Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2FF598ADF
	for <lists+linux-pm@lfdr.de>; Thu, 18 Aug 2022 20:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiHRSJK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Aug 2022 14:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbiHRSJI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Aug 2022 14:09:08 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CC81A382
        for <linux-pm@vger.kernel.org>; Thu, 18 Aug 2022 11:09:06 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3246910dac3so62203587b3.12
        for <linux-pm@vger.kernel.org>; Thu, 18 Aug 2022 11:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BQzknscGoJmCJVbW5eLwhZSTVcBlC0xIVj31IEsmJv4=;
        b=WcFBaULAIRzpgXX9qo+Ak581nKtftWGZ49W6MuDAEzhOUN9DMZJqCiLoOkI2kzKXnz
         lItJ3pQ5pZ79kliGoJLIQsqbxjrygRP9UfhcGz3jQG9Crf8rXVJpDe24tobhBefR0JP/
         Sd/yVRzy382eALhko+nxyaHcFFBLv98HHcNUdFNKSs+QEYlpmD1JIoRBuG6rBhimy6B2
         wBgy5bFrRz1OxXfCEqtjtNc4Wx+HLHMct6GlM5cxnbNN9U2sccLU834ApYULcuxtZJuD
         J/vw/p64E/5iYKiobK52wRRkOqEKsOVm5lm9khtgxKuEhvGUTjBppeICAT9aHyxoU9SU
         5X0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BQzknscGoJmCJVbW5eLwhZSTVcBlC0xIVj31IEsmJv4=;
        b=rigrw3C2aKOzybrJSL8HYnxPBvsloeSOxTFMlYw0FO64fP0AmtkRpzDyUHY8L5hxjH
         q4XmfcMnf0Vohz/eCBuNZfy/TU8hntEcEpo71ypE21vUJMvO9O9LlCnE9xZmqdTTxs+k
         tO8CQrqjNZXkiqcSDHMBDWAFe6/nSapCKfBM6DzsJ7KPFcVj6NvH8R+eZn5U70m+ds8y
         XC/+spsoSg28q6OltydfF1Y3qygNRELUo5n7jFtirQrHe7GOlBGzM3PUugJ9OplHshzO
         q+lGTUOlXhxVRMxTCRjktl5fNOM/3IRwT4N59bkyVQdi9dRVoFUcUPID5jzzsOkvxvX8
         iDZw==
X-Gm-Message-State: ACgBeo2kRKpgEg2L++SgoXJ4ePZ22sihCgy1ylvkzbxt4x5C4Vci3As+
        0/eMqoESPy9/LhyHqNKB5NGNVzdVJjuppXSEJObETk434GY6Fg==
X-Google-Smtp-Source: AA6agR74zQLuaUWhDf7z1LiK/foixV2Bcs8+zpwAuNR7AGqh0/HcLpsvnbWzMYU2SOdV7HfOEQNEAwnod6ilKwThtvg=
X-Received: by 2002:a05:6902:2cb:b0:684:aebe:49ab with SMTP id
 w11-20020a05690202cb00b00684aebe49abmr4039537ybh.242.1660846145984; Thu, 18
 Aug 2022 11:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR04MB941735271F45C716342D0410886B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <DU0PR04MB9417E391B514287D040E0EC7886B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417E391B514287D040E0EC7886B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 18 Aug 2022 11:08:29 -0700
