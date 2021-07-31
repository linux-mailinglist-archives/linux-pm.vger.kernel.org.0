Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AC63DC5B0
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jul 2021 13:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhGaLW4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Jul 2021 07:22:56 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:25074 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbhGaLW4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jul 2021 07:22:56 -0400
Date:   Sat, 31 Jul 2021 11:22:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1627730566;
        bh=oBMQORLr71eHF+5XGOOCjrFcm1f761Z0GkeUmfUkBrw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=E/ItKv/tf+7asF/tsJipLM7n9oHsREqXWCpz6flaRJ9RzqHMzxPl7YLNz5qpO74UC
         pm6PF0G/TlRFDPFNPsmNq68Dwf7oKJWI4FJa3YtJsDcS7QaKs7WnPz4NACjpvMltvr
         N0wI8LTstTKzp3TOMRvVMPmTmiuE5vu5TT807K24=
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH 1/5] interconnect: qcom: sdm660: Commonize RPM-QoS
Message-ID: <8MU3XQ.J4PEYNU13D7K2@protonmail.com>
In-Reply-To: <d65fa810-403f-29f3-ec18-16bcdfb68a85@somainline.org>
References: <tBji8z2BZb2uc4O2OP7PyUJqbxLiWwoKnR7Ybshs@cp3-web-050.plabs.ch> <d65fa810-403f-29f3-ec18-16bcdfb68a85@somainline.org>
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

