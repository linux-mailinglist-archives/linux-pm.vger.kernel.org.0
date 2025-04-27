Return-Path: <linux-pm+bounces-26302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A5DA9E50C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 00:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764AB1897C8B
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 22:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D97204599;
	Sun, 27 Apr 2025 22:50:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595401FFC48
	for <linux-pm@vger.kernel.org>; Sun, 27 Apr 2025 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745794219; cv=none; b=INpGFSLtDkC/4ZT/K54ZYk3b6OcbuOD2SRNkBiYFZXl/qFdCF6gnlzzTg4qzmkRW+HMJE9dO5MC4fiie6pvNPg1Q7n3QgiwNqfThTCN1XShGaHwhQ2F9xxWBUo1QW83ELu9KQ0mSNS2kXCa1mtZoXNyuOWKETZF3XWmAsLbGuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745794219; c=relaxed/simple;
	bh=TuGRt2lzwCeb1p5lsab0EE61UqfMdFNnJ1H5vhKp7Ic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PAtni/g5qx4sxsGQM4b5tFASuJatcL2Gx2nubxv4Kc88/95QYixohPPBOVQcxfMzD10xIMjHkSwY9+FtJZmPKhtf1GDZ1+wMdVvxA0NjsPXPFbG4Yanw1EgFsFsjecoHfkwwWOC9DYBjSOjmlveEz6VbRtONdAXKMVnjy9+WzGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBC0C4CEE3;
	Sun, 27 Apr 2025 22:50:18 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id B721D1808BE; Mon, 28 Apr 2025 00:50:16 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, 
 Alexander Shiyan <eagle.alexander923@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20250307053809.20245-1-eagle.alexander923@gmail.com>
References: <20250307053809.20245-1-eagle.alexander923@gmail.com>
Subject: Re: [PATCH] power: reset: at91-reset: Optimize at91_reset()
Message-Id: <174579421672.295785.6107429632907980615.b4-ty@collabora.com>
Date: Mon, 28 Apr 2025 00:50:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 07 Mar 2025 08:38:09 +0300, Alexander Shiyan wrote:
> This patch adds a small optimization to the low-level at91_reset()
> function, which includes:
> - Removes the extra branch, since the following store operations
>   already have proper condition checks.
> - Removes the definition of the clobber register r4, since it is
>   no longer used in the code.
> 
> [...]

Applied, thanks!

[1/1] power: reset: at91-reset: Optimize at91_reset()
      commit: 62d48983f215bf1dd48665913318101fa3414dcf

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


