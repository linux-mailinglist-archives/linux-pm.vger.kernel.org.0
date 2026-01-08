Return-Path: <linux-pm+bounces-40484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8907FD047A8
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 17:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3260314A057
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 16:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26788274FF5;
	Thu,  8 Jan 2026 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZoMceo8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890B22B8C5;
	Thu,  8 Jan 2026 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889414; cv=none; b=u1du3odSinMhM+m7FAWAEQJyZhtr7YaWh7DrXYmATRy4m2HdmOftTA6B7zVpxscOIhov08glVohxnA5B/JcgK64ujZi0vaR7iWIr46KDhNsqOzhAvPvLF4Q6M0o6KnFN4joUBNDJwI0ytKt28Iu+T1PK0OpbH/LiMqS3EoIdIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889414; c=relaxed/simple;
	bh=gSsZxG351efBaDNbRvps68xQxExB2zun5oxFcNKBT9c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=laneJLiERIkfbCgAo/sqHUK0pLA8amRUSpXQIMXN53HQuq1uTxKQJj79usmwEeATZPv4WyQlBS7uwMofb5o2mmt3uI+FaSWp3CRJZpoD3x0GpJIvrRqCnM/uvjoXVgxzEochDWS2H71Ml6bZrN9zVX/mZUvpn2Y8qxB+/RU68T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZoMceo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45ECC116C6;
	Thu,  8 Jan 2026 16:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767889413;
	bh=gSsZxG351efBaDNbRvps68xQxExB2zun5oxFcNKBT9c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SZoMceo8qB67d+U9AuF4huBvALoYJbx3SWM+R6KmrwdlPIqfxMl99LSLsptJeLiIl
	 4R5OTNFsbgO5Qk9KC7FR2TDrUDXZTjMQMlmYB1d7fjRESpy7vGTGlP0n61GMvjMMvm
	 RpcfsSVL4VNkkFgh77n+/oC85D84bvj0N4WdeYfez0PRchlOgWcpNbU/vee5yAf7Mc
	 FwMvNBFEvy/m1/a27eEvEh2HpAi0SABL4e280kGMnPA6uiMm4kGT84pvSGq+CxweIl
	 WCBHVoiWATNuM/1vlHpBXjRg8vOQIphVAK0qDziN2q7fX879P7H8RalZab9fAguesn
	 RmGIJ+jv2fZzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78F063A54A35;
	Thu,  8 Jan 2026 16:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND][PATCH v2 0/3] net: Discard pm_runtime_put() return value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176788921029.3704775.16200371231139470355.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 16:20:10 +0000
References: <2816529.mvXUDI8C0e@rafael.j.wysocki>
In-Reply-To: <2816529.mvXUDI8C0e@rafael.j.wysocki>
To: Rafael J. Wysocki <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, briannorris@chromium.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 s-vadapalli@ti.com, rogerq@kernel.org, netdev@vger.kernel.org,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 07 Jan 2026 13:31:03 +0100 you wrote:
> Hi All,
> 
> This is a resend of
> 
> https://lore.kernel.org/linux-pm/5973090.DvuYhMxLoT@rafael.j.wysocki/
> 
> which mostly was a resend of patches [10-12/23] from:
> 
> [...]

Here is the summary with links:
  - [RESEND,v2,1/3] net: ethernet: ti: am65-cpsw: Discard pm_runtime_put() return value
    https://git.kernel.org/netdev/net-next/c/6961aa43654b
  - [RESEND,v2,2/3] net: cadence: macb: Discard pm_runtime_put() return value
    https://git.kernel.org/netdev/net-next/c/46786f66f2cc
  - [RESEND,v2,3/3] net: wan: framer: Discard pm_runtime_put() return values
    https://git.kernel.org/netdev/net-next/c/36775f3d5f70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



