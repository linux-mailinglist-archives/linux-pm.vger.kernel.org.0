Return-Path: <linux-pm+bounces-20542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC9DA13ABD
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 14:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B06188A451
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6473222A1EA;
	Thu, 16 Jan 2025 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L/YsZg8a"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ACA1DE2AD;
	Thu, 16 Jan 2025 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033551; cv=none; b=jwxC6BVhUCDBzAUEdgEZhafVxh5ZXFfZVa7eM77q7aQTOwSPJ0GhLachAHRyYTQHMHLYaB2egiY+OYtiQkt8aFwfe6aSFOMPyv7PEtCRINfIJgdg6u7iwolrZrRgmnUb5/qAvcWpROt1CRIqVNIfypjJ6OuJCEyVgCuPbEFkQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033551; c=relaxed/simple;
	bh=BFxVXJJabloKs7r9Ax8zWdGqbl8ktI2pQICt6LoVVE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhsLA5dO3p+49rRhbTEp+qQAhmuf4GtHOwVshsOm0OlKzXyJHHYy1CM7RPpyvc5gbZP3X6XgO2z5keExXPbn+EjMI/R1b6tUDQvBrSQvUA6AB9PguFv+Tg4O61lKSv6jom2mbnmFuFYWpU/W3ghFgNURiUthF/ni/E7ljnaFEoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L/YsZg8a; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737033547;
	bh=BFxVXJJabloKs7r9Ax8zWdGqbl8ktI2pQICt6LoVVE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/YsZg8aHcfPf2SBOAGkuZNb0Rd0AgPQTwR+GEt9a/NNVVFH46/KHDX4A/y1i6rGj
	 QXg7AXFiMperBDsoFI8MxX0p+aI2hv7sMbroQzdreXz/FbBUWhdUTfgKmpOwiPiyLK
	 tRDw3He6SieKgxXPbamDhWOMrppT6aeF2J9LDjccYLYUAUP+IB97Dl4HtpgWYF4s7o
	 ZjO0cpn6TVnvRKmutLy22LLM8756cAfgyJJXgLgak5CQSkMalSZ/g+sfTflqqDn4bv
	 TGx1s1Ue2kA0i5aM9I7lCdAq2awESlrYMnYPMU1sAxOxm8r6EakllcOwDZlnCurUFW
	 AaUtoOt1ofQug==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 142D517E0E9E;
	Thu, 16 Jan 2025 14:19:00 +0100 (CET)
Date: Thu, 16 Jan 2025 10:18:54 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
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
Subject: Re: [PATCH RESEND v2 1/5] thermal/drivers/mediatek/lvts: Disable
 monitor mode during suspend
Message-ID: <554102c6-d597-4dc8-b760-3e2b9078e471@notapiano>
References: <20250113-mt8192-lvts-filtered-suspend-fix-v2-0-07a25200c7c6@collabora.com>
 <20250113-mt8192-lvts-filtered-suspend-fix-v2-1-07a25200c7c6@collabora.com>
 <20828ba5-ecb5-46a4-8be3-9119d93c383a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20828ba5-ecb5-46a4-8be3-9119d93c383a@linaro.org>

On Tue, Jan 14, 2025 at 10:23:42AM +0100, Daniel Lezcano wrote:
> 
> Hi Nicolas,
> 
> On 13/01/2025 14:27, Nícolas F. R. A. Prado wrote:
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
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> >   drivers/thermal/mediatek/lvts_thermal.c | 36 +++++++++++++++++++++++++++++++--
> >   1 file changed, 34 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> > index 07f7f3b7a2fb569cfc300dc2126ea426e161adff..a1a438ebad33c1fff8ca9781e12ef9e278eef785 100644
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
> > +	static const u8 sensor_filt_bitmap[] = { BIT(0), BIT(1), BIT(2), BIT(3) };
> > +	u32 sensor_map = 0;
> > +	int i;
> > +
> > +	if (lvts_ctrl->mode != LVTS_MSR_FILTERED_MODE)
> > +		return;
> > +
> > +	if (enable) {
> > +		lvts_for_each_valid_sensor(i, lvts_ctrl)
> > +			sensor_map |= sensor_filt_bitmap[i];
> > +	}
> > +
> > +	/*
> > +	 * Bits:
> > +	 *      9: Single point access flow
> > +	 *    0-3: Enable sensing point 0-3
> > +	 */
> > +	writel(sensor_map | BIT(9), LVTS_MONCTL0(lvts_ctrl->base));
> > +}
> > +
> >   /*
> >    * At this point the configuration register is the only place in the
> >    * driver where we write multiple values. Per hardware constraint,
> > @@ -1381,8 +1407,11 @@ static int lvts_suspend(struct device *dev)
> >   	lvts_td = dev_get_drvdata(dev);
> > -	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
> > +	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
> > +		lvts_ctrl_monitor_enable(dev, &lvts_td->lvts_ctrl[i], false);
> > +		usleep_range(100, 200);
> 
> From where this delay is coming from ?

That's empirical. I tested several times doing system suspend and resume on the
machines hooked to our lab and that was the minimum delay I could find that
still never resulted in the spurious readings.

Unfortunately the technical documentation I have access to never even mentioned
that this issue could arise, let alone what the timing constraints were, so this
had to be figured out empirically.

Thanks,
Nícolas

