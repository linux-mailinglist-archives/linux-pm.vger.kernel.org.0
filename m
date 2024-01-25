Return-Path: <linux-pm+bounces-2720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B9583BD18
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 10:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA7A5B2ADBE
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA71BC41;
	Thu, 25 Jan 2024 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyWUUrqf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585781BC3F
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174486; cv=none; b=KF2O5DsAe4VLOhuYPRAnyDSWwoSZ9qrgZFYSVVlLHfuZ7KPF2tn7ZmWvvMjqeQYKgtJCWfVsJDv0mVKuLzvWLthstC6Q8poa5+aMBRIcR2lUZzETY84znSLAI+PNsnW2EcBgs2JNNBAosNYuaFFZyVNLs/1R1qc6hJqwGM3jVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174486; c=relaxed/simple;
	bh=l7MKXv+zQaHNxJ+1BuAS51uglInDZfrq10pazNAy3PA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=deHVygpCQelDiIgb96im0EGNZImZX9iZ27MgEcVkP1wHLpS6tsDY+5XqKAStMXo+rEdjLN2trt/3rNUPW2SmNQqWVq9nskKVLdTSueugC3LC0NewANYGOhDlwAWDh8jGh3/4UzygM9IzEnVE8VA9qV/vmy6kTWZyDhPmgNsE9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyWUUrqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEEEEC43394
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 09:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706174485;
	bh=l7MKXv+zQaHNxJ+1BuAS51uglInDZfrq10pazNAy3PA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HyWUUrqfwQ9k0mnmN18DDQME+xeusPJ2SwhRtcL7G7vPvZDgluawWsUomvma6xEhZ
	 6wet15Hfj63Qo7JqItyMaydRmId3gr8+wiYlOP2KcFNw+4aYf1wufSW4/hjpabrla0
	 JDctRDMsqWPRdfCp4o3io4VKK46XSUXqhINsi7hyROurjsWNttC1kdclX+746xnom2
	 846L8VYAA9FEmN9pEustHVHWs8bmqXt8RJ2qTvDBjUcgS8R3kS+s18Xma5H0lEBbeE
	 7I2UYM3blXdC23Ouf0t+HtlNEhnWs2PCZFI3ZtF9uOKbeqDTND+sMFjLLlDXqGLH/3
	 rCDrMsg+DiVEg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CE9F1C4332E; Thu, 25 Jan 2024 09:21:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Thu, 25 Jan 2024 09:21:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ozin@itu.edu.tr
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-1bOsS23Rmv@https.bugzilla.kernel.org/>
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

--- Comment #36 from Mithat (ozin@itu.edu.tr) ---
Hi Perry,

It worked for me on Fedora 39. Thank you and AMD team for the support.

# sudo dmidecode -t system

# dmidecode 3.5
Getting SMBIOS data from sysfs.
SMBIOS 3.2.0 present.

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: ASUS
        Product Name: System Product Name
        Version: System Version
        Serial Number: System Serial Number
        UUID: fd469375-3c63-da50-47f3-a85e45cd44c4
        Wake-up Type: Power Switch
        SKU Number: SKU
        Family: To be filled by O.E.M.

Handle 0x002E, DMI type 12, 5 bytes
System Configuration Options
        Option 1: Default string

Handle 0x002F, DMI type 32, 20 bytes
System Boot Information
        Status: No errors detected

# sudo cpupower frequency-info

analyzing CPU 20:
  driver: amd-pstate-epp
  CPUs which run at the same hardware frequency: 20
  CPUs which need to have their frequency coordinated by software: 20
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 550 MHz - 4.57 GHz
  available cpufreq governors: performance powersave
  current policy: frequency should be within 550 MHz and 4.57 GHz.
                  The governor "powersave" may decide which speed to use
                  within this range.
  current CPU frequency: Unable to call hardware
  current CPU frequency: 3.68 GHz (asserted by call to kernel)
  boost state support:
    Supported: yes
    Active: yes
    AMD PSTATE Highest Performance: 166. Maximum Frequency: 4.57 GHz.
    AMD PSTATE Nominal Performance: 138. Nominal Frequency: 3.80 GHz.
    AMD PSTATE Lowest Non-linear Performance: 64. Lowest Non-linear Frequen=
cy:
1.76 GHz.
    AMD PSTATE Lowest Performance: 21. Lowest Frequency: 550 MHz.

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
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138
138

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dhighest_perf perf=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
231
166
166
241
236
241
201
196
191
186
181
226
176
171
166
166
231
226
221
216
211
206
221
166
166
166
166
166
166
241
236
241
201
216
196
191
186
181
176
171
166
166
211
206
166
166
166
166

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

# PCC bits are not zero anymore.
# sudo hexdump -C --skip 0xBA6D0000 /dev/mem | head

ba6d0000  00 43 43 50 00 00 01 00  e7 00 00 00 8a 00 00 00  |.CCP..........=
..|
ba6d0010  40 00 00 00 15 00 00 00  00 00 00 00 00 00 00 00  |@.............=
..|
ba6d0020  15 00 00 00 e7 00 00 00  00 00 00 00 00 00 00 00  |..............=
..|
ba6d0030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..............=
..|
ba6d0040  00 00 00 00 00 00 00 00  00 00 00 00 01 00 00 00  |..............=
..|
ba6d0050  01 00 00 00 00 00 00 00  80 00 00 00 00 00 00 00  |..............=
..|
ba6d0060  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..............=
..|

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

