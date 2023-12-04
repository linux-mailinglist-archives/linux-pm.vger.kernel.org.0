Return-Path: <linux-pm+bounces-659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE09802B53
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 06:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BB91C2091F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 05:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425CF1873;
	Mon,  4 Dec 2023 05:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMA3nHWt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73115A4
	for <linux-pm@vger.kernel.org>; Mon,  4 Dec 2023 05:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E3DBC433C7
	for <linux-pm@vger.kernel.org>; Mon,  4 Dec 2023 05:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701667918;
	bh=OPYCgBDMWPmFGDuVLNbcLd2LqhqMrNPdOXSXINceyVA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iMA3nHWtaBSsDBw/iV123lAla0SOrQe14Gu0fqnjuiLviKVjX3DN34RuA+Oaictpd
	 mJfYey/EF2JJPI4Aom1kGc30HnWAFxWhZPQkPd4/xAJR1b03Zcb0szW2g4PNYTz/yG
	 z0R8T3XftRcVZ1fanbXbY9q3IhkDjFfCVvEo8uCJgNSVXvOm1M3+W+jTuT48b3sgun
	 ccZh5C20usxv2C1ZBIMfT5q3WZkQ+iHpU+KyFZwwaViBY5pGKmeuQikU3zDOBTGFj4
	 5roreEhia9qggj1eYSJBhqkLmSFvuwGTauSlG8j2mH1PSYJmRA6VKTpGU8B2Ozg86f
	 57CBePA1JZFvQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 739B9C53BD2; Mon,  4 Dec 2023 05:31:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Mon, 04 Dec 2023 05:31:58 +0000
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
Message-ID: <bug-218171-137361-o4exqVOBfK@https.bugzilla.kernel.org/>
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

--- Comment #14 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Gino Badouri from comment #13)
> Hi Perry,
>=20
> A little offtopic I guess, but are you saying the acpi table is not compl=
ete
> or correct?
> Because when I tried Ryzen Master software on Windows a while ago, it was
> able to gather all of the performance metrics.
> Does it rely on the acpi tables as well? Or does it use a different
> method/interface for getting the information?

Hi Gino, I was told that you can try the latest BIOS and check the CPPC
function again, if the CPPC is still not working, you need to reach out to =
the
board vendor for technical support, it is a BIOS issue, driver side can do
nothing for this.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

