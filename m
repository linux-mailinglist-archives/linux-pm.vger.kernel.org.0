Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63683576460
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 17:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbiGOPUq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 11:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiGOPUp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 11:20:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9895B54
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 08:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AA03B82B3F
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 15:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D1EEC341CA
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657898442;
        bh=U46/GDok6rBsTnXlQGq9Q2K/glZRZ5zACvs5Hgzz+lU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TatRfuUCIRq0hUdqyNWnI+mQ+8PUSLjVgK76jNcXYpTOzUyhQI8vhM95Zct4sVaW2
         9KyqWEaECBPksmuJoBJIkBNJad+Aug/ZF6DnIQltRApvl6Inq/Q83QL018bEGyso03
         FZZqSZSBv2NWdSlBrMbPMs+sw7xumpeVZen4NUGb4RWdr1ZtZd6E+4kIqEum3zrtD5
         ZJ3iWjbAvXEmsXuertnCn8BbqkxhoD04vnzI2uzrIx8BYehjPki0H596uLewZFk8z1
         vr4SJW1uu5Jm7zMauPk2yWLZ2S/stF9HP9UZFXLtjd4JXnF4JtMyxY5JRjyzYtG3Sy
         kmsjPPTHYMotQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0AFA7CC13AD; Fri, 15 Jul 2022 15:20:42 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 15:20:41 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216248-137361-TX3Ptoh3RE@https.bugzilla.kernel.org/>
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

--- Comment #15 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Created attachment 301440
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301440&action=3Dedit
possible patch to avoid the error

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
