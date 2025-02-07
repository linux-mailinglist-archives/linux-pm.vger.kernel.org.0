Return-Path: <linux-pm+bounces-21568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4948A2D071
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 23:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6336616C5DF
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 22:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932671C1F08;
	Fri,  7 Feb 2025 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAr/I9FM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B71BCA0A;
	Fri,  7 Feb 2025 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738967144; cv=none; b=dbt2IQYte3+/M6gn5FSbid/5cRh1nO9IdnRqUI2TUzlldzGbF0bC9SCJu26ycOeiEMAgia47LHCTThJXIEIscn26F99OJ1hen1dKCegrpmW4ABJRIl8HSrvHs/RFGcwGsZy1u3f0chc6v7fno4yUWuDAQu5tj3h5W2GDbCkI990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738967144; c=relaxed/simple;
	bh=dWI1j4mObgqvwg4j8lh2VPVQthACPy2J29+l2hHuFQE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tI7dCWxeaU9rqU2mxIoyIBZvB7vCPk/88fid/YHQXTRntrRMV8kMIiSCEG+F/YkskBn6LzcH0bWfOcLdsTLtbFsiFPs2QVDiTUzUQ4RFnT4X3WXszYMY6rcRMsYiux0W681yqtIz3r31xcGvB+fmUbjTbsLZwmP1Ttbzs6/o8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAr/I9FM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F6EC4CED1;
	Fri,  7 Feb 2025 22:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738967144;
	bh=dWI1j4mObgqvwg4j8lh2VPVQthACPy2J29+l2hHuFQE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oAr/I9FMjbjE/aSf97n7F2RTQzQZ3fJCxsGbNdGQP7Om3RwmHP0f90A8qSiSgc+M5
	 GxmFOx8jkXaq6kJlWAGyJZEQMlZ2NPG0wlRCo4wD/l/uwb5aW7TVaQXsiAHe8gKx68
	 qQjqT7iU363ulf+u1vp1rLHHTIXytieQKI8n2BzcrqzHz8uHkKdtc0fpuLhi9GzJ/4
	 X8/Dozc/8YXDEQyz41RDA5hX4Bo8EwitlGuXYyc+1iVxlGSrGRHr5rWBfbHpJyST2U
	 ii/HpB/0DQxsRisehIY3/x0Ja3Ab73n5nEioF3QYgQzyc+QTf8iwOltSQF2xWsVEmI
	 qN2bFY3XpfWcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F87380AAEB;
	Fri,  7 Feb 2025 22:26:13 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.14-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iU1C-K9dP+8g1PMvuuWg2UT-ocgL055ruWEX23j-KuPg@mail.gmail.com>
References: <CAJZ5v0iU1C-K9dP+8g1PMvuuWg2UT-ocgL055ruWEX23j-KuPg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iU1C-K9dP+8g1PMvuuWg2UT-ocgL055ruWEX23j-KuPg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.14-rc2
X-PR-Tracked-Commit-Id: 73195bed7899150cd1005cf0a902b68793adad23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fa9970a4e61e9383a8ee738b44e2194d4ce7ff5
Message-Id: <173896717208.2405435.15139542520035665688.pr-tracker-bot@kernel.org>
Date: Fri, 07 Feb 2025 22:26:12 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mario Limonciello <mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Feb 2025 14:02:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fa9970a4e61e9383a8ee738b44e2194d4ce7ff5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

