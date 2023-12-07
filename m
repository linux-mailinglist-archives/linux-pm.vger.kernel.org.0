Return-Path: <linux-pm+bounces-772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F6A808066
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 06:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C14B20D3F
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 05:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7711103;
	Thu,  7 Dec 2023 05:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFPBpect"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937AF134AC
	for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2023 05:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0ACEDC433CC
	for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2023 05:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701928353;
	bh=cg1GUCWPQnhCx5qMC2rAQS1ni42/zAtl5FRLgJ4fJ4A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AFPBpect6OUlbVt284UJSODvTLCB0jOvjGDYdRsT5+yHpu3nOofeIdmdWlMASYjrA
	 nem8CQONnfzamsXzJd9xCX6PT88EBxjl9dx8PcquL5CJdEok91rlB9BZn+QGd280bL
	 crmh3vtGVkz+yUMv1/NNSvX/Asqsxwes6WQZI7fR7MDceWpXc0/7CzGjJ+5Z1b9c2h
	 xqQMo9AQ888JmYQIWFFqvmKvTQe+nTwiaYteHLtvWkaXOjzKKRdF8JOLw3wFRndhOX
	 rkJHFp1LgO4jqcyreZo8fkMK2hfjOExllQFf62OhdHOzJtn+niPyNA2sjDLwTBLGSp
	 A07RHyFGH7XXQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E3560C53BD3; Thu,  7 Dec 2023 05:52:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Thu, 07 Dec 2023 05:52:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ozin@itu.edu.tr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218171-137361-ZnG7aGtoHZ@https.bugzilla.kernel.org/>
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

Mithat (ozin@itu.edu.tr) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ozin@itu.edu.tr

--- Comment #19 from Mithat (ozin@itu.edu.tr) ---
Hello Everyone,

I dunno if its relevant but my observations regarding the problem are:

As far as I understand, AMD CPUs declares CPPC via CPUID intruction.

1) cpuid 0x80000008 (ebx) CPPC bit is always 0 (disabled) whether you enabl=
e or
disable CPPC in BIOS.

2) Asus AMI Bios does not have _OSC declaration for CPPC support in DSDT and
SSDT tables.

3) There exists _CPC declarations in a SSDT table but since CPPC support is=
 not
declared, it is omitted by Linux kernel ?

Hence, amd_pstate module declares "the _CPC object is not present in SBIOS =
or
ACPI disabled" ?

Hope it helps.

Mithat

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

