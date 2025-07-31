Return-Path: <linux-pm+bounces-31668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12439B16D3E
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 10:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257B5168CE2
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 08:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB1C2222A3;
	Thu, 31 Jul 2025 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="nt67wWbO"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9CE18D643;
	Thu, 31 Jul 2025 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949509; cv=none; b=PdTOgw7FMNZVjxZk8h1ffH4kd2hd422huvyXRJbs87KZ+SAbGAMrES3TedyOdB6jws/fZzVGWMdnrmJVxAUGgoeIf26lbFAfyQCUD1V5sDCXy7QOd6x7LQEyvI796gD7c6Y9XuxZt7eFu+NRKBia68X8rQ0/oS58l0v2l7LkUX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949509; c=relaxed/simple;
	bh=7HJQ4clK8DvfFO+gD8huL+L2TcsZXthXhffjKMJO2pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Irz9F6mnknGRlxU6281Wcbbz6bwstr3M92905/Ax8gNEki+Ny4kHCvKuVclDRE7n8RMKvNUL88Yp86e5IBCj/r7Hhb0lPQkGuIFZAFobj6sjhKszqYUIstJlH/mXbVyIKeYX/QfY0n5NQ7mMxPUVrOq6L/VQi/CBt2k6EoezvJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=nt67wWbO; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=SnN4gkK7hnqg+1fHPpMhKULH0EAOxYwzimcsaqGrHpI=; b=nt67wWbOozmrdStei2uDKou0oi
	JUfbs/YtFvbvyk0xU/vIThKDjzbAlY6JA9O1a+EPymvZSvddO6Mz7yr/HalubI8+LNMRstAnxihEP
	QRub/dVXS0103625DIbhimZn4sE7hRrW/RYhU1gYaLTP7vdn2zpitPTK4m5KHC8LSZoNNuU4KMRKB
	Nqrn1vuZpL/WOEthSFsRqK1KIC14a3cNt82X9xxc4kRtFN+Ujb8zodPWsxCcVX6ZnzBlhK5YekXv2
	4Ja3ws0DG/RitZoSgAWbfT+vtQKM4B5JNzxB+ey8/jqk28U5hf3Ghjfo9VFlNMiUO/gSm2bdTsEDd
	qEI8bSEw==;
Received: from i53875bde.versanet.de ([83.135.91.222] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uhONo-0006X8-Jv; Thu, 31 Jul 2025 10:11:24 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alexey Charkov <alchark@gmail.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
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
Date: Thu, 31 Jul 2025 10:11:23 +0200
Message-ID: <3560770.QJadu78ljV@diego>
In-Reply-To:
 <CABjd4YzJeNf0Qq9qFeMcoYQV5erZGUeOpmJynRW88AeL9dJNhQ@mail.gmail.com>
References:
 <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
 <14c91ee4-3a09-4ec9-966f-0d563d7c8966@linaro.org>
 <CABjd4YzJeNf0Qq9qFeMcoYQV5erZGUeOpmJynRW88AeL9dJNhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hey Alexey,

Am Donnerstag, 31. Juli 2025, 09:33:32 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Alexey Charkov:
> On Thu, Jul 17, 2025 at 12:20=E2=80=AFPM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 7/17/25 09:21, Heiko St=C3=BCbner wrote:
> > > Hi Daniel,
> > >
> > > Am Mittwoch, 16. Juli 2025, 22:12:53 Mitteleurop=C3=A4ische Sommerzei=
t schrieb Daniel Lezcano:
> > >> On Tue, Jun 10, 2025 at 02:32:36PM +0200, Nicolas Frattaroli wrote:
> > >>> This series adds support for the RK3576's thermal sensor.
> > >>>
> > >>> The sensor has six channels, providing measurements for the package
> > >>> temperature, the temperature of the big cores, the temperature of t=
he
> > >>> little cores, and the GPU, NPU and DDR controller.
> > >>>
> > >>> In addition to adding support for the sensor itself, the series also
> > >>> adds support for reading thermal trim values out of the device tree.
> > >>> Most of this functionality is not specific to this SoC, but needed =
to be
> > >>> implemented to make the sensors a little more accurate in order to
> > >>> investigate whether the TRM swapped GPU and DDR or downstream swapp=
ed
> > >>> GPU and DDR in terms of channel IDs, as downstream disagrees with w=
hat's
> > >>> in the TRM, and the difference is so small and hard to pin down with
> > >>> testing that the constant offset between the two sensors was a litt=
le
> > >>> annoying for me to deal with.
> > >>>
> > >>> I ended up going with the channel assignment the TRM lists, as I se=
e the
> > >>> DDR sensor get a larger deviation from baseline temperatures during=
 memory
> > >>> stress tests (stress-ng --memrate 8 --memrate-flush) than what the =
TRM
> > >>> claims is the GPU sensor but downstream claims is the DDR sensor. I=
nput
> > >>> from Rockchip engineers on whether the TRM is right or wrong welcom=
e.
> > >>>
> > >>> The trim functionality is only used by RK3576 at the moment. Code to
> > >>> handle other SoCs can rely on the shared otp reading and perhaps ev=
en
> > >>> the IP revision specific function, but may need its own IP revision
> > >>> specific functions added as well. Absent trim functionality in other
> > >>> SoCs should not interfere with the modified common code paths.
> > >>>
> > >>> Patch 1 is a cleanup patch for the rockchip thermal driver, where a
> > >>> function was confusingly named.
> > >>>
> > >>> Patch 2 adds the RK3576 compatible to the bindings.
> > >>>
> > >>> Patch 3 adds support for this SoC's thermal chip to the driver. It =
is a
> > >>> port of the downstream commit adding support for this.
> > >>>
> > >>> Patch 4 adds some documentation for imminent additional functionali=
ty to
> > >>> the binding, namely the trim value stuff.
> > >>>
> > >>> Patch 5 adds support for reading these OTP values in the
> > >>> rockchip_thermal driver, and makes use of them. The code is mostly =
new
> > >>> upstream code written by me, using downstream code as reference.
> > >>
> > >> Replaced previously applied version V5 with this V6 patches 1-5
> > >
> > > are these commits available somewhere?
> > >
> > > Because git.kernel.org reports that
> > >    https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> > > has not seen activity in a while?
> > >
> >
> > I just pushed the bleeding-edge branch
>=20
> Just wondering if patches 6-7 from this series are on your radar?
> Driver changes are in -next AFAICT, but not DTS. Can't wait to get the
> temperature monitoring working on RK3576 without out-of-tree patches
> ;-)

they are :-) .

Right now we're in the middle of the merge-window though, so everything
I apply now, I'd need to rebase onto -rc1 in slightly more than a week,
invalidating all those nice commit hashes that end up in the "applied" mail=
s.

So I'm struggling with myself on every merge window about that.


Heiko



