Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF18A1B5DFA
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 16:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgDWOh7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 10:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726363AbgDWOh7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2020 10:37:59 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EAAC08E934
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2020 07:37:59 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id v192so1548027vkd.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2020 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ug3KiCtaYc2Wm8ungvIjXJGgMkxsZrDe9mGUGvcX/Bo=;
        b=zWPu+z3h95PnKcJptjma7DrUfqzD6ETQeNhRoBAIDiGfv6tyoZVVI5fLdYPE24Bg9W
         iXquNUsFq/pKpxjBjLor4OZRCT6EwKAMSeYSePz7lJOnV9IyAhl6gx7uK3arMMbKkr+P
         VFN3NH3Ee4vJPGPmYyJKj4L5utnLkGqkc2dV33JyM7cnY+rSjvD3/RQh8CuVcM9ce17Y
         1B6ZVHSbtKvUDSADHKXLWBSWkYduBUMI4s+fayyoETdw60pDj7xlgn4kAL5qLw474YwA
         q8LQurPtvHiUV5XqCOVIIwaSmj0subdwxJ+8agVAHS+SmcfevzNMJmNm3D/M9h3jcPp7
         I6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ug3KiCtaYc2Wm8ungvIjXJGgMkxsZrDe9mGUGvcX/Bo=;
        b=iQJJ03wIhBG9+gTM4Gnj9Uk1NBbsb8dptu2OmgTPJBn1WOsmLvDm42tJ9+QM4m2cyM
         bJtOdhsccfwxzKTDUfTQfF+H1YE+6pzH1gTRz7w46yQM5kPr2p1Rnk7lDj3BZKR7kZMj
         Ft/usg+a0wuK8zSKmNUVK9jQApfbw2G0zZPSIXZLs0v0mE5h4YQluhYauKH4HiT7qKA0
         3SJlSj/kDhILd2UacMZuonTNzv3miIgdSag5r7HGfWi3CKtPsmeodZrBa1ugEVd9PXPF
         mJjuHrlm0qUhv39KVx1shPk0A31ci6/BOwik1pwBUf54gCVUVig6OE2GnRSby24lqhHB
         u+Eg==
X-Gm-Message-State: AGi0Pubsc3FwrpXI5Xn0unYsB5lCDnLoplC9k/qPJHEyByq3NUmieeVk
        vSD25xYKfPXtXgOqzEr06Ge6LGqeolDCj7v/ixxocg==
X-Google-Smtp-Source: APiQypJ7U6znxJCGvIjdiEDJKmyx8voqZXUHTKPQxiRWpWkQibyxKowhF3MORyevpBPSV+VXgHmkCg5/K3uHw44EK24=
X-Received: by 2002:a1f:ce86:: with SMTP id e128mr3761286vkg.86.1587652678214;
 Thu, 23 Apr 2020 07:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <1587650406-20050-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1587650406-20050-1-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 23 Apr 2020 20:07:35 +0530
Message-ID: <CAHLCerP3jGUZC+i2i6CEYhOtBjLYKAPe7M0bKUs1b5oQEsdfEg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: firmware: imx: Move system control into
 dt-binding headfile
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux@rempel-privat.de, Peng Fan <peng.fan@nxp.com>,
        LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 23, 2020 at 7:38 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> i.MX8 SoCs DTS file needs system control macro definitions, so move them
> into dt-binding headfile.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Why am I seeing multiple versions of the same series?

You need to squash this series so that the swapping of the header file
happens in a single patch otherwise compilation will break with only
patch 1 applied.

