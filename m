Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCDB31BB5B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 15:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhBOOrr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 09:47:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229944AbhBOOrr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Feb 2021 09:47:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6704264E26
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2021 14:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613400426;
        bh=OTnmqMGo5UOduyAmvNM8NHgwCvy88zx8EuuAvvytA3A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NKPHWwfS+vgzTz/a6ciqslvuAZ5bq9YdVOUnufHaxzlH0dgsoA8nulhT3SlqInePl
         JzHfRvroKe8uDQaR4nSr3O53Kh9Lyyoy53TTylIbYkeNY0LmKMTC+3SV+oDpNgWs/E
         eNet0l/FESuxCk+vweIQxvEDoWrAdcn13KLRB7+6bhBMTjnAnM86PeHuiT0s/S9/JA
         r+SuRSEWvsRzlOp5ZWz9wSuNtS3hlwqrCJpNRjTxhwqDdgzFYCzYyVBln8RfSEsrV+
         I0Hn5ok9oD6YAIsoV+vlJl6vDWpb787jZ2S2D456VHoDGy/lD2YfZgSd0Rv4kCkoyT
         KNZuIBW6hQr4w==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 5573E60180; Mon, 15 Feb 2021 14:47:06 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211305] schedutil selects low P-States on AMD EPYC with
 frequency invariance
Date:   Mon, 15 Feb 2021 14:47:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gardotd426@gmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211305-137361-dUunaHKhMj@https.bugzilla.kernel.org/>
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

--- Comment #16 from Matt McDonald (gardotd426@gmail.com) ---
Haha I'd just typed my response and bugzilla stopped me from submitting. Th=
at's
a cool feature.=20

Yeah, I'll build and test now.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
