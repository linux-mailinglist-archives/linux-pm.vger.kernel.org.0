Return-Path: <linux-pm+bounces-11787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598EE9441F3
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 05:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9B61C21E19
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 03:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25321D696;
	Thu,  1 Aug 2024 03:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIg4eFMZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8231EB4A0
	for <linux-pm@vger.kernel.org>; Thu,  1 Aug 2024 03:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722483574; cv=none; b=j2qxASS0G4dWySclrEKNe2zNz0VwwK8U6urIt4q1GeyQaQG4adxaKfg7I5KXPM5HRzsem5TxRn/c+kXANKty15JTagKxFgS5uqKVHgKBf3p1bT4UftmlVfXYeKgLcwrVtJ60tV3gElpURmgDEXu3fV7AlWPAa7a8/mys9vbevzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722483574; c=relaxed/simple;
	bh=6jGorjGxUi1F1TAGp5kIZClImuoFXSIwBSFnuheaKQ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fXe8124iBLbpKvEdTaELtn+j8yIlZMVA+d2AI5EiqdkDIefAUOC+8jYAxeVM4wl4s5KAW+7H7H0DN2nlX1MNYEnZbAkN9hHpOq7i8xTD8WQQSRIKM2X+e6QBtniV5bmLBK6ji/mFLsxx5O/hnbdXpf3sxzWfHx8L/6X25ASQino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIg4eFMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27FE2C4AF12
	for <linux-pm@vger.kernel.org>; Thu,  1 Aug 2024 03:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722483574;
	bh=6jGorjGxUi1F1TAGp5kIZClImuoFXSIwBSFnuheaKQ4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HIg4eFMZxpLl79qAo42uJy2x/rxyKp5mOHfAMvB8Do3dxee1YwxycJtVYT3gb0d5Z
	 6hs+ZJ5txetaZVwdJDkwH20nCOKYs7KzCfPZlTtfnlZf4EosDYOq8zT0HWVaeFvzgm
	 OCVp0AC/aSSTzOOHcK5kOO27BmUVsu0w6TR/WCKgeH9EViC1SjrgaW7gYiEGFqPj7j
	 QY5G3rr1t+3bPj9B5gKpWMs3ZRIuf7BS/t00xbN6TqY2woLOt8ppn8F7ZlvxESzpzr
	 K5NzxcYqBbL4UOqSAbxKM/r/UgZ7rYkrxNp4yfk8kaveLmtV8zEG5ab9bXa1vgWcmW
	 wEfmHkP6cB0Ow==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1F52CC433E5; Thu,  1 Aug 2024 03:39:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 01 Aug 2024 03:39:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-FjMHkm5myT@https.bugzilla.kernel.org/>
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

--- Comment #67 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/progra=
mmer-references/55901_B1_pub_053.zip=20

Page 120.

CPUID_Fn80000008_EBX [Extended Feature Extensions ID EBX]=20=20
Bit 27 CPPC. Read-only. Reset: 1. Collaborative Processor Performance Contr=
ol.

sudo cpuid -l 0x80000008 -r
CPU 0:
   0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f edx=
=3D0x00010000

Bit 27 =3D 0, that means BIOS didn`t enable CPPC capability, OS cannot dete=
ct the
CPPC flag on the system,=20

you can check lscpu output,

#lscpu |grep cppc.

Windows maybe don`t depends on this CPUID bit, but Linux detect the CPUID a=
nd
set cppc flag at kernel booting. no cppc flag, amd-pstate driver cannot loa=
d so
far.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

