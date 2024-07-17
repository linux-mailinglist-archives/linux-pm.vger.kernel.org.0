Return-Path: <linux-pm+bounces-11213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 046BC9341AB
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 19:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B9528407D
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924CB181D1D;
	Wed, 17 Jul 2024 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcXeuuM0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C04F181B9A
	for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2024 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238567; cv=none; b=fiB1eyq3dKL8qLCtlbjSwX78TDS0tMddtTY5RvjzVV6AlvvDYtq/xTA8aYJi2ovSr4HXAxGXmbe9q5xkT4f8WQ7or/ialJpYYkiSItrPpZ+xsQ9qMu18twFeT4j81SAwBjK14fRqOfoIdDPxamIYTGUfGTGNH/WqeqXFuCYX2sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238567; c=relaxed/simple;
	bh=PREtBEgB3Qx7Wk5O+qHG1TU5IShcOnMAx73+X//LA+8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jkdIKfcef/15XXyA6vthEbHYs+NcQPpXUSJmqBseor/x9iW1JkW+AH1gGmDCY+BPHTT6fX2ayX+vrKlITQCi56Lp1pWzltw0Sn1mOwYE8yldMvUsp00wWLCfhovAGr8mNk4iUZ/S6ddQ6AKglV9ZR602J0VpodFy/YbgBnDgkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcXeuuM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F154CC2BD10
	for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2024 17:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721238567;
	bh=PREtBEgB3Qx7Wk5O+qHG1TU5IShcOnMAx73+X//LA+8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QcXeuuM0/YdZQFfORxAtZ0cduupgLb3j9uJZWROtGdA+GP5nxIO/VQmyhOtzXdWHC
	 27uB7Skba/NlEIeaSVWDPXqT+No6B1WQ+oDTQcCnCCKsSK/3rhO9RnqxRz6/fkhkYH
	 lj5YOFTjzxlFJBB1LjY5IE1932sZ7MbUgOx729tDTZRJJA92jKNZr5L51WMqDC+vcj
	 3Jn+sjzgUb/RnGu04h9zw5FJq9HupcgHc5Gthi55RhT17ARqqzLbvFSkjwWOF+pwUx
	 qTsYij+XQ8jXtC+Y2k7m5jAgXqfeNBfBy37mKYNIEXMWV6g4PyBnonp3I3ZzOt/IKC
	 i7bz3QY0KsAKQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DBC3CC53BA7; Wed, 17 Jul 2024 17:49:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219051] amd_pstate=active reset computer
Date: Wed, 17 Jul 2024 17:49:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: catalin@antebit.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219051-137361-w0CzHoprVc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219051-137361@https.bugzilla.kernel.org/>
References: <bug-219051-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219051

--- Comment #3 from Catalin (catalin@antebit.com) ---
I already have the latest version of bios.

It's a laptop with very limited bios settings, undervolting is not one of t=
hem.
Pretty much is default, secureboot activated, disk encrypted

I got some errors in dmesg:

[  864.970948] asus_wmi: fan_curve_get_factory_default (0x00110024) failed:=
 -61
[  864.972365] asus_wmi: fan_curve_get_factory_default (0x00110025) failed:=
 -61
[  864.973533] asus_wmi: fan_curve_get_factory_default (0x00110032) failed:=
 -19

I have them on other laptop with 24.04 and no issues

and

[  864.511925] systemd-journald[638]: File
/var/log/journal/9ce66a6c7ebf406aa908624aafc66e86/system.journal corrupted =
or
uncleanly shut down, renaming and replacing.


I agree it could be a HW error, but with amd_pstate disabled I have no rese=
ts
.. at least for 10 hours..

If I can give you more information I will.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

