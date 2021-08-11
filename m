Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E03B3E9204
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 14:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhHKM5d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 08:57:33 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:49032 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhHKM5d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 08:57:33 -0400
Date:   Wed, 11 Aug 2021 12:56:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1628686625;
        bh=fnwNuodEHW6jgrmLRroC0GTlmUzP7CcYZkBDo8BUNdY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=uYoJ0dUnWmyOJWILLr3BMsYTKExKyPawzFePwVc2zT8PyJLawDZhf499ruNtt7KuX
         kEdkec0ciPKXK9bFDnDurrkTrbgP8ON6ami/PJ6W/r82KOye3onuqzSAe7vksKDfec
         aLGxaPvR8ckLX0LaFVrj1YvEg1U5slSz7UQ46St0=
To:     Georgi Djakov <djakov@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        okukatla@codeaurora.org, mdtipton@codeaurora.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH v3 5/6] interconnect: qcom: Add MSM8996 interconnect provider driver
Message-ID: <CMEOXQ.F594ZQFPV8PT2@protonmail.com>
In-Reply-To: <a520d353-f291-4596-e21b-6bdd27fdc965@kernel.org>
References: <20210811043451.189776-1-y.oudjana@protonmail.com> <20210811043451.189776-6-y.oudjana@protonmail.com> <a520d353-f291-4596-e21b-6bdd27fdc965@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On Wed, Aug 11 2021 at 14:56:01 +0400, Georgi Djakov=20
<djakov@kernel.org> wrote:
> Hi Yassine,
>=20
> Thank you for working on this!
>=20
> On 11.08.21 7:37, Yassine Oudjana wrote:
>>  Add a driver for the MSM8996 NoCs. This chip is similar to SDM660=20
>> where
>>  some busses are controlled by RPM, while others directly by the AP=20
>> with
>>  writes to QoS registers.
>>=20
>>  This driver currently supports all NoCs except a0noc.
>=20
> Just curious what's the issue with a0noc. Do we need to enable some=20
> GDSC
> or clock in order to write to the QoS registers?

I'm not sure why, but I get a SError interrupt when writing to its=20
registers.
I tried enabling AGGRE0_NOC_GDSC but it didn't change anything.

