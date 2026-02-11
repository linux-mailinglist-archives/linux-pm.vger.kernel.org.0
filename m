Return-Path: <linux-pm+bounces-42525-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFHoKa/mjGnquwAAu9opvQ
	(envelope-from <linux-pm+bounces-42525-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 21:29:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEA1127647
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 21:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C5CD300D0AC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 20:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFDD3612D6;
	Wed, 11 Feb 2026 20:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mS6GUvsR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADE1357A3D;
	Wed, 11 Feb 2026 20:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770841693; cv=none; b=g1sWahJKfFCsaZES3vZkv0WqXAH8zf8WJ0Yz2iM3BsmTkgaWOBSzthDm+8R2dtzoytMyOMusAX7f+Ib8/8PhGLhpjBywo+1UfFa14OwEbRd3qM2ZepW0zhrXfg/4j8rJwLhsyDa1jlXfDzVk3nmve+9+i8nb7J+s3uPiQrUt20g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770841693; c=relaxed/simple;
	bh=1v4DtYhnoPl+/VwCc2RIwdNlWPlTGMEwqIZSdzM7uYM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NU5kj2MZAy7Y+bpH/Gd4JGOfh4AJ3yhFIvCv8bXJi2I17XI4LMOybvTYtkLjekVMFe1X10lSlbOpvcwnEUrugx9/iyY75nXXU2G26pxg9d4nnEWjUZlMcsBKH8UIaAVAfcb1g6UzBjaHoZL4EwvIE1u1y04+syv9PGSE69Jb93w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mS6GUvsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86276C4CEF7;
	Wed, 11 Feb 2026 20:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770841693;
	bh=1v4DtYhnoPl+/VwCc2RIwdNlWPlTGMEwqIZSdzM7uYM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mS6GUvsRHAfPoaq0F5c42pnu2MKAwCHdQnCp8v1lY8k3nHP6njOjmDQCurU5cm+qs
	 WtMNC5qjltE4evTmSQG510Klyl65bswvlDEJhsfqhmYh3tBUSwY6sevY1RFdMYZiw9
	 bXQuASC7BRMCvxumpNko2zDy9c9HkcJMlP562lNNEt1t+dNHR1jXRFS33V61JvDhV1
	 KJwVjo00zt14KKqi39mChdvyfqI+qX0N3E3GVS8CPPiH7MzG/XhvwE35UyYL50k/U2
	 u0TqiX/rxiCyO6Mare0oqg/c4+2GdrciCHC+2OTQWM5JX38XH3SU/IN+4+C7DXo/kk
	 rRnvF4Y4bNREg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8505C39EF964;
	Wed, 11 Feb 2026 20:28:09 +0000 (UTC)
Subject: Re: [GIT PULL] power sequencing updates for v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260210091401.24342-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260210091401.24342-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260210091401.24342-1-bartosz.golaszewski@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.0-rc1
X-PR-Tracked-Commit-Id: ecfcae7885f105b29898ff71d3cb70abd56ef96e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 893ace4df0f96b8ad066651453e0519d4ffe35ca
Message-Id: <177084168810.710910.16699830952437509180.pr-tracker-bot@kernel.org>
Date: Wed, 11 Feb 2026 20:28:08 +0000
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42525-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDEA1127647
X-Rspamd-Action: no action

The pull request you sent on Tue, 10 Feb 2026 10:14:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/893ace4df0f96b8ad066651453e0519d4ffe35ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

