Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE59C7CC991
	for <lists+linux-pm@lfdr.de>; Tue, 17 Oct 2023 19:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJQRMA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Oct 2023 13:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjJQRL6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2023 13:11:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408F6D3
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 10:11:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E06FBC433C9
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697562716;
        bh=siPgSrwqCsCLZWI/CZ6S1iyQ60g4grbkkj+6IMjsIDU=;
        h=From:To:Subject:Date:From;
        b=FE4XnahLanya7nc19wR8eGkTmnoWEPGVv6YHjfpXM7i9XhiwqvqLG4xeRHJhqOdmB
         WcDO3x2jMifXtMFw4+UqI7wZnVOY+tVx79uNovJudmGQACRZxODXTntzPEAIIzHRlh
         jq2MCmXUkOGYeJdPSvMV0fBty14hQL1lQcnCl+FUCk5gfLjqCdw/opJ85N+EsEmnX2
         Mix7lyn5FYdRbc6/umBhVjeun02t/K8SbSDMXhKUx8N5815gKcAiG+z6RmtU2HfsTZ
         geyhYb1a68jLcB8MScG0NjOOzvERYzPLufhorZCsHlZGp9XKISIuUHyGz4F4OzQtfO
         YAelIvueEv5/Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CBBAEC53BCD; Tue, 17 Oct 2023 17:11:56 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218022] New: CONFIG_CPU_FREQ_GOV_SCHEDUTIL - 10%-12% reduced
 performance in lower priority processes on ADL Intel processors.
Date:   Tue, 17 Oct 2023 17:11:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218022-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218022

            Bug ID: 218022
           Summary: CONFIG_CPU_FREQ_GOV_SCHEDUTIL - 10%-12% reduced
                    performance in lower priority processes on ADL Intel
                    processors.
           Product: Power Management
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: ionut_n2001@yahoo.com
        Regression: No

Hi,

I have noticed for some days, working on an Intel ADL system, that certain
processes are not processed correctly at certain low frequencies, and the
return in frequency causes the applications to go under glitches.

How could I test to see if there are problems from the scheduler, C-state or
intel_pstate?

CPU: 12th Gen Intel(R) Core(TM) i7-1260P

5.15.0-1042-intel-iotg (5.15.122) Ubuntu OS

From what I see on ADL the performances are relatively good, but with C-sta=
te
disabled they are improved quite a lot.

-  processor.max_cstate=3D0 intel.max_cstate=3D0 processor_idle.max_cstate=
=3D0
intel_idle.max_cstate=3D0

cat /proc/cmdline
BOOT_IMAGE=3D/boot/vmlinuz-5.15.0-1042-intel-iotg
root=3DUUID=3Dd52175e7-4bd5-4a56-891f-f5961006330f ro processor.max_cstate=
=3D0
intel.max_cstate=3D0 processor_idle.max_cstate=3D0 intel_idle.max_cstate=3D=
0 quiet
splash vt.handoff=3D7

With all parameters in cmdline, the system becomes stable.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
