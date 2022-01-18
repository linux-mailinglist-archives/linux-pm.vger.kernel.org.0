Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB75492348
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jan 2022 10:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiARJyQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jan 2022 04:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiARJyN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jan 2022 04:54:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BE7C06173E
        for <linux-pm@vger.kernel.org>; Tue, 18 Jan 2022 01:54:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF910B812A9
        for <linux-pm@vger.kernel.org>; Tue, 18 Jan 2022 09:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F7A3C340E5
        for <linux-pm@vger.kernel.org>; Tue, 18 Jan 2022 09:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642499650;
        bh=PlUVjzFkehk1kAzxDRLpxTuTPRSQviXiKRzeaCxZe3c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CpIuEv0IEiS9DsFJgINHCojNWhuZFTnB18hQr7DCmnjwN2yP6UY4qp02DD565CKUb
         yMF/sHUfiha1pa5QXfAP4Te8z4SKpo8ys7mwHyIVILO46/VQqrdYjoSFARuuCsH+cP
         +jqoG0K3l5ri9B8sCWMejFHMYSZFHheFUMCkMOdMA8TZfR4p3xQF+T5gxZwcbgQq0A
         ibwtSnFYphHaWUpYi1/AeHtFcqgin+GQiIVFkbL4TWYkddIbUCoHjW6ABBRMu2KZrJ
         RrM615WyhylegKlAk3WdPUtNYGoxTeVwsV8hZgDEB6E/N0Wf2j/hVvN+G59HTAQBA1
         Hc4XZaF/psLfg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 64E95CC13AF; Tue, 18 Jan 2022 09:54:10 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215135] proposed cpufreq driver amd-pstate regresses wrt
 acpi-cpufreq on some AMD EPYC Zen3
Date:   Tue, 18 Jan 2022 09:54:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jinzhou.su@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215135-137361-ZPGNwyGILG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215135-137361@https.bugzilla.kernel.org/>
References: <bug-215135-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215135

Joe (jinzhou.su@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jinzhou.su@amd.com

--- Comment #2 from Joe (jinzhou.su@amd.com) ---
Hello Giovanni,

Thanks for testing AMD Pstate driver. Finally we have set up the same devic=
e on
our local, here is the lscpu info:

Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              256
On-line CPU(s) list: 0-255
Thread(s) per core:  2
Core(s) per socket:  64
Socket(s):           2
NUMA node(s):        2
Vendor ID:           AuthenticAMD
CPU family:          25
Model:               1

Here is the tbench test result.

acpi-cpufreq-ondemand  17628  MB/sec  ( 1.00)
acpi-cpufreq-perfgov   25317  MB/sec  ( 1.43)
acpi-cpufreq-sugov     21369   MB/sec ( 1.21)

amd-pstate-ondemand    17913  MB/sec  ( 1.02)
amd-pstate-perfgov     25865  MB/sec  ( 1.47)
amd-pstate-sugov       22359  MB/sec  ( 1.26)

From our site of view, amd-pstate performs slight better acpi driver in
Tbench4. The test based on 50 times test in each policy.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
