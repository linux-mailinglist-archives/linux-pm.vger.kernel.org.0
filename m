Return-Path: <linux-pm+bounces-35192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9EAB93C17
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 02:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F792E0AF6
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 00:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B848B1C54A9;
	Tue, 23 Sep 2025 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="otohyrUY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E243418FC97
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588846; cv=none; b=hbFASV6rmjbaNU4Hq6UFymBbMO0TbXt4fLpyyIkGxVbWKzQf+uZGFuagfTN+shH1zeFP0nvh95hWpOyRreD2JwkiKGkEzuRfaUZ2th1IxaPCQlOVPGiF6stJQamYrIwR08q2QUuVuvgfweL0JX8sRqVx8EXUKNi6gOAzULeymIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588846; c=relaxed/simple;
	bh=k3I4yoQWlYW8RaG3vYcx9XWCVtfKEFR4QSZqQ2hTEDI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=QZs2Irs1YzvUgAPVjt1HLpUnW+jsEdWmoHpxRVHCs12CC1FJD5Y6r/tPwGkWj2XJ4rTzU4349WWDDPr3WjVIk+Z4lX2yM2ityfKPbwD7mmHafns2U0PxqY3xI+gEV1A+i/riSqTW2gEZ1tGrBs1bwi3woYarZ6+2ZJIxV+DNTw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=otohyrUY; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250923005401epoutp04c0523c5812c20ccb96e1d47973e7b4b9~nwzv6jhwb1350113501epoutp04C
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 00:54:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250923005401epoutp04c0523c5812c20ccb96e1d47973e7b4b9~nwzv6jhwb1350113501epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758588841;
	bh=0icZwGq6l6trj5m8kiyot8z07Evuj931KewICxfmrA0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=otohyrUYrfg89CB6iep/4Blgcw316CaCY9Ze4fGymgPL3NLb4lAHCkiqU7sQZGoBw
	 s8mB4UZjAndBJCZ09LyTRR5ofZz68puAE2yg7EZnBIba3fIKU0Sp3RixV1UzNpfGUu
	 WhY8w4lDG50mlvgjH63gHJhONoRrx6lOcqT1xB0I=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20250923005400epcas2p4d217865e5715affdeab93832c32ea661~nwzu8bTEn1878118781epcas2p4R;
	Tue, 23 Sep 2025 00:54:00 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.36.70]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cW1h76Mw1z2SSKx; Tue, 23 Sep
	2025 00:53:59 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250923005359epcas2p419655d2bdb7de8ea6e0e60556660ac14~nwzte59Ee2370523705epcas2p4p;
	Tue, 23 Sep 2025 00:53:59 +0000 (GMT)
