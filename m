Return-Path: <linux-pm+bounces-16440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CC79AFE13
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 11:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584621C228EF
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2671D4615;
	Fri, 25 Oct 2024 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="FYFaZyx+"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4251D3181;
	Fri, 25 Oct 2024 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847957; cv=none; b=PFCCify80tVElW71HbWC6gSv5yJv/yyqB6n/tbfsBwx5tV5640Lc05atJ+DrMF/S14o7ZQmKnvB4vapFNx27JZ44eW6ua6PqqokrvS1T5B0TL/jUmZg0/nvRzmXfbZiX0n1u5Mz91DStotlzUfpZaY2Cwwv2AzzKWUZtECoqKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847957; c=relaxed/simple;
	bh=jGwRrHVrMrQhrU93MbTVsh1zFw3AeLdhWIEmfA4/8ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfIoYEHoTUODtsqt1NXaIQe9yTd2elnodR0S73qLhPbK1TJlMoLvFyLZLS91O2lVWQTt/hSPO7wdzEgzLgrp5RTnkUvf1vlec/ijQFKluHVE1HolQMh6pho+RIZSWIcT13M1CoVwE9FWoFawWvwGZ0Z2FrxRjsPmVg9NhTc373U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=FYFaZyx+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y+jm9ardZfDQqVqtaj+yn7oty3xNlqz/dKihmWT8xaE=; b=FYFaZyx+NfXBTA/kmDH+CvbKAT
	9G8SxA0/a14dY6GCNROeC8sI5TlH5eC5mp+KdcnxtAPmWtvUYHBrzjGROCSD1SHBUx0sOBLFmadWi
	8c7Wol6ijbwAKzVqKBS/ma7Wx6Jc0I98kOl8TkWZWMv1/PRL+rBqmuMadgL6UMd5cTsgqfgQlenSG
	5HlCExAuwXR5muP/9zFcgrrINeut+nWXd53zdJifo9WSmI6CP55o2mUPjo53BHqdOjMPAF0x/v14i
	LmdSguVRgkKIlEPmwZeG1DcWktKT1MvKyPEOgLCjJK9SOLqDcWDq9KCHFTmSry/n3UJUtaB45sTOq
	bAC4Ol9A==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t4GTJ-0008U9-V4; Fri, 25 Oct 2024 11:19:05 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 =?ISO-8859-1?Q?Adri=E1n_Mart=EDnez?= Larumbe <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com
Subject: Re: [PATCH v3 0/7] Fix RK3588 GPU domain
Date: Fri, 25 Oct 2024 11:19:04 +0200
Message-ID: <16964583.geO5KgaWL5@diego>
In-Reply-To: <20241022154508.63563-1-sebastian.reichel@collabora.com>
References: <20241022154508.63563-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 22. Oktober 2024, 17:41:45 CEST schrieb Sebastian Reichel:
> Hi,
> 
> I got a report, that the Linux kernel crashes on Rock 5B when the panthor
> driver is loaded late after booting. The crash starts with the following
> shortened error print:
> 
> rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'gpu', val=0
> rockchip-pm-domain fd8d8000.power-management:power-controller: failed to get ack on domain 'gpu', val=0xa9fff
> SError Interrupt on CPU4, code 0x00000000be000411 -- SError
> 
> This series first does some cleanups in the Rockchip power domain
> driver and changes the driver, so that it no longer tries to continue
> when it fails to enable a domain. This gets rid of the SError interrupt
> and long backtraces. But the kernel still hangs when it fails to enable
> a power domain. I have not done further analysis to check if that can
> be avoided.
> 
> Last but not least this provides a fix for the GPU power domain failing
> to get enabled - after some testing from my side it seems to require the
> GPU voltage supply to be enabled.
> 
> This series is now based on the pull request from Mark Brown:
> https://lore.kernel.org/linux-pm/ZvsVfQ1fuSVZpF6A@finisterre.sirena.org.uk/
> 
> I added one more patch, which adds devm_of_regulator_get without the
> _optional suffix, since that is more sensible for the Rockchip usecase.
> Longer explanation can be seen in patch 6, which adds the handling to
> the Rockchip driver. My merge suggestion would be that Mark adds the
> regulator patch on top of the immutable branch and creates a new pull
> request.
> 
> The last patch, which updates the RK3588 board files only covers the
> boards from 6.12-rc1. Any board missing the update will behave as before,
> so it is perfectly fine not to update all DT files at once.

My rk3588 jaguar somehow developed some delay when dhcp'ing for its nfs
root and with that actually started running into that gpu-regulator-issue.

With this series applied, that issue goes away:

Tested-by: Heiko Stuebner <heiko@sntech.de>



