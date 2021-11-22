Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2542459521
	for <lists+linux-pm@lfdr.de>; Mon, 22 Nov 2021 19:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhKVSz6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Nov 2021 13:55:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233806AbhKVSz3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Nov 2021 13:55:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88DB660187;
        Mon, 22 Nov 2021 18:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637607142;
        bh=iSx3WxKNM78WB0szNiNtunoYOvJloAsNWxUjSZiBZro=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WdtTZd+9UUe+o8uXecf4D7OaN6GKTom55Hc4+QV0yF/pBYieY5ek0UuEytw187NLF
         pmAV4Qb/YKbtVQglYwvI5IDIpsk3wMKhIP07bIDP1JHCIpxE/EBgxLGGVc2g4jf6Z2
         S73LzbrUoiKqQ1Glu1s9sNBBRUytLoaRtqO/44kmWz0wA5YXhVNMbMd9kXkujCF36z
         vh40+c6v9JvbCdz3etHQD3wdJ06qD/uaBEVZYMzYndjYZrayDy2L1RT9CZmOA96ezm
         HT3cTjTTnml6ZenDjYNnbmbfPsprCskSQod9IQQEVo3U6Ihpael/0eKYZyQGGk+7/e
         DpcSB1tGmVF4g==
Message-ID: <ef607d90-b10d-cb2c-b3c3-7784d1b7adb6@kernel.org>
Date:   Mon, 22 Nov 2021 20:52:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v5 4/5] interconnect: qcom: Add MSM8996
 interconnect provider driver
Content-Language: en-US
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20211021132329.234942-1-y.oudjana@protonmail.com>
 <20211021132329.234942-5-y.oudjana@protonmail.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20211021132329.234942-5-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Yassine,

On 21.10.21 16:25, Yassine Oudjana wrote:
> Add a driver for the MSM8996 NoCs. This chip is similar to SDM660 where
> some busses are controlled by RPM, while others directly by the AP with
> writes to QoS registers
Thank you for working on this!

> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
> Changes since v4:
>   - Rebase on Dmitry's icc-rpm patches.
>   - Clean up qcom_icc_node structs by removing unused properties, moving links to external
>     arrays and using the same arrays for multiple nodes where possible.
>   - Add support for Aggregate 0 NoC (a0noc).
> Changes since v3:
>   - Expand DEFINE_QNODE macros in msm8996.c.
>   - Commonize probe function.
>   - Code style fixes.
> 
>   drivers/interconnect/qcom/Kconfig   |    9 +
>   drivers/interconnect/qcom/Makefile  |    2 +
>   drivers/interconnect/qcom/msm8996.c | 2113 +++++++++++++++++++++++++++
>   drivers/interconnect/qcom/msm8996.h |  149 ++
>   4 files changed, 2273 insertions(+)
>   create mode 100644 drivers/interconnect/qcom/msm8996.c
>   create mode 100644 drivers/interconnect/qcom/msm8996.h
> 
[..]
> +
> +static struct qcom_icc_node mas_ufs = {
> +	.name = "mas_ufs",
> +	.id = MSM8996_MASTER_UFS,
> +	.buswidth = 8,
> +	.mas_rpm_id = 68,
> +	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_FIXED,
> +	.qos.areq_prio = 1,
> +	.qos.prio_level = 1,
> +	.qos.qos_port = 2,
> +	.num_links = 1,

This line should be removed, as we use ARRAY_SIZE below.

> +	.num_links = ARRAY_SIZE(mas_a2noc_common_links),
> +	.links = mas_a2noc_common_links
> +};
> +
> +static const u16 mas_apps_proc_links[] = {
> +	MSM8996_SLAVE_BIMC_SNOC_1,
> +	MSM8996_SLAVE_EBI_CH0,
> +	MSM8996_SLAVE_BIMC_SNOC_0
> +};
> +
[..]
> +
> +static struct qcom_icc_node mas_snoc_cnoc = {
> +	.name = "mas_snoc_cnoc",
> +	.id = MSM8996_MASTER_SNOC_CNOC,
> +	.buswidth = 8,
> +	.mas_rpm_id = 52,
> +	.slv_rpm_id = -1,
> +	.num_links = 37,

Ditto.

> +	.num_links = ARRAY_SIZE(mas_snoc_cnoc_links),
> +	.links = mas_snoc_cnoc_links
> +};
> +
[..]
> +static struct qcom_icc_node mas_sdcc_2 = {
> +	.name = "mas_sdcc_2",
> +	.id = MSM8996_MASTER_SDCC_2,
> +	.buswidth = 8,
> +	.mas_rpm_id = 35,
> +	.slv_rpm_id = -1,
> +	.num_links = 1,

Ditto.

> +	.num_links = ARRAY_SIZE(mas_pnoc_a1noc_common_links),
> +	.links = mas_pnoc_a1noc_common_links
> +};
> +
> +static struct qcom_icc_node mas_sdcc_4 = {
> +	.name = "mas_sdcc_4",
> +	.id = MSM8996_MASTER_SDCC_4,
> +	.buswidth = 8,
> +	.mas_rpm_id = 36,
> +	.slv_rpm_id = -1,
> +	.num_links = 1,

Ditto.

> +	.num_links = ARRAY_SIZE(mas_pnoc_a1noc_common_links),
> +	.links = mas_pnoc_a1noc_common_links
> +};
> +
> +static struct qcom_icc_node mas_usb_hs = {
> +	.name = "mas_usb_hs",
> +	.id = MSM8996_MASTER_USB_HS,
> +	.buswidth = 8,
> +	.mas_rpm_id = 42,
> +	.slv_rpm_id = -1,
> +	.num_links = 1,

Ditto.

> +	.num_links = ARRAY_SIZE(mas_pnoc_a1noc_common_links),
> +	.links = mas_pnoc_a1noc_common_links
> +};
> +
> +static struct qcom_icc_node mas_blsp_1 = {
> +	.name = "mas_blsp_1",
> +	.id = MSM8996_MASTER_BLSP_1,
> +	.buswidth = 4,
> +	.mas_rpm_id = 41,
> +	.slv_rpm_id = -1,
> +	.num_links = 1,

Ditto.

> +	.num_links = ARRAY_SIZE(mas_pnoc_a1noc_common_links),
> +	.links = mas_pnoc_a1noc_common_links
> +};
> +
> +static struct qcom_icc_node mas_blsp_2 = {
> +	.name = "mas_blsp_2",
> +	.id = MSM8996_MASTER_BLSP_2,
> +	.buswidth = 4,
> +	.mas_rpm_id = 39,
> +	.slv_rpm_id = -1,
> +	.num_links = 1,

Ditto.

> +	.num_links = ARRAY_SIZE(mas_pnoc_a1noc_common_links),
> +	.links = mas_pnoc_a1noc_common_links
> +};
> +
> +static struct qcom_icc_node mas_tsif = {
> +	.name = "mas_tsif",
> +	.id = MSM8996_MASTER_TSIF,
> +	.buswidth = 4,
> +	.mas_rpm_id = 37,
> +	.slv_rpm_id = -1,
> +	.num_links = 1,

Ditto.

> +	.num_links = ARRAY_SIZE(mas_pnoc_a1noc_common_links),
> +	.links = mas_pnoc_a1noc_common_links
> +};
> +
[..]
> +static struct qcom_icc_node slv_a2noc_snoc = {
> +	.name = "slv_a2noc_snoc",
> +	.id = MSM8996_SLAVE_A2NOC_SNOC,
> +	.buswidth = 8,
> +	.mas_rpm_id = -1,
> +	.slv_rpm_id = 143,
> +	.num_links = 1,

Ditto.

> +	.num_links = ARRAY_SIZE(slv_a2noc_snoc_links),
> +	.links = slv_a2noc_snoc_links
> +};
> +
[..]
> +
> +static const u16 slv_snoc_bimc_links[] = {
> +	MSM8996_MASTER_SNOC_BIMC
> +};
> +
> +static struct qcom_icc_node slv_snoc_bimc = {
> +	.name = "slv_snoc_bimc",
> +	.id = MSM8996_SLAVE_SNOC_BIMC,
> +	.buswidth = 32,
> +	.mas_rpm_id = -1,
> +	.slv_rpm_id = 24,
> +	.num_links = 1,

Ditto.

> +	.num_links = ARRAY_SIZE(slv_snoc_bimc_links),
> +	.links = slv_snoc_bimc_links
> +};
> +
[..]

I have fixed the above issue and applied patches 1-4.

Thanks,
Georgi
