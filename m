Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFE5577694
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jul 2022 16:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiGQOGq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jul 2022 10:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiGQOGp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jul 2022 10:06:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6796E13E35
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 07:06:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C69CB80CB1
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 14:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9CC8C341CF
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 14:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658066801;
        bh=GnHIs+7rfdp1/o5u3iWDYzbPZX7l/7vXkKqA+HOsqB0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iKWHjvNWIgyN58Yy9/R5X6asqHsDTg29vSOoZd91mOcmsQY8ufYNAR253cIpb+hvv
         KM0ky8KCX8hseWpYbIWLIbPDKJgP9Ssx7dvEDSdkcDnSlpkpgAzGe9/apv/HUcMeHK
         NLx4m70gR69NAOI0AG9zsKflfqtx6LmuYDLHDp5xqjIvAylCRiJE6m6kFch2PgLpuK
         1qfXRF+sdOzFg/EpnZ1KBg8MNBgTNMngUJQkA/Bj+vo0aGpx2BHE2pvuIdQ3ZnXUDD
         XuLVjCHIRyrEm5tQxwmVzF5xsIl/QVqCeZPzA/7N1b91JGC0uYaGm35/hQ2v3UtGxr
         UE8W4s00TCN9Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A033BCC13AD; Sun, 17 Jul 2022 14:06:41 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Sun, 17 Jul 2022 14:06:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arek.rusi@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216248-137361-Syq3Nn0N5L@https.bugzilla.kernel.org/>
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

--- Comment #20 from Arek Ru=C5=9Bniak (arek.rusi@gmail.com) ---
Hi, phandrix did you read issue i've mention in #1
https://lore.kernel.org/lkml/3559249.JlDtxWtqDm@natalenko.name/
an patch for that issue:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?h=3Dnext-20220715&id=3Dfbd74d16890b9f5d08ea69b5282b123c894f8860
if it still not helps, and you don't have 'cppc' flag in lscpu output please
file a new bug,

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
