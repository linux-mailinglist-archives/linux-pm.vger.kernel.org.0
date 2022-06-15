Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D9D54C999
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 15:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348894AbiFONQP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jun 2022 09:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349298AbiFONQK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 09:16:10 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D7B2A97D;
        Wed, 15 Jun 2022 06:16:07 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id z11so8719731ilq.6;
        Wed, 15 Jun 2022 06:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=zvLI0BlmqNbISbXhThShkWXXEhNvQvDes/xEcvuVD+s=;
        b=JLg11JyEn7BHbZA7oRtVt6E6aZ0TOTVq77P1W3Mffnpdi1B0gZMVmIpFbK+agGuFqV
         aIkVB3AyFoXl6XwmqvzYmV4z5L+bIngbhflKI1fiGPS3AwJxQy3XYz01XDsZuQAjkIfB
         Bh4h0An41dlpB0AqvLinyk7yY2c7828ywzZr/2QlOE3Jt8h4sn6SqZYmFkdG7U1wy7oE
         Jf6ffUL6vmfQvr7i0hco0PkTADByH16V3cT8iLj3nmsxLQQeNqMz5YIPZoVEqNMPlaNp
         rAYYX3m3I3NwSlIgOigJqxQxbXQxXquzY13Nk8zdS2LyerfHD41IWYmex/Plb+5nCgqu
         nLWQ==
X-Gm-Message-State: AJIora+8QW4eHCHR1fgUmNCZUneOQZHx91Uyou62eyZDAhBesEbrhTPQ
        cVBL9lbnGICDn0rUGGnUTg==
X-Google-Smtp-Source: AGRyM1vlw8kiV5ITb9w8FLndwz/Q07d6wIyZQeUvhjl1bM49oCMY4Qo39rEhpsgn1K+F5SUXB9WI0Q==
X-Received: by 2002:a05:6e02:2161:b0:2d3:d5e4:1574 with SMTP id s1-20020a056e02216100b002d3d5e41574mr5907967ilv.1.1655298966098;
        Wed, 15 Jun 2022 06:16:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id r13-20020a6b2b0d000000b00669bcd058dcsm6843061ior.36.2022.06.15.06.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 06:16:05 -0700 (PDT)
Received: (nullmailer pid 662454 invoked by uid 1000);
        Wed, 15 Jun 2022 13:16:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220615094804.388280-4-francesco.dolcini@toradex.com>
References: <20220615094804.388280-1-francesco.dolcini@toradex.com> <20220615094804.388280-4-francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 3/9] dt-bindings: thermal: imx: Add trips point
Date:   Wed, 15 Jun 2022 07:16:02 -0600
Message-Id: <1655298962.409974.662453.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jun 2022 11:47:58 +0200, Francesco Dolcini wrote:
> Add trips point to i.MX Thermal bindings for each temperature grade
> (automotive, commercial, extended-commercial and industrial) to enable
> specifying a different trip point than the hard-coded value.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../bindings/thermal/imx-thermal.yaml         | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


temperature-sensor: compatible:0: 'fsl,imx6sll-tempmon' is not one of ['fsl,imx6q-tempmon', 'fsl,imx6sx-tempmon', 'fsl,imx7d-tempmon']
	arch/arm/boot/dts/imx6sll-evk.dtb
	arch/arm/boot/dts/imx6sll-kobo-clarahd.dtb
	arch/arm/boot/dts/imx6sll-kobo-librah2o.dtb

temperature-sensor: compatible: ['fsl,imx6sll-tempmon', 'fsl,imx6sx-tempmon'] is too long
	arch/arm/boot/dts/imx6sll-evk.dtb
	arch/arm/boot/dts/imx6sll-kobo-clarahd.dtb
	arch/arm/boot/dts/imx6sll-kobo-librah2o.dtb

