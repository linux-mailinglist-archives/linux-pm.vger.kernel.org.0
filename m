Return-Path: <linux-pm+bounces-12004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE0F94C402
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 20:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 773C5B23D35
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D42C81745;
	Thu,  8 Aug 2024 18:00:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F255D33F7;
	Thu,  8 Aug 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723140022; cv=none; b=BN1d8OUylirOLWQ76CA0ZHX4LgaCMmVa6/KYURyGxG1AdSIj/cJ/aVbf1mDrYpem2EYayXZTx7OzEOZ2SYde4MBXpSjl0WZgBr3gTWwQhCxnkWG8heYRWi25VWSxUK/HS0lDtk7hrphuQ9B+X93lV8Ki386Fo8Btvpkczp+qeEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723140022; c=relaxed/simple;
	bh=fT2eiLp8rGJvo5W2x3PCbqn8Y+vXb2s/QEPwgiUzFr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7oqtnCuoob2IC3fx3FDE/gZ0fT6WZoXrOL/x41YsQ8sDo7zn7Lz/54U/tTa6vzOwhGtsKgMu+V+tv1pFtH4rOX5xKOz/NIVbnqY/RbpCqvDfR4R7IScTEKOYJ/Bpbh9do7zUKeH46fSDva1ModHVg9PUPPABz2CtVnQjFSXb64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sc7Qe-0005Pz-Hv; Thu, 08 Aug 2024 20:00:00 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Arnd Bergmann <arnd@arndb.de>, Elaine Zhang <zhangqing@rock-chips.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v2 2/2] pmdomain: rockchip: Add support for rk3576 SoC
Date: Thu, 08 Aug 2024 19:59:59 +0200
Message-ID: <2449940.aKNjEaI27c@diego>
In-Reply-To: <5805279.DvuYhMxLoT@trenzalore>
References:
 <20240808163451.80750-1-detlev.casanova@collabora.com>
 <17766579.lhrHg4fidi@diego> <5805279.DvuYhMxLoT@trenzalore>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Detlev,

Am Donnerstag, 8. August 2024, 19:53:20 CEST schrieb Detlev Casanova:
> On Thursday, 8 August 2024 12:41:05 EDT Heiko St=FCbner wrote:
> > > @@ -552,7 +575,10 @@ static int rockchip_pd_power(struct
> > > rockchip_pm_domain *pd, bool power_on)>=20
> > >  			/* if powering up, leave idle mode */
> > >  			rockchip_pmu_set_idle_request(pd, false);
> > >=20
> > > -			rockchip_pmu_restore_qos(pd);
> > > +			if (pd->info->delay_us)
> > > +				udelay(pd->info->delay_us);
> > > +			else
> > > +				rockchip_pmu_restore_qos(pd);
> >=20
> > I still want this behaviour change in a separate patch with adequate
> > commit message please.
> >=20
> > Going from always handling qos to allowing to just wait a specific time
> > needs explanation and is not part of "just" adding rk3576 support.
>=20
> You are right, I didn't takle this issue.
> This is actually a bug, the else is not supposed to be there, it should o=
nly=20
> be an added delay for some PDs.
>=20
> Unfortunately, I'm not sure why that delay is needed exactly, so I'm will=
ing=20
> to remove it for now (only used by nputop and vop, both unsupported) and =
come=20
> back to it if needed when VOP/NPU support is added.
>=20
> Would that work for this upstream ?

that would work. The whole delay thing is not part of the dt-binding
which would be more critical to get right in the first round.

So as long as your "add rk3576 support" patch really only adds the
rk3576-specific data, but does not change how the shared code
behaves, we should be fine and can find out about that delay later.


Heiko



