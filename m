Return-Path: <linux-pm+bounces-15692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF2699F874
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15082863F0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4C81FAF18;
	Tue, 15 Oct 2024 21:01:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F56D1F9EB5;
	Tue, 15 Oct 2024 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026086; cv=none; b=PvvTeQa1XYL5UPW30nNiDc+yRuyyWO+3Ge4hm+A57DQkJ2OwTzj0EctXuR3jMBwF3ZMxK2D+Ss5hvcPjS4CHuPtcPKq5GSvKNQOJfu3n+0VnPnmcIrijGdRUBncPsZryA+iKLQeflMffm7dXbcJtobG1O37rpn7jRSbdHrDc+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026086; c=relaxed/simple;
	bh=rFP5aiFo5gPBll5iSGgzw2eSuiBpiYmPQVeMX6hiXHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YVo3dlClpJAzohBhVV1aJGX9jdpE3IPP+FQG4IrC24PFLxF1e5PoJ60Wa8At/XhVoLxsVu083z8MUtaGA8EjVuC/TEJI+r0unpcEYELKCumGOGGpufuHoaWWEg6yYmBzJmtwD9HQP3GSCDioRUSpkCEn+i4vfpNaLFb4Dyp3aGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD191C4CED0;
	Tue, 15 Oct 2024 21:01:25 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 6595A1060433; Tue, 15 Oct 2024 23:01:23 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
References: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
Subject: Re: [PATCH 0/7] power: supply: constify ocv and resistance tables
Message-Id: <172902608335.467915.16942683889560111430.b4-ty@collabora.com>
Date: Tue, 15 Oct 2024 23:01:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Sat, 05 Oct 2024 12:04:16 +0200, Thomas Weißschuh wrote:
> These tables are nevery modified. Reflect this in the API and constify
> the table definitions.
> 
> 

Applied, thanks!

[1/7] power: supply: core: constify power_supply_battery_info::resist_table
      commit: 58797abed49d6b78c7af99b03b037f20c7ffb203
[2/7] power: supply: ab8500: constify resistance table
      commit: 40d00fa5a8be87812a7acb6524eb3d8fd3ea42b9
[3/7] power: supply: samsung-sdi-battery: constify resistance table
      commit: 27fde3aa4f924793966c8aa5b10506c41ce933e1
[4/7] power: supply: sc27xx: use const reference to ocv table
      commit: 840683c341907b37173e270798607a83462118f1
[5/7] power: supply: core: constify power_supply_battery_info::ocv_table
      commit: ce20d5b9e37099a035ab34d4d3f59e1744756385
[6/7] power: supply: ab8500: constify ocv table
      commit: b7b6bf444529c2ead9416e79d8dd8a2cb832cd24
[7/7] power: supply: samsung-sdi-battery: constify ocv table
      commit: b5289ba57a27a212acad14b81ec6597ce140e01d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


