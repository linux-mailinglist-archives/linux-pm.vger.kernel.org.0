Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41602386BDB
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 23:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244626AbhEQVC7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 17:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236014AbhEQVC6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 May 2021 17:02:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id ADB726105A
        for <linux-pm@vger.kernel.org>; Mon, 17 May 2021 21:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621285301;
        bh=KHAZ4+C412240DhiGfa9dZsCDjhb3wjLbC9o2z/f/p4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=p15K2yRS8ydLzdIBpAm6PMVZFtMgaIf8i9gjkVjFNRRREKuaBWDvTGuHllBWSjZCj
         z0fhOicqaCVvSihWta61E3bXT+NwUu59uXZECstJogeDWqNq9b8BSs9SiXx66T5Ew3
         iGsOF8XVyop+NTB1B1xSW/EKt0OYV5FBN1ReOIXkuMHb+l6i065bvVL8Z+AeOpoMwo
         krR5KPn62PNJ1HW2RsB+Euaf3rvjPAxkMCAS3eCM9xeiReMht1r2NkCt6I+DCLICkx
         9LKYwN0FFVYbmIKibN1JgRzpdQWcOo0krl/Uw5rLDPfUuLm7FlBbVcVriFjETQ1B56
         J5J4K0ewnEazg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id A56BE611AD; Mon, 17 May 2021 21:01:41 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 213115] Unable to set the lowest frequency of AMD CPUs via
 cpupower - while kernel 5.12.4 (or 5.3.18) is booted with "nosmt"
Date:   Mon, 17 May 2021 21:01:41 +0000
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
Message-ID: <bug-213115-137361-rVwWzeog5w@https.bugzilla.kernel.org/>
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

--- Comment #2 from Yan Huang (Johnny) (yan.huang@suse.com) ---
Created attachment 296821
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D296821&action=3Dedit
cpupower frequency-info

Attaching the "cpupower frequency-info" output from my own laptop Lenovo
IdeaPad 3-15ADA05 with AMD Ryzen 3 3250U (while "nosmt" wasn't set and befo=
re
running the command mentioned in the comment #0)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
