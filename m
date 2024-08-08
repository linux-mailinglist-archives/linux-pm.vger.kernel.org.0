Return-Path: <linux-pm+bounces-11987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3230094B84C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 09:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70C24B25E6C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 07:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61214188CBA;
	Thu,  8 Aug 2024 07:55:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E07187848;
	Thu,  8 Aug 2024 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103712; cv=none; b=VpbgtzrZoCxlC1j4hO79F8lV8ncxtQUo9bZBjphJDqq3sR4mVKg+dIjdDizyL8cpQsbIUn41CxzK+Hx6uJ9qNPD87z1RncaN2/sNXUMk1GRLxsWA+3NGOsoVysv9G9/CTmpMKjb0h440+yFiYE/ftfqeHP8Nubevxz4PZBFNykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103712; c=relaxed/simple;
	bh=0EDV+ZA80Nb72boDd5yPoathjXuPDJ0DD/ceNMfmO3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMCSF0eMtmaTZNW8Q+c7mui58edR+c+basXkrvxF2xxoGXKdARvCeFyKQJrq4OS0jdElMLZquAaZE2g0lpEzpoEZfp37eW+FDWyB0YI1cQ4i0kKE6HSixA2riwHzxIM7iuPRYYXXIzjB/DgeHaPKKUshW4kbnBZ3guXzdqFC2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sbxz5-0000Hh-CK; Thu, 08 Aug 2024 09:54:55 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Elaine Zhang <zhangqing@rock-chips.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: Add power-domain header for RK3576 SoCs
Date: Thu, 08 Aug 2024 09:54:54 +0200
Message-ID: <10908017.3WhfQktd6Z@diego>
In-Reply-To: <3310992.44csPzL39Z@trenzalore>
References:
 <20240802151647.294307-1-detlev.casanova@collabora.com>
 <e04258dc-07c4-45c7-90d4-bc1ed9eb100b@kernel.org>
 <3310992.44csPzL39Z@trenzalore>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Detlev,

Am Dienstag, 6. August 2024, 18:34:41 CEST schrieb Detlev Casanova:
> On Sunday, 4 August 2024 05:56:39 EDT Krzysztof Kozlowski wrote:
> > On 02/08/2024 17:14, Detlev Casanova wrote:
> > > From: Finley Xiao <finley.xiao@rock-chips.com>
> > > 
> > > Define power domain IDs as described in the TRM.
> > 
> > Please use subject prefixes matching the subsystem. You can get them for
> > example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> > your patch is touching. For bindings, the preferred subjects are
> > explained here:
> > https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patche
> > s.html#i-for-patch-submitters
> > > Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> > > [reword]
> > > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > > ---
> > > 
> > >  include/dt-bindings/power/rk3576-power.h | 30 ++++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > >  create mode 100644 include/dt-bindings/power/rk3576-power.h
> > 
> > This is part of bindings.
> > 
> > > diff --git a/include/dt-bindings/power/rk3576-power.h
> > > b/include/dt-bindings/power/rk3576-power.h
> > Missing vendor prefix. This should be named after compatible.
> 
> Looks like all other rockchip power bindings use the include/dt-bindings/
> power/rkXXXX.h format. Should I keep that way ?

there is also rockchip,rv1126-power.h , so please follow Krzysztof's
suggestion. Older header namings need to stay the same of course
but that shouldn't keep us from updating naming schemes to better
work in new additions.



