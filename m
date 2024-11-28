Return-Path: <linux-pm+bounces-18213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1160A9DBC6E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 20:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 663FBB220BC
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 19:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAD71C1F1C;
	Thu, 28 Nov 2024 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rylO2s/j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F50142E9F;
	Thu, 28 Nov 2024 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732821579; cv=none; b=ANrpR4Egy5CGKSEbpiAxqlqmWFc0Gq3UPyznjOqOxKdZ0ph08Sa8OIrMXNcrqe4n3YeXueKnxf23kHE5tR4Jt19aco53bu4Bffn/e/d0cBSj545Vz/5N2rklhV5xzTd/XNU0ESO2bwOQ5oiD3nj0gg/MM3E3MQ3gJ4EWywjh8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732821579; c=relaxed/simple;
	bh=QOLi7nm3hrTWKr8+MCs6wPe6Peg2QaFLYz5OGw4L7Nk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nXtlv5I2mJPx5tdn0ql1W546v2BdlHdmwATMnPUGSGp1lLxx56y+h0MSfeKBXEpNPRWzLJ714CIgyCcxjivJc4oxZiyYcyPytUD1+3Q7kka9jyWTtzVLRnvmQyXdkdBHYfjJOo1xBEPebbWxYGgh03kapQiMeA/0AOXSfupQl0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rylO2s/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B68C4CECE;
	Thu, 28 Nov 2024 19:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732821578;
	bh=QOLi7nm3hrTWKr8+MCs6wPe6Peg2QaFLYz5OGw4L7Nk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rylO2s/jiySAdGg9Q4eplpkNSOMez9QPZanROSrgZpKcK6o1gM4pvGkZ+f1GRezyt
	 tvaHbwihMJkl6Yq3S5D0mxrtUjuXA4sm6cgw24n9EQm5AcKAUteYXXLbF0bchobyXp
	 r2OEFqttByl5X+gzZS+me/tgBxQ4DId7MA7WnR+8fGGKCk7z6xhgWQhcqa+Q7hnAFY
	 T+pexFDAeFKcypVzIyf4JzGL0bfsWruUGntRgbBOGPJud6nO6X/4Vy0kZmWRXDaC3a
	 tVOvX/Gx3MgjQiykW6Euk9EQRLMTLl3E0DtwZLFxDNOZK9VqixYg/S+MsPP5C/NKKO
	 ThiHR5/2nDSEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE2380A944;
	Thu, 28 Nov 2024 19:19:53 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <rxg72umwpo3ltl4inbidhmgqpzxmqluk4wr6irmhwuo7ukpmnc@liqfo2svz3in>
References: <rxg72umwpo3ltl4inbidhmgqpzxmqluk4wr6irmhwuo7ukpmnc@liqfo2svz3in>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <rxg72umwpo3ltl4inbidhmgqpzxmqluk4wr6irmhwuo7ukpmnc@liqfo2svz3in>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.13
X-PR-Tracked-Commit-Id: b6d445f6724deda3fd87fa33358009d947a64c5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 448ecd5771e255629bef0fb16c9b78c4bbd7bd56
Message-Id: <173282159206.1826869.16816433115140337802.pr-tracker-bot@kernel.org>
Date: Thu, 28 Nov 2024 19:19:52 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Nov 2024 00:05:37 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/448ecd5771e255629bef0fb16c9b78c4bbd7bd56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

