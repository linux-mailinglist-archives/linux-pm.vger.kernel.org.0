Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD773B9A1
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jun 2023 16:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjFWOPI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jun 2023 10:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjFWOPF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jun 2023 10:15:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC50F2696
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 07:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DD3261A5A
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 14:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E13C1C433C0
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 14:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687529702;
        bh=conaE5lscTt+B8k1OO4KkIxlHXrLDYjllOhUKIA8AzU=;
        h=From:To:Subject:Date:From;
        b=mSIiqx5WzD6Ln/T7xtVBPoIh6HQzjMu5Vdvl4oYdZmFs1V936kWCQQCAx1tmcOyKi
         D4j7/jDJwn5rb+lW8+poWeKYBfm4zsianONPuTeLqL4oe1ujdO5pnOgfxBZFvr6fsa
         Nuh7bAcYwN/69oi4Mper/vAuYFaRFI0x9jhKVGQTSCupokkRS28QJjxY7euW9CO1uB
         cZ8aDLA/E7irpVxBWR/LycwDmMvSZW5Y9la/YDchG+3+XcqPYGdL/ceVC+tAJ4a4t+
         Gw9BMV0vQKFvFWG6QE9jd4GBnn710fIZ+RZUkVcLVabk68v38Vcds+uxpKG9G4qLCl
         d6xyydzu6M39A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CE092C53BD0; Fri, 23 Jun 2023 14:15:02 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217589] New: Intel CPU maximum boost frequency reduced after
 resume from suspend to RAM
Date:   Fri, 23 Jun 2023 14:15:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217589-137361@https.bugzilla.kernel.org/>
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

            Bug ID: 217589
           Summary: Intel CPU maximum boost frequency reduced after resume
                    from suspend to RAM
           Product: Power Management
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: bjackson0971@gmail.com
        Regression: No

Hardware: MSI MAG Tomahawk Z790 Wifi motherboard, 7D91vH6 BIOS, with Intel
i7-13700K, p-cores overclocked to 5.5GHz, e-cores overclocked to 4.4GHz
Kernel: Linux fedora 6.3.9-200.fc38.x86_64

While running: sysbench cpu run --num-threads=3D24, then run cat
/sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq | sort -rn

Correct output after reboot:
5500054
5500054
5500000
5500000
5500000
5500000
5500000
5500000
5500000
5500000
5499945
5499945
5499945
5499945
5499945
5499945
4400096
4400044
4400017
4400006
4400004
4400002
4400000
4399960

After suspend to RAM and resume, CPU frequencies are at hardware default
without overclock:
5399941
5399941
5300057
5300057
5300000
5300000
5300000
5300000
5300000
5300000
5300000
5300000
5300000
5300000
4500000
4499951
4200050
4200038
4200036
4200004
4199991
4199985
4199963
4199897

CPU boost clock should retain overclocked speeds after resume from suspend.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
