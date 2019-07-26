Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C35A77402
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2019 00:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfGZW1F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 18:27:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36254 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbfGZW1E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 18:27:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so44717795wme.1;
        Fri, 26 Jul 2019 15:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pLIvL1ELNjaZefRkSo34EEeqZ5ctkKw3Nhc4gJBc33s=;
        b=ePOopMHVtBJWVbqlKtDxoGAEJq2W+MrKFCPb2aExEk+4Js7x0XFa33YynjU0aYy+Zd
         cy8SOMYIf8ILafKjZKdQNPmN5l+a6/AtmSX16476xaqtwIhafaF+Tkr3Hhy8mEupfqD1
         l1Fxv4/EWdfc3Znt515XrTWt1Gpj/K2hQoYPL5Cr9SGL6Y1I8TqxbhGeL1OoCedTXnsz
         WDJ33syVp6qDMLPxtq5zlNFdpUAgGk8NfG0/NIPKuHicwUUS0OIkT0oli/9bAznmh+rR
         IPghhpH766v1ZEoaeXrdL+5+dmvIE7ZsoovhwgJdcWh2/YKaxv8k+WD3GA7eCwtwaCLI
         a9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLIvL1ELNjaZefRkSo34EEeqZ5ctkKw3Nhc4gJBc33s=;
        b=bO22VTu4vtev8BcMp6FGcxh3SQKf2HTS2EtEc+bue1CQod3DiJrMBUXtvGuaOZDxkE
         FJYI4mrpmFS0KBSGQa/E56xs2l8i0LRDmz9GT8vqvfKjL02UahMDahHGMx4f3vAmOfeT
         V8I7SDakzRf14PWdd+chgnLZJ2JKgQcW8C3WLb8/FH70hdQT2U1Yu9/t8UmPoZg+vO8E
         PxQr6+7kIP9RNb0ELCPpeDci+9xyr7ptq7D9YZsRzype4Gt6yIwkuzFO9ia8j+Wug4Cj
         X2JFUxFo1vrO/Evp3Lsm3JmP1aACjTLDdJpCKhNaw7Onlf20O2E2kBuCifYIT6tyvi4s
         4qCA==
X-Gm-Message-State: APjAAAX76wy+lEoicfZTNLjCuMA4dUfT1LHq6T5qyZGeQ+TSihw17BSw
        2ZMS23+Uy9NajE6F/PeLNZ9OC+LXSxHm8nxxcBs=
X-Google-Smtp-Source: APXvYqxg4Ing4cAKxRNOyIS5IE4D6JXVjbgrCbkFHO/3jK45VR23Z9xnWOALa5i4VOTyOCbFR45W/I9i3pdpSHZMPSA=
X-Received: by 2002:a1c:96c7:: with SMTP id y190mr80069646wmd.87.1564180022241;
 Fri, 26 Jul 2019 15:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190705045612.27665-1-Anson.Huang@nxp.com> <20190705045612.27665-5-Anson.Huang@nxp.com>
In-Reply-To: <20190705045612.27665-5-Anson.Huang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Sat, 27 Jul 2019 01:26:50 +0300
Message-ID: <CAEnQRZAZNMBx3ApVmRP8hYPw0XY_QgR-saE6WLcT8oZmHPCxSA@mail.gmail.com>
Subject: Re: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TMU_ROOT
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Carlo Caione <ccaione@baylibre.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-pm@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk@vger.kernel.org, dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

latest linux-next hangs at boot.

commit fde50b96be821ac9673a7e00847cc4605bd88f34 (HEAD -> master, tag:
next-20190726, origin/master, origin/HEAD)
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Fri Jul 26 15:18:02 2019 +1000

    Add linux-next specific files for 20190726

    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>


I know this is crazy but reverting commit:

commit 431bdd1df48ee2896ea9980d9153e3aeaf0c81ef (refs/bisect/bad)
Author: Anson Huang <Anson.Huang@nxp.com>
Date:   Fri Jul 5 12:56:11 2019 +0800

    clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TMU_ROOT

    IMX8MQ_CLK_TMU_ROOT is ONLY used for thermal module, the driver
    should manage this clock, so no need to have CLK_IS_CRITICAL flag
    set.



makes the boot work again.

Any idea?

On Fri, Jul 5, 2019 at 8:07 AM <Anson.Huang@nxp.com> wrote:
>
> From: Anson Huang <Anson.Huang@nxp.com>
>
> IMX8MQ_CLK_TMU_ROOT is ONLY used for thermal module, the driver
> should manage this clock, so no need to have CLK_IS_CRITICAL flag
> set.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index d407a07..91de69a 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -539,7 +539,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
>         clks[IMX8MQ_CLK_DISP_AXI_ROOT]  = imx_clk_gate2_shared2("disp_axi_root_clk", "disp_axi", base + 0x45d0, 0, &share_count_dcss);
>         clks[IMX8MQ_CLK_DISP_APB_ROOT]  = imx_clk_gate2_shared2("disp_apb_root_clk", "disp_apb", base + 0x45d0, 0, &share_count_dcss);
>         clks[IMX8MQ_CLK_DISP_RTRM_ROOT] = imx_clk_gate2_shared2("disp_rtrm_root_clk", "disp_rtrm", base + 0x45d0, 0, &share_count_dcss);
> -       clks[IMX8MQ_CLK_TMU_ROOT] = imx_clk_gate4_flags("tmu_root_clk", "ipg_root", base + 0x4620, 0, CLK_IS_CRITICAL);
> +       clks[IMX8MQ_CLK_TMU_ROOT] = imx_clk_gate4("tmu_root_clk", "ipg_root", base + 0x4620, 0);
>         clks[IMX8MQ_CLK_VPU_DEC_ROOT] = imx_clk_gate2_flags("vpu_dec_root_clk", "vpu_bus", base + 0x4630, 0, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
>         clks[IMX8MQ_CLK_CSI1_ROOT] = imx_clk_gate4("csi1_root_clk", "csi1_core", base + 0x4650, 0);
>         clks[IMX8MQ_CLK_CSI2_ROOT] = imx_clk_gate4("csi2_root_clk", "csi2_core", base + 0x4660, 0);
> --
> 2.7.4
>
