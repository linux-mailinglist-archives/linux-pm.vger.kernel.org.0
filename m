Return-Path: <linux-pm+bounces-16607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EA99B3784
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 18:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D8EB258B5
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40EA1DF247;
	Mon, 28 Oct 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teD5cj7o"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F81DEFDC
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135963; cv=none; b=obriq6r3dWK4boEWj+rKkP9nTH670ugWspdgSnpCyfXMmH8jfh4V2jtqEM14Wu/CbMHZgMAgdhthKGBeOpngm//EWjWE9aEVO8Ua05bDwvMkbzHeeZwVHGtWRZ35jSFQUtj/yMAKcIgQYX2TqlZKVj2xFkbkoauRWy5yG3ksgN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135963; c=relaxed/simple;
	bh=cWjiMSu79m6PxkRyG2jvsMOxL9WuiNpndIGmBAcGJek=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HOFcSyuQcW68bxu90clVpUdp/TxfPPahC2piMpC2pRhe9qALtQbOZpgc2wSQ+zxSDyWHeCS3CxCLa9N5kSnmLqiOGb6eXV5jCjN7XRsOgEAQ/sJAuJeyHe/OSZGAf7gcUHu1A2GCyykVEQ5UY4h3875OIMP6O0K/WpEQFRntR9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teD5cj7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FB9EC4CEE4
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 17:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730135963;
	bh=cWjiMSu79m6PxkRyG2jvsMOxL9WuiNpndIGmBAcGJek=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=teD5cj7oYYhL6HQFIO0/2maBpbZRGIM1JD+mgb781Ied5Xa5rqKmFpwZeubrQZSKO
	 AuDQeZZGcNdeHN4rBKWpJst/hI4o1imV5ei+IGG1bOOKNtF0yHawcF1xsU0T3JLQND
	 8Elopa44Sj6zzrVMwUJvbBFYf3RVD6bLMJerbwwBvp77kIHYI3GALkyfRIXc426RcU
	 Idk+qY7ht+Py5kcx0V6Rxby3NIOWf4bvoo/jCb9siAVmb1l19mVvdWGqDJuEkPbjNO
	 byTV3evOwcclS5BWXHD34SlWh3l9QnuYInlS8nIJab+UdYucTtLCj+zVvsodZogyMz
	 ZVL0J/OPejU7g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 264D5C53BC7; Mon, 28 Oct 2024 17:19:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Mon, 28 Oct 2024 17:19:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: intelfx@intelfx.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219431-137361-vCoUg7BPmP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219431-137361@https.bugzilla.kernel.org/>
References: <bug-219431-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219431

--- Comment #9 from Ivan Shapovalov (intelfx@intelfx.name) ---
Created attachment 307082
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307082&action=3Dedit
`acpidump -b`, 5950X, ASRock X570M-Pro4, BIOS P3.60

Attaching `acpidump -b` output for my system, which is a 5950X on an ASRock
X570M-Pro4 motherboard. The BIOS is also quite old here.

I'm not observing any specific functional limitations *that I can track to =
this
issue*.

However, there is this thing that basically nothing I do to the EPP knobs or
the cpufreq governor has any effect on the CPU frequency management behavio=
r.
Also, sometimes under ~75% load (cgroup limited) some cores get stuck at <4=
GHz
while others boost to expected ~4.7-ish, but I've no idea how to reproduce =
this
one reliably.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

