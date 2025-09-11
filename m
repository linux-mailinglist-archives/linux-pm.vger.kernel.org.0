Return-Path: <linux-pm+bounces-34493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D320B5385B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 17:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202081C2420E
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 15:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934B03570A8;
	Thu, 11 Sep 2025 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLjM1yaQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7143570A1;
	Thu, 11 Sep 2025 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606028; cv=none; b=CS4JisOuVoFQEP7RiEu3MZBuiX80g5O4QETEvkQEgmEQpkwHPRTbAcvIPkAi0LnKv4/r80uJEXg4Xgg/zfhF9LW0PJnYU/T+8uQ1YRjkJZXzJbfYSddUHsKInYTxTtNqITyIkowr2f6gqtfLrOgfDKLEzUgutVtiL78uMb6XiNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606028; c=relaxed/simple;
	bh=bytY0CyvfxCV3Ea2rCA5rI2rWAOMQeuj+FvthNFwSD8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c1IArTdMfeoPswnrfYanhvnrl9jx7sNnDjIrHUNzJlmfwGLaTHL38HOwrsXs6ZIiZKTx9COmSfiJxHwXIxhHQ1kzLg4/Fncs4h4uf+k5IlGFL2B48u1jUadIVQo4mBDP2dTnbih4p2ypDzpkSw/fkF6hkJSWW+ZzH7ByyzFd5lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLjM1yaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461FFC4CEF0;
	Thu, 11 Sep 2025 15:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757606028;
	bh=bytY0CyvfxCV3Ea2rCA5rI2rWAOMQeuj+FvthNFwSD8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mLjM1yaQDHBwQATmP6lW6WHFHU9/eKxXXBiJgQNWMWwtFg7Dcielp55AU814Ik+xL
	 LEvSOgUawT1MztbJBjwCYDai+FhsNbTm4GtAuGxXgQ8p/vP1aCZOC98R+XZrkI9A/2
	 tVc8iWhgKKohAyyNfHXee/V87sD3amqNmmjVWyRS7LXCQyHkXhPeYosx5gzeiV/qIa
	 pd7Y3qtPwAvVVfTFAn/Cx/vpbg476AcInKzeW1hDtEg72Mee8J7WfT0lUcxAdmqqUq
	 NshgwC1v7clLID+TOHVXBipw9toCry4PdlXsyEwkxjPWfp0TuFYblDrI3ymxPhu5L3
	 TS+eKkKNqnCRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F94383BF69;
	Thu, 11 Sep 2025 15:53:52 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.17-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j-OGp-djCo7m8Y92v1FOPTYbPp4tw_d1N4jyS_4gfgFA@mail.gmail.com>
References: <CAJZ5v0j-OGp-djCo7m8Y92v1FOPTYbPp4tw_d1N4jyS_4gfgFA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j-OGp-djCo7m8Y92v1FOPTYbPp4tw_d1N4jyS_4gfgFA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.17-rc6
X-PR-Tracked-Commit-Id: bddce1c7a5ab3ec2dd0fc404f4155c0c17e847b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1228f048a314b9280784a2cbd757cac74705589
Message-Id: <175760603090.2231751.15229977954314649541.pr-tracker-bot@kernel.org>
Date: Thu, 11 Sep 2025 15:53:50 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Sep 2025 14:54:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1228f048a314b9280784a2cbd757cac74705589

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

