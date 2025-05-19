Return-Path: <linux-pm+bounces-27368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B78D3ABC54E
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 19:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B34B3BB12F
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF852874F1;
	Mon, 19 May 2025 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hJBMq/Kw"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FA320AF87;
	Mon, 19 May 2025 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674723; cv=none; b=Im+yf55kt/eRUfWd1OAJuTXVRfv8y4VmYSzal0uf+Rwy20ZUo5ArqooNrzr+lkrHbuTBLJHpk/3EtnhWDl1/Aju5E9LLM40HZ4PFAYI74o2QF3U37NlGXvyLx6V7B7bkvaHZLgMiSeAz3aL7YKfg9Zxh4bl4S0uHclZBYDkfD0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674723; c=relaxed/simple;
	bh=1M08tbMPKZIQwA166WgmYRAIrkDv6G6ToLEOnILqPFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT6ZV1H5oQvY5TdxXLKgmTm8FBpfnHupSiLVGnA73QlKuFES9xQqPqPGtAUUDBOKvD1g/A2Lz4GPeD5b56KseA+r2cmqGk6UzLiZZxYyNVzmrNytG7O56csddFWMoHElln1W4Uf8TlgaSNDDms8rUksx2Dea8YK9dr73f7TWayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hJBMq/Kw; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6D21425A24;
	Mon, 19 May 2025 19:12:00 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ShMum505WjK7; Mon, 19 May 2025 19:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1747674719; bh=1M08tbMPKZIQwA166WgmYRAIrkDv6G6ToLEOnILqPFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hJBMq/Kw4XA76Nuf9u+aIIaa8FYuHF5IdWTy+M6dSd1fPRry8yXkbNc4be1LyT+Ja
	 C2bj8zMtqUwgz61KwraY7pSqBcaqa5bwx2wVlpukeNzT6e3bEZnnCe4XlVkHNFMOOj
	 rfWddaatS0X1FFU/KeY9uCcs8FElX+xVtkSu+OT6VAAwZzRaeGGKqfdiI8rjlJegK/
	 mEUylHgwmKOGnPN0eWbt3oqSr8bSrxi2APOAh/WN66K+sZIQTh18fEkEi8XSeV+sPJ
	 VuceCm6xhSe0YhEz7NfzbRp0k8kP+kPv69bWTgvPuxIc8voFcCauZxDIwfpOtY/aTk
	 HmBaVKWqee0Hg==
Date: Mon, 19 May 2025 17:11:32 +0000
From: Yao Zi <ziyao@disroot.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Jonas Karlman <jonas@kwiboo.se>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] pmdomain: rockchip: Add support for RK3528
Message-ID: <aCtmREp_H6_K00jR@pie.lan>
References: <20250518220707.669515-1-jonas@kwiboo.se>
 <20250518220707.669515-3-jonas@kwiboo.se>
 <aCthtDxm25RU_fd3@pie.lan>
 <3416319.KgjxqYA5nG@diego>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3416319.KgjxqYA5nG@diego>

On Mon, May 19, 2025 at 07:07:39PM +0200, Heiko Stübner wrote:
> Hi,
> 
> Am Montag, 19. Mai 2025, 18:52:04 Mitteleuropäische Sommerzeit schrieb Yao Zi:
> > On Sun, May 18, 2025 at 10:06:49PM +0000, Jonas Karlman wrote:
> > > Add configuration and power domains for RK3528 SoC.
> > > 
> > > Only PD_GPU can fully be powered down. PD_RKVDEC, PD_RKVENC, PD_VO and
> > > PD_VPU are used by miscellaneous devices in RK3528.
> > 
> > Thanks for your work!
> > 
> > > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > ---
> > >  drivers/pmdomain/rockchip/pm-domains.c | 27 ++++++++++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > > 
> > > diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> > > index 4cce407bb1eb..242570c505fb 100644
> > > --- a/drivers/pmdomain/rockchip/pm-domains.c
> > > +++ b/drivers/pmdomain/rockchip/pm-domains.c
> > > @@ -35,6 +35,7 @@
> > >  #include <dt-bindings/power/rk3366-power.h>
> > >  #include <dt-bindings/power/rk3368-power.h>
> > >  #include <dt-bindings/power/rk3399-power.h>
> > > +#include <dt-bindings/power/rockchip,rk3528-power.h>
> > >  #include <dt-bindings/power/rockchip,rk3562-power.h>
> > 
> > But I had some trouble applying this patch on either Rockchip SoC tree
> > or linux-pm. Looking through the context, seems the patch depends on
> > some RK3562 PMU driver changes, which I couldn't find with some brief
> > searching among the list.
> > 
> > Which branch is the series based on?
> 
> are you sure you looked at the right linux-pm tree?
> 
> In [0] I do see rk3562 powerdomains applied.

Oops, thanks for the link! I was digging through rafael/linux-pm.git
actually...

> Heiko
> 
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git/commit/?h=next&id=f89c082d44914f24dfb5b0219eb140369de5b612
> 
> 

Best regards,
Yao Zi