> ---
>  include/dt-bindings/firmware/imx/rsrc.h | 84 +++++++++++++++++++++++++++++++++
>  include/linux/firmware/imx/sci.h        |  1 -
>  include/linux/firmware/imx/types.h      | 65 -------------------------
>  3 files changed, 84 insertions(+), 66 deletions(-)
>  delete mode 100644 include/linux/firmware/imx/types.h
>
> diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
> index 4e61f64..51906b9 100644
> --- a/include/dt-bindings/firmware/imx/rsrc.h
> +++ b/include/dt-bindings/firmware/imx/rsrc.h
> @@ -547,4 +547,88 @@
>  #define IMX_SC_R_ATTESTATION           545
>  #define IMX_SC_R_LAST                  546
>
> +/*
> + * Defines for SC PM CLK
> + */
> +#define IMX_SC_PM_CLK_SLV_BUS          0       /* Slave bus clock */
> +#define IMX_SC_PM_CLK_MST_BUS          1       /* Master bus clock */
> +#define IMX_SC_PM_CLK_PER              2       /* Peripheral clock */
> +#define IMX_SC_PM_CLK_PHY              3       /* Phy clock */
> +#define IMX_SC_PM_CLK_MISC             4       /* Misc clock */
> +#define IMX_SC_PM_CLK_MISC0            0       /* Misc 0 clock */
> +#define IMX_SC_PM_CLK_MISC1            1       /* Misc 1 clock */
> +#define IMX_SC_PM_CLK_MISC2            2       /* Misc 2 clock */
> +#define IMX_SC_PM_CLK_MISC3            3       /* Misc 3 clock */
> +#define IMX_SC_PM_CLK_MISC4            4       /* Misc 4 clock */
> +#define IMX_SC_PM_CLK_CPU              2       /* CPU clock */
> +#define IMX_SC_PM_CLK_PLL              4       /* PLL */
> +#define IMX_SC_PM_CLK_BYPASS           4       /* Bypass clock */
> +
> +/*
> + * Defines for SC CONTROL
> + */
> +#define IMX_SC_C_TEMP                       0U
> +#define IMX_SC_C_TEMP_HI                    1U
> +#define IMX_SC_C_TEMP_LOW                   2U
> +#define IMX_SC_C_PXL_LINK_MST1_ADDR         3U
> +#define IMX_SC_C_PXL_LINK_MST2_ADDR         4U
> +#define IMX_SC_C_PXL_LINK_MST_ENB           5U
> +#define IMX_SC_C_PXL_LINK_MST1_ENB          6U
> +#define IMX_SC_C_PXL_LINK_MST2_ENB          7U
> +#define IMX_SC_C_PXL_LINK_SLV1_ADDR         8U
> +#define IMX_SC_C_PXL_LINK_SLV2_ADDR         9U
> +#define IMX_SC_C_PXL_LINK_MST_VLD           10U
> +#define IMX_SC_C_PXL_LINK_MST1_VLD          11U
> +#define IMX_SC_C_PXL_LINK_MST2_VLD          12U
> +#define IMX_SC_C_SINGLE_MODE                13U
> +#define IMX_SC_C_ID                         14U
> +#define IMX_SC_C_PXL_CLK_POLARITY           15U
> +#define IMX_SC_C_LINESTATE                  16U
> +#define IMX_SC_C_PCIE_G_RST                 17U
> +#define IMX_SC_C_PCIE_BUTTON_RST            18U
> +#define IMX_SC_C_PCIE_PERST                 19U
> +#define IMX_SC_C_PHY_RESET                  20U
> +#define IMX_SC_C_PXL_LINK_RATE_CORRECTION   21U
> +#define IMX_SC_C_PANIC                      22U
> +#define IMX_SC_C_PRIORITY_GROUP             23U
> +#define IMX_SC_C_TXCLK                      24U
> +#define IMX_SC_C_CLKDIV                     25U
> +#define IMX_SC_C_DISABLE_50                 26U
> +#define IMX_SC_C_DISABLE_125                27U
> +#define IMX_SC_C_SEL_125                    28U
> +#define IMX_SC_C_MODE                       29U
> +#define IMX_SC_C_SYNC_CTRL0                 30U
> +#define IMX_SC_C_KACHUNK_CNT                31U
> +#define IMX_SC_C_KACHUNK_SEL                32U
> +#define IMX_SC_C_SYNC_CTRL1                 33U
> +#define IMX_SC_C_DPI_RESET                  34U
> +#define IMX_SC_C_MIPI_RESET                 35U
> +#define IMX_SC_C_DUAL_MODE                  36U
> +#define IMX_SC_C_VOLTAGE                    37U
> +#define IMX_SC_C_PXL_LINK_SEL               38U
> +#define IMX_SC_C_OFS_SEL                    39U
> +#define IMX_SC_C_OFS_AUDIO                  40U
> +#define IMX_SC_C_OFS_PERIPH                 41U
> +#define IMX_SC_C_OFS_IRQ                    42U
> +#define IMX_SC_C_RST0                       43U
> +#define IMX_SC_C_RST1                       44U
> +#define IMX_SC_C_SEL0                       45U
> +#define IMX_SC_C_CALIB0                     46U
> +#define IMX_SC_C_CALIB1                     47U
> +#define IMX_SC_C_CALIB2                     48U
> +#define IMX_SC_C_IPG_DEBUG                  49U
> +#define IMX_SC_C_IPG_DOZE                   50U
> +#define IMX_SC_C_IPG_WAIT                   51U
> +#define IMX_SC_C_IPG_STOP                   52U
> +#define IMX_SC_C_IPG_STOP_MODE              53U
> +#define IMX_SC_C_IPG_STOP_ACK               54U
> +#define IMX_SC_C_SYNC_CTRL                  55U
> +#define IMX_SC_C_OFS_AUDIO_ALT              56U
> +#define IMX_SC_C_DSP_BYP                    57U
> +#define IMX_SC_C_CLK_GEN_EN                 58U
> +#define IMX_SC_C_INTF_SEL                   59U
> +#define IMX_SC_C_RXC_DLY                    60U
> +#define IMX_SC_C_TIMER_SEL                  61U
> +#define IMX_SC_C_LAST                       62U
> +
>  #endif /* __DT_BINDINGS_RSCRC_IMX_H */
> diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
> index 17ba4e4..3fa418a 100644
> --- a/include/linux/firmware/imx/sci.h
> +++ b/include/linux/firmware/imx/sci.h
> @@ -11,7 +11,6 @@
>  #define _SC_SCI_H
>
>  #include <linux/firmware/imx/ipc.h>
> -#include <linux/firmware/imx/types.h>
>
>  #include <linux/firmware/imx/svc/misc.h>
>  #include <linux/firmware/imx/svc/pm.h>
> diff --git a/include/linux/firmware/imx/types.h b/include/linux/firmware/imx/types.h
> deleted file mode 100644
> index 8082110..0000000
> --- a/include/linux/firmware/imx/types.h
> +++ /dev/null
> @@ -1,65 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Copyright (C) 2016 Freescale Semiconductor, Inc.
> - * Copyright 2017~2018 NXP
> - *
> - * Header file containing types used across multiple service APIs.
> - */
> -
> -#ifndef _SC_TYPES_H
> -#define _SC_TYPES_H
> -
> -/*
> - * This type is used to indicate a control.
> - */
> -enum imx_sc_ctrl {
> -       IMX_SC_C_TEMP = 0,
> -       IMX_SC_C_TEMP_HI = 1,
> -       IMX_SC_C_TEMP_LOW = 2,
> -       IMX_SC_C_PXL_LINK_MST1_ADDR = 3,
> -       IMX_SC_C_PXL_LINK_MST2_ADDR = 4,
> -       IMX_SC_C_PXL_LINK_MST_ENB = 5,
> -       IMX_SC_C_PXL_LINK_MST1_ENB = 6,
> -       IMX_SC_C_PXL_LINK_MST2_ENB = 7,
> -       IMX_SC_C_PXL_LINK_SLV1_ADDR = 8,
> -       IMX_SC_C_PXL_LINK_SLV2_ADDR = 9,
> -       IMX_SC_C_PXL_LINK_MST_VLD = 10,
> -       IMX_SC_C_PXL_LINK_MST1_VLD = 11,
> -       IMX_SC_C_PXL_LINK_MST2_VLD = 12,
> -       IMX_SC_C_SINGLE_MODE = 13,
> -       IMX_SC_C_ID = 14,
> -       IMX_SC_C_PXL_CLK_POLARITY = 15,
> -       IMX_SC_C_LINESTATE = 16,
> -       IMX_SC_C_PCIE_G_RST = 17,
> -       IMX_SC_C_PCIE_BUTTON_RST = 18,
> -       IMX_SC_C_PCIE_PERST = 19,
> -       IMX_SC_C_PHY_RESET = 20,
> -       IMX_SC_C_PXL_LINK_RATE_CORRECTION = 21,
> -       IMX_SC_C_PANIC = 22,
> -       IMX_SC_C_PRIORITY_GROUP = 23,
> -       IMX_SC_C_TXCLK = 24,
> -       IMX_SC_C_CLKDIV = 25,
> -       IMX_SC_C_DISABLE_50 = 26,
> -       IMX_SC_C_DISABLE_125 = 27,
> -       IMX_SC_C_SEL_125 = 28,
> -       IMX_SC_C_MODE = 29,
> -       IMX_SC_C_SYNC_CTRL0 = 30,
> -       IMX_SC_C_KACHUNK_CNT = 31,
> -       IMX_SC_C_KACHUNK_SEL = 32,
> -       IMX_SC_C_SYNC_CTRL1 = 33,
> -       IMX_SC_C_DPI_RESET = 34,
> -       IMX_SC_C_MIPI_RESET = 35,
> -       IMX_SC_C_DUAL_MODE = 36,
> -       IMX_SC_C_VOLTAGE = 37,
> -       IMX_SC_C_PXL_LINK_SEL = 38,
> -       IMX_SC_C_OFS_SEL = 39,
> -       IMX_SC_C_OFS_AUDIO = 40,
> -       IMX_SC_C_OFS_PERIPH = 41,
> -       IMX_SC_C_OFS_IRQ = 42,
> -       IMX_SC_C_RST0 = 43,
> -       IMX_SC_C_RST1 = 44,
> -       IMX_SC_C_SEL0 = 45,
> -       IMX_SC_C_LAST
> -};
> -
> -#endif /* _SC_TYPES_H */
> --
> 2.7.4
>
