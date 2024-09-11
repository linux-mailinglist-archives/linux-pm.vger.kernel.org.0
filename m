Return-Path: <linux-pm+bounces-13980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 620D7974921
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 06:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B781C2416A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 04:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBB22D057;
	Wed, 11 Sep 2024 04:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8j8pwNb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DA48BEE
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 04:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726029147; cv=none; b=YZHQ42sdKlVwpzWBIK74TOp0V11v/FLfE1HUpk1C1UY1D38A9kaWktsFfwdsNMzT+qinkwNm124tMeFLs6Vmkst/iD3udIznwUC/pBcgo3WrRHJKcDBXuw7W0nMMdkxD0ZP+wVPBCOy3iihBgpHBWDrP+55lrj6XTjQryj5vw+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726029147; c=relaxed/simple;
	bh=aN8iRNCMBvNxvcsc5BzRkg11Lh8EoBvJr2vMfsqOPtk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IS4VwsbQ+oeqQP04Q8O1WL/X2vlhxE9OiofjRdJWnPi9xVNewEk9Lqha4v+fbrP/9VjpWRQCUjSqK2J9RHHLht1IBYzletWAXa8w2yDuA06EAmmYlizH4UYowQkvn+cXJ87+Du4qMbzoqDw0tIgvnLAd4LdYcYNtHNPO44uRY1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8j8pwNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B30FFC4CED2
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 04:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726029146;
	bh=aN8iRNCMBvNxvcsc5BzRkg11Lh8EoBvJr2vMfsqOPtk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=j8j8pwNbbx5YM4ZQ3vfgMbj0xKIyZ3CyKM6p8JwLqynIU+3Be4abcyNAEXLi350Fr
	 Uy5fpuPy77AGExMaZv7HXK18GYQsMQYZmiurBY7LgtqIBlWGs58/42Deo34VJHBHFC
	 BbxQPDNl9oofu7yGgyqSHGbPmuARPL+ty7vmhBJcbsEj+SgBSGBlM7nYnIdcFpEFtl
	 60TDdC1bBZQSODDBB8WsC/ZjAFfVVFNOLqjaT+6SA0vzq+IgvgvuUfhMN2G+oh4Xp2
	 nMi4FCf/r7FSLph2/yVqXbvW2dmBouQs5/HuMZvohpue4/2v5TKEWKvlxgPDw8H791
	 IeY9G6ty0cXPA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AAEBFC53BB8; Wed, 11 Sep 2024 04:32:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 11 Sep 2024 04:32:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: xiaojian.du@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-obMAVPwbmc@https.bugzilla.kernel.org/>
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

--- Comment #97 from xiaojian.du@amd.com ---
Thanks for all of you guys.
This thread will be the reference for the similar issue on many other OEM
devices.
Checked the background, it seems ASUS always uses a different palce to store
pstate info.

like this commit:
[PATCH v6 03/14] ACPI: CPPC: implement support for SystemIO registers
From: Steven Noonan <steven@valvesoftware.com>

According to the ACPI v6.2 (and later) specification, SystemIO can be
used for _CPC registers. This teaches cppc_acpi how to handle such
registers.

This patch was tested using the amd_pstate driver on my Zephyrus G15
(model GA503QS) using the current version 410 BIOS, which uses
a SystemIO register for the HighestPerformance element in _CPC.

https://lkml.org/lkml/2021/12/19/90

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