Received: from KORCO115296 (unknown [12.80.207.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250923005359epsmtip26a98a0660041a34e46c9d4ee172226d5~nwztZPk940718307183epsmtip27;
	Tue, 23 Sep 2025 00:53:59 +0000 (GMT)
From: =?ks_c_5601-1987?B?vNW9xQ==?= <shin.son@samsung.com>
To: "'Henrik Grimler'" <henrik@grimler.se>
Cc: "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>, "'Krzysztof
 Kozlowski'" <krzk@kernel.org>, "'Rafael J . Wysocki'" <rafael@kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>, "'Zhang Rui'"
	<rui.zhang@intel.com>, "'Lukasz Luba'" <lukasz.luba@arm.com>, "'Rob
	Herring'" <robh@kernel.org>, "'Conor Dooley'" <conor+dt@kernel.org>, "'Alim
	Akhtar'" <alim.akhtar@samsung.com>, <linux-pm@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20250922200430.GA4697@l14.localdomain>
Subject: RE: [PATCH v4 2/3] thermal: exynos_tmu: Support new hardware and
 update TMU interface
Date: Tue, 23 Sep 2025 09:53:53 +0900
Message-ID: <000001dc2c24$8be7a090$a3b6e1b0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLNrO/s5c6r06mWwaZxWViDEkHfogKWIOg4AX/6Z7UBj0CC7bKPv5FA
Content-Language: ko
X-CMS-MailID: 20250923005359epcas2p419655d2bdb7de8ea6e0e60556660ac14
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250922041902epcas2p3e40ed58737b22b7af9d09f6ba362928d
References: <20250922041857.1107445-1-shin.son@samsung.com>
	<CGME20250922041902epcas2p3e40ed58737b22b7af9d09f6ba362928d@epcas2p3.samsung.com>
	<20250922041857.1107445-3-shin.son@samsung.com>
	<20250922200430.GA4697@l14.localdomain>

Hello Henrik Grimler

> -----Original Message-----
> From: Henrik Grimler [mailto:henrik@grimler.se]
> Sent: Tuesday, September 23, 2025 5:05 AM
> To: Shin Son <shin.son@samsung.com>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>; Krzysztof Kozlowski
> <krzk@kernel.org>; Rafael J . Wysocki <rafael@kernel.org>; Daniel Lezcano
> <daniel.lezcano@linaro.org>; Zhang Rui <rui.zhang@intel.com>; Lukasz Luba
> <lukasz.luba@arm.com>; Rob Herring <robh@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Alim Akhtar <alim.akhtar@samsung.com>; linux-
> pm@vger.kernel.org; linux-samsung-soc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v4 2/3] thermal: exynos_tmu: Support new hardware and
> update TMU interface
> 
> Hi Shin,
> 
> On Mon, Sep 22, 2025 at 01:18:56PM +0900, Shin Son wrote:
> > The Exynos tmu driver's private data structure has been extended to
> > support the exynosautov920 hardware, which requires per-sensor
> > interrupt enablement and multiple-zone handling:
> >
> > - Add 'slope_comp' : compensation parameter below 25 degrees.
> > - Add 'calib_temp' : stores the fused calibaration temperature.
> > - Add 'sensor_count' : reflects the maximum sensor numbers.
> > - Rename 'tzd' -> 'tzd_array' to register multiple thermal zones.
> >
> > Since splitting this patch causes runtime errors during temperature
> > emulation or problems where the read temperature feature fails to
> > retrieve values, I have submitted it as a single commit. To add
> > support for the exynosautov920 to the exisiting TMU interface, the
> > following changes are included:
> >
> > 1. Simplify "temp_to_code" and "code_to_temp" to one computation path
> >    by normalizing calib_temp.
> > 2. Loop over 'sensor_count' in critical-point setup.
> > 3. Introduce 'update_con_reg' for exynosautov920 control-register
> updates.
> > 4. Add exynosautov920-specific branch in 'exynos_tmu_update_temp'
> function.
> > 5. Skip high & low temperature threshold setup in exynosautov920.
> > 6. Enable interrupts via sensor_count in exynosautov920.
> > 7. Initialize all new members during 'exynosautov920_tmu_initialize'.
> > 8. Clear IRQs by iterating the sensor_count in exynosautov920.
> > 9. Register each zone with 'devm_thermal_of_zone_register()'
> >    based on 'sensor_count'.
> >
> > Signed-off-by: Shin Son <shin.son@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 322
> > ++++++++++++++++++++++++---
> >  1 file changed, 285 insertions(+), 37 deletions(-)
> >
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c
> > b/drivers/thermal/samsung/exynos_tmu.c
> > index 47a99b3c5395..ebcc38f3fff6 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -121,8 +121,51 @@
> >
> >  #define EXYNOS_NOISE_CANCEL_MODE		4
> >
> > +/* ExynosAutov920 specific registers */
> > +#define EXYNOSAUTOV920_SLOPE_COMP		25
> > +#define EXYNOSAUTOV920_SLOPE_COMP_MASK		0xf
> > +#define EXYNOSAUTOV920_CALIB_SEL_TEMP		30
> > +#define EXYNOSAUTOV920_CALIB_SEL_TEMP_MASK	0x2
> > +
> > +#define EXYNOSAUTOV920_SENSOR0_TRIM_INFO	0x10
> > +#define EXYNOSAUTOV920_TRIM_MASK		0x1ff
> > +#define EXYNOSAUTOV920_TRIMINFO_25_SHIFT	0
> > +#define EXYNOSAUTOV920_TRIMINFO_85_SHIFT	9
> > +
> > +#define EXYNOSAUTOV920_TMU_REG_TRIMINFO2	0x04
> > +
> > +#define EXYNOSAUTOV920_TMU_REG_THRESHOLD(p)	(((p)) * 0x50 +
0x00d0)
> > +#define EXYNOSAUTOV920_TMU_REG_INTEN(p)		(((p)) * 0x50 +
> 0x00f0)
> > +#define EXYNOSAUTOV920_TMU_REG_INT_PEND(p)	(((p)) * 0x50 + 0x00f8)
> > +
> > +#define EXYNOSAUTOV920_CURRENT_TEMP_P1_P0	0x084
> > +#define EXYNOSAUTOV920_TMU_REG_EMUL_CON		0x0b0
> > +
> > +#define EXYNOSAUTOV920_TMU_REG_CONTROL		0x50
> > +#define EXYNOSAUTOV920_TMU_REG_CONTROL1		0x54
> > +#define EXYNOSAUTOV920_TMU_REG_AVG_CONTROL	0x58
> > +#define EXYNOSAUTOV920_TMU_SAMPLING_INTERVAL	0x70
> > +#define EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE0	0x74
> > +#define EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE1	0x78
> > +
> > +#define EXYNOSAUTOV920_TMU_T_BUF_VREF_SEL_SHIFT		8
> > +#define EXYNOSAUTOV920_TMU_T_BUF_VREF_SEL_MASK		0x1f
> > +#define EXYNOSAUTOV920_TMU_T_BUF_SLOPE_SEL_SHIFT	3
> > +#define EXYNOSAUTOV920_TMU_T_BUF_SLOPE_SEL_MASK		0xf
> > +#define EXYNOSAUTOV920_TMU_NUM_PROBE_MASK		0xf
> > +#define EXYNOSAUTOV920_TMU_NUM_PROBE_SHIFT		16
> > +#define EXYNOSAUTOV920_TMU_LPI_MODE_MASK		1
> > +#define EXYNOSAUTOV920_TMU_LPI_MODE_SHIFT		10
> > +
> > +#define EXYNOSAUTOV920_TMU_AVG_CON_UPDATE		0x0008011a
> > +#define EXYNOSAUTOV920_TMU_COUNTER_VALUE0_UPDATE	0x030003c0
> > +#define EXYNOSAUTOV920_TMU_COUNTER_VALUE1_UPDATE	0x03c0004d
> > +
> >  #define MCELSIUS	1000
> >
> > +#define EXYNOS_DEFAULT_SENSOR_COUNT			1
> > +#define EXYNOS_MAX_SENSOR_COUNT				16
> 
> In patch 1, sensor count is described as a value 0 <= sensor_count <= 15,
> but here max sensor count value is set to 16. Shouldn't max value be the
> same in these two places, what is the maximum number of thermal sensors
> that the hardware can have?

