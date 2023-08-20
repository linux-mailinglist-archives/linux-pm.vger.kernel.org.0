Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D4A781FB3
	for <lists+linux-pm@lfdr.de>; Sun, 20 Aug 2023 22:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjHTU2Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Aug 2023 16:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjHTU2X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Aug 2023 16:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7535919B5
        for <linux-pm@vger.kernel.org>; Sun, 20 Aug 2023 13:24:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCA5560FAB
        for <linux-pm@vger.kernel.org>; Sun, 20 Aug 2023 20:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21C24C433C9
        for <linux-pm@vger.kernel.org>; Sun, 20 Aug 2023 20:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692563084;
        bh=27zmgiMb7C5umEFTCkRD8VcNzOCOpNFRgn17Rizi0w0=;
        h=From:To:Subject:Date:From;
        b=InOy2j9FJsE/50Is/7n3MX7igqK0KgoIbJdHTXMsNNN/N4wRgd8snIe8+ccf04j0o
         7yU1iVdxGL305IrmZXELUwur8EtyoHsWt6t52XXaBlXsqDOusF0xZjmFa7SjV/sbFH
         f5PjpMSPbBFLIJjBQ/94mp4RboiVi+liVswPoYr6EdRMwiPu1Ot4zqrl8Fy1rmUdXq
         WW53mXqX+SEjWDJNM5i33n4GZaIYUttNNHqu2caalXGrUJqZ2LuEP0JArFPowlzrsi
         jHyusaIZRiqbZVXAJD+Uv9zkgLLQckw2iefKJTpt10yetqUIXBUHC6fGFliRntVCgQ
         opwdR/cof+rQg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0E3C5C53BCD; Sun, 20 Aug 2023 20:24:44 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217810] New: Lenovo Ideapad S145 CPU frequency stuck after
 waking from sleep
Date:   Sun, 20 Aug 2023 20:24:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mysignup27@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217810-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217810

            Bug ID: 217810
           Summary: Lenovo Ideapad S145 CPU frequency stuck after waking
                    from sleep
           Product: Power Management
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: mysignup27@proton.me
        Regression: No

Lenovo Ideapad S145-14IGM
CPU: Intel Celeron N4000
Fedora 38 KDE

The problem is that after waking from sleep, the CPU frequency gets stuck on
the minimum frequency (1.1GHz for this model).

I reproduced this behavior on an old BIOS and the latest BIOS (AWCN30WW).

I found this solution to work:
sudo cpupower frequency-set -g schedutil && sudo cpupower frequency-set -g
performance

This needs to be run 4 times.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
