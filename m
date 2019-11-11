Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD96F736C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 12:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfKKLxE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 06:53:04 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:14190 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKKLxE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 06:53:04 -0500
Received: from [10.18.29.227] (10.18.29.227) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 11 Nov
 2019 19:53:21 +0800
Subject: Re: [PATCH v4 3/4] soc: amlogic: Add support for Secure power domains
 controller
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
References: <1572868028-73076-1-git-send-email-jianxin.pan@amlogic.com>
 <1572868028-73076-4-git-send-email-jianxin.pan@amlogic.com>
 <7hmud4stfo.fsf@baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <57b9c706-c341-c7cf-698a-66335b34442b@amlogic.com>
Date:   Mon, 11 Nov 2019 19:53:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7hmud4stfo.fsf@baylibre.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.227]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kevin,

Thanks for the review, please see the comments below:

2019/11/10 4:09, Kevin Hilman wrote:
> Hi Jianxin,
> 
> Jianxin Pan <jianxin.pan@amlogic.com> writes:
> 
>> Add support for the Amlogic Secure Power controller. In A1/C1 series, power
>> control registers are in secure domain, and should be accessed by smc.
>>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> 
> This driver is looking pretty good.  A few more minor comments below.
> 
> [...]
> 
>> +static bool pwrc_secure_is_off(struct meson_secure_pwrc_domain *pwrc_domain)
>> +{
>> +	int sts = 1;
> 
> What does 'sts' mean?  status?  or something else?  Please use a more
> descriptive name.
> 
>> +	if (meson_sm_call(pwrc_domain->pwrc->fw, SM_PWRC_GET, &sts,
>> +			  pwrc_domain->index, 0, 0, 0, 0) < 0)
>> +		pr_err("failed to get power domain status\n");
> 
> Does any bit in this register mean the power domain is off?  I think it
> would be better (and more future proof) if you checked the specific bit
> (or mask)
> 
sts=1 means, the domain is powered off. I can rename it to is_off in the next version.
now, only bit[0] is used in BL31, so I can use sts directly instead of !!sts.
>> +	return !!sts;
> 
> and then:
> 
>     return sts & bitmask;
>     
>> +}
>> +
>> +static int meson_secure_pwrc_off(struct generic_pm_domain *domain)
>> +{
>> +	int sts = 0;
> 
> Like above, what does sts mean?
> 
>> +	struct meson_secure_pwrc_domain *pwrc_domain =
>> +		container_of(domain, struct meson_secure_pwrc_domain, base);
>> +
>> +	if (meson_sm_call(pwrc_domain->pwrc->fw, SM_PWRC_SET, NULL,
>> +			  pwrc_domain->index, PWRC_OFF, 0, 0, 0) < 0) {
>> +		pr_err("failed to set power domain off\n");
>> +		sts = -EINVAL;
>> +	}
>> +
>> +	return sts;
> 
> It looks to me like sts is only used as a return code, so maybe call it
> ret for clarity?  or rename it to something more descriptive.
> 
sts here indicates if smc call is failed (such as due to inlvaid command id). I can rename it to ret in the next version.
>> +}
>> +
>> +static int meson_secure_pwrc_on(struct generic_pm_domain *domain)
>> +{
>> +	int sts = 0;
>> +	struct meson_secure_pwrc_domain *pwrc_domain =
>> +		container_of(domain, struct meson_secure_pwrc_domain, base);
>> +
>> +	if (meson_sm_call(pwrc_domain->pwrc->fw, SM_PWRC_SET, NULL,
>> +			  pwrc_domain->index, PWRC_ON, 0, 0, 0) < 0) {
>> +		pr_err("failed to set power domain on\n");
>> +		sts = -EINVAL;
>> +	}
>> +
>> +	return sts;
> 
> same comment as above.
> 
OK, I will fix it.
>> +}
>> +
>> +#define SEC_PD(__name, __flag)			\
>> +[PWRC_##__name##_ID] =				\
>> +{						\
>> +	.name = #__name,			\
>> +	.index = PWRC_##__name##_ID,		\
>> +	.is_off = pwrc_secure_is_off,	\
>> +	.flags = __flag,			\
>> +}
>> +
>> +static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
>> +	SEC_PD(DSPA,	0),
>> +	SEC_PD(DSPB,	0),
>> +	/* UART should keep working in ATF after suspend and before resume */
>> +	SEC_PD(UART,	GENPD_FLAG_ALWAYS_ON),
>> +	/* DMC is for DDR PHY ana/dig and DMC, and should be always on */
>> +	SEC_PD(DMC,	GENPD_FLAG_ALWAYS_ON),
>> +	SEC_PD(I2C,	0),
>> +	SEC_PD(PSRAM,	0),
>> +	SEC_PD(ACODEC,	0),
>> +	SEC_PD(AUDIO,	0),
>> +	SEC_PD(OTP,	0),
>> +	SEC_PD(DMA,	0),
>> +	SEC_PD(SD_EMMC,	0),
>> +	SEC_PD(RAMA,	0),
>> +	/* SRAMB is used as AFT runtime memory, and should be always on */
> 
> AFT?  I assume you mean ATF?
> 
Yes, I will fix it, thank  you.
>> +	SEC_PD(RAMB,	GENPD_FLAG_ALWAYS_ON),
>> +	SEC_PD(IR,	0),
>> +	SEC_PD(SPICC,	0),
>> +	SEC_PD(SPIFC,	0),
>> +	SEC_PD(USB,	0),
>> +	/* NIC is for NIC400, and should be always on */
> 
> Why?
> 
NIC domain is for ARM CoreLink NIC-400 Network Interconnect, and should be always on since bootloader.
>> +	SEC_PD(NIC,	GENPD_FLAG_ALWAYS_ON),
>> +	SEC_PD(PDMIN,	0),
>> +	SEC_PD(RSA,	0),
>> +};
> 
> [...]
> 
> Kevin
> 
> .
> 

