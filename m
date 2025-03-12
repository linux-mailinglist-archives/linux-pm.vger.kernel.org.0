Return-Path: <linux-pm+bounces-23931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2EDA5E46B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 20:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65173AC915
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 19:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9371D7E37;
	Wed, 12 Mar 2025 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZgNhcCF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F7B1CF96
	for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807862; cv=none; b=ZbDPJEX1tlQljwnfqDFnoNJsT8HfLPGCwMu5iqpQ/YtVu586JqxHAYzgWshskywUXn5GwO+Cx2hjRnADSy0hxzeuBF0HtRI8JAoxU6YwJ+axkXRg/Vk7ShF8847k16lc16aqLtmk2fsVAn4KQI8TV5QBdUiDWFEBYO8BJFE7KHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807862; c=relaxed/simple;
	bh=GFT6bA2Q+nnjPaA6pTXUZbhECYu8A26Wtli9ggm9j+c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BZIIc1mjb8brMuAOilu7xqets7UK27TEXGR8vKdwsylfiGpdHJYZGi+d1wNNdhfXNDeD2Pb3vU55392r1FOGeJPzoWXtlBxr2+rbVXMHjGvlAiU5XJ2ZZD49nMvplkjSYCxt15mkiyVT758+CoowEJ5boIhhtxc71gKIK8Vdk5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZgNhcCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B72C7C4CEDD
	for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 19:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741807861;
	bh=GFT6bA2Q+nnjPaA6pTXUZbhECYu8A26Wtli9ggm9j+c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GZgNhcCFsXzZvTi72EBk78umy2Bh42cP+PGpiiA/76YtSRxi7l9hempznDCR6cwBT
	 /0bkqHlv/ZMYCebY15lVMLQyG7yoack/OIIdbTgZfKxqnyO3Z1n83HCV/rdVySLMqc
	 fvrG654lidGb8WfFNFnHo9hM/Y3aSAV51gCCtY+vO9VvGVT4ZM/L2QIcOJBCItc5+G
	 lBGXWx2m07yRlamivFtz7NYlfnV6I3CFbD81kIT8SLYpDw4dL/+ZUB+Q5A+T88pRM8
	 mLDxlnYO1IOXRcjMp1Pc6ozmMZNi3x8jRxgVENoYqxFcdVu/j7DRlnunHCFw7qyg46
	 mOgbjBI+xMUTw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AD5BFC3279F; Wed, 12 Mar 2025 19:31:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219858] AMD Zen 2 broken power management after sleep
Date: Wed, 12 Mar 2025 19:31:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: diogotavc@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219858-137361-a7auqAtucq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219858-137361@https.bugzilla.kernel.org/>
References: <bug-219858-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219858

--- Comment #2 from Diogo Carvalho (diogotavc@protonmail.com) ---
Couldn't find any kernel newer than 6.12.15 that I can easily run on my Fed=
ora
installation, so I've switched to 6.12.15-200.fc41.x86_64
(https://koji.fedoraproject.org/koji/buildinfo?buildID=3D2661636) and added=
 a
versionlock for now. Can confirm the behaviour hasn't presented itself, mea=
ning
it's solely affecting 6.13 and newer.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

