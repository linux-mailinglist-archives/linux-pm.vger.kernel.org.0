Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA21547A9E
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jun 2022 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiFLPEc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jun 2022 11:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiFLPEb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jun 2022 11:04:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAC654BCD
        for <linux-pm@vger.kernel.org>; Sun, 12 Jun 2022 08:04:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5F6BCCE0BAB
        for <linux-pm@vger.kernel.org>; Sun, 12 Jun 2022 15:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68B77C3411E
        for <linux-pm@vger.kernel.org>; Sun, 12 Jun 2022 15:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655046265;
        bh=PvC99MtOOw4XX7S7cuDbe9w/0FUpI7HBrpuO4L6vgbs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Q9O+jcCTp/i1pPV4y3OPtaYkaMYgbVfYvi37wbQ/38hHQWalPutntrGs1oWVB3QsB
         aUoI/a+nueTqUtrIFmgBintDR1bh+TiWI+Q5mbZRbeOvFbVNY8xsTFOEB5aN+FdM2J
         ZITg3pjePe7zZUIy+pSbuefDhTppGPEpZ28G1lPHBlHshikOcKRr11RDcS37bC6/lR
         U6kSbp3xGr//ZZUrcBayaPLR6igb8gFGCZjF1BVqNUzhWJHo7FMALlmD3IZAqdZds6
         0Ke2cdui8BsJ8C7FtdKFN4CvLQFJDHi+6tfoNOzGuiXqg0s0G/CFodXvrajQfWezlO
         zDZQPOWUUSZxA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 52AAECC13B4; Sun, 12 Jun 2022 15:04:25 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Sun, 12 Jun 2022 15:04:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215800-137361-hKgyMOwVlK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #21 from Artem S. Tashkinov (aros@gmx.com) ---
/sys/devices/system/cpu/cpufreq/policy0

amd_pstate_highest_perf:166
scaling_min_freq:550000
scaling_available_governors:conservative ondemand userspace powersave
performance schedutil=20
scaling_governor:ondemand
cpuinfo_max_freq:4929000
amd_pstate_lowest_nonlinear_freq:1752000
amd_pstate_max_freq:4929000
related_cpus:0
scaling_cur_freq:1247422
scaling_setspeed:<unsupported>
affected_cpus:0
scaling_max_freq:1600000
cpuinfo_transition_latency:131072
scaling_driver:amd-pstate
cpuinfo_min_freq:550000

Why do I have two wildly different amd_pstate_highest_perf=3D166 and
highest_perf=3D186?

What's the relationship between the two?

Anyways, the issue remains. As far as I can see
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/dri=
vers/cpufreq/amd-pstate.c
has seen near zero activity for the past three months.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
