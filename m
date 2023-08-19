Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4EF781C0A
	for <lists+linux-pm@lfdr.de>; Sun, 20 Aug 2023 04:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjHTCea (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Aug 2023 22:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjHTCeT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 19 Aug 2023 22:34:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4501D83F8
        for <linux-pm@vger.kernel.org>; Sat, 19 Aug 2023 15:33:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB0C560B03
        for <linux-pm@vger.kernel.org>; Sat, 19 Aug 2023 22:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 311F5C433C7
        for <linux-pm@vger.kernel.org>; Sat, 19 Aug 2023 22:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692484396;
        bh=jf8X+L06YP/UosTz/HO/IdtH+J/+3sRvxO9MGrXYCb0=;
        h=From:To:Subject:Date:From;
        b=KaZVXwv4ByKTtYA9IZLl9CN7g33IfvgOPmdXQ4oKuQ7zMppwyDf/UOy75ABZkOgJS
         fqc7sjNAIw2O6ZuHC3s8GHJBNAqEck0uEX05SrHwUJS8Kn135XURUQMZLPIRu/Fq3Z
         RIIZ+GeC7EIUxorYNJRkyS7d9zFHNiSx0WmCDEHZ/MgGIZanh/9deBiwghn4rD3jX0
         DUGUeC4syDZ5QX3CUeK5827jxoQISneVlMfqpfn92WfKeIZWPmt01gmPS2Q1Df2ALH
         ew7D1XEr5Q1nZ/p8AgJQZSkiFuduQ3Kq7x+8AiBUtVbrtk3D7MwV4FX6WF26/dImL9
         9LFGqgZhFccFA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1A350C53BC6; Sat, 19 Aug 2023 22:33:16 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217809] New: Core frequencies do not float correctly on AMD
 Ryzen 7 5700U when running on battery
Date:   Sat, 19 Aug 2023 22:33:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: soren@stoutner.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217809-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217809

            Bug ID: 217809
           Summary: Core frequencies do not float correctly on AMD Ryzen 7
                    5700U when running on battery
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: soren@stoutner.com
        Regression: No

On my laptop running an AMD Ryzen 7 5700U CPU, when on battery there are
problems with the core frequency logic.  When a process consumes 100% CPU u=
sage
on a single core, the system forces the core frequency to the lowest value =
(399
MHz) instead of letting it float up to the highest frequency (4.3 GHz).  At=
 the
same time, other cores that have minimal CPU utilization will increase
frequency up to the maximum, meaning that the CPU isn't locked to the lower
frequency as a whole, but that something about
the frequency control logic isn't making the correct decisions.  This causes
the system to run very slowly when on battery.

When the laptop is plugged in the behavior disappears, with cores that are
consuming significant CPU able to increase the frequency to the maximum val=
ue.=20
Often after plugging in the laptop and then unplugging it, the correct beha=
vior
is maintained, although over time it usually reverts to the constrained
behavior.  Also, sometimes this behavior will disappear if the laptop is
suspended and resumed while on battery.  And, very rarely, the system boots=
 up
on battery and behaves correctly.  All of this indicates that there is some
power management logic that is misbehaving in a way that was not anticipate=
d.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
