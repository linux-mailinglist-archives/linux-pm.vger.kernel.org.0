Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872745759EC
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 05:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiGODUI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jul 2022 23:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiGODUH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jul 2022 23:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9A2A447
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2022 20:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8E9D621E3
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 03:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0ADF9C3411C
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 03:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657855206;
        bh=K58BTqh4qmrI0zkssX+T9NQuRl9u5GknZElbiWA0yV4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PW6Ng4KXTh5JcLBc9RVpFcebRWJjM7QbOieBbJm90anBg2whmyeEa2zg1IBt7gjQ1
         2LwN6aUY7dmahJXYBvV8IdDI/dJ60y8GVUm16AIRVCPX4XT1/U7fQVuuJkFsSuFc4+
         GaC2rLS+kReLY1FifdIXLuwm/Tuem8SrozgQJj3YMm6b34QNDDMkDOCSR5d5zU7IY1
         3xBGTeRaqGNdkGPZsQ8kgdK7R9Hl9i3kZi3LmykbwXe3UhvQR6t8KH6S2qcXcgJsyy
         YnGyYSlPzqD2tUasJIfVXw/FxeiJRgZwfsl504g7AeEnhId1RGSoCt0PRpE71XM1Ek
         BisyZ4Qyck+6g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E12CACC13B7; Fri, 15 Jul 2022 03:20:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 03:20:05 +0000
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
Message-ID: <bug-216248-137361-0R57yQKKvL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216248-137361@https.bugzilla.kernel.org/>
References: <bug-216248-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216248

--- Comment #2 from perry_yuan@outlook.com ---
Hi Arek:

Could try the latest kernel from linux-pm tree ?
https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-pm.git

I tried this tree, the pstate driver can be loaded.

[  250.010934] cpufreq: setting new policy for CPU 15: 400000 - 4673000 kHz
[  250.010935] cpufreq: new min and max freqs are 400000 - 4673000 kHz
[  250.010935] cpufreq: governor limits update
[  250.010935] cpufreq: cpufreq_governor_limits: for CPU 15
[  250.010936] cpufreq: initialization complete
[  250.010937] cpufreq: driver amd-pstate up and running


 5.19.0-rc6+ #13 SMP PREEMPT_DYNAMIC Fri Jul 15 11:07:12 CST 2022 x86_64 x8=
6_64
x86_64 GNU/Linux

My system has the same model id like yours.=20

Vendor ID:                       AuthenticAMD
CPU family:                      25
Model:                           80

with cppc flag in cpuid

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
