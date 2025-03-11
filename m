Return-Path: <linux-pm+bounces-23817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 104A9A5B7FE
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 05:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB3318912BA
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 04:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576BA1E47B3;
	Tue, 11 Mar 2025 04:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHxiG9mh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3206F38DDB
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 04:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741667239; cv=none; b=gp9cUqz2Z9Xcoxw3p/5qCpC8Qm/REhHiHa2ieeDxy0nLjej7JUP44Izz/a4tqkjvKgfPwekBCg9t15aQt++jXLyrfdO3calOs1ZuuAmQSbybqNbFUgqoZsnpJ7EFcNEBFHNzMtlAmJ1dXXs6o90GK7XoMYYYC2QBlBDmwuqTPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741667239; c=relaxed/simple;
	bh=6fKGI62L9pcYo2dTaYFFcWl3RF6n5sRQSnD1DWUwAPU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QXcp9Le3wv0Em7B9pRnPdcrSdKznl7DTrLe2DpNAm+KJBjjI5wHT4cVZQVszfUc0NeY/MyiaZDqd3zIib91L2kFMP95JfXws7yOR9Ep/ajAQeb1R4/hBsvLYsFyZLTu53xudFgYKuDTU94L+cPJgZkx6zhTF/JS59N65pXyShLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHxiG9mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1E50C4CEEC
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 04:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741667238;
	bh=6fKGI62L9pcYo2dTaYFFcWl3RF6n5sRQSnD1DWUwAPU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uHxiG9mh3pYD73nROUrTQerv0s8s5H4b5XdFxHUfoPGFUdeyPiEfGVkumVzWhqScV
	 1RWCTq0LNtNgqJ6HlMjnI18G2LXz2hCOcKzJIez2INlRI4yExZ28ZVlJuHc1eGPHey
	 B7zZ6Jce/+YL8Y7ASiryc3dPheRljy5Ul1D2JpXwPiktevgHjbl0qA3MToVbJ4uELx
	 a40h4cG9BvwyY/f0jJ1eFZfX05Dtg5hmMMUScw1sF0jl322auAMgNKTWYLIKt53JB3
	 MZclUHZawvN2Xwjdw5SjvZalSH2EPceoZHZR65/FJ2yTUJMejVlNWzSfPgZcfhmJK7
	 M010GEoD7Oi8g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8B646C53BBF; Tue, 11 Mar 2025 04:27:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219851] [amd-pstate 6.15] Frequency Scaling Will Not Scale
 Above Lowest Non-Linear Performance on Ryzen 7 5700U
Date: Tue, 11 Mar 2025 04:27:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dnaim@cachyos.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219851-137361-gVkotPYIsm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219851-137361@https.bugzilla.kernel.org/>
References: <bug-219851-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219851

--- Comment #4 from Eric Naim (dnaim@cachyos.org) ---
(In reply to Dhananjay Ugwekar (AMD) from comment #2)
Hi Dhananjay,
> Hello Eric,
>=20
> 1. Could you please give more details on how to reproduce the issue? which
> governor, amd-pstate mode (when the issue was observed), workload. Are you
> able to reproduce the issue on your machine as well?
> 2. Just to confirm, does the user have
> https://web.git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/com=
mit/
> ?h=3Damd-pstate-v6.15-2025-03-03&id=3Df6c0b760290951688697d9debbb2b8462c4=
23a48,
> in his tree, it fixed a corner case in the culprit commit that you pointed
> to.

It looks like the user didn't have that commit after all. They were using an
older revision of the patchset that didn't have the updated amd-pstate comm=
its.
I should've asked them to crosscheck their issue with the kernel in our
repositories first. Sorry to have wasted your time. I'm going to close this=
 as
invalid.

>=20
> Thanks,=20
> Dhananjay

Regards,
Eric

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

