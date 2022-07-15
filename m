Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEC55759D7
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 05:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiGODM5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jul 2022 23:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiGODMz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jul 2022 23:12:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06311C903
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2022 20:12:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D3A3B81A73
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 03:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEA19C3411C
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 03:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657854771;
        bh=Yl9czywWQjax919EO97/uHT5nGs+0/z8EJkWAog4cbg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oBJgYYYLL4comjRr4Z/beZWG+E159wuKDPJdd0h5a0/suaTUvKQnxWewxcWA8TAuI
         /gp2EseMuZU/5azJokW/y1foJJnWZU1y70zCvD18HVCPjhOPZ3lINVAYJxIr23kf2V
         7bppudjlipx28MD1JAoh+bqhlkcaAI/1O8NO/H+YM/T9GH4kktno2Z7Ip3G7+TQ9at
         ZqxGDBUyK2uVBj5q0BQzILuRzzIL3Zcn+CXfU4a+qt+rV3Zeep1TlilggWneUVPWxJ
         epSZXLnM3+ylOdWZsDB1k1hEWz53JniTPiNFFaoarEjbRN07fiMbh2NqVH9lXuxUj1
         6p8MWIFWXN56g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C22F4CC13B7; Fri, 15 Jul 2022 03:12:51 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 03:12:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216248-137361-VLUBTpNKys@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216248-137361@https.bugzilla.kernel.org/>
References: <bug-216248-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216248

--- Comment #1 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
I believe your CPU should support the MSR approach.  It should have been fi=
xed
by "ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is supported".  You =
can
see in your lscpu output the "cppc" flag is present.

That other patch won't matter.  That patch was specifically to fix "ACPI: b=
us:
Set CPPC _OSC bits for all and when CPPC_LIB is supported".

A few asks:
1) Does acpi-cpufreq work?  Or that's broken too from this commit?
2) Can you please share your full dmesg and an acpidump?
3) If you turn on dynamic debugging for drivers/acpi/cppc_acpi.c do you see
"Flexible address space capability not supported"?  I would expect yes from
that bisect.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
