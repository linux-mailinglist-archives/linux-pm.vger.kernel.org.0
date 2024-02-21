Return-Path: <linux-pm+bounces-4188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7919F85D69A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 12:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A80DB242A7
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46553FE31;
	Wed, 21 Feb 2024 11:15:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352353F9FB
	for <linux-pm@vger.kernel.org>; Wed, 21 Feb 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514125; cv=none; b=ou1m3srsd7q6Xu5sBI4+X42NMM+9hE1BfkdUHKU8MARuqyXhmIWcnZCN9B14V0bgzwpPuZLkJoj9UoDSIz4kLGcQ87L+Wlhxljt7ZHCAar0sq+mVJkwWuuEM3kYvPIzG7jey0IaqmNTR+mstf20PTnx/HdgwNEFtEUF54Rt9//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514125; c=relaxed/simple;
	bh=irQ6ebiQiyGpcMm37AjfJenPghYMGL62W6zUcLWPX+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q4EwNbCOymIv+R/LFclcfkNmP9nSGnhWGSuWzEFLODF+SVKtoI2aCoqjXmE/l0E5kQgcqPOFgZQuFMHND1d32nHAcT43VF93hOwtEZJ1dGnoPVriftTgD/muUulPHEy7DQ2rCDB+Po9L8TQkHheMLqDYTkMylbLxb5YqPW5PAVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rckYx-0006aF-9K; Wed, 21 Feb 2024 12:14:55 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rckYt-0021lT-Mj; Wed, 21 Feb 2024 12:14:51 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rckYt-0005LY-1x;
	Wed, 21 Feb 2024 12:14:51 +0100
Message-ID: <6cc0774c0093086aa2504d6124ee6b9af4615677.camel@pengutronix.de>
Subject: Re: [PATCH v6 0/6] reset: gpio: ASoC: shared GPIO resets
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami
 <bgoswami@quicinc.com>,  Bjorn Andersson <andersson@kernel.org>, Konrad
 Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, Frank Rowand <frowand.list@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org,  linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-pm@vger.kernel.org
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, Bartosz Golaszewski
	 <brgl@bgdev.pl>, Sean Anderson <sean.anderson@seco.com>
Date: Wed, 21 Feb 2024 12:14:51 +0100
In-Reply-To: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 29 Jan 2024 12:52:10 +0100, Krzysztof Kozlowski wrote:
> Dependencies / Merging
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. Depends on !GPIOLIB stub:
>    https://lore.kernel.org/all/20240125081601.118051-3-krzysztof.kozlowsk=
i@linaro.org/
>=20
> 2. Patch #2 (cpufreq: do not open-code of_phandle_args_equal()) and patch=
 #4
>    (reset: Instantiate reset GPIO controller for shared reset-gpios) depe=
nd on OF
>    change (patch #1).
>=20
> [...]

Applied patches 1-4 to reset/next, thanks!

[1/6] of: Add of_phandle_args_equal() helper
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D26ea8511c849
[2/6] cpufreq: do not open-code of_phandle_args_equal()
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D0f28982835c2
[3/6] reset: gpio: Add GPIO-based reset controller
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Dcee544a40e44
[4/6] reset: Instantiate reset GPIO controller for shared reset-gpios
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Dc721f189e89c

regards
Philipp



