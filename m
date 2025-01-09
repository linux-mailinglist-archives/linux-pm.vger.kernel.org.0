Return-Path: <linux-pm+bounces-20154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A103A07D3A
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 17:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9501653D9
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 16:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5066422370D;
	Thu,  9 Jan 2025 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMn/oGh/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35F223707;
	Thu,  9 Jan 2025 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439393; cv=none; b=g/yMaiSSgIX0o5CjM3oMa4aB/vO0ypHQzET5UnbhRmNwshdk+n0iUK1DhojorZ0R5Stis8DxXD+TJdm1NvHQ3At6Foi3HT12jpg0R+QcLV1HzVzdI7wlNHm0aN5lgw0ev5uM9aRjA/opEq31CfysaufbglEj1SOrOdCgrdfW7vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439393; c=relaxed/simple;
	bh=U+PB9W4+UsPTNIAE1vKQ2VkLWmxg7Jaqkcu31Y/OYQs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BnVXH6KTjbzuN+70j7wA6eKTv7mNhwBya7nGZ573BfgAztqWA1Ch+UPJbUkXxudEDh3jTEWfAi5fITogxZxJ/BQi8Z1KfjssJhazQrE1+K7lEWFPQd4TedMG9Fas8wIoTAWqJTRD08IVsuRy1VZ2ExT4iAz8lTWoHOhdiZJXkm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMn/oGh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79001C4CED2;
	Thu,  9 Jan 2025 16:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439391;
	bh=U+PB9W4+UsPTNIAE1vKQ2VkLWmxg7Jaqkcu31Y/OYQs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PMn/oGh/BZTZB0N3NeOgBNoh6XWqhb1R/NYyrRRz2Lpy+tH1UYFhvW89iOwuTIMkh
	 UIWWcI0ywZ6mHe8vS1hhWimLDciphU8pREeV2jFFBYoN7m/XaIyay3afI0Ex8saJQw
	 YFEzWN9cnydAHl7CK129MrJ2ECXodFGaIJUHTJ2oaStDcA3bBnvyX8XyXmL2C3O4jr
	 HTYswL5rDQBVjTUB5yP/fKnFrjMVgvnMPwUIjHZaP2cOTa+lqhw+cVLLzn8rGuR22N
	 lA2t9q1mpP0CiBP/aQp/ExKnWQIdbcCjBHKrVt/unAaHfg/meyjoQE0lbBQYR7+8DL
	 BFFFX6bsq6X0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB8380A97D;
	Thu,  9 Jan 2025 16:16:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] cpuidle: riscv-sbi: fix device node release in early
 exit of for_each_possible_cpu
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173643941299.1375203.12210975797046480950.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 16:16:52 +0000
References: <20241116-cpuidle-riscv-sbi-cleanup-v3-1-a3a46372ce08@gmail.com>
In-Reply-To: <20241116-cpuidle-riscv-sbi-cleanup-v3-1-a3a46372ce08@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-riscv@lists.infradead.org, anup@brainfault.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, atishp@rivosinc.com, palmer@rivosinc.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 ajones@ventanamicro.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 16 Nov 2024 00:32:39 +0100 you wrote:
> The 'np' device_node is initialized via of_cpu_device_node_get(), which
> requires explicit calls to of_node_put() when it is no longer required
> to avoid leaking the resource.
> 
> Instead of adding the missing calls to of_node_put() in all execution
> paths, use the cleanup attribute for 'np' by means of the __free()
> macro, which automatically calls of_node_put() when the variable goes
> out of scope. Given that 'np' is only used within the
> for_each_possible_cpu(), reduce its scope to release the nood after
> every iteration of the loop.
> 
> [...]

Here is the summary with links:
  - [v3] cpuidle: riscv-sbi: fix device node release in early exit of for_each_possible_cpu
    https://git.kernel.org/riscv/c/7e25044b8045

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



