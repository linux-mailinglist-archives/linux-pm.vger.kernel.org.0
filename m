Return-Path: <linux-pm+bounces-2812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 051E283DED6
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jan 2024 17:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98BAAB25AF4
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jan 2024 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5599A1D69B;
	Fri, 26 Jan 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ6afYL2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314401D699
	for <linux-pm@vger.kernel.org>; Fri, 26 Jan 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287019; cv=none; b=ewyM4uM4oWrwcb0AAYlzlU6Tdb0ySfPaVR6WQC8VfHkzO+EqT+NoBUU/T3NLjjHDKIbDGkvMyeV7wTMKxOs0ahjkW4rm/+4rzCl2jsMsoc2bBXA5M7++oXrtK12o3asAprQojdcO3LXieQWqdja4+ecu9haPBpqjsUfw4Vz9rtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287019; c=relaxed/simple;
	bh=RjJpYifouNsJOuy4oP+VV9KSQxxECNDoyQzxQ+h4SlQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pR7LXXCamx7UviUM3mjOrWp48+9jgHTck0Ku1Elr5NctHTknS8jbxwVnNeS1zMqD3DdGexXAZIQhRBZdJl4v1Q3k5WMRS4AKmBKrOSIRati/1WGE6woPDJKtdkRKne8llZASIPG4Y89EPH83/+9oUcNNW/z9LFR3JETzx0wFnTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ6afYL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06DF2C433B1
	for <linux-pm@vger.kernel.org>; Fri, 26 Jan 2024 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706287019;
	bh=RjJpYifouNsJOuy4oP+VV9KSQxxECNDoyQzxQ+h4SlQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OQ6afYL2UEE9gjs7mTiC9sTC2lMMWCMN6VUGhdpuiMuLIbYg2rAXoGKrTljBmNvpv
	 veF4+ur3KdrOaRuXSFUnWF8mC+6Rld9oLlj/GffpxkJhgp1VdwYvhUiH6/3MxbEuvA
	 BMOsTm0teW9j1tQiTYb1ALP6FclXbPpbttYt6HrXldQ1EQLIyT1IddGU8bwewuB1LQ
	 9xTtunJcQ2HA8GrLaBEvCKQexsSc8CmPb16Ju5Km5qGQxMiiKsXf9FgxDib1RgepZw
	 kwl5zPePtbc0+6vpyQerZ91NCvJmNeX1BeWac8jTGhr22sfUnPjfILdPkNKNSdVHUN
	 y7DVJM+H3WhxA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EADDBC53BD0; Fri, 26 Jan 2024 16:36:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Fri, 26 Jan 2024 16:36:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: johnypean@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-Z2j32WjQXz@https.bugzilla.kernel.org/>
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

--- Comment #41 from Jan Kosterec (johnypean@gmail.com) ---
This is grat news. Working flawlessly on:
Gigabyte TRX40 DESIGNARE
AMD Ryzen Threadripper 3970X

Tried it on 6.6.14, amd-pstate=3Dactive (can't use 6.7 yet) and it works gr=
eat.
Temperatures are lower while performance is better.

cpupower frequency-info
analyzing CPU 10:
driver: amd-pstate-epp
CPUs which run at the same hardware frequency: 10
CPUs which need to have their frequency coordinated by software: 10
maximum transition latency:  Cannot determine or is not supported.
hardware limits: 550 MHz - 4.55 GHz
available cpufreq governors: performance powersave
current policy: frequency should be within 550 MHz and 4.55 GHz.
The governor "powersave" may decide which speed to use
within this range.
current CPU frequency: Unable to call hardware
current CPU frequency: 4.32 GHz (asserted by call to kernel)
boost state support:
Supported: yes
Active: yes
AMD PSTATE Highest Performance: 166. Maximum Frequency: 4.55 GHz.
AMD PSTATE Nominal Performance: 135. Nominal Frequency: 3.70 GHz.
AMD PSTATE Lowest Non-linear Performance: 64. Lowest Non-linear Frequency: =
1.75
GHz.
AMD PSTATE Lowest Performance: 21. Lowest Frequency: 550 MHz.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

