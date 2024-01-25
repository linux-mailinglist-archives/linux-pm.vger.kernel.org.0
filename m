Return-Path: <linux-pm+bounces-2733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED3383C274
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 13:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF8CAB20E4D
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 12:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221AF45971;
	Thu, 25 Jan 2024 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6BoDeX/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07CD37709
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185560; cv=none; b=M+qRKTV/Q51UhPBqk2D50iwIyB+VSU7WMiy+ng6Uxtkf5rqbG4jZ0rprLAxfboaNyM3BwRa6obVXZJu26lDy1WmojMfOtxZVHmbLdipq6f7tv7T/lwejeB89KIhvS8r/9CW7IpkUKf2OHcwW2HYAdKwpQSJ789BjOxEPqHToCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185560; c=relaxed/simple;
	bh=m/cDC6+RJ/JPh6JU8UjSLMu3CqfH6EIk48tCCu8XD8M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q4UyfamLjNEeHZPk1/dpXO8QOvQBcUCnCCmS7mRfwVyzVegNjnMB4MTgmJgMxujkXDjhUo87GRHcQKciVYu2ykgtN2IaXnQ2781DW/egp3++HoO9J2g9vw3hdXdmYQsIMgDXihWsb2FBTNzpeZhKvlt8CbdmLqjsk8eZTr35Cn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6BoDeX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70E9FC43399
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 12:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706185559;
	bh=m/cDC6+RJ/JPh6JU8UjSLMu3CqfH6EIk48tCCu8XD8M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=O6BoDeX/TAiPrXgTaEOoLm7d/t6l0x2KR+i3qc9XhZfiMv6CKeNKbGSQJkOnFaoJf
	 LZAXyY+nDqdkr+jQ1WSuVI0zAqjT+geI0h5ax0m+8EZiSevEbenD9rTe+Rxczqcgmb
	 A9E6dwvE+f0NklsfgmkmJ2YeDW/NGYzCcxCb/+UDi9ivBsqx1yB9BK/cHOwUp6T1XP
	 1vW+RE9lkpiiFqnAVLyjb9MFzBn72REVdfIBBWyg4cD5aDjd9MnqwDc7b/yfNhP1N9
	 uY1ElIBUQhjRGuU6+VlZdO1WoQYXIgw34xAhXWZeW2QMExu5o1LE0dbbu/lWpvRTVW
	 N64m6jA5p+LCg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5CDD7C53BD0; Thu, 25 Jan 2024 12:25:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Thu, 25 Jan 2024 12:25:58 +0000
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
Message-ID: <bug-218171-137361-GGVuDQXYso@https.bugzilla.kernel.org/>
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

--- Comment #37 from Gino Badouri (badouri.g@gmail.com) ---
Hi there Perry,

Thanks again for looking into this, here are my results:

Kernel: 6.8.0-rc1 vanilla + your patch
Mainboard: Asus ROG Zenith II Extreme (sTRX40)
CPU: AMD Threadripper 3960X
Bios: 1802 (06/09/2023) CPPC and CPPC Preferred Core enabled
Kernel command line: amd_pstate=3Dactive


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
  driver: amd-pstate-epp
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 550 MHz - 4.78 GHz
  available cpufreq governors: performance powersave
  current policy: frequency should be within 550 MHz and 4.78 GHz.
                  The governor "performance" may decide which speed to use
                  within this range.
  current CPU frequency: Unable to call hardware
  current CPU frequency: 3.58 GHz (asserted by call to kernel)
  boost state support:
    Supported: yes
    Active: yes
    Boost States: 0
    Total States: 3
    Pstate-P0:  3800MHz
    Pstate-P1:  2800MHz
    Pstate-P2:  2200MHz


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


If you like, I can also redo the same tests with guided and/or passive mode=
s.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

