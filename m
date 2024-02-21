Return-Path: <linux-pm+bounces-4189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A64A85D6D0
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 12:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5F61C21A0D
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 11:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D172C3FE2C;
	Wed, 21 Feb 2024 11:26:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F3405F4
	for <linux-pm@vger.kernel.org>; Wed, 21 Feb 2024 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514805; cv=none; b=OiQjTbLYmWIxFmo8NCaRMiDbrAjMPTPzz/RD5js5hFIqL/Qf359y1Ug9jQo0kmAhE1AbqYRcU7AbozAVTr6EbcE0QmT8VQLxfExtgN5yjcC/jt1poQqh0Qeam7js9WE1iVGDeQ17bAXl8y0tuqwQjCAbGKJGI0tb/zr0BRsQWKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514805; c=relaxed/simple;
	bh=0b8SeCdjbW0gI8qK6TzdaaI5mEtgC9wamMalUHNEG2o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LEerf/HEBYyxeoaNFaE1ylbMTua5yuVklqAGV5xP4uxNArJZUZA8WWLEp2ygNcjMF2KAH3nf507bPISRfVbNeDNj/s+2tsuqBeMJNrWk0MC202OEEwwEGmw6jT7uB+N+M6yyPR39WBugrKlxAd586Edj7H0DcZpiICplUGIcVQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rckk2-0008Rw-D4; Wed, 21 Feb 2024 12:26:22 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rckjz-0021oc-6E; Wed, 21 Feb 2024 12:26:19 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rckjz-0005aF-0M;
	Wed, 21 Feb 2024 12:26:19 +0100
Message-ID: <38fda6619769da7240517982adfe734cb653ff5e.camel@pengutronix.de>
Subject: Re: [PATCH v6 0/6] reset: gpio: ASoC: shared GPIO resets
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami
 <bgoswami@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, Konrad
 Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  "Rafael J. Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, Frank Rowand <frowand.list@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Packham
 <chris.packham@alliedtelesis.co.nz>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Sean Anderson <sean.anderson@seco.com>
Date: Wed, 21 Feb 2024 12:26:19 +0100
In-Reply-To: <7ae0567d-e5d3-4e00-98f7-5139d5879f75@linaro.org>
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
	 <7ae0567d-e5d3-4e00-98f7-5139d5879f75@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hi Krzysztof,

On Mi, 2024-02-21 at 10:44 +0100, Krzysztof Kozlowski wrote:
> On 29/01/2024 12:52, Krzysztof Kozlowski wrote:
> > Hi,
> >=20
> > Dependencies / Merging
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. Depends on !GPIOLIB stub:
> >    https://lore.kernel.org/all/20240125081601.118051-3-krzysztof.kozlow=
ski@linaro.org/
> >=20
> > 2. Patch #2 (cpufreq: do not open-code of_phandle_args_equal()) and pat=
ch #4
> >    (reset: Instantiate reset GPIO controller for shared reset-gpios) de=
pend on OF
> >    change (patch #1).
>=20
>=20
> Hi Philipp,
>=20
> I got acks from GPIO folks. The also provided stable tag with dependency:
> https://lore.kernel.org/all/20240213101000.16700-1-brgl@bgdev.pl/
> (which BTW already is in mainline, so you could just merge Linus' tree
> into your next branch)

Thanks.

> Can you take entire patchset?

I've picked up 1-4. Patches 5-6 can go independently via ASoC, right?

regards
Philipp

