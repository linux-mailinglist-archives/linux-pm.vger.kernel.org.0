Return-Path: <linux-pm+bounces-668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1436802F01
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 10:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563FD1F2029D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 09:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13431C6B0;
	Mon,  4 Dec 2023 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djDx0jvO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53471C6A5
	for <linux-pm@vger.kernel.org>; Mon,  4 Dec 2023 09:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4180BC433C9
	for <linux-pm@vger.kernel.org>; Mon,  4 Dec 2023 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701683008;
	bh=ED6vo/IzLoo0vmwDoIj3V9POeixeZQvnI0KOKUA2Av8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=djDx0jvOJqIZ92hzvzQM5qSU+0vThVcZxaQF43yYbQ/Fe9f0smQpZphANuyo/blWl
	 Lg3rpBVCZf7MuB51aqsEr1Xb7zggzGQzCxdYtXNTY0H18dpXTyGAJqWaA/gr1T7FGD
	 Ud5RNXo6YdJ99j+ChsAZ7Qg8AjmuSZBa925wM1C3laKoQkxUdfMkD/nXfgAvg5B5DT
	 x50Dy2z9oT4xX3j3mH6MC+9e8iZM3QOox85M/cA+19HjsNtEdDxkeqCB5RbYSlh7rw
	 7lgHeMh/iqxyTs6P5WGw3SjG11UmskgfZ+bzoU7bZ3oBI+8antD8rfvJrCM/XYZKlD
	 7no570GRtnX6Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2D659C53BD2; Mon,  4 Dec 2023 09:43:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Mon, 04 Dec 2023 09:43:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-6bZsKcnQNw@https.bugzilla.kernel.org/>
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

--- Comment #18 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
 (In reply to Gino Badouri from comment #17)
> Thank you Perry,
>=20
> I'll contact Asus support and see if they can do anything about it.
> For other users having the same issue.
> Please make sure you have CPPC and CPPC Preferred Cores enabled in the bi=
os
> settings.
> You should be able to find it somewhere in the advanced settings under:
> AMD CBS > NBIO Common Options > SMU
>=20
> Also please share your ACPI tables, so the developers can verify them:
>=20
> fedora/redhat:
> dnf install acpica-tools
>=20
> debian/ubuntu:
> apt update
> apt install acpica-tools
>=20
> how to dump your tables:
> acpidump > acpidump.out
> acpixtract -a acpidump.out
> iasl *.dat
> zip -9 acpi_tables.zip *.dsl
>=20
> Then please attach your acpi_tables.zip to this bug report and share your
> mainboard vendor/model and bios version.

thank you Gino as well, let's know if you have any questions on this.=20
You can check the CPPC table with vendor if they confirm the CPPC is suppor=
ted
on the board.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

