Return-Path: <linux-pm+bounces-32113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24196B1FE7D
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 07:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6717E7A9577
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 05:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5723B1E2858;
	Mon, 11 Aug 2025 05:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWK552xr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3326C14F125
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 05:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754889642; cv=none; b=Y5JydubV5g3Z9LRY68RuYfRE/afsJ0bl4Wepe/RknpIhmTu8Evl/Yka6aqw5HNufMQOTX/oaRyeIPkcwHaLXmo2ajgFtOsaEOL0/JwVLosqXuT0+tB/dmTu/JsZf0uCBTfaAu75w9U6LWwgPwFKDvEYehMobF2PKZZb+hNNmYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754889642; c=relaxed/simple;
	bh=WG4R5v3coyDvwx6WElYxgIWKdvMB7MF+p6LxjG/e3Qo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t9rRXrMvuqThiipheqR3HFbEa2RU2NxMOlq9GHOh3HGSPolsQ/THhF3pUw+vxdBdNlf4jeHrTU0d1M4D2t4fEv2XP8lY8cLf0WjHOSlhpVKhXTjAhZO4nKjpWaoQ0R+agfPsWSoIzlz4Qo2V5tuHSDTWU8m8ErsRATfHPtTz6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWK552xr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAAD9C4CEF5
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 05:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754889641;
	bh=WG4R5v3coyDvwx6WElYxgIWKdvMB7MF+p6LxjG/e3Qo=;
	h=From:To:Subject:Date:From;
	b=QWK552xrbmGelObaYALqwpQyuFq/jbZ5WAbCI4HYbFV0RF+eM9ozsSjapeXNT6STW
	 q5kWEA98jYgfVhm38a4Jf05T8mBFbMl7amS9yMNDj8muz6fbu8OpkiQAAnoUZSmp8d
	 3a6X2J1cCYOGLLvlvcwWBJvcs6QK9McRCrniSWpUNtdKl8gROqtCWqF4lnW070Iwq4
	 AQokbOhq6jJdjk+z8zYDrzgqx/Ci4XLR34lzUsm/Qop52YDSAkIiUrwE0Gn405Kicg
	 in93B/QsvflFRxWMsvZo/t6+zG00hX1Jn7IO1OQm9+0FjfJc0Kec78I1BlLfLCpr7x
	 goc6OTbJQ15Yw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9E59FC41613; Mon, 11 Aug 2025 05:20:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220433] New: Regression on AMD pstate cannot control turbo
 boost after wake from suspend
Date: Mon, 11 Aug 2025 05:20:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: me@gzgz.dev
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220433-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220433

            Bug ID: 220433
           Summary: Regression on AMD pstate cannot control turbo boost
                    after wake from suspend
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: me@gzgz.dev
        Regression: No

Somewhere between 6.12.37 and 6.13.3, after a wake from suspend,
`/sys/devices/system/cpu/cpufreq/boost` no longer correspond to whether my =
CPU
is boosting. Even though `/sys/devices/system/cpu/cpufreq/boost` reads 0, my
CPU is clearly still boosting judging from both fan speed/heat and `cpuinfo=
`:


=3D=3D=3D=3D=3D=3D
analyzing CPU 12:
  driver: amd-pstate
  CPUs which run at the same hardware frequency: 12
  CPUs which need to have their frequency coordinated by software: 12
  maximum transition latency: 20.0 us
  hardware limits: 400 MHz - 3.20 GHz
  available cpufreq governors: conservative ondemand userspace powersave
performance schedutil
  current policy: frequency should be within 400 MHz and 3.20 GHz.
                  The governor "schedutil" may decide which speed to use
                  within this range.
  current CPU frequency: 3.79 GHz (asserted by call to kernel)
  boost state support:
    Supported: yes
    Active: yes
  amd-pstate limits:
    Highest Performance: 196. Maximum Frequency: 4.46 GHz.
    Nominal Performance: 119. Nominal Frequency: 3.20 GHz.
    Lowest Non-linear Performance: 41. Lowest Non-linear Frequency: 1.10 GH=
z.
    Lowest Performance: 15. Lowest Frequency: 400 MHz.
    Preferred Core Support: 1. Preferred Core Ranking: 196.
=3D=3D=3D=3D=3D=3D


(the CPU's max freq is 3.20 GHz without turbo boost, with turbo boost it can
get up to 4.1 GHz)


I'm on `amd_pstate=3Dpassive`, not running in active mode because I want to
control the frequencies and turbo boost.


I'm trying to bisect but I failed to build both 6.13 and 6.13.1 for some re=
ason
:(=20


System info:
Solus 4.7 Endurance x86_64
CPU: AMD Ryzen 7 5800H with Radeon Graphics

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

