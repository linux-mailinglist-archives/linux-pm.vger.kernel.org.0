Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AF931BAB5
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 15:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhBOOFI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 09:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhBOOFH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Feb 2021 09:05:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6835E64E32
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2021 14:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613397866;
        bh=YcHOpHfZCwiU0JTUKDCsInQhnEMZmrGBRrvdChb0U6I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=khal1mfsO2wWj1/s7aslCi/2YML78E26Z/5rtg5OQuxmnDSN4s+iI3/Tbe4DtFaiy
         Um9VSqH9Ft/MCnKWGSujFnz5AOHq/oSbxMt97bcH89VMSZnzkIMZEhKkkKQOCtWwDM
         mNBCM/guYRhgUGBuD3Be0jnOI3U94Qe7WCouTiVQatZqhHLlEgV3DiKAUxm1Y72iJq
         /Ur6EIBQfqBoMzrdum3OrN6V/I20uLOPMtUiupmbFN4FiWb+6hUNh91fMLRClmGRpd
         Ni9QpmKr/HxI+iXAaTKOu5ob+ag5Ytd0EKpP50AtK/s0GXplvM3yhsmpcKdeaKMVOF
         O3Nhz6YUeJUuA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 4A78C60249; Mon, 15 Feb 2021 14:04:26 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211305] schedutil selects low P-States on AMD EPYC with
 frequency invariance
Date:   Mon, 15 Feb 2021 14:04:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjw@rjwysocki.net
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211305-137361-ESumSMJlfX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211305-137361@https.bugzilla.kernel.org/>
References: <bug-211305-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211305

--- Comment #14 from Rafael J. Wysocki (rjw@rjwysocki.net) ---
Also can you please enable dynamic debug in freq_table.c, unload acpi-cpufr=
eq,
load it again and attach the output of dmesg?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
