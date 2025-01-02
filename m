Return-Path: <linux-pm+bounces-19878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F6C9FF589
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 03:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDAB160FAE
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 02:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEF64A00;
	Thu,  2 Jan 2025 02:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZiQpYzs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66AA184E
	for <linux-pm@vger.kernel.org>; Thu,  2 Jan 2025 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735783890; cv=none; b=H6fBY4YWQDjs0YEbgJi91+1A6sUVkQBWV4GL3UZc/faGEnJ6w90XqgsOPx2TkPFvAQLDOTfEK0bTO4BE0x9Q2zpJUX5rN/kEyOZSKivVvXHe4K1VKe1ExPJ2IIqv2qChVM5pAXUEfClL/mlZ6yCq6mXb/ADF5kic72YhBcnRrr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735783890; c=relaxed/simple;
	bh=tF7J7F0cAYFW/IX2u1lgxozmkIT2Jg7qNwAN+Hj8v6I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pBNPrsr0EKSWjb9PKjS/j44tAsCK7A7PwkYf4GGgCdQ1vmASKrfdD1SQZfs7TmC53FgO2261znc/5/VIAT1hDYLt3pfx8CnsVQstBcaTUGpvKq2JmsM153a2hrhM4L765KB6XX+mP2zpdaf8hvOnBEOh3O+Gz3w2rdgc7bY9FPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZiQpYzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E922C4CEDD
	for <linux-pm@vger.kernel.org>; Thu,  2 Jan 2025 02:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735783889;
	bh=tF7J7F0cAYFW/IX2u1lgxozmkIT2Jg7qNwAN+Hj8v6I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KZiQpYzsUxZ7/kCO7hUrdb7NtRAcL+8eE/Iv9F6vH59gj1cy7b6Q210Nca1hm7MK0
	 5Ew7o+OiMTeZoVo8tpV7ZYAoX1rF8TS+fDV3i1HukCuP5Hlrmw98FXe7H9OO92XK0p
	 fPOdHC7fUWjVxJEOX+WNTzRxoDeGgtZrDwa/EEEVzBA+FMHBEwckaSWFWzms2tNKx1
	 PO2Q90pkiUg1M0/EyldyyyeGVAcn61vlKyahNXfsWZrFK9IHx+91t5UjUJyHWI0kCl
	 FTu0SLqbS0LIZVsjMp+UcM5pZ2Ef4CRzgDjKI750WCJSpHIWMSKRRuzk2zoxe+6oc/
	 tv4yNic42ZtoQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 70B4AC4160E; Thu,  2 Jan 2025 02:11:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219640] [REGRESSION, BISECTED] Preferred cores working
 incorrectly for Zen3 CPU (regression)
Date: Thu, 02 Jan 2025 02:11:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: mario.limonciello@amd.com
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status assigned_to attachments.created
Message-ID: <bug-219640-137361-YaGFOtJo92@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219640-137361@https.bugzilla.kernel.org/>
References: <bug-219640-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219640

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED
           Assignee|linux-pm@vger.kernel.org    |mario.limonciello@amd.com

--- Comment #1 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Created attachment 307438
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307438&action=3Dedit
potential patch (v1)

FWIW that commit ID is a little bit different than what landed in mainline.=
=20
This is the mainline commit ID:

https://git.kernel.org/torvalds/c/50a062a762005

Looking at the changes in what you identified, I have a patch that might he=
lp.=20
Can you please have a try with it?

If that doesn't work to help isolate; can you please tell me if you can also
reproduce this issue using the 'linux-next' branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=3D=
linux-next

While also adding this patch series on top of it?

https://lore.kernel.org/lkml/20241223043407.1611-1-kprateek.nayak@amd.com/#t

If not aware you can use the tool 'b4' to download and apply that series:

```
b4 shazam
https://lore.kernel.org/lkml/20241223043407.1611-1-kprateek.nayak@amd.com/#t
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

