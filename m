Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533A93A93BA
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 09:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFPH2g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 03:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhFPH2f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Jun 2021 03:28:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 669CC6135C
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 07:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623828390;
        bh=FRdsLJWKRt/Wt9UMk83IEyrlLdbNiVeFWsPskkyGldY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PloE1TpLI26itxcs5H3twzDGhwAq01ETHOT/joZ2+wfwJDe9vBBwqNQ8mEbhsl3vj
         HMcitiWWmWoY+wxafqUzlQY0cgFTS7qU0Zkvg31FP9kBAR53jyXhUDUCFb89SuTxwl
         dqeDex9i9tRa8iqzvVMcaABxKB9wRDhmakXVjGQCWaNws67tplnE/0k+cxgCBPry+y
         CyxL9Ax62ecIpt6hyMaLCZYkqSjEhKGdv+i+JaNjh801eew0CJmv0CdsFF+/tss018
         O+xLXTtVYYBcig04qzPKVquAMGlyozPyYGT09k7jE7086n6PW3MF+AHOz1T5BdzW+g
         T3PHKHGPugF9Q==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 631D96109D; Wed, 16 Jun 2021 07:26:30 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 210993] Intel frequency scaling causes electrical noise on 10th
 gen CPUs
Date:   Wed, 16 Jun 2021 07:26:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: intel_pstate
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: rui.zhang@intel.com
X-Bugzilla-Status: CLOSED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-210993-137361-PDHcfhU7ZM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210993-137361@https.bugzilla.kernel.org/>
References: <bug-210993-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D210993

Zhang Rui (rui.zhang@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |CLOSED
         Resolution|---                         |DOCUMENTED

--- Comment #12 from Zhang Rui (rui.zhang@intel.com) ---
Bug closed.
Please feel free to reopen if you still have any questions.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
