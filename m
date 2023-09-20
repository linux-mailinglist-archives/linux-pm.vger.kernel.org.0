Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DB77A7A04
	for <lists+linux-pm@lfdr.de>; Wed, 20 Sep 2023 13:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjITLG6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Sep 2023 07:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjITLG5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2023 07:06:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD869E
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 04:06:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6629CC433C9
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 11:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695208011;
        bh=XcdeCTPnMeCkMjggE9AqWXJZOEwToBOXJHN32JLnNzs=;
        h=From:To:Subject:Date:From;
        b=onisfrOWqITpb+jyRBt2Zr6zoO6zjNbwC2ixjueguuHKeb8iuR2sXSry29ACxJtfp
         eix2uv7pwqtwODP9vxunG4ScThE9bU8+NyqGF02VmhRtGQ1DPfskYFpof6sHxTVoAH
         8tcZkd3xqnx1PJRGEYH6IMs1H3LeB7fCcfZ3fhbVIQuq/k9bOs1Qzn1e1+CHUaZd2X
         IYTncxb8KGfkAkGbYRM3HsYWwE6LiT1fZzDu8GyOlXdeDVRAG8sCaKLr7jzjGBgqAF
         TVhhiQIQx21Jm6hq+97NMl27KNkXwH2e8Z7unVwTZThiWDa1Upi7Mr4znQZOMDNSD9
         M3w6gUL+3Ruhw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 522ECC53BC6; Wed, 20 Sep 2023 11:06:51 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217931] New: amd-pstate lacks crucial features: CPU frequency
 and boost control
Date:   Wed, 20 Sep 2023 11:06:51 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-217931-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

            Bug ID: 217931
           Summary: amd-pstate lacks crucial features: CPU frequency and
                    boost control
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: aros@gmx.com
        Regression: No

Created attachment 305131
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305131&action=3Dedit
Power Options: Processor Power Management in Windows

It would be really great if amd-pstate had a feature parity with acpi-cpufr=
eq,
namely

1) Being able to set operating frequencies (maximum, minimum and user-defin=
ed)

2) Being able to enable/disable boost

Currently both features are not available and frequency control is simply
ignored (bug 215800).

Rationale:

1) This is required for benchmarking and proper temperature control. Boost
frequencies are subject to multiple limitations (power in watts, amperage,
voltage, temperature, BIOS limitations) and can change depending on the
workload. Setting a low enough frequency allows to run benchmarks in the
controlled environment and get proper data.

Windows allows to do that easily, see the attached screenshot.

2) Disabling boost is an easy option to subdue operating temperatures thoug=
h if
the previous issue is tackled, it's not really needed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
