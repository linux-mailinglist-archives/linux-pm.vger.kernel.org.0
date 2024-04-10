Return-Path: <linux-pm+bounces-6141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BD989EA04
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 07:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3676E1F235FE
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 05:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D2A15AF9;
	Wed, 10 Apr 2024 05:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdyS5Cfr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A281AC129
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 05:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712728128; cv=none; b=ABPs/rw6YNpbKjQOQ3oIGHpcb0oVPNdij3M6rhrEzOP1TQah7ytvC5HLg8JVI9HfdKNKVmXQcQo7JpfSibMfeGFFtITanD+vmE7TeFGWKed9oKYSklN6Xaruc8c9XautvbCa+tvW6ah5cHsh9cu5fQ7Z/+fMqBN2J9GeYurz7ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712728128; c=relaxed/simple;
	bh=Gjqqvaiz8atseIKaaPOcv+OwcXTJgvW+6yvQP1WLoYQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=laOghGA3g4Ixndxa2OU8Wok1w6zAh/u+nQ8BgjXrpE+rREHaCoSBTV/3xjwHBgqt6IXVC9ZkfszJkyrvu32LdHKZ0ddrcLDme75FNO/drMpMAGpfMDTs8gc0sU/4klkiilCaYYAeKgJHnNDztRW1GjYqVG/JL35QQhQV/OHM0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdyS5Cfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FC5EC43390
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 05:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712728128;
	bh=Gjqqvaiz8atseIKaaPOcv+OwcXTJgvW+6yvQP1WLoYQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JdyS5Cfr08/uBQ+JbnAluv0sEM4smryo4vVRZDqgG0o7cqpcxJnqBqyPOo9Eq/WQ8
	 pPBrjHmPKAwPUPaRKBwiHfo6j0aq7hWvmN/3uYXOHYbWFZ4CLeIEkKtZHLneEjx2bf
	 csCCGj7JZs8Kbli8Y4WNpmXbSuJ4xAePhlpXMBa3nTFgAEB2RmrwEXzqlGDrUco/Ye
	 Wc/gvJfTbKpAlqbZ+coS4pNc5wJGlw6F2zvzIrr3BBWtCFjymIIuT+9D8JKp1e+00i
	 1Uw3kh3yx5SYogioaQl5MZTLihT7/q0suRw4WyVuubGeBw22kUr58NSMNFaZjstt1l
	 6NWr0zGV1rG8w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0D15BC53BD3; Wed, 10 Apr 2024 05:48:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 05:48:47 +0000
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
Message-ID: <bug-218686-137361-bG7ntWteib@https.bugzilla.kernel.org/>
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

--- Comment #7 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to al0uette from comment #6)
> (In reply to Perry Yuan(AMD) from comment #5)
> > Hi=EF=BC=8Cplease help to provide this output with below commands.
> >=20
> > # cd /sys/devices/system/cpu/cpu0/cpufreq
> > # grep . *
> > #sudo rdmsr 0xc00102b3 -a
> > #lscpu -ae
> > #dmesg
>=20
> Should I do this with amd_pstate=3Dactive commandline?

Yes, if your kernel is not updated to include the patches which make the
amd_pstate_epp as the default mode, you would need to add amd_pstate=3Dacti=
ve
commandline.

After you added the amd_pstate=3Dactive and boot system up, we can check wh=
y  the
EPP values cannot be changed.=20

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

