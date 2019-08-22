Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D8198DD1
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 10:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbfHVIfr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 04:35:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36246 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732423AbfHVIfq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 04:35:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so4852722wme.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2019 01:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GBnW032xSu60CltCPuJEjbhneu0+WvTkUl7+tZCylnI=;
        b=JMKqri4ZB5PNuNT/U1r94qHjK1ITjuQN6K4129g4oHk/APWpqMjY6qse0u+oTpKa4N
         IsZxMK7i12gqoIxas+FaRrOEsZVkftl3CE81HwF1aETTgdjDdtzd5NM68DcufIEcv2Gd
         wK+jBRnEt+9DUs5NHysQFXXHFVjWpSMeJ8w15VXwYret7N6HitaYm9R+3i2jhTxvkNAX
         Yf+I8Iojy5dzTsW6GT6ZdUOywMD6AG6EVJ875f5MitlLqYZ97sqz7q633R4cri6j+H7a
         +otge8P/DbGsuvksn6s4Q3y9+Oh9mhEpGFTTQXmKCEPDu5MP27c63CMBUEqyElPfJrkM
         3hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GBnW032xSu60CltCPuJEjbhneu0+WvTkUl7+tZCylnI=;
        b=XcfKvj8II+7tYrv0xv1QXFktGho9kT8+4Fhjngnw4divcNm8hzxU3/BWlQccenp5iV
         Zr/GMUxqbfRekR+BM899TTCiB+6xtqoboRVY1q7Uojy9/Tz18DwZXp/QrfYfk8PyOLG1
         LYBQvcPcanV0ik1tCHvQJ6erfJh98Lja9HsoEwXVkqGkEfq/GR4LQXAhpGZd1O4Yrkkc
         t1No4zY2PzF4TUuTuzDw+rak89v/Yeuquoi7SYJhFmUFDHZdhCOZTt4isX/HW/VHJLRP
         yK+4GKdeTg36N3oab0jL9UVzcR4o89Es51c19Dydm6/PZE65rDpPYVJwuo77w7HdTuHj
         RrsA==
X-Gm-Message-State: APjAAAUgkce8KS7bpxUC+7tMe4aMXJY9NX1PcCBIc2TtU7tfcZx5Ay8g
        zCIeUTpkgKYHe4FA2WOgp34ZmQ==
X-Google-Smtp-Source: APXvYqz87J5nJfsj3ECqccjSZvsCXU24QkooCTGdC3BSMvr6LbCqxcq52sXrkP0vcmz/zkXnXxXmoA==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr4724246wmj.82.1566462941510;
        Thu, 22 Aug 2019 01:35:41 -0700 (PDT)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id g7sm3280254wme.17.2019.08.22.01.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 01:35:40 -0700 (PDT)
Subject: Re: [PATCH 2/5] soc: amlogic: Add support for Everything-Else power
 domains controller
To:     Kevin Hilman <khilman@baylibre.com>, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190821114121.10430-1-narmstrong@baylibre.com>
 <20190821114121.10430-3-narmstrong@baylibre.com>
 <7hzhk25ct3.fsf@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <b6cfb770-76eb-00b1-e088-1a73b7978f33@baylibre.com>
