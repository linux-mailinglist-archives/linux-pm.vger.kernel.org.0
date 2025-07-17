Return-Path: <linux-pm+bounces-30983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE20B08668
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 09:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BA43AEC08
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 07:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82205219311;
	Thu, 17 Jul 2025 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Sb4TTbxy"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5D1799F;
	Thu, 17 Jul 2025 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736902; cv=none; b=SXUf449oC5vKf/qxfX3ehBA1ylH053nWw292RaVqIBVZlPXCgxGsCV0AW7dZxmURI/79XxXI16R9wrsk4JK0wlQX8UcV3wxTK/395BewYksPNf0JlAZ7BFC7tFfX2hiHOEb8JnGb59SlM9UyOlQqDn+rMMzw1kETbPiyR//Auik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736902; c=relaxed/simple;
	bh=tBcpLdv18IqnAMBxa+umxHuraWcwwqUgk+B8U42pMgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noAdfQlCo+XNmhnjR+nEAsh2t33QuUnCIoSKNamr8ruI00nGFVlCp5y1VD45E/7eHlvwagnfYZBp4gxl2SGoghN6yQHGxVrbRRfCrSbo2XR8GHtgr75JYFErkBSlXN54+W3Gcz33Ze+z4tQ2r80mqWhE9fJOSYPBpJ+/ZrUlr5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Sb4TTbxy; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=CCCh+o003YcA0EOQv+9QFXT7/N6o1tA3bae7OHo+cmQ=; b=Sb4TTbxyxiDgQuJhQRwTlezXuZ
	ndsCkb3KK8RpL9i3sauoWUWQsfxM9CYNFir1F2iRqOw9WscSAklzMOb67ZnciZCj3qrKMzv7RYyfM
	RXd6MMO7+BwTz/Yx5Sq8ZgNRSe2Z4PG4zXZfURqbenPgP8DXIArpS+2lrNChxBQUpO11ZQL9Cd9S4
	jIU4DvqK4N09T5yDIH5qRAnVUH9GegzyclpmggSHhHiGeYHyJBzHvnB4nYeRvhGkyO8TUul2riH0E
	SLtod0/X0loDmyaaP8tUPge8CvnWFrUrFrk02eB2GejkiKWyuKX+aHd3vgJ9XQMPAR71EnyFY6CAk
	8FfmpiAg==;
Received: from i53875bf7.versanet.de ([83.135.91.247] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ucIvf-00010Z-Vn; Thu, 17 Jul 2025 09:21:20 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Alexey Charkov <alchark@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ye Zhang <ye.zhang@rock-chips.com>
Subject: Re: [PATCH v6 0/7] RK3576 thermal sensor support,
 including OTP trim adjustments
Date: Thu, 17 Jul 2025 09:21:22 +0200
Message-ID: <4178173.5fSG56mABF@diego>
In-Reply-To: <aHgHxR1_Gzu8Dwbm@mai.linaro.org>
References:
 <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
 <aHgHxR1_Gzu8Dwbm@mai.linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Daniel,

Am Mittwoch, 16. Juli 2025, 22:12:53 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Daniel Lezcano:
> On Tue, Jun 10, 2025 at 02:32:36PM +0200, Nicolas Frattaroli wrote:
> > This series adds support for the RK3576's thermal sensor.
> >=20
> > The sensor has six channels, providing measurements for the package
> > temperature, the temperature of the big cores, the temperature of the
> > little cores, and the GPU, NPU and DDR controller.
> >=20
> > In addition to adding support for the sensor itself, the series also
> > adds support for reading thermal trim values out of the device tree.
> > Most of this functionality is not specific to this SoC, but needed to be
> > implemented to make the sensors a little more accurate in order to
> > investigate whether the TRM swapped GPU and DDR or downstream swapped
> > GPU and DDR in terms of channel IDs, as downstream disagrees with what's
> > in the TRM, and the difference is so small and hard to pin down with
> > testing that the constant offset between the two sensors was a little
> > annoying for me to deal with.
> >=20
> > I ended up going with the channel assignment the TRM lists, as I see the
> > DDR sensor get a larger deviation from baseline temperatures during mem=
ory
> > stress tests (stress-ng --memrate 8 --memrate-flush) than what the TRM
> > claims is the GPU sensor but downstream claims is the DDR sensor. Input
> > from Rockchip engineers on whether the TRM is right or wrong welcome.
> >=20
> > The trim functionality is only used by RK3576 at the moment. Code to
> > handle other SoCs can rely on the shared otp reading and perhaps even
> > the IP revision specific function, but may need its own IP revision
> > specific functions added as well. Absent trim functionality in other
> > SoCs should not interfere with the modified common code paths.
> >=20
> > Patch 1 is a cleanup patch for the rockchip thermal driver, where a
> > function was confusingly named.
> >=20
> > Patch 2 adds the RK3576 compatible to the bindings.
> >=20
> > Patch 3 adds support for this SoC's thermal chip to the driver. It is a
> > port of the downstream commit adding support for this.
> >=20
> > Patch 4 adds some documentation for imminent additional functionality to
> > the binding, namely the trim value stuff.
> >=20
> > Patch 5 adds support for reading these OTP values in the
> > rockchip_thermal driver, and makes use of them. The code is mostly new
> > upstream code written by me, using downstream code as reference.
>=20
> Replaced previously applied version V5 with this V6 patches 1-5

are these commits available somewhere?

Because git.kernel.org reports that
  https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
has not seen activity in a while?

Thanks
Heiko



