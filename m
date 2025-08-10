Return-Path: <linux-pm+bounces-32099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A0DB1FC35
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 23:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401F4177AB9
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 21:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24B02580D1;
	Sun, 10 Aug 2025 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Osf4jbmh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C7253B42;
	Sun, 10 Aug 2025 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860335; cv=none; b=sMuNurCZomjKdZo1t427T0v447vluYZdCivwEfLftJ39QhSc00tay5QR0qH9ZVZCb8oR27mItyoB0btLgu7H8gfaGWX+NSggBXKQEknj/Htvt2jKbR8zYpcUT//kasijhnNYnynX5Lf/hxYRZbi6+Cwt76hyX4EalYd4Mk/2QcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860335; c=relaxed/simple;
	bh=6qZtmYPtQt6UwAsXJ30diF7OIT7IeXGDZboQy/POMhY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FoqfiyPJCjHqjbN7WKY+UXfkGt35bgtl1PXPMHsTeYa6uy4vmcMtOlKc4bzSQg4ScN/ou7aR1Xg+izox8mPzh2mmZF9f0IMt58wGBco9pfZNIWV2f1KaN9juUifd7Zas3fXylucK/mo2jJDl7rNf2jCtxrhQe6RG2ZFWrT7Kg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Osf4jbmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AB4C4CEF8;
	Sun, 10 Aug 2025 21:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860335;
	bh=6qZtmYPtQt6UwAsXJ30diF7OIT7IeXGDZboQy/POMhY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Osf4jbmhAA6UtiHphDxnXbpyWNtr3NtPHo5Orbi0VcusCvyEN9ju4ZjusP9njFz0y
	 BEkKw4L9d2HggMgUg7UxPMaJCZcFjxD/l1aEeiE88jk/Z9s6h8G7jsyj0R6w8PRtOW
	 Q45wlJ8ga//bPDscDGu5K/FJj0cygWL75l6w91Y7G71cWNVO7AzOk1LkNr6grMkJUq
	 mFQc3Fl9RDiCcv0j+VvneBDn7JCeUX1nDthOy733XoPFAo2bOeHoYi0oadwLSTC+KY
	 DiOT9Kp/cteJ2xGwnIAzNOpXuBDjuXNkLxi9V4Wvv2cvfoJOgqwCUBnCGnyEyRb3GR
	 jDjiXPYViAJDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D4339D0C2B;
	Sun, 10 Aug 2025 21:12:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 08/21] cpuidle: riscv-sbi: Opt-out from genpd's common
 ->sync_state() support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486034774.1221929.3623715142191297628.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:27 +0000
References: <20250523134025.75130-9-ulf.hansson@linaro.org>
In-Reply-To: <20250523134025.75130-9-ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-riscv@lists.infradead.org, saravanak@google.com, sboyd@kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
 m.grzeschik@pengutronix.de, andersson@kernel.org, abel.vesa@linaro.org,
 peng.fan@oss.nxp.com, tomi.valkeinen@ideasonboard.com, johan@kernel.org,
 maulik.shah@oss.qualcomm.com, michal.simek@amd.com, konradybcio@kernel.org,
 thierry.reding@gmail.com, jonathanh@nvidia.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 anup@brainfault.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Ulf Hansson <ulf.hansson@linaro.org>:

On Fri, 23 May 2025 15:40:05 +0200 you wrote:
> The riscv-sbi-domain implements its own specific ->sync_state() callback.
> Let's set the GENPD_FLAG_NO_SYNC_STATE to inform genpd about it.
> 
> Moreover, let's call of_genpd_sync_state() to make sure genpd tries to
> power off unused PM domains.
> 
> Cc: Anup Patel <anup@brainfault.org>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> [...]

Here is the summary with links:
  - [v2,08/21] cpuidle: riscv-sbi: Opt-out from genpd's common ->sync_state() support
    https://git.kernel.org/riscv/c/ee766b017586
  - [v2,21/21] cpuidle: riscv-sbi: Drop redundant sync_state support
    https://git.kernel.org/riscv/c/eb34a0b5fee7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