Sorry for the confusion. It actually refers to the maximum number of remote
sensors.
I'll change it to 15.

> 
> >  enum soc_type {
> >  	SOC_ARCH_EXYNOS3250 = 1,
> >  	SOC_ARCH_EXYNOS4210,
> > @@ -133,6 +176,7 @@ enum soc_type {
> >  	SOC_ARCH_EXYNOS5420_TRIMINFO,
> >  	SOC_ARCH_EXYNOS5433,
> >  	SOC_ARCH_EXYNOS7,
> > +	SOC_ARCH_EXYNOSAUTOV920,
> >  };
> >

...

> >  static int temp_to_code(struct exynos_tmu_data *data, u8 temp)  {
> > +	s32 temp_diff, code;
> > +
> >  	if (data->cal_type == TYPE_ONE_POINT_TRIMMING)
> >  		return temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
> >
> > -	return (temp - EXYNOS_FIRST_POINT_TRIM) *
> > -		(data->temp_error2 - data->temp_error1) /
> > -		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) +
> > -		data->temp_error1;
> > +	temp_diff = temp - EXYNOS_FIRST_POINT_TRIM;
> > +
> > +	code = temp_diff * (data->temp_error2 - data->temp_error1) *
> MCELSIUS /
> > +	       (data->calib_temp - EXYNOS_FIRST_POINT_TRIM);
> > +
> > +	if (data->soc == SOC_ARCH_EXYNOSAUTOV920 && temp_diff < 0)
> > +		code = code * (57 + data->slope_comp) / 65;
> > +
> > +	return code / MCELSIUS + data->temp_error1;
> >  }
> >
> >  /*
> > @@ -220,13 +277,20 @@ static int temp_to_code(struct exynos_tmu_data
> *data, u8 temp)
> >   */
> >  static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
> > {
> > +	s32 code_diff, temp;
> > +
> >  	if (data->cal_type == TYPE_ONE_POINT_TRIMMING)
> >  		return temp_code - data->temp_error1 +
> EXYNOS_FIRST_POINT_TRIM;
> >
> > -	return (temp_code - data->temp_error1) *
> > -		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
> > -		(data->temp_error2 - data->temp_error1) +
> > -		EXYNOS_FIRST_POINT_TRIM;
> > +	code_diff = temp_code - data->temp_error1;
> > +
> > +	temp = code_diff * (data->calib_temp - EXYNOS_FIRST_POINT_TRIM) *
> MCELSIUS /
> > +	       (data->temp_error2 - data->temp_error1);
> > +
> > +	if (data->soc == SOC_ARCH_EXYNOSAUTOV920 && code_diff < 0)
> > +		temp = temp * 65 / (57 + data->slope_comp);
> > +
> > +	return temp / MCELSIUS + EXYNOS_FIRST_POINT_TRIM;
> >  }
> 
> Nice, these two functions looks much better compared to v2!

