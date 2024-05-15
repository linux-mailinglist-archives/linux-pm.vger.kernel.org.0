Return-Path: <linux-pm+bounces-7877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24CB8C6CB1
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 21:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E249C1C2200C
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 19:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885F0159562;
	Wed, 15 May 2024 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="REkKWhWu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FECA446AC;
	Wed, 15 May 2024 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800636; cv=none; b=XOtDbixheeAHo2rwNOJFE9Q4hRJQvz74lktCpK5R9ro4hyYOLMIZgvd5fy8wEe1p97bB5jrppnF45ZTABgIOE/jWSYGa2pEympLG+3CsW77qX0TVlgOA1D/SXJRf7uqpzqNuW5J0OIQTxLqNcnTzpRvEBFt2SWE2l6aa3PhRDEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800636; c=relaxed/simple;
	bh=V6B1o7vP2U1mB+39DQXD0JAC2U9kKIj4ljLZL1FbBX8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrcEUo/S4PU0HPUVxkzHMyhkLnugnsXJ/1xHx4+4KzfVvyFmjioalISWU8OgHHZTvzfbBdAIDdGXywEf1DiPTw2rw0KXFg2VZcvh74hsfg5d0MrvyFAQomM5Cktxd1Cm4gPWb2BlTTy5yrCB2Wa+Fg0C2UUIdKYmfvVsowXPdoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=REkKWhWu; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7888B10002F;
	Wed, 15 May 2024 22:17:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7888B10002F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715800632;
	bh=0753sID6h0JKAX7uW58+tc82AGYS+dbom4wraQwXJOU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=REkKWhWurHkxfjqqLrnnr+zsQd9y9VC1UnwvBMKYK7xIKSIr1+XAGpvMK7HDH62bN
	 c0jYuV963J2dT1XvTQgJwqCsKLP7aM4E+KE9A2DoQcb7706m19AMxvfnKNtfSNTPWc
	 0azZeDbWEzUfUKEOcf28OlThCiCg9+gqzI577WpaEIqlZQSJhQ19YFjbFk/1Ep/8c0
	 3D49RcCwzW1nDY/K9mjoCgNrXlcPdIXcIe+vQ7rtta06WIG2Nbn79B7qiy2jXXa9yP
	 O5PzxUJMfYoJtCkVCCWtRj5ahX+jCGE30OxGG8B6ryh+T7qGpRZhUdLZLQO07ghoeX
	 omxh0ktXh66sA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 15 May 2024 22:17:12 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 15 May
 2024 22:17:11 +0300
Date: Wed, 15 May 2024 22:17:11 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>
CC: <jbrunet@baylibre.com>, <mturquette@baylibre.com>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <glaroque@baylibre.com>,
	<rafael@kernel.org>, <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
	<lukasz.luba@arm.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/3] arm64: dts: amlogic: a1: introduce thermal setup
Message-ID: <20240515191711.3bltbh536pntnvdg@CAB-WSD-L081021>
References: <20240328192645.20914-1-ddrokosov@salutedevices.com>
 <20240503184222.cqka6nmjxhezfhtg@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240503184222.cqka6nmjxhezfhtg@CAB-WSD-L081021>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185260 [May 15 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/15 12:35:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/15 18:39:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/15 13:12:00 #25231738
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Neil,

Excuse me, pls ping.

On Fri, May 03, 2024 at 09:42:22PM +0300, Dmitry Rokosov wrote:
> Hello Neil,
> 
> A1 Thermal Sensor was applied to linux-pm for v6.10-rc1:
> 
> https://lore.kernel.org/all/89a02410-87c8-47c6-aa50-04dad5b4e585@linaro.org/
> 
> Could you please advise if it's enough to proceed with this series? Or
> do I need to do something more?
> 
> On Thu, Mar 28, 2024 at 10:26:34PM +0300, Dmitry Rokosov wrote:
> > This patch series introduces thermal sensor declaration to the Meson A1
> > common dtsi file. It also sets up thermal zones for the AD402 reference
> > board. It depends on the series with A1 thermal support at [1].
> > 
> > Changes v2 since v1 at [2]:
> >     - provide Neil RvB for cooling-cells dts patch
> >     - purge unnecessary 'amlogic,a1-thermal' fallback
> > 
> > Links:
> > [1] - https://lore.kernel.org/all/20240328191322.17551-1-ddrokosov@salutedevices.com/
> > [2] - https://lore.kernel.org/all/20240328134459.18446-1-ddrokosov@salutedevices.com/
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > 
> > Dmitry Rokosov (3):
> >   arm64: dts: amlogic: a1: add cooling-cells for DVFS feature
> >   arm64: dts: amlogic: a1: introduce cpu temperature sensor
> >   arm64: dts: amlogic: ad402: setup thermal-zones
> > 
> >  .../arm64/boot/dts/amlogic/meson-a1-ad402.dts | 45 +++++++++++++++++++
> >  arch/arm64/boot/dts/amlogic/meson-a1.dtsi     | 13 ++++++
> >  2 files changed, 58 insertions(+)
> 
> -- 
> Thank you,
> Dmitry

-- 
Thank you,
Dmitry

