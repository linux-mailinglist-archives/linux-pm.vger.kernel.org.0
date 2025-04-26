Return-Path: <linux-pm+bounces-26273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72464A9DD29
	for <lists+linux-pm@lfdr.de>; Sat, 26 Apr 2025 22:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BED01B6742D
	for <lists+linux-pm@lfdr.de>; Sat, 26 Apr 2025 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886701F5838;
	Sat, 26 Apr 2025 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="PZDOouGS"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EB71F3D45;
	Sat, 26 Apr 2025 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745701058; cv=pass; b=KCtvy788N+eA6pdlobCiyqer+tk47o704rwxq4IExcLMrUkcgfw7UFPpFAhyASUFYXYcTzbmwS+LPX8GV2HZj0gmrcCGZyxIarwmM7J3GOXH07ob73xWq7bKHziJWUf44tl4YuQfmEyCXvopVzWHSYsta3bljhX/dK2ks6X7nvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745701058; c=relaxed/simple;
	bh=p0BZViD/yOTJLjUeoWQCI8234JU2GTuhrpX40eCaEFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GkaQ8HwPpFzHnlcO8VvrUHeNXUkgxG7ie9N4C4DBWjk6KDWlPjIYdxYxhCZg2sS5cxpQd8d2RAOy87IEAp+f5P9TKKFXPh4bujeUAHxjDG0BoJxTI7xZBr/35sQPLcdf7Bz5HgWpugqZM+VLIPWPQDEQq+GWScygWioeWEsfptM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=PZDOouGS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745701030; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kY8x2uGSh2Jlnn13Q7cIzSmnWqtv4xd7Z4SjbnhFP0KScN2GeQI4K3LT0eKY117HSjFkxmb6B8PXRmk15LEE70tM0J10XGxtaN2+7kjsu3igRs02sXAaMDBh+W3ufRNPlKTm/IDDfFw3gYA5ESoozPgt7J6xMSbzfe6stEiJVeQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745701030; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=d5RUawyA0HZ8iOrYQ/UIr7PD1runCe3i/3feWl3o2dw=; 
	b=CA5u7SYQvsCIFJgMNKhE8vA7o0/3vWx/lkh77k3OctLSvLkOHz8w1LPyYFXnjRrm3k5FLtxc+tdnBfB6IU/C/aT0hhN34NWI4A0OYR7Wt5PJd4f6Q+KQYBLKxOKO9VUrA1DEFua5BSrMeP5LVhi69/4i/rEkfPfsTXL4Sf8w/to=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745701030;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=d5RUawyA0HZ8iOrYQ/UIr7PD1runCe3i/3feWl3o2dw=;
	b=PZDOouGSbvvhbt4Z2xQnoXSSwlqd8WH3rsALrYFcBDvKFIi9OU1ItkP8MjHc0oFr
	soAxiGgeWJPgYt4WnNFQrg7I25OX4fveMjP4B8/U8wkEWtUntFNSvmgY8N6V/arlmlQ
	A8FW1sTCRkKxTSTSZag8nR/gOW5q2NNfJng6Ahdk=
Received: by mx.zohomail.com with SMTPS id 1745701030129397.68583282935344;
	Sat, 26 Apr 2025 13:57:10 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>,
 Diederik de Haas <didi.debian@cknow.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org
Subject:
 Re: [PATCH v5 5/7] thermal: rockchip: support reading trim values from OTP
Date: Sat, 26 Apr 2025 22:57:04 +0200
Message-ID: <2891736.iZASKD2KPV@workhorse>
In-Reply-To: <D9GH5V09WW47.358SY1F7LJ9ZV@cknow.org>
References:
 <20250425-rk3576-tsadc-upstream-v5-0-0c840b99c30e@collabora.com>
 <20250425-rk3576-tsadc-upstream-v5-5-0c840b99c30e@collabora.com>
 <D9GH5V09WW47.358SY1F7LJ9ZV@cknow.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 26 April 2025 11:49:13 Central European Summer Time Diederik de Haas wrote:
