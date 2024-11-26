Return-Path: <linux-pm+bounces-18129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61549D9829
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 14:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BBC283941
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 13:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC251D47A2;
	Tue, 26 Nov 2024 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bvD8CEB2"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E71D27BB;
	Tue, 26 Nov 2024 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732627159; cv=none; b=RXloVkLLBnK5wifpfQPihzUThWLtnAvv/jZ9vdXsWAtTmcm6+U/xArbWBqti8HXwu8sno6DHO5T31+2N79hmuUY3n/3g3x5KiHoeiK3QnPZ2syM151iEwZ33zo9lqcSGMyFyWSRZPF6HrQyBDvcxIKkCQAkTK8UTIC/Qu9+Zcb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732627159; c=relaxed/simple;
	bh=9n3DMWiNfsEPU/+nTL+NGjyuioKCWO5RjIWhEr0S1Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pp/OgaZsTMGbCbAIPnYZ9i4DuyWBPtCVWakcafZqaZmiQhKCoxrPKA/+e1jQCakqHq1d/b4378cSQzmmgNUDSfaqepNkQXTXui9A/b5i5lW2qKheXFgVFNgQJyEiaPUKr6SRoFyJ4/TC+ME7yFbQKyAen+K8bc1WQ/phgxC/EOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bvD8CEB2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732627155;
	bh=9n3DMWiNfsEPU/+nTL+NGjyuioKCWO5RjIWhEr0S1Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvD8CEB2NRi1y2GiRlZ/hRTRGq2xk1RfRWFfRYFeuKXpFRenr6DFgfgew/G/KX1gl
	 /on3JSQivwHfYIvJ8MKYAFgR1NIuv6aLsoZ6HYDwPeHPp2bXthUlabI/b4yVSTd5WK
	 tmTEhyVYAr+ohPd1YiBSpIwQDFhN/OgGJyLGq4iX6thE7WcmjRPcx/WQH5WybmzpvE
	 6pYa2nRyQWPWzp/urldLb92YAS//GDqlziYlW3UIrG0v/hyzUjJmX17VC8jTBxG4dJ
	 MOtYzDF8vL2zqa+vbKw07tl8sNsZB5YkXYuPPgDkVNjDpUs5dLtTaB5j9HB8IWGSFW
	 zOWmQahCPhESg==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 96A9717E3663;
	Tue, 26 Nov 2024 14:19:13 +0100 (CET)
Date: Tue, 26 Nov 2024 08:19:11 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Balsam CHIHI <bchihi@baylibre.com>, kernel@collabora.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bernhard =?utf-8?Q?Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] thermal/drivers/mediatek/lvts: Disable monitor mode
 during suspend
Message-ID: <e3e9020b-f3d5-42bb-bf1e-6aa8da2d1708@notapiano>
References: <20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com>
 <20241125-mt8192-lvts-filtered-suspend-fix-v1-1-42e3c0528c6c@collabora.com>
 <600f9d78-bdc8-4133-bb43-06d798bcd543@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <600f9d78-bdc8-4133-bb43-06d798bcd543@collabora.com>

On Tue, Nov 26, 2024 at 10:43:55AM +0100, AngeloGioacchino Del Regno wrote:
> Il 25/11/24 22:20, Nícolas F. R. A. Prado ha scritto:
> > When configured in filtered mode, the LVTS thermal controller will
> > monitor the temperature from the sensors and trigger an interrupt once a
> > thermal threshold is crossed.
> > 
> > Currently this is true even during suspend and resume. The problem with
> > that is that when enabling the internal clock of the LVTS controller in
> > lvts_ctrl_set_enable() during resume, the temperature reading can glitch
> > and appear much higher than the real one, resulting in a spurious
> > interrupt getting generated.
> > 
> > Disable the temperature monitoring and give some time for the signals to
> > stabilize during suspend in order to prevent such spurious interrupts.
> > 
> > Cc: stable@vger.kernel.org
> > Reported-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > Closes: https://lore.kernel.org/all/20241108-lvts-v1-1-eee339c6ca20@chromium.org/
> > Fixes: 8137bb90600d ("thermal/drivers/mediatek/lvts_thermal: Add suspend and resume")
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> >   drivers/thermal/mediatek/lvts_thermal.c | 36 +++++++++++++++++++++++++++++++--
> >   1 file changed, 34 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> > index 1997e91bb3be94a3059db619238aa5787edc7675..a92ff2325c40704adc537af6995b34f93c3b0650 100644
> > --- a/drivers/thermal/mediatek/lvts_thermal.c
> > +++ b/drivers/thermal/mediatek/lvts_thermal.c
> > @@ -860,6 +860,32 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
> >   	return 0;
> >   }
> > +static void lvts_ctrl_monitor_enable(struct device *dev, struct lvts_ctrl *lvts_ctrl, bool enable)
> > +{
> > +	/*
> > +	 * Bitmaps to enable each sensor on filtered mode in the MONCTL0
> > +	 * register.
> > +	 */
> > +	u32 sensor_filt_bitmap[] = { BIT(0), BIT(1), BIT(2), BIT(3) };
> > +	u32 sensor_map = 0;
> > +	int i;
> > +
> > +	if (lvts_ctrl->mode != LVTS_MSR_FILTERED_MODE)
> > +		return;
> > +
> 
> That's easier and shorter:
> 
> static void lvts_ctrl_monitor_enable( .... )
> {
> 	/* Bitmap to enable each sensor on filtered mode in the MONCTL0 register */
> 	const u32 sensor_map = GENMASK(3, 0);
> 
> 	if (lvts_ctrl->mode != LVTS_MSR_FILTERED_MODE)
> 		return;
> 
> 	/* Bits 0-3: Sensing points - Bit 9: Single point access flow */
> 	if (enable)
> 		writel(sensor_map | BIT(9), LVTS_MONCTL0(lvts_ctrl->base));

Wait, no, here you're enabling all the sensors in the controller. We only want
to enable ones that are valid, otherwise we might get garbage data and irqs from
sensors that aren't actually there. That's why I use the
lvts_for_each_valid_sensor() helper in this patch.

Thanks,
Nícolas

