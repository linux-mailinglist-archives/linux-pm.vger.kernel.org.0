Return-Path: <linux-pm+bounces-14899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E962798959A
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2024 15:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5FA1F22056
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2024 13:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7017B14A4F1;
	Sun, 29 Sep 2024 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCfCSN0A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE841E868
	for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2024 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727615592; cv=none; b=gb0Mf2KoYUh961/lIX2EM/wmBLlTm24nHFsU7tGESR9n9AiPS+CsH4pweXs3KDAkvbywb7l/s74rgnjAAn/EBO0c8LAit+6lTEZFekoou+/CCvms4/p8hrf/pUrwR7Z+JmvUBB4XQHORa96uRo63+Fwx/Hw+c43ynLoaXOoq96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727615592; c=relaxed/simple;
	bh=gcYXd5v7dD5qquLvnmDblPiEZYC/XwlEE3hB5q4guOg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LmptI8jbjrX3u0xBZJMLqUS8qNpscFQt2V/nKen/ePzNYHmTkPqwI4+Xb2UMjmd1ZoYcW8OorC/2//BOYyEC4cBinvB7z3tDiki2yZx9r6eSINMEI6D6LuUXtWpaUH+Pezzhz/nTDHzeZ7nLmqxVTCi4pl4h2y4uvbTjHSN5BWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCfCSN0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD940C4CEC6
	for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2024 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727615591;
	bh=gcYXd5v7dD5qquLvnmDblPiEZYC/XwlEE3hB5q4guOg=;
	h=From:To:Subject:Date:From;
	b=LCfCSN0AMH2C7CJ1f2470m5gwPBHXotu7rXuvMFFShOMvByZ+ndKpt2Y3EQ+QT2BE
	 TH8WiiSYtIZS4MOhdveIedmSS6gmnqn3/jCSJEKecydXYyxTHCGlSymF7DZnFdAeGN
	 A7/4UHlt4enau77bi567tx9KNMEYK/vu3j4AgN7F7lFj65Ve9oWczUHXVgUpCVc9zA
	 j25oxrkPgH8m/hQH0IkKvjPfIfQSf22DcqazyuucZ9//8W2JbJ8CJuea1a2BwmuCor
	 Nf9NbE2hRcmhAE//PcKRWlH+IMVUhqf5ZtAujIX4Bas/y2gcbrNRPA1agCauXLYOay
	 340ihNfGw+N2w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8C714C53BBF; Sun, 29 Sep 2024 13:13:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMTkzMzJdIE5ldzogL3N5cy9kZXZpY2VzL3N5c3RlbS9j?=
 =?UTF-8?B?cHUvY3B1ZnJlcS9wb2xpY3kwL2VuZXJneV9wZXJmb3JtYW5jZV9wcmVmZXJl?=
 =?UTF-8?B?bmNlOiBEZXZpY2Ugb3IgcmVzb3VyY2UgYnVzeQ==?=
Date: Sun, 29 Sep 2024 13:13:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219332-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219332

            Bug ID: 219332
           Summary: /sys/devices/system/cpu/cpufreq/policy0/energy_perform
                    ance_preference: Device or resource busy
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: aros@gmx.com
        Regression: No

Created attachment 306935
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306935&action=3Dedit
A dump of /sys/devices/system/cpu

I've played with various tee: /sys/devices/system/cpu/cpufreq/policy0/* opt=
ions
and now on Linux 6.11 and Ryzen 7 5800X I'm getting this:

perfbias.sh power
Now: performance
Switching to: power
tee: /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference:
Device or resource busy
tee: /sys/devices/system/cpu/cpufreq/policy10/energy_performance_preference:
Device or resource busy
tee: /sys/devices/system/cpu/cpufreq/policy11/energy_performance_preference:
Device or resource busy
tee: /sys/devices/system/cpu/cpufreq/policy12/energy_performance_preference:
Device or resource busy
tee: /sys/devices/system/cpu/cpufreq/policy13/energy_performance_preference:
Device or resource busy
tee: /sys/devices/system/cpu/cpufreq/policy14/energy_performance_preference:
Device or resource busy
tee: /sys/devices/system/cpu/cpufreq/policy15/energy_performance_preference:
Device or resource busy
tee: /sys/devices/system/cpu/cpufreq/policy1/energy_performance_preference:
Device or resource busy
tee: /sys/devices/system/cpu/cpufreq/policy2/energy_performance_preference:
Device or resource busy
tee: /sys/devices/system/cpu/cpufreq/policy3/energy_performance_preference:
Device or resource busy
tee: /sys/devices/system/cpu/cpufreq/policy4/energy_performance_preference:
Device or resource busy
tee: /sys/devices/system/cpu/cpufreq/policy5/energy_performance_preference:
Device or resource busy
tee: /sys/devices/system/cpu/cpufreq/policy6/energy_performance_preference:
Device or resource busy
tee: /sys/devices/system/cpu/cpufreq/policy7/energy_performance_preference:
Device or resource busy
tee: /sys/devices/system/cpu/cpufreq/policy8/energy_performance_preference:
Device or resource busy
tee: /sys/devices/system/cpu/cpufreq/policy9/energy_performance_preference:
Device or resource busy
Result: performance

This doesn't seem right.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

