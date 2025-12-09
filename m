Return-Path: <linux-pm+bounces-39344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEE0CAFD5F
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 12:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A249E30DE06B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 11:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255BE3203BE;
	Tue,  9 Dec 2025 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwuvgEtb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF337314D32;
	Tue,  9 Dec 2025 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765281202; cv=none; b=ej+C465V9qtzkftY3SQPS/CERNTuFf8zjmwosNp4ysLSQIEMrwRsPPWFCQaQzbMCz0Py7mWChnarmLOdMD+Eoi9Ad1na6hsJ5nVll7oaNYgKHX2X3deSuzJ+sYvZ6mfwxqJlVxmK3h9pIkM18z+I+Iq/kq7SJyDxALtL8uTovRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765281202; c=relaxed/simple;
	bh=4XmPTj4eIU127BY9tbYi/o+/cOe8ZrjE0gxW3z0HsMA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S4CT/HpZK8OkbNDZ9jMJYYVbT1v5GYJ2hEfPNqC3sCLxtQgyCAL9WUGcg+ycJcwWJETkpBX91CpWaB5UHpWITRc3S9qQPzZk/7p+EIMEUwP4BZRhXg/zDQnx1hE4uw25iVwCEYDwA322PrHJ19BGoprdaaGzyEtbEyodj3hB0c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwuvgEtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCB0C4CEF5;
	Tue,  9 Dec 2025 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765281201;
	bh=4XmPTj4eIU127BY9tbYi/o+/cOe8ZrjE0gxW3z0HsMA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JwuvgEtbDnVRRlx3llLr/hoUVXVSJG6CDMy27o3326mKYrn7a05Ro4F90BkOvgMlH
	 gzuwDQFZNuQcRd3hWUDq5EGeV81Vuso1DQCN/JI0blK/mfeO+4TAC/R+WqoACk12DO
	 ao8UxucgIUWL6rSyNrqw7HJiBGkfzNGwE50fQ3xTa8fqrfofNK9SLl5vJ9L733uH7B
	 gg6F/QGCriheKdf0jk8PkUbQRAWfPZPnTwvMHcNd2eIw4QLZgWsFrfZWIovZayzNyH
	 0C4B6Kk/CnEABoX0wmwZ6uUWPQ5f5NCxmH2Sz57cs37mvRitVkBh8vBJLLr4LMOhID
	 CJcNLk+5DYkYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B5EC3808200;
	Tue,  9 Dec 2025 11:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ynl: add regen hint to new headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176528101677.3919807.17328654587091373825.git-patchwork-notify@kernel.org>
Date: Tue, 09 Dec 2025 11:50:16 +0000
References: <20251207004740.1657799-1-kuba@kernel.org>
In-Reply-To: <20251207004740.1657799-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 lukasz.luba@arm.com, rafael@kernel.org, pavel@kernel.org, lenb@kernel.org,
 linux-pm@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  6 Dec 2025 16:47:40 -0800 you wrote:
> Recent commit 68e83f347266 ("tools: ynl-gen: add regeneration comment")
> added a hint how to regenerate the code to the headers. Update
> the new headers from this release cycle to also include it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: lukasz.luba@arm.com
> CC: rafael@kernel.org
> CC: pavel@kernel.org
> CC: lenb@kernel.org
> CC: linux-pm@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net] ynl: add regen hint to new headers
    https://git.kernel.org/netdev/net/c/e56cadaa27fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



