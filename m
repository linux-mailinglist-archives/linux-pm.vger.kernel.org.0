Return-Path: <linux-pm+bounces-32100-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAC1B1FC38
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 23:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EEE93B1306
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 21:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31706262FC2;
	Sun, 10 Aug 2025 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMEJ8Gq2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C07220F4F;
	Sun, 10 Aug 2025 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860337; cv=none; b=oPLitNWO31+mcAMvId9cmYeAvPCx+HgHlI3qldQ30kJtSNMUaYWtELiDv/3XVKaV7XPfOP/mAgdybhcwjy7WdUlBNfU73bYLj4qzUaH1Lya+I0XER4zSRG2/6nmEQFkkYmWMZNPVA8w7SD7vD9WoFJ9Tq602tUzzvUjl/XKCpvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860337; c=relaxed/simple;
	bh=9MmiwSbOpn9sJ3k+9vBWQv8oVw1RiwTCpsRy+r+Y3B8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jxkzGHhbCUGAAA2tEjnUc65teTLRc0lzRqeH2grwXELhiURKWIkTjHKpLRPlASwtQFJ7y7LlRbh3BOllW6moZVrM76vXbhS277RkatWWerRG5ygP/tUTj2Ii+dcMN7e+zyh4fe9KSqehGgZuD6028mPS8yKTpjrGB6FdHh7ULjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMEJ8Gq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEF6C4CEEB;
	Sun, 10 Aug 2025 21:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860336;
	bh=9MmiwSbOpn9sJ3k+9vBWQv8oVw1RiwTCpsRy+r+Y3B8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rMEJ8Gq22UebkrmVDbiKKeRUjqO/BW93ToXRYdfhGef1rLm5v/DuIs+VOmVha52Ua
	 9BqJE4gioTZ7AojQDm04GlNgy5Ux+iDN7tQWmeq5mlfjfFHf66ecZyi8j8MrgHO3mP
	 r9P60YJAIb8m6DeUXFcpWqx7KfojCPpESsduM6p+DwoC3AGuvpVd3muUBsBkK+D7pO
	 67m4Mw9G7jlYvkOrg8CycH89yy9R0nhoBgGvkS/GRnexFMxOcmo6VhXoyF+NfZD6ZU
	 9zOkMONCwi7Tyy277v2z5aOeU8Mny/cEbjQ6xXEa8fW9kqlk2MZuVkIHF729qu1J6u
	 uqTqY/JUOOHVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD2139D0C2B;
	Sun, 10 Aug 2025 21:12:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 11/24] cpuidle: riscv-sbi: Opt-out from genpd's common
 ->sync_state() support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486034925.1221929.6715963825149639363.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:29 +0000
References: <20250701114733.636510-12-ulf.hansson@linaro.org>
In-Reply-To: <20250701114733.636510-12-ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-riscv@lists.infradead.org, saravanak@google.com, sboyd@kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
 m.grzeschik@pengutronix.de, andersson@kernel.org, abel.vesa@linaro.org,
 peng.fan@oss.nxp.com, tomi.valkeinen@ideasonboard.com, johan@kernel.org,
 maulik.shah@oss.qualcomm.com, michal.simek@amd.com, konradybcio@kernel.org,
 thierry.reding@gmail.com, jonathanh@nvidia.com, hiago.franco@toradex.com,
 geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, anup@brainfault.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Ulf Hansson <ulf.hansson@linaro.org>:

On Tue,  1 Jul 2025 13:47:13 +0200 you wrote:
> The riscv-sbi-domain implements its own specific ->sync_state() callback.
> Let's set the GENPD_FLAG_NO_SYNC_STATE to inform genpd about it.
> 
> Moreover, let's call of_genpd_sync_state() to make sure genpd tries to
> power off unused PM domains.
> 
> Cc: Anup Patel <anup@brainfault.org>
> Cc: linux-riscv@lists.infradead.org
> Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
> Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> [...]

Here is the summary with links:
  - [v3,11/24] cpuidle: riscv-sbi: Opt-out from genpd's common ->sync_state() support
    https://git.kernel.org/riscv/c/ee766b017586
  - [v3,24/24] cpuidle: riscv-sbi: Drop redundant sync_state support
    https://git.kernel.org/riscv/c/eb34a0b5fee7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



