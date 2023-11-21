Return-Path: <linux-pm+bounces-13-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D57527F296C
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 10:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C042828C0
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00293C094;
	Tue, 21 Nov 2023 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PB3UCRpD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00FE3C086
	for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 09:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C861C433C9
	for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 09:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700560581;
	bh=oSfSjBDD8zIu3XnYw9G4NqDSoOKXGc9yd7A66Uh1ZSc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PB3UCRpDOmY4sL72bPr/AMJwsCrL59RZh/AyWzc0l7tm+GkkqdPvJGAKtfc6BbbNV
	 PGjf2Rw6XtZxJNViLN3yabQv9H4k7Y5+r/FHNN5tBn3AhT/NIMTXesUJaNbncR7nee
	 lJDp9Q3URXRc+7IlYJAbPAmAeV0UDMVfKxPt2eEI5IpSjuwGdQ2shjBgwSQ+zernie
	 GxCNWE3lmlLiV+QZjlUUVjuzqp6muJyaieC131TgpIBv/oxDMe9i9km1F9WAJoWYlz
	 qh58u+yYhHmOS0TuqMM66VU1UxJxDG5+nt9JVt/AeQWRq/g3/5f+nSlKP98mTisuTe
	 1mPEujMJPVs8g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 498DDC53BC6; Tue, 21 Nov 2023 09:56:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Tue, 21 Nov 2023 09:56:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: badouri.g@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-gplRlPkuO7@https.bugzilla.kernel.org/>
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

--- Comment #1 from badouri.g@gmail.com (badouri.g@gmail.com) ---
Hi there,

I'm running linux 6.5.11 on a  Asus ROG Zenith II Extreme (TRX40) with a AMD
Threadripper 3960X and the amd-pstate driver refuses to load due to missing
_CPC objects:

[    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI
disabled

However both CPPC and AMD Preferred core support is enabled in the firmware.
Also I can confirm there are _CPC entries in the ACPI tables.

acpidump > acpidump.out
acpixtract -a acpidump.out
iasl *.dat
grep -i cpc *.dsl

ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control
ssdt7.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performan=
ce
Control

Any ideas why the driver cannot find them?
I could upload the dsl files somewhere if it helps.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

