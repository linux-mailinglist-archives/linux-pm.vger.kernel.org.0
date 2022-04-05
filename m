Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8554F20FD
	for <lists+linux-pm@lfdr.de>; Tue,  5 Apr 2022 06:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiDECiM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Apr 2022 22:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiDECiE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 22:38:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0AC2F4969
        for <linux-pm@vger.kernel.org>; Mon,  4 Apr 2022 18:37:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7EFD61779
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 01:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 457AEC34112
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 01:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649122275;
        bh=7ANXFPQWrr+OJFrA8EYATZGadFjVKC1xGXRzttgB4VM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KmyjzBX/vs0yNLE2guVvVSFvPr+6X+oNQ1XyrHz+PVJOlv8bh2FBUoDniXEYt3EgJ
         DhvCN1Q9yiB01CpkjKY4vGechpxg2gjwo32KEy3FIdLH7wHKT9e+MggOXbf6M7SyWF
         UdDI84coO923YzqFnMVsWLd1K7yzGH0GCbVJO8RcXIQR1B4z7QWJG4LHCxueAxHhQ7
         i7QjAx2srtJAINbGVTOofHqxhr4U+yYoNUZ7Hdzzqmckyr7xjSyqOaqgoroHdlbR/Z
         R9tHm2qC3f9zmhLWQYEev6bwosEKVZKJJUKnq7RMlm6VZu0V1vNaodKGDADBPapwAG
         EnyJFJSuvhqVQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2DD17C05FD4; Tue,  5 Apr 2022 01:31:15 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Tue, 05 Apr 2022 01:31:14 +0000
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
Message-ID: <bug-215800-137361-zueIJglCrA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
So, now I have this and all the cores are stuck at 2.2GHz:

/sys/devices/system/cpu/cpu0/cpufreq:

amd_pstate_highest_perf:166
scaling_min_freq:550000
scaling_available_governors:conservative ondemand userspace powersave
performance schedutil=20
scaling_governor:ondemand
cpuinfo_max_freq:4929000
amd_pstate_lowest_nonlinear_freq:1752000
amd_pstate_max_freq:4929000
related_cpus:0
scaling_cur_freq:2190255
scaling_setspeed:<unsupported>
affected_cpus:0
scaling_max_freq:4929000
cpuinfo_transition_latency:131072
scaling_driver:amd-pstate
cpuinfo_min_freq:550000

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