tempmon: compatible:0: 'fsl,imx6ul-tempmon' is not one of ['fsl,imx6q-tempmon', 'fsl,imx6sx-tempmon', 'fsl,imx7d-tempmon']
	arch/arm/boot/dts/imx6ul-14x14-evk.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dtb
	arch/arm/boot/dts/imx6ul-geam.dtb
	arch/arm/boot/dts/imx6ul-isiot-emmc.dtb
	arch/arm/boot/dts/imx6ul-isiot-nand.dtb
	arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dtb
	arch/arm/boot/dts/imx6ul-kontron-n6310-s.dtb
	arch/arm/boot/dts/imx6ull-14x14-evk.dtb
	arch/arm/boot/dts/imx6ull-colibri-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dtb
	arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dtb
	arch/arm/boot/dts/imx6ul-liteboard.dtb
	arch/arm/boot/dts/imx6ull-jozacp.dtb
	arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dtb
	arch/arm/boot/dts/imx6ull-opos6uldev.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb
	arch/arm/boot/dts/imx6ull-phytec-tauri-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-tauri-nand.dtb
	arch/arm/boot/dts/imx6ull-tqma6ull2l-mba6ulx.dtb
	arch/arm/boot/dts/imx6ull-tqma6ull2-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-opos6uldev.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ul-pico-dwarf.dtb
	arch/arm/boot/dts/imx6ul-pico-hobbit.dtb
	arch/arm/boot/dts/imx6ul-pico-pi.dtb
	arch/arm/boot/dts/imx6ul-prti6g.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul1-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul2l-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul2-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0010.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0011.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dtb
	arch/arm/boot/dts/imx6ulz-14x14-evk.dtb
	arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dtb

tempmon: compatible: ['fsl,imx6sx-tempmon', 'fsl,imx6q-tempmon'] is too long
	arch/arm/boot/dts/imx6sx-nitrogen6sx.dtb
	arch/arm/boot/dts/imx6sx-sabreauto.dtb
	arch/arm/boot/dts/imx6sx-sdb.dtb
	arch/arm/boot/dts/imx6sx-sdb-mqs.dtb
	arch/arm/boot/dts/imx6sx-sdb-reva.dtb
	arch/arm/boot/dts/imx6sx-sdb-sai.dtb
	arch/arm/boot/dts/imx6sx-softing-vining-2000.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-basic.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-extended.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-full.dtb

tempmon: compatible: ['fsl,imx6ul-tempmon', 'fsl,imx6sx-tempmon'] is too long
	arch/arm/boot/dts/imx6ul-14x14-evk.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dtb
	arch/arm/boot/dts/imx6ul-geam.dtb
	arch/arm/boot/dts/imx6ul-isiot-emmc.dtb
	arch/arm/boot/dts/imx6ul-isiot-nand.dtb
	arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dtb
	arch/arm/boot/dts/imx6ul-kontron-n6310-s.dtb
	arch/arm/boot/dts/imx6ull-14x14-evk.dtb
	arch/arm/boot/dts/imx6ull-colibri-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dtb
	arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dtb
	arch/arm/boot/dts/imx6ul-liteboard.dtb
	arch/arm/boot/dts/imx6ull-jozacp.dtb
	arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dtb
	arch/arm/boot/dts/imx6ull-opos6uldev.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb
	arch/arm/boot/dts/imx6ull-phytec-tauri-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-tauri-nand.dtb
	arch/arm/boot/dts/imx6ull-tqma6ull2l-mba6ulx.dtb
	arch/arm/boot/dts/imx6ull-tqma6ull2-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-opos6uldev.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ul-pico-dwarf.dtb
	arch/arm/boot/dts/imx6ul-pico-hobbit.dtb
	arch/arm/boot/dts/imx6ul-pico-pi.dtb
	arch/arm/boot/dts/imx6ul-prti6g.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul1-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul2l-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul2-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0010.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0011.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dtb
	arch/arm/boot/dts/imx6ulz-14x14-evk.dtb
	arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dtb

