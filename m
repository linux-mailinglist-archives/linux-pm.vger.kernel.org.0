Return-Path: <linux-pm+bounces-667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865D4802D7C
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 09:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FD71C209ED
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 08:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0792F9C8;
	Mon,  4 Dec 2023 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNYdhVmi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CE9F9C3
	for <linux-pm@vger.kernel.org>; Mon,  4 Dec 2023 08:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 694D0C433C8
	for <linux-pm@vger.kernel.org>; Mon,  4 Dec 2023 08:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701679500;
	bh=LR8vWftot8rJB7cM1/rcaXtzpN879FaBIFufuFnU19M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UNYdhVmigxrzKr62rkHQNlocqdXTfxXrhoaKX2Lg8awhwoUdLHfM08op4an93LnK4
	 YL9cuBKiolwoSeA4cu9f8cKVdLuZZ2sAqjevAQGiR3CFfLGAg5R1KAsSqFhAmgbgV+
	 WH7DMmO9n3OxgMmBQ0Qw5iSCpRRSUcx9vCTrZtk7RVGvwMLvkNkuamZJZtW9IyheZn
	 9h24P41q+/XS8zwAPFqglKsvjYiSL/Km4uY94HcYLUH4RduGz9EulyBDkoIVw+AQ9i
	 bKyvOzQoLg9xv+65mgEOsvssq9PcreXI9PhfopYOcXefhMvTi1t147fgnwCpY+8JD7
	 BbT9vn47bafnw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4C818C53BD0; Mon,  4 Dec 2023 08:45:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Mon, 04 Dec 2023 08:45:00 +0000
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
Message-ID: <bug-218171-137361-x2pVfaFetv@https.bugzilla.kernel.org/>
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

--- Comment #17 from Gino Badouri (badouri.g@gmail.com) ---
Thank you Perry,

I'll contact Asus support and see if they can do anything about it.
For other users having the same issue.
Please make sure you have CPPC and CPPC Preferred Cores enabled in the bios
settings.
You should be able to find it somewhere in the advanced settings under:
AMD CBS > NBIO Common Options > SMU

Also please share your ACPI tables, so the developers can verify them:

fedora/redhat:
dnf install acpica-tools

debian/ubuntu:
apt update
apt install acpica-tools

how to dump your tables:
acpidump > acpidump.out
acpixtract -a acpidump.out
iasl *.dat
zip -9 acpi_tables.zip *.dsl

Then please attach your acpi_tables.zip to this bug report and share your
mainboard vendor/model and bios version.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

