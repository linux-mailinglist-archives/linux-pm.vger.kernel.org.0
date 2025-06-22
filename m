Return-Path: <linux-pm+bounces-29234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BBDAE31A9
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 21:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A2816E152
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 19:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D780F1FDA9B;
	Sun, 22 Jun 2025 19:13:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9F11FAC29;
	Sun, 22 Jun 2025 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750619599; cv=none; b=GhLxIsFIWtR844uqi/hfFrf/R6x+HpGTcuhk0UoyjMH8LMjar0eCRNaf5FuZzz+vTBaV1jcaIVHhNTS1vx72gzdrRp9ELK4Uiopjme3xa0jCXbNvABJClAJnPclTh76QVDsrEidKSQqR/TqqSn1CZSp0qFr3WHoXpLcy8Afc8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750619599; c=relaxed/simple;
	bh=UkrWaxu2UyuCillq505uwSRmqCGny23KsKu20t9PEJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IoBUqO9iExNoOO1xZPTM0SypCoQpQ/QJhswQHTrFuhJS996Hq/d6M/ZFw8Z5/JZ/8n5wMQseuLaBShLjJ0lekxl6Vvd/3LJeygf26Di5bZVVgwl4PRbkhqB4MyIgNvuuhgtaszcALDlhgBUWHFHNzxpha0xwFEqck1ejZndVrnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0E5C4CEF2;
	Sun, 22 Jun 2025 19:13:19 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 569EC18095A; Sun, 22 Jun 2025 21:13:17 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1ef0beb1e09bf914650f9f9885a33af06772540d.1746536287.git.geert+renesas@glider.be>
References: <1ef0beb1e09bf914650f9f9885a33af06772540d.1746536287.git.geert+renesas@glider.be>
Subject: Re: [PATCH] power: reset: POWER_RESET_TORADEX_EC should depend on
 ARCH_MXC
Message-Id: <175061959734.285737.1158842363498301438.b4-ty@collabora.com>
Date: Sun, 22 Jun 2025 21:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 06 May 2025 15:01:27 +0200, Geert Uytterhoeven wrote:
> The Toradex Embedded Controller is currently only present on Toradex
> SMARC iMX8MP and iMX95 SoMs.  Hence add a dependency on ARCH_MXC, to
> prevent asking the user about this driver when configuring a kernel
> without NXP i.MX SoC family support.
> 
> 

Applied, thanks!

[1/1] power: reset: POWER_RESET_TORADEX_EC should depend on ARCH_MXC
      commit: 22e4d29f081df8a10f1c062d3d952bb876eb9bdc

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


