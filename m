Return-Path: <linux-pm+bounces-7120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA2E8B2816
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 20:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D95E2828DB
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 18:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A021514C6;
	Thu, 25 Apr 2024 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n68zaVIr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2FE1514C4
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068921; cv=none; b=MHgfWXIEKyG1BEkj2cySTTyXKu2BvontYmcujSuVoB2sERfPKVYfXNRV2rFBqCUJuWgzAiAhuNmzO0HQLuDyGU5EncvVQFRtxa8HI+1eBya7EIQaGAN48CaRsysgUjmT70Z4PUWDOIVB/qExa3A9KzDpwO4gZ6m9UvQcdVSp1oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068921; c=relaxed/simple;
	bh=uXMmsb4p7DTew/rARnU7r7GTJtNUG2bQu5F+fa72NLw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vB+hyp1uZm1u2M8fK4Yk9Y1vh3B+oekZATT3qh40ZRs/LzAjbL0KNwJ49pR4UyNcmyoOb1m4XmAMqU9KS+2igyL/ijR261IYBSEUIcZit8ECx158LlqCNjabmJ3gk3gHqy5Bi9NgDf/3rlttl0vZTXfd4MFaCLPICBYZmzYZaYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n68zaVIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2134DC2BBFC
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 18:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714068921;
	bh=uXMmsb4p7DTew/rARnU7r7GTJtNUG2bQu5F+fa72NLw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n68zaVIrM1mEczmx+JqREWg3Z+6a17AGr6IDZYSWSqExexuSO8vDu5LOuFZE5Jjlk
	 h/TqEMOh8u2U4NY+dbx//5+lv7n0+zq3CSSczyQ9xUDNOA8aggeDn3n96PPO22m3xJ
	 aCyfBueJluJc+X1IfM+R3HgspII7rRkLqQKYrg2Mzg8dxTgUS2C8imoS12FgwyW9Xw
	 K3Ysb0+vOuUg5X7Q4QfO1/2ih1Yr8TqGP2Z8p4SXPFMzDrTuswpcfyy5CroivgQ5a1
	 05p4Tm7rSjYwh1GNMoQvDckfvuzXSkOJrvPEFl+gLSxYCmRifaFPbMo3PkToNZ3+99
	 FIEaNJ/GsUtEg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1A018C433E3; Thu, 25 Apr 2024 18:15:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Thu, 25 Apr 2024 18:15:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gahabana@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-R8WCNE8JMg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218759-137361@https.bugzilla.kernel.org/>
References: <bug-218759-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

--- Comment #9 from Gaha (gahabana@gmail.com) ---
hi , thank you for the suggestions (@Mario),=20
    I've just tried that as well. Single core workloads still do not go abo=
ve
'basic' speeds. In addition to adding 'amd_prefcore=3Ddisable' below i've a=
lso
tried adding explicitly to kernel command line amd_pstate various parameters
(active, guided, passive) 'GRUB_CMDLINE_LINUX_DEFAULT=3D"amd_pstate=3Dguided
amd_prefcore=3Ddisable iommu=3Dpt quiet " with no change in behaviour
zh@muc:~$ cat /proc/cmdline
BOOT_IMAGE=3D/boot/vmlinuz-6.9.0-rc5-zh-250HZ-amdpatches+
root=3DUUID=3Ddc0bb664-2e43-421d-bd28-96d0332f030c ro amd_prefcore=3Ddisabl=
e iommu=3Dpt
quiet
zh@muc:~$ uname -a
Linux muc 6.9.0-rc5-zh-250HZ-amdpatches+ #5 SMP PREEMPT_DYNAMIC Thu Apr 25
11:45:21 CEST 2024 x86_64 x86_64 x86_64 GNU/Linux
... (In 2nd session am running 'cat /dev/zero >/dev/null')
zh@muc:~$ lscpu -ae
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4350.0000 400.0000 1815.3290
  1    0      0    1 1:1:1:0          yes 4350.0000 400.0000 1724.5240
  2    0      0    2 2:2:2:0          yes 4350.0000 400.0000 2156.9199
  3    0      0    3 3:3:3:0          yes 4350.0000 400.0000  400.0000
  4    0      0    4 4:4:4:0          yes 4350.0000 400.0000  400.0000
  5    0      0    5 5:5:5:0          yes 4350.0000 400.0000 2050.2410
  6    0      0    6 6:6:6:0          yes 4350.0000 400.0000  400.0000
  7    0      0    7 7:7:7:0          yes 4350.0000 400.0000  400.0000
  8    0      0    0 0:0:0:0          yes 4350.0000 400.0000  400.0000
  9    0      0    1 1:1:1:0          yes 4350.0000 400.0000  400.0000
 10    0      0    2 2:2:2:0          yes 4350.0000 400.0000  400.0000
 11    0      0    3 3:3:3:0          yes 4350.0000 400.0000  400.0000
 12    0      0    4 4:4:4:0          yes 4350.0000 400.0000  400.0000
 13    0      0    5 5:5:5:0          yes 4350.0000 400.0000  400.0000
 14    0      0    6 6:6:6:0          yes 4350.0000 400.0000 4315.7319
 15    0      0    7 7:7:7:0          yes 4350.0000 400.0000  400.0000

I hope this helps ?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

