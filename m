Return-Path: <linux-pm+bounces-17239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F35FC9C2811
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 00:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DB91F216C7
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 23:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E274420B807;
	Fri,  8 Nov 2024 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5j+BxX+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB51E22F5;
	Fri,  8 Nov 2024 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731108294; cv=none; b=mBo8tzktGsyysLZwS9tIykkS8XOFWRVc8LokQzjFwFa4bD+1G1frDc2ZMbOoZq27cO2une3AtSaew0zSt/qLP+k8Rnzlp/9qDfJY/Q2hJAGHlmishBeVIoApHU6bbJNZxaqcmqEOPSjYPrwKZ5XfBSiAY+lGNE6BBpGft7nGjGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731108294; c=relaxed/simple;
	bh=T/gDRMcPtOxDWxU33Ni7GdQdPV6TdZUgv+2eiOA6iRM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Dc0i/vOO76iAAlSLxON1MozGEJDBU5H5Ifg+0FptMJ92sM7p+7ecbNv2S+Gzp9pdgyo4IDfJyOidkVnlywkjvWIyMyq0N3m1VWOLSFMt6ntQcsPMgjdUhw8l7UAa5Rg+ECYhCNVuyQasLCeytLNhMBE75pVfCnc7seuR5NmZFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5j+BxX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCF4C4CECE;
	Fri,  8 Nov 2024 23:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731108294;
	bh=T/gDRMcPtOxDWxU33Ni7GdQdPV6TdZUgv+2eiOA6iRM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h5j+BxX+XtQBAA7gKP03LXCTpyRhS4NV3oAM11D9JVuqfp5z+NWYcEqZfOHUKymzF
	 9P+La6fq/Xs7j46XPYCXoPf3O+hKTEqA+nke1DOzz+z986sjzRF2XxgHGENc1Tblk/
	 aWtbKG4/AjFREdGjpoiQ1jHGKvu2D/CL2+xqBW2KmrirFKCuVkzT5sw+6vZiCnMQeF
	 HnF9ceLml5gWsnFfZX4nhQC/opGQH+0+mkG+xxVxRblaZQqZJcWRr4BUfneLVvSKeM
	 aTMceXBe9jwecchL2tO63oGzjIxWVnLRvwr8f5wK3cEuxvxq4hhLWPwKcw/QHIKSn5
	 uxPjrH4iETOZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACC73809A80;
	Fri,  8 Nov 2024 23:25:04 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h1JmxJSeR6sOAfMhmdPLVzHx+wV4dE_HyhoqfLs9Zmvw@mail.gmail.com>
References: <CAJZ5v0h1JmxJSeR6sOAfMhmdPLVzHx+wV4dE_HyhoqfLs9Zmvw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h1JmxJSeR6sOAfMhmdPLVzHx+wV4dE_HyhoqfLs9Zmvw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.12-rc7
X-PR-Tracked-Commit-Id: 5469a8deac05391781bcd27e7c40f2c35121ca09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da4373fbcf006deda90e5e6a87c499e0ff747572
Message-Id: <173110830348.2790059.1596049969709134987.pr-tracker-bot@kernel.org>
Date: Fri, 08 Nov 2024 23:25:03 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Nov 2024 21:03:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da4373fbcf006deda90e5e6a87c499e0ff747572

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

