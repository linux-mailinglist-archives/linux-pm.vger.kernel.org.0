Return-Path: <linux-pm+bounces-15990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 718699A46FC
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 21:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C361C20DD2
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 19:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83440757F3;
	Fri, 18 Oct 2024 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Odg0szGu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5278720E33D;
	Fri, 18 Oct 2024 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729279827; cv=none; b=C0s3ofYJSN16v9u3vA6NSX0QURJd6NNEM0gBUTnsb6bTVBZDUKNaYToxsvy7lbSB9QXmIJqWyx5ItGK/FgVW5NGmzvcK6U16KfoPPkBk28+/DGJFOaPOj49DevIdFcfiZTbOaw3sGm82OIdaeKaoJQcqm6x1HF/pBsockp6LTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729279827; c=relaxed/simple;
	bh=p9ULyfH5xSo1quqZ2zJZlf3a0m4okW+HzZ99xgU0074=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vEpCCpSGkA0YhpYRncueSL4GgIUYG+x7Uet/TZaL7Clnk1fNGXVGGN1ZfU0je4wxmNPToeKTFsTa3fO6BEQ8oiDLyqRenJYRZ4IBKG0Hjw8nmWXowJ7Ly1nsE677ths5o07AGd0BPZcdJB7n2KiGeYCesZ4JFvj8/iPeXdsUIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Odg0szGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AE6C4CEC3;
	Fri, 18 Oct 2024 19:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729279825;
	bh=p9ULyfH5xSo1quqZ2zJZlf3a0m4okW+HzZ99xgU0074=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Odg0szGui3Hynaz4FDwV1jtwEkU6wtWbbds1g9Gy0SM2rfQnNVglc+3zjONcEHCJh
	 KHQ0kzbZEDJv/cJzV86GtpN1X2j7Ibq/vkUQwB4FJsQNRT+HdhqqbxpQF0dSWKELsN
	 7JWEdskOsIPTDVubkNFlIwniDAo0d1DucnwqUOj9Rfdtt+UtM/pbAbSDT5zPgDk4uN
	 23f9YoHf4i7x00AsR70HryHXOB3RjqUG3rH4jDWniYTq1h1QMPUYAUa0aVR/oHZcnf
	 bU+H7zHfm2W82OX6zMqo6OurdH54AJIk+0o6o7+QCEX0rKrP+nOhuBCvWWfTrdhZ7F
	 SpTpXsL4CR7bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD583805CC0;
	Fri, 18 Oct 2024 19:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] cpuidle: riscv-sbi: Allow cpuidle pd used by other
 devices
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172927983117.3213860.9782496340545347046.git-patchwork-notify@kernel.org>
Date: Fri, 18 Oct 2024 19:30:31 +0000
References: <20240814054434.3563453-1-nick.hu@sifive.com>
In-Reply-To: <20240814054434.3563453-1-nick.hu@sifive.com>
To: Nick Hu <nick.hu@sifive.com>
Cc: linux-riscv@lists.infradead.org, anup@brainfault.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, greentime.hu@sifive.com, zong.li@sifive.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 14 Aug 2024 13:44:32 +0800 you wrote:
> Add this patchset so the devices that inside the cpu/cluster power domain
> can use the cpuidle pd to register the genpd notifier to handle the PM
> when cpu/cluster is going to enter a deeper sleep state.
> 
> Nick Hu (2):
>   cpuidle: riscv-sbi: Move sbi_cpuidle_init to arch_initcall
>   cpuidle: riscv-sbi: Add cpuidle_disabled() check
> 
> [...]

Here is the summary with links:
  - [v2,1/2] cpuidle: riscv-sbi: Move sbi_cpuidle_init to arch_initcall
    https://git.kernel.org/riscv/c/f8a23e3b79d6
  - [v2,2/2] cpuidle: riscv-sbi: Add cpuidle_disabled() check
    https://git.kernel.org/riscv/c/27b4d6aa29ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



