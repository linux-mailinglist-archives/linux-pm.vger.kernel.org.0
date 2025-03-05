Return-Path: <linux-pm+bounces-23471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 060CEA4F952
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 09:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9E0188D25E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 08:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB8E1FDE2F;
	Wed,  5 Mar 2025 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YhY5E9MR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="kD1rLRYV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48CB191F75;
	Wed,  5 Mar 2025 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165030; cv=none; b=Orv1AjMFjDeKQfkMZKSNSbhEdAi0Sh6KgPf43y75oU+yYOpSrJM0t2BIyIsQwgfoREoMya7tPP+Df71FGgqYlYQLBiNbrDQimSu+C+uWAHD7iFVPpMEFf07Am4qOZj1ka4QKDTKv4e/NXMFSRieKHYAWeE6Gt/WYkRk95gOBuMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165030; c=relaxed/simple;
	bh=qsGsvCAfdcfeE51ac9RONSysVMtYIjNdL+vMqgURXUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLQ327KnYTMWvy1UFsd+zKJUFRhKcleJF9hao6k9ZdWx72ArRymkjZlpTg3zJn0h9JhhgAGLals2R4UzeCuxqWLf8hHsqIepLfDr6O5RCaCRCwV+AxqpHLCmd2zKZk1ZN/s56J9moNYCyt6ZrTocGMUuWAMC+BTzIda+Pmy9MXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=YhY5E9MR; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=kD1rLRYV reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1741165026; x=1772701026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e+jhkYS0TRz2o1la5b8D/3y4xT0VqD2+ekryj9z0zm8=;
  b=YhY5E9MRkL1bzexUheXHxzsAnUxw7MYdVwuJ9o5YNTk7GsZePzUJOUdU
   Rey1WV+tByzJRQl4p69S0TxfpZYx38yAB3zbjbH5uQwDqXAfBwKpGOBq3
   c1FnVaj460O5eY4Ly/SKe3GPG1uhKGsVfhamg8krsZQVouAG282Xa3f3s
   ja3ajHNjIITTMHILoDX4I4P9sf8MeoScwDC3fLefW7Jr4LSBTa+BeoX5p
   FYaRBHL8840gNXIpkPXzVjeVWbsN9sg6vYuACnEweWI/jnQhgr4JLB65h
   yq4dbFGGAzzmtz0tqehRqALpGVc878NR2BYfhUCArpOoUUQlyGttt2k10
   w==;
X-CSE-ConnectionGUID: tRwjRDSeTueS95ISt5PufQ==
X-CSE-MsgGUID: Mp++ScJxRMCuLKwD8CNM4Q==
X-IronPort-AV: E=Sophos;i="6.14,222,1736809200"; 
   d="scan'208";a="42301545"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 05 Mar 2025 09:57:03 +0100
X-CheckPoint: {67C811DE-42-F35B2447-E1635CDE}
X-MAIL-CPID: AD65E4B5510E62E90C988CDA2D9A3F96_1
X-Control-Analysis: str=0001.0A006369.67C811E2.0079,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57F63170E8E;
	Wed,  5 Mar 2025 09:56:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1741165018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+jhkYS0TRz2o1la5b8D/3y4xT0VqD2+ekryj9z0zm8=;
	b=kD1rLRYVbR3w7K+GjtmEYISp04lQVjebsKh0ladQK1ogzl0H2UjpGi0i4ws1KRAWE9Ben5
	J/KK43vOQAQglcqLXMdTLik/Proj5m3Zrr6y8DiM1oZIWRBB+AU9hV4GTpuMlH4tRoYhMX
	f5qdmvq+GeBBXE8uYaflFBt9jBdLbEo3UfXoj39skcRBERlo3pvaNiVjxGtcRhWbfTSR5K
	ldNQG+ygagGit6y17MuQcwn+Nt3MgoKh7WsT/yCaOZmtosTKn0MDN1YFghS/w5IXgF6OcT
	xEJlW0G3MR6dajelV0nnEPPFgqVPU2SxMW1Evo+vvmhX1cvan1wM/aT4IxJX+w==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@ew.tq-group.com, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v3 3/6] pmdomain: imx93-blk-ctrl: Scan subnodes and bind drivers
 to them
Date: Wed, 05 Mar 2025 09:56:55 +0100
Message-ID: <23858231.6Emhk5qWAg@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250305-keen-shaggy-bullfinch-fc77fd@krzk-bin>
References:
 <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
 <20250304154929.1785200-4-alexander.stein@ew.tq-group.com>
 <20250305-keen-shaggy-bullfinch-fc77fd@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Krzysztof,

Am Mittwoch, 5. M=E4rz 2025, 08:17:23 CET schrieb Krzysztof Kozlowski:
> On Tue, Mar 04, 2025 at 04:49:22PM +0100, Alexander Stein wrote:
> > +#include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> > @@ -297,8 +298,14 @@ static int imx93_blk_ctrl_probe(struct platform_de=
vice *pdev)
> > =20
> >  	dev_set_drvdata(dev, bc);
> > =20
> > +	ret =3D devm_of_platform_populate(dev);
>=20
> This means in remove() you will depopulate in different order than error
> path (e.g. after genpd removal). This is rather unexpected - remove()
> should be cleaning up in exactly reversed order of probe. Not sure if it
> can lead to any issues, but usual recommendation is that you either use
> devm() or not.

Thanks for pointing out. I will add a devm_of_platform_depopulate() to
remove().

Best regards
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