>=20
>>=20
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>  ---
>>    drivers/interconnect/qcom/Kconfig   |   9 +
>>    drivers/interconnect/qcom/Makefile  |   2 +
>>    drivers/interconnect/qcom/msm8996.c | 574=20
>> ++++++++++++++++++++++++++++
>>    drivers/interconnect/qcom/msm8996.h | 149 ++++++++
>>    4 files changed, 734 insertions(+)
>>    create mode 100644 drivers/interconnect/qcom/msm8996.c
>>    create mode 100644 drivers/interconnect/qcom/msm8996.h
>>=20
>>  diff --git a/drivers/interconnect/qcom/Kconfig=20
>> b/drivers/interconnect/qcom/Kconfig
>>  index ad16224f1720..e30ad95e5584 100644
>>  --- a/drivers/interconnect/qcom/Kconfig
>>  +++ b/drivers/interconnect/qcom/Kconfig
>>  @@ -35,6 +35,15 @@ config INTERCONNECT_QCOM_MSM8974
>>    =09 This is a driver for the Qualcomm Network-on-Chip on=20
>> msm8974-based
>>    =09 platforms.
>>=20
>>  +config INTERCONNECT_QCOM_MSM8996
>>  +=09tristate "Qualcomm MSM8996 interconnect driver"
>>  +=09depends on INTERCONNECT_QCOM
>>  +=09depends on QCOM_SMD_RPM
>>  +=09select INTERCONNECT_QCOM_SMD_RPM_QOS
>>  +=09help
>>  +=09  This is a driver for the Qualcomm Network-on-Chip on=20
>> msm8996-based
>>  +=09  platforms.
>>  +
>>    config INTERCONNECT_QCOM_OSM_L3
>>    =09tristate "Qualcomm OSM L3 interconnect driver"
>>    =09depends on INTERCONNECT_QCOM || COMPILE_TEST
>>  diff --git a/drivers/interconnect/qcom/Makefile=20
>> b/drivers/interconnect/qcom/Makefile
>>  index 2d04d024f46e..8a198b8b7a45 100644
>>  --- a/drivers/interconnect/qcom/Makefile
>>  +++ b/drivers/interconnect/qcom/Makefile
>>  @@ -4,6 +4,7 @@ icc-bcm-voter-objs=09=09=09:=3D bcm-voter.o
>>    qnoc-msm8916-objs=09=09=09:=3D msm8916.o
>>    qnoc-msm8939-objs=09=09=09:=3D msm8939.o
>>    qnoc-msm8974-objs=09=09=09:=3D msm8974.o
>>  +qnoc-msm8996-objs=09=09=09:=3D msm8996.o
>>    icc-osm-l3-objs=09=09=09=09:=3D osm-l3.o
>>    qnoc-qcs404-objs=09=09=09:=3D qcs404.o
>>    icc-rpmh-obj=09=09=09=09:=3D icc-rpmh.o
>>  @@ -22,6 +23,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) +=3D=20
>> icc-bcm-voter.o
>>    obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) +=3D qnoc-msm8916.o
>>    obj-$(CONFIG_INTERCONNECT_QCOM_MSM8939) +=3D qnoc-msm8939.o
>>    obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) +=3D qnoc-msm8974.o
>>  +obj-$(CONFIG_INTERCONNECT_QCOM_MSM8996) +=3D qnoc-msm8996.o
>>    obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) +=3D icc-osm-l3.o
>>    obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) +=3D qnoc-qcs404.o
>>    obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) +=3D icc-rpmh.o
>>  diff --git a/drivers/interconnect/qcom/msm8996.c=20
>> b/drivers/interconnect/qcom/msm8996.c
>>  new file mode 100644
>>  index 000000000000..0cb93d743f35
>>  --- /dev/null
>>  +++ b/drivers/interconnect/qcom/msm8996.c
>>  @@ -0,0 +1,574 @@
>>  +/* SPDX-License-Identifier: GPL-2.0-only */
>=20
> The // style is preferred for .c files.

Noted.

>=20
>>  +/*
>>  + * Qualcomm MSM8996 Network-on-Chip (NoC) QoS driver
>>  + *
>>  + * Copyright (c) 2021 Yassine Oudjana <y.oudjana@protonmail.com>
>>  + */
>>  +
>>  +#include <linux/clk.h>
>>  +#include <linux/device.h>
>>  +#include <linux/interconnect-provider.h>
>>  +#include <linux/io.h>
>>  +#include <linux/module.h>
>>  +#include <linux/of_device.h>
>>  +#include <linux/of_platform.h>
>>  +#include <linux/platform_device.h>
>>  +#include <linux/regmap.h>
>>  +
>>  +#include <dt-bindings/interconnect/qcom,msm8996.h>
>>  +
>>  +#include "icc-rpm-qos.h"
>>  +#include "smd-rpm.h"
>>  +#include "msm8996.h"
>>  +
> [..]
>>  +DEFINE_QNODE(mas_mdp_p0, MSM8996_MASTER_MDP_PORT0, 32, 8, -1,=20
>> true, NOC_QOS_MODE_BYPASS, 0, 1, MSM8996_SLAVE_MNOC_BIMC);
>>  +DEFINE_QNODE(mas_mdp_p1, MSM8996_MASTER_MDP_PORT1, 32, 61, -1,=20
>> true, NOC_QOS_MODE_BYPASS, 0, 2, MSM8996_SLAVE_MNOC_BIMC);
>>  +DEFINE_QNODE(mas_rotator, MSM8996_MASTER_ROTATOR, 32, 120, -1,=20
>> true, NOC_QOS_MODE_BYPASS, 0, 0, MSM8996_SLAVE_MNOC_BIMC);
>>  +DEFINE_QNODE(mas_venus, MSM8996_MASTER_VIDEO_P0, 32, 9, -1, true,=20
>> NOC_QOS_MODE_BYPASS, 0, 3 /* TODO: 3 4 ?? */,=20
>> MSM8996_SLAVE_MNOC_BIMC);
>=20
> Is the TODO for multiple QoS ports?

