Return-Path: <linux-pm+bounces-35298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B059B9BB80
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 21:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0EB3AB420
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 19:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B17926CE11;
	Wed, 24 Sep 2025 19:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b="ZEM96ehZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A3B26CE28
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758742389; cv=none; b=PVGrNl5z9e46IumzDdG1R0twah32KpDIlr1D9b1nnocDHCoayrJ7IWKSAhpUY3xchwP43lFflW8FkohUrMeucjca97PwTTiIk7IX+HynaUEQY/A5J1wy6QAKijQW426Mpxjpa/h6Ru22LlgH9DSq1s9izOojcSVQCC2RPQ0ofGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758742389; c=relaxed/simple;
	bh=kGyFyRGnTEIQDnRHQzBMUtjvoUiSsEKBITF948LfKig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIGhDubSwkKxoZ7YwY22KtGorj11yRATW5nHm0Zx//vowJdmr7T84EsEImlM69E5lMJfYk3Np+z4HH9SVGNTbq8NCtEW1l98HG9Y5qpahdHysa3ClD/CWFbbBKlq9zk7Mi58nKLfcNugTBj/bEBZnu5IGo0/UrHl1Y681q3Tfiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se; spf=pass smtp.mailfrom=grimler.se; dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b=ZEM96ehZ; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grimler.se
Date: Wed, 24 Sep 2025 21:32:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
	t=1758742374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5iHvWuqXMKqXY5xi5HWO4WJVMOf5QP5qFtqbNbimzII=;
	b=ZEM96ehZfNKMQ9RPJZFXmoXJ8Fk/dL8ssD8yZTVwrJTEoInjNxItijIGl8OtrfbNlfEQyZ
	jk1KKW07G6hBHf8X7G3kPRtnmUmIml0rWY7oeJPvxA6nOiDn0uifc48w56uARMZxnMOZd2
	wKaMSGKfxG/hUk+DCJF1pHv7OGeu3Dw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: =?utf-8?B?77+91b3vv70=?= <shin.son@samsung.com>
Cc: 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>,
	'Krzysztof Kozlowski' <krzk@kernel.org>,
	"'Rafael J . Wysocki'" <rafael@kernel.org>,
	'Daniel Lezcano' <daniel.lezcano@linaro.org>,
	'Zhang Rui' <rui.zhang@intel.com>,
	'Lukasz Luba' <lukasz.luba@arm.com>,
	'Rob Herring' <robh@kernel.org>,
	'Conor Dooley' <conor+dt@kernel.org>,
	'Alim Akhtar' <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] thermal: exynos_tmu: Support new hardware and
 update TMU interface
Message-ID: <20250924193248.GA34040@l14.localdomain>
References: <20250922041857.1107445-1-shin.son@samsung.com>
 <CGME20250922041902epcas2p3e40ed58737b22b7af9d09f6ba362928d@epcas2p3.samsung.com>
 <20250922041857.1107445-3-shin.son@samsung.com>
 <20250922200430.GA4697@l14.localdomain>
 <000001dc2c24$8be7a090$a3b6e1b0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000001dc2c24$8be7a090$a3b6e1b0$@samsung.com>
X-Migadu-Flow: FLOW_OUT

Hi Shin,

On Tue, Sep 23, 2025 at 09:53:53AM +0900, �ս� wrote:
> Hello Henrik Grimler
> 
> > -----Original Message-----
> > From: Henrik Grimler [mailto:henrik@grimler.se]
> > Sent: Tuesday, September 23, 2025 5:05 AM
> > To: Shin Son <shin.son@samsung.com>
> > Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>; Krzysztof Kozlowski
> > <krzk@kernel.org>; Rafael J . Wysocki <rafael@kernel.org>; Daniel Lezcano
> > <daniel.lezcano@linaro.org>; Zhang Rui <rui.zhang@intel.com>; Lukasz Luba
> > <lukasz.luba@arm.com>; Rob Herring <robh@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>; Alim Akhtar <alim.akhtar@samsung.com>; linux-
> > pm@vger.kernel.org; linux-samsung-soc@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v4 2/3] thermal: exynos_tmu: Support new hardware and
> > update TMU interface
> > 
> > Hi Shin,
> > 
> > On Mon, Sep 22, 2025 at 01:18:56PM +0900, Shin Son wrote:
> > > The Exynos tmu driver's private data structure has been extended to
> > > support the exynosautov920 hardware, which requires per-sensor
> > > interrupt enablement and multiple-zone handling:
> > >
> > > - Add 'slope_comp' : compensation parameter below 25 degrees.
> > > - Add 'calib_temp' : stores the fused calibaration temperature.
> > > - Add 'sensor_count' : reflects the maximum sensor numbers.
> > > - Rename 'tzd' -> 'tzd_array' to register multiple thermal zones.
> > >
> > > Since splitting this patch causes runtime errors during temperature
> > > emulation or problems where the read temperature feature fails to
> > > retrieve values, I have submitted it as a single commit. To add
> > > support for the exynosautov920 to the exisiting TMU interface, the
> > > following changes are included:
> > >
> > > 1. Simplify "temp_to_code" and "code_to_temp" to one computation path
> > >    by normalizing calib_temp.
> > > 2. Loop over 'sensor_count' in critical-point setup.
> > > 3. Introduce 'update_con_reg' for exynosautov920 control-register
> > updates.
> > > 4. Add exynosautov920-specific branch in 'exynos_tmu_update_temp'
> > function.
> > > 5. Skip high & low temperature threshold setup in exynosautov920.
> > > 6. Enable interrupts via sensor_count in exynosautov920.
> > > 7. Initialize all new members during 'exynosautov920_tmu_initialize'.
> > > 8. Clear IRQs by iterating the sensor_count in exynosautov920.
> > > 9. Register each zone with 'devm_thermal_of_zone_register()'
> > >    based on 'sensor_count'.
> > >
> > > Signed-off-by: Shin Son <shin.son@samsung.com>

[ ... ]

> > > @@ -952,6 +1183,14 @@ static int exynos_map_dt_data(struct
> > > platform_device *pdev)
> > >
> > >  	data->cal_type = TYPE_ONE_POINT_TRIMMING;
> > >
> > > +	if (data->soc == SOC_ARCH_EXYNOSAUTOV920) {
> > > +		if (of_property_read_u32(pdev->dev.of_node,
> > "samsung,sensors",
> > > +					 &data->sensor_count)) {
> > > +			dev_err(&pdev->dev, "failed to get sensor count\n");
> > > +			return -ENODEV;
> > > +		}
> > > +	}
> > 
> > Do we really need the `if (data->soc == SOC_ARCH_EXYNOSAUTOV920)` here, I
> > am sure there will be more socs that use samsung,sensors. Can't we simply
> > read samsung,sensors for all socs and use EXYNOS_DEFAULT_SENSOR_COUNT if
> > it fails, or would it be potentially dangerous if samsung,sensors is
> > missing for autov920 dtb and default value of 1 is used?
> > 
> > Best regards,
> > Henrik Grimler
> > 
> 
> Yes. Incorrect remote-sensor settings can affect TMU operation. For
> example, when the sensor count is set to 1,
> The thermal zone doesn't function properly and the hardware trip doesn't
> assert on the v920 variant.
> I consider that configuration unsafe, so I added variant-specific handling
> for that SoC.
> Meanwhile, the other variant legitimately uses only a single sensor.

I see, thanks for the explanation!

Best regards,
Henrik Grimler