On Fri, Jul 30 2021 at 17:39:31 +0400, AngeloGioacchino Del Regno=20
<angelogioacchino.delregno@somainline.org> wrote:
> Il 30/07/21 14:06, Yassine Oudjana ha scritto:
>>  SoCs such as MSM8996 also control bus QoS in a similar fashion to=20
>> SDM660,
>>  with some paths being controlled by RPM and others directly by the=20
>> AP.
>>  Move relevant functions and defines to a new object so that they=20
>> can be used
>>  in multiple drivers.
>>=20
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>=20
> Hello Yassine,
> thanks for the patch! However, I think there are a few things to=20
> improve:
>=20
>>  ---
>>    drivers/interconnect/qcom/Kconfig       |   5 +-
>>    drivers/interconnect/qcom/Makefile      |   2 +
>>    drivers/interconnect/qcom/icc-rpm-qos.c | 237 ++++++++++++++++
>>    drivers/interconnect/qcom/icc-rpm-qos.h | 133 +++++++++
>>    drivers/interconnect/qcom/icc-rpmh.c    |   6 +-
>>    drivers/interconnect/qcom/icc-rpmh.h    |   2 +-
>>    drivers/interconnect/qcom/sc7180.c      |   2 +-
>>    drivers/interconnect/qcom/sc7280.c      |   2 +-
>>    drivers/interconnect/qcom/sdm660.c      | 346=20
>> +-----------------------
>>    drivers/interconnect/qcom/sdm845.c      |   2 +-
>>    drivers/interconnect/qcom/sdx55.c       |   2 +-
>>    drivers/interconnect/qcom/sm8150.c      |   2 +-
>>    drivers/interconnect/qcom/sm8250.c      |   2 +-
>>    drivers/interconnect/qcom/sm8350.c      |   2 +-
>>    14 files changed, 391 insertions(+), 354 deletions(-)
>>    create mode 100644 drivers/interconnect/qcom/icc-rpm-qos.c
>>    create mode 100644 drivers/interconnect/qcom/icc-rpm-qos.h
>>=20
>>  diff --git a/drivers/interconnect/qcom/Kconfig=20
>> b/drivers/interconnect/qcom/Kconfig
>>  index 0d7a2500d0b8..ad16224f1720 100644
>>  --- a/drivers/interconnect/qcom/Kconfig
>>  +++ b/drivers/interconnect/qcom/Kconfig
>>  @@ -87,7 +87,7 @@ config INTERCONNECT_QCOM_SDM660
>>    =09tristate "Qualcomm SDM660 interconnect driver"
>>    =09depends on INTERCONNECT_QCOM
>>    =09depends on QCOM_SMD_RPM
>>  -=09select INTERCONNECT_QCOM_SMD_RPM
>>  +=09select INTERCONNECT_QCOM_SMD_RPM_QOS
>>    =09help
>>    =09  This is a driver for the Qualcomm Network-on-Chip on=20
>> sdm660-based
>>    =09  platforms.
>>  @@ -139,3 +139,6 @@ config INTERCONNECT_QCOM_SM8350
>>=20
>>    config INTERCONNECT_QCOM_SMD_RPM
>>    =09tristate
>>  +
>>  +config INTERCONNECT_QCOM_SMD_RPM_QOS
>>  +=09tristate
>>  diff --git a/drivers/interconnect/qcom/Makefile=20
>> b/drivers/interconnect/qcom/Makefile
>>  index 2880129a6fe4..2d04d024f46e 100644
>>  --- a/drivers/interconnect/qcom/Makefile
>>  +++ b/drivers/interconnect/qcom/Makefile
>>  @@ -16,6 +16,7 @@ qnoc-sm8150-objs=09=09=09:=3D sm8150.o
>>    qnoc-sm8250-objs=09=09=09:=3D sm8250.o
>>    qnoc-sm8350-objs=09=09=09:=3D sm8350.o
>>    icc-smd-rpm-objs=09=09=09:=3D smd-rpm.o icc-rpm.o
>>  +icc-smd-rpm-qos-objs=09=09=09:=3D smd-rpm.o icc-rpm-qos.o
>>=20
>>    obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) +=3D icc-bcm-voter.o
>>    obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) +=3D qnoc-msm8916.o
>>  @@ -33,3 +34,4 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) +=3D=20
>> qnoc-sm8150.o
>>    obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) +=3D qnoc-sm8250.o
>>    obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) +=3D qnoc-sm8350.o
>>    obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) +=3D icc-smd-rpm.o
>>  +obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM_QOS) +=3D icc-smd-rpm-qos.o
>>  diff --git a/drivers/interconnect/qcom/icc-rpm-qos.c=20
>> b/drivers/interconnect/qcom/icc-rpm-qos.c
>>  new file mode 100644
>>  index 000000000000..678b347375d8
>>  --- /dev/null
>>  +++ b/drivers/interconnect/qcom/icc-rpm-qos.c
>>  @@ -0,0 +1,237 @@
>>  +/* SPDX-License-Identifier: GPL-2.0 */
>>  +/*
>>  + * Copyright (C) 2020, AngeloGioacchino Del Regno=20
>> <kholk11@gmail.com>
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
>>  +#include <linux/slab.h>
>>  +
>>  +#include "smd-rpm.h"
>>  +#include "icc-rpm-qos.h"
>>  +
>>  +static int qcom_icc_bimc_set_qos_health(struct regmap *rmap,
>>  +=09=09=09=09=09struct qcom_icc_qos *qos,
>>  +=09=09=09=09=09int regnum)
>>  +{
>>  +=09u32 val;
>>  +=09u32 mask;
>>  +
>>  +=09val =3D qos->prio_level;
>>  +=09mask =3D M_BKE_HEALTH_CFG_PRIOLVL_MASK;
>>  +
>>  +=09val |=3D qos->areq_prio << M_BKE_HEALTH_CFG_AREQPRIO_SHIFT;
>>  +=09mask |=3D M_BKE_HEALTH_CFG_AREQPRIO_MASK;
>>  +
>>  +=09/* LIMITCMDS is not present on M_BKE_HEALTH_3 */
>>  +=09if (regnum !=3D 3) {
>>  +=09=09val |=3D qos->limit_commands << M_BKE_HEALTH_CFG_LIMITCMDS_SHIFT=
;
>>  +=09=09mask |=3D M_BKE_HEALTH_CFG_LIMITCMDS_MASK;
>>  +=09}
>>  +
>>  +=09return regmap_update_bits(rmap,
>>  +=09=09=09=09  M_BKE_HEALTH_CFG_ADDR(regnum, qos->qos_port),
>>  +=09=09=09=09  mask, val);
>>  +}
>>  +
>>  +static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw,
>>  +=09=09=09=09 bool bypass_mode)
>>  +{
>>  +=09struct qcom_icc_provider *qp;
>>  +=09struct qcom_icc_node *qn;
>>  +=09struct icc_provider *provider;
>>  +=09u32 mode =3D NOC_QOS_MODE_BYPASS;
>>  +=09u32 val =3D 0;
>>  +=09int i, rc =3D 0;
>>  +
>>  +=09qn =3D src->data;
>>  +=09provider =3D src->provider;
>>  +=09qp =3D to_qcom_provider(provider);
>>  +
>>  +=09if (qn->qos.qos_mode !=3D -1)
>>  +=09=09mode =3D qn->qos.qos_mode;
>>  +
>>  +=09/* QoS Priority: The QoS Health parameters are getting considered
>>  +=09 * only if we are NOT in Bypass Mode.
>>  +=09 */
>>  +=09if (mode !=3D NOC_QOS_MODE_BYPASS) {
>>  +=09=09for (i =3D 3; i >=3D 0; i--) {
>>  +=09=09=09rc =3D qcom_icc_bimc_set_qos_health(qp->regmap,
>>  +=09=09=09=09=09=09=09  &qn->qos, i);
>>  +=09=09=09if (rc)
>>  +=09=09=09=09return rc;
>>  +=09=09}
>>  +
>>  +=09=09/* Set BKE_EN to 1 when Fixed, Regulator or Limiter Mode */
>>  +=09=09val =3D 1;
>>  +=09}
>>  +
>>  +=09return regmap_update_bits(qp->regmap,=20
>> M_BKE_EN_ADDR(qn->qos.qos_port),
>>  +=09=09=09=09  M_BKE_EN_EN_BMASK, val);
>>  +}
>>  +
>>  +static int qcom_icc_noc_set_qos_priority(struct regmap *rmap,
>>  +=09=09=09=09=09 struct qcom_icc_qos *qos)
>>  +{
>>  +=09u32 val;
>>  +=09int rc;
>>  +
>>  +=09/* Must be updated one at a time, P1 first, P0 last */
>>  +=09val =3D qos->areq_prio << NOC_QOS_PRIORITY_P1_SHIFT;
>>  +=09rc =3D regmap_update_bits(rmap,=20
>> NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
>>  +=09=09=09=09NOC_QOS_PRIORITY_MASK, val);
>>  +=09if (rc)
>>  +=09=09return rc;
>>  +
>>  +=09val =3D qos->prio_level << NOC_QOS_PRIORITY_P0_SHIFT;
>>  +=09return regmap_update_bits(rmap,=20
>> NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
>>  +=09=09=09=09  NOC_QOS_PRIORITY_MASK, val);
>>  +}
>>  +
>>  +static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
>>  +{
>>  +=09struct qcom_icc_provider *qp;
>>  +=09struct qcom_icc_node *qn;
>>  +=09struct icc_provider *provider;
>>  +=09u32 mode =3D NOC_QOS_MODE_BYPASS;
>>  +=09int rc =3D 0;
>>  +
>>  +=09qn =3D src->data;
>>  +=09provider =3D src->provider;
>>  +=09qp =3D to_qcom_provider(provider);
>>  +
>>  +=09if (qn->qos.qos_port < 0) {
>>  +=09=09dev_dbg(src->provider->dev,
>>  +=09=09=09"NoC QoS: Skipping %s: vote aggregated on parent.\n",
>>  +=09=09=09qn->name);
>>  +=09=09return 0;
>>  +=09}
>>  +
>>  +=09if (qn->qos.qos_mode !=3D -1)
>>  +=09=09mode =3D qn->qos.qos_mode;
>>  +
>>  +=09if (mode =3D=3D NOC_QOS_MODE_FIXED) {
>>  +=09=09dev_dbg(src->provider->dev, "NoC QoS: %s: Set Fixed mode\n",
>>  +=09=09=09qn->name);
>>  +=09=09rc =3D qcom_icc_noc_set_qos_priority(qp->regmap, &qn->qos);
>>  +=09=09if (rc)
>>  +=09=09=09return rc;
>>  +=09} else if (mode =3D=3D NOC_QOS_MODE_BYPASS) {
>>  +=09=09dev_dbg(src->provider->dev, "NoC QoS: %s: Set Bypass mode\n",
>>  +=09=09=09qn->name);
>>  +=09}
>>  +
>>  +=09return regmap_update_bits(qp->regmap,
>>  +=09=09=09=09  NOC_QOS_MODEn_ADDR(qn->qos.qos_port),
>>  +=09=09=09=09  NOC_QOS_MODEn_MASK, mode);
>>  +}
>>  +
>>  +static int qcom_icc_qos_set(struct icc_node *node, u64 sum_bw)
>>  +{
>>  +=09struct qcom_icc_provider *qp =3D to_qcom_provider(node->provider);
>>  +=09struct qcom_icc_node *qn =3D node->data;
>>  +
>>  +=09dev_dbg(node->provider->dev, "Setting QoS for %s\n", qn->name);
>>  +
>>  +=09if (qp->is_bimc_node)
>>  +=09=09return qcom_icc_set_bimc_qos(node, sum_bw,
>>  +=09=09=09=09(qn->qos.qos_mode =3D=3D NOC_QOS_MODE_BYPASS));
>>  +
>>  +=09return qcom_icc_set_noc_qos(node, sum_bw);
>>  +}
>>  +
>>  +static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64=20
>> sum_bw)
>>  +{
>>  +=09int ret =3D 0;
>>  +
>>  +=09if (mas_rpm_id !=3D -1) {
>>  +=09=09ret =3D qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
>>  +=09=09=09=09=09    RPM_BUS_MASTER_REQ,
>>  +=09=09=09=09=09    mas_rpm_id,
>>  +=09=09=09=09=09    sum_bw);
>>  +=09=09if (ret) {
>>  +=09=09=09pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
>>  +=09=09=09       mas_rpm_id, ret);
>>  +=09=09=09return ret;
>>  +=09=09}
>>  +=09}
>>  +
>>  +=09if (slv_rpm_id !=3D -1) {
>>  +=09=09ret =3D qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
>>  +=09=09=09=09=09    RPM_BUS_SLAVE_REQ,
>>  +=09=09=09=09=09    slv_rpm_id,
>>  +=09=09=09=09=09    sum_bw);
>>  +=09=09if (ret) {
>>  +=09=09=09pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
>>  +=09=09=09       slv_rpm_id, ret);
>>  +=09=09=09return ret;
>>  +=09=09}
>>  +=09}
>>  +
>>  +=09return ret;
>>  +}
>>  +
>>  +int qcom_icc_rpm_qos_set(struct icc_node *src, struct icc_node=20
>> *dst)
>>  +{
>>  +=09struct qcom_icc_provider *qp;
>>  +=09struct qcom_icc_node *qn;
>>  +=09struct icc_provider *provider;
>>  +=09struct icc_node *n;
>>  +=09u64 sum_bw;
>>  +=09u64 max_peak_bw;
>>  +=09u64 rate;
>>  +=09u32 agg_avg =3D 0;
>>  +=09u32 agg_peak =3D 0;
>>  +=09int ret, i;
>>  +
>>  +=09qn =3D src->data;
>>  +=09provider =3D src->provider;
>>  +=09qp =3D to_qcom_provider(provider);
>>  +
>>  +=09list_for_each_entry(n, &provider->nodes, node_list)
>>  +=09=09provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
>>  +=09=09=09=09    &agg_avg, &agg_peak);
>>  +
>>  +=09sum_bw =3D icc_units_to_bps(agg_avg);
>>  +=09max_peak_bw =3D icc_units_to_bps(agg_peak);
>>  +
>>  +=09if (!qn->qos.ap_owned) {
>>  +=09=09/* send bandwidth request message to the RPM processor */
>>  +=09=09ret =3D qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw)=
;
>>  +=09=09if (ret)
>>  +=09=09=09return ret;
>>  +=09} else if (qn->qos.qos_mode !=3D -1) {
>>  +=09=09/* set bandwidth directly from the AP */
>>  +=09=09ret =3D qcom_icc_qos_set(src, sum_bw);
>>  +=09=09if (ret)
>>  +=09=09=09return ret;
>>  +=09}
>>  +
>>  +=09rate =3D max(sum_bw, max_peak_bw);
>>  +
>>  +=09do_div(rate, qn->buswidth);
>>  +
>>  +=09if (qn->rate =3D=3D rate)
>>  +=09=09return 0;
>>  +
>>  +=09for (i =3D 0; i < qp->num_clks; i++) {
>>  +=09=09ret =3D clk_set_rate(qp->bus_clks[i].clk, rate);
>>  +=09=09if (ret) {
>>  +=09=09=09pr_err("%s clk_set_rate error: %d\n",
>>  +=09=09=09       qp->bus_clks[i].id, ret);
>>  +=09=09=09return ret;
>>  +=09=09}
>>  +=09}
>>  +
>>  +=09qn->rate =3D rate;
>>  +
>>  +=09return 0;
>>  +}
>>  +EXPORT_SYMBOL_GPL(qcom_icc_rpm_qos_set);
>>  diff --git a/drivers/interconnect/qcom/icc-rpm-qos.h=20
>> b/drivers/interconnect/qcom/icc-rpm-qos.h
>>  new file mode 100644
>>  index 000000000000..625ac5f84ebc
>>  --- /dev/null
>>  +++ b/drivers/interconnect/qcom/icc-rpm-qos.h
>>  @@ -0,0 +1,133 @@
>>  +/* SPDX-License-Identifier: GPL-2.0 */
>>  +/*
>>  + * Copyright (C) 2020, AngeloGioacchino Del Regno=20
>> <kholk11@gmail.com>
>>  + */
>>  +
>>  +#ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_QOS_H__
>>  +#define __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_QOS_H__
>>  +
>>  +#define RPM_BUS_MASTER_REQ=090x73616d62
>>  +#define RPM_BUS_SLAVE_REQ=090x766c7362
>>  +
>>  +/* BIMC QoS */
>>  +#define M_BKE_REG_BASE(n)=09=09(0x300 + (0x4000 * n))
>>  +#define M_BKE_EN_ADDR(n)=09=09(M_BKE_REG_BASE(n))
>>  +#define M_BKE_HEALTH_CFG_ADDR(i, n)=09(M_BKE_REG_BASE(n) + 0x40 +=20
>> (0x4 * i))
>>  +
>>  +#define M_BKE_HEALTH_CFG_LIMITCMDS_MASK=090x80000000
>>  +#define M_BKE_HEALTH_CFG_AREQPRIO_MASK=090x300
>>  +#define M_BKE_HEALTH_CFG_PRIOLVL_MASK=090x3
>>  +#define M_BKE_HEALTH_CFG_AREQPRIO_SHIFT=090x8
>>  +#define M_BKE_HEALTH_CFG_LIMITCMDS_SHIFT 0x1f
>>  +
>>  +#define M_BKE_EN_EN_BMASK=09=090x1
>>  +
>>  +/* Valid for both NoC and BIMC */
>>  +#define NOC_QOS_MODE_FIXED=09=090x0
>>  +#define NOC_QOS_MODE_LIMITER=09=090x1
>>  +#define NOC_QOS_MODE_BYPASS=09=090x2
>>  +
>>  +/* NoC QoS */
>>  +#define NOC_PERM_MODE_FIXED=09=091
>>  +#define NOC_PERM_MODE_BYPASS=09=09(1 << NOC_QOS_MODE_BYPASS)
>>  +
>>  +#define NOC_QOS_PRIORITYn_ADDR(n)=09(0x8 + (n * 0x1000))
>>  +#define NOC_QOS_PRIORITY_MASK=09=090xf
>>  +#define NOC_QOS_PRIORITY_P1_SHIFT=090x2
>>  +#define NOC_QOS_PRIORITY_P0_SHIFT=090x3
>>  +
>>  +#define NOC_QOS_MODEn_ADDR(n)=09=09(0xc + (n * 0x1000))
>>  +#define NOC_QOS_MODEn_MASK=09=090x3
>>  +
>>  +#define to_qcom_provider(_provider) \
>>  +=09container_of(_provider, struct qcom_icc_provider, provider)
>>  +
>>  +/**
>>  + * struct qcom_icc_provider - Qualcomm specific interconnect=20
>> provider
>>  + * @provider: generic interconnect provider
>>  + * @bus_clks: the clk_bulk_data table of bus clocks
>>  + * @num_clks: the total number of clk_bulk_data entries
>>  + * @is_bimc_node: indicates whether to use bimc specific setting
>>  + * @regmap: regmap for QoS registers read/write access
>>  + * @mmio: NoC base iospace
>>  + */
>>  +struct qcom_icc_provider {
>>  +=09struct icc_provider provider;
>>  +=09struct clk_bulk_data *bus_clks;
>>  +=09int num_clks;
>>  +=09bool is_bimc_node;
>>  +=09struct regmap *regmap;
>>  +=09void __iomem *mmio;
>>  +};
>>  +
>>  +/**
>>  + * struct qcom_icc_qos - Qualcomm specific interconnect QoS=20
>> parameters
>>  + * @areq_prio: node requests priority
>>  + * @prio_level: priority level for bus communication
>>  + * @limit_commands: activate/deactivate limiter mode during runtime
>>  + * @ap_owned: indicates if the node is owned by the AP or by the=20
>> RPM
>>  + * @qos_mode: default qos mode for this node
>>  + * @qos_port: qos port number for finding qos registers of this=20
>> node
>>  + */
>>  +struct qcom_icc_qos {
>>  +=09u32 areq_prio;
>>  +=09u32 prio_level;
>>  +=09bool limit_commands;
>>  +=09bool ap_owned;
>>  +=09int qos_mode;
>>  +=09int qos_port;
>>  +};
>>  +
>>  +/**
>>  + * struct qcom_icc_node - Qualcomm specific interconnect nodes
>>  + * @name: the node name used in debugfs
>>  + * @id: a unique node identifier
>>  + * @links: an array of nodes where we can go next while traversing
>>  + * @num_links: the total number of @links
>>  + * @buswidth: width of the interconnect between a node and the bus=20
>> (bytes)
>>  + * @mas_rpm_id: RPM id for devices that are bus masters
>>  + * @slv_rpm_id: RPM id for devices that are bus slaves
>>  + * @qos: NoC QoS setting parameters
>>  + * @rate: current bus clock rate in Hz
>>  + */
>>  +
>>  +#define MAX_LINKS=0938
>>  +
>>  +struct qcom_icc_node {
>>  +=09unsigned char *name;
>>  +=09u16 id;
>>  +=09u16 links[MAX_LINKS];
>>  +=09u16 num_links;
>>  +=09u16 buswidth;
>>  +=09int mas_rpm_id;
>>  +=09int slv_rpm_id;
>>  +=09struct qcom_icc_qos qos;
>>  +=09u64 rate;
>>  +};
>>  +
>>  +struct qcom_icc_desc {
>>  +=09struct qcom_icc_node **nodes;
>>  +=09size_t num_nodes;
>>  +=09const struct regmap_config *regmap_cfg;
>>  +};
>>  +
>>  +#define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id,=20
>> _slv_rpm_id,=09\
>>  +=09=09     _ap_owned, _qos_mode, _qos_prio, _qos_port, ...)=09\
>>  +=09=09static struct qcom_icc_node _name =3D {=09=09=09\
>>  +=09=09.name =3D #_name,=09=09=09=09=09=09\
>>  +=09=09.id =3D _id,=09=09=09=09=09=09\
>>  +=09=09.buswidth =3D _buswidth,=09=09=09=09=09\
>>  +=09=09.mas_rpm_id =3D _mas_rpm_id,=09=09=09=09\
>>  +=09=09.slv_rpm_id =3D _slv_rpm_id,=09=09=09=09\
>>  +=09=09.qos.ap_owned =3D _ap_owned,=09=09=09=09\
>>  +=09=09.qos.qos_mode =3D _qos_mode,=09=09=09=09\
>>  +=09=09.qos.areq_prio =3D _qos_prio,=09=09=09=09\
>>  +=09=09.qos.prio_level =3D _qos_prio,=09=09=09=09\
>>  +=09=09.qos.qos_port =3D _qos_port,=09=09=09=09\
>>  +=09=09.num_links =3D ARRAY_SIZE(((int[]){ __VA_ARGS__ })),=09\
>>  +=09=09.links =3D { __VA_ARGS__ },=09=09=09=09\
>>  +=09}
>>  +
>>  +int qcom_icc_rpm_qos_set(struct icc_node *src, struct icc_node=20
>> *dst);
>>  +
>>  +#endif
>>  diff --git a/drivers/interconnect/qcom/icc-rpmh.c=20
>> b/drivers/interconnect/qcom/icc-rpmh.c
>>  index bf01d09dba6c..6f93273109a3 100644
>>  --- a/drivers/interconnect/qcom/icc-rpmh.c
>>  +++ b/drivers/interconnect/qcom/icc-rpmh.c
>>  @@ -70,13 +70,13 @@ int qcom_icc_aggregate(struct icc_node *node,=20
>> u32 tag, u32 avg_bw,
>>    EXPORT_SYMBOL_GPL(qcom_icc_aggregate);
>>=20
>>    /**
>>  - * qcom_icc_set - set the constraints based on path
>>  + * qcom_icc_rpmh_set - set the constraints based on path
>>     * @src: source node for the path to set constraints on
>>     * @dst: destination node for the path to set constraints on
>>     *
>>     * Return: 0 on success, or an error code otherwise
>>     */
>>  -int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>  +int qcom_icc_rpmh_set(struct icc_node *src, struct icc_node *dst)
>=20
> This change should be splitted to a different commit, as it is not=20
> part of any
> commonization of the RPM QoS functions. This is a "global" rename, so=20
> you should
> create a preparation commit for this change.
>=20

Noted.

>>    {
>>    =09struct qcom_icc_provider *qp;
>>    =09struct qcom_icc_node *qn;
>>  @@ -99,7 +99,7 @@ int qcom_icc_set(struct icc_node *src, struct=20
>> icc_node *dst)
>>=20
>>    =09return 0;
>>    }
>>  -EXPORT_SYMBOL_GPL(qcom_icc_set);
>>  +EXPORT_SYMBOL_GPL(qcom_icc_rpmh_set);
>>=20
>>    struct icc_node_data *qcom_icc_xlate_extended(struct=20
>> of_phandle_args *spec, void *data)
>>    {
>>  diff --git a/drivers/interconnect/qcom/icc-rpmh.h=20
>> b/drivers/interconnect/qcom/icc-rpmh.h
>>  index e5f61ab989e7..5dc1049dc065 100644
>>  --- a/drivers/interconnect/qcom/icc-rpmh.h
>>  +++ b/drivers/interconnect/qcom/icc-rpmh.h
>>  @@ -130,7 +130,7 @@ struct qcom_icc_desc {
>>=20
>>    int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>>    =09=09       u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
>>  -int qcom_icc_set(struct icc_node *src, struct icc_node *dst);
>>  +int qcom_icc_rpmh_set(struct icc_node *src, struct icc_node *dst);
>=20
> Same for this.
>=20
>>    struct icc_node_data *qcom_icc_xlate_extended(struct=20
>> of_phandle_args *spec, void *data);
>>    int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device=20
>> *dev);
>>    void qcom_icc_pre_aggregate(struct icc_node *node);
>>  diff --git a/drivers/interconnect/qcom/sc7180.c=20
>> b/drivers/interconnect/qcom/sc7180.c
>>  index 8d9044ed18ab..40232b41c080 100644
>>  --- a/drivers/interconnect/qcom/sc7180.c
>>  +++ b/drivers/interconnect/qcom/sc7180.c
>>  @@ -532,7 +532,7 @@ static int qnoc_probe(struct platform_device=20
>> *pdev)
>>=20
>>    =09provider =3D &qp->provider;
>>    =09provider->dev =3D &pdev->dev;
>>  -=09provider->set =3D qcom_icc_set;
>>  +=09provider->set =3D qcom_icc_rpmh_set;
>=20
> And for this ... etc :))
>=20
>>    =09provider->pre_aggregate =3D qcom_icc_pre_aggregate;
>>    =09provider->aggregate =3D qcom_icc_aggregate;
>>    =09provider->xlate_extended =3D qcom_icc_xlate_extended;
>>  diff --git a/drivers/interconnect/qcom/sc7280.c=20
>> b/drivers/interconnect/qcom/sc7280.c
>>  index 8d1b55c3705c..b84742debc13 100644
>>  --- a/drivers/interconnect/qcom/sc7280.c
>>  +++ b/drivers/interconnect/qcom/sc7280.c
>>  @@ -1830,7 +1830,7 @@ static int qnoc_probe(struct platform_device=20
>> *pdev)
>>=20
>>    =09provider =3D &qp->provider;
>>    =09provider->dev =3D &pdev->dev;
>>  -=09provider->set =3D qcom_icc_set;
>>  +=09provider->set =3D qcom_icc_rpmh_set;
>>    =09provider->pre_aggregate =3D qcom_icc_pre_aggregate;
>>    =09provider->aggregate =3D qcom_icc_aggregate;
>>    =09provider->xlate_extended =3D qcom_icc_xlate_extended;
>>  diff --git a/drivers/interconnect/qcom/sdm660.c=20
>> b/drivers/interconnect/qcom/sdm660.c
>>  index 632dbdd21915..acd026ecd17f 100644
>>  --- a/drivers/interconnect/qcom/sdm660.c
>>  +++ b/drivers/interconnect/qcom/sdm660.c
>>  @@ -4,7 +4,6 @@
>>     * Copyright (C) 2020, AngeloGioacchino Del Regno=20
>> <kholk11@gmail.com>
>>     */
>>=20
>>  -#include <dt-bindings/interconnect/qcom,sdm660.h>
>=20
> Why did you move this header down?
> If you have a reason, this is also not part of the RPM-QoS=20
> commonization.
>=20

Must have been by mistake. I tried to keep the order of things in=20
msm8996.c similar to newer drivers, and I probably ended up editing=20
sdm660.c as well without noticing it.

> Thanks!
> - Angelo


