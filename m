Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485825471A6
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jun 2022 05:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349079AbiFKDd0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jun 2022 23:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350116AbiFKDdX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2022 23:33:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21089328ED0
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 20:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 500FD62061
        for <linux-pm@vger.kernel.org>; Sat, 11 Jun 2022 03:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFEF8C34116
        for <linux-pm@vger.kernel.org>; Sat, 11 Jun 2022 03:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654918399;
        bh=KQkAgB32buoV9Q4ftIJFd9gExLLIRGUjByBhzP3ZYjs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=p4hMlkTUwV7Mjve3EM8jBL4KfRFdOFIO8NXei37JgJZOjpdgxNa3vDnN8NWr6f6ef
         JuCdJXnBLSvmgf7H4Isfe7+d5IXqia5Kk2FeEtS8u6AYFGu0dUMlClGdleiJKgtEC3
         aZrdwqm0AlNaBTGBT3wnjNqjctgw4PhiNLk7phbL/aSs6/bRYQ1s+kfumb/dDqMxxU
         zpTmMmUmJHAZMue728BV71KDwOAaiuRDVRkmrm7VN2LjdO4zkvc6tGvn62Ue/F4uGt
         kgW0KTD5KI1vTQ+akr0sA3nACo8JEqgKVJmHrBYVetEPWOk6Kc1sNLL4GriD0VzBeJ
         c579RNvHlDDjA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 985BCCC13B1; Sat, 11 Jun 2022 03:33:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Sat, 11 Jun 2022 03:33:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dev@alexmaras.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215938-137361-DXacUXLXjl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

--- Comment #13 from Alex Maras (dev@alexmaras.com) ---
Hey Perry, results below:

[I] alex@alex-laptop ~> sudo cpupower frequency-set -g userspace
[sudo] password for alex:
Setting cpu: 0
Setting cpu: 1
Setting cpu: 2
Setting cpu: 3
Setting cpu: 4
Setting cpu: 5
Setting cpu: 6
Setting cpu: 7
Setting cpu: 8
Setting cpu: 9
Setting cpu: 10
Setting cpu: 11
Setting cpu: 12
Setting cpu: 13
Setting cpu: 14
Setting cpu: 15
[I] alex@alex-laptop ~> systemctl suspend
[I] alex@alex-laptop ~> cd /sys/devices/system/cpu/cpufreq/policy0
[I] alex@alex-laptop /s/d/s/c/c/policy0> echo 1752589 | sudo tee
scaling_setspeed
1752589
[I] alex@alex-laptop /s/d/s/c/c/policy0> cat scaling_setspeed
1752589
[I] alex@alex-laptop /s/d/s/c/c/policy0> cat scaling_governor
userspace
[I] alex@alex-laptop /s/d/s/c/c/policy0> cat scaling_cur_freq
2796520
[I] alex@alex-laptop /s/d/s/c/c/policy0>


Looks like the same issue continuing. Do you want the same dmesg with pstate
logging turned on?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