I was going to better format that TODO or remove it but it seems that I=20
forgot.
Downstream has both ports specified.

>=20
> [..]
>=20
>>  +static const struct regmap_config msm8996_mnoc_regmap_config =3D {
>>  +=09.reg_bits=09=3D 32,
>>  +=09.reg_stride=09=3D 4,
>>  +=09.val_bits=09=3D 32,
>>  +=09.max_register=09=3D 0x20000,
>>  +=09.fast_io=09=3D true,
>>  +};
>>  +
>>  +static const struct qcom_icc_desc msm8996_mnoc =3D {
>>  +=09.nodes =3D mnoc_nodes,
>>  +=09.num_nodes =3D ARRAY_SIZE(mnoc_nodes),
>>  +=09.regmap_cfg =3D &msm8996_mnoc_regmap_config,
>>  +};
>>  +
>>  +
>=20
> Nit: No multiple blank lines, please.

Noted.

>=20
>>  +static struct qcom_icc_node *pnoc_nodes[] =3D {
>>  +=09[MASTER_SNOC_PNOC] =3D &mas_snoc_pnoc,
>>  +=09[MASTER_SDCC_1] =3D &mas_sdcc_1,
>>  +=09[MASTER_SDCC_2] =3D &mas_sdcc_2,
>>  +=09[MASTER_SDCC_4] =3D &mas_sdcc_4,
>>  +=09[MASTER_USB_HS] =3D &mas_usb_hs,
>>  +=09[MASTER_BLSP_1] =3D &mas_blsp_1,
>>  +=09[MASTER_BLSP_2] =3D &mas_blsp_2,
>>  +=09[MASTER_TSIF] =3D &mas_tsif,
>>  +=09[SLAVE_PNOC_A1NOC] =3D &slv_pnoc_a1noc,
>>  +=09[SLAVE_USB_HS] =3D &slv_usb_hs,
>>  +=09[SLAVE_SDCC_2] =3D &slv_sdcc_2,
>>  +=09[SLAVE_SDCC_4] =3D &slv_sdcc_4,
>>  +=09[SLAVE_TSIF] =3D &slv_tsif,
>>  +=09[SLAVE_BLSP_2] =3D &slv_blsp_2,
>>  +=09[SLAVE_SDCC_1] =3D &slv_sdcc_1,
>>  +=09[SLAVE_BLSP_1] =3D &slv_blsp_1,
>>  +=09[SLAVE_PDM] =3D &slv_pdm,
>>  +=09[SLAVE_AHB2PHY] =3D &slv_ahb2phy,
>>  +};
>>  +
>>  +static const struct regmap_config msm8996_pnoc_regmap_config =3D {
>>  +=09.reg_bits=09=3D 32,
>>  +=09.reg_stride=09=3D 4,
>>  +=09.val_bits=09=3D 32,
>>  +=09.max_register=09=3D 0x3000,
>>  +=09.fast_io=09=3D true,
>>  +};
>>  +
> [..]
>>  +=09for (i =3D 0; i < num_nodes; i++) {
>>  +=09=09size_t j;
>>  +
>>  +=09=09node =3D icc_node_create(qnodes[i]->id);
>>  +=09=09if (IS_ERR(node)) {
>>  +=09=09=09ret =3D PTR_ERR(node);
>>  +=09=09=09goto err;
>>  +=09=09}
>>  +
>>  +=09=09node->name =3D qnodes[i]->name;
>>  +=09=09node->data =3D qnodes[i];
>>  +=09=09icc_node_add(node, provider);
>>  +
>>  +=09=09for (j =3D 0; j < qnodes[i]->num_links; j++) {
>>  +=09=09=09icc_link_create(node, qnodes[i]->links[j]);
>>  +=09=09}
>=20
> Nit: No need for braces.
>=20
> Also please rebase all patches onto linux-next.
>=20
> Thanks,
> Georgi

Will do.

Thanks,
Yassine



