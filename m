Return-Path: <linux-pm+bounces-1199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353208146CE
	for <lists+linux-pm@lfdr.de>; Fri, 15 Dec 2023 12:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FC71C232E4
	for <lists+linux-pm@lfdr.de>; Fri, 15 Dec 2023 11:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E165124B47;
	Fri, 15 Dec 2023 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO17Ak8q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7BE24B22
	for <linux-pm@vger.kernel.org>; Fri, 15 Dec 2023 11:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 065FFC433CC
	for <linux-pm@vger.kernel.org>; Fri, 15 Dec 2023 11:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702639503;
	bh=B5Nl5lRDqgM6zVn94/ZihNmtzrTcD7PANdEp1S47qOU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jO17Ak8qXOlXlqMx/r75nSEaFZcx6coGSJQsw+SqvEcbdoITLq9Ycp9xIts8sNvmL
	 hHlhfFOTbwbkybph5qhAoMJtyvt+jkttx68ZlWwzS5frgm4knUV4tUXikBV0l2NZZB
	 LMdboiYMtv5iLPHL5h6YcYzJjqH26bQZCoFcH7qK+6mo6tXyZRyrKEaN5zoRBD2zEH
	 fAJ/5fN21FcnzrHCbX5hAtDRIXkQVOYSBJMjFwyWPTqGg2trBAyXCafGZFrMAJDmN8
	 cEM9cK31o/L15+n/OaRtgL9IReX0ZfzQ8S6xWobhh05qtA53OIqGp03NGfGMAE3/9A
	 DqEGL2jVESRoQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E9B90C53BD3; Fri, 15 Dec 2023 11:25:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Fri, 15 Dec 2023 11:25:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: johnypean@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218171-137361-qQoeJ1sKFn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #20 from Jan Kosterec (johnypean@gmail.com) ---
Created attachment 305606
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305606&action=3Dedit
Gigabyte TRX40 DESIGNARE BIOS v. FD TR 3970X

Hi, attaching my report with acpitables:

$ sudo inxi -F
Machine:
Type: Desktop System: Gigabyte product: TRX40 DESIGNARE v: -CF serial: N/A
Mobo: Gigabyte model: TRX40 DESIGNARE serial: N/A UEFI: American Megatrends
LLC. v: FD
date: 09/07/2022
CPU:
Info: 32-core model: AMD Ryzen Threadripper 3970X bits: 64 type: MT MCP cac=
he:
L2: 16 MiB
Speed (MHz): avg: 2251 min/max: 2200/3700

$ sudo dmesg | grep amd_pstate
[    2.189961] amd_pstate: the _CPC object is not present in SBIOS or ACPI
disabled

CPPC settings enabled in bios

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

