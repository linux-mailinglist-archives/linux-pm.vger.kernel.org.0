Return-Path: <linux-pm+bounces-26267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B38A9D9E7
	for <lists+linux-pm@lfdr.de>; Sat, 26 Apr 2025 11:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F20E1BC0E95
	for <lists+linux-pm@lfdr.de>; Sat, 26 Apr 2025 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F612512FA;
	Sat, 26 Apr 2025 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="mL2Dr4PB"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0362512EB
	for <linux-pm@vger.kernel.org>; Sat, 26 Apr 2025 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745660981; cv=none; b=OCc0M2QUZADqqUEj+Zh/M4w2LOa7f5l99fYnDPoMErKmaORXB7AFGAaC49/oFWNiLWQbxodCsV2LgJGCN3kZcINqeNlqRlV6rdZrgQKLZXtDUkh/gI8wYTeE35Fe+RWSXTcAjL4fDP9eEjNoZGo56FzaRCWR/OUSsEAnl2DoygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745660981; c=relaxed/simple;
	bh=ENKUpsUSB0Fj2hnXNx8MLmM76MEghDwFjK68FQWIDIA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CdMUbzM/Ljho2xD1+IKrMMhjc8r6RxpHOOFy2Nx2K0AwzhozjyZkt7N5IkLApikHW37zubOlMJJH5E/tD7caf6papKR7UagWcGSlZe445+P8wJ0RFTYG6Ta3ltIztel9ip07xLZD3b92cmJNitmR32wxpf97H0sdUvuoAd6WvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=mL2Dr4PB; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1745660966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3LCgJPF74Xbd9a4LK3HZnV1+d98aQdvtMSQTN4S4yY=;
	b=mL2Dr4PBjwgXUrKJj/AgVVRKSL5GmFbusKHF+A70PvEUaDDYfnu1lcLBih37M0FWhRTjSK
	vYJ9Vm4TF5gn53WfmmM/fR3Bw6Bu6dbDgYaLkhb5Gh3eZStC8TADhI9CrKfu5mwgpI9YfQ
	R8xX69n+r5XDJx9TYxayaqFF8zXg5A+zADwQ2njEyLmR+fJ3krEiHw8bFj8O/tiS4ojfvS
	TL/PL3CptmOq27C9PLh9muXvi7K8WoYfr/ytT5yvh9rT10WIgQc9ilZjUehgU60VtW4SV2
	JSGQvb7iVja5A61Cq0KkHqIe7dtE0RYSbcrDaKU14O0kVRjYwmMf7tRFRAMhQA==
Content-Type: multipart/signed;
 boundary=3f073c5a59fc125928ba9034ef05e53a7e470d8fbbe478b43f705ef13c24;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sat, 26 Apr 2025 11:49:13 +0200
Message-Id: <D9GH5V09WW47.358SY1F7LJ9ZV@cknow.org>
Cc: <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Sebastian
 Reichel" <sebastian.reichel@collabora.com>, <linux-kernel@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>, <kernel@collabora.com>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 5/7] thermal: rockchip: support reading trim values
 from OTP
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko
 Stuebner" <heiko@sntech.de>, "Jonas Karlman" <jonas@kwiboo.se>
References: <20250425-rk3576-tsadc-upstream-v5-0-0c840b99c30e@collabora.com>
 <20250425-rk3576-tsadc-upstream-v5-5-0c840b99c30e@collabora.com>
In-Reply-To: <20250425-rk3576-tsadc-upstream-v5-5-0c840b99c30e@collabora.com>
X-Migadu-Flow: FLOW_OUT

--3f073c5a59fc125928ba9034ef05e53a7e470d8fbbe478b43f705ef13c24
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Nicolas,

On Fri Apr 25, 2025 at 9:34 PM CEST, Nicolas Frattaroli wrote:
> Many of the Rockchip SoCs support storing trim values for the sensors in
> factory programmable memory. These values specify a fixed offset from
> the sensor's returned temperature to get a more accurate picture of what
> temperature the silicon is actually at.
>
> The way this is implemented is with various OTP cells, which may be
> absent. There may both be whole-TSADC trim values, as well as per-sensor
> trim values.
>
> In the downstream driver, whole-chip trim values override the per-sensor
> trim values. This rewrite of the functionality changes the semantics to
> something I see as slightly more useful: allow the whole-chip trim
> values to serve as a fallback for lacking per-sensor trim values,
> instead of overriding already present sensor trim values.
>
> Additionally, the chip may specify an offset (trim_base, trim_base_frac)
> in degrees celsius and degrees decicelsius respectively which defines
> what the basis is from which the trim, if any, should be calculated
> from. By default, this is 30 degrees Celsius, but the chip can once
> again specify a different value through OTP cells.

Would it be useful to define all the values in the same unit?
Having celsius and decicelsius and millicelsius sounds like a recipe for
(future) off-by-10/-100/-1000 errors.

And possibly define-ing the '30' so people don't need this commit
message to figure out where that magic number comes from?
And also the '923' for ``.trim_slope``?

> The implementation of these trim calculations have been tested
> extensively on an RK3576, where it was confirmed to get rid of pesky 1.8
> degree Celsius offsets between certain sensors.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/thermal/rockchip_thermal.c | 221 +++++++++++++++++++++++++++++++=
++----
>  1 file changed, 202 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchi=
p_thermal.c
> index 89e3180667e2a8f0ef5542b0db4d9e19a21a24d3..3beff9b6fac3abe8948b56132=
b618ff1bed57217 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -9,6 +9,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> @@ -69,16 +70,18 @@ struct chip_tsadc_table {
>   * struct rockchip_tsadc_chip - hold the private data of tsadc chip
>   * @chn_offset: the channel offset of the first channel
>   * @chn_num: the channel number of tsadc chip
> - * @tshut_temp: the hardware-controlled shutdown temperature value
> + * @trim_slope: used to convert the trim code to a temperature in millic=
elsius
> + * @tshut_temp: the hardware-controlled shutdown temperature value, with=
 no trim

Having the same units used everywhere would also avoid possible
confusion here as ``trim_slope`` explicitly mentions millicelsius, but
``tshut_temp`` does not, but AFAIK it's also in millicelsius.

Cheers,
  Diederik

>   * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
>   * @tshut_polarity: the hardware-controlled active polarity (0:LOW 1:HIG=
H)
>   * @initialize: SoC special initialize tsadc controller method
>   * @irq_ack: clear the interrupt
>   * @control: enable/disable method for the tsadc controller
> - * @get_temp: get the temperature
> + * @get_temp: get the raw temperature, unadjusted by trim
>   * @set_alarm_temp: set the high temperature interrupt
>   * @set_tshut_temp: set the hardware-controlled shutdown temperature
>   * @set_tshut_mode: set the hardware-controlled shutdown mode
> + * @get_trim_code: convert a hardware temperature code to one adjusted f=
or by trim
>   * @table: the chip-specific conversion table
>   */
>  struct rockchip_tsadc_chip {
> @@ -86,6 +89,9 @@ struct rockchip_tsadc_chip {

--3f073c5a59fc125928ba9034ef05e53a7e470d8fbbe478b43f705ef13c24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaAysHwAKCRDXblvOeH7b
btwyAP0TuDcK9Aa/VqKu9kTOU2O3d5xjx4EzW+e6XJ2ZOqBbGAEApqUGJ4a2zPpi
S1Shb4PtPJRr9dktGwogIP97AP7t3AY=
=e2Pn
-----END PGP SIGNATURE-----

--3f073c5a59fc125928ba9034ef05e53a7e470d8fbbe478b43f705ef13c24--

