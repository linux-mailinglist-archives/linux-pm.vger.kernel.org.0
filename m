Return-Path: <linux-pm+bounces-27159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652C5AB7745
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 22:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2304173DB9
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 20:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2785295506;
	Wed, 14 May 2025 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPjnyKwM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB1120B7FB
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747255452; cv=none; b=E1kkW7icOrk/s2KTBnZ6GQtguEy14Kv7HaJmSzaViUNYtMpKt/kXUuwy2sju1hW37t7Lm9ywCPfqTHkvfF07fdr/b+VP3qMiVlTe54rNJpwEPATZoE0xFOcYFLinx+FgGDgSBa6Gzkhtc9k1DSprnUHdePfG6sXe5oQdkjEBLIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747255452; c=relaxed/simple;
	bh=zliecfqXd5FdEhLZHfHsBqUkqmnV/6E3Xcv4WHb1DF8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nXSOPimhjRG1dCqbQ9rt+3LmzlnelSe5axN7BN3y6JL/s0D42o4c0kZ7Tb5oK5Or7voYy4d2nSVkfqI20vWQIHzustbNJVL4eiZ3WxpD1zAYIBTbUGFV+3Mr+m2EccoH72wF5Tk/a9BE7ChHUsV5djXeZNsD0KS+Jt7m0h8DBSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPjnyKwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DC65C4CEF0
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 20:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747255452;
	bh=zliecfqXd5FdEhLZHfHsBqUkqmnV/6E3Xcv4WHb1DF8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DPjnyKwMsJjvWF2N6wnEGE6yPyBVziRn+uJaub3Mdg91Q9FsPgm37RcyqkZf2ebXS
	 I+lEGMIxcfnBFsbFv6m5/hvyCJrdidFSFoXkU6WfjbK3Zep6m5fibn46DbcGIIMsDX
	 tdyxpIXsRlNv9/UdIjr1ZPgJUPmR19q7VLkJjPo1OnliHvEcMGU3wqeM3Y20Kk3oxy
	 RWD5Ydu91ZAB5yMb9iaSK1Kji4Sc3DEA8cexAdBaaAIdivp+3UjapJ17icamgKZF6Q
	 vdFtR1uWBGK7pFCpZ4AuLx0QHCmF67KaMBddXwlij0vbECJgmK/Y/N9d8f0NeW4jmy
	 e2qVSbC1ztSJA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 042EEC41613; Wed, 14 May 2025 20:44:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220117] cpufreq performance governor doesn't correctly apply in
 combination with isolcpus
Date: Wed, 14 May 2025 20:44:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dsmythies@telus.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220117-137361-CgQfW1zGHX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220117-137361@https.bugzilla.kernel.org/>
References: <bug-220117-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220117

Doug Smythies (dsmythies@telus.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |dsmythies@telus.net

--- Comment #1 from Doug Smythies (dsmythies@telus.net) ---
Depending on the CPU frequency scaling driver, yes listed stale frequencies
might just be the current value for scaling_min_freq. If the processor is i=
dle
and has been for awhile the CPU frequency is considered to be "stale" and a
default value is listed.

Here is an example for my test computer with an Intel i5-10600K processor, =
with
CPUs 2 and 3 isolated (which isn't actually relevant):

doug@s19:~$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:intel_pstate
/sys/devices/system/cpu/cpu10/cpufreq/scaling_driver:intel_pstate
/sys/devices/system/cpu/cpu11/cpufreq/scaling_driver:intel_pstate
/sys/devices/system/cpu/cpu1/cpufreq/scaling_driver:intel_pstate
/sys/devices/system/cpu/cpu2/cpufreq/scaling_driver:intel_pstate
/sys/devices/system/cpu/cpu3/cpufreq/scaling_driver:intel_pstate
/sys/devices/system/cpu/cpu4/cpufreq/scaling_driver:intel_pstate
/sys/devices/system/cpu/cpu5/cpufreq/scaling_driver:intel_pstate
/sys/devices/system/cpu/cpu6/cpufreq/scaling_driver:intel_pstate
/sys/devices/system/cpu/cpu7/cpufreq/scaling_driver:intel_pstate
/sys/devices/system/cpu/cpu8/cpufreq/scaling_driver:intel_pstate
/sys/devices/system/cpu/cpu9/cpufreq/scaling_driver:intel_pstate
doug@s19:~$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu10/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu11/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu1/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu2/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu4/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu5/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu6/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu7/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu8/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu9/cpufreq/scaling_governor:performance
doug@s19:~$ grep MHz /proc/cpuinfo
cpu MHz         : 800.000
cpu MHz         : 800.000
cpu MHz         : 800.000
cpu MHz         : 800.000
cpu MHz         : 800.000
cpu MHz         : 800.000
cpu MHz         : 800.000
cpu MHz         : 800.000
cpu MHz         : 800.000
cpu MHz         : 800.000
cpu MHz         : 800.000
cpu MHz         : 800.000

My test computer is extremely idle and all cpu frequencies were stale.
Now, adding a load to isolated CPU 2 gives:

doug@s19:~$ grep MHz /proc/cpuinfo
cpu MHz         : 800.000
cpu MHz         : 800.000
cpu MHz         : 4799.997
cpu MHz         : 800.000
cpu MHz         : 4800.906
cpu MHz         : 4800.362
cpu MHz         : 800.000
cpu MHz         : 800.000
cpu MHz         : 800.000
cpu MHz         : 800.000
cpu MHz         : 4800.017
cpu MHz         : 800.000

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

