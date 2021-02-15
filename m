Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCC831BB58
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 15:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBOOoi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 09:44:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229670AbhBOOoh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Feb 2021 09:44:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2C13761606
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2021 14:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613400237;
        bh=b3E5qHSvbs2XeqD+stpnE23BMwS/SEBzM7Bmz/Y1CGk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QUH1DfAaMRmBpGKY/qgw7/JHbLq5wabs8/wqffyBeRsYqtv+pXDgp8FmP+bUid4JG
         oaG0vKPrf+M7DvgQDVA/oYIk2pcshVydEvxgqyvHPXqTDDk5SKEzi3d/ho4ZFxIn7q
         0C1UZykSuOM7vyY+fQxVqtVQlGY3x00BeEEPQY7qAEokx2Xx9e8/mOIsNzbC2y/P4G
         MINkrkxXAh8++xm2L0mLoXm6yjHqELxru9wVmi9IBCe6kf2+jYd3p/xQjxWu0EhJig
         ZMjALHMUp5LrgTlHRo5sD18KNIqaLLzzkUy59BZyCO2qsLfqatU4IJunVPdoQgRcoZ
         jasB0FLEHVZYg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 1E18360249; Mon, 15 Feb 2021 14:43:57 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211305] schedutil selects low P-States on AMD EPYC with
 frequency invariance
Date:   Mon, 15 Feb 2021 14:43:56 +0000
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
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-211305-137361-LYnqs6oL4o@https.bugzilla.kernel.org/>
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
 Attachment #295255|0                           |1
        is obsolete|                            |

--- Comment #15 from Rafael J. Wysocki (rjw@rjwysocki.net) ---
Created attachment 295295
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D295295&action=3Dedit
cpufreq: ACPI: Set cpuinfo.max_freq directly if max boost is known (v2)

I found a mistake in the previous version of the fix patch which didn't
initialize policy->max properly.

Please test this one instead and there is no need to provide the information
requested in the previous comments (at least not ATM).

Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
