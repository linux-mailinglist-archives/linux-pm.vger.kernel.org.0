Return-Path: <linux-pm+bounces-24604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC23A757A2
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 20:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1478E188EAEA
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 19:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BB6199E80;
	Sat, 29 Mar 2025 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iqo17WxR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819617A31A
	for <linux-pm@vger.kernel.org>; Sat, 29 Mar 2025 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743275071; cv=none; b=dk6FDt8TR5ukH2iPvG6DnU0C8VWrHWPJ+Snk2E4L13PozQ/4tMSutYbozHn6r1BrWLXLOHQtPoOdrFB0mntbSsYAqoQfwwSkG+anZ5YkOkvLJmAMGsgOk+AH48bfV4zz+iTug/TcOR0TrgKDmS3I+v7Ib2F3gVRLNQvlRNU/+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743275071; c=relaxed/simple;
	bh=ncYXcARCgsAIiUKeffh9rQIZHcepAQi2KD87bAYRpUk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K4k0YHZtBQl6ejZWo9TphnZZjuEorjBrLujEvMRxIuTJQwSlrOu1miJLmlyLn66/UcwfnGPr0GevQqmsnrOEawV36LimXR4ZIIfOUJFhsjrGwB+O/CK4g3rdV6G6rsyROEXQIqCOGTJHwY95Zjag+8M6r863s6sgl3q/LwYCm8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iqo17WxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56431C4CEE2
	for <linux-pm@vger.kernel.org>; Sat, 29 Mar 2025 19:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743275070;
	bh=ncYXcARCgsAIiUKeffh9rQIZHcepAQi2KD87bAYRpUk=;
	h=From:To:Subject:Date:From;
	b=Iqo17WxRb0QVh6d+D6Ea5s+j1LxGdxNmNzZp7ukpfO6bSWV+TtlBoc/kliUnpKyrq
	 5ilxR6eLoethI0NNZXuArkV77sd7mSr+iNmAmDzrqymSPmLyMvMBJE/yDhJ/yTPlnL
	 0MBi0CDSSJph5e9jk9hw6Ziio4X1sC574k//baoeRx6CcxeG6I2qT9yjb0xZiD2WYT
	 OgnaXG/Y+VeFIjIJjnPZUUbPTLk589Fff7cesnAvdRBNiwqtNrFXopnTaF5kqTfNO9
	 bxKZp5k3pKZaSgHHDCAQf08BV32kMa/vBqxqYoMjcJQP7rzXhmh/3YaFwUkN5NAXGI
	 rjvv7U8Hw7/Sw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 46E00C41613; Sat, 29 Mar 2025 19:04:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219966] New: modpost: EXPORT symbol "policy_has_boost_freq"
 [vmlinux] version generation failed, symbol will not be versioned.
Date: Sat, 29 Mar 2025 19:04:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219966-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219966

            Bug ID: 219966
           Summary: modpost: EXPORT symbol "policy_has_boost_freq"
                    [vmlinux] version generation failed, symbol will not
                    be versioned.
           Product: Power Management
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: ionut_n2001@yahoo.com
        Regression: No

Hello Kernel Team,

I notice this:

...
WARNING: modpost: EXPORT symbol "policy_has_boost_freq" [vmlinux] version
generation failed, symbol will not be versioned.
Is "policy_has_boost_freq" prototyped in <asm/asm-prototypes.h>?
...

Kernel: 6.14.0 mainline

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

