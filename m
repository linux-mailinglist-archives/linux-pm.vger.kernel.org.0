Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9831575671
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jul 2022 22:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbiGNUkd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jul 2022 16:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiGNUkd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jul 2022 16:40:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C432459B7
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2022 13:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 148F760F80
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2022 20:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A087C341C6
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2022 20:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657831231;
        bh=sVUNeSwUTaywLCQaqs/iBHvjU9NBP6ZRA+ca6v50ph4=;
        h=From:To:Subject:Date:From;
        b=PNPZoI5tw7RoPx5h4HcAYEjZl3LMStfwBph4aL1HP9nj2/6DjSw+aiod+qKhigNIe
         Z/sdwTmtxr+FKzuJ+fapSC1LEPeypdrgA1qowvoKg3x9HEAFJxPqneuhRMEPQtGTX9
         2nOMeUU++MO9aRhpOFL0IvpRj5EOcR7axdlV/i4M9pw8R62A4ghTmxi+VDzuLXn+lz
         bXjZywaKkuZXPXuZtkEqjegI9RW1KNmhPTGpdPXazpDqwT4LAO8D4FIQIZKWMNL3VN
         LDZhfgz44uxCxcr9iDME0BGg66AHJz3FPbsPJ5vRgAVrv2xbUfwiWGU82Lg3f6fpax
         J2gtVTYzT2ARg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4D52ACC13B0; Thu, 14 Jul 2022 20:40:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] New: [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Thu, 14 Jul 2022 20:40:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-216248-137361@https.bugzilla.kernel.org/>
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

            Bug ID: 216248
           Summary: [Regression] amd-pstate stops working after [ACPI:
                    CPPC: Check _OSC for flexible address space]
           Product: Power Management
           Version: 2.5
    Kernel Version: 5.18.11
          Hardware: AMD
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: arek.rusi@gmail.com
        Regression: No

Created attachment 301428
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301428&action=3Dedit
lscpu

Model name: AMD Ryzen 7 5800HS with Radeon Graphics
CPU family: 25
Model: 80
Flags: ... cppc ...

amd-pstate won't load:
modprobe: ERROR: could not insert 'amd_pstate': No such device

first bad commit is: 13bb696dd2f3bd5f23a6be2d97063ee3bdb6b690
[ACPI: CPPC: Check _OSC for flexible address space]

it cannot be simlpy reverted unfortunaltelly=20

Issue is quite simmilar to:=20
https://lore.kernel.org/lkml/3559249.JlDtxWtqDm@natalenko.name/

To be sure i've tweaked that patch to fit to my cpu, but it didn't work.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
