Return-Path: <linux-pm+bounces-1202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8AF81473E
	for <lists+linux-pm@lfdr.de>; Fri, 15 Dec 2023 12:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50EFEB21237
	for <lists+linux-pm@lfdr.de>; Fri, 15 Dec 2023 11:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A512224B52;
	Fri, 15 Dec 2023 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6/lvmum"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8960E2555B
	for <linux-pm@vger.kernel.org>; Fri, 15 Dec 2023 11:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1385EC433CA
	for <linux-pm@vger.kernel.org>; Fri, 15 Dec 2023 11:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702640807;
	bh=MaUigJ61RVevT3FZsCJYmvoNnK+i2vlev1rG1zTE+BU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=D6/lvmumF8wPbiPLnbPXS2HrgTyUrO7szcmPWRgcEpIHxGHnmWjanqR0Ujm4kaWiX
	 aBrdqP3Oo0qf4UefUAGqyKlkg2nco+MOspzghjPs/Bwr+2x38NCOjZjyrWIUGzWoVs
	 BbycnPWp/NA8JOA45XwIpbWI7UDN4ZRiATb+nUd6KFalNYrHIlMO1478Tr2b0M6hq+
	 aIAUiu+06hh7clfHDD9KX5GdtKmrQtHzcGvJOQjTjykHWxaGYaZyPSy74Y/b8dLxp3
	 qxjWYmmmKSnguwgsuQq5Liw0FLlbgNkP8ZFJfMcWj4p0xzlnQYCcPsk82wobnSWDlb
	 NbuOiX881G7+w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EA6F8C53BD2; Fri, 15 Dec 2023 11:46:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Fri, 15 Dec 2023 11:46:46 +0000
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
Message-ID: <bug-218171-137361-PYbVzqEVPe@https.bugzilla.kernel.org/>
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

--- Comment #21 from Gino Badouri (badouri.g@gmail.com) ---
Thank you Jan,

I hope this gives the developers some more information to digest.
I've reached out to Asus with a full report and a link to this thread.
However I doubt they'll look into it, as the sTRX40 platform is discontinue=
d.
I'm not export on ACPI tables at all, but I'm wondering whether it's the
mainboard vendor to blame for this.
I believe the "AGESA" firmware which is part of the bios is responsible for
setting up CPPC.
And this firmware is provided by AMD to the mainboard vendors.
For sTRX40 (which only lasted one generation), the latest version seems to =
be
1.0.0.4.
Perhaps this version is too old and doesn't provide the necessary
info/specification for the ACPI tables.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

