Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A10386BB7
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 22:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbhEQUx7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 16:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244524AbhEQUx6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 May 2021 16:53:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F1977611BF
        for <linux-pm@vger.kernel.org>; Mon, 17 May 2021 20:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621284762;
        bh=PKA/GJzMw6gwJgcwTeJ0C2E3zU/mEjtWBv6U5+PHA1Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HxkjuK9uMjbzz9+xGTREnxXBwW+dJuIDSdp/txC+FpQDdAcCNS17fG/xiIEkLLAVl
         6n5JHrZKkNdfCFrR4tm60wRU/QZDM4DsfRtZc6bPYKJbagF/CW5Mr02cLP136MlFcV
         nQfNVpF597UdXDTECYgn/PkiI4mIev8bJyGRq7xzXc+aujNBQ9oI3XR8kO/M7QGie8
         xJ7RodQzSvp1ty+jyIodC1iPvsmF73JuFqmHjWimC+P8e00k7mxdNiABv8t/f2O73v
         5APFYlnOsoPUziiWNsXe9XU8oPgl6l0Lm/6dUl8Ss5fvCJFGIHa6mSe7+fY3+b8hHL
         rg/lxrdUgWSWQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id E6E0761176; Mon, 17 May 2021 20:52:41 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 213115] Unable to set the lowest frequency of AMD CPUs via
 cpupower - while kernel 5.12.4 (or 5.3.18) is booted with "nosmt"
Date:   Mon, 17 May 2021 20:52:41 +0000
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
X-Bugzilla-Changed-Fields: cc cf_regression
Message-ID: <bug-213115-137361-PbfNklJRUn@https.bugzilla.kernel.org/>
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

Yan Huang (Johnny) (yan.huang@suse.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |yan.huang@suse.com
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