Message-ID: <CAGETcx8xXM18Se-ykf7=fFJ_4bvSgQm8LG6Bq=3wd0skSR46EA@mail.gmail.com>
Subject: Re: Regression: PM: domains: Delete usage of driver_deferred_probe_check_state
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>, Bough Chen <haibo.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 15, 2022 at 11:43 PM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Regression: PM: domains: Delete usage of
> > driver_deferred_probe_check_state
>
> Just see your patchset :)
> https://lore.kernel.org/all/20220727185012.3255200-1-saravanak@google.com/
>
> Thanks,
> Peng.
> >
> > Hi Saravana,
> >
> > The following two patches breaks NXP i.MX8ULP, but I think it may break
> > others use SCMI.
> >
> > commit 5a46079a96451cfb15e4f5f01f73f7ba24ef851a
> > Author: Saravana Kannan <mailto:saravanak@google.com>
> > Date:   Wed Jun 1 00:06:57 2022 -0700
> >
> >     PM: domains: Delete usage of driver_deferred_probe_check_state()
> >
> >     Now that fw_devlink=on by default and fw_devlink supports
> >     "power-domains" property, the execution will never get to the point
> >     where driver_deferred_probe_check_state() is called before the supplier
> >     has probed successfully or before deferred probe timeout has expired.
> >
> >     So, delete the call and replace it with -ENODEV.
> >
> >     Tested-by: Geert Uytterhoeven <mailto:geert+renesas@glider.be>
> >     Reviewed-by: Ulf Hansson <mailto:ulf.hansson@linaro.org>
> >     Signed-off-by: Saravana Kannan <mailto:saravanak@google.com>
> >     Link: https://lore.kernel.org/r/20220601070707.3946847-2-
> > saravanak@google.com
> >     Signed-off-by: Greg Kroah-Hartman <mailto:gregkh@linuxfoundation.org>
> >
> > commit 9cbffc7a59561be950ecc675d19a3d2b45202b2b
> > Author: Saravana Kannan <mailto:saravanak@google.com>
> > Date:   Wed Jun 1 00:07:05 2022 -0700
> >
> >     driver core: Delete driver_deferred_probe_check_state()
> >
> >     The function is no longer used. So delete it.
> >
> >     Tested-by: Geert Uytterhoeven <mailto:geert+renesas@glider.be>
> >     Signed-off-by: Saravana Kannan <mailto:saravanak@google.com>
> >     Link: https://lore.kernel.org/r/20220601070707.3946847-10-
> > saravanak@google.com
> >     Signed-off-by: Greg Kroah-Hartman <mailto:gregkh@linuxfoundation.org>
> >
> > The i.MX8ULP mmc device node use
> > "power-domains = <&scmi_devpd IMX8ULP_PD_USDHC0>;"
> >
> > The scmi firmware node as below:
> >         firmware {
> >                 scmi {
> >                         compatible = "arm,scmi-smc";
> >                         arm,smc-id = <0xc20000fe>;
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> >                         shmem = <&scmi_buf>;
> >
> >                         scmi_devpd: protocol@11 {
> >                                 reg = <0x11>;
> >                                 #power-domain-cells = <1>;
> >                         };
> >
> >                         scmi_sensor: protocol@15 {
> >                                 reg = <0x15>;
> >                                 #thermal-sensor-cells = <1>;
> >                         };
> >                 };
> >         };
> >
> > When sdhc driver probe, the scmi power domain provider has not been
> > registered. So __genpd_dev_pm_attach directly return -ENODEV.
> >
> > device_links_check_suppliers should already check suppliers, but scmi
> > protocol device not have compatible, so of_link_to_phandle
> >       |-> of_get_compat_node
> > use the parent node of scmi protocol as supplier if I understand correct.
> >
> > I am not sure whether we need to revert the above two patches, or do you
> > have other suggestions?

Hi Peng,

Thanks for the report. If you try this series with the following diff,
I expect it to fix the issue for you. Can you please test it out and
let me know? The v1 of the series removes the dependency on
"compatible" strings. The first diff below is something I'm going to
roll into v2 of the series and the 2nd diff below is fixing up the
scmi bus to set the fwnode for devices it creates.

Thanks,
Saravana

https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2f012e826986..866755d8ad95 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2068,7 +2068,11 @@ static int fw_devlink_create_devlink(struct device *con,
                device_links_write_unlock();
        }

-       sup_dev = get_dev_from_fwnode(sup_handle);
+       if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
+               sup_dev = fwnode_get_next_parent_dev(sup_handle);
+       else
+               sup_dev = get_dev_from_fwnode(sup_handle);
+
        if (sup_dev) {
                /*
                 * If it's one of those drivers that don't actually bind to


diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index d4e23101448a..0802bdd0ebfc 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -192,6 +192,7 @@ scmi_device_create(struct device_node *np, struct
device *parent, int protocol,
        scmi_dev->protocol_id = protocol;
        scmi_dev->dev.parent = parent;
        scmi_dev->dev.of_node = np;
+       scmi_dev->dev.fwnode= of_fwnode_handle(np);
        scmi_dev->dev.bus = &scmi_bus_type;
        scmi_dev->dev.release = scmi_device_release;
        dev_set_name(&scmi_dev->dev, "scmi_dev.%d", id);
