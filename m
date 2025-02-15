Return-Path: <linux-pm+bounces-22139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A81A36A55
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221E116A462
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF2015B984;
	Sat, 15 Feb 2025 00:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyG6sgO0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D04154C0B;
	Sat, 15 Feb 2025 00:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580839; cv=none; b=mEGeDTalSlhHEVx+udTXkjzLtenBnsCUnqGstkPj47PJ0M8ek3XAKN/D5WYI3qeUQjz3P90Bscce300NHxT5aepCWvMMH8XY3uz3XqglSsdt3xyEHhgVPVKVyjHzPmQZzKrf5KyocNpEhaumsYgvWmkKIB9JPqIJB/1qd2BGlA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580839; c=relaxed/simple;
	bh=lBuK/bSbUTeN6/buU76cBjlajqTaZ8mhrN+dn8TsGwE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TPMc/iP+y8R1pU6nFJsYZnx1CtvtMBOWMne1a86pIbYD9H8XL7nAye8G5Y/mIXHx2rR/BWEsPqlM39ynhebvdUe3LCm8Tlz5jZvUGtZG2u+5sNLSBiVn3r7ndU/MpDVbvgfM8Cxzm+LmRdHtEEdTWTzSKPns6KJfHW+btYKbZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyG6sgO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD87C4CED1;
	Sat, 15 Feb 2025 00:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580839;
	bh=lBuK/bSbUTeN6/buU76cBjlajqTaZ8mhrN+dn8TsGwE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FyG6sgO0VcBr2Cw0gjpLeN3qgR9DFcwvspmaQdN+BdJEF/1p7gqfwTAfdz267Jpux
	 kziLavEyeinjbkmIiKFfsmBgYctYQJqwYPCxgB5bS0D2XIzQ+12hADTOhZigI5vRYQ
	 i8VVjJSULf2cg2WGIYbdDpAbCfnlagySeKo+VzwB1ZMZLok208VCIRZ2nvv+zZ77ZX
	 RfUNqnV1Kf/s7XczDdlY2sczeWzxz7xpsfxEcqI9xAXPzrjpGK6dCPDxnHtc5mLDKy
	 MMBGprkTL6iXSX6P3d3OXppmRvJVJYntxPz9ql4debPJKyV0kI99P+SNp5jvi34xcu
	 Z3EAnsnnPfncg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB01D380CEE8;
	Sat, 15 Feb 2025 00:54:29 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hZnJHLmwh9K7_auS+JeinAx0DWd1vi-bWr_qDp5ZnyGw@mail.gmail.com>
References: <CAJZ5v0hZnJHLmwh9K7_auS+JeinAx0DWd1vi-bWr_qDp5ZnyGw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hZnJHLmwh9K7_auS+JeinAx0DWd1vi-bWr_qDp5ZnyGw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.14-rc3
X-PR-Tracked-Commit-Id: a6768c4f92e152265590371975d44c071a5279c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f2ca7b8b33db7d094ef729e6b0707b5534159b0
Message-Id: <173958086859.2153475.12582084633117526210.pr-tracker-bot@kernel.org>
Date: Sat, 15 Feb 2025 00:54:28 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Feb 2025 21:51:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f2ca7b8b33db7d094ef729e6b0707b5534159b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

