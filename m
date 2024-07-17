Return-Path: <linux-pm+bounces-11211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAC393417D
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 19:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6AA282A63
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 17:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB61D1822F6;
	Wed, 17 Jul 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O81Ubxtj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812F31822CC
	for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721237341; cv=none; b=L985XcHfIvTTLs3zoEXpUXtbgJ+emOopOZ6d2ctPiun7Qf+WEwyspdxLtEumUr3RRG+euv7gAGWqIXOt7hiidEI9w35zJsungCPhta3pBbSWl4xIpZk9WmlXHtH728nL3Du/0T85Rsp1jv/Lf09bhF2jZkDyvKRNg8sa0mHumTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721237341; c=relaxed/simple;
	bh=piH9kyhRP6oB+NgUhbvW0wQSIfUVBUsM1KQKxdh5SuI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=foPgk+UOZfJJnyEMSBcZPdVrTcUxGNBXzra78NrrCTIYk9u26nddfWuDfxUcJPAicrahbf3JMz0HTbbq8tQOQ614mXyp2Nmv9ohu9YlXsj6PUAUHD+Nute44eWxVofotCG9BcNlbhcuRLMWe2iKnxl4gkkCN46BhWwNYYDRvFPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O81Ubxtj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A36BC4AF0C
	for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2024 17:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721237341;
	bh=piH9kyhRP6oB+NgUhbvW0wQSIfUVBUsM1KQKxdh5SuI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=O81UbxtjJabiVDUB1TxDFYnywUMDWmZYbmRAHBHW4VhCjsAMmD2vFxrLZwiZK4TZS
	 S3J4yoOGaqDRfmvYdiCDMP9Rg7WjK0tTraCUMOMoQYsBnnZI2yA0B4vDkuga218xZo
	 UlQz/P9VsCM41fnMlau4FlxEm8APwonWj+S6AYj2a44axJIG6gOnCV9qxsDjM6bycn
	 OCa8xlhw2tUNapqk7fnKqVh2HJkhOMQSeiW4qynUNl/EKuebh9GVkW1ds46tLfX7eT
	 fPSX8adD6A4kIkRX3Or4BbIcP56T09QInK+jf8s9uYYCM4Dz7rLfRILoE5QAj1RMMK
	 4wENyKk77PKcg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 02147C433E5; Wed, 17 Jul 2024 17:29:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219051] amd_pstate=active reset computer
Date: Wed, 17 Jul 2024 17:29:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219051-137361-HjRhpr3fvM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219051-137361@https.bugzilla.kernel.org/>
References: <bug-219051-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219051

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Also, it's worth noting that if your system resets itself (and you get a
confirmation about that on next boot where dmesg says your partitions have =
been
recovered), it usually indicates a HW issue, rather than a software one.

Unfortunately I've no clue what could be wrong and how to test it.

Some AMD users have been playing with undervolting their CPUs using e.g.
Smokeless_UMAF or similar things, and I wanna hope it's not what you've don=
e.
Undervolting may make your system unstable.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

