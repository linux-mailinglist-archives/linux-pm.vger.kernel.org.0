Return-Path: <linux-pm+bounces-7475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA0A8BAC5B
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 14:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307981F22D58
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 12:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CAC1534EC;
	Fri,  3 May 2024 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flGsWzFo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC96152DE0
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714739100; cv=none; b=Nb3a/D7lGYZCjqGtKb469bny+qHkzpw6OAQBP5DWRvEjZSMMBeG8cmY+ogD9nCmb0JNuIqM8ddV1S/17VBTSmdDBpAkrQ9XvB+KK/RgLHRkSkb6Q035t6haMB2rmxS/br/bJxpk5uYdVZL6mn2v1CTG7WTpcbPJAmvZbJbufhSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714739100; c=relaxed/simple;
	bh=swHAHgxGAKj5m0WbUcIOdJ5mZyPBNxrvxcEdYq9bSN0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mxjnB92zQSLtS5PeLYQkwPBxpV1aBnbIzjccHUR9PCFubKUtZztB01ngRnf6AG9vj5/zEnYqNIdjUZ4qsD/73ytrEfRboVqwoGOsD5R82+vV6+cy+60l7Mmr0U7Bs8FTDF7GDWhvda49b2WEZOxndqXfIM/twHJ9OHXTacORpfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flGsWzFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87156C2BBFC
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 12:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714739099;
	bh=swHAHgxGAKj5m0WbUcIOdJ5mZyPBNxrvxcEdYq9bSN0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=flGsWzForop7uE3J5vxbWOGG8dBPM/TP+weGUaKzo0/OAkKzPBFLDX+gRqw9/VXpZ
	 2I0SC0MSBHioxYiiAPGgWFzSSLBIQHyv5hE/0n2FHc47aLv2gsI5MmtVuzV2GZe98Y
	 NmvieBUSZf6xxpJvT2F3opjeoXmIq80utTeO9CDb7GaXBzhWsu34IeugLAwdFIj8VM
	 efjQI64ZSMNda6nfnhxwua3/8sNt+WDIfV7N9SFhNzXlKamfik+C0uQp/GpOYnymtP
	 mETpIaCJ4F2Zf+usFQ19P8m4DCCM6YvqpIESPKlpagG/DRtuKfHJsxqKjOM+RTfUJL
	 pX/N4hL3ygwYQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 77F1CC53B50; Fri,  3 May 2024 12:24:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Fri, 03 May 2024 12:24:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-YN6zUSNDpu@https.bugzilla.kernel.org/>
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

--- Comment #18 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
thx for the update, Mario!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

