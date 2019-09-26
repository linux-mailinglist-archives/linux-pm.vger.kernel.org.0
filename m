Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 776B3BEE43
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 11:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfIZJRJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Sep 2019 05:17:09 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:13802 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbfIZJRI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2019 05:17:08 -0400
Received: from [10.18.29.226] (10.18.29.226) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 26 Sep
 2019 17:17:06 +0800
Subject: Re: [PATCH 2/3] soc: amlogic: Add support for Secure power domains
 controller
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Zhiqiang Liang <zhiqiang.liang@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
References: <1568895064-4116-1-git-send-email-jianxin.pan@amlogic.com>
 <1568895064-4116-3-git-send-email-jianxin.pan@amlogic.com>
 <7hh850t2wy.fsf@baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <3859c748-01f0-4dbd-05d6-20fff31edf11@amlogic.com>
Date:   Thu, 26 Sep 2019 17:17:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7hh850t2wy.fsf@baylibre.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.226]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kevin,

Thanks for your review. Please see my comments below.


On 2019/9/26 6:41, Kevin Hilman wrote:
> Hi Jianxin,
> 
> Jianxin Pan <jianxin.pan@amlogic.com> writes:
> 
>> Add support for the Amlogic Secure Power controller. In A1/C1 series, power
>> control registers are in secure domain, and should be accessed by smc.
>>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> Signed-off-by: Zhiqiang Liang <zhiqiang.liang@amlogic.com>
> 
> Thanks for the new power domain driver.
> 
>> ---
>>  drivers/soc/amlogic/Kconfig             |  13 +++
>>  drivers/soc/amlogic/Makefile            |   1 +
>>  drivers/soc/amlogic/meson-secure-pwrc.c | 182 ++++++++++++++++++++++++++++++++
>>  3 files changed, 196 insertions(+)
>>  create mode 100644 drivers/soc/amlogic/meson-secure-pwrc.c
>>
>> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
>> index bc2c912..6cb06e7 100644
>> --- a/drivers/soc/amlogic/Kconfig
>> +++ b/drivers/soc/amlogic/Kconfig
>> @@ -48,6 +48,19 @@ config MESON_EE_PM_DOMAINS
>>  	  Say yes to expose Amlogic Meson Everything-Else Power Domains as
>>  	  Generic Power Domains.
>>  
>> +config MESON_SECURE_PM_DOMAINS
>> +	bool "Amlogic Meson Secure Power Domains driver"
>> +	depends on ARCH_MESON || COMPILE_TEST
>> +	depends on PM && OF
>> +	depends on HAVE_ARM_SMCCC
>> +	default ARCH_MESON
>> +	select PM_GENERIC_DOMAINS
>> +	select PM_GENERIC_DOMAINS_OF
>> +	help
>> +	  Support for the power controller on Amlogic A1/C1 series.
>> +	  Say yes to expose Amlogic Meson Secure Power Domains as Generic
>> +	  Power Domains.
>> +
>>  config MESON_MX_SOCINFO
>>  	bool "Amlogic Meson MX SoC Information driver"
>>  	depends on ARCH_MESON || COMPILE_TEST
>> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
>> index de79d044..7b8c5d3 100644
>> --- a/drivers/soc/amlogic/Makefile
>> +++ b/drivers/soc/amlogic/Makefile
>> @@ -5,3 +5,4 @@ obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
>>  obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
>> +obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
>> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
>> new file mode 100644
>> index 00000000..00c7232
>> --- /dev/null
>> +++ b/drivers/soc/amlogic/meson-secure-pwrc.c
>> @@ -0,0 +1,182 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
[...]
>> +
>> +static bool pwrc_secure_get_power(struct meson_secure_pwrc_domain *pwrc_domain)
>> +{
>> +	struct arm_smccc_res res;
>> +
>> +	arm_smccc_smc(SMC_PWRC_GET, pwrc_domain->index, 0,
>> +		      0, 0, 0, 0, 0, &res);
>> +
>> +	return res.a0 & 0x1;
> 
> Please use a #define with a readable name for this mask.
> The return type of this smc is bool. I will remove 0x1 mask in next version. 

Another question about smc:
In this driver, no share memory is needed, and I use arm_smccc_smc() directly.
Should I add secure-monitor = <&sm> in dtb and use meson_sm_call() from sm driver instead? 
>> +}
> 
> What does the return value for this function mean?  Does true mean
> "powered off" or "powered on">
The return vaule for SMC_PWRC_GET :
0 -> power on
1 -> power off> See the rename I just did on the ee-pwrc driver:
> https://lore.kernel.org/linux-amlogic/20190925213528.21515-2-khilman@kernel.org/
> I will follow and rename to _is_off() in the next verson.
>> +static int meson_secure_pwrc_off(struct generic_pm_domain *domain)
>> +{
>> +	struct arm_smccc_res res;
>> +	struct meson_secure_pwrc_domain *pwrc_domain =
[...]
>> +
>> +#define SEC_PD(__name, __flag)			\
>> +{						\
>> +	.name = #__name,			\
>> +	.index = PWRC_##__name##_ID,		\
>> +	.get_power = pwrc_secure_get_power,	\
>> +	.flags = __flag,			\
>> +}
>> +
>> +static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
>> +	SEC_PD(DSPA,	0),
>> +	SEC_PD(DSPB,	0),
>> +	SEC_PD(UART,	GENPD_FLAG_ALWAYS_ON),
> 
> This flag should only be used for domains where there are no linux
> drivers.
> 
> Rather than using this flag, you need to add a 'power-domain' property
> to the uart driver in DT, and then update the meson_uart driver to use
> the runtime PM API so that the domain is enabled whenever the UART is in
> use.
PM_UART Power domain is shared by uart, msr, jtag and cec.
Uart should keep working in BL31, after kernel suspend and before kernel resume.
> 
>> +	SEC_PD(DMC,	GENPD_FLAG_ALWAYS_ON),
> 
> Please explain the need for ALWAYS_ON.
> 
PM_DMC is used for DDR PHY ana/dig and DMC. 
There is no linux drver for them, and it should be always on. 

I will add comments for all these always on domains.
>> +	SEC_PD(I2C,	0),
>> +	SEC_PD(PSRAM,	0),
>> +	SEC_PD(ACODEC,	0),
>> +	SEC_PD(AUDIO,	0),
>> +	SEC_PD(OTP,	0),
>> +	SEC_PD(DMA,	0),
>> +	SEC_PD(SD_EMMC,	0),
>> +	SEC_PD(RAMA,	0),
>> +	SEC_PD(RAMB,	GENPD_FLAG_ALWAYS_ON),
> 
> Please explain the need for ALWAYS_ON.
> 
In A1, SRAMB is used for bl31 ATF. 
>> +	SEC_PD(IR,	0),
>> +	SEC_PD(SPICC,	0),
>> +	SEC_PD(SPIFC,	0),
>> +	SEC_PD(USB,	0),
>> +	SEC_PD(NIC,	GENPD_FLAG_ALWAYS_ON),
> 
> Please explain the need for ALWAYS_ON.
> 
PD_NIC is used for NIC400, and should keep on.
>> +	SEC_PD(PDMIN,	0),
>> +	SEC_PD(RSA,	0),
>> +};
>> +
>> +static int meson_secure_pwrc_probe(struct platform_device *pdev)
>> +{
>> +	const struct meson_secure_pwrc_domain_data *match;
>> +	struct meson_secure_pwrc *pwrc;
>> +	int i;
[...]
>> +
>> +	return of_genpd_add_provider_onecell(pdev->dev.of_node, &pwrc->xlate);
>> +}
>> +
>> +static struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data = {
>> +	.domains = a1_pwrc_domains,
>> +	.count = ARRAY_SIZE(a1_pwrc_domains),
>> +};
>> +
>> +static const struct of_device_id meson_secure_pwrc_match_table[] = {
>> +	{
>> +		.compatible = "amlogic,meson-a1-pwrc",
>> +		.data = &meson_secure_a1_pwrc_data,
>> +	},
>> +	{ }
> 
> as mentioned by Martin, please add the sentinel string here.  Helps for
> readability.
> 
OK, I will fix it. Thank you.
>> +};
>> +
>> +static struct platform_driver meson_secure_pwrc_driver = {
>> +	.probe = meson_secure_pwrc_probe,
>> +	.driver = {
>> +		.name		= "meson_secure_pwrc",
>> +		.of_match_table	= meson_secure_pwrc_match_table,
>> +	},
>> +};
>> +
>> +static int meson_secure_pwrc_init(void)
>> +{
>> +	return platform_driver_register(&meson_secure_pwrc_driver);
>> +}
>> +arch_initcall_sync(meson_secure_pwrc_init);
> 
> Please use builtin_platform_driver() or explain in detail why the
> initcall is needed.
> 
OK, I will use builtin_platform_driver instead.
> Thanks,
> 
> Kevin
> 
> .
> 

