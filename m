Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885D074B1C7
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 15:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjGGNaH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 09:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjGGNaG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 09:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0429D1BEE
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 06:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D341619A2
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 13:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBAE7C433CB
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 13:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688736605;
        bh=bwXFVv23H/EXAiEd612S50MtnLF6fuYBK7F+tMWQ9dM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=in3/ziUTfro6mFADqaCI5CImF9mCu7pTaE+gKJlAj4Mdsob3sTI3jsdqHSFOhtcuD
         b4ys612ytw0zwr6FV+if4MEN/oDQd1wYUGR4mpxw1sEq9nWZNGFn1nM5tvJiZJ5+Fv
         RRotia0he/fQ1YSbQpsWNuMjSYX60o99bY8VS2OgW2gU/5qTE6jQKB4BvaRN481rdd
         G9i53p44TCGw8XDHO2mYz5K8cnq9sAFZrck3hazb4ElVntHV1LkKSTpS4X7PslS6gB
         v8eM6BvcKYy3Nqv9r1DD4gczs6aP3hNjitULF44Z5QhqyW/FVPRHwEVL05RK3xlK89
         GJP9MTdqzvQUA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D092CC53BD3; Fri,  7 Jul 2023 13:30:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Fri, 07 Jul 2023 13:30:04 +0000
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
Message-ID: <bug-215800-137361-LKBpOilTjl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #26 from Artem S. Tashkinov (aros@gmx.com) ---
amd_pstate_highest_perf is readonly, I cannot write to it.

/sys/devices/system/cpu/cpufreq/policy0 $ grep -r .=20
energy_performance_available_preferences:default performance
balance_performance balance_power power=20
amd_pstate_highest_perf:166
scaling_min_freq:550000
scaling_available_governors:performance powersave
scaling_governor:powersave
cpuinfo_max_freq:4929000
amd_pstate_lowest_nonlinear_freq:1752000
amd_pstate_max_freq:4929000
related_cpus:0
scaling_cur_freq:550000
scaling_setspeed:<unsupported>
affected_cpus:0
scaling_max_freq:3000000
cpuinfo_transition_latency:0
energy_performance_preference:performance
scaling_driver:amd-pstate-epp
cpuinfo_min_freq:550000

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
