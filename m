Return-Path: <linux-pm+bounces-24821-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91C9A7BED3
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 16:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20BC3BB00D
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85931F193D;
	Fri,  4 Apr 2025 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZ/Hx86i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9353942A87
	for <linux-pm@vger.kernel.org>; Fri,  4 Apr 2025 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743776027; cv=none; b=dZMOy4K/jk4h5U5pofPWCGOZvPkNVbO7kiwpfNWrMDIQWhw3H64X+JVu4eY4t523AtnRuLn8LMgMI3Rh2YyvfDJ+s9UOrzKOsww5O/61+P7p7Bs/5KnfUgNDe08P58km/pUIUWdh24g0qHS1f4LvU0vEdxii/2wiF0b6MFdCWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743776027; c=relaxed/simple;
	bh=b6CBWN3GPasTJBGfQtT/gUQ+MGQeMASZBmOC5yeHljk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=upABjZeD2LuDWupKSVQSodIMs0vZcJJY++EjR9OU+4XFCxsEt7j7uR5wX8gbPMKx+4HQWgu+tbwgf/lvQV/ckvYrdlkyJ7rhDGuK9Vb7hCRSQz7hhv0H2a5hedroKFYPrTVofC/Y4Cd7yODuVOryPq/ZsuofYAOMEDJ+dP5M1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZ/Hx86i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BA55C4CEE8
	for <linux-pm@vger.kernel.org>; Fri,  4 Apr 2025 14:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743776027;
	bh=b6CBWN3GPasTJBGfQtT/gUQ+MGQeMASZBmOC5yeHljk=;
	h=From:To:Subject:Date:From;
	b=pZ/Hx86i2fGvU+t3vVCpCwLVU1scDXPwPOH792kHN3p7DVw3gCLOpM1TvI4JzjFLp
	 fu1V309CbZa9q5L1rFQ2ACdH2lTPJYcuW5nEinpZfrqTEQEl+dHKasX6alPiT28WyS
	 z2rOvSjQOgghLBsYS8g3fYOot88GSwN5JXzLFejO0zRJV32B8Fm5hrGVrZwcJSYRX6
	 +Vg6NtvOXpUcVKRkyv78vZhdMqOJlJUnybRN12ypW9kSNOir0V4eQ04PHfdNhHoj4z
	 4DR719chxfEQfmnvppGiSyH6/6v2nVxlVY3tA1NI4XkSkQ2e2FLitl4SJjpWgUtMfu
	 9NJKIvYXMGylg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 59C85C41616; Fri,  4 Apr 2025 14:13:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219981] New: Regression on amd-pstate suspend/remove
Date: Fri, 04 Apr 2025 14:13:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: vincent.maurin.fr@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219981-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219981

            Bug ID: 219981
           Summary: Regression on amd-pstate suspend/remove
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: vincent.maurin.fr@gmail.com
        Regression: No

The issue that was reported here was solved by adding handlers for
suspend/resume events https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

These handlers has been removed with this commit
https://github.com/torvalds/linux/commit/2064543f5ba0d2929e3e9b3a616c3262a5=
7c7925
and I am suffering the same issue again (so scaling frequencies are ignored
after a suspend)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

