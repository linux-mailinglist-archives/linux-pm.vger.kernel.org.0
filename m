Return-Path: <linux-pm+bounces-40621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CB5D104B9
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 02:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2EC0300728F
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 01:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A4823EA8E;
	Mon, 12 Jan 2026 01:56:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2F1237163;
	Mon, 12 Jan 2026 01:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182966; cv=none; b=lpgvC8fwKJoQEV0T0j1+M33c2nnzkLHyNNN24pC6NMCkQUjj3wSpcn4R9tB3N2ipyTEnnynDE1Se/NRFfasttJ+Fn7J7f8NIumrSytORmcFZoO3p39vYNOtvnao0/xTaSxGjtTIFopc4fM1yjZm1KefdnWR4UUwTyCnI25eCNSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182966; c=relaxed/simple;
	bh=w49V3ZKvhTE6VQpxuqfw0eGfrZbl/Xfp3oLXYwJXRQw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G8cDaIZAIzGUVKRtl5aEE+bfyZ7j8/YPDiAY8upLuKu3U5tjvri63fpDBDcm1NgTDWD8x5Nz12XSB3x0FVLoa2jgdnAvyfdk7uF0c9h7qi2hZ5+6lqhBX6oCTUEE3VJkZ4UNJEeHLW04wFHNFWKSfq5Hjlxn0O/cI98nn4u35GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FF1C19425;
	Mon, 12 Jan 2026 01:56:06 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id EFFB1180534; Mon, 12 Jan 2026 02:56:03 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Tobias Schrammm <t.schramm@manjaro.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1766266985.git.waqar.hameed@axis.com>
References: <cover.1766266985.git.waqar.hameed@axis.com>
Subject: Re: [PATCH 0/5] power: supply: Remove unused gpio include header
Message-Id: <176818296396.643060.5342827931953504236.b4-ty@collabora.com>
Date: Mon, 12 Jan 2026 02:56:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 20 Dec 2025 22:54:07 +0100, Waqar Hameed wrote:
> These drivers include the gpio header but never use it. This patch
> series just removes this unnecessary header.
> 
> This issue was found when writing a new driver for the upcoming TI
> BQ25630 [1]. Patch adding support for that one will be sent as soon as
> TI releases the datasheet publicly, which should be anytime soon...
> 
> [...]

Applied, thanks!

[1/5] power: supply: bd99954: Remove unused gpio include header
      commit: e312b7e3183d2d806609ee0e905da807ff5d891f
[2/5] power: supply: bq256xx: Remove unused gpio include header
      commit: 38673fd9d622318eed1e35cfad5998b4056edc1e
[3/5] power: supply: bq25980: Remove unused gpio include header
      commit: 3d74b6dfd703ba812c624c689451b0ae573b4f0b
[4/5] power: supply: cw2015: Remove unused gpio include header
      commit: 91a4f92de8454621e9d4e77a58c19c9d60a69581
[5/5] power: supply: ucs1002: Remove unused gpio include header
      commit: ce3bc8469e4c387fd937e2ef96a6d45b7e22afc7

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


