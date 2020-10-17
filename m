Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB962911F9
	for <lists+linux-pm@lfdr.de>; Sat, 17 Oct 2020 15:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438014AbgJQNVo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Oct 2020 09:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438041AbgJQNVn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Oct 2020 09:21:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD157C061755;
        Sat, 17 Oct 2020 06:21:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n15so6538334wrq.2;
        Sat, 17 Oct 2020 06:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Iatka7C4NJK2vmnSHshTpsMZv8AB40sJEA38wTBvVV8=;
        b=XqiFgSvPSfvyaaFncaSAS6M0TQzV01OuqXIp74uUPMXyyi/9m6IF0d6U0V8RlM1nzr
         g7wufSOyFnsjTd0tOzNIl5oWx9/rB02Wd2WXCgM3qj2dHK6ss9ZDhJeEukBKZSffyroO
         pNAzSUix/DwHtqNPDcpaGaw7jdkBD4HDQhCwnynepmPu3w/DPYZgDGPsby4TtZ3QNou0
         tTIg/12qn9s5I3JPBwnt88XxAwM9WlDqhCm+BZOR+WySIZQF24y9at0xZjqHw6XQkMvE
         DK4d4GdmXtk0Tde51SvHIXcVfbhVxiYUa0a824boVk1xhOl9Pefqjr8G/QTI+MmEn424
         o0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Iatka7C4NJK2vmnSHshTpsMZv8AB40sJEA38wTBvVV8=;
        b=aYXQ16QIU8NN79xKvimBqi/uXpo2BTjMhbFl7TQilekHAMwmQU/Po7DFry39T9KBSm
         JJNGDRViLHZI/5EVshg3ExjL9VrHDRQz2OXVfFPVP+qcgofookz6wRVyQuwL+VaJRxHD
         EJRDvgmrmeMhvB+kubf60fwBa1EiySSgczVyLniOcd61a6ipQ1i8YQWS67/e8XRc5piz
         ifFNVR4o86boCyhuWZy6wGp4ysBzaQ/6G82dbL/54v7GbNGwxij2+9sdc4WpOFMlS0Iu
         bkDKlR0q+b3TaUa/0+QAx4d22Yec7TADtQjHyJvc+l+YW+d/8a9I4T/v1GClD99PcH4Z
         ozIQ==
X-Gm-Message-State: AOAM530JwdlUxG4pMaSMqExzifw4HkhwZdAqeI46rO+f/CBH/ic7NNGr
        acKHN1aLDc3auNJ2G100F8IlwpFm3y5K0o4DHZU=
X-Google-Smtp-Source: ABdhPJyoFlBugfBOhzcxQjwXYOUHh+TPkF/sdHZk5EbsxGxMrKhGYJ2KYqS2vcrgWRilxtim6525kU0dvGw8NaXbm3E=
X-Received: by 2002:a5d:4843:: with SMTP id n3mr10407515wrs.416.1602940900815;
 Sat, 17 Oct 2020 06:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201008204515.695210-1-kholk11@gmail.com> <20201008204515.695210-3-kholk11@gmail.com>
 <cf9ddcd1-6f95-15bc-b295-6c5147dce608@linaro.org>
In-Reply-To: <cf9ddcd1-6f95-15bc-b295-6c5147dce608@linaro.org>
From:   AngeloGioacchino Del Regno <kholk11@gmail.com>
Date:   Sat, 17 Oct 2020 15:21:29 +0200
Message-ID: <CAK7fi1ZPhz9B--OMvUAOQTELN8G2pe-bp89RKZuUSZeAhsiuNA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] interconnect: qcom: Add SDM660 interconnect
 provider driver
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, marijns95@gmail.com,
        konradybcio@gmail.com, martin.botka1@gmail.com,
        MSM <linux-arm-msm@vger.kernel.org>, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello!

Il giorno ven 16 ott 2020 alle ore 10:46 Georgi Djakov
<georgi.djakov@linaro.org> ha scritto:
>
> Hi,
>
> Thanks for the patch!
My pleasure!

>
> On 10/8/20 23:45, kholk11@gmail.com wrote:
> > From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> >
> > Introduce a driver for the Qualcomm interconnect busses found in
> > the SDM630/SDM636/SDM660 SoCs.
> > The topology consists of several NoCs that are controlled by a
> > remote processor that collects the aggregated bandwidth for each
> > master-slave pairs.
> >
> > On a note, these chips are managing the "bus QoS" in a "hybrid"
> > fashion: some of the paths in the topology are managed through
> > (and by, of course) the RPM uC, while some others are "AP Owned",
> > meaning that the AP shall do direct writes to the appropriate
> > QoS registers for the specific paths and ports, instead of sending
> > an indication to the RPM and leaving the job to that one.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> > ---
> >  drivers/interconnect/qcom/Kconfig  |   9 +
> >  drivers/interconnect/qcom/Makefile |   2 +
> >  drivers/interconnect/qcom/sdm660.c | 919 +++++++++++++++++++++++++++++
> >  3 files changed, 930 insertions(+)
> >  create mode 100644 drivers/interconnect/qcom/sdm660.c
> >
> > diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/q=
com/Kconfig
> > index a8f93ba265f8..ae76527a22f6 100644
> > --- a/drivers/interconnect/qcom/Kconfig
> > +++ b/drivers/interconnect/qcom/Kconfig
> > @@ -42,6 +42,15 @@ config INTERCONNECT_QCOM_QCS404
> >         This is a driver for the Qualcomm Network-on-Chip on qcs404-bas=
ed
> >         platforms.
> >
> > +config INTERCONNECT_QCOM_SDM660
> > +     tristate "Qualcomm SDM660 interconnect driver"
> > +     depends on INTERCONNECT_QCOM
> > +     depends on QCOM_SMD_RPM
> > +     select INTERCONNECT_QCOM_SMD_RPM
> > +     help
> > +       This is a driver for the Qualcomm Network-on-Chip on sdm660-bas=
ed
> > +       platforms.
> > +
> >  config INTERCONNECT_QCOM_RPMH
> >       tristate
> >
> > diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/=
qcom/Makefile
> > index cf628f7990cd..ebe15d1dfe8b 100644
> > --- a/drivers/interconnect/qcom/Makefile
> > +++ b/drivers/interconnect/qcom/Makefile
> > @@ -7,6 +7,7 @@ icc-osm-l3-objs                               :=3D osm-=
l3.o
> >  qnoc-qcs404-objs                     :=3D qcs404.o
> >  icc-rpmh-obj                         :=3D icc-rpmh.o
> >  qnoc-sc7180-objs                     :=3D sc7180.o
> > +qnoc-sdm660-objs                     :=3D sdm660.o
> >  qnoc-sdm845-objs                     :=3D sdm845.o
> >  qnoc-sm8150-objs                     :=3D sm8150.o
> >  qnoc-sm8250-objs                     :=3D sm8250.o
> > @@ -19,6 +20,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) +=3D icc-osm-l=
3.o
> >  obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) +=3D qnoc-qcs404.o
> >  obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) +=3D icc-rpmh.o
> >  obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) +=3D qnoc-sc7180.o
> > +obj-$(CONFIG_INTERCONNECT_QCOM_SDM660) +=3D qnoc-sdm660.o
> >  obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) +=3D qnoc-sdm845.o
> >  obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) +=3D qnoc-sm8150.o
> >  obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) +=3D qnoc-sm8250.o
> > diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/=
qcom/sdm660.c
> > new file mode 100644
> > index 000000000000..9ad709dde913
> > --- /dev/null
> > +++ b/drivers/interconnect/qcom/sdm660.c
> > @@ -0,0 +1,919 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Qualcomm SDM630/SDM636/SDM660 Network-on-Chip (NoC) QoS driver
> > + * Copyright (C) 2020, AngeloGioacchino Del Regno <kholk11@gmail.com>
> > + */
> > +
> > +#include <dt-bindings/interconnect/qcom,sdm660.h>
> > +#include <linux/clk.h>
> > +#include <linux/device.h>
> > +#include <linux/interconnect-provider.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +#include "smd-rpm.h"
> > +
> > +#define RPM_BUS_MASTER_REQ   0x73616d62
> > +#define RPM_BUS_SLAVE_REQ    0x766c7362
> > +
> > +/* BIMC QoS */
> > +#define M_BKE_REG_BASE(n)            (0x300 + (0x4000 * n))
> > +#define M_BKE_EN_ADDR(n)             (M_BKE_REG_BASE(n))
> > +#define M_BKE_HEALTH_CFG_ADDR(i, n)  (M_BKE_REG_BASE(n) + 0x40 + (0x4 =
* i))> +
> > +#define M_BKE_HEALTH_CFG_LIMITCMDS_MASK      0x80000000
> > +#define M_BKE_HEALTH_CFG_AREQPRIO_MASK       0x300
> > +#define M_BKE_HEALTH_CFG_REG_MASK(n) ((n =3D=3D 3) ? 0x303 : 0x8000030=
3)
>
> This one is not used? Maybe remove it?
>
> > +#define M_BKE_HEALTH_CFG_PRIOLVL_MASK        0x3
> > +#define M_BKE_HEALTH_CFG_AREQPRIO_SHIFT      0x8
> > +#define M_BKE_HEALTH_CFG_LIMITCMDS_SHIFT 0x1f
> > +
> > +#define M_BKE_HEALTH_CFG_ALL_MASK    (M_BKE_HEALTH_CFG_LIMITCMDS_MASK =
| \
> > +                                      M_BKE_HEALTH_CFG_AREQPRIO_MASK |=
 \
