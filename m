Return-Path: <linux-pm+bounces-11657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CEB940F8C
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 12:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519281C22A08
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 10:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED9019F486;
	Tue, 30 Jul 2024 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7XA2hwN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC3318E774
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335545; cv=none; b=hmesLDHbgO2CDecaQUwWeLVPLMN1zTqyxoCseJ3qU/qqnt8EzNh3Wft3XLGEnZ6md49n90+nRvTPsvi5u34lVkEHVFIZWejAMNXUMu0x/5Migrcj7Xa/fATxVG4IaV0kwwXgfGCEluvFEfMD24CnKfnTJfQah40cZx7Ee7p+5Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335545; c=relaxed/simple;
	bh=TO2qw2rR5DMaoe+jo098Fc5MaDSv2YUKBJki/q6v0v0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U4D4N65JXrZSskAHweOMgYwslAr5YFfiMP6eRg8R/usV8WHdUp+vWVsQnkKmxmSAH1uKluyDx0JUJYgR4fYmYfms43gEO76G4pn1pKuBkqxx6vNUvSRLhjk2Bz0uYWDGbtJqo3GJgVnsRv5O2uDOj7RFguEuqx9yZKZhgAJbhk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7XA2hwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0F24C4AF11
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 10:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722335545;
	bh=TO2qw2rR5DMaoe+jo098Fc5MaDSv2YUKBJki/q6v0v0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=X7XA2hwNPSKG2m4vn8KmS6Oc6vXuMwP05zFMM/xYu9iOUApZOawzNh9w1wePSzZvI
	 zzxnbOUifqwjZ35GAFAfEn8HxCFcmKXHBcUz77H2UwL7RSUO9wkD/m9p/Wi1CK4wxK
	 nfQC+zFW7oUb2l2KCfNWtxhkceK4q1LsBHt8qUAmkvzgh7taUaeslhda6qStxzDg0M
	 N/gzq6ZpKY4pn79iMrRRL/GioDFgL7k5nIe5ysmE6tK5O8l8l4OAlSo6KC+Lu/6pqX
	 VjoGavq9Lm+znWnPMNT531duBgJAvmjpkXGJ1OufKphxqmPscIjVh2d+zyzNtKXP1d
	 geN2v3r2e8VAg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A4AA2C53BBF; Tue, 30 Jul 2024 10:32:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Tue, 30 Jul 2024 10:32:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mike.stokes85@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-NlFVkXeGfK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

--- Comment #58 from Mike (mike.stokes85@gmail.com) ---
New BIOS version has been released:

Version: GA403UV.306
Release Date: 06/05/2024


sudo rdmsr 0xc00102b3 -a
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0


sudo rdmsr 0xc00102b0 -a
e295290f
dc95290f
e895290f
d695290f
c495290f
ca95290f
e895290f
d095290f
e295290fe295290f
dc95290fdc95290f
e895290fe895290f
d695290fd695290f
c495290fc495290f
ca95290fca95290f
e895290fe895290f
d095290fd095290f


sudo rdmsr 0xc00102b1 -a
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0


sudo cpuid -l 0x80000008 -r
CPU 0:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 1:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 2:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 3:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 4:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 5:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 6:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 7:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 8:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 9:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 10:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 11:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 12:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 13:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 14:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000
CPU 15:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

