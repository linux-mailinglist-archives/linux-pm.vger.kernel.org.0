Return-Path: <linux-pm+bounces-6618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874008A9426
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 09:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93531C203DD
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 07:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4CB57334;
	Thu, 18 Apr 2024 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIUtAr/z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620C56462
	for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2024 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425764; cv=none; b=ny9fWYcf5STFjF0zuy6eWwl8cWA4Oj1NKJ5FSc7VqhJfR5TTkPF47dT7pfRhWIco8SBcOKSYC7ZhZUgBcNSA+652j5gs1yHhCZnpVF87GJEYCty0+my9aDfrdCir0zypMXQl32bS1g+tOpZGQvLOYfPYN/6F7iCHehWVJ4pV6uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425764; c=relaxed/simple;
	bh=TNq6NiaNA717LBQnOMKNh5eAPIe3GtOI/QuYopoErR8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IwIz3otQBH3zapZOazxojh1go8E3+weQM0xUXxbirr15SZUjK0EI5NMHoMnWM/vFaKG/IDX4es4xTaXcfrHVdz0e9mm7CaNqY8qdQHQx4oXLNgV02N8l0kf6XW5+zxLXofRirDs6yiPklvCbR9H6/8MmpY8rzwVTh71cQkNAwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIUtAr/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B67BC113CE
	for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2024 07:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713425764;
	bh=TNq6NiaNA717LBQnOMKNh5eAPIe3GtOI/QuYopoErR8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZIUtAr/zlxeYwEZcprz4s4kYu1Q/Dqe6awOAdwl9cLpR1Iy8Dhnj1Fm/sePZFwKSP
	 wagDUpvMZg9OZi5aCjUKhy1TGK5Qj8gDHhUUE7FPIlzZAMVphdIBAqqFisLyh4L7Ab
	 0X6K6623H+JZ+gFiz+5zUCXnY1fWQ9dykOFs12lJ1vCvNM3K/Aa/N29KsDv9k5kQw5
	 11/yi+EBaV5zk/2DEabdumCFnPVhpgUblXDGGXTH/zdK+7p7FpsyPy8IKxQv04NmEZ
	 t2wDQiqwIcCnQxLrzSljdxGiVahHdCsgCxBwvE7pSEz99hfuaYbJbWDldSQbsuKhKh
	 vzKzk65vM8TYg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2CC04C433E5; Thu, 18 Apr 2024 07:36:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 18 Apr 2024 07:36:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-wJ8JwBnT0j@https.bugzilla.kernel.org/>
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

--- Comment #39 from al0uette@outlook.com ---
(In reply to Perry Yuan(AMD) from comment #38)
> Hi,
>=20
> sudo apt install cpuid
> sudo cpuid -l 0x80000008 -r
>=20
> Please help to provide this output.=20
>=20
> Perry.

Here's the output:=20

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

