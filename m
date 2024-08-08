Return-Path: <linux-pm+bounces-12002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D183B94C2FB
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 18:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84335281AF5
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 16:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4FC190049;
	Thu,  8 Aug 2024 16:46:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E0190067;
	Thu,  8 Aug 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135585; cv=none; b=WVzJCuI7SaRheQG1DbDVL7MI8nOa437YW2cGVw9d1lwWcZMfPIelqRnfqXW/6YbSFqpPIl+wBeuDa32878U+bNatcbiD8N7T0yEj6zg2hs011zuH78o/R+Zp3buY0J1/nwf3+QnGyDX5S9wR48+vNh/dl4DsMxdo+aZXVX3xgVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135585; c=relaxed/simple;
	bh=07F8n5MvsCYMmCPHHwaeA3RHn8tt9n6stIA7mFgipy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUULnYR0hOBuI37Ec1iQ/T+NMQ05drKEQ4QFXpsMLGNAImqZzOQv7zAk7+7Lfx9FpfXsv1bjG1jejz3J71xJ39QpHGzqCUjYMFL5XfKXf3Z0rGFUt/454PI1ZwG0UrpETAlN5IVm9Ub89lomvS0jQNmKFORJnThwhnVAGGM5+ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sc6HF-0004jv-7w; Thu, 08 Aug 2024 18:46:13 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Elaine Zhang <zhangqing@rock-chips.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: Add power-domain header for RK3576 SoCs
Date: Thu, 08 Aug 2024 18:46:12 +0200
Message-ID: <3030655.BQQF58Tnoo@diego>
In-Reply-To: <0c66dbf97fc5a5adc3831b1ed01e1188@manjaro.org>
References:
 <20240802151647.294307-1-detlev.casanova@collabora.com>
 <10908017.3WhfQktd6Z@diego> <0c66dbf97fc5a5adc3831b1ed01e1188@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 8. August 2024, 18:43:42 CEST schrieb Dragan Simic:
> Hello Heiko,
>=20
> On 2024-08-08 09:54, Heiko St=FCbner wrote:
> > Am Dienstag, 6. August 2024, 18:34:41 CEST schrieb Detlev Casanova:
> >> On Sunday, 4 August 2024 05:56:39 EDT Krzysztof Kozlowski wrote:
> >> > On 02/08/2024 17:14, Detlev Casanova wrote:
> >> > > From: Finley Xiao <finley.xiao@rock-chips.com>
> >> > >
> >> > > Define power domain IDs as described in the TRM.
> >> >
> >> > Please use subject prefixes matching the subsystem. You can get them=
 for
> >> > example with `git log --oneline -- DIRECTORY_OR_FILE` on the directo=
ry
> >> > your patch is touching. For bindings, the preferred subjects are
> >> > explained here:
> >> > https://www.kernel.org/doc/html/latest/devicetree/bindings/submittin=
g-patche
> >> > s.html#i-for-patch-submitters
> >> > > Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> >> > > [reword]
> >> > > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> >> > > ---
> >> > >
> >> > >  include/dt-bindings/power/rk3576-power.h | 30 +++++++++++++++++++=
+++++
> >> > >  1 file changed, 30 insertions(+)
> >> > >  create mode 100644 include/dt-bindings/power/rk3576-power.h
> >> >
> >> > This is part of bindings.
> >> >
> >> > > diff --git a/include/dt-bindings/power/rk3576-power.h
> >> > > b/include/dt-bindings/power/rk3576-power.h
> >> > Missing vendor prefix. This should be named after compatible.
> >>=20
> >> Looks like all other rockchip power bindings use the=20
> >> include/dt-bindings/
> >> power/rkXXXX.h format. Should I keep that way ?
> >=20
> > there is also rockchip,rv1126-power.h , so please follow Krzysztof's
> > suggestion. Older header namings need to stay the same of course
> > but that shouldn't keep us from updating naming schemes to better
> > work in new additions.
>=20
> Actually, why don't we rename the old headers to follow the new naming=20
> rules?
> Is there something preventing us from doing that, which I'm missing?

yes, the headers are _part_ of the actual devicetree-binding.
So you have out of tree users in the BSDs or whereever else.