Thank you for your advice!

> 
> >  static void sanitize_temp_error(struct exynos_tmu_data *data, u32
> > trim_info) @@ -262,6 +326,9 @@ static int exynos_tmu_initialize(struct
> platform_device *pdev)

...

> > @@ -865,6 +1079,10 @@ static int exynos_map_dt_data(struct
> > platform_device *pdev)
> >
> >  	data->soc = (uintptr_t)of_device_get_match_data(&pdev->dev);
> >
> > +	data->sensor_count = EXYNOS_DEFAULT_SENSOR_COUNT;
> > +
> > +	data->calib_temp = EXYNOS_SECOND_POINT_TRIM;
> > +
> >  	switch (data->soc) {
> >  	case SOC_ARCH_EXYNOS4210:
> >  		data->tmu_set_low_temp = exynos4210_tmu_set_low_temp; @@ -
> 945,6
> > +1163,19 @@ static int exynos_map_dt_data(struct platform_device *pdev)
> >  		data->min_efuse_value = 15;
> >  		data->max_efuse_value = 100;
> >  		break;
> > +	case SOC_ARCH_EXYNOSAUTOV920:
> > +		data->tmu_set_low_temp = exynosautov920_tmu_set_low_temp;
> > +		data->tmu_set_high_temp = exynosautov920_tmu_set_high_temp;
> > +		data->tmu_disable_low = exynosautov920_tmu_disable_low;
> > +		data->tmu_disable_high = exynosautov920_tmu_disable_high;
> > +		data->tmu_set_crit_temp = exynosautov920_tmu_set_crit_temp;
> > +		data->tmu_initialize = exynosautov920_tmu_initialize;
> > +		data->tmu_control = exynosautov920_tmu_control;
> > +		data->tmu_read = exynosautov920_tmu_read;
> > +		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
> > +		data->tmu_clear_irqs = exynosautov920_tmu_clear_irqs;
> > +		data->sensor_count = EXYNOS_MAX_SENSOR_COUNT;
> > +		break;
> >  	default:
> >  		dev_err(&pdev->dev, "Platform not supported\n");
> >  		return -EINVAL;
> > @@ -952,6 +1183,14 @@ static int exynos_map_dt_data(struct
> > platform_device *pdev)
> >
> >  	data->cal_type = TYPE_ONE_POINT_TRIMMING;
> >
> > +	if (data->soc == SOC_ARCH_EXYNOSAUTOV920) {
> > +		if (of_property_read_u32(pdev->dev.of_node,
> "samsung,sensors",
> > +					 &data->sensor_count)) {
> > +			dev_err(&pdev->dev, "failed to get sensor count\n");
> > +			return -ENODEV;
> > +		}
> > +	}
> 
> Do we really need the `if (data->soc == SOC_ARCH_EXYNOSAUTOV920)` here, I
> am sure there will be more socs that use samsung,sensors. Can't we simply
> read samsung,sensors for all socs and use EXYNOS_DEFAULT_SENSOR_COUNT if
> it fails, or would it be potentially dangerous if samsung,sensors is
> missing for autov920 dtb and default value of 1 is used?
> 
> Best regards,
> Henrik Grimler
> 

Yes. Incorrect remote-sensor settings can affect TMU operation. For
example, when the sensor count is set to 1,
The thermal zone doesn't function properly and the hardware trip doesn't
assert on the v920 variant.
I consider that configuration unsafe, so I added variant-specific handling
for that SoC.
Meanwhile, the other variant legitimately uses only a single sensor.