Date:   Thu, 22 Aug 2019 10:35:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7hzhk25ct3.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/08/2019 01:16, Kevin Hilman wrote:
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
>> Add support for the General Purpose Amlogic Everything-Else Power controller,
>> with the first support for G12A and SM1 SoCs dedicated to the VPU, PCIe,
>> USB, NNA, GE2D and Ethernet Power Domains.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Nice!  Thanks for generalizing this.
> 
> A few comments/concerns below, but this is mostly ready.
> 
>> ---
>>  drivers/soc/amlogic/Kconfig         |  11 +
>>  drivers/soc/amlogic/Makefile        |   1 +
>>  drivers/soc/amlogic/meson-ee-pwrc.c | 560 ++++++++++++++++++++++++++++
>>  3 files changed, 572 insertions(+)
>>  create mode 100644 drivers/soc/amlogic/meson-ee-pwrc.c
>>
>> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
>> index 23bfb8ef4fdb..bc2c912949bd 100644
>> --- a/drivers/soc/amlogic/Kconfig
>> +++ b/drivers/soc/amlogic/Kconfig
>> @@ -37,6 +37,17 @@ config MESON_GX_PM_DOMAINS
>>  	  Say yes to expose Amlogic Meson GX Power Domains as
>>  	  Generic Power Domains.
>>  
>> +config MESON_EE_PM_DOMAINS
>> +	bool "Amlogic Meson Everything-Else Power Domains driver"
>> +	depends on ARCH_MESON || COMPILE_TEST
>> +	depends on PM && OF
>> +	default ARCH_MESON
>> +	select PM_GENERIC_DOMAINS
>> +	select PM_GENERIC_DOMAINS_OF
>> +	help
>> +	  Say yes to expose Amlogic Meson Everything-Else Power Domains as
>> +	  Generic Power Domains.
>> +
>>  config MESON_MX_SOCINFO
>>  	bool "Amlogic Meson MX SoC Information driver"
>>  	depends on ARCH_MESON || COMPILE_TEST
>> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
>> index f2e4ed171297..de79d044b545 100644
>> --- a/drivers/soc/amlogic/Makefile
>> +++ b/drivers/soc/amlogic/Makefile
>> @@ -4,3 +4,4 @@ obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
>>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
>> +obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
>> diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
>> new file mode 100644
>> index 000000000000..7159888c850b
>> --- /dev/null
>> +++ b/drivers/soc/amlogic/meson-ee-pwrc.c
>> @@ -0,0 +1,560 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (c) 2019 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of_device.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/reset.h>
>> +#include <linux/clk.h>
>> +#include <dt-bindings/power/meson-g12a-power.h>
>> +#include <dt-bindings/power/meson-sm1-power.h>
>> +
>> +/* AO Offsets */
>> +
>> +#define AO_RTI_GEN_PWR_SLEEP0		(0x3a << 2)
>> +#define AO_RTI_GEN_PWR_ISO0		(0x3b << 2)
>> +
>> +/* HHI Offsets */
>> +
>> +#define HHI_MEM_PD_REG0			(0x40 << 2)
>> +#define HHI_VPU_MEM_PD_REG0		(0x41 << 2)
>> +#define HHI_VPU_MEM_PD_REG1		(0x42 << 2)
>> +#define HHI_VPU_MEM_PD_REG3		(0x43 << 2)
>> +#define HHI_VPU_MEM_PD_REG4		(0x44 << 2)
>> +#define HHI_AUDIO_MEM_PD_REG0		(0x45 << 2)
>> +#define HHI_NANOQ_MEM_PD_REG0		(0x46 << 2)
>> +#define HHI_NANOQ_MEM_PD_REG1		(0x47 << 2)
>> +#define HHI_VPU_MEM_PD_REG2		(0x4d << 2)
>> +
>> +struct meson_ee_pwrc;
>> +struct meson_ee_pwrc_domain;
>> +
>> +struct meson_ee_pwrc_mem_domain {
>> +	unsigned int reg;
>> +	unsigned int mask;
>> +};
>> +
>> +struct meson_ee_pwrc_top_domain {
>> +	unsigned int sleep_reg;
>> +	unsigned int sleep_mask;
>> +	unsigned int iso_reg;
>> +	unsigned int iso_mask;
>> +};
>> +
>> +struct meson_ee_pwrc_domain_desc {
>> +	char *name;
>> +	char **reset_names;
>> +	unsigned int reset_names_count;
>> +	char **clk_names;
>> +	unsigned int clk_names_count;
>> +	struct meson_ee_pwrc_top_domain *top_pd;
>> +	unsigned int mem_pd_count;
>> +	struct meson_ee_pwrc_mem_domain *mem_pd;
>> +	bool (*get_power)(struct meson_ee_pwrc_domain *pwrc_domain);
>> +};
>> +
>> +struct meson_ee_pwrc_domain_data {
>> +	unsigned int count;
>> +	struct meson_ee_pwrc_domain_desc *domains;
>> +};
>> +
>> +/* Clock and Resets lists */
>> +
>> +static char *g12a_pwrc_vpu_resets[] = {
>> +	"viu", "venc", "vcbus", "bt656",
>> +	"rdma", "venci", "vencp", "vdac",
>> +	"vdi6", "vencl", "vid_lock",
>> +};
>> +
>> +static char *g12a_pwrc_vpu_clks[] = {
>> +	"vpu", "vapb",
>> +};
>> +
>> +/* TOP Power Domains */
>> +
>> +static struct meson_ee_pwrc_top_domain g12a_pwrc_vpu = {
>> +	.sleep_reg = AO_RTI_GEN_PWR_SLEEP0,
>> +	.sleep_mask = BIT(8),
>> +	.iso_reg = AO_RTI_GEN_PWR_SLEEP0,
>> +	.iso_mask = BIT(9),
>> +};
>> +
>> +#define SM1_EE_PD(__bit)					\
>> +	{							\
>> +		.sleep_reg = AO_RTI_GEN_PWR_SLEEP0, 		\
>> +		.sleep_mask = BIT(__bit), 			\
>> +		.iso_reg = AO_RTI_GEN_PWR_ISO0, 		\
>> +		.iso_mask = BIT(__bit), 			\
>> +	}
>> +
>> +static struct meson_ee_pwrc_top_domain sm1_pwrc_vpu = SM1_EE_PD(8);
>> +static struct meson_ee_pwrc_top_domain sm1_pwrc_nna = SM1_EE_PD(16);
>> +static struct meson_ee_pwrc_top_domain sm1_pwrc_usb = SM1_EE_PD(17);
>> +static struct meson_ee_pwrc_top_domain sm1_pwrc_pci = SM1_EE_PD(18);
>> +static struct meson_ee_pwrc_top_domain sm1_pwrc_ge2d = SM1_EE_PD(19);
>> +
>> +/* Memory PD Domains */
>> +
>> +#define VPU_MEMPD(__reg)					\
>> +	{ __reg, GENMASK(1, 0) },				\
>> +	{ __reg, GENMASK(3, 2) },				\
>> +	{ __reg, GENMASK(5, 4) },				\
>> +	{ __reg, GENMASK(7, 6) },				\
>> +	{ __reg, GENMASK(9, 8) },				\
>> +	{ __reg, GENMASK(11, 10) },				\
>> +	{ __reg, GENMASK(13, 12) },				\
>> +	{ __reg, GENMASK(15, 14) },				\
>> +	{ __reg, GENMASK(17, 16) },				\
>> +	{ __reg, GENMASK(19, 18) },				\
>> +	{ __reg, GENMASK(21, 20) },				\
>> +	{ __reg, GENMASK(23, 22) },				\
>> +	{ __reg, GENMASK(25, 24) },				\
>> +	{ __reg, GENMASK(27, 26) },				\
>> +	{ __reg, GENMASK(29, 28) },				\
>> +	{ __reg, GENMASK(31, 30) }
>> +
>> +#define VPU_HHI_MEMPD(__reg)					\
>> +	{ __reg, BIT(8) },					\
>> +	{ __reg, BIT(9) },					\
>> +	{ __reg, BIT(10) },					\
>> +	{ __reg, BIT(11) },					\
>> +	{ __reg, BIT(12) },					\
>> +	{ __reg, BIT(13) },					\
>> +	{ __reg, BIT(14) },					\
>> +	{ __reg, BIT(15) }
>> +
>> +static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_vpu[] = {
>> +	VPU_MEMPD(HHI_VPU_MEM_PD_REG0),
>> +	VPU_MEMPD(HHI_VPU_MEM_PD_REG1),
>> +	VPU_MEMPD(HHI_VPU_MEM_PD_REG2),
>> +	VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
>> +};
>> +
>> +static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_eth[] = {
>> +	{ HHI_MEM_PD_REG0, GENMASK(3, 2) },
>> +};
>> +
>> +static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_vpu[] = {
>> +	VPU_MEMPD(HHI_VPU_MEM_PD_REG0),
>> +	VPU_MEMPD(HHI_VPU_MEM_PD_REG1),
>> +	VPU_MEMPD(HHI_VPU_MEM_PD_REG2),
>> +	VPU_MEMPD(HHI_VPU_MEM_PD_REG3),
>> +	{ HHI_VPU_MEM_PD_REG4, GENMASK(1, 0) },
>> +	{ HHI_VPU_MEM_PD_REG4, GENMASK(3, 2) },
>> +	{ HHI_VPU_MEM_PD_REG4, GENMASK(5, 4) },
>> +	{ HHI_VPU_MEM_PD_REG4, GENMASK(7, 6) },
>> +	VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
>> +};
>> +
>> +static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_nna[] = {
>> +	{ HHI_NANOQ_MEM_PD_REG0, 0xff },
>> +	{ HHI_NANOQ_MEM_PD_REG1, 0xff },
>> +};
>> +
>> +static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_usb[] = {
>> +	{ HHI_MEM_PD_REG0, GENMASK(31, 30) },
>> +};
>> +
>> +static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_pcie[] = {
>> +	{ HHI_MEM_PD_REG0, GENMASK(29, 26) },
>> +};
>> +
>> +static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_ge2d[] = {
>> +	{ HHI_MEM_PD_REG0, GENMASK(25, 18) },
>> +};
>> +
>> +static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_audio[] = {
>> +	{ HHI_MEM_PD_REG0, GENMASK(5, 4) },
>> +	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(1, 0) },
>> +	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(3, 2) },
>> +	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(5, 4) },
>> +	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(7, 6) },
>> +	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(13, 12) },
>> +	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(15, 14) },
>> +	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(17, 16) },
>> +	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(19, 18) },
>> +	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(21, 20) },
>> +	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(23, 22) },
>> +	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(25, 24) },
>> +	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(27, 26) },
>> +};
>> +
>> +#define VPU_PD(__name, __resets, __clks, __top_pd, __mem, __get_power)	\
>> +	{								\
>> +		.name = __name,						\
>> +		.reset_names_count = ARRAY_SIZE(__resets),		\
>> +		.reset_names = __resets,				\
>> +		.clk_names_count = ARRAY_SIZE(__clks),			\
>> +		.clk_names = __clks,					\
>> +		.top_pd = __top_pd,					\
>> +		.mem_pd_count = ARRAY_SIZE(__mem),			\
>> +		.mem_pd = __mem,					\
>> +		.get_power = __get_power,				\
>> +	}
>> +
>> +#define TOP_PD(__name, __top_pd, __mem)					\
>> +	{								\
>> +		.name = __name,						\
>> +		.top_pd = __top_pd,					\
>> +		.mem_pd_count = ARRAY_SIZE(__mem),			\
>> +		.mem_pd = __mem,					\
>> +	}
> 
> Why can't the TOP_PD domains also have a __get_power().  Shouldn't we
> just be able to check the sleep_reg/sleep_mask like in the VPU case?

