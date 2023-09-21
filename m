Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D667A9F66
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 22:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjIUUVk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 16:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjIUUVR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 16:21:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB59400D8
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:15:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 962A4C433C9
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 05:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695273907;
        bh=c58xEsygUdws9xzfrFKFJkrkCVDiywjPhuXf1PYl/vA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EhnJoo8dWXvbEBZb0mt1KGfORDsoHM5HE9EnX+rr+WNVQ5M32GvpewRzTh+/W3tmc
         3hYzFqAe3MirrC/ukJDC7is2TMMm2GFeIiZX2HiCqU8twjX/1OChB63vmD0O8dFm6d
         oLx5iJzM5T9cTPDb6V4sJCQylnUKi3JVd869RN6CbthhuLH0UTofdwBPKaSve4IgI1
         GHW0GXUhoK+TJvM4g87uH4edy2KPLWTeTbs9ML1PWh+O4ulnt3R/hluR0q0dV31TKQ
         +SVGV1gL7plOlaaSHjS4SWVQDwPb7GCpeFL3HAEcbjxT2NY0mXYNz/5nXQCLmX18f2
         ouVXUHLm0vxqQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 7CE5EC53BD0; Thu, 21 Sep 2023 05:25:07 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date:   Thu, 21 Sep 2023 05:25:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217931-137361-nN2QvCF5Yc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

Perry Yuan(AMD) (Perry.Yuan@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |Perry.Yuan@amd.com

--- Comment #4 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Artem S. Tashkinov from comment #0)
> Created attachment 305131 [details]
> Power Options: Processor Power Management in Windows
>=20
> It would be really great if amd-pstate had a feature parity with
> acpi-cpufreq, namely
>=20
> 1) Being able to set operating frequencies (maximum, minimum and
> user-defined)
>=20
> 2) Being able to enable/disable boost
>=20
> Currently both features are not available and frequency control is simply
> ignored (bug 215800).
>=20
> Rationale:
>=20
> 1) This is required for benchmarking and proper temperature control. Boost
> frequencies are subject to multiple limitations (power in watts, amperage,
> voltage, temperature, BIOS limitations) and can change depending on the
> workload. Setting a low enough frequency allows to run benchmarks in the
> controlled environment and get proper data.
>=20
> Windows allows to do that easily, see the attached screenshot.
>=20
> 2) Disabling boost is an easy option to subdue operating temperatures tho=
ugh
> if the previous issue is tackled, it's not really needed.

Thanks for the suggestion.
There are two modes for amd pstate driver, one passive, and another active
mode,  the passive mode already has the boost control feature.

# cat /sys/devices/system/cpu/cpufreq/boost
1

I have raised this requestion and will get active mode supported with a new
patch.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
