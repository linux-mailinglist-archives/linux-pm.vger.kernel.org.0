Return-Path: <linux-pm+bounces-13893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117B9971CF5
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 16:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6F01C211E7
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 14:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700291BAEDC;
	Mon,  9 Sep 2024 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIdtZvB6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2911531E0
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893010; cv=none; b=nKZhBNCc6nqPIh0ex3a6QvVvkLEql7NIcLAI24qKg14Jb9xR05qn8K/cG7dojE5R3iMVcaqJnJXEDkzW3rYiLda8WMk91dYWFzqZ7uX1JUPYXyjYLdpmXwq9GsvQDi4EtnsSyPrkZCuUi2j9cfCx0QnmNtlAYWPbwSmu0hMW8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893010; c=relaxed/simple;
	bh=gs7Yk1XWhf3Yq2Tz6KSBVhBHeXiOJ4g1D9ioiWjYsb4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o2cDpFv7xxuw1umKQRqrG5zQj+Yz46dAKn4u/4cxsLmpPN/eq4de3dyFTaL694fXBprVAKPjzgJtzqcqfCgDfyxbqcOulNOrBGqh0BBeLclGYPcsbPOiHSBksxlLb2S6bhMPSKC7OJ7XFvoZ9LzueDzJDB6cJNiD12Jciyu1HDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIdtZvB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C82A5C4CECF
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 14:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725893009;
	bh=gs7Yk1XWhf3Yq2Tz6KSBVhBHeXiOJ4g1D9ioiWjYsb4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bIdtZvB6bbg/RuIPoG6rrvE+KfWFa4TvQs8foN8cV+v9Z2d84X9ojD/EKdR2lNWYR
	 W7HgPE3TbrT/aL/JIYf1RSQI6+/PGQccHYBXIy4UywbKisQz6PNfKJJdj2oWy2y4Ii
	 KDQlVIrCYu/DZiT4l1un8bc31iG7CjD/J33sZOvedDv5RGX96m7nnKLgjM/e7K4RWf
	 ln7p7nVmyIZmp8ca+5sSA9gGrLhSZbqWFKZaOc8U3bB2cPjfDBQaQAQ07M9EOEbQTL
	 K9uKb1f3h4Fxbd8FhQRlUvYfmKP9yCzMVBvuk0tble6ePPWMcvDjlhIzgQriDFtvEQ
	 SIWzymN0lqg/Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BFA77C53BB8; Mon,  9 Sep 2024 14:43:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 09 Sep 2024 14:43:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-URl6oRFnRb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

--- Comment #84 from al0uette@outlook.com ---
(In reply to Mario Limonciello (AMD) from comment #83)
> @al0uette@outlook.com:
>=20
> Very interesting observation.  I did double check the ACPI spec and found
> this.
>=20
> '''
> Starting with ACPI Specification 6.2, all _CPC registers can be in PCC,
> System Memory, System IO, or Functional Fixed Hardware address spaces. OS=
PM
> support for this more flexible register space scheme is indicated by the
> =E2=80=9CFlexible Address Space for CPPC Registers=E2=80=9D _OSC bit.
> '''
>=20
> So yes I do think this 'direction' is OK to go, but it probably needs an
> extra check on the ACPI 6.2 version.  Something like this:
>=20
> if (acpi_gbl_FADT.header.revision > 6 ||=20
>    (acpi_gbl_FADT.header.revision =3D=3D 6 && acpi_gbl_FADT.minor_revisio=
n >=3D 2))
>=20
> Can you please spin your patch to add that and a proper commit message and
> then post it to the linux-acpi mailing list?

I don't know how to do that, can you help me? BTW I heard that AMD seems not
quite happy with the Functional Fixed Hardware implementation, is there any
performance difference between PCC and FFH implementation? If there is
noticeable performance difference, can AMD urge ASUS to switch to PCC
implementation?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

