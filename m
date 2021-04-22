Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB963368165
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 15:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhDVNYQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 09:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232844AbhDVNYP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 09:24:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DF79A61425
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 13:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619097820;
        bh=Udp4IHq5lUuq8U8r5Q51/kXoPPpXkHpBtpePPOZpf6A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=m49ighhaXimLujceV1sfdE4SzzEH2Rx8y5fBZIKPVXmVm7JyDzWdASZs63UI9NWij
         veIbdrVAnZF8Pk8BNSxyC3hnlyVMbjSXqJk5G7r1xQUkDcXyllhk95VZO9TqYUrxUf
         iz5ueQM5tsxcaQBhqVM7Hyqc05muK0ePDp1l4hebjUVIdRUrmf/5ZvizKzzUzXtISH
         5to8wBXiHEdpA6iIwkNuuieEoqoMajlxQisWSX+j1a31D3uB2hbptnsIyGg/HN104l
         jpzDccKLPZ61OAMdDBsMtu56VjR8sLTaqL/c5bgXCFKsVf2Bm4is4orUGkBJ6Mt6Xy
         Jr91XM/6hmetg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id D491361183; Thu, 22 Apr 2021 13:23:40 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 210993] Intel frequency scaling causes electrical noise on 10th
 gen CPUs
Date:   Thu, 22 Apr 2021 13:23:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: intel_pstate
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: rui.zhang@intel.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component
Message-ID: <bug-210993-137361-Vj5F3hPFJT@https.bugzilla.kernel.org/>
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
          Component|cpufreq                     |intel_pstate

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
