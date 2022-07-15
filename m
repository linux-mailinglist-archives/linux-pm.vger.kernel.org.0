Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FC6575EB6
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 11:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiGOJiB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 05:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiGOJiA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 05:38:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EDB7E83E
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 02:38:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05AA7B82B4F
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 09:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83692C341C6
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 09:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657877877;
        bh=mGtnvcFKcJPQpM/g66VGkDlbAWmN4aNUqq62lJp7AFQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=q2YUk3+PKPBIgx67AHueW1hoeKm4YPJtChywUVVtD85H6jhN895XrD7qucioxhIhy
         cNVMU2nAPETPGFvphYsrhAaHEF01eJiVnxNZAEUJJbvFX29d4ef+AwKkBJ/pWCs4tl
         PuTT1urN3AU2TBXxlI+0f2qeFqsyb3Kb/dME9Fi3zTo4a6kDBppVD/AgIih0CbFeil
         jh/lVXchyHl4VEPNjmHsvdCdsCNGbLGZDJFVn2ICjaRKeaD7I6+WJZJjeu/zslZpk5
         RN+MGiRsCr3V9YgzpZoZK0qd9Ob/XY+V9/zwLSLVj+BVEZd+Oj39Nu/nKdvLKwKCFM
         58sPhJEMHgaLg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 70159CC13BA; Fri, 15 Jul 2022 09:37:57 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 09:37:57 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216248-137361-HF8Y3BD99x@https.bugzilla.kernel.org/>
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

--- Comment #9 from Arek Ru=C5=9Bniak (arek.rusi@gmail.com) ---
Created attachment 301435
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301435&action=3Dedit
dmesg 5.18.10 - with working amd_pstate

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
