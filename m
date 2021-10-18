Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9250E431983
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 14:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhJRMoB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 08:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhJRMn5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 08:43:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F10C06161C;
        Mon, 18 Oct 2021 05:41:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d3so70448126edp.3;
        Mon, 18 Oct 2021 05:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ma438rY78GdjEHQdrb6TeuEWVkfDff3eVr92rQK25g=;
        b=bcAtQSZOMt385CqDWdkLB/tKrt5rRPBKhcbch35IBWT6Sr3WLk901jzIlD+48ZjV8w
         KAH93yJNsDq7DOIUt7l6UXvAnST7EhOYi8fVfOjB1sBx1P8ou9IomX99wgP1XJHlE2Kk
         LHINYnzr/F3bwU9rcVPUAWRdk8MrKSqERp+nuzTC4/kJMrI/BFk9mck8zRNIEccdURJ0
         DIlJRTGc4WB6uKaPwdgtVYpgJyZH0k5Ppwbq6MFG66zZ7mk/7AU0D9B6xpUxofVl/ikK
         HgUQu/wcXzHsfRLhPrJTunXyNMh4Y5/HD4enWwsx3d0VDuwnMbuKzBROppO6C1iKT029
         Japg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ma438rY78GdjEHQdrb6TeuEWVkfDff3eVr92rQK25g=;
        b=IaXf34Mux0AyglbI+aiu5x4/MFKymGPPK6YKWfiNIme/H/syr4UqF5OqC1/KF5o4SJ
         u8BCy9LHOnilQOeyJEawgkyFCJ1qX9qfqyEviBNCybmXeGwzMjjsrjDDg18ifIp2JgIf
         +zlnbeQylHNPxmTmc7J6wDFS+0PHjLmQ2hSC8OV55NoT501jPfIOsgAuajHqvlVyHOnI
         JboUXwgv6idmYKuEi0reURRP9afLqS06exyqPtIyi7pDGuDbuH7NRoU8xcDf4zcCi/Rd
         v6M7mL/6IkbRb/UhloWnJ6qFggVPiI0SDe3ne/8Q+zw3Q+QIzpE7x0mFOWGMAOZJNdK7
         PMnw==
X-Gm-Message-State: AOAM531JQhrxu85GaHZWxChJ5411678sJQloecgl/Yv/PM3XPlysyAp3
        IteBj3GKrXDD4dG+V4kv6ocKwUk1PhkFBdEc/24=
X-Google-Smtp-Source: ABdhPJz1PLsDQarVE2punUuKVpCeV/TAxHyeu/Efl7gijXadKdGcoiL62B//S44l/8LUBAQnLezt1XPCjgNtrvKbCk8=
X-Received: by 2002:a17:907:2bdf:: with SMTP id gv31mr28802835ejc.521.1634560902659;
 Mon, 18 Oct 2021 05:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com> <1631554694-9599-9-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1631554694-9599-9-git-send-email-abel.vesa@nxp.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 18 Oct 2021 07:41:31 -0500
Message-ID: <CAHCN7xLpdLY06vUDW0-oAVWDk-VYf_8kZh2F8f5+jd0RS0y74w@mail.gmail.com>
Subject: Re: [RFC 08/19] interconnect: imx8: Remove the imx_icc_node_adj_desc
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 13, 2021 at 12:39 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Now that the imx generic interconnect doesn't use the
> imx_icc_node_adj_desc, we remove it from all the i.MX8M
> platform drivers.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/interconnect/imx/imx.h    | 19 ++++-------------
>  drivers/interconnect/imx/imx8mm.c | 32 +++++++++-------------------
>  drivers/interconnect/imx/imx8mn.c | 28 +++++++------------------
>  drivers/interconnect/imx/imx8mq.c | 35 ++++++++++---------------------
>  4 files changed, 33 insertions(+), 81 deletions(-)
>

I noticed there are no interconnect nodes in the imx8mm nor the
imx8mn, so it appears to me like the mini and nano code won't do
anything.


