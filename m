Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7785F386BD2
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 22:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbhEQVBE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 17:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233271AbhEQVBD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 May 2021 17:01:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1DC1261244
        for <linux-pm@vger.kernel.org>; Mon, 17 May 2021 20:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621285187;
        bh=xXdA0VZYABQtmgYMX2/0i8UeZQlmMzsDNIOSYVBmJr0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=roxBp+4M0fWhNQequs6xPSbzXnOnYLDI4eRGUZB/iEggj8G6QUGL9A8Uv9d9G32Y/
         IAK7/AUXDbFEsTF1h222XxvcClW6kFkn9sghHLwCJiHH70UDES4ZngBta6UIryn0dz
         SDMTAx3jRQXdqzPzwCtjv92a7xfMVlNXIn8bTIMs2tCaeqHCfkT6j72yVbC/c7eex5
         8dSZXmUIOGLkIb0rgUnNYCnXVSydFTlYz2AMnfx7lcXQILF2oVGgEgxzYxCBPUqKWS
         ERfP3Fhiw9yqdHFT3tVfjs3v0xRNnCM0DEdDbNMXN2/s/n05Qki8Qjx4iacxCdROrm
         wXZBokKsESdzw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 0FA03611AD; Mon, 17 May 2021 20:59:47 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 213115] Unable to set the lowest frequency of AMD CPUs via
 cpupower - while kernel 5.12.4 (or 5.3.18) is booted with "nosmt"
Date:   Mon, 17 May 2021 20:59:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: yan.huang@suse.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-213115-137361-diTuDubGUE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213115-137361@https.bugzilla.kernel.org/>
References: <bug-213115-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213115

--- Comment #1 from Yan Huang (Johnny) (yan.huang@suse.com) ---
Created attachment 296817
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D296817&action=3Dedit
/proc/cpuinfo

Attaching /proc/cpuinfo from my own laptop Lenovo IdeaPad 3-15ADA05 with AMD
Ryzen 3 3250U (while "nosmt" wasn't set)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
