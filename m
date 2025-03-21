Return-Path: <linux-pm+bounces-24392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8911A6BF64
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 17:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1E1172988
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 16:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A1622A7FF;
	Fri, 21 Mar 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRAaU4Og"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A9822A4EA
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573615; cv=none; b=FUsiF0o77SCLx6FGDwZcDPldvc2iemH6jo29QBsqoAOjGOOIWYHUwTz36WK/jCXAwFwnMMcspUUzUYmx/uXMJ9ChsgRbo8GheJiQ7axFcrAyBUNpAP9QXFtQTuv5Ih9VEnssAj6YwYJTrN8yaAglVeTZpfecjisdT5Ew778sr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573615; c=relaxed/simple;
	bh=ppbSEv+Gy22Sr7UsZ5k1xoNLTb51d3Ej2ye8UwqlwDQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y9yotmpzNF3i3tvgBVsTwSjZ7dAwSMVVTLbG4M08Q2ke4MZIDTqPurPyyKcsbHNlNtAYERLtOnZ+B5zrS7HCpKlyN+QxEgo7fHT51ZWVp0SRC1F4f1LAQbWECGQbIIY13lLjjYxpiBb54GqqnKoQ+grD0+RLnge0MBim69llGvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRAaU4Og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B563EC4CEEA
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 16:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742573614;
	bh=ppbSEv+Gy22Sr7UsZ5k1xoNLTb51d3Ej2ye8UwqlwDQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QRAaU4OganvWSyqb9MTtTm+ovQrD2oMALsg7Gz1Gq6cgr65XsbMKxrGg0jjGSpxyO
	 6mvm2xewJoMbcF/ZfII1juasbjKIJgHI2iHwg8tkw1QiYlkBLEHDNxd1e1V9+o8Wpm
	 /UhD9ah4p96FsCHW2hbitcl4eGbWjsivHVILu9VZfIEQlKz8S5jPOQ4ejNB445X5sg
	 cdVqgBa9CwHCvneLN6yIG/WpP0F+vv8Qk8e4evIz81RPm8CCSV/mZFKva+XvOuUxFC
	 XYtn4ocu6hSLxjqgie+Lv2H+75oCq74n2NKUQHWe4U/fIBpMKkR3mUYt9OETnKzhGG
	 JgWI4cA1lBVGQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 99C93C41612; Fri, 21 Mar 2025 16:13:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219858] AMD Zen 2 broken power management after sleep
Date: Fri, 21 Mar 2025 16:13:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: diogotavc@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219858-137361-4sqvBwjJIE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219858-137361@https.bugzilla.kernel.org/>
References: <bug-219858-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219858

--- Comment #5 from Diogo Carvalho (diogotavc@protonmail.com) ---
Before:

```
2025-03-21 16:08:24,596 INFO:   =F0=9F=90=A7 Kernel:       6.14.0-0.rc6.49.=
fc42.x86_64
2025-03-21 16:08:24,596 INFO:   =F0=9F=AB=86 'status':     active
2025-03-21 16:08:24,597 INFO:   =F0=9F=AB=86 'prefcore':   disabled
2025-03-21 16:08:24,637 INFO:   =F0=9F=92=BB CPU:          AMD Ryzen 7 5700=
U with Radeon
Graphics
2025-03-21 16:08:24,643 INFO:   =F0=9F=94=8B Per-CPU sysfs files
+---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------+
|   CPU # |   CPU Min Freq |   CPU Nonlinear Freq |   CPU Max Freq |   Scal=
ing
Min Freq |   Scaling Max Freq | Energy Performance Preference   |   Prefcor=
e |=20
 Boost |
|---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------|
|       0 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       1 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       2 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       3 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       4 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       5 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       6 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       7 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       8 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       9 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|      10 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|      11 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|      12 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|      13 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|      14 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|      15 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
+---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------+
2025-03-21 16:08:24,654 WARNING:        =F0=9F=9A=A6 MSR checks unavailable
```

After:

```
2025-03-21 16:09:31,138 INFO:   =F0=9F=90=A7 Kernel:       6.14.0-0.rc6.49.=
fc42.x86_64
2025-03-21 16:09:31,138 INFO:   =F0=9F=AB=86 'status':     active
2025-03-21 16:09:31,138 INFO:   =F0=9F=AB=86 'prefcore':   disabled
2025-03-21 16:09:31,155 INFO:   =F0=9F=92=BB CPU:          AMD Ryzen 7 5700=
U with Radeon
Graphics
2025-03-21 16:09:31,157 INFO:   =F0=9F=94=8B Per-CPU sysfs files
+---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------+
|   CPU # |   CPU Min Freq |   CPU Nonlinear Freq |   CPU Max Freq |   Scal=
ing
Min Freq |   Scaling Max Freq | Energy Performance Preference   |   Prefcor=
e |=20
 Boost |
|---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------|
|       0 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       1 |         400000 |              1114000 |        4373000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    1 |
|       2 |         400000 |              1114000 |        4373000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    1 |
|       3 |         400000 |              1114000 |        4373000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    1 |
|       4 |         400000 |              1114000 |        4373000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    1 |
|       5 |         400000 |              1114000 |        4373000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    1 |
|       6 |         400000 |              1114000 |        4373000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    1 |
|       7 |         400000 |              1114000 |        4373000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    1 |
|       8 |         400000 |              1114000 |        4373000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    1 |
|       9 |         400000 |              1114000 |        4373000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    1 |
|      10 |         400000 |              1114000 |        4373000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    1 |
|      11 |         400000 |              1114000 |        4373000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    1 |
|      12 |         400000 |              1114000 |        4373000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    1 |
|      13 |         400000 |              1114000 |        4373000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    1 |
|      14 |         400000 |              1114000 |        4373000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    1 |
|      15 |         400000 |              1114000 |        4373000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    1 |
+---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------+
2025-03-21 16:09:31,162 WARNING:        =F0=9F=9A=A6 MSR checks unavailable
```

After (setting power saving mode again):

```
2025-03-21 16:08:51,541 INFO:   =F0=9F=90=A7 Kernel:       6.14.0-0.rc6.49.=
fc42.x86_64
2025-03-21 16:08:51,542 INFO:   =F0=9F=AB=86 'status':     active
2025-03-21 16:08:51,542 INFO:   =F0=9F=AB=86 'prefcore':   disabled
2025-03-21 16:08:51,557 INFO:   =F0=9F=92=BB CPU:          AMD Ryzen 7 5700=
U with Radeon
Graphics
2025-03-21 16:08:51,559 INFO:   =F0=9F=94=8B Per-CPU sysfs files
+---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------+
|   CPU # |   CPU Min Freq |   CPU Nonlinear Freq |   CPU Max Freq |   Scal=
ing
Min Freq |   Scaling Max Freq | Energy Performance Preference   |   Prefcor=
e |=20
 Boost |
|---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------|
|       0 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       1 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       2 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       3 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       4 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       5 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       6 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       7 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       8 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|       9 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|      10 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|      11 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|      12 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|      13 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|      14 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
|      15 |         400000 |              1114000 |        1801000 |=20=20=
=20=20=20=20=20=20=20=20=20
1114000 |            1801000 | power                           |        255=
 |=20=20
    0 |
+---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------+
2025-03-21 16:08:51,563 WARNING:        =F0=9F=9A=A6 MSR checks unavailable
```

I can confirm that it still boosts over the supposed max frequency, regardl=
ess.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

