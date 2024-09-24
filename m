Return-Path: <linux-pm+bounces-14633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A13984C20
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 22:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6ED61C20952
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 20:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D667F13D8B4;
	Tue, 24 Sep 2024 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vv93CvMH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07E112EBE1;
	Tue, 24 Sep 2024 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209292; cv=none; b=qW6lplRxQX46950gTO1AAwj/dVqMNcDIcCDY2Lz3zZlO3rRrZndWfd4Q6cBTfdRb/6v5xudi+ZgwmT+71a2bdVtBcXe+trQ/+/u2H8jM8SxqKZe6hqUv4BCm/pNuvysP5/wqW8s2oAoISVCVhWiB7TbRX95F+g2a5SYod+VM7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209292; c=relaxed/simple;
	bh=DuKVFPupGPbbk8/6FUFTSTfkCApwtc8zA8hYKrq0Z+0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UfKj37REKYESXUtsKbJ/mwTkFa7Z86aw9ur7knamXDU2SFSPXSZpD3suYXLgq591GMTfuvw1mvaAa7ZotZwqOcHTGTTc26FZHSPHCjG1ExHr/k3CMWkN60UFn+xNpedJA16oidQ2jyHLed1rCLIFQRPbMyaBgYNCU67L7HI3ZBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vv93CvMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94730C4CEC4;
	Tue, 24 Sep 2024 20:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727209292;
	bh=DuKVFPupGPbbk8/6FUFTSTfkCApwtc8zA8hYKrq0Z+0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Vv93CvMHjFRhfdC2JJzFjFGvxrDEqbUZ8osEkCYIv2GCfFRzguzPLidpGNeQxAFc8
	 S2BeeSfS5LVh/4moLm9BmvbMhhEJs7YHwGiginWWjTVeIU2KzL2N54u/0MqV66JW59
	 DIUPcsF1NWUDiibKLwxJnrouc853YbzQvj+dCiLeM0mj6KJUkPwFZZ1Dhep4/1Wwuc
	 uxI1sCKwM2ML0q8tCnqB2yqNmjuicYUS6V6kNq20kyiag00AVgNjvPB7SxiYytRfEs
	 d/oeGZFlMGlgrFpNoZQaQ0tmDsKfnE3z/nk9ufZLiD1gdTe4zvFW2VCI7D30GyVZM1
	 AZt3WRiiEox7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340593806656;
	Tue, 24 Sep 2024 20:21:36 +0000 (UTC)
Subject: Re: [GIT PULL] [GIT PULL] cpupower fixes for Linux 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <cf329845-48ee-4b25-9b5a-02a6e2b55e5a@linuxfoundation.org>
References: <cf329845-48ee-4b25-9b5a-02a6e2b55e5a@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <cf329845-48ee-4b25-9b5a-02a6e2b55e5a@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.12-rc1-fixes
X-PR-Tracked-Commit-Id: 6c56fb4434f59df9c777eded5f77cc812882cef3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f8de2bf072530a48f53a5658db8528af598b75f
Message-Id: <172720929487.4186044.6964190812073925273.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 20:21:34 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, "John B. Wyatt IV" <jwyatt@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Sep 2024 14:19:01 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.12-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f8de2bf072530a48f53a5658db8528af598b75f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

