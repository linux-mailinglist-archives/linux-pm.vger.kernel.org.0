Return-Path: <linux-pm+bounces-5994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D5F89A844
	for <lists+linux-pm@lfdr.de>; Sat,  6 Apr 2024 03:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30195280E7E
	for <lists+linux-pm@lfdr.de>; Sat,  6 Apr 2024 01:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E225033C9;
	Sat,  6 Apr 2024 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbjJuc20"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3C22119
	for <linux-pm@vger.kernel.org>; Sat,  6 Apr 2024 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712367528; cv=none; b=td7ovpi7ms4GjxogE8j6k4OD/W/W3yMtDtnJ3kUeI1MIxPCNB0pHddOeBRujAAUiltHsO7LdHQ6PDAh69s6Gf4l4VKjla7i14drptem8qP/+peKMe1RpvPF+N6BycbK+RzhEtXX/SPCDm0RkWrdyG+ghghO9Nj5VHadsijFkf00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712367528; c=relaxed/simple;
	bh=lNUTfgM3lq1CicNGVvWyXq6R8VsyvvyrVbw81iNAY70=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VqNE40gDAhzySeEygUJpWGLWXRChtbujzIbpbPZ1iJ9Qac2POU51748kzTSiLOye5V+2+/FGFsbzt40+GHqlB5QKmDV/r9WY03ZW15zmRl2SAHekHebA/XqYNijntxL1D8VhGx352iPF/RCbP2E/uHUcsXQjlL+ntd5mvO8JmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbjJuc20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57CF8C433A6
	for <linux-pm@vger.kernel.org>; Sat,  6 Apr 2024 01:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712367528;
	bh=lNUTfgM3lq1CicNGVvWyXq6R8VsyvvyrVbw81iNAY70=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RbjJuc20fkPQ1KPo7CXCq83ucXiWfS/AMTtd70Fwt91reiHarRaIxT566CVioL5PW
	 5a5BOFL7m65nT9mr+smSyg/Dlv8L9DjKTwO1bW7SMoG5ykcWIVMAie1ZO9bHM/xyaU
	 qykYAEmYss8vrYaEC1oWjkRnnRQxNXSfPw74ed1Pk+yGYtViCmxgk5AwnbARiE9pzH
	 UrKQn+NL6K7ATvwBu/duzMPhsvKzv4rV9pl+TrLU4KVqJZOYD0WdIhHFOdTNTCTAC9
	 42EgR/idhEuOvnTrTktBEVFQanwQ9x9+RUsgYhS4JyCux4f+2fk+rpCgS6MG/mydou
	 PRJQ2H3V6WHkg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4CC75C53BD3; Sat,  6 Apr 2024 01:38:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Sat, 06 Apr 2024 01:38:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-GAcJBOdLlK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #56 from Artem S. Tashkinov (aros@gmx.com) ---
Here's my report for 6.8.4 and Ryzen 7 7840HS:

1. Setting scaling_max_freq works, cool, but you cannot go below 544MHz. You
can set 400MHz but the CPU will continue to jump to 544MHz, not a big deal.

2. Setting scaling_min_freq sort of works, the CPU _prefers_ to stay at this
specified frequency but occasionally drops to 400MHz. Then, the CPU doesn't
totally respect it, i.e. for values below 1.4GHz it stays around 1397MHz. T=
he
relationship is not linear, setting 4GHz results in the CPU preferring 3766=
Mhz.
Or 2GHz -> 1982MHz. Not a big deal. Unlikely anyone would want to set the
lowest frequency.

3. /sys/devices/system/cpu/amd_pstate/cpb_boost is missing altogether:

# find /sys -iname '*boost*'
[nothing]

So, my only remaining question is where's boost support? Or it's not suppor=
ted
for all Zen CPUs?

Thanks a lot for your work regardless!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