> Hi Nicolas,
> 
> On Fri Apr 25, 2025 at 9:34 PM CEST, Nicolas Frattaroli wrote:
> > Many of the Rockchip SoCs support storing trim values for the sensors in
> > factory programmable memory. These values specify a fixed offset from
> > the sensor's returned temperature to get a more accurate picture of what
> > temperature the silicon is actually at.
> >
> > The way this is implemented is with various OTP cells, which may be
> > absent. There may both be whole-TSADC trim values, as well as per-sensor
> > trim values.
> >
> > In the downstream driver, whole-chip trim values override the per-sensor
> > trim values. This rewrite of the functionality changes the semantics to
> > something I see as slightly more useful: allow the whole-chip trim
> > values to serve as a fallback for lacking per-sensor trim values,
> > instead of overriding already present sensor trim values.
> >
> > Additionally, the chip may specify an offset (trim_base, trim_base_frac)
> > in degrees celsius and degrees decicelsius respectively which defines
> > what the basis is from which the trim, if any, should be calculated
> > from. By default, this is 30 degrees Celsius, but the chip can once
> > again specify a different value through OTP cells.
> 
> Would it be useful to define all the values in the same unit?
> Having celsius and decicelsius and millicelsius sounds like a recipe for
> (future) off-by-10/-100/-1000 errors.

No. It is not possible to redefine the unit of these, because the values are 
factory programmed into these one-time programmable cells.

> And possibly define-ing the '30' so people don't need this commit
> message to figure out where that magic number comes from?

There is no constant of 30 in the code to define anywhere. This is what the
factory programmed values are referenced against.

> And also the '923' for ``.trim_slope``?

.trim_slope is an SoC specific value that does not need to be defined a second
time in a different place, it lives in the SoC data for that reason, much like
the code tables and which functions the driver should use for this chip. There
is nothing to be gained here from the indirection.

> 
> > The implementation of these trim calculations have been tested
> > extensively on an RK3576, where it was confirmed to get rid of pesky 1.8
> > degree Celsius offsets between certain sensors.
> >
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/thermal/rockchip_thermal.c | 221 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 202 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> > index 89e3180667e2a8f0ef5542b0db4d9e19a21a24d3..3beff9b6fac3abe8948b56132b618ff1bed57217 100644
> > --- a/drivers/thermal/rockchip_thermal.c
> > +++ b/drivers/thermal/rockchip_thermal.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> > @@ -69,16 +70,18 @@ struct chip_tsadc_table {
> >   * struct rockchip_tsadc_chip - hold the private data of tsadc chip
> >   * @chn_offset: the channel offset of the first channel
> >   * @chn_num: the channel number of tsadc chip
> > - * @tshut_temp: the hardware-controlled shutdown temperature value
> > + * @trim_slope: used to convert the trim code to a temperature in millicelsius
> > + * @tshut_temp: the hardware-controlled shutdown temperature value, with no trim
> 
> Having the same units used everywhere would also avoid possible
> confusion here as ``trim_slope`` explicitly mentions millicelsius, but
> ``tshut_temp`` does not, but AFAIK it's also in millicelsius.

That seems like an additional change out of scope for this series, and does not
need to hold up this patch series for a v6.

> 
> Cheers,
>   Diederik
> 
> >   * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
> >   * @tshut_polarity: the hardware-controlled active polarity (0:LOW 1:HIGH)
> >   * @initialize: SoC special initialize tsadc controller method
> >   * @irq_ack: clear the interrupt
> >   * @control: enable/disable method for the tsadc controller
> > - * @get_temp: get the temperature
> > + * @get_temp: get the raw temperature, unadjusted by trim
> >   * @set_alarm_temp: set the high temperature interrupt
> >   * @set_tshut_temp: set the hardware-controlled shutdown temperature
> >   * @set_tshut_mode: set the hardware-controlled shutdown mode
> > + * @get_trim_code: convert a hardware temperature code to one adjusted for by trim
> >   * @table: the chip-specific conversion table
> >   */
> >  struct rockchip_tsadc_chip {
> > @@ -86,6 +89,9 @@ struct rockchip_tsadc_chip {
> 





