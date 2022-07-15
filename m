Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACEC575D0C
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 10:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiGOIJf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 04:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGOIJe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 04:09:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054031B78E
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 01:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2850B82ADF
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 08:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 268F7C341C6
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 08:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657872571;
        bh=BhALceA4QuJrmA6m4s/SfPPz4763/9awtJXO3LmK6g8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eghTpTHFBirXm+wC6ron+/P5Kigqgn5Ah9Clzo0d2iX6WhoF5CybtuClB53lY0VSX
         ELxCJ6U3kFja16WIZ0CBJNPmNl7Qn/h2K9CYT3FkIeWEgyXLr7mQrGUT/m2AKIUbxN
         WZBxP13aZZDXL03dHT4NbH+NqYWj/O/CnKLJeC7rEpnWRARb6eY8uWAzBDP0z3WeTw
         nk/7qxfgnaUeiSoQgfRaYpxL06+lU0HvbARLN3g+beeRv1Xmy5Y054qoHR+kezcAGx
         QEuEbbm2lPSz52JOKSgu8UwSWDfWOqFBLRJlN6xtLyFmk+0Ap65Aj9yJp4azGgOskj
         zsxX6binCkjIw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 126CFCC13BA; Fri, 15 Jul 2022 08:09:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 08:09:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arek.rusi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216248-137361-HnyRgfBoUX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216248-137361@https.bugzilla.kernel.org/>
References: <bug-216248-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216248

--- Comment #3 from Arek Ru=C5=9Bniak (arek.rusi@gmail.com) ---
I've built ...git/rafael/linux-pm.git #branch=3Dbleeding-edge (as far I can=
 see
it's match linux-next) amd-pstate not working.

I've done any dumps on this build (hope it's not a problem)

1)it's loaded but not detect boost (but according to turbostats boost works)
2)will be uploaded
3)yes, you have right:
 [    0.494379] ACPI CPPC: CPPC v2 _OSC not acked
 [    0.494388] ACPI CPPC: Flexible address space capability not supported

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
