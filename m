Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8961575F70
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 12:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiGOKgd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 06:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGOKgc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 06:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBBC83F10
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 03:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DAFB62248
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 10:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BC24C341C0
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 10:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657881390;
        bh=xbEY6cbsX9p2X6BGZ+RlVy3jNalWuqwr4z2w9W81aC0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NffSax9mUPxby0KxcUU7koAAS4JfmkjpJEbHDErTdi2g9+BQkz9N5s8YpLYvK4GWC
         i5gdRYPa90B9VpngDFxPldlkjiy6g02cDGZF8TMBe2+HAl/VKe9By+sguUjY/zCFf4
         B4jgLScU2VKrLpELyl0mm/Z3Q9T7y003PYO3JpKM/PZT43Zf/JtPKc7rI9PBRd5U9U
         ku3qamXI9XVI4hyCxq7HcENkhiZD3TZCvEPR4VHafq54/aJg1pd7rvvik6sFy2VM5n
         G7WPHkBdA2OYQrTJ1hMIgyVPpMNDloHMn0u4kmFJAXZXKWSsrjA6mCJW8ZjxS/Z7ss
         4cav9BeQp9GgA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 642F0CC13BA; Fri, 15 Jul 2022 10:36:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 10:36:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: manualinux@yahoo.es
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216248-137361-RTVb8t8ejM@https.bugzilla.kernel.org/>
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

Jos=C3=A9 Luis Lara Carrascal (manualinux@yahoo.es) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |manualinux@yahoo.es

--- Comment #10 from Jos=C3=A9 Luis Lara Carrascal (manualinux@yahoo.es) ---

Hello,

I have the same problem with kernel 5.18.11, which is still in kernel 5.18.=
12,
released today.

I have an AMD Ryzen 3 3100, and I use the kernel boot option:
amd_pstate.shared_mem=3D1. With kernel 5.18.10 and earlier, no problem.

Regards.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
