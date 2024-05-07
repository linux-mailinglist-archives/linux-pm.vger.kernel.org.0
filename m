Return-Path: <linux-pm+bounces-7567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1DB8BDD49
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 10:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFB51C20CF4
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355ED14D2A6;
	Tue,  7 May 2024 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDOLyiYs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1121A13CA8D
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071271; cv=none; b=WbU/wvLtiaVJfXjqZ1cBJOOZx9gkQQDakmSIR6ez7F5EXziuxFzpEhwQDiWYExQAxZUTUeHnuZeiCcpsvkLo+2WvkGRrg9zk72fmyJ/3Lu/ES+yRFFKrhlfZOA+GAnnD3A83M+8TvtMOJxTc1377FLQTpn08ToKsO+vaeneJKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071271; c=relaxed/simple;
	bh=Lmh5xqUqFD2HruiVtSIocfiXpzAwh3abONhsDjWObfE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QT18xZobjS9CX8JRcV4/+JoHWjcZ7Qrm3BHGLymrENF6xKJor0ZLWfcdze67U2uycPGRTIhZWCK9vE9k3lbxAJsBjssLL3Cn+TXT9z7kBATiaA2EXkbou4CMgr+PrSTtENe9C/6lSXlm/kpVA8JDRyUh2zwcTDV5KRr8Tofb7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDOLyiYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BAD6C3277B
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 08:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715071270;
	bh=Lmh5xqUqFD2HruiVtSIocfiXpzAwh3abONhsDjWObfE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PDOLyiYscQnd5Cd9viGino2EB7x9cJKaxq/faD3kW3rO8t/ajumPP+Ay1mBGF3Npo
	 9v8AHpFG5bUGLrtEPjFUFc/UKh3N7kQT1HYsKXi/gyIGqdS0CqsRgHMAh9eII0v1P9
	 V0vEelgNX2T334F/kmdSqmO7Bb0wyDqYvZEnZoQmRjH8LqMlv5gvCgNCPvH0U2MmuO
	 Oeto0iipW85iFbCBw6N4GGR+bxSNbAZhiqxnVkNahxzMDioOqX/VM0r4ZJHJDi+yAr
	 toTfb5jI49JE7TRswFfjs6q8KZ6cU5hAgTtc6ZqtyBpRYQ3ps7MQImNGiwhj8GfIUZ
	 weI2/6Mh5q8gQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 853E6C16A72; Tue,  7 May 2024 08:41:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 08:41:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-I5lVlDO98J@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218759-137361@https.bugzilla.kernel.org/>
References: <bug-218759-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

--- Comment #19 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Hi, Please try this patchset for the issue

https://lore.kernel.org/lkml/cover.1715065568.git.perry.yuan@amd.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

