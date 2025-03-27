Return-Path: <linux-pm+bounces-24550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B84B8A7293A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Mar 2025 04:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59932189E647
	for <lists+linux-pm@lfdr.de>; Thu, 27 Mar 2025 03:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671B21F09A5;
	Thu, 27 Mar 2025 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhbjfZ8I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409A01F0994;
	Thu, 27 Mar 2025 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743045872; cv=none; b=G3zRqBlgWr33QURZ+O9LWK7qGZH5osDuSajPkUH7zYY+1B3l/55ImfBD3MqR8mNs5T/Mm69miBT3CtFpuNvDUrB8GYs+SqHnN5eCFua+liLfKYdLLbtVj7iVTUAOfEMyAUxSsS6L5JlkbYRCk3ZeV3KXECveOpNyhJ0/2RaJRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743045872; c=relaxed/simple;
	bh=LFo4fJhj7LYS+DWRELXN3oisPqu60X2eAPFXsH5rLOI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oTJYuO+DzIahmBYcV9cAvv2b2yA84K45kCdvvhNHYnamhaPMhJOKyqrWW9NJ+e8EJT5cc6v7Ud4MrdDRaaMpJv+gTavxfTb+zl9FUfusawEMBrSOcp+igG754u/e1t9LoN3S7D4o8Qv/o4C5CNK1yORc2ichXu2yXc2mk4KDxDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhbjfZ8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3CFC4CEDD;
	Thu, 27 Mar 2025 03:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743045872;
	bh=LFo4fJhj7LYS+DWRELXN3oisPqu60X2eAPFXsH5rLOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IhbjfZ8IjHrBmvECLpZ6xHk1Y+clh+HewujQXnFfg33WXNez44RzBRsy3/z7rDxuG
	 mjxjGHunV5mMb9j7jM5+TTVP902Ku/PJkxo0Vn3Lf2dQrwp+i3hILt6G4ljjOiasWk
	 Syfl67rnti1D1EFbztKIKTr4SoQ0gqICAtGV7/bBEhi4sfEiv3jz/sWTzs5WPy5CAN
	 CqEEstmAVlM8YJXR/aeqAUfOT1pMYBhpYyh5wCw0Lo9McXRoBJpZ1wj/4stZs4mUEE
	 Zl4XHY7PCKPC6tdLSZDzBaEDtJpjjq2pVBsiheyTsDFrlWpOjuCF6TfRwN/OiJdKEG
	 wFU96omzU/i6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC08380AAFD;
	Thu, 27 Mar 2025 03:25:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] Support SSTC while PM operations
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <174304590824.1549280.16399053930975160017.git-patchwork-notify@kernel.org>
Date: Thu, 27 Mar 2025 03:25:08 +0000
References: <20241028033928.223218-1-nick.hu@sifive.com>
In-Reply-To: <20241028033928.223218-1-nick.hu@sifive.com>
To: Nick Hu <nick.hu@sifive.com>
Cc: linux-riscv@lists.infradead.org, greentime.hu@sifive.com,
 zong.li@sifive.com, rafael@kernel.org, pavel@ucw.cz,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 daniel.lezcano@linaro.org, tglx@linutronix.de, ajones@ventanamicro.com,
 conor.dooley@microchip.com, samuel.holland@sifive.com,
 sunilvl@ventanamicro.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Mon, 28 Oct 2024 11:39:24 +0800 you wrote:
> When the cpu is going to be hotplug, stop the stimecmp to prevent pending
> interrupt.
> When the cpu is going to be suspended, save the stimecmp before entering
> the suspend state and restore it in the resume path.
> 
> changes in v3:
> 1. Update the commit description
> 2. Remove csr_read/write_hi_lo from the previous patch
> Link: https://lore.kernel.org/lkml/20240926065422.226518-1-nick.hu@sifive.com/T/
> 
> [...]

Here is the summary with links:
  - [v3,1/2] riscv: Add stimecmp save and restore
    https://git.kernel.org/riscv/c/ffef54ad4110
  - [v3,2/2] clocksource/drivers/timer-riscv: Stop stimecmp when cpu hotplug
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