> > +                                      M_BKE_HEALTH_CFG_PRIOLVL_MASK)
> > +
> > +#define M_BKE_EN_EN_BMASK            0x1
> > +
> > +/* Valid for both NoC and BIMC */
> > +#define NOC_QOS_MODE_FIXED           0x0
> > +#define NOC_QOS_MODE_LIMITER         0x1
> > +#define NOC_QOS_MODE_BYPASS          0x2
> > +
> > +/* NoC QoS */
> > +#define NOC_PERM_MODE_FIXED          1
> > +#define NOC_PERM_MODE_BYPASS         (1 << NOC_QOS_MODE_BYPASS)
> > +
> > +#define NOC_QOS_PRIORITYn_ADDR(n)    (0x8 + (n * 0x1000))
> > +#define NOC_QOS_PRIORITY_MASK                0xf
> > +#define NOC_QOS_PRIORITY_P1_SHIFT    0x2
> > +#define NOC_QOS_PRIORITY_P0_SHIFT    0x3
> > +
> > +#define NOC_QOS_MODEn_ADDR(n)                (0xC + (n * 0x1000))
>
> Nit: Lowercase is preferred for hex values.
>
> > +#define NOC_QOS_MODEn_MASK           0x3
> > +
> > +enum {
> > +     SDM660_MASTER_IPA =3D 1,
> > +     SDM660_MASTER_CNOC_A2NOC,
> > +     SDM660_MASTER_SDCC_1,
> > +     SDM660_MASTER_SDCC_2,
> > +     SDM660_MASTER_BLSP_1,
> > +     SDM660_MASTER_BLSP_2,
> > +     SDM660_MASTER_UFS,
> > +     SDM660_MASTER_USB_HS,
> > +     SDM660_MASTER_USB3,
> > +     SDM660_MASTER_CRYPTO_C0,
> > +     SDM660_MASTER_GNOC_BIMC,
> > +     SDM660_MASTER_OXILI,
> > +     SDM660_MASTER_MNOC_BIMC,
> > +     SDM660_MASTER_SNOC_BIMC,
> > +     SDM660_MASTER_PIMEM,
> > +     SDM660_MASTER_SNOC_CNOC,
> > +     SDM660_MASTER_QDSS_DAP,
> > +     SDM660_MASTER_APPS_PROC,
> > +     SDM660_MASTER_CNOC_MNOC_MMSS_CFG,
> > +     SDM660_MASTER_CNOC_MNOC_CFG,
> > +     SDM660_MASTER_CPP,
> > +     SDM660_MASTER_JPEG,
> > +     SDM660_MASTER_MDP_P0,
> > +     SDM660_MASTER_MDP_P1,
> > +     SDM660_MASTER_VENUS,
> > +     SDM660_MASTER_VFE,
> > +     SDM660_MASTER_QDSS_ETR,
> > +     SDM660_MASTER_QDSS_BAM,
> > +     SDM660_MASTER_SNOC_CFG,
> > +     SDM660_MASTER_BIMC_SNOC,
> > +     SDM660_MASTER_A2NOC_SNOC,
> > +     SDM660_MASTER_GNOC_SNOC,
> > +
> > +     SDM660_SLAVE_A2NOC_SNOC,
> > +     SDM660_SLAVE_EBI,
> > +     SDM660_SLAVE_HMSS_L3,
> > +     SDM660_SLAVE_BIMC_SNOC,
> > +     SDM660_SLAVE_CNOC_A2NOC,
> > +     SDM660_SLAVE_MPM,
> > +     SDM660_SLAVE_PMIC_ARB,
> > +     SDM660_SLAVE_TLMM_NORTH,
> > +     SDM660_SLAVE_TCSR,
> > +     SDM660_SLAVE_PIMEM_CFG,
> > +     SDM660_SLAVE_IMEM_CFG,
> > +     SDM660_SLAVE_MESSAGE_RAM,
> > +     SDM660_SLAVE_GLM,
> > +     SDM660_SLAVE_BIMC_CFG,
> > +     SDM660_SLAVE_PRNG,
> > +     SDM660_SLAVE_SPDM,
> > +     SDM660_SLAVE_QDSS_CFG,
> > +     SDM660_SLAVE_CNOC_MNOC_CFG,
> > +     SDM660_SLAVE_SNOC_CFG,
> > +     SDM660_SLAVE_QM_CFG,
> > +     SDM660_SLAVE_CLK_CTL,
> > +     SDM660_SLAVE_MSS_CFG,
> > +     SDM660_SLAVE_TLMM_SOUTH,
> > +     SDM660_SLAVE_UFS_CFG,
> > +     SDM660_SLAVE_A2NOC_CFG,
> > +     SDM660_SLAVE_A2NOC_SMMU_CFG,
> > +     SDM660_SLAVE_GPUSS_CFG,
> > +     SDM660_SLAVE_AHB2PHY,
> > +     SDM660_SLAVE_BLSP_1,
> > +     SDM660_SLAVE_SDCC_1,
> > +     SDM660_SLAVE_SDCC_2,
> > +     SDM660_SLAVE_TLMM_CENTER,
> > +     SDM660_SLAVE_BLSP_2,
> > +     SDM660_SLAVE_PDM,
> > +     SDM660_SLAVE_CNOC_MNOC_MMSS_CFG,
> > +     SDM660_SLAVE_USB_HS,
> > +     SDM660_SLAVE_USB3_0,
> > +     SDM660_SLAVE_SRVC_CNOC,
> > +     SDM660_SLAVE_GNOC_BIMC,
> > +     SDM660_SLAVE_GNOC_SNOC,
> > +     SDM660_SLAVE_CAMERA_CFG,
> > +     SDM660_SLAVE_CAMERA_THROTTLE_CFG,
> > +     SDM660_SLAVE_MISC_CFG,
> > +     SDM660_SLAVE_VENUS_THROTTLE_CFG,
> > +     SDM660_SLAVE_VENUS_CFG,
> > +     SDM660_SLAVE_MMSS_CLK_XPU_CFG,
> > +     SDM660_SLAVE_MMSS_CLK_CFG,
> > +     SDM660_SLAVE_MNOC_MPU_CFG,
> > +     SDM660_SLAVE_DISPLAY_CFG,
> > +     SDM660_SLAVE_CSI_PHY_CFG,
> > +     SDM660_SLAVE_DISPLAY_THROTTLE_CFG,
> > +     SDM660_SLAVE_SMMU_CFG,
> > +     SDM660_SLAVE_MNOC_BIMC,
> > +     SDM660_SLAVE_SRVC_MNOC,
> > +     SDM660_SLAVE_HMSS,
> > +     SDM660_SLAVE_LPASS,
> > +     SDM660_SLAVE_WLAN,
> > +     SDM660_SLAVE_CDSP,
> > +     SDM660_SLAVE_IPA,
> > +     SDM660_SLAVE_SNOC_BIMC,
> > +     SDM660_SLAVE_SNOC_CNOC,
> > +     SDM660_SLAVE_IMEM,
> > +     SDM660_SLAVE_PIMEM,
> > +     SDM660_SLAVE_QDSS_STM,
> > +     SDM660_SLAVE_SRVC_SNOC,
> > +
> > +     SDM660_A2NOC,
> > +     SDM660_BIMC,
> > +     SDM660_CNOC,
> > +     SDM660_GNOC,
> > +     SDM660_MNOC,
> > +     SDM660_SNOC,
> > +};
> > +
> > +#define to_qcom_provider(_provider) \
> > +     container_of(_provider, struct qcom_icc_provider, provider)
> > +
> > +static const struct clk_bulk_data bus_clocks[] =3D {
> > +     { .id =3D "bus" },
> > +     { .id =3D "bus_a" },
> > +};
> > +
> > +static const struct clk_bulk_data bus_mm_clocks[] =3D {
> > +     { .id =3D "bus" },
> > +     { .id =3D "bus_a" },
> > +     { .id =3D "iface" },
> > +};
> > +
> > +/**
> > + * struct qcom_icc_provider - Qualcomm specific interconnect provider
> > + * @provider: generic interconnect provider
> > + * @bus_clks: the clk_bulk_data table of bus clocks
> > + * @num_clks: the total number of clk_bulk_data entries
> > + * @is_bimc_node: indicates whether to use bimc specific setting
> > + */
> > +struct qcom_icc_provider {
> > +     struct icc_provider provider;
> > +     struct clk_bulk_data *bus_clks;
> > +     int num_clks;
> > +     bool is_bimc_node;
> > +     struct regmap *regmap;
>
> Please describe this in the kerneldoc above.
>
> > +     void __iomem *mmio;
>
> Ditto.
>
> > +};
> > +
> > +#define SDM660_MAX_LINKS     34
> > +
> > +/**
> > + * struct qcom_icc_qos - Qualcomm specific interconnect QoS parameters
> > + * @areq_prio: node requests priority
> > + * @prio_level: priority level for bus communication
> > + * @limit_commands: activate/deactivate limiter mode during runtime
> > + * @ap_owned: indicates if the node is owned by the AP or by the RPM
> > + * @qos_mode: default qos mode for this node
> > + * @qos_port: qos port number for finding qos registers of this node
> > + */
> > +struct qcom_icc_qos {
> > +     u32 areq_prio;
> > +     u32 prio_level;
> > +     bool limit_commands;
> > +     bool ap_owned;
> > +     int qos_mode;
> > +     int qos_port;
> > +};
> > +
> > +/**
> > + * struct qcom_icc_node - Qualcomm specific interconnect nodes
> > + * @name: the node name used in debugfs
> > + * @id: a unique node identifier
> > + * @links: an array of nodes where we can go next while traversing
> > + * @num_links: the total number of @links
> > + * @buswidth: width of the interconnect between a node and the bus (by=
tes)
> > + * @mas_rpm_id:      RPM id for devices that are bus masters
> > + * @slv_rpm_id:      RPM id for devices that are bus slaves
>
> Maybe convert tabs to spaces to be consistent with the rest?
>
> > + * @qos: NoC QoS setting parameters
> > + * @rate: current bus clock rate in Hz
> > + */
> > +struct qcom_icc_node {
> > +     unsigned char *name;
> > +     u16 id;
> > +     u16 links[SDM660_MAX_LINKS];
> > +     u16 num_links;
> > +     u16 buswidth;
> > +     int mas_rpm_id;
> > +     int slv_rpm_id;
> > +     struct qcom_icc_qos qos;
> > +     u64 rate;
> > +};
> > +
> > +struct qcom_icc_desc {
> > +     struct qcom_icc_node **nodes;
> > +     size_t num_nodes;
> > +     const struct regmap_config *regmap_cfg;
> > +};
> > +
> > +#define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id, =
       \
