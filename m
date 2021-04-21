Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC87F36638E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 04:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhDUCRU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 22:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233824AbhDUCRU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Apr 2021 22:17:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 47F8A61411
        for <linux-pm@vger.kernel.org>; Wed, 21 Apr 2021 02:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618971408;
        bh=4ud15AY/RnaYMGMfXHB22X5V5IZK3bEe54k8Db1BcQk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YR36UOpAgNJCptBGNoJPgCqosEenLl3lKPTEE06uR1iid4q3P7is1F5gnua9i5KC/
         auA9EPrSmN0K3scTSyFX42Z7lYDOOOWCKlUESoczz2cO9Q8DoWOYJkX1e5eBmaYgcr
         5dx4n9cokc7wA5FL08bXPOFwgsMAQqV75CNjTzn/eadlDp/xFrxkaDlvHyyKEXENsE
         JhQQLlQFK7DPTRzJ5s3kD7+Z/DTcODQmsU2mnK3iUh4vk+OgsuumyxOcU/+kS8bHeq
         Pz4fwgjz65xnHfz2mqYHXQdSRR046BE81A0iFWIZKrByfYcrSv3wLRQBm/UHpIMSu+
         kTefNTauOKG7g==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 44249611AC; Wed, 21 Apr 2021 02:16:48 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 209069] CPU stuck at 800 MHz at any load - Xeon E3-1271v3 HSW
Date:   Wed, 21 Apr 2021 02:16:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rui.zhang@intel.com
X-Bugzilla-Status: CLOSED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-209069-137361-mjcCwRv0lN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209069-137361@https.bugzilla.kernel.org/>
References: <bug-209069-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D209069

Zhang Rui (rui.zhang@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |CLOSED

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
