Return-Path: <linux-pm+bounces-20579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BBEA1406E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 18:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E453A327D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6207F22CBD8;
	Thu, 16 Jan 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfYLybKD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3B415442C;
	Thu, 16 Jan 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047619; cv=none; b=Q0+voZ4S6GByrC4w2UuZnexo66jJCTkMPM2P4IN3Q5Xtn9mZwqFAwNpdSDt2LF+F4ptWg2c7/pORabxmcrV3fO6AA7vzKxYhQv7llZ3o/VOvbzKrLovWvAbzMrGWMiIcLbHzhBG2Wyo4x9T4ibYw9j2A66xRZ2+p5r/uiaJ+UF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047619; c=relaxed/simple;
	bh=ZsWa/OyvYmlGLLWq4dD4WPcy/AZDxqRGyZcdqJhZ2ko=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M3ScsERP1TA6rkPJYssALfSPUSQ8tOzg6JUZnygt8TPpoKwpxourXqYRKTS2m+2DRmL5w/TcrtIbizJvO/m+tuB1zI4Z1Qz4FXNQBBUMfU8zO4pDZKCZjM4xOEByHeIhs8RpeN/dM6RXtpJFLk6lbHBgpYskZ54ZJOuX8/J7KAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfYLybKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB80C4CED6;
	Thu, 16 Jan 2025 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737047619;
	bh=ZsWa/OyvYmlGLLWq4dD4WPcy/AZDxqRGyZcdqJhZ2ko=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JfYLybKDZUyappzSmx7c+8JPjeIwXjnf9P/5fWk5INs6qugisa4neuB17l6Nf2dPV
	 75UFQOj1b0fmHXXGrYYb4M8XmORnma6LIUQRIm/zOjsjFEOd3NmsZILxkOyqJaC2Ck
	 MY0UU9kJWTDCBTsBRcY9KRlIbbT2QWKgiA94oZrY63J6/3F4nBZpnxYcL/1lFGICcm
	 6ljLXcJr1b+Q7VjD+ughDY2mRWd9EiTXcuIHbsTrz/Mur/GHhMBoXR0NxOe+mFLFUZ
	 6RTKWMAKjhT9oXIfRLMTCtYxIzghYBS3KcB/EeQzcOnB9NWxAAkgVISAn/P8wNSs0B
	 fSBmSlnw9gw/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C3D380AA63;
	Thu, 16 Jan 2025 17:14:03 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for final v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hdgZ3KpZhtdF5hDn4KwUcT4=nfjtG=mythTyzrNJLpCw@mail.gmail.com>
References: <CAJZ5v0hdgZ3KpZhtdF5hDn4KwUcT4=nfjtG=mythTyzrNJLpCw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hdgZ3KpZhtdF5hDn4KwUcT4=nfjtG=mythTyzrNJLpCw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.13-rc8
X-PR-Tracked-Commit-Id: 3744b08449c27bfa085aa218c4830f3996a51626
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b4ccf11fa5dae17ac815c5a07ce56655d60a815
Message-Id: <173704764208.1527932.9560029296846677292.pr-tracker-bot@kernel.org>
Date: Thu, 16 Jan 2025 17:14:02 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 Jan 2025 15:46:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.13-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b4ccf11fa5dae17ac815c5a07ce56655d60a815

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