> > +                  _ap_owned, _qos_mode, _qos_prio, _qos_port, ...)   \
> > +             static struct qcom_icc_node _name =3D {                  =
 \
> > +             .name =3D #_name,                                        =
 \
> > +             .id =3D _id,                                             =
 \
> > +             .buswidth =3D _buswidth,                                 =
 \
> > +             .mas_rpm_id =3D _mas_rpm_id,                             =
 \
> > +             .slv_rpm_id =3D _slv_rpm_id,                             =
 \
> > +             .qos.ap_owned =3D _ap_owned,                             =
 \
> > +             .qos.qos_mode =3D _qos_mode,                             =
 \
> > +             .qos.areq_prio =3D _qos_prio,                            =
 \
> > +             .qos.prio_level =3D _qos_prio,                           =
 \
> > +             .qos.qos_port =3D _qos_port,                             =
 \
> > +             .num_links =3D ARRAY_SIZE(((int[]){ __VA_ARGS__ })),     =
 \
> > +             .links =3D { __VA_ARGS__ },                              =
 \
> > +     }
> > +
> > +DEFINE_QNODE(mas_ipa, SDM660_MASTER_IPA, 8, 59, -1, true, NOC_QOS_MODE=
_FIXED, 1, 3, SDM660_SLAVE_A2NOC_SNOC);
> > +DEFINE_QNODE(mas_cnoc_a2noc, SDM660_MASTER_CNOC_A2NOC, 8, 146, -1, tru=
e, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
> > +DEFINE_QNODE(mas_sdcc_1, SDM660_MASTER_SDCC_1, 8, 33, -1, false, -1, 0=
, -1, SDM660_SLAVE_A2NOC_SNOC);
> > +DEFINE_QNODE(mas_sdcc_2, SDM660_MASTER_SDCC_2, 8, 34, -1, false, -1, 0=
, -1, SDM660_SLAVE_A2NOC_SNOC);
> > +DEFINE_QNODE(mas_blsp_1, SDM660_MASTER_BLSP_1, 4, 41, -1, false, -1, 0=
, -1, SDM660_SLAVE_A2NOC_SNOC);
> > +DEFINE_QNODE(mas_blsp_2, SDM660_MASTER_BLSP_2, 4, 39, -1, false, -1, 0=
, -1, SDM660_SLAVE_A2NOC_SNOC);
> > +DEFINE_QNODE(mas_ufs, SDM660_MASTER_UFS, 8, 68, -1, true, NOC_QOS_MODE=
_FIXED, 1, 4, SDM660_SLAVE_A2NOC_SNOC);
> > +DEFINE_QNODE(mas_usb_hs, SDM660_MASTER_USB_HS, 8, 42, -1, true, NOC_QO=
S_MODE_FIXED, 1, 1, SDM660_SLAVE_A2NOC_SNOC);
> > +DEFINE_QNODE(mas_usb3, SDM660_MASTER_USB3, 8, 32, -1, true, NOC_QOS_MO=
DE_FIXED, 1, 2, SDM660_SLAVE_A2NOC_SNOC);
> > +DEFINE_QNODE(mas_crypto, SDM660_MASTER_CRYPTO_C0, 8, 23, -1, true, NOC=
_QOS_MODE_FIXED, 1, 11, SDM660_SLAVE_A2NOC_SNOC);
> > +DEFINE_QNODE(mas_gnoc_bimc, SDM660_MASTER_GNOC_BIMC, 4, 144, -1, true,=
 NOC_QOS_MODE_FIXED, 0, 0, SDM660_SLAVE_EBI);
> > +DEFINE_QNODE(mas_oxili, SDM660_MASTER_OXILI, 4, 6, -1, true, NOC_QOS_M=
ODE_BYPASS, 0, 1, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI, SDM660_SLAVE_BIMC=
_SNOC);
> > +DEFINE_QNODE(mas_mnoc_bimc, SDM660_MASTER_MNOC_BIMC, 4, 2, -1, true, N=
OC_QOS_MODE_BYPASS, 0, 2, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI, SDM660_SL=
AVE_BIMC_SNOC);
> > +DEFINE_QNODE(mas_snoc_bimc, SDM660_MASTER_SNOC_BIMC, 4, 3, -1, false, =
-1, 0, -1, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI);
> > +DEFINE_QNODE(mas_pimem, SDM660_MASTER_PIMEM, 4, 113, -1, true, NOC_QOS=
_MODE_FIXED, 1, 4, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI);
> > +DEFINE_QNODE(mas_snoc_cnoc, SDM660_MASTER_SNOC_CNOC, 8, 52, -1, true, =
-1, 0, -1, SDM660_SLAVE_CLK_CTL, SDM660_SLAVE_QDSS_CFG, SDM660_SLAVE_QM_CFG=
, SDM660_SLAVE_SRVC_CNOC, SDM660_SLAVE_UFS_CFG, SDM660_SLAVE_TCSR, SDM660_S=
LAVE_A2NOC_SMMU_CFG, SDM660_SLAVE_SNOC_CFG, SDM660_SLAVE_TLMM_SOUTH, SDM660=
_SLAVE_MPM, SDM660_SLAVE_CNOC_MNOC_MMSS_CFG, SDM660_SLAVE_SDCC_2, SDM660_SL=
AVE_SDCC_1, SDM660_SLAVE_SPDM, SDM660_SLAVE_PMIC_ARB, SDM660_SLAVE_PRNG, SD=
M660_SLAVE_MSS_CFG, SDM660_SLAVE_GPUSS_CFG, SDM660_SLAVE_IMEM_CFG, SDM660_S=
LAVE_USB3_0, SDM660_SLAVE_A2NOC_CFG, SDM660_SLAVE_TLMM_NORTH, SDM660_SLAVE_=
USB_HS, SDM660_SLAVE_PDM, SDM660_SLAVE_TLMM_CENTER, SDM660_SLAVE_AHB2PHY, S=
DM660_SLAVE_BLSP_2, SDM660_SLAVE_BLSP_1, SDM660_SLAVE_PIMEM_CFG, SDM660_SLA=
VE_GLM, SDM660_SLAVE_MESSAGE_RAM, SDM660_SLAVE_BIMC_CFG, SDM660_SLAVE_CNOC_=
MNOC_CFG);
> > +DEFINE_QNODE(mas_qdss_dap, SDM660_MASTER_QDSS_DAP, 8, 49, -1, true, -1=
, 0, -1, SDM660_SLAVE_CLK_CTL, SDM660_SLAVE_QDSS_CFG, SDM660_SLAVE_QM_CFG, =
SDM660_SLAVE_SRVC_CNOC, SDM660_SLAVE_UFS_CFG, SDM660_SLAVE_TCSR, SDM660_SLA=
VE_A2NOC_SMMU_CFG, SDM660_SLAVE_SNOC_CFG, SDM660_SLAVE_TLMM_SOUTH, SDM660_S=
LAVE_MPM, SDM660_SLAVE_CNOC_MNOC_MMSS_CFG, SDM660_SLAVE_SDCC_2, SDM660_SLAV=
E_SDCC_1, SDM660_SLAVE_SPDM, SDM660_SLAVE_PMIC_ARB, SDM660_SLAVE_PRNG, SDM6=
60_SLAVE_MSS_CFG, SDM660_SLAVE_GPUSS_CFG, SDM660_SLAVE_IMEM_CFG, SDM660_SLA=
VE_USB3_0, SDM660_SLAVE_A2NOC_CFG, SDM660_SLAVE_TLMM_NORTH, SDM660_SLAVE_US=
B_HS, SDM660_SLAVE_PDM, SDM660_SLAVE_TLMM_CENTER, SDM660_SLAVE_AHB2PHY, SDM=
660_SLAVE_BLSP_2, SDM660_SLAVE_BLSP_1, SDM660_SLAVE_PIMEM_CFG, SDM660_SLAVE=
_GLM, SDM660_SLAVE_MESSAGE_RAM, SDM660_SLAVE_CNOC_A2NOC, SDM660_SLAVE_BIMC_=
CFG, SDM660_SLAVE_CNOC_MNOC_CFG);
> > +DEFINE_QNODE(mas_apss_proc, SDM660_MASTER_APPS_PROC, 16, 0, -1, true, =
-1, 0, -1, SDM660_SLAVE_GNOC_SNOC, SDM660_SLAVE_GNOC_BIMC);
> > +DEFINE_QNODE(mas_cnoc_mnoc_mmss_cfg, SDM660_MASTER_CNOC_MNOC_MMSS_CFG,=
 8, 4, -1, true, -1, 0, -1, SDM660_SLAVE_VENUS_THROTTLE_CFG, SDM660_SLAVE_V=
ENUS_CFG, SDM660_SLAVE_CAMERA_THROTTLE_CFG, SDM660_SLAVE_SMMU_CFG, SDM660_S=
LAVE_CAMERA_CFG, SDM660_SLAVE_CSI_PHY_CFG, SDM660_SLAVE_DISPLAY_THROTTLE_CF=
G, SDM660_SLAVE_DISPLAY_CFG, SDM660_SLAVE_MMSS_CLK_CFG, SDM660_SLAVE_MNOC_M=
PU_CFG, SDM660_SLAVE_MISC_CFG, SDM660_SLAVE_MMSS_CLK_XPU_CFG);
> > +DEFINE_QNODE(mas_cnoc_mnoc_cfg, SDM660_MASTER_CNOC_MNOC_CFG, 4, 5, -1,=
 true, -1, 0, -1, SDM660_SLAVE_SRVC_MNOC);
> > +DEFINE_QNODE(mas_cpp, SDM660_MASTER_CPP, 16, 115, -1, true, NOC_QOS_MO=
DE_BYPASS, 0, 4, SDM660_SLAVE_MNOC_BIMC);
> > +DEFINE_QNODE(mas_jpeg, SDM660_MASTER_JPEG, 16, 7, -1, true, NOC_QOS_MO=
DE_BYPASS, 0, 6, SDM660_SLAVE_MNOC_BIMC);
> > +DEFINE_QNODE(mas_mdp_p0, SDM660_MASTER_MDP_P0, 16, 8, -1, true, NOC_QO=
S_MODE_BYPASS, 0, 0, SDM660_SLAVE_MNOC_BIMC); /* vrail-comp???? */
> > +DEFINE_QNODE(mas_mdp_p1, SDM660_MASTER_MDP_P1, 16, 61, -1, true, NOC_Q=
OS_MODE_BYPASS, 0, 1, SDM660_SLAVE_MNOC_BIMC); /* vrail-comp??? */
> > +DEFINE_QNODE(mas_venus, SDM660_MASTER_VENUS, 16, 9, -1, true, NOC_QOS_=
MODE_BYPASS, 0, 1, SDM660_SLAVE_MNOC_BIMC);
> > +DEFINE_QNODE(mas_vfe, SDM660_MASTER_VFE, 16, 11, -1, true, NOC_QOS_MOD=
E_BYPASS, 0, 5, SDM660_SLAVE_MNOC_BIMC);
> > +DEFINE_QNODE(mas_qdss_etr, SDM660_MASTER_QDSS_ETR, 8, 31, -1, true, NO=
C_QOS_MODE_FIXED, 1, 1, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IMEM, SDM660_SLAVE=
_SNOC_CNOC, SDM660_SLAVE_SNOC_BIMC);
> > +DEFINE_QNODE(mas_qdss_bam, SDM660_MASTER_QDSS_BAM, 4, 19, -1, true, NO=
C_QOS_MODE_FIXED, 1, 0, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IMEM, SDM660_SLAVE=
_SNOC_CNOC, SDM660_SLAVE_SNOC_BIMC);
> > +DEFINE_QNODE(mas_snoc_cfg, SDM660_MASTER_SNOC_CFG, 4, 20, -1, false, -=
1, 0, -1, SDM660_SLAVE_SRVC_SNOC);
> > +DEFINE_QNODE(mas_bimc_snoc, SDM660_MASTER_BIMC_SNOC, 8, 21, -1, false,=
 -1, 0, -1, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IPA, SDM660_SLAVE_QDSS_STM, SD=
M660_SLAVE_LPASS, SDM660_SLAVE_HMSS, SDM660_SLAVE_CDSP, SDM660_SLAVE_SNOC_C=
NOC, SDM660_SLAVE_WLAN, SDM660_SLAVE_IMEM);
> > +DEFINE_QNODE(mas_gnoc_snoc, SDM660_MASTER_GNOC_SNOC, 8, 150, -1, false=
, -1, 0, -1, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IPA, SDM660_SLAVE_QDSS_STM, S=
DM660_SLAVE_LPASS, SDM660_SLAVE_HMSS, SDM660_SLAVE_CDSP, SDM660_SLAVE_SNOC_=
CNOC, SDM660_SLAVE_WLAN, SDM660_SLAVE_IMEM);
> > +DEFINE_QNODE(mas_a2noc_snoc, SDM660_MASTER_A2NOC_SNOC, 16, 112, -1, fa=
lse, -1, 0, -1, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IPA, SDM660_SLAVE_QDSS_STM=
, SDM660_SLAVE_LPASS, SDM660_SLAVE_HMSS, SDM660_SLAVE_SNOC_BIMC, SDM660_SLA=
VE_CDSP, SDM660_SLAVE_SNOC_CNOC, SDM660_SLAVE_WLAN, SDM660_SLAVE_IMEM);
> > +DEFINE_QNODE(slv_a2noc_snoc, SDM660_SLAVE_A2NOC_SNOC, 16, -1, 143, fal=
se, -1, 0, -1, SDM660_MASTER_A2NOC_SNOC);
> > +DEFINE_QNODE(slv_ebi, SDM660_SLAVE_EBI, 4, -1, 0, false, -1, 0, -1, 0)=
;
> > +DEFINE_QNODE(slv_hmss_l3, SDM660_SLAVE_HMSS_L3, 4, -1, 160, false, -1,=
 0, -1, 0);
> > +DEFINE_QNODE(slv_bimc_snoc, SDM660_SLAVE_BIMC_SNOC, 4, -1, 2, false, -=
1, 0, -1, SDM660_MASTER_BIMC_SNOC);
> > +DEFINE_QNODE(slv_cnoc_a2noc, SDM660_SLAVE_CNOC_A2NOC, 8, -1, 208, true=
, -1, 0, -1, SDM660_MASTER_CNOC_A2NOC);
> > +DEFINE_QNODE(slv_mpm, SDM660_SLAVE_MPM, 4, -1, 62, true, -1, 0, -1, 0)=
;
> > +DEFINE_QNODE(slv_pmic_arb, SDM660_SLAVE_PMIC_ARB, 4, -1, 59, true, -1,=
 0, -1, 0);
> > +DEFINE_QNODE(slv_tlmm_north, SDM660_SLAVE_TLMM_NORTH, 8, -1, 214, true=
, -1, 0, -1, 0);
> > +DEFINE_QNODE(slv_tcsr, SDM660_SLAVE_TCSR, 4, -1, 50, true, -1, 0, -1, =
0);
> > +DEFINE_QNODE(slv_pimem_cfg, SDM660_SLAVE_PIMEM_CFG, 4, -1, 167, true, =
-1, 0, -1, 0);
> > +DEFINE_QNODE(slv_imem_cfg, SDM660_SLAVE_IMEM_CFG, 4, -1, 54, true, -1,=
 0, -1, 0);
> > +DEFINE_QNODE(slv_message_ram, SDM660_SLAVE_MESSAGE_RAM, 4, -1, 55, tru=
e, -1, 0, -1, 0);
> > +DEFINE_QNODE(slv_glm, SDM660_SLAVE_GLM, 4, -1, 209, true, -1, 0, -1, 0=
);
> > +DEFINE_QNODE(slv_bimc_cfg, SDM660_SLAVE_BIMC_CFG, 4, -1, 56, true, -1,=
 0, -1, 0);
> > +DEFINE_QNODE(slv_prng, SDM660_SLAVE_PRNG, 4, -1, 44, true, -1, 0, -1, =
0);
> > +DEFINE_QNODE(slv_spdm, SDM660_SLAVE_SPDM, 4, -1, 60, true, -1, 0, -1, =
0);
> > +DEFINE_QNODE(slv_qdss_cfg, SDM660_SLAVE_QDSS_CFG, 4, -1, 63, true, -1,=
 0, -1, 0);
> > +DEFINE_QNODE(slv_cnoc_mnoc_cfg, SDM660_SLAVE_BLSP_1, 4, -1, 66, true, =
-1, 0, -1, SDM660_MASTER_CNOC_MNOC_CFG);
> > +DEFINE_QNODE(slv_snoc_cfg, SDM660_SLAVE_SNOC_CFG, 4, -1, 70, true, -1,=
 0, -1, 0);
> > +DEFINE_QNODE(slv_qm_cfg, SDM660_SLAVE_QM_CFG, 4, -1, 212, true, -1, 0,=
 -1, 0);
> > +DEFINE_QNODE(slv_clk_ctl, SDM660_SLAVE_CLK_CTL, 4, -1, 47, true, -1, 0=
, -1, 0);
> > +DEFINE_QNODE(slv_mss_cfg, SDM660_SLAVE_MSS_CFG, 4, -1, 48, true, -1, 0=
, -1, 0);
> > +DEFINE_QNODE(slv_tlmm_south, SDM660_SLAVE_TLMM_SOUTH, 4, -1, 217, true=
, -1, 0, -1, 0);
> > +DEFINE_QNODE(slv_ufs_cfg, SDM660_SLAVE_UFS_CFG, 4, -1, 92, true, -1, 0=
, -1, 0);
> > +DEFINE_QNODE(slv_a2noc_cfg, SDM660_SLAVE_A2NOC_CFG, 4, -1, 150, true, =
-1, 0, -1, 0);
> > +DEFINE_QNODE(slv_a2noc_smmu_cfg, SDM660_SLAVE_A2NOC_SMMU_CFG, 8, -1, 1=
52, true, -1, 0, -1, 0);
> > +DEFINE_QNODE(slv_gpuss_cfg, SDM660_SLAVE_GPUSS_CFG, 8, -1, 11, true, -=
1, 0, -1, 0);
> > +DEFINE_QNODE(slv_ahb2phy, SDM660_SLAVE_AHB2PHY, 4, -1, 163, true, -1, =
0, -1, 0);
> > +DEFINE_QNODE(slv_blsp_1, SDM660_SLAVE_BLSP_1, 4, -1, 39, true, -1, 0, =
-1, 0);
> > +DEFINE_QNODE(slv_sdcc_1, SDM660_SLAVE_SDCC_1, 4, -1, 31, true, -1, 0, =
-1, 0);
> > +DEFINE_QNODE(slv_sdcc_2, SDM660_SLAVE_SDCC_2, 4, -1, 32, true, -1, 0, =
-1, 0);
> > +DEFINE_QNODE(slv_tlmm_center, SDM660_SLAVE_TLMM_CENTER, 4, -1, 218, tr=
ue, -1, 0, -1, 0);
> > +DEFINE_QNODE(slv_blsp_2, SDM660_SLAVE_BLSP_2, 4, -1, 37, true, -1, 0, =
-1, 0);
> > +DEFINE_QNODE(slv_pdm, SDM660_SLAVE_PDM, 4, -1, 41, true, -1, 0, -1, 0)=
;
> > +DEFINE_QNODE(slv_cnoc_mnoc_mmss_cfg, SDM660_SLAVE_CNOC_MNOC_MMSS_CFG, =
8, -1, 58, true, -1, 0, -1, SDM660_MASTER_CNOC_MNOC_MMSS_CFG);
> > +DEFINE_QNODE(slv_usb_hs, SDM660_SLAVE_USB_HS, 4, -1, 40, true, -1, 0, =
-1, 0);
> > +DEFINE_QNODE(slv_usb3_0, SDM660_SLAVE_USB3_0, 4, -1, 22, true, -1, 0, =
-1, 0);
> > +DEFINE_QNODE(slv_srvc_cnoc, SDM660_SLAVE_SRVC_CNOC, 4, -1, 76, true, -=
1, 0, -1, 0);
> > +DEFINE_QNODE(slv_gnoc_bimc, SDM660_SLAVE_GNOC_BIMC, 16, -1, 210, true,=
 -1, 0, -1, SDM660_MASTER_GNOC_BIMC);
> > +DEFINE_QNODE(slv_gnoc_snoc, SDM660_SLAVE_GNOC_SNOC, 8, -1, 211, true, =
-1, 0, -1, SDM660_MASTER_GNOC_SNOC);
> > +DEFINE_QNODE(slv_camera_cfg, SDM660_SLAVE_CAMERA_CFG, 4, -1, 3, true, =
-1, 0, -1, 0);
> > +DEFINE_QNODE(slv_camera_throttle_cfg, SDM660_SLAVE_CAMERA_THROTTLE_CFG=
, 4, -1, 154, true, -1, 0, -1, 0);
> > +DEFINE_QNODE(slv_misc_cfg, SDM660_SLAVE_MISC_CFG, 4, -1, 8, true, -1, =
0, -1, 0);
> > +DEFINE_QNODE(slv_venus_throttle_cfg, SDM660_SLAVE_VENUS_THROTTLE_CFG, =
4, -1, 178, true, -1, 0, -1, 0);
> > +DEFINE_QNODE(slv_venus_cfg, SDM660_SLAVE_VENUS_CFG, 4, -1, 10, true, -=
1, 0, -1, 0);
> > +DEFINE_QNODE(slv_mmss_clk_xpu_cfg, SDM660_SLAVE_MMSS_CLK_XPU_CFG, 4, -=
1, 13, true, -1, 0, -1, 0);
> > +DEFINE_QNODE(slv_mmss_clk_cfg, SDM660_SLAVE_MMSS_CLK_CFG, 4, -1, 12, t=
rue, -1, 0, -1, 0);
> > +DEFINE_QNODE(slv_mnoc_mpu_cfg, SDM660_SLAVE_MNOC_MPU_CFG, 4, -1, 14, t=
rue, -1, 0, -1, 0);
> > +DEFINE_QNODE(slv_display_cfg, SDM660_SLAVE_DISPLAY_CFG, 4, -1, 4, true=
, -1, 0, -1, 0);
> > +DEFINE_QNODE(slv_csi_phy_cfg, SDM660_SLAVE_CSI_PHY_CFG, 4, -1, 224, tr=
ue, -1, 0, -1, 0);
> > +DEFINE_QNODE(slv_display_throttle_cfg, SDM660_SLAVE_DISPLAY_THROTTLE_C=
FG, 4, -1, 156, true, -1, 0, -1, 0);
> > +DEFINE_QNODE(slv_smmu_cfg, SDM660_SLAVE_SMMU_CFG, 8, -1, 205, true, -1=
, 0, -1, 0);
> > +DEFINE_QNODE(slv_mnoc_bimc, SDM660_SLAVE_MNOC_BIMC, 16, -1, 16, true, =
-1, 0, -1, SDM660_MASTER_MNOC_BIMC);
> > +DEFINE_QNODE(slv_srvc_mnoc, SDM660_SLAVE_SRVC_MNOC, 8, -1, 17, true, -=
1, 0, -1, 0);
> > +DEFINE_QNODE(slv_hmss, SDM660_SLAVE_HMSS, 8, -1, 20, true, -1, 0, -1, =
0);
> > +DEFINE_QNODE(slv_lpass, SDM660_SLAVE_LPASS, 4, -1, 21, true, -1, 0, -1=
, 0);
> > +DEFINE_QNODE(slv_wlan, SDM660_SLAVE_WLAN, 4, -1, 206, false, -1, 0, -1=
, 0);
> > +DEFINE_QNODE(slv_cdsp, SDM660_SLAVE_CDSP, 4, -1, 221, true, -1, 0, -1,=
 0);
> > +DEFINE_QNODE(slv_ipa, SDM660_SLAVE_IPA, 4, -1, 183, true, -1, 0, -1, 0=
);
> > +DEFINE_QNODE(slv_snoc_bimc, SDM660_SLAVE_SNOC_BIMC, 16, -1, 24, false,=
 -1, 0, -1, SDM660_MASTER_SNOC_BIMC);
> > +DEFINE_QNODE(slv_snoc_cnoc, SDM660_SLAVE_SNOC_CNOC, 8, -1, 25, false, =
-1, 0, -1, SDM660_MASTER_SNOC_CNOC);
> > +DEFINE_QNODE(slv_imem, SDM660_SLAVE_IMEM, 8, -1, 26, false, -1, 0, -1,=
 0);
> > +DEFINE_QNODE(slv_pimem, SDM660_SLAVE_PIMEM, 8, -1, 166, false, -1, 0, =
-1, 0);
> > +DEFINE_QNODE(slv_qdss_stm, SDM660_SLAVE_QDSS_STM, 4, -1, 30, false, -1=
, 0, -1, 0);
> > +DEFINE_QNODE(slv_srvc_snoc, SDM660_SLAVE_SRVC_SNOC, 16, -1, 29, false,=
 -1, 0, -1, 0);
> > +
> > +static struct qcom_icc_node *sdm660_a2noc_nodes[] =3D {
> > +     [MASTER_IPA] =3D &mas_ipa,
> > +     [MASTER_CNOC_A2NOC] =3D &mas_cnoc_a2noc,
> > +     [MASTER_SDCC_1] =3D &mas_sdcc_1,
> > +     [MASTER_SDCC_2] =3D &mas_sdcc_2,
> > +     [MASTER_BLSP_1] =3D &mas_blsp_1,
> > +     [MASTER_BLSP_2] =3D &mas_blsp_2,
> > +     [MASTER_UFS] =3D &mas_ufs,
> > +     [MASTER_USB_HS] =3D &mas_usb_hs,
> > +     [MASTER_USB3] =3D &mas_usb3,
> > +     [MASTER_CRYPTO_C0] =3D &mas_crypto,
> > +     [SLAVE_A2NOC_SNOC] =3D &slv_a2noc_snoc,
> > +};
> > +
> > +static const struct regmap_config sdm660_a2noc_regmap_config =3D {
> > +     .reg_bits       =3D 32,
> > +     .reg_stride     =3D 4,
> > +     .val_bits       =3D 32,
> > +     .max_register   =3D 0x20000,
> > +     .fast_io        =3D true,
> > +};
> > +
> > +static struct qcom_icc_desc sdm660_a2noc =3D {
> > +     .nodes =3D sdm660_a2noc_nodes,
> > +     .num_nodes =3D ARRAY_SIZE(sdm660_a2noc_nodes),
> > +     .regmap_cfg =3D &sdm660_a2noc_regmap_config,
> > +};
> > +
> > +static struct qcom_icc_node *sdm660_bimc_nodes[] =3D {
> > +     [MASTER_GNOC_BIMC] =3D &mas_gnoc_bimc,
> > +     [MASTER_OXILI] =3D &mas_oxili,
> > +     [MASTER_MNOC_BIMC] =3D &mas_mnoc_bimc,
> > +     [MASTER_SNOC_BIMC] =3D &mas_snoc_bimc,
> > +     [MASTER_PIMEM] =3D &mas_pimem,
> > +     [SLAVE_EBI] =3D &slv_ebi,
> > +     [SLAVE_HMSS_L3] =3D &slv_hmss_l3,
> > +     [SLAVE_BIMC_SNOC] =3D &slv_bimc_snoc,
> > +};
> > +
> > +static const struct regmap_config sdm660_bimc_regmap_config =3D {
> > +     .reg_bits       =3D 32,
> > +     .reg_stride     =3D 4,
> > +     .val_bits       =3D 32,
> > +     .max_register   =3D 0x80000,
> > +     .fast_io        =3D true,
> > +};
> > +
> > +static struct qcom_icc_desc sdm660_bimc =3D {
> > +     .nodes =3D sdm660_bimc_nodes,
> > +     .num_nodes =3D ARRAY_SIZE(sdm660_bimc_nodes),
> > +     .regmap_cfg =3D &sdm660_bimc_regmap_config,
> > +};
> > +
> > +static struct qcom_icc_node *sdm660_cnoc_nodes[] =3D {
> > +     [MASTER_SNOC_CNOC] =3D &mas_snoc_cnoc,
> > +     [MASTER_QDSS_DAP] =3D &mas_qdss_dap,
> > +     [SLAVE_CNOC_A2NOC] =3D &slv_cnoc_a2noc,
> > +     [SLAVE_MPM] =3D &slv_mpm,
> > +     [SLAVE_PMIC_ARB] =3D &slv_pmic_arb,
> > +     [SLAVE_TLMM_NORTH] =3D &slv_tlmm_north,
> > +     [SLAVE_TCSR] =3D &slv_tcsr,
> > +     [SLAVE_PIMEM_CFG] =3D &slv_pimem_cfg,
> > +     [SLAVE_IMEM_CFG] =3D &slv_imem_cfg,
> > +     [SLAVE_MESSAGE_RAM] =3D &slv_message_ram,
> > +     [SLAVE_GLM] =3D &slv_glm,
> > +     [SLAVE_BIMC_CFG] =3D &slv_bimc_cfg,
> > +     [SLAVE_PRNG] =3D &slv_prng,
> > +     [SLAVE_SPDM] =3D &slv_spdm,
> > +     [SLAVE_QDSS_CFG] =3D &slv_qdss_cfg,
> > +     [SLAVE_CNOC_MNOC_CFG] =3D &slv_cnoc_mnoc_cfg,
> > +     [SLAVE_SNOC_CFG] =3D &slv_snoc_cfg,
> > +     [SLAVE_QM_CFG] =3D &slv_qm_cfg,
> > +     [SLAVE_CLK_CTL] =3D &slv_clk_ctl,
> > +     [SLAVE_MSS_CFG] =3D &slv_mss_cfg,
> > +     [SLAVE_TLMM_SOUTH] =3D &slv_tlmm_south,
> > +     [SLAVE_UFS_CFG] =3D &slv_ufs_cfg,
> > +     [SLAVE_A2NOC_CFG] =3D &slv_a2noc_cfg,
> > +     [SLAVE_A2NOC_SMMU_CFG] =3D &slv_a2noc_smmu_cfg,
> > +     [SLAVE_GPUSS_CFG] =3D &slv_gpuss_cfg,
> > +     [SLAVE_AHB2PHY] =3D &slv_ahb2phy,
> > +     [SLAVE_BLSP_1] =3D &slv_blsp_1,
> > +     [SLAVE_SDCC_1] =3D &slv_sdcc_1,
> > +     [SLAVE_SDCC_2] =3D &slv_sdcc_2,
> > +     [SLAVE_TLMM_CENTER] =3D &slv_tlmm_center,
> > +     [SLAVE_BLSP_2] =3D &slv_blsp_2,
> > +     [SLAVE_PDM] =3D &slv_pdm,
> > +     [SLAVE_CNOC_MNOC_MMSS_CFG] =3D &slv_cnoc_mnoc_mmss_cfg,
> > +     [SLAVE_USB_HS] =3D &slv_usb_hs,
> > +     [SLAVE_USB3_0] =3D &slv_usb3_0,
> > +     [SLAVE_SRVC_CNOC] =3D &slv_srvc_cnoc,
> > +};
> > +
> > +static const struct regmap_config sdm660_cnoc_regmap_config =3D {
> > +     .reg_bits       =3D 32,
> > +     .reg_stride     =3D 4,
> > +     .val_bits       =3D 32,
> > +     .max_register   =3D 0x10000,
> > +     .fast_io        =3D true,
> > +};
> > +
> > +static struct qcom_icc_desc sdm660_cnoc =3D {
> > +     .nodes =3D sdm660_cnoc_nodes,
> > +     .num_nodes =3D ARRAY_SIZE(sdm660_cnoc_nodes),
> > +     .regmap_cfg =3D &sdm660_cnoc_regmap_config,
> > +};
> > +
> > +static struct qcom_icc_node *sdm660_gnoc_nodes[] =3D {
> > +     [MASTER_APSS_PROC] =3D &mas_apss_proc,
> > +     [SLAVE_GNOC_BIMC] =3D &slv_gnoc_bimc,
> > +     [SLAVE_GNOC_SNOC] =3D &slv_gnoc_snoc,
> > +};
> > +
> > +static const struct regmap_config sdm660_gnoc_regmap_config =3D {
> > +     .reg_bits       =3D 32,
> > +     .reg_stride     =3D 4,
> > +     .val_bits       =3D 32,
> > +     .max_register   =3D 0xe000,
> > +     .fast_io        =3D true,
> > +};
> > +
> > +static struct qcom_icc_desc sdm660_gnoc =3D {
> > +     .nodes =3D sdm660_gnoc_nodes,
> > +     .num_nodes =3D ARRAY_SIZE(sdm660_gnoc_nodes),
> > +     .regmap_cfg =3D &sdm660_gnoc_regmap_config,
> > +};
> > +
> > +static struct qcom_icc_node *sdm660_mnoc_nodes[] =3D {
> > +     [MASTER_CPP] =3D &mas_cpp,
> > +     [MASTER_JPEG] =3D &mas_jpeg,
> > +     [MASTER_MDP_P0] =3D &mas_mdp_p0,
> > +     [MASTER_MDP_P1] =3D &mas_mdp_p1,
> > +     [MASTER_VENUS] =3D &mas_venus,
> > +     [MASTER_VFE] =3D &mas_vfe,
> > +     [MASTER_CNOC_MNOC_MMSS_CFG] =3D &mas_cnoc_mnoc_mmss_cfg,
> > +     [MASTER_CNOC_MNOC_CFG] =3D &mas_cnoc_mnoc_cfg,
> > +     [SLAVE_CAMERA_CFG] =3D &slv_camera_cfg,
> > +     [SLAVE_CAMERA_THROTTLE_CFG] =3D &slv_camera_throttle_cfg,
> > +     [SLAVE_MISC_CFG] =3D &slv_misc_cfg,
> > +     [SLAVE_VENUS_THROTTLE_CFG] =3D &slv_venus_throttle_cfg,
> > +     [SLAVE_VENUS_CFG] =3D &slv_venus_cfg,
> > +     [SLAVE_MMSS_CLK_XPU_CFG] =3D &slv_mmss_clk_xpu_cfg,
> > +     [SLAVE_MMSS_CLK_CFG] =3D &slv_mmss_clk_cfg,
> > +     [SLAVE_MNOC_MPU_CFG] =3D &slv_mnoc_mpu_cfg,
> > +     [SLAVE_DISPLAY_CFG] =3D &slv_display_cfg,
> > +     [SLAVE_CSI_PHY_CFG] =3D &slv_csi_phy_cfg,
> > +     [SLAVE_DISPLAY_THROTTLE_CFG] =3D &slv_display_throttle_cfg,
> > +     [SLAVE_SMMU_CFG] =3D &slv_smmu_cfg,
> > +     [SLAVE_SRVC_MNOC] =3D &slv_srvc_mnoc,
> > +     [SLAVE_MNOC_BIMC] =3D &slv_mnoc_bimc,
> > +};
> > +
> > +static const struct regmap_config sdm660_mnoc_regmap_config =3D {
> > +     .reg_bits       =3D 32,
> > +     .reg_stride     =3D 4,
> > +     .val_bits       =3D 32,
> > +     .max_register   =3D 0x10000,
> > +     .fast_io        =3D true,
> > +};
> > +
> > +static struct qcom_icc_desc sdm660_mnoc =3D {
> > +     .nodes =3D sdm660_mnoc_nodes,
> > +     .num_nodes =3D ARRAY_SIZE(sdm660_mnoc_nodes),
> > +     .regmap_cfg =3D &sdm660_mnoc_regmap_config,
> > +};
> > +
> > +static struct qcom_icc_node *sdm660_snoc_nodes[] =3D {
> > +     [MASTER_QDSS_ETR] =3D &mas_qdss_etr,
> > +     [MASTER_QDSS_BAM] =3D &mas_qdss_bam,
> > +     [MASTER_SNOC_CFG] =3D &mas_snoc_cfg,
> > +     [MASTER_BIMC_SNOC] =3D &mas_bimc_snoc,
> > +     [MASTER_A2NOC_SNOC] =3D &mas_a2noc_snoc,
> > +     [MASTER_GNOC_SNOC] =3D &mas_gnoc_snoc,
> > +     [SLAVE_HMSS] =3D &slv_hmss,
> > +     [SLAVE_LPASS] =3D &slv_lpass,
> > +     [SLAVE_WLAN] =3D &slv_wlan,
> > +     [SLAVE_CDSP] =3D &slv_cdsp,
> > +     [SLAVE_IPA] =3D &slv_ipa,
> > +     [SLAVE_SNOC_BIMC] =3D &slv_snoc_bimc,
> > +     [SLAVE_SNOC_CNOC] =3D &slv_snoc_cnoc,
> > +     [SLAVE_IMEM] =3D &slv_imem,
> > +     [SLAVE_PIMEM] =3D &slv_pimem,
> > +     [SLAVE_QDSS_STM] =3D &slv_qdss_stm,
> > +     [SLAVE_SRVC_SNOC] =3D &slv_srvc_snoc,
> > +};
> > +
> > +static const struct regmap_config sdm660_snoc_regmap_config =3D {
> > +     .reg_bits       =3D 32,
> > +     .reg_stride     =3D 4,
> > +     .val_bits       =3D 32,
> > +     .max_register   =3D 0x20000,
> > +     .fast_io        =3D true,
> > +};
> > +
> > +static struct qcom_icc_desc sdm660_snoc =3D {
> > +     .nodes =3D sdm660_snoc_nodes,
> > +     .num_nodes =3D ARRAY_SIZE(sdm660_snoc_nodes),
> > +     .regmap_cfg =3D &sdm660_snoc_regmap_config,
> > +};
> > +
> > +static int qcom_icc_bimc_set_qos_health(struct regmap *rmap,
> > +                             struct qcom_icc_qos *qos, int reg_num)
>
> Nit: Please align to the open parenthesis.
>
> > +{
> > +     u32 val;
> > +
> > +     val =3D qos->limit_commands << M_BKE_HEALTH_CFG_LIMITCMDS_SHIFT;
> > +     val |=3D qos->areq_prio << M_BKE_HEALTH_CFG_AREQPRIO_SHIFT;
> > +     val |=3D qos->prio_level;
> > +
> > +     return regmap_update_bits(rmap,
> > +                             M_BKE_HEALTH_CFG_ADDR(reg_num, qos->qos_p=
ort),
> > +                             M_BKE_HEALTH_CFG_ALL_MASK, val);
> > +}
> > +
> > +static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw,
> > +                              bool bypass_mode)> +{
> > +     struct qcom_icc_provider *qp;
> > +     struct qcom_icc_node *qn;
> > +     struct icc_provider *provider;
> > +     u32 mode =3D NOC_QOS_MODE_BYPASS;
> > +     u32 val =3D 0;
> > +     int i, rc =3D 0;
> > +
> > +     qn =3D src->data;
> > +     provider =3D src->provider;
> > +     qp =3D to_qcom_provider(provider);
> > +
> > +     if (qn->qos.qos_mode !=3D -1)
> > +             mode =3D qn->qos.qos_mode;
> > +
> > +     /* QoS Priority: The QoS Health parameters are getting considered
> > +      * only if we are NOT in Bypass Mode.
> > +      */
> > +     if (mode !=3D NOC_QOS_MODE_BYPASS) {
> > +             for (i =3D 3; i >=3D 0; i--) {
> > +                     rc =3D qcom_icc_bimc_set_qos_health(qp->regmap,
> > +                                                       &qn->qos, i);
> > +                     if (rc)
> > +                             return rc;
> > +             }
> > +
> > +             /* Set BKE_EN to 1 when Fixed, Regulator or Limiter Mode =
*/
> > +             val =3D 1;
> > +     }
> > +
> > +     return regmap_update_bits(qp->regmap, M_BKE_EN_ADDR(qn->qos.qos_p=
ort),
> > +                               M_BKE_EN_EN_BMASK, val);
> > +}
> > +
> > +static int qcom_icc_noc_set_qos_priority(struct regmap *rmap,
> > +                             struct qcom_icc_qos *qos)
>
> Nit: Please align to the open parenthesis.
>
> > +{
> > +     u32 val;
> > +     int rc;
> > +
> > +     /* Must be updated one at a time, P1 first, P0 last */
> > +     val =3D qos->areq_prio << NOC_QOS_PRIORITY_P1_SHIFT;
> > +     rc =3D regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_p=
ort),
> > +                             NOC_QOS_PRIORITY_MASK, val);
> > +     if (rc)
> > +             return rc;
> > +
> > +     val =3D qos->prio_level << NOC_QOS_PRIORITY_P0_SHIFT;
> > +     return regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_p=
ort),
> > +                               NOC_QOS_PRIORITY_MASK, val);> +}
> > +
> > +static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
> > +{
> > +
>
> Blank line? Please remove.
>
> > +     struct qcom_icc_provider *qp;
> > +     struct qcom_icc_node *qn;
> > +     struct icc_provider *provider;
> > +     u32 mode =3D NOC_QOS_MODE_BYPASS;
> > +     int rc =3D 0;
> > +
> > +     qn =3D src->data;
> > +     provider =3D src->provider;
> > +     qp =3D to_qcom_provider(provider);
> > +
> > +     if (qn->qos.qos_port < 0) {
> > +             dev_dbg(src->provider->dev, "NoC QoS: Skipping %s: "
> > +                     "vote gets aggregated on its parent.\n", qn->name=
);
>
> Nit: Would be nice if we can keep the quoted string on a single line.
>
> > +             return 0;
> > +     }
> > +
> > +     if (qn->qos.qos_mode !=3D -1)
> > +             mode =3D qn->qos.qos_mode;
> > +
> > +     if (mode =3D=3D NOC_QOS_MODE_FIXED) {
> > +             dev_dbg(src->provider->dev, "NoC QoS: %s: Set Fixed mode\=
n",
> > +                     qn->name);
> > +             rc =3D qcom_icc_noc_set_qos_priority(qp->regmap, &qn->qos=
);
> > +             if (rc)
> > +                     return rc;
> > +     } else if (mode =3D=3D NOC_QOS_MODE_BYPASS) {
> > +             dev_dbg(src->provider->dev, "NoC QoS: %s: Set Bypass mode=
\n",
> > +                     qn->name);
> > +     }
> > +
> > +     return regmap_update_bits(qp->regmap,
> > +                               NOC_QOS_MODEn_ADDR(qn->qos.qos_port),
> > +                               NOC_QOS_MODEn_MASK, mode);
> > +}
> > +
> > +static int qcom_icc_qos_set(struct icc_node *node, u64 sum_bw)
> > +{
> > +     struct qcom_icc_provider *qp =3D to_qcom_provider(node->provider)=
;
> > +     struct qcom_icc_node *qn =3D node->data;
> > +
> > +     dev_dbg(node->provider->dev, "Setting QoS for %s\n", qn->name);
> > +
> > +     if (qp->is_bimc_node)
> > +             return qcom_icc_set_bimc_qos(node, sum_bw,
> > +                             (qn->qos.qos_mode =3D=3D NOC_QOS_MODE_BYP=
ASS));
> > +
> > +     return qcom_icc_set_noc_qos(node, sum_bw);
> > +}
> > +
> > +static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64 sum_bw=
)
> > +{
> > +     int ret =3D 0;
> > +
> > +     if (mas_rpm_id !=3D -1) {
> > +             ret =3D qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
> > +                                         RPM_BUS_MASTER_REQ,
> > +                                         mas_rpm_id,
> > +                                         sum_bw);
> > +             if (ret) {
> > +                     pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
> > +                            mas_rpm_id, ret);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     if (slv_rpm_id !=3D -1) {
> > +             ret =3D qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
> > +                                         RPM_BUS_SLAVE_REQ,
> > +                                         slv_rpm_id,
> > +                                         sum_bw);
> > +             if (ret) {
> > +                     pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
> > +                            slv_rpm_id, ret);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
> > +{
> > +     struct qcom_icc_provider *qp;
> > +     struct qcom_icc_node *qn;
> > +     struct icc_provider *provider;
> > +     struct icc_node *n;
> > +     u64 sum_bw;
> > +     u64 max_peak_bw;
> > +     u64 rate;
> > +     u32 agg_avg =3D 0;
> > +     u32 agg_peak =3D 0;
> > +     int ret, i;
> > +
> > +     qn =3D src->data;
> > +     provider =3D src->provider;
> > +     qp =3D to_qcom_provider(provider);
> > +
> > +     list_for_each_entry(n, &provider->nodes, node_list)
> > +             provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
> > +                                 &agg_avg, &agg_peak);
> > +
> > +     sum_bw =3D icc_units_to_bps(agg_avg);
> > +     max_peak_bw =3D icc_units_to_bps(agg_peak);
> > +
> > +     if (!qn->qos.ap_owned) {
> > +             /* send bandwidth request message to the RPM processor */
> > +             ret =3D qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, =
sum_bw);
> > +             if (ret)
> > +                     return ret;
> > +     } else if (qn->qos.qos_mode !=3D -1) {
> > +             /* set bandwidth directly from the AP */
> > +             ret =3D qcom_icc_qos_set(src, sum_bw);
>
> Isn't setting QoS just once per node enough? Or should we set it again on
> every bandwidth request?
>
I am not 100% sure about that. The other smd-rpm based interconnect
drivers are setting it at every BW request, so I followed the others' flow.=
..
Moreover, looking at downstream, it looks like they also set it everytime..=
.

> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     rate =3D max(sum_bw, max_peak_bw);
> > +
> > +     do_div(rate, qn->buswidth);
> > +
> > +     if (qn->rate =3D=3D rate)
> > +             return 0;
> > +
> > +     for (i =3D 0; i < qp->num_clks; i++) {
> > +             ret =3D clk_set_rate(qp->bus_clks[i].clk, rate);
> > +             if (ret) {
> > +                     pr_err("%s clk_set_rate error: %d\n",
> > +                            qp->bus_clks[i].id, ret);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     qn->rate =3D rate;
> > +
> > +     return 0;
> > +}
> > +
> > +static int qnoc_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     const struct qcom_icc_desc *desc;
> > +     struct icc_onecell_data *data;
> > +     struct icc_provider *provider;
> > +     struct qcom_icc_node **qnodes;
> > +     struct qcom_icc_provider *qp;
> > +     struct icc_node *node;
> > +     struct resource *res;
> > +     size_t num_nodes, i;
> > +     int ret;
> > +
> > +     /* wait for the RPM proxy */
> > +     if (!qcom_icc_rpm_smd_available())
> > +             return -EPROBE_DEFER;
> > +
> > +     desc =3D of_device_get_match_data(dev);
> > +     if (!desc)
> > +             return -EINVAL;
> > +
> > +     qnodes =3D desc->nodes;
> > +     num_nodes =3D desc->num_nodes;
> > +
> > +     qp =3D devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
> > +     if (!qp)
> > +             return -ENOMEM;
> > +
> > +     data =3D devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
> > +                         GFP_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     if (of_device_is_compatible(dev->of_node, "qcom,sdm660-mnoc")) {
> > +             qp->bus_clks =3D devm_kmemdup(dev, bus_mm_clocks,
> > +                                         sizeof(bus_mm_clocks), GFP_KE=
RNEL);
> > +             qp->num_clks =3D ARRAY_SIZE(bus_mm_clocks);
> > +     } else {
> > +             if (of_device_is_compatible(dev->of_node, "qcom,sdm660-bi=
mc"))
> > +                     qp->is_bimc_node =3D true;
> > +
> > +             qp->bus_clks =3D devm_kmemdup(dev, bus_clocks, sizeof(bus=
_clocks),
> > +                                         GFP_KERNEL);
> > +             qp->num_clks =3D ARRAY_SIZE(bus_clocks);
> > +     }
> > +     if (!qp->bus_clks)
> > +             return -ENOMEM;
> > +
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!res)
> > +             return -ENODEV;
> > +
> > +     qp->mmio =3D devm_ioremap_resource(dev, res);
> > +     if (IS_ERR(qp->mmio)) {
> > +             dev_err(dev, "Cannot ioremap interconnect bus resource\n"=
);
> > +             return PTR_ERR(qp->mmio);
> > +     }
> > +
> > +     qp->regmap =3D devm_regmap_init_mmio(dev, qp->mmio, desc->regmap_=
cfg);
> > +     if (IS_ERR(qp->regmap)) {
> > +             dev_err(dev, "Cannot regmap interconnect bus resource\n")=
;
> > +             return PTR_ERR(qp->regmap);
> > +     }
> > +
> > +     ret =3D devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D clk_bulk_prepare_enable(qp->num_clks, qp->bus_clks);
> > +     if (ret)
> > +             return ret;
> > +
> > +     provider =3D &qp->provider;
> > +     INIT_LIST_HEAD(&provider->nodes);
> > +     provider->dev =3D dev;
> > +     provider->set =3D qcom_icc_set;
> > +     provider->aggregate =3D icc_std_aggregate;
> > +     provider->xlate =3D of_icc_xlate_onecell;
> > +     provider->data =3D data;
> > +
> > +     ret =3D icc_provider_add(provider);
> > +     if (ret) {
> > +             dev_err(dev, "error adding interconnect provider: %d\n", =
ret);
> > +             clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> > +             return ret;
> > +     }
> > +
> > +     for (i =3D 0; i < num_nodes; i++) {
> > +             size_t j;
> > +
> > +             node =3D icc_node_create(qnodes[i]->id);
> > +             if (IS_ERR(node)) {
> > +                     ret =3D PTR_ERR(node);
> > +                     goto err;
> > +             }
> > +
> > +             node->name =3D qnodes[i]->name;
> > +             node->data =3D qnodes[i];
> > +             icc_node_add(node, provider);
> > +
> > +             dev_dbg(dev, "registered node %s\n", node->name);
>
> Please remove.
>
> > +
> > +             /* populate links */
>
> Not very useful comment. Please remove.
>
> > +             for (j =3D 0; j < qnodes[i]->num_links; j++)
> > +                     icc_link_create(node, qnodes[i]->links[j]);
> > +
> > +             data->nodes[i] =3D node;
> > +     }
> > +     data->num_nodes =3D num_nodes;
> > +     platform_set_drvdata(pdev, qp);
> > +
> > +     return 0;
> > +err:
> > +     icc_nodes_remove(provider);
> > +     clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> > +     icc_provider_del(provider);
> > +
> > +     return ret;
> > +}
> > +
> > +static int qnoc_remove(struct platform_device *pdev)
> > +{
> > +     struct qcom_icc_provider *qp =3D platform_get_drvdata(pdev);
> > +
> > +     icc_nodes_remove(&qp->provider);
> > +     clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> > +     return icc_provider_del(&qp->provider);
> > +}
> > +
> > +static const struct of_device_id sdm660_noc_of_match[] =3D {
> > +     { .compatible =3D "qcom,sdm660-a2noc", .data =3D &sdm660_a2noc },
> > +     { .compatible =3D "qcom,sdm660-bimc", .data =3D &sdm660_bimc },
> > +     { .compatible =3D "qcom,sdm660-cnoc", .data =3D &sdm660_cnoc },
> > +     { .compatible =3D "qcom,sdm660-gnoc", .data =3D &sdm660_gnoc },
> > +     { .compatible =3D "qcom,sdm660-mnoc", .data =3D &sdm660_mnoc },
> > +     { .compatible =3D "qcom,sdm660-snoc", .data =3D &sdm660_snoc },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(of, sdm660_noc_of_match);
> > +
> > +static struct platform_driver sdm660_noc_driver =3D {
> > +     .probe =3D qnoc_probe,
> > +     .remove =3D qnoc_remove,
> > +     .driver =3D {
> > +             .name =3D "qnoc-sdm660",
> > +             .of_match_table =3D sdm660_noc_of_match,
> > +     },
> > +};
> > +module_platform_driver(sdm660_noc_driver);
> > +MODULE_DESCRIPTION("Qualcomm sdm660 NoC driver");
> > +MODULE_LICENSE("GPL v2");
> >
>
> Thanks,
> Georgi

All of the suggestions are fixed and I've also added a small improvement.
Sending V4 ASAP!

Thanks for this nice review!
-- Angelo