It can, I can add it later, do we need it for this version ?

> 
> Also, for readability, I think the arguments to VPU_PD and TOP_PD to
> have the same order, at least for the common ones.  IOW, __name,
> __top_pd, __mem should be first.

Sure, will fix

> 
>> +#define MEM_PD(__name, __mem)						\
>> +	TOP_PD(__name, NULL, __mem)
>> +
>> +static bool pwrc_vpu_get_power(struct meson_ee_pwrc_domain *pwrc_domain);
>> +
>> +static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
>> +	[PWRC_G12A_VPU_ID]  = VPU_PD("VPU", g12a_pwrc_vpu_resets,
>> +				     g12a_pwrc_vpu_clks, &g12a_pwrc_vpu,
>> +				     g12a_pwrc_mem_vpu,
>> +				     pwrc_vpu_get_power),
>> +	[PWRC_G12A_ETH_ID] = MEM_PD("ETH", g12a_pwrc_mem_eth),
>> +};
>> +
>> +static struct meson_ee_pwrc_domain_desc sm1_pwrc_domains[] = {
>> +	[PWRC_SM1_VPU_ID]  = VPU_PD("VPU", g12a_pwrc_vpu_resets,
>> +				    g12a_pwrc_vpu_clks, &sm1_pwrc_vpu,
>> +				    sm1_pwrc_mem_vpu,
>> +				    pwrc_vpu_get_power),
>> +	[PWRC_SM1_NNA_ID]  = TOP_PD("NNA", &sm1_pwrc_nna, sm1_pwrc_mem_nna),
>> +	[PWRC_SM1_USB_ID]  = TOP_PD("USB", &sm1_pwrc_usb, sm1_pwrc_mem_usb),
>> +	[PWRC_SM1_PCIE_ID] = TOP_PD("PCI", &sm1_pwrc_pci, sm1_pwrc_mem_pcie),
>> +	[PWRC_SM1_GE2D_ID] = TOP_PD("GE2D", &sm1_pwrc_ge2d, sm1_pwrc_mem_ge2d),
>> +	[PWRC_SM1_AUDIO_ID] = MEM_PD("AUDIO", sm1_pwrc_mem_audio),
>> +	[PWRC_SM1_ETH_ID] = MEM_PD("ETH", g12a_pwrc_mem_eth),
>> +};
>> +
>> +struct meson_ee_pwrc_domain {
>> +	struct generic_pm_domain base;
>> +	bool enabled;
>> +	struct meson_ee_pwrc *pwrc;
>> +	struct meson_ee_pwrc_domain_desc desc;
>> +	struct clk **clks;
>> +	int num_clks;
>> +	struct reset_control **rstc;
>> +	int num_rstc;
>> +};
>> +
>> +struct meson_ee_pwrc {
>> +	struct regmap *regmap_ao;
>> +	struct regmap *regmap_hhi;
>> +	struct meson_ee_pwrc_domain *domains;
>> +	struct genpd_onecell_data xlate;
>> +};
>> +
>> +static bool pwrc_vpu_get_power(struct meson_ee_pwrc_domain *pwrc_domain)
>> +{
>> +	u32 reg;
>> +
>> +	regmap_read(pwrc_domain->pwrc->regmap_ao,
>> +		    pwrc_domain->desc.top_pd->sleep_reg, &reg);
>> +
>> +	return (reg & pwrc_domain->desc.top_pd->sleep_mask);
>> +}
>> +
>> +static int meson_ee_reset_assert(struct meson_ee_pwrc_domain *pwrc_domain)
>> +{
>> +	int i, ret;
>> +
>> +	for (i = 0 ; i < pwrc_domain->num_rstc ; ++i) {
>> +		ret = reset_control_assert(pwrc_domain->rstc[i]);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int meson_ee_reset_deassert(struct meson_ee_pwrc_domain *pwrc_domain)
>> +{
>> +	int i, ret;
>> +
>> +	for (i = 0 ; i < pwrc_domain->num_rstc ; ++i) {
>> +		ret = reset_control_deassert(pwrc_domain->rstc[i]);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> You should use the reset_array functions, then you don't need these helpers.
> 
>> +static int meson_ee_clk_disable(struct meson_ee_pwrc_domain *pwrc_domain)
>> +{
>> +	int i;
>> +
>> +	for (i = 0 ; i < pwrc_domain->num_clks ; ++i)
>> +		clk_disable(pwrc_domain->clks[i]);
>> +
>> +	for (i = 0 ; i < pwrc_domain->num_clks ; ++i)
>> +		clk_unprepare(pwrc_domain->clks[i]);
>> +
>> +	return 0;
>> +}
>> +
>> +static int meson_ee_clk_enable(struct meson_ee_pwrc_domain *pwrc_domain)
>> +{
>> +	int i, ret;
>> +
>> +	for (i = 0 ; i < pwrc_domain->num_clks ; ++i) {
>> +		ret = clk_prepare(pwrc_domain->clks[i]);
>> +		if (ret)
>> +			goto fail_prepare;
>> +	}
>> +
>> +	for (i = 0 ; i < pwrc_domain->num_clks ; ++i) {
>> +		ret = clk_enable(pwrc_domain->clks[i]);
>> +		if (ret)
>> +			goto fail_enable;
>> +	}
>> +
>> +	return 0;
>> +fail_enable:
>> +	while (--i)
>> +		clk_disable(pwrc_domain->clks[i]);
>> +
>> +	/* Unprepare all clocks */
>> +	i = pwrc_domain->num_clks;
>> +
>> +fail_prepare:
>> +	while (--i)
>> +		clk_unprepare(pwrc_domain->clks[i]);
>> +
>> +	return ret;
>> +}
> 
> Both the clk enable and disable functions above are just open-coding of
> the clk_bulk equivalents.  Please use clk_bulk_*, then you don't need
> these helpers.  (c.f. the RFT patch I did to convert the old driver to
> clk_bulk[1])

Yes, but clk_bulk takes _all_ the clocks from the node, you canot specify
a list of names, maybe it's overengineered but I wanted to specify the
exact resets and clocks for each power domain, clk_bulk doesn't provide this.

> 
>> +static int meson_ee_pwrc_off(struct generic_pm_domain *domain)
>> +{
>> +	struct meson_ee_pwrc_domain *pwrc_domain =
>> +		container_of(domain, struct meson_ee_pwrc_domain, base);
>> +	int i;
>> +
>> +	if (pwrc_domain->desc.top_pd)
>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
>> +				   pwrc_domain->desc.top_pd->sleep_reg,
>> +				   pwrc_domain->desc.top_pd->sleep_mask,
>> +				   pwrc_domain->desc.top_pd->sleep_mask);
>> +	udelay(20);
>> +
>> +	for (i = 0 ; i < pwrc_domain->desc.mem_pd_count ; ++i)
>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_hhi,
>> +				   pwrc_domain->desc.mem_pd[i].reg,
>> +				   pwrc_domain->desc.mem_pd[i].mask,
>> +				   pwrc_domain->desc.mem_pd[i].mask);
>> +
>> +	udelay(20);
>> +
>> +	if (pwrc_domain->desc.top_pd)
>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
>> +				   pwrc_domain->desc.top_pd->iso_reg,
>> +				   pwrc_domain->desc.top_pd->iso_mask,
>> +				   pwrc_domain->desc.top_pd->iso_mask);
>> +
>> +	if (pwrc_domain->num_clks) {
>> +		msleep(20);
>> +		meson_ee_clk_disable(pwrc_domain);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int meson_ee_pwrc_on(struct generic_pm_domain *domain)
>> +{
>> +	struct meson_ee_pwrc_domain *pwrc_domain =
>> +		container_of(domain, struct meson_ee_pwrc_domain, base);
>> +	int i, ret;
>> +
>> +	if (pwrc_domain->desc.top_pd)
>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
>> +				   pwrc_domain->desc.top_pd->sleep_reg,
>> +				   pwrc_domain->desc.top_pd->sleep_mask, 0);
>> +	udelay(20);
>> +
>> +	for (i = 0 ; i < pwrc_domain->desc.mem_pd_count ; ++i)
>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_hhi,
>> +				   pwrc_domain->desc.mem_pd[i].reg,
>> +				   pwrc_domain->desc.mem_pd[i].mask, 0);
>> +
>> +	udelay(20);
>> +
>> +	ret = meson_ee_reset_assert(pwrc_domain);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (pwrc_domain->desc.top_pd)
>> +		regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
>> +				   pwrc_domain->desc.top_pd->iso_reg,
>> +				   pwrc_domain->desc.top_pd->iso_mask, 0);
>> +
>> +	ret = meson_ee_reset_deassert(pwrc_domain);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return meson_ee_clk_enable(pwrc_domain);
>> +}
>> +
>> +static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
>> +				     struct meson_ee_pwrc *sm1_pwrc,
>> +				     struct meson_ee_pwrc_domain *dom)
>> +{
>> +	dom->pwrc = sm1_pwrc;
>> +	dom->num_rstc = dom->desc.reset_names_count;
>> +	dom->num_clks = dom->desc.clk_names_count;
>> +
>> +	if (dom->num_rstc) {
>> +		int rst;
>> +
>> +		dom->rstc = devm_kcalloc(&pdev->dev, dom->num_rstc,
>> +				sizeof(struct reset_control *),	GFP_KERNEL);
>> +		if (!dom->rstc)
>> +			return -ENOMEM;
>> +
>> +		for (rst = 0 ; rst < dom->num_rstc ; ++rst) {
>> +			dom->rstc[rst] = devm_reset_control_get_exclusive(
>> +					&pdev->dev,
>> +					dom->desc.reset_names[rst]);
>> +			if (IS_ERR(dom->rstc[rst]))
>> +				return PTR_ERR(dom->rstc[rst]);
>> +		}
> 
> Why not simplify and use the helpers that get multiple reset lines (like
> devm_reset_control_array_get() used in meson-gx-pwrc-vpu.c)?

Same comment as clk_bulk, we cannot be sure we select the right reset lines.

> 
> You could also use reset_control_get_count() and compare to the expected
> number (dom->num_rstc).

This seems oversimplified

> 
>> +	}
>> +
>> +	if (dom->num_clks) {
>> +		int clk;
>> +
>> +		dom->clks = devm_kcalloc(&pdev->dev, dom->num_clks,
>> +				sizeof(struct clk *), GFP_KERNEL);
>> +		if (!dom->clks)
>> +			return -ENOMEM;
>> +
>> +		for (clk = 0 ; clk < dom->num_clks ; ++clk) {
>> +			dom->clks[clk] = devm_clk_get(&pdev->dev,
>> +					dom->desc.clk_names[clk]);
>> +			if (IS_ERR(dom->clks[clk]))
>> +				return PTR_ERR(dom->clks[clk]);
>> +		}
>> +	}
> 
> Please use clk_bulk API, and then just double-check that the number of
> clocks found matches the expected number.

Same, I'll either take all the clks and resets for the vpu power domain,
or keep this code to make sure we get the right clocks and resets.

> 
>> +	dom->base.name = dom->desc.name;
>> +	dom->base.power_on = meson_ee_pwrc_on;
>> +	dom->base.power_off = meson_ee_pwrc_off;
>> +
>> +	if (dom->desc.get_power) {
>> +		bool powered_off = dom->desc.get_power(dom);
> 
> nit: insert blank line here
> 
> More importantly, we defintely will have problem here in the
> !powered_off case.  TL;DR; the driver's state does not match the actual
> hardware state.
> 
> When powered_off = false, you're telling the genpd core that this domain
> is already turned on.  However, you haven't called _pwrc_on() yet for
> the domain, which means internal state of the driver for this domain
> (e.g. clock enables, resets, etc.) is not in sync with the HW.  On
> SEI610 this case is happending for the VPU, which seems to be enabled by
> u-boot, so this driver detects it as already on, which is fine.  But...
> 
> Remember that the ->power_off() function will be called during suspend,
> and will lead to the clk unprepare/disable calls.  However, for domains
> that are detected as on (!powered_off), clk prepare/enable will never
> have been called, so that when suspend happens, you'll get "already
> unprepared" errors from the clock core
> 
> IOW, I think you need something like this here:
> 
> 		if (!powered_off)
> 			meson_ee_pwrc_on(&dom->base);
> 
> so that the internal state of clock fwk etc. matches the detected state
> of the HW.  The problem with that simple fix, at least for the VPU is
> that it might cause us to lose any existing display or framebuffer
> console that's on-going.  Probably needs some testing.

Yes, I forgot to take the _shutdown() function from gx_pwrc_vpu driver :

349 static void meson_gx_pwrc_vpu_shutdown(struct platform_device *pdev)
350 {
351         struct meson_gx_pwrc_vpu *vpu_pd = platform_get_drvdata(pdev);
352         bool powered_off;
353
354         powered_off = meson_gx_pwrc_vpu_get_power(vpu_pd);
355         if (!powered_off)
356                 vpu_pd->genpd.power_off(&vpu_pd->genpd);
357 }

> 
> Anyways, to see what I mean, try suspend/resume (you can test this
> series on my integ branch with "rtcwake -d rtc0 -m mem -s4") and you'll
> see error splats from the clock core during suspend.
> 
> 
> 
>> +		pm_genpd_init(&dom->base, &pm_domain_always_on_gov,
>> +			      powered_off);
> 
>> +	} else
>> +		pm_genpd_init(&dom->base, NULL, true);
> 
> nit: the else clause should also have {} to match the if
> (c.f. CodingStyle)

OK

> 
> Why do you force the always-on governor in the case where ->get_power()
> exists, but not the other?
> 
> If you force that, then for any devices connected to these domains that
> use runtime PM, they will never turn off the domain when it's idle.
> IOW, these domains will only ever be turned off on system-wide
> suspend/resume.
> 
> IMO, unless there's a good reason not to, you should pass NULL for the
> governor.

It's for legacy when VPU is initialized from vendor U-Boot, look at commit :
339cd0ea082287ea8e2b7e7159a5a33665a2cbe3 "soc: amlogic: meson-gx-pwrc-vpu: fix power-off when powered by bootloader"

    In the case the VPU power domain has been powered on by the bootloader
    and no driver are attached to this power domain, the genpd will power it
    off after a certain amount of time, but the clocks hasn't been enabled
    by the kernel itself and the power-off will trigger some faults.
    This patch enable the clocks to have a coherent state for an eventual
    poweroff and switches to the pm_domain_always_on_gov governor.

I could set always-on governor only if the domain was already enabled,
what do you think ?

And seems I'm also missing the "This patch enable the clocks".

> 
>> +	return 0;
>> +}
>> +
>> +static int meson_ee_pwrc_probe(struct platform_device *pdev)
>> +{
>> +	const struct meson_ee_pwrc_domain_data *match;
>> +	struct regmap *regmap_ao, *regmap_hhi;
>> +	struct meson_ee_pwrc *sm1_pwrc;
> 
> Why the sm1_ prefix throughout this code?  This is now generalized for
> more SoCs, so shouldn't be sm1.  I'm assuming this is just left-over
> from the original version.  IMO, just called it pwrc.

Indeed, it's a leftover.

> 
>> +	int i, ret;
>> +
>> +	match = of_device_get_match_data(&pdev->dev);
>> +	if (!match) {
>> +		dev_err(&pdev->dev, "failed to get match data\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	sm1_pwrc = devm_kzalloc(&pdev->dev, sizeof(*sm1_pwrc), GFP_KERNEL);
>> +	if (!sm1_pwrc)
>> +		return -ENOMEM;
>> +
>> +	sm1_pwrc->xlate.domains =
>> +		devm_kcalloc(&pdev->dev,
>> +			     match->count,
>> +			     sizeof(*sm1_pwrc->xlate.domains),
>> +			     GFP_KERNEL);
>> +	if (!sm1_pwrc->xlate.domains)
>> +		return -ENOMEM;
>> +
>> +	sm1_pwrc->domains =
>> +		devm_kcalloc(&pdev->dev,
> 
> nit: this line probably doesn't need to be wrapped.

Ok

> 
>> +			     match->count,
>> +			     sizeof(*sm1_pwrc->domains),
>> +			     GFP_KERNEL);
>> +	if (!sm1_pwrc->domains)
>> +		return -ENOMEM;
>> +
>> +	sm1_pwrc->xlate.num_domains = match->count;
>> +
>> +	regmap_hhi = syscon_node_to_regmap(of_get_parent(pdev->dev.of_node));
>> +	if (IS_ERR(regmap_hhi)) {
>> +		dev_err(&pdev->dev, "failed to get HHI regmap\n");
>> +		return PTR_ERR(regmap_hhi);
>> +	}
>> +
>> +	regmap_ao = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>> +						    "amlogic,ao-sysctrl");
>> +	if (IS_ERR(regmap_ao)) {
>> +		dev_err(&pdev->dev, "failed to get AO regmap\n");
>> +		return PTR_ERR(regmap_ao);
>> +	}
>> +
>> +	sm1_pwrc->regmap_ao = regmap_ao;
>> +	sm1_pwrc->regmap_hhi = regmap_hhi;
>> +
>> +	platform_set_drvdata(pdev, sm1_pwrc);
>> +
>> +	for (i = 0 ; i < match->count ; ++i) {
>> +		struct meson_ee_pwrc_domain *dom = &sm1_pwrc->domains[i];
>> +
>> +		memcpy(&dom->desc, &match->domains[i], sizeof(dom->desc));
>> +
>> +		ret = meson_ee_pwrc_init_domain(pdev, sm1_pwrc, dom);
>> +		if (ret)
>> +			return ret;
>> +
>> +		sm1_pwrc->xlate.domains[i] = &dom->base;
>> +	}
>> +
>> +	of_genpd_add_provider_onecell(pdev->dev.of_node, &sm1_pwrc->xlate);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct meson_ee_pwrc_domain_data meson_ee_g12a_pwrc_data = {
>> +	.count = ARRAY_SIZE(g12a_pwrc_domains),
>> +	.domains = g12a_pwrc_domains,
>> +};
>> +
>> +static struct meson_ee_pwrc_domain_data meson_ee_sm1_pwrc_data = {
>> +	.count = ARRAY_SIZE(sm1_pwrc_domains),
>> +	.domains = sm1_pwrc_domains,
>> +};
>> +
>> +static const struct of_device_id meson_ee_pwrc_match_table[] = {
>> +	{
>> +		.compatible = "amlogic,meson-g12a-pwrc",
>> +		.data = &meson_ee_g12a_pwrc_data,
>> +	},
>> +	{
>> +		.compatible = "amlogic,meson-sm1-pwrc",
>> +		.data = &meson_ee_sm1_pwrc_data,
>> +	},
>> +	{ /* sentinel */ }
>> +};
>> +
>> +static struct platform_driver meson_ee_pwrc_driver = {
>> +	.probe	= meson_ee_pwrc_probe,
>> +	.driver = {
>> +		.name		= "meson_ee_pwrc",
>> +		.of_match_table	= meson_ee_pwrc_match_table,
>> +	},
>> +};
>> +builtin_platform_driver(meson_ee_pwrc_driver);
>> -- 
>> 2.22.0

Thanks,
Neil

> 
> Kevin
> 
> [1] https://lore.kernel.org/linux-amlogic/20190809230904.28747-1-khilman@baylibre.com/
> 

