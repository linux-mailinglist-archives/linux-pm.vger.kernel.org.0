Return-Path: <linux-pm+bounces-27430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83844ABE2C7
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 20:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E8F1BC097D
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 18:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D9625B1C5;
	Tue, 20 May 2025 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="TnlDoJMg"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3201A2580F7
	for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766326; cv=none; b=RVsehKlbPv7ZBqZ/n4SQewKRSWWg1cmladrli8qQTT1VUGjrNsIyVipEyk5zACd8FUSRICjfInqbbIYRx8BgASpkE8pGlc3fw+A9RDSPs99vuM97XNviLpkhO/XuYLRcAzhok/QQHmqIwpkcnqfp23XquyGL7hBc86109NU7EKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766326; c=relaxed/simple;
	bh=rWwnfB/TbeNImJkz273xKx5BFJ5CIQ0KcX4dNJ4mTtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rlsp9UjiRC7TDx/efyzldLc5ZCoDLPnddMvRxl5JUYHAwu6Iyt5muU1DBfiqsYPO3c7Hq1/wp8COcGwxurX7/WHhKnX1wn3LU2F8brl6jzjufj6FjAfSd3fhjMPMBpmSDAIHXalIXGoh64LGpVVcj660ogfm7bQ5l08LBXQX/eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=TnlDoJMg; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=u3v+sVXn3QS5HAZR6rlTvCjsDNvFK3/tVpaq1eLWVu0=; b=TnlDoJMght2Uzy7gaxZQpE1Dr9
	FusfAMBSB6rYCB2jSSC2ocaG3pmnnC4ac1wuEfYHlSIWE//NkQMgDiSNIZBHdGGoNVIQf/sYrAhqG
	dGCCrZbu6H8GDMuGifH6qjt+7lRyybeemwOSPelvQg/A+kZfDzwOtwuL34RG66DgyKh3uw4RaAEBk
	poOhLxpuPu/Biw69o9blr5h40q1O9+pbNAgjjysf+DpidOyYQfHxJ266061ZSTRZrvEeI+NPv/zMw
	QIe7wsj6hRfUThpCKD8m2PTrPcOkSR5CfY3ChPnCz3zoRItFVsnX+Ha7e9T65SpWH1PgqgKBFhh+I
	pRpNb4HQ==;
Received: from [61.8.146.112] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uHRrM-0004Av-9K; Tue, 20 May 2025 20:38:40 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: ulf.hansson@linaro.org, mark.rutland@arm.com, lpieralisi@kernel.org,
 sudeep.holla@arm.com, Robin Murphy <robin.murphy@arm.com>
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] pmdomain: rockchip: Relax SMCCC dependency
Date: Tue, 20 May 2025 20:38:39 +0200
Message-ID: <2393836.usQuhbGJ8B@phil>
In-Reply-To:
 <6f0a38e596c0727d0de13a29c9224f71bc7d30f1.1747760015.git.robin.murphy@arm.com>
References:
 <ab0476382e3342161beda94a45ddadb49b026dcd.1747760015.git.robin.murphy@arm.com>
 <6f0a38e596c0727d0de13a29c9224f71bc7d30f1.1747760015.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 20. Mai 2025, 19:10:17 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Robin Murphy:
> Most 32-bit Rockchip platforms do not use PSCI, so having to select
> ARM_PSCI to satisfy a dependency chain to retain working power domain
> support is a bit weird and non-obvious. Now that the offending SMCCC API
> is properly stubbed out for optional usage, we can relax this again.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>


Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Of course this needs patch1 of this series to get applied
first.

I think for bisectability, doing this directly in patch1 might
be less dangerous though?


Heiko

> ---
>  drivers/pmdomain/rockchip/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/pmdomain/rockchip/Kconfig b/drivers/pmdomain/rockchi=
p/Kconfig
> index 218d43186e5b..ffe5e7b78494 100644
> --- a/drivers/pmdomain/rockchip/Kconfig
> +++ b/drivers/pmdomain/rockchip/Kconfig
> @@ -4,7 +4,6 @@ if ARCH_ROCKCHIP || COMPILE_TEST
>  config ROCKCHIP_PM_DOMAINS
>  	bool "Rockchip generic power domain"
>  	depends on PM
> -	depends on HAVE_ARM_SMCCC_DISCOVERY
>  	depends on REGULATOR
>  	select PM_GENERIC_DOMAINS
>  	help
>=20





