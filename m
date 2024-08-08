Return-Path: <linux-pm+bounces-12003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B6A94C3EC
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 19:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3941F22837
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 17:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7195B1448F2;
	Thu,  8 Aug 2024 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="SUf2zPf8"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A989C12CDAE;
	Thu,  8 Aug 2024 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723139549; cv=pass; b=anBePdCG7naHPHH4OutKUlVUfaJegeX/lkGR+xNY5EOluQt/e2Y+QpVugRDVbCgqECUskrQivnk3Q4AC3w0bNpEHkSb7PxaW7l5lK73L2X04+uwliSKboLjoOsh1qhkb5URHWp/IUEAHBFYyZwvXxvVfAJTZXe1z6RZA4k/yTxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723139549; c=relaxed/simple;
	bh=J+kCj9xB02trLEDSGjOa+PeGNVfgddKIWq+oSVKBPIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXepOc84lEDNM2gq0utbRlHLOveJJ7c1w/bEDsEmhP5246gYJbXN8+IMU3bpvhmUXiLRrfpj1zaS0YJ9cBSRgtbbrzMAPjRoV8+Y+CtR8+bsqixd9ZScupKx/lsYzsZO2Lrr8WwukGvVIsNVp0e6PTLhoswsp4pittbNil2qB7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=SUf2zPf8; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723139524; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z5RkGYweZDCj33L+9XVp7NUsy9qorTJumRZa1LgxuRjS80WUvyI0CLLtoi/YIn+y7pVZ8Q4wYe6/yIUvFdioWrfBZKhanGSSAOjDqOvP1Bh/CjXQTpRnJnLObqFyLsEgo/BG+d3YEHASnTjmU1AZ4c6oFG5ZtnPcmfdjDZ8uKA0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723139524; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZPWX9nQFc4zdu6yspZOvI5jMNY9Ewabr9vrBLea3YM4=; 
	b=V1ep5TXuqay3hF4BdasanLQtOeW0lGjl02E0MCusyLESdyoUGbnEHRu6U3pwcWx76ZOAU3MbjAfz+5hpY9xH47RtRSqgGQ1qjy4UU/hlDS3RfkjHVTGU4U/B9wl3wc0VVIIruOhvIuxSPqkpdeiBrTrVxaq/R+vRntZ0Gue+Q34=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723139524;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=ZPWX9nQFc4zdu6yspZOvI5jMNY9Ewabr9vrBLea3YM4=;
	b=SUf2zPf8ofT0XUr+yvKRzZjdSOZkiv/HcHz6jC112prhVEf3TDQ8+QJCqXXkrhb1
	0LbtgkeoyybsSLxaRYrYYrGqTJt1wGXpS3lVq2RuAEnICwk2lkbGu8LlqjhQMBVrcti
	IwJBAERJ4k3P7/WIzfHVKJa9VS9z7xWgKF6dLD+4=
Received: by mx.zohomail.com with SMTPS id 1723139522203254.50577975633348;
	Thu, 8 Aug 2024 10:52:02 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org,
 Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Arnd Bergmann <arnd@arndb.de>, Elaine Zhang <zhangqing@rock-chips.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v2 2/2] pmdomain: rockchip: Add support for rk3576 SoC
Date: Thu, 08 Aug 2024 13:53:20 -0400
Message-ID: <5805279.DvuYhMxLoT@trenzalore>
In-Reply-To: <17766579.lhrHg4fidi@diego>
References:
 <20240808163451.80750-1-detlev.casanova@collabora.com>
 <20240808163451.80750-3-detlev.casanova@collabora.com>
 <17766579.lhrHg4fidi@diego>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

Hi Heiko,

On Thursday, 8 August 2024 12:41:05 EDT Heiko St=C3=BCbner wrote:
> Hi Detlev,
>=20
> >=20
> > @@ -552,7 +575,10 @@ static int rockchip_pd_power(struct
> > rockchip_pm_domain *pd, bool power_on)>=20
> >  			/* if powering up, leave idle mode */
> >  			rockchip_pmu_set_idle_request(pd, false);
> >=20
> > -			rockchip_pmu_restore_qos(pd);
> > +			if (pd->info->delay_us)
> > +				udelay(pd->info->delay_us);
> > +			else
> > +				rockchip_pmu_restore_qos(pd);
>=20
> I still want this behaviour change in a separate patch with adequate
> commit message please.
>=20
> Going from always handling qos to allowing to just wait a specific time
> needs explanation and is not part of "just" adding rk3576 support.

You are right, I didn't takle this issue.
This is actually a bug, the else is not supposed to be there, it should onl=
y=20
be an added delay for some PDs.

Unfortunately, I'm not sure why that delay is needed exactly, so I'm willin=
g=20
to remove it for now (only used by nputop and vop, both unsupported) and co=
me=20
back to it if needed when VOP/NPU support is added.

Would that work for this upstream ?

Detlev.





