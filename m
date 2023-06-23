Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933FF73BE29
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jun 2023 19:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjFWR6H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jun 2023 13:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjFWR6G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jun 2023 13:58:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F893E41
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 10:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B5A161AED
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 17:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B642C433C9
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 17:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687543084;
        bh=LO01+ljK8XoggJs5gbUbjOveu0MmI+/6jUmu2a+GTNo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UtDHw6Yt7QVXP8CQZRs5Usyvg+YyJcKSp6HpVSJMxW/Igm/kF1ffToIZ49nR7ynJT
         Xyk4i3EcPWHPHm4MZNlIk978wh2Fp6FrsKfhXjaSVyJ7pl0SsfgespwSQDN+gxm6di
         juLRX3/vxSpq1Jbpl9siRtxjvIOBC23T7Uus3/L1O/cTaqirtWu7TEc4RWHJwOsJRa
         vfBLkgh6a7FlclxXZ4umDU6pnoRQWxjvoE5OZCrJ022vicEU7qEHQEzWZq7VkWb6/Y
         fkSSCn34EUdkfKWISFXI4rp1RdYQ56VF3+mwatEpWuZuQcEfP5fryKRBxp7MB38bBf
         1nT3jUC9k3o3A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 519E0C53BCD; Fri, 23 Jun 2023 17:58:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217589] Intel CPU maximum boost frequency reduced after resume
 from suspend to RAM
Date:   Fri, 23 Jun 2023 17:58:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bjackson0971@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217589-137361-mkA7iGdGge@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217589-137361@https.bugzilla.kernel.org/>
References: <bug-217589-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217589

--- Comment #6 from Brad  Jackson (bjackson0971@gmail.com) ---
Had to disable secure boot for debug output. First log:

intel_pstate: CPU 1 going offline
smpboot: CPU 1 is now offline
x86: Booting SMP configuration:
smpboot: Booting Node 0 Processor 1 APIC 0x1
intel_pstate: CPU 1 going online
intel_pstate: set_policy cpuinfo.max 5500000 policy->max 5500000
intel_pstate: cpu:1 min_policy_perf:11 max_policy_perf:70
intel_pstate: cpu:1 global_min:11 global_max:70
intel_pstate: cpu:1 max_perf_ratio:70 min_perf_ratio:11

Second log attached below.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
