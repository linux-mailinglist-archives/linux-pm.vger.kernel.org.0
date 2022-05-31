Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ABB538A0C
	for <lists+linux-pm@lfdr.de>; Tue, 31 May 2022 04:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243673AbiEaCzp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 May 2022 22:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiEaCzp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2022 22:55:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942328CCFB
        for <linux-pm@vger.kernel.org>; Mon, 30 May 2022 19:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DCD0B80E5B
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2022 02:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEC42C385B8
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2022 02:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653965741;
        bh=wYPh+CdhuEOsU+fJ2xTWQM3EHzuiKd0nxlFhsDePAac=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HR1w/pK828qxLF7dYpKWX9OfMOXJsJ/7ytkVEnwx+DcedMW1IJqVw3Tk2uSe2u82j
         xWTC5vw6HCrBbfkPTxui2kRhQ02hpE6hmkuln38d9P3g0XPKYh+ZhgiRoVAZ1Y3n/K
         Vm+tBU27DIVzPbGZkkWW9FHdBDTuoey8RNsLr2Q/4/6xpENVxXmoEs37kX21E+r73b
         HZ192HWwxPHS/n7zKuarFpM2yTm7L2czttGfz4XEOg9Tv/IssrLaRwhD/8xn1SxKy3
         D+8hv0qMIAyiFIhw1G5zgM6xU9ZvAcTk8GoNO6R7ur17GZ3MHLAqF0uh2tXKFpRTb5
         3ePiAtbuu0/nQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A5FC4CC13AD; Tue, 31 May 2022 02:55:41 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Tue, 31 May 2022 02:55:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: perry_yuan@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215938-137361-uLCaQBjWw8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

--- Comment #7 from perry_yuan@outlook.com ---
(In reply to Alex Maras from comment #6)
> Hey Perry,
>=20
> I've attached the /proc/cpuinfo output and dmesg output after the listed
> process. Do you want anything more for the moment? Let me know if you need
> anything, happy to help.
>=20
> Alex

Thanks for your info.
Could you try this kernel ?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/driv=
ers/cpufreq/amd-pstate.c?h=3Dv5.18

add this to grub.

amd-pstate.dyndbg=3D+p  acpi-cpufreq.dyndbg=3D+p freq_table.dyndbg=3D+p
cpufreq.dyndbg=3D+p cpufreq_governor.dyndbg=3D+p

I didn't find amd pstate driver related log in your last dmesg.
more debug logs will be helpful.

Thanks.
Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
