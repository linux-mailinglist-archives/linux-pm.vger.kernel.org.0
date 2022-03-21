Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01AE4E2736
	for <lists+linux-pm@lfdr.de>; Mon, 21 Mar 2022 14:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347497AbiCUNIx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Mar 2022 09:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243574AbiCUNIw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2022 09:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2919C5938F
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2022 06:07:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A45FD61189
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2022 13:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F7F5C340E8
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2022 13:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647868045;
        bh=j/IiLivNUH51Mh9Bw8lEm0dIQ0A6/AXUsS0te36MkHo=;
        h=From:To:Subject:Date:From;
        b=S7cf60XNYVyihU7rBpqImq3eP0F1cbYPH3U4v0Vhn8+5oAnLIIfuI/OC6u7TEcUq/
         5073lx6SvAwJ3e+NqPESn+i3x46+jJjSV8TVK7xJBl0gxN1Kaq7HMMWIjRDmPJQoM4
         Cm7tPW/j712/VwuHP5ddVaLRARiGrnLk3iu2LdlsmswN2Bc08KU6zu7t/KaJWygJaG
         B8VrxtvC57JxQ5GDsRoLSJJdzmiTZHmgHcUiy5acUwL/MB7tKGpYKteKtf54WeLqrM
         Qe4taQkX3XOsc5ZFBeRaiqKrTnMXx7tiyuCTaNIQawdLfe34ZZx38gnZET9jfqRW1i
         Oc+dUtDQsp4iA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id F1A4AC05FD5; Mon, 21 Mar 2022 13:07:24 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215714] New: A huge unnecessary power consumption with
 CONFIG_X86_ACPI_CPUFREQ
Date:   Mon, 21 Mar 2022 13:07:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215714-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215714

            Bug ID: 215714
           Summary: A huge unnecessary power consumption with
                    CONFIG_X86_ACPI_CPUFREQ
           Product: Power Management
           Version: 2.5
    Kernel Version: 5.17
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: aros@gmx.com
        Regression: No

So, here's the situation.

I have a Ryzen 5800X CPU.

Whenever I watch a 4K youtube video (VP9 codec, Mozilla Firefox, no GPU
acceleration, decoded and rendered solely by the CPU) with the ACPI_CPUFREQ
driver the power consumption stays around 50-55 Watts while the CPU is
constantly hitting or staying around the maximum turbo frequency (~4.75GHz).

Whenever I disable Turbo Boost (echo 0 >
/sys/devices/system/cpu/cpufreq/boost), the power consumption instantly
deceases to around 39W with no difference in video decoding, i.e. frames are
not dropped, decoding is smooth and steady.

We are talking about a staggering 30% decrease in power consumption just by
disabling Turbo Boost and limiting CPU frequency to 3.8GHz.

I suppose this is not right and should be fixed/addressed.

I'm using the ondemand governor with default settings.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
