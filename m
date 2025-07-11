Return-Path: <linux-pm+bounces-30708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E375B022F8
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 19:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E1EA80841
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 17:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391232F2711;
	Fri, 11 Jul 2025 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf+23qQU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112262F2376;
	Fri, 11 Jul 2025 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255841; cv=none; b=oNAjwYkDhoaSeGemPBng87UDdpV8/3o94fuOUmbQeDk5/1fK0SpLjSLAaVIBs+36bcv7HMQFZNTfONsNnTw3M8QS4IHNVJGpbPbJcY6ORfqe71NuwD5FlGgX8yipPvoUn0vopbS34dTS/Ue8dDALnVN8NDOaoT6wp5U3/L+KrWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255841; c=relaxed/simple;
	bh=vtN+5QUZRl16guHSdFUz7Z/c4uaI9X7xGBS88JqdMKo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lxcvIjOJQqO2w7ab0mJIbrc2DzTt9KvYc4VbECSakBXWfGkGUZ+DhjmCP4jcd3Y4AQTI+tfInMZD5NCKamyWNsmc/MXISSUP983IQPzOHsVZK6qXYeWkjz4HT9TA+6oZCQAPiEFbIdAQJhEt3q0KNSlTxzhuRwGwQOmAaYdhlKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf+23qQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83211C4CEEF;
	Fri, 11 Jul 2025 17:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752255840;
	bh=vtN+5QUZRl16guHSdFUz7Z/c4uaI9X7xGBS88JqdMKo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gf+23qQUVjHO7q5AMcziQYFGCrTApbW7xQQ/Ni/n9rzO2/me/+Y9mHvCLQTrlGHX/
	 rYdBuB51IYc19S8vBhrROtWXjulWaRLSE5Qs3efCfI8EWEPiGf4esFz8fltBmegxzX
	 3yi1DZvUi3ISJGoGsnT8hZurCogpP6M2LDDPWm2uQgTtRZeQwMxLITAU5DP/U2ifyz
	 yYRqjAO1G/TdQKmFu60q0uF3TQxz4by87IQi77C2O7JF/laRc4MDQz7w1zPg2eGL7R
	 Voie3pZnHFP3v1f/DU6gLUj7dLM6s1WW5lZkQxVp+zw7/5LvS3D8irnRHXIDiaAigN
	 t2J/CfEe+lVLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE28B383B275;
	Fri, 11 Jul 2025 17:44:23 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iCR5vqDgzibNa99oi3SvTt8qx50EEUJMoyfzMH5zaJtQ@mail.gmail.com>
References: <CAJZ5v0iCR5vqDgzibNa99oi3SvTt8qx50EEUJMoyfzMH5zaJtQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iCR5vqDgzibNa99oi3SvTt8qx50EEUJMoyfzMH5zaJtQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.16-rc6
X-PR-Tracked-Commit-Id: ec3cae639482a8da11a3ae30d28ceceb9d6a3f56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87cf461cd30bc3e0ae48936a96590de8db747f54
Message-Id: <175225586216.2350666.10492758815896381217.pr-tracker-bot@kernel.org>
Date: Fri, 11 Jul 2025 17:44:22 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Jul 2025 11:38:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87cf461cd30bc3e0ae48936a96590de8db747f54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