tempmon: '#thermal-sensor-cells' does not match any of the regexes: '^(automotive|commercial|extended-commercial|industrial)-thermal$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/imx6dl-alti6p.dtb
	arch/arm/boot/dts/imx6dl-apf6dev.dtb
	arch/arm/boot/dts/imx6dl-aristainetos2_4.dtb
	arch/arm/boot/dts/imx6dl-aristainetos2_7.dtb
	arch/arm/boot/dts/imx6dl-aristainetos_4.dtb
	arch/arm/boot/dts/imx6dl-aristainetos_7.dtb
	arch/arm/boot/dts/imx6dl-b105pv2.dtb
	arch/arm/boot/dts/imx6dl-b105v2.dtb
	arch/arm/boot/dts/imx6dl-b125pv2.dtb
	arch/arm/boot/dts/imx6dl-b125v2.dtb
	arch/arm/boot/dts/imx6dl-b155v2.dtb
	arch/arm/boot/dts/imx6dl-colibri-aster.dtb
	arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6dl-colibri-iris.dtb
	arch/arm/boot/dts/imx6dl-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx6dl-cubox-i.dtb
	arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dtb
	arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dtb
	arch/arm/boot/dts/imx6dl-dhcom-picoitx.dtb
	arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dtb
	arch/arm/boot/dts/imx6dl-emcon-avari.dtb
	arch/arm/boot/dts/imx6dl-gw51xx.dtb
	arch/arm/boot/dts/imx6dl-gw52xx.dtb
	arch/arm/boot/dts/imx6dl-gw53xx.dtb
	arch/arm/boot/dts/imx6dl-gw54xx.dtb
	arch/arm/boot/dts/imx6dl-gw551x.dtb
	arch/arm/boot/dts/imx6dl-gw552x.dtb
	arch/arm/boot/dts/imx6dl-gw553x.dtb
	arch/arm/boot/dts/imx6dl-gw560x.dtb
	arch/arm/boot/dts/imx6dl-gw5903.dtb
	arch/arm/boot/dts/imx6dl-gw5904.dtb
	arch/arm/boot/dts/imx6dl-gw5907.dtb
	arch/arm/boot/dts/imx6dl-gw5910.dtb
	arch/arm/boot/dts/imx6dl-gw5912.dtb
	arch/arm/boot/dts/imx6dl-gw5913.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard.dtb
	arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dtb
	arch/arm/boot/dts/imx6dl-icore.dtb
	arch/arm/boot/dts/imx6dl-icore-mipi.dtb
	arch/arm/boot/dts/imx6dl-icore-rqs.dtb
	arch/arm/boot/dts/imx6dl-lanmcu.dtb
	arch/arm/boot/dts/imx6dl-mamoj.dtb
	arch/arm/boot/dts/imx6dl-mba6a.dtb
	arch/arm/boot/dts/imx6dl-mba6b.dtb
	arch/arm/boot/dts/imx6dl-nit6xlite.dtb
	arch/arm/boot/dts/imx6dl-nitrogen6x.dtb
	arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6dl-phytec-pbab01.dtb
	arch/arm/boot/dts/imx6dl-pico-dwarf.dtb
	arch/arm/boot/dts/imx6dl-pico-hobbit.dtb
	arch/arm/boot/dts/imx6dl-pico-nymph.dtb
	arch/arm/boot/dts/imx6dl-pico-pi.dtb
	arch/arm/boot/dts/imx6dl-plybas.dtb
	arch/arm/boot/dts/imx6dl-plym2m.dtb
	arch/arm/boot/dts/imx6dl-prtmvt.dtb
	arch/arm/boot/dts/imx6dl-prtrvt.dtb
	arch/arm/boot/dts/imx6dl-prtvt7.dtb
	arch/arm/boot/dts/imx6dl-rex-basic.dtb
	arch/arm/boot/dts/imx6dl-riotboard.dtb
	arch/arm/boot/dts/imx6dl-sabreauto.dtb
	arch/arm/boot/dts/imx6dl-sabrelite.dtb
	arch/arm/boot/dts/imx6dl-sabresd.dtb
	arch/arm/boot/dts/imx6dl-savageboard.dtb
	arch/arm/boot/dts/imx6dl-skov-revc-lt2.dtb
	arch/arm/boot/dts/imx6dl-skov-revc-lt6.dtb
	arch/arm/boot/dts/imx6dl-solidsense.dtb
	arch/arm/boot/dts/imx6dl-ts4900.dtb
	arch/arm/boot/dts/imx6dl-ts7970.dtb
	arch/arm/boot/dts/imx6dl-tx6dl-comtft.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8034.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8035.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-801x.dtb
	arch/arm/boot/dts/imx6dl-tx6u-8033.dtb
	arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-811x.dtb
	arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dtb
	arch/arm/boot/dts/imx6dl-udoo.dtb
	arch/arm/boot/dts/imx6dl-victgo.dtb
	arch/arm/boot/dts/imx6dl-vicut1.dtb
	arch/arm/boot/dts/imx6dl-wandboard.dtb
	arch/arm/boot/dts/imx6dl-wandboard-revb1.dtb
	arch/arm/boot/dts/imx6dl-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6dl-yapp4-draco.dtb
	arch/arm/boot/dts/imx6dl-yapp4-hydra.dtb
	arch/arm/boot/dts/imx6dl-yapp4-orion.dtb
	arch/arm/boot/dts/imx6dl-yapp4-ursa.dtb
	arch/arm/boot/dts/imx6q-apalis-eval.dtb
	arch/arm/boot/dts/imx6q-apalis-ixora.dtb
	arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dtb
	arch/arm/boot/dts/imx6q-apf6dev.dtb
	arch/arm/boot/dts/imx6q-arm2.dtb
	arch/arm/boot/dts/imx6q-b450v3.dtb
	arch/arm/boot/dts/imx6q-b650v3.dtb
	arch/arm/boot/dts/imx6q-b850v3.dtb
	arch/arm/boot/dts/imx6q-bosch-acc.dtb
	arch/arm/boot/dts/imx6q-cm-fx6.dtb
	arch/arm/boot/dts/imx6q-cubox-i.dtb
	arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6q-cubox-i-som-v15.dtb
	arch/arm/boot/dts/imx6q-dfi-fs700-m60.dtb
	arch/arm/boot/dts/imx6q-dhcom-pdk2.dtb
	arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dtb
	arch/arm/boot/dts/imx6q-dmo-edmqmx6.dtb
	arch/arm/boot/dts/imx6q-dms-ba16.dtb
	arch/arm/boot/dts/imx6q-ds.dtb
	arch/arm/boot/dts/imx6q-emcon-avari.dtb
	arch/arm/boot/dts/imx6q-evi.dtb
	arch/arm/boot/dts/imx6q-gk802.dtb
	arch/arm/boot/dts/imx6q-gw51xx.dtb
	arch/arm/boot/dts/imx6q-gw52xx.dtb
	arch/arm/boot/dts/imx6q-gw53xx.dtb
	arch/arm/boot/dts/imx6q-gw5400-a.dtb
	arch/arm/boot/dts/imx6q-gw54xx.dtb
	arch/arm/boot/dts/imx6q-gw551x.dtb
	arch/arm/boot/dts/imx6q-gw552x.dtb
	arch/arm/boot/dts/imx6q-gw553x.dtb
	arch/arm/boot/dts/imx6q-gw560x.dtb
	arch/arm/boot/dts/imx6q-gw5903.dtb
	arch/arm/boot/dts/imx6q-gw5904.dtb
	arch/arm/boot/dts/imx6q-gw5907.dtb
	arch/arm/boot/dts/imx6q-gw5910.dtb
	arch/arm/boot/dts/imx6q-gw5912.dtb
	arch/arm/boot/dts/imx6q-gw5913.dtb
	arch/arm/boot/dts/imx6q-h100.dtb
	arch/arm/boot/dts/imx6q-hummingboard2.dtb
	arch/arm/boot/dts/imx6q-hummingboard2-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dtb
	arch/arm/boot/dts/imx6q-hummingboard.dtb
	arch/arm/boot/dts/imx6q-hummingboard-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6q-hummingboard-som-v15.dtb
	arch/arm/boot/dts/imx6q-icore.dtb
	arch/arm/boot/dts/imx6q-icore-mipi.dtb
	arch/arm/boot/dts/imx6q-icore-ofcap10.dtb
	arch/arm/boot/dts/imx6q-icore-ofcap12.dtb
	arch/arm/boot/dts/imx6q-icore-rqs.dtb
	arch/arm/boot/dts/imx6q-kp-tpc.dtb
	arch/arm/boot/dts/imx6q-logicpd.dtb
	arch/arm/boot/dts/imx6q-marsboard.dtb
	arch/arm/boot/dts/imx6q-mba6a.dtb
	arch/arm/boot/dts/imx6q-mba6b.dtb
	arch/arm/boot/dts/imx6q-mccmon6.dtb
	arch/arm/boot/dts/imx6q-nitrogen6_max.dtb
	arch/arm/boot/dts/imx6q-nitrogen6_som2.dtb
	arch/arm/boot/dts/imx6q-nitrogen6x.dtb
	arch/arm/boot/dts/imx6q-novena.dtb
	arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dtb
	arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6q-phytec-pbab01.dtb
	arch/arm/boot/dts/imx6q-pico-dwarf.dtb
	arch/arm/boot/dts/imx6q-pico-hobbit.dtb
	arch/arm/boot/dts/imx6q-pico-nymph.dtb
	arch/arm/boot/dts/imx6q-pico-pi.dtb
	arch/arm/boot/dts/imx6q-pistachio.dtb
	arch/arm/boot/dts/imx6qp-mba6b.dtb
	arch/arm/boot/dts/imx6qp-nitrogen6_max.dtb
	arch/arm/boot/dts/imx6qp-nitrogen6_som2.dtb
	arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6qp-prtwd3.dtb
	arch/arm/boot/dts/imx6q-prti6q.dtb
	arch/arm/boot/dts/imx6q-prtwd2.dtb
	arch/arm/boot/dts/imx6qp-sabreauto.dtb
	arch/arm/boot/dts/imx6qp-sabresd.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8037.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8137.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dtb
	arch/arm/boot/dts/imx6qp-vicutp.dtb
	arch/arm/boot/dts/imx6qp-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dtb
	arch/arm/boot/dts/imx6qp-zii-rdu2.dtb
	arch/arm/boot/dts/imx6q-rex-pro.dtb
	arch/arm/boot/dts/imx6q-sabreauto.dtb
	arch/arm/boot/dts/imx6q-sabrelite.dtb
	arch/arm/boot/dts/imx6q-sabresd.dtb
	arch/arm/boot/dts/imx6q-savageboard.dtb
	arch/arm/boot/dts/imx6q-sbc6x.dtb
	arch/arm/boot/dts/imx6q-skov-revc-lt2.dtb
	arch/arm/boot/dts/imx6q-skov-revc-lt6.dtb
	arch/arm/boot/dts/imx6q-skov-reve-mi1010ait-1cp1.dtb
	arch/arm/boot/dts/imx6q-solidsense.dtb
	arch/arm/boot/dts/imx6q-tbs2910.dtb
	arch/arm/boot/dts/imx6q-ts4900.dtb
	arch/arm/boot/dts/imx6q-ts7970.dtb
	arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dtb
	arch/arm/boot/dts/imx6q-tx6q-1010.dtb
	arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dtb
	arch/arm/boot/dts/imx6q-tx6q-1020.dtb
	arch/arm/boot/dts/imx6q-tx6q-1036.dtb
	arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dtb
	arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dtb
	arch/arm/boot/dts/imx6q-tx6q-1110.dtb
	arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dtb
	arch/arm/boot/dts/imx6q-udoo.dtb
	arch/arm/boot/dts/imx6q-utilite-pro.dtb
	arch/arm/boot/dts/imx6q-var-dt6customboard.dtb
	arch/arm/boot/dts/imx6q-vicut1.dtb
	arch/arm/boot/dts/imx6q-wandboard.dtb
	arch/arm/boot/dts/imx6q-wandboard-revb1.dtb
	arch/arm/boot/dts/imx6q-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6q-yapp4-crux.dtb
	arch/arm/boot/dts/imx6q-zii-rdu2.dtb
	arch/arm/boot/dts/imx6s-dhcom-drc02.dtb

