Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B199045DB9E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 14:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355320AbhKYNwG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 08:52:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344320AbhKYNu3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Nov 2021 08:50:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id ADB2060F58
        for <linux-pm@vger.kernel.org>; Thu, 25 Nov 2021 13:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637848038;
        bh=15bfCaUUIGWysLCzupXrQy6iijBhZKwWc1rX+uV2Os0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bPIWqMwLfYcqcg0Sey+AMwaVUne10mTv1bjahA5ugzN/8BWNf7FYvd+GxLp5PRSPN
         xwR224jX4YCdjzy3NKt8eZQcSP2lDGKaYx30biseg3VUDZowrzX1AlKPP43SlWUAwe
         j/uv7KyDXZ5JASu0fMs9AyitPcetzhZbipsbO1qgynKNLxXV35Z70uuFsoqi80lE4V
         mfqHUCl3vYOfIQIji6mf7pDfzgDqH23AqFn93sj/G3HhYTV79OGi+bUp+q22y+xywF
         WZvQXJ4AgXMJ61HCgeke5ggPD5SMn++weWkYBf6q0XveGkJNQ/HPi+KknCC9ALki/1
         VHjoKcueMo+Lw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 9D7F461001; Thu, 25 Nov 2021 13:47:18 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215135] proposed cpufreq driver amd-pstate regresses wrt
 acpi-cpufreq on some AMD EPYC Zen3
Date:   Thu, 25 Nov 2021 13:47:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ggherdovich@suse.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215135-137361-kpGW42MISl@https.bugzilla.kernel.org/>
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

--- Comment #1 from Giovanni Gherdovich (ggherdovich@suse.cz) ---
Created attachment 299709
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D299709&action=3Dedit
data for tbench, 128 clients

The attachment contains data for tbench, 128 clients. These are the through=
put
reached in the various configuration; acpi-cpufreq/ondemand is the baseline,
higher is better.

acpi-cpufreq-ondemand  23092.2  MB/sec  ( 1.00)
acpi-cpufreq-perfgov   28880.1  MB/sec  ( 1.25)
acpi-cpufreq-sugov     31474    MB/sec  ( 1.36)

amd-pstate-ondemand    23820.4  MB/sec  ( 1.03)
amd-pstate-perfgov     27336.9  MB/sec  ( 1.18)
amd-pstate-sugov        6275.4  MB/sec  ( 0.27)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