adam
> diff --git a/drivers/interconnect/imx/imx.h b/drivers/interconnect/imx/imx.h
> index 75da51076c68..5c9f5138f6aa 100644
> --- a/drivers/interconnect/imx/imx.h
> +++ b/drivers/interconnect/imx/imx.h
> @@ -14,15 +14,6 @@
>
>  #define IMX_ICC_MAX_LINKS      4
>
> -/*
> - * struct imx_icc_node_adj - Describe a dynamic adjustable node
> - */
> -struct imx_icc_node_adj_desc {
> -       unsigned int bw_mul, bw_div;
> -       const char *phandle_name;
> -       bool main_noc;
> -};
> -
>  /*
>   * struct imx_icc_node - Describe an interconnect node
>   * @name: name of the node
> @@ -35,23 +26,21 @@ struct imx_icc_node_desc {
>         u16 id;
>         u16 links[IMX_ICC_MAX_LINKS];
>         u16 num_links;
> -       const struct imx_icc_node_adj_desc *adj;
>  };
>
> -#define DEFINE_BUS_INTERCONNECT(_name, _id, _adj, ...)                 \
> +#define DEFINE_BUS_INTERCONNECT(_name, _id, ...)                       \
>         {                                                               \
>                 .id = _id,                                              \
>                 .name = _name,                                          \
> -               .adj = _adj,                                            \
>                 .num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),      \
>                 .links = { __VA_ARGS__ },                               \
>         }
>
>  #define DEFINE_BUS_MASTER(_name, _id, _dest_id)                                \
> -       DEFINE_BUS_INTERCONNECT(_name, _id, NULL, _dest_id)
> +       DEFINE_BUS_INTERCONNECT(_name, _id, _dest_id)
>
> -#define DEFINE_BUS_SLAVE(_name, _id, _adj)                             \
> -       DEFINE_BUS_INTERCONNECT(_name, _id, _adj)
> +#define DEFINE_BUS_SLAVE(_name, _id)                                   \
> +       DEFINE_BUS_INTERCONNECT(_name, _id)
>
>  int imx_icc_register(struct platform_device *pdev,
>                      struct imx_icc_node_desc *nodes,
> diff --git a/drivers/interconnect/imx/imx8mm.c b/drivers/interconnect/imx/imx8mm.c
> index 1083490bb391..0c16110bef9d 100644
> --- a/drivers/interconnect/imx/imx8mm.c
> +++ b/drivers/interconnect/imx/imx8mm.c
> @@ -14,18 +14,6 @@
>
>  #include "imx.h"
>
> -static const struct imx_icc_node_adj_desc imx8mm_dram_adj = {
> -       .bw_mul = 1,
> -       .bw_div = 16,
> -       .phandle_name = "fsl,ddrc",
> -};
> -
> -static const struct imx_icc_node_adj_desc imx8mm_noc_adj = {
> -       .bw_mul = 1,
> -       .bw_div = 16,
> -       .main_noc = true,
> -};
> -
>  /*
>   * Describe bus masters, slaves and connections between them
>   *
> @@ -33,43 +21,43 @@ static const struct imx_icc_node_adj_desc imx8mm_noc_adj = {
>   * PL301 nics which are skipped/merged into PL301_MAIN
>   */
>  static struct imx_icc_node_desc nodes[] = {
> -       DEFINE_BUS_INTERCONNECT("NOC", IMX8MM_ICN_NOC, &imx8mm_noc_adj,
> +       DEFINE_BUS_INTERCONNECT("NOC", IMX8MM_ICN_NOC,
>                         IMX8MM_ICS_DRAM, IMX8MM_ICN_MAIN),
>
> -       DEFINE_BUS_SLAVE("DRAM", IMX8MM_ICS_DRAM, &imx8mm_dram_adj),
> -       DEFINE_BUS_SLAVE("OCRAM", IMX8MM_ICS_OCRAM, NULL),
> +       DEFINE_BUS_SLAVE("DRAM", IMX8MM_ICS_DRAM),
> +       DEFINE_BUS_SLAVE("OCRAM", IMX8MM_ICS_OCRAM),
>         DEFINE_BUS_MASTER("A53", IMX8MM_ICM_A53, IMX8MM_ICN_NOC),
>
>         /* VPUMIX */
>         DEFINE_BUS_MASTER("VPU H1", IMX8MM_ICM_VPU_H1, IMX8MM_ICN_VIDEO),
>         DEFINE_BUS_MASTER("VPU G1", IMX8MM_ICM_VPU_G1, IMX8MM_ICN_VIDEO),
>         DEFINE_BUS_MASTER("VPU G2", IMX8MM_ICM_VPU_G2, IMX8MM_ICN_VIDEO),
> -       DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MM_ICN_VIDEO, NULL, IMX8MM_ICN_NOC),
> +       DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MM_ICN_VIDEO, IMX8MM_ICN_NOC),
>
>         /* GPUMIX */
>         DEFINE_BUS_MASTER("GPU 2D", IMX8MM_ICM_GPU2D, IMX8MM_ICN_GPU),
>         DEFINE_BUS_MASTER("GPU 3D", IMX8MM_ICM_GPU3D, IMX8MM_ICN_GPU),
> -       DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MM_ICN_GPU, NULL, IMX8MM_ICN_NOC),
> +       DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MM_ICN_GPU, IMX8MM_ICN_NOC),
>
>         /* DISPLAYMIX */
>         DEFINE_BUS_MASTER("CSI", IMX8MM_ICM_CSI, IMX8MM_ICN_MIPI),
>         DEFINE_BUS_MASTER("LCDIF", IMX8MM_ICM_LCDIF, IMX8MM_ICN_MIPI),
> -       DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MM_ICN_MIPI, NULL, IMX8MM_ICN_NOC),
> +       DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MM_ICN_MIPI, IMX8MM_ICN_NOC),
>
>         /* HSIO */
>         DEFINE_BUS_MASTER("USB1", IMX8MM_ICM_USB1, IMX8MM_ICN_HSIO),
>         DEFINE_BUS_MASTER("USB2", IMX8MM_ICM_USB2, IMX8MM_ICN_HSIO),
>         DEFINE_BUS_MASTER("PCIE", IMX8MM_ICM_PCIE, IMX8MM_ICN_HSIO),
> -       DEFINE_BUS_INTERCONNECT("PL301_HSIO", IMX8MM_ICN_HSIO, NULL, IMX8MM_ICN_NOC),
> +       DEFINE_BUS_INTERCONNECT("PL301_HSIO", IMX8MM_ICN_HSIO, IMX8MM_ICN_NOC),
>
>         /* Audio */
>         DEFINE_BUS_MASTER("SDMA2", IMX8MM_ICM_SDMA2, IMX8MM_ICN_AUDIO),
>         DEFINE_BUS_MASTER("SDMA3", IMX8MM_ICM_SDMA3, IMX8MM_ICN_AUDIO),
> -       DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MM_ICN_AUDIO, NULL, IMX8MM_ICN_MAIN),
> +       DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MM_ICN_AUDIO, IMX8MM_ICN_MAIN),
>
>         /* Ethernet */
>         DEFINE_BUS_MASTER("ENET", IMX8MM_ICM_ENET, IMX8MM_ICN_ENET),
> -       DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MM_ICN_ENET, NULL, IMX8MM_ICN_MAIN),
> +       DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MM_ICN_ENET, IMX8MM_ICN_MAIN),
>
>         /* Other */
>         DEFINE_BUS_MASTER("SDMA1", IMX8MM_ICM_SDMA1, IMX8MM_ICN_MAIN),
> @@ -77,7 +65,7 @@ static struct imx_icc_node_desc nodes[] = {
>         DEFINE_BUS_MASTER("USDHC1", IMX8MM_ICM_USDHC1, IMX8MM_ICN_MAIN),
>         DEFINE_BUS_MASTER("USDHC2", IMX8MM_ICM_USDHC2, IMX8MM_ICN_MAIN),
>         DEFINE_BUS_MASTER("USDHC3", IMX8MM_ICM_USDHC3, IMX8MM_ICN_MAIN),
> -       DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MM_ICN_MAIN, NULL,
> +       DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MM_ICN_MAIN,
>                         IMX8MM_ICN_NOC, IMX8MM_ICS_OCRAM),
>  };
>
> diff --git a/drivers/interconnect/imx/imx8mn.c b/drivers/interconnect/imx/imx8mn.c
> index ad97e55fd4e5..8d16bd5cf006 100644
> --- a/drivers/interconnect/imx/imx8mn.c
> +++ b/drivers/interconnect/imx/imx8mn.c
> @@ -11,18 +11,6 @@
>
>  #include "imx.h"
>
> -static const struct imx_icc_node_adj_desc imx8mn_dram_adj = {
> -       .bw_mul = 1,
> -       .bw_div = 4,
> -       .phandle_name = "fsl,ddrc",
> -};
> -
> -static const struct imx_icc_node_adj_desc imx8mn_noc_adj = {
> -       .bw_mul = 1,
> -       .bw_div = 4,
> -       .main_noc = true,
> -};
> -
>  /*
>   * Describe bus masters, slaves and connections between them
>   *
> @@ -30,23 +18,23 @@ static const struct imx_icc_node_adj_desc imx8mn_noc_adj = {
>   * PL301 nics which are skipped/merged into PL301_MAIN
>   */
>  static struct imx_icc_node_desc nodes[] = {
> -       DEFINE_BUS_INTERCONNECT("NOC", IMX8MN_ICN_NOC, &imx8mn_noc_adj,
> +       DEFINE_BUS_INTERCONNECT("NOC", IMX8MN_ICN_NOC,
>                         IMX8MN_ICS_DRAM, IMX8MN_ICN_MAIN),
>
> -       DEFINE_BUS_SLAVE("DRAM", IMX8MN_ICS_DRAM, &imx8mn_dram_adj),
> -       DEFINE_BUS_SLAVE("OCRAM", IMX8MN_ICS_OCRAM, NULL),
> +       DEFINE_BUS_SLAVE("DRAM", IMX8MN_ICS_DRAM),
> +       DEFINE_BUS_SLAVE("OCRAM", IMX8MN_ICS_OCRAM),
>         DEFINE_BUS_MASTER("A53", IMX8MN_ICM_A53, IMX8MN_ICN_NOC),
>
>         /* GPUMIX */
>         DEFINE_BUS_MASTER("GPU", IMX8MN_ICM_GPU, IMX8MN_ICN_GPU),
> -       DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MN_ICN_GPU, NULL, IMX8MN_ICN_NOC),
> +       DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MN_ICN_GPU, IMX8MN_ICN_NOC),
>
>         /* DISPLAYMIX */
>         DEFINE_BUS_MASTER("CSI1", IMX8MN_ICM_CSI1, IMX8MN_ICN_MIPI),
>         DEFINE_BUS_MASTER("CSI2", IMX8MN_ICM_CSI2, IMX8MN_ICN_MIPI),
>         DEFINE_BUS_MASTER("ISI", IMX8MN_ICM_ISI, IMX8MN_ICN_MIPI),
>         DEFINE_BUS_MASTER("LCDIF", IMX8MN_ICM_LCDIF, IMX8MN_ICN_MIPI),
> -       DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MN_ICN_MIPI, NULL, IMX8MN_ICN_NOC),
> +       DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MN_ICN_MIPI, IMX8MN_ICN_NOC),
>
>         /* USB goes straight to NOC */
>         DEFINE_BUS_MASTER("USB", IMX8MN_ICM_USB, IMX8MN_ICN_NOC),
> @@ -54,11 +42,11 @@ static struct imx_icc_node_desc nodes[] = {
>         /* Audio */
>         DEFINE_BUS_MASTER("SDMA2", IMX8MN_ICM_SDMA2, IMX8MN_ICN_AUDIO),
>         DEFINE_BUS_MASTER("SDMA3", IMX8MN_ICM_SDMA3, IMX8MN_ICN_AUDIO),
> -       DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MN_ICN_AUDIO, NULL, IMX8MN_ICN_MAIN),
> +       DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MN_ICN_AUDIO, IMX8MN_ICN_MAIN),
>
>         /* Ethernet */
>         DEFINE_BUS_MASTER("ENET", IMX8MN_ICM_ENET, IMX8MN_ICN_ENET),
> -       DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MN_ICN_ENET, NULL, IMX8MN_ICN_MAIN),
> +       DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MN_ICN_ENET, IMX8MN_ICN_MAIN),
>
>         /* Other */
>         DEFINE_BUS_MASTER("SDMA1", IMX8MN_ICM_SDMA1, IMX8MN_ICN_MAIN),
> @@ -66,7 +54,7 @@ static struct imx_icc_node_desc nodes[] = {
>         DEFINE_BUS_MASTER("USDHC1", IMX8MN_ICM_USDHC1, IMX8MN_ICN_MAIN),
>         DEFINE_BUS_MASTER("USDHC2", IMX8MN_ICM_USDHC2, IMX8MN_ICN_MAIN),
>         DEFINE_BUS_MASTER("USDHC3", IMX8MN_ICM_USDHC3, IMX8MN_ICN_MAIN),
> -       DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MN_ICN_MAIN, NULL,
> +       DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MN_ICN_MAIN
>                         IMX8MN_ICN_NOC, IMX8MN_ICS_OCRAM),
>  };
>
> diff --git a/drivers/interconnect/imx/imx8mq.c b/drivers/interconnect/imx/imx8mq.c
> index d7768d3c6d8a..b8c36d668946 100644
> --- a/drivers/interconnect/imx/imx8mq.c
> +++ b/drivers/interconnect/imx/imx8mq.c
> @@ -12,18 +12,6 @@
>
>  #include "imx.h"
>
> -static const struct imx_icc_node_adj_desc imx8mq_dram_adj = {
> -       .bw_mul = 1,
> -       .bw_div = 4,
> -       .phandle_name = "fsl,ddrc",
> -};
> -
> -static const struct imx_icc_node_adj_desc imx8mq_noc_adj = {
> -       .bw_mul = 1,
> -       .bw_div = 4,
> -       .main_noc = true,
> -};
> -
>  /*
>   * Describe bus masters, slaves and connections between them
>   *
> @@ -31,43 +19,42 @@ static const struct imx_icc_node_adj_desc imx8mq_noc_adj = {
>   * PL301 nics which are skipped/merged into PL301_MAIN
>   */
>  static struct imx_icc_node_desc nodes[] = {
> -       DEFINE_BUS_INTERCONNECT("NOC", IMX8MQ_ICN_NOC, &imx8mq_noc_adj,
> -                       IMX8MQ_ICS_DRAM, IMX8MQ_ICN_MAIN),
> +       DEFINE_BUS_INTERCONNECT("NOC", IMX8MQ_ICN_NOC, IMX8MQ_ICS_DRAM, IMX8MQ_ICN_MAIN),
>
> -       DEFINE_BUS_SLAVE("DRAM", IMX8MQ_ICS_DRAM, &imx8mq_dram_adj),
> -       DEFINE_BUS_SLAVE("OCRAM", IMX8MQ_ICS_OCRAM, NULL),
> +       DEFINE_BUS_SLAVE("DRAM", IMX8MQ_ICS_DRAM),
> +       DEFINE_BUS_SLAVE("OCRAM", IMX8MQ_ICS_OCRAM),
>         DEFINE_BUS_MASTER("A53", IMX8MQ_ICM_A53, IMX8MQ_ICN_NOC),
>
>         /* VPUMIX */
>         DEFINE_BUS_MASTER("VPU", IMX8MQ_ICM_VPU, IMX8MQ_ICN_VIDEO),
> -       DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MQ_ICN_VIDEO, NULL, IMX8MQ_ICN_NOC),
> +       DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MQ_ICN_VIDEO, IMX8MQ_ICN_NOC),
>
>         /* GPUMIX */
>         DEFINE_BUS_MASTER("GPU", IMX8MQ_ICM_GPU, IMX8MQ_ICN_GPU),
> -       DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MQ_ICN_GPU, NULL, IMX8MQ_ICN_NOC),
> +       DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MQ_ICN_GPU, IMX8MQ_ICN_NOC),
>
>         /* DISPMIX (only for DCSS) */
>         DEFINE_BUS_MASTER("DC", IMX8MQ_ICM_DCSS, IMX8MQ_ICN_DCSS),
> -       DEFINE_BUS_INTERCONNECT("PL301_DC", IMX8MQ_ICN_DCSS, NULL, IMX8MQ_ICN_NOC),
> +       DEFINE_BUS_INTERCONNECT("PL301_DC", IMX8MQ_ICN_DCSS, IMX8MQ_ICN_NOC),
>
>         /* USBMIX */
>         DEFINE_BUS_MASTER("USB1", IMX8MQ_ICM_USB1, IMX8MQ_ICN_USB),
>         DEFINE_BUS_MASTER("USB2", IMX8MQ_ICM_USB2, IMX8MQ_ICN_USB),
> -       DEFINE_BUS_INTERCONNECT("PL301_USB", IMX8MQ_ICN_USB, NULL, IMX8MQ_ICN_NOC),
> +       DEFINE_BUS_INTERCONNECT("PL301_USB", IMX8MQ_ICN_USB, IMX8MQ_ICN_NOC),
>
>         /* PL301_DISPLAY (IPs other than DCSS, inside SUPERMIX) */
>         DEFINE_BUS_MASTER("CSI1", IMX8MQ_ICM_CSI1, IMX8MQ_ICN_DISPLAY),
>         DEFINE_BUS_MASTER("CSI2", IMX8MQ_ICM_CSI2, IMX8MQ_ICN_DISPLAY),
>         DEFINE_BUS_MASTER("LCDIF", IMX8MQ_ICM_LCDIF, IMX8MQ_ICN_DISPLAY),
> -       DEFINE_BUS_INTERCONNECT("PL301_DISPLAY", IMX8MQ_ICN_DISPLAY, NULL, IMX8MQ_ICN_MAIN),
> +       DEFINE_BUS_INTERCONNECT("PL301_DISPLAY", IMX8MQ_ICN_DISPLAY, IMX8MQ_ICN_MAIN),
>
>         /* AUDIO */
>         DEFINE_BUS_MASTER("SDMA2", IMX8MQ_ICM_SDMA2, IMX8MQ_ICN_AUDIO),
> -       DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MQ_ICN_AUDIO, NULL, IMX8MQ_ICN_DISPLAY),
> +       DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MQ_ICN_AUDIO, IMX8MQ_ICN_DISPLAY),
>
>         /* ENET */
>         DEFINE_BUS_MASTER("ENET", IMX8MQ_ICM_ENET, IMX8MQ_ICN_ENET),
> -       DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MQ_ICN_ENET, NULL, IMX8MQ_ICN_MAIN),
> +       DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MQ_ICN_ENET, IMX8MQ_ICN_MAIN),
>
>         /* OTHER */
>         DEFINE_BUS_MASTER("SDMA1", IMX8MQ_ICM_SDMA1, IMX8MQ_ICN_MAIN),
> @@ -76,7 +63,7 @@ static struct imx_icc_node_desc nodes[] = {
>         DEFINE_BUS_MASTER("USDHC2", IMX8MQ_ICM_USDHC2, IMX8MQ_ICN_MAIN),
>         DEFINE_BUS_MASTER("PCIE1", IMX8MQ_ICM_PCIE1, IMX8MQ_ICN_MAIN),
>         DEFINE_BUS_MASTER("PCIE2", IMX8MQ_ICM_PCIE2, IMX8MQ_ICN_MAIN),
> -       DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MQ_ICN_MAIN, NULL,
> +       DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MQ_ICN_MAIN,
>                         IMX8MQ_ICN_NOC, IMX8MQ_ICS_OCRAM),
>  };
>
> --
> 2.31.1
>
