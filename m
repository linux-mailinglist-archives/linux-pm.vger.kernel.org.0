Return-Path: <linux-pm+bounces-17790-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51389D2F2B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 20:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAE8281FEC
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 19:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6071D12FE;
	Tue, 19 Nov 2024 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+y2UM41"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7689126BFA;
	Tue, 19 Nov 2024 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045960; cv=none; b=ZQmTYe4XgPh2cUMKZLvJgiBsIYdpt0BCd8wXDjrtaUYHvhoObdLVWBq13Ljj0ZYgE6F/gsCjAKtS9YXxYwiWa//t7/gA+gpjUxufmVKy/EhknnE88+cZ4d8G/Z48t+pWt5GIAOHtOFnCnzWEEf6T3HP0sn2+nu+JUO9chB5nRnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045960; c=relaxed/simple;
	bh=Yeimh+3hGRIHI29GJAVpr27bkgbUtuFAjoUUbhbGzaA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DRknAXloioX600RrBQrpNdnDX0HeUPu8o5Q7XKA4xCDFDIHo1TzW1OHhhyacRd74+ujdu0R5FqYBR23wY1lUgLzx7E5b49G25qAH4gZO1PSx8g66C4XQurnfeEMyuHzAuCiAZLeM48xcR000MJtmzaoGcmLUlH0SQYH7zd7Wh/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+y2UM41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6F2C4CECF;
	Tue, 19 Nov 2024 19:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732045960;
	bh=Yeimh+3hGRIHI29GJAVpr27bkgbUtuFAjoUUbhbGzaA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g+y2UM41lzWN2z4vX0ZHG3YIy/LjlanS0qpzvxtxG/62s+t/LRdIajiDJGZLz2MZt
	 7n6AXn3Wvf22ItmCcancj4X0YpVXAvSOEQTcZiAFUQJKKTsgH876jOFSyE+Stpcy5X
	 obC+i1NZ/F+BqPx+yOAJkURrsC+wfA8/fjabnQ4o34xRUgWnNblJX77Z82eBovxsB+
	 qZS324lYfV58psIldsfvXboSrYHjGpCrJPbpHv3nJrFWsbijjXRsjQM60jza4Iheh8
	 56uLPevfZI4+TaIlRWqj9J8+yQ3HteBjkVbUKXQfI+/E/nOHEmJKoz3ekvgwS5wbgo
	 zXeIOrr6l5aFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AF83809A80;
	Tue, 19 Nov 2024 19:52:53 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0imu3DZbUb6P=UGP5G9ffxS6MbnRb-2zx7pXNTrxS1Z1A@mail.gmail.com>
References: <CAJZ5v0imu3DZbUb6P=UGP5G9ffxS6MbnRb-2zx7pXNTrxS1Z1A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0imu3DZbUb6P=UGP5G9ffxS6MbnRb-2zx7pXNTrxS1Z1A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.13-rc1
X-PR-Tracked-Commit-Id: 0104dcdaad3a7afd141e79a5fb817a92ada910ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd7fa3e1b0bc9c210eba23edbe8d6884f0368281
Message-Id: <173204597202.668199.17388622666384238911.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 19:52:52 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 11:23:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd7fa3e1b0bc9c210eba23edbe8d6884f0368281

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

