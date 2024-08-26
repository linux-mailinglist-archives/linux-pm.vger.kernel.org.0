Return-Path: <linux-pm+bounces-12897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C4E95F7F4
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 19:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75DE91F2144F
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 17:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EE71990DD;
	Mon, 26 Aug 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCu9QT7O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09AD1990D9
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693002; cv=none; b=fXneV4PBlRiMu8wxKPpIIKOjY9BfY2DrYBK+ss8I5uVnZURbZ1JgFtkOy44cMQkxk1CdVLwyvUVmq3scw5ebj5X15g9wYjXLwnCyPI2onl1GRPgmEq4ETFVPxGEQuqBPzN16FpPRuydyUx//uoC/yxfSc/DHGMC/MN+Mh+JGmQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693002; c=relaxed/simple;
	bh=0kz704KWW7v2c2I3a3OTfUf3aCINlDJ2w9wzFEmwuT0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VN/23VvzhQZJGNhtdRKO4ebeSNQrRGVI8k455ZmLca/mnDhl/y5AsDLltUfORi5CP+Rw7jU8xQ1kCoLngWgZF/ltemPPPyydNiFaQM40+7m+/kgtXKppYEPSxwxIlK/tLCZA1hMpA6nOM7k99IwxgGghifAtEzD9WEfLZXN/+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCu9QT7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36A8DC8B7A2
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724693002;
	bh=0kz704KWW7v2c2I3a3OTfUf3aCINlDJ2w9wzFEmwuT0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PCu9QT7OxMDCQkwCiHp+JyCrlTCQkx8aNlb44MlMAjSkP7SrqQx5DpEwiP2Rl+tJV
	 3wy5pFDdRnqX3joK5RMcZ8sYe3WzYKBQ6GvwlvxmkYZUi458g/smEqmW6U+2mo+qL0
	 fhSR6h/R9O7zZ+87hJDINj6bF3g5AMTjKgDAvrIdrdQjO/H3xX0Xb3sJdPwzQ4vR8H
	 YNovrIg/grWnsyC+H2T63/M3PSp7yPXBE7NMSAjsiBddzcGonzOpxzLaMWyOlMXucM
	 q4SdtoHvd8mSbfJrAgHmSqBQ9y3Ay4naJ/y7AqUyu1lMlY3nKKsf1btWw5U5zSa0J6
	 P9XmUjy5Ce8JQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3032DC53BBF; Mon, 26 Aug 2024 17:23:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219110] amd-pstate's balance_performance
 energy_performance_preference doesn't survive suspend resume
Date: Mon, 26 Aug 2024 17:23:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219110-137361-w22G8Auoui@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219110-137361@https.bugzilla.kernel.org/>
References: <bug-219110-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219110

--- Comment #8 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
To me this sounds like a firmware bug.  I can't seem to reproduce it.

I just had a try on an AMD reference system with a "AMD Ryzen 5 7640U w/ Ra=
deon
760M Graphics" running PhoenixPI-FP8-FP7 1.1.0.2a.

For my kernel I used 6.11-rc4.
For userspace it's Ubuntu 24.04 userspace.
I ran "mpv bbb_sunflower_2160p_60fps_normal.mp4".

I then SSH'ed in from another system and looked at the average PPT value
reported by 'sensors'.  It stay in the 8W range the whole time.  Here was a
snapshot:

amdgpu-pci-c200
Adapter: PCI adapter
vddgfx:      900.00 mV
vddnb:       759.00 mV
edge:         +39.0=C2=B0C
PPT:           6.00 W  (avg =3D   8.14 W)

I then stopped the video, suspended and started it back up and looked again=
.=20
Same ballpark.

You might look at the value for the MSR's that amd-pstate uses by using 'rd=
msr
MSR' to see if they change in any notable way before or after suspend.

#define MSR_AMD_CPPC_CAP1               0xc00102b0
#define MSR_AMD_CPPC_ENABLE             0xc00102b1
#define MSR_AMD_CPPC_CAP2               0xc00102b2
#define MSR_AMD_CPPC_REQ                0xc00102b3
#define MSR_AMD_CPPC_STATUS             0xc00102b4

The most important one to check is MSR_AMD_CPPC_REQ.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

