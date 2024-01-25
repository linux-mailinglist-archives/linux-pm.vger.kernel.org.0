Return-Path: <linux-pm+bounces-2764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 168DA83CB4F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 19:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF381C228DB
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 18:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8811EF18;
	Thu, 25 Jan 2024 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJWMSnAz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D72537E3
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208082; cv=none; b=bWKAfSR46NfJKbKKmLk5bI7Cfz6BHGIiv9XpX2sNS2jdn+wQdEKcuHumD597Ygm8wICRULOpb3AfkYelwNsueC/4PfQyKwwgQrQhqV/KZdzmNoGvXPIp1BiI9KaAtd9CafH45pGmiSvX3R13cwaJzs2ovxTJ0i34uAB7yvhBlJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208082; c=relaxed/simple;
	bh=rS7nOBovj1WqICoa3f5ENOD+0tEJ9Wgp8gE+65oK07o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VBfvlYMmZrA4aI93/C39t3xNmKi1SBPIVhOup2ug0jViquHivqSGO4JKNREW0bJPyaYScatP/7MmU6vFHcmQMiMRC77NyoTHCnQ8kuKyu6r8j+JcP9mxtv4T+kstrIruaZnHt0oVpu+JjN5AaldSoy89Hb8HIe7C+6fGsli5g1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJWMSnAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99963C433A6
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 18:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706208081;
	bh=rS7nOBovj1WqICoa3f5ENOD+0tEJ9Wgp8gE+65oK07o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sJWMSnAzyMR4TgKQbLHbxPdxtJYeD2RZE2hoOJxPiHeYjgzSBbpRpVHNncz+G8D6c
	 e88rhJHhQgSgkfIDKJbycY7D1Fo+94Znr7VTmanSGFEK1HIkM/rUeWmSGP0VAg5AKV
	 sjxOKDIZGJo5exe2JDbzrNVowE4bZ6zhk8uhphDrNgfpbFPUgf7yF1etipxWplzsgT
	 sK9BGo6k74sC3OXKHvqad5zRGfx/yA/gzwLcoqZFoq7uzb7wVnFDoSizS8pX8+f6lA
	 nEUId3GCzZufVncFe3RQdC7oFkf6UIfMLHxIUT8hBzjmkno2BO8diDjlNEc0Y8tfOJ
	 jvnBfgUIgwPyw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 83DD3C53BD1; Thu, 25 Jan 2024 18:41:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Thu, 25 Jan 2024 18:41:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pnascimento@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-g0xf89NpSD@https.bugzilla.kernel.org/>
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

--- Comment #39 from Pedro Nascimento (pnascimento@gmail.com) ---
Happy to report it is also working on mine.

# dmidecode 3.4
Getting SMBIOS data from sysfs.
SMBIOS 3.3.0 present.

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Gigabyte Technology Co., Ltd.
        Product Name: TRX40 AORUS PRO WIFI
        Version: -CF
        Serial Number: Default string
        UUID: 032e02b4-0499-05fa-cd06-fd0700080009
        Wake-up Type: Power Switch
        SKU Number: Default string
        Family: Default string

Handle 0x0006, DMI type 12, 5 bytes
System Configuration Options
        Option 1: Default string

Handle 0x0007, DMI type 32, 20 bytes
System Boot Information
        Status: No errors detected

analyzing CPU 0:
  driver: amd-pstate-epp
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 550 MHz - 4.55 GHz
  available cpufreq governors: performance powersave
  current policy: frequency should be within 550 MHz and 4.55 GHz.
                  The governor "performance" may decide which speed to use
                  within this range.
  current CPU frequency: Unable to call hardware
  current CPU frequency: 550 MHz (asserted by call to kernel)
  boost state support:
    Supported: yes
    Active: yes
    Boost States: 0
    Total States: 3
    Pstate-P0:  3700MHz
    Pstate-P1:  2800MHz
    Pstate-P2:  2200MHz
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal freq=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
3701
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal perf=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
135
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dhighest_perf perf=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
166
216
211
206
201
196
191
241
241
236
231
166
166
166
166
166
186
181
176
171
166
166
166
166
166
166
166
166
166
166
166
166
166
166
226
221
216
211
206
201
196
191
241
241
166
236
231
166
166
166
166
186
181
176
171
166
166
166
166
166
166
166
226
221
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest_nonlinear_perf perf=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
64
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest perf=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21
21

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

