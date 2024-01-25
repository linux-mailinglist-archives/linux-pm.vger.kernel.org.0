Return-Path: <linux-pm+bounces-2735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DE983C4F9
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 15:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4434D2934F8
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3329E6E2BB;
	Thu, 25 Jan 2024 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRdDQztu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC24F218
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193561; cv=none; b=DYvyTWvk3IpUHDbD8KbjgCKoG3HiJErd/cS2e1Y/BNerIHDtQSHd1mxRlSU9jMmibkdLIoH3TJCtOxwQXWlzzv/t1EoXULhjzAfH5kahWft1ZKNAHV5wP+54eQu3jtbZDag3EaZD1iP+j6F97svllo0w3/dLfA59wD7i+mkXJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193561; c=relaxed/simple;
	bh=hYWvfGPzZZcKHssrfuDWgXp1RFaRYisBA6wehzEvXTM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bgi479Sk9UMoQShd2VEmmB9NKkm0K8XwY+eCFh6/jSLRIKworyU7cRacWhAQx+crl94+7iZZol2/Aomef0urGKjd7AYXe8tcAmCzrKhfJwWvVjvyl4J82/SePahroNEA90w6Wz+hmeG7IDzIsmFHflxEddX7Uls++Iok5R3ykx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRdDQztu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 827B7C43399
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 14:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706193560;
	bh=hYWvfGPzZZcKHssrfuDWgXp1RFaRYisBA6wehzEvXTM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kRdDQztuTvIgHRKQO4KWpCTPwjh0pQQ7eOgn8I5omfnPrqqZvWInpbEcahDPGCODS
	 loVdHjXBwoNfIqeke5LqN0BwmClQwi+qYP1DiGZenU2ZYFp8gxWJvl6Y+6fkYROE7b
	 BYnW50QPO0/Y98Fp++cAnfv971ZeJ/iPr6657k6NN/EpjBAYcvv4DERrm/4MJqLRnD
	 GJ114xaSFOjyRpOvzQGfX4YIy6VjDSww73d3/Rm7cI0f5i472QfsCfan4amCubsreQ
	 O1nkCJt0G1zOtn2zmzlMtG6OvWH39OUv99+lZ/BXQ48a3WyRuRq9aD39RMW/5f4Cip
	 s8qYXhmANrR2w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7014CC53BCD; Thu, 25 Jan 2024 14:39:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Thu, 25 Jan 2024 14:39:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: badouri.g@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-YAYQcnkLYq@https.bugzilla.kernel.org/>
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

--- Comment #38 from Gino Badouri (badouri.g@gmail.com) ---
Here's the information with amd-pstate in guided mode:

Kernel: 6.8.0-rc1 vanilla + your patch
Mainboard: Asus ROG Zenith II Extreme (sTRX40)
CPU: AMD Threadripper 3960X
Bios: 1802 (06/09/2023) CPPC and CPPC Preferred Core enabled
Kernel command line: amd_pstate=3Dguided


# dmidecode 3.4
Getting SMBIOS data from sysfs.
SMBIOS 3.2.0 present.

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: ASUS
        Product Name: System Product Name
        Version: System Version
        Serial Number: System Serial Number
        UUID: ebcd3b7e-9734-32f6-6752-3497f631a402
        Wake-up Type: Power Switch
        SKU Number: SKU
        Family: To be filled by O.E.M.

Handle 0x003E, DMI type 12, 5 bytes
System Configuration Options
        Option 1: Default string

Handle 0x003F, DMI type 32, 20 bytes
System Boot Information
        Status: No errors detected


# cpupower frequency-info
analyzing CPU 0:
  driver: amd-pstate
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency: 20.0 us
  hardware limits: 550 MHz - 4.78 GHz
  available cpufreq governors: conservative ondemand userspace powersave
performance schedutil
  current policy: frequency should be within 550 MHz and 4.78 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency: Unable to call hardware
  current CPU frequency: 4.39 GHz (asserted by call to kernel)
  boost state support:
    Supported: yes
    Active: yes
    AMD PSTATE Highest Performance: 166. Maximum Frequency: 4.78 GHz.
    AMD PSTATE Nominal Performance: 132. Nominal Frequency: 3.80 GHz.
    AMD PSTATE Lowest Non-linear Performance: 60. Lowest Non-linear Frequen=
cy:
1.73 GHz.
    AMD PSTATE Lowest Performance: 20. Lowest Frequency: 550 MHz.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal freq=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
3801
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal perf=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
132
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dhighest_perf perf=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
231
166
166
201
196
191
241
241
236
166
166
226
166
166
166
166
231
226
221
216
211
206
221
186
181
176
171
166
166
201
196
191
241
216
241
236
166
166
166
166
166
166
211
206
186
181
176
171
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest_nonlinear_perf perf=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
60
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest perf=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20
20

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

