Return-Path: <linux-pm+bounces-37342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6933C2F7AC
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 07:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D9F934D13C
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 06:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8789535977;
	Tue,  4 Nov 2025 06:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyuMPcdZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059E35971
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238811; cv=none; b=HOVwMRMqKghhDPM824nSOgWkCmTaZWed88LfQXbUzWz6vS/ByWAusfnZgho+x4p2XwPrI44i7kcrA0IW8sgc/GOwHzIHCt5u+Ui4ul/p/DSCkUlo+fGCwOnp912DGrvZhjS89hkKNYY0pnQWesyj/2PbMzfOd8z+RBKzSztcQL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238811; c=relaxed/simple;
	bh=eX3fIp/uaqJ5lCpgInWlyfHk9Lz/9PExRsF2X6i0tcc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J+h23IvpRe2AveO/IaYLJIp71/mMENG/gVX1JDh6EeFLmPZh0NgMr8zkyXWANSxH8HRmaV6Z18XGIw1AtTlN+4BnERQUBaECGW7wkDIPWBjarPtciUnKHsUTlk08ApZZPg4WO5kJMC1iZ9GxJeSh25C93VK7vZYivOr+dz4iNwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyuMPcdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEE44C4CEF7
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 06:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762238810;
	bh=eX3fIp/uaqJ5lCpgInWlyfHk9Lz/9PExRsF2X6i0tcc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MyuMPcdZu39DgB54V9+kXeE/1SWQxzkownRTA6bi8y/DuUD+XXvi551UcmUcjSB6S
	 IHtLzP1OnKerM0R7BmmKP/8Z9GmaGO65v4cTf24DT75y1OH0lJQee8K/ayr4tdsvtQ
	 wTUK8o+uUOPcNFRQyMHsmLAvHkO4MqIWxreBvoygFtk76QODsdmcJU9jVNUMeZjVKg
	 E+d0a4r1xlA1nn8mqAjx18G68Fa9U30cbk8zqdfHUIkcX1kHXs51N2GzcG3AAeQz0e
	 MAngl8cqg2P2NXSs+BMAEUARLvsnCaep3UoIyjQCMkctgTQPNJCiPYeqUS8rda1q2x
	 3haAbazhuvyVA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E8006C41612; Tue,  4 Nov 2025 06:46:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Tue, 04 Nov 2025 06:46:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gautham.shenoy@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220715-137361-twwOxYHByn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220715-137361@https.bugzilla.kernel.org/>
References: <bug-220715-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220715

Gautham R. Shenoy (gautham.shenoy@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |gautham.shenoy@gmail.com

--- Comment #16 from Gautham R. Shenoy (gautham.shenoy@gmail.com) ---
I think Mario is on the right track in that the issue is because of failure=
 to
detect something on a CPU that is present but not online.

My hunch is that it is in amd_detect_prefcore() which checks if the number =
of
distinct highest_perf values in the system is greater than 1, but uses
for_each_present_cpu() which fails when the system is booted with
`nosmt=3Dforce`. The commit that introduces this code is 279f838a61f9  ("x8=
6/amd:
Detect preferred cores in amd_get_boost_ratio_numerator()") which got merge=
d in
the upstream kernel 6.12.


@Chris, if you don't mind, can you please try the following patch:

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 7047124490f6..d7c8ef1e354d 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -196,7 +196,7 @@ int amd_detect_prefcore(bool *detected)
                break;
        }

-       for_each_present_cpu(cpu) {
+       for_each_online_cpu(cpu) {
                u32 tmp;
                int ret;

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

