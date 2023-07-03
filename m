Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BD874617D
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jul 2023 19:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGCRiZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jul 2023 13:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGCRiY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2023 13:38:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4907AE6C
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 10:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC75E60FF1
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 17:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EF9CC433CA
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688405902;
        bh=dusbUbnnL2mAASHuow+7OxnXUPHxyl2Eqvjb2zkFIhs=;
        h=From:To:Subject:Date:From;
        b=KP8Z0m4KiaPNtFz/1seRqcmmizrBFyuaVBcmD4Z+PiqS//ICWW4PoXSOst0PSwcea
         ccykImuuxUpVyI/DhU8WxuvvlxtCNUn4qpXlSRs4Wd3fMvU41E4IQVO6QWieNL0++J
         zukb+Or+OC92LYIUMAEb21Q81UllvvatimYZ29wEPoueuqKi1BvPKPjChGeGDDMTEv
         fmjj1AbnUz6BegephKDpwNqexPqCtR462wA5n5AWeI10d+IETiMwzBCoUikrj19xy1
         3s8/wUeY3IIwWOEgw8FDRCP2PKzGS6RSLqHzEy2F5zesVgvqwSoqksP/eXtqCFdP3l
         uJtHcu6N7mLBA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 28661C53BC6; Mon,  3 Jul 2023 17:38:22 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217630] New: Kernel fails to load amd_pstate driver on 3970x
 while Windows works well on the same machine
Date:   Mon, 03 Jul 2023 17:38:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: pshirshov@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217630-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217630

            Bug ID: 217630
           Summary: Kernel fails to load amd_pstate driver on 3970x while
                    Windows works well on the same machine
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: pshirshov@gmail.com
        Regression: No

I have 3970x CPU installed into Gigabyte Designare TRX40 rev 1.0 motherboar=
d.
The UEFI is updated to version F6 so AGESA has version 1.0.0.7.

CPPC is explicitly enabled in UEFI settings. It definitely works in Windows=
:=20

> Information   7/3/2023 4:46:04 PM=20=20=20=20
> Microsoft-Windows-Kernel-Processor-Power        55      (47)    "Processo=
r 63
> in group 0 exposes the following power management capabilities:
> Idle state type: ACPI Idle (C) States (2 state(s))
> Performance state type: ACPI Collaborative Processor Performance Control

Kernel 6.3 fails to load amd_pstate with both "amd_pstate=3Dactive" and
"amd_pstate=3Dpassive" kernel parameters with the following message:

> amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

Kernel 6.4.0 doesn't shows the same error "amd_pstate=3Dactive",
"amd_pstate=3Dpassive" and "amd_pstate=3Dguided".


Please help.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
