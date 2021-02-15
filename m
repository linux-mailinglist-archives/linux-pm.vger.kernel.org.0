Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0348331BAA0
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 14:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhBONz7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 08:55:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230316AbhBONzk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Feb 2021 08:55:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4487664E30
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2021 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613397300;
        bh=5n/hz9QvFi3Bj+cfgf5AGg/31aCr8IhbjQn0t4EtXS8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Sz+qJv+v8V39MrcHEPDSJIpix2JbW8fgoE8cu4gHHQ/3rL5Q71SV+3CgfC9P9qVs9
         z6ZT/K66fIYxrjnILZx4kTrLuYD95770h3yWYD2DiiR7h858NspXtOZ3FbF4fRu8pR
         LhUGVRbBMZXsdw4+NWipMv4glZghjNM2hPSrLKsTJJIscDhA4q/KvnNxvS6J8n6x5s
         9j/5uXMHQagl3I73BPtRP4iUqO+Ov4JtbSG17Skv55BykVNMaPlbmV2kSGj9zZ8aKJ
         DOW4hPUn2Il/fG+c83AnHympATVXJmPxslkbyTd2FspmEW2ZHLjIPS8R7vXGtudTVY
         +NNx8qT1SZB7g==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 3C2DD60249; Mon, 15 Feb 2021 13:55:00 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211305] schedutil selects low P-States on AMD EPYC with
 frequency invariance
Date:   Mon, 15 Feb 2021 13:55:00 +0000
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
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-211305-137361-WxX2mYhW2Q@https.bugzilla.kernel.org/>
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

Rafael J. Wysocki (rjw@rjwysocki.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
