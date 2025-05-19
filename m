Return-Path: <linux-pm+bounces-27366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C40ABC538
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 19:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8D73AA045
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2CB288522;
	Mon, 19 May 2025 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="LdDakWGE"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E82746A;
	Mon, 19 May 2025 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674476; cv=none; b=INEP4rQa7PAR3bvsWlSudNVzumqLim+5cSrVD4QC/UiFpygeXvhi1Rk4LbpBq92NY2rmGIDFh5E68u+2/jOuro6HbopDX66MhxiiYfG58sMxbE/cz83JfmL4m+rMHpSwZOHXal517vd5ljOdtVQ7BMx+E+SQgpGcVHnKGgzZdgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674476; c=relaxed/simple;
	bh=QvrvwfJmf+TzOMYNton3n4RVQxMtDR2OUv5vF/4GLLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTStx1ZW6Gm+8CbxtGV/aL9c1jBMnpu2IfnVomvvWgmv9cpCxWSBFTUnSyPZepKqw5xpbcF+EIfRTJn8qAi47dzuC9PIWgpwITioXDBzdkByaZ68j/wlHEW9dDQgAT/VlKvxusn/GKmESBKQsyWNGLw5NVv2avx0vqF0rZKvf+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=LdDakWGE; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Kj/VMwkUNI8WVdA0evoXZ3TAkYKKG+MMJX7QyMMaXUw=; b=LdDakWGElKmsMDaJk0QIhJJ3gP
	XF9eyygXbXn2sxg/ndnPMgIveMAO0fBzXxQPeD9HnK3VbOk3mEX3G0pkUf1zK8l0j5o9pktX8RpIm
	+N3F0fXW/YHFFaR4+sdHkKcBmsuKCx4BCfz60zEbzhuB3iRT1eeZpqi44zUXJC69h6d0BGkD5sIEp
	2+sF4ClgqezucwpElSorBu044SW01DtrzCz0sQdmnA0CEy3weD88rdu38aNuN/HHBQzLCFqpuc6mj
	vEiVwzobXE0cvuFqqwdZPX946aUhipHu5GWmHgRvV8XsOEVx/fMJShQx7eYO24SAcpjt/hHUWs5QY
	xf2lusRw==;
Received: from i53875bdb.versanet.de ([83.135.91.219] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uH3xm-0007E0-3W; Mon, 19 May 2025 19:07:42 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>, Ulf Hansson <ulf.hansson@linaro.org>,
 Yao Zi <ziyao@disroot.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] pmdomain: rockchip: Add support for RK3528
Date: Mon, 19 May 2025 19:07:39 +0200
Message-ID: <3416319.KgjxqYA5nG@diego>
In-Reply-To: <aCthtDxm25RU_fd3@pie.lan>
References:
 <20250518220707.669515-1-jonas@kwiboo.se>
 <20250518220707.669515-3-jonas@kwiboo.se> <aCthtDxm25RU_fd3@pie.lan>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Montag, 19. Mai 2025, 18:52:04 Mitteleurop=C3=A4ische Sommerzeit schrieb=
 Yao Zi:
> On Sun, May 18, 2025 at 10:06:49PM +0000, Jonas Karlman wrote:
> > Add configuration and power domains for RK3528 SoC.
> >=20
> > Only PD_GPU can fully be powered down. PD_RKVDEC, PD_RKVENC, PD_VO and
> > PD_VPU are used by miscellaneous devices in RK3528.
>=20
> Thanks for your work!
>=20
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> >  drivers/pmdomain/rockchip/pm-domains.c | 27 ++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >=20
> > diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/=
rockchip/pm-domains.c
> > index 4cce407bb1eb..242570c505fb 100644
> > --- a/drivers/pmdomain/rockchip/pm-domains.c
> > +++ b/drivers/pmdomain/rockchip/pm-domains.c
> > @@ -35,6 +35,7 @@
> >  #include <dt-bindings/power/rk3366-power.h>
> >  #include <dt-bindings/power/rk3368-power.h>
> >  #include <dt-bindings/power/rk3399-power.h>
> > +#include <dt-bindings/power/rockchip,rk3528-power.h>
> >  #include <dt-bindings/power/rockchip,rk3562-power.h>
>=20
> But I had some trouble applying this patch on either Rockchip SoC tree
> or linux-pm. Looking through the context, seems the patch depends on
> some RK3562 PMU driver changes, which I couldn't find with some brief
> searching among the list.
>=20
> Which branch is the series based on?

are you sure you looked at the right linux-pm tree?

In [0] I do see rk3562 powerdomains applied.

Heiko


[0] https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git/commi=
t/?h=3Dnext&id=3Df89c082d44914f24dfb5b0219eb140369de5b612



