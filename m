Return-Path: <linux-pm+bounces-13910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9A197248E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 23:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8000828556A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 21:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7F118A920;
	Mon,  9 Sep 2024 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaptyjHW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B905018951A
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725917516; cv=none; b=rpPJWhnHl52QAnocYdCds30tu8KvGaj24ieYcSF2QIefk8DP94Zyn3aDEBbD5bxzSj22wQhBqYszHeEWvrcq+riWiE3SYy/UNDNp5j3QezaXL6T7PvGBTQ5ITUOOnjgidwo63oqp9Ag1dzRWWwTOorpFKguj0bBlm62Wi97pNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725917516; c=relaxed/simple;
	bh=Rqs4rehwjX82I/WnALPvTV8oWOzsJuyL031ZHjnMDBU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vDaprUqJsjLAt1tM8P5J15EbRZpZt8q8Aphm5fdGq7TRxIQmv+1matRXBCd7IcZALBfBBRJK/SIliamW48UPKRVo7DSU8+4uGotFtKsRp2eS/kjB7hzq7mzl04mz53HOvin2o+HmyPpWhlaYGnY+j3dU0pcpyztd5LmgUuVH63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaptyjHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45FADC4CED0
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 21:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725917516;
	bh=Rqs4rehwjX82I/WnALPvTV8oWOzsJuyL031ZHjnMDBU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oaptyjHWqm0Kg+QOnod/pH3AYrvFjX2y9ZkEzakWf0uyRab/W+CnxxOJiNxdV2LKe
	 3TieguHDcgNEvgNgQ7kiPPcdl1xkSDvJoqOwzUg0Y1mXzICXqkOoHcxRFShyjxYsai
	 cS6WAnK2ZZMKUkipOp8hkurch7fTjMjz6kfrgz5spjQJV03y3LBTsdhb6Aw28eA6Iz
	 FAY4FJS//N/sokulEl8Qrg+WG1nEYHhnDPFlVVZDAj9qFyYwgGTJ1OFsdMwwNrz3tC
	 0idACl5VY3enmcwb+WvM52lYvc1vtyxyA06UnopLcC/EtksRQiChiuWfQpkWzds8IE
	 yNTSOUFz3T8vA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 409C4C53BC2; Mon,  9 Sep 2024 21:31:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 09 Sep 2024 21:31:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: vderp@icloud.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218686-137361-fU0U4B93Mm@https.bugzilla.kernel.org/>
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

derp (vderp@icloud.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |vderp@icloud.com

--- Comment #89 from derp (vderp@icloud.com) ---
after testing v2 of the patch on my
[   26.705565] Hardware name: ASUSTeK COMPUTER INC. ASUS Zenbook 14
UM3406HA_UM3406HA/UM3406HA, BIOS UM3406HA.304 06/05/2024

I found it to crash with

[    3.384772] UBSAN: shift-out-of-bounds in drivers/acpi/cppc_acpi.c:1117:9
[    3.384774] shift exponent 64 is too large for 64-bit type 'long unsigned
int'

the reason turned out to be: auto_sel_reg real type was ACPI_TYPE_INTEGER(w=
ith
value 0x1) and cpc_write isn't guarded against ACPI_TYPE_INTEGER value-only
registers and performs invalid operation

by ignoring auto_sel_reg entirely, I gained a working CPPC, which inspired =
v3
of the patch

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

