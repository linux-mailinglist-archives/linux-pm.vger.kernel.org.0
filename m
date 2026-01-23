Return-Path: <linux-pm+bounces-41389-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBOKACfnc2nhzQAAu9opvQ
	(envelope-from <linux-pm+bounces-41389-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 22:24:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF197AE03
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 22:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4AE453006D80
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 21:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9F5271464;
	Fri, 23 Jan 2026 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRU2es7K"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA63EBF28;
	Fri, 23 Jan 2026 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769203491; cv=none; b=FkogW1Vy5UZsMJpXaKe8/9i6I6MytUQ43Klr+EyoRtZW/p/KZTGHvvjHCB2TkswqjLyBEVkBAT9nJ9mN2CacUqjMGNdmuVXrvAqS0UqwOfFiV5wSmC3m1hktfrb6tcwM23KLiobUZGdeQYgiEqw17tkPpDYX+QvLLcliG+tSwU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769203491; c=relaxed/simple;
	bh=VNE+m3Pfw/5+DeSp+zS9BpD2eDtyYG3WMUZep7z42kk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RsTKMgFLZmbHkLgZMCeONjK/bl5SCb6OLHeXmwzilefenSrctFRPOXeeXgRDcYWUkyBk4SX9PLQO8jhSNDZ6I+dd98pdLJ3idtopEkPrDzYhvyp4xTUjxAfys0mccDckOHHPtUKR0SOyROokVDwEm7UMDcgZ/avHfa3P22DeopM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRU2es7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E540C4CEF1;
	Fri, 23 Jan 2026 21:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769203491;
	bh=VNE+m3Pfw/5+DeSp+zS9BpD2eDtyYG3WMUZep7z42kk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FRU2es7KDBQsIuGPn/Zwj/zskcTTWOFBo7wXszdenmmDoS82otCCJjnCgrE/qh0fH
	 katSaRxM3a6b2D5aO2mhWIMfYrNap8jxC6v63bsnL64JHxMAxFFF/tvn8l3nY7tVsn
	 DjZpZv58jbEdgUzg1AEj0Uljw6Io5dse6V3atpAkYpo/T5djglhmQPnfJYa3cmGe1d
	 OTE6NmcobUHSqOe7hIiq6xR91QJ8qOt9BqxRFR+QsTHL2osbkJx21aCrqSD4nksQMj
	 HqzXVaL7+P43LV9OyBbO0HofT5RNPXeyNlFmCCoEKrL5fi1nJB5TFU8j8GkDpDcqD1
	 k519Lg0mBvhzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BA0B3808200;
	Fri, 23 Jan 2026 21:24:48 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.19-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260123121435.245253-1-ulf.hansson@linaro.org>
References: <20260123121435.245253-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20260123121435.245253-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.19-rc3-2
X-PR-Tracked-Commit-Id: 861d21c43c98478eef70e68e31d4ff86400c6ef7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9731fa48beb346bb9804cb81e34b3260ce65e561
Message-Id: <176920348722.2720183.9624545632206323526.pr-tracker-bot@kernel.org>
Date: Fri, 23 Jan 2026 21:24:47 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41389-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-pm@vger.kernel.org]
X-Rspamd-Queue-Id: 9AF197AE03
X-Rspamd-Action: no action

The pull request you sent on Fri, 23 Jan 2026 13:14:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.19-rc3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9731fa48beb346bb9804cb81e34b3260ce65e561

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

