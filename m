Return-Path: <linux-pm+bounces-630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA0B8018A8
	for <lists+linux-pm@lfdr.de>; Sat,  2 Dec 2023 01:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A52A1C210B7
	for <lists+linux-pm@lfdr.de>; Sat,  2 Dec 2023 00:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C31963B;
	Sat,  2 Dec 2023 00:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9+YSRmC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F33E7E3
	for <linux-pm@vger.kernel.org>; Sat,  2 Dec 2023 00:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 168ACC116D7;
	Sat,  2 Dec 2023 00:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701475551;
	bh=Ae3UnqSajkyHxQqQ8zvp2J+FXGjBn8TlpNsrYJvgN1s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=u9+YSRmC5MpQN8rji1yR+EJHtQx8lZBXHxDzz8JxB34chSMHnOQfvcQy4XLsdKVdF
	 ASMedvDXulxlR7HlLnw/o/eo12y2lQ6ZAzQuA0vSbPK38bgeGk1xPW1HLCxX2J3yf/
	 1+DxETC9xM4CGFY2yl7jdrjLUjZPXDxZioDI+QDwIGIPDPy+QpR7zCOG6d4aQwhr0J
	 AbWgfAhnhI0QJgri64qcBdJmSJ4RAv7iG0vxNnnaZKruvjMKt+EFlcr/QYYI6YFtrl
	 CspqwMMmdMDN6Px2MpwZfH5tUMvdgBucXq3KKmkNXCtNlh6t1KLtioEPUEiHQhMjEQ
	 7zq/PaR74vC8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE166C73FEA;
	Sat,  2 Dec 2023 00:05:50 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.7-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iHKMcpK+B9dzCbDJxqZK79PoGdbLUD5hRH6sueAMgKGw@mail.gmail.com>
References: <CAJZ5v0iHKMcpK+B9dzCbDJxqZK79PoGdbLUD5hRH6sueAMgKGw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iHKMcpK+B9dzCbDJxqZK79PoGdbLUD5hRH6sueAMgKGw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.7-rc4
X-PR-Tracked-Commit-Id: a6b31256928d78204f8f282220d3b0d64387f79d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 815fb87b753055df2d9e50f6cd80eb10235fe3e9
Message-Id: <170147555097.9445.4196790284612702987.pr-tracker-bot@kernel.org>
Date: Sat, 02 Dec 2023 00:05:50 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Dec 2023 22:21:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/815fb87b753055df2d9e50f6cd80eb10235fe3e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

