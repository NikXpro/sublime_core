import React, { useState } from "react";
import { useNuiEvent } from "../../hooks/useNuiEvent";
import { useDisclosure } from "@mantine/hooks";
import { createStyles } from "@mantine/core";
import type { ModalProps } from "../../typings";
import { useConfig } from "../../providers/ConfigProvider";

import { OpenModalConfirm, OpenModalCustom } from "./modals";

//import { fetchNui } from "../../utils/fetchNui";

const ModalWrapper: React.FC = () => {
    const { config } = useConfig();
    const useStyles = createStyles((theme) => ({...config.modalsStyles}));
    const { classes } = useStyles();
    const [data, setData] = useState<ModalProps>({type: ""});
    const [opened, { close, open }] = useDisclosure(false);

    useNuiEvent("sl:modal:opened", (data) => {
        if (data.type === "confirm" && !data.description && !data.title && !data.subtitle) return;
        console.log("ModalWrapper: ", data);
        setData(data);
        open();
    });

    return (
        <>
            {opened && (
                data.type === "confirm" ? 
                    <OpenModalConfirm title={data.title} subtitle={data.subtitle} description={data.description} handleClose={close} />
                : data.type === "custom" ?
                    <OpenModalCustom title={data.title} options={data.options} handleClose={close} />
                : null
            )}
        </>
    );
}
/*


            */

export default ModalWrapper;