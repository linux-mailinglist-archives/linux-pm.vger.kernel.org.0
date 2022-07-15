Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C5257645F
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 17:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiGOPUZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 11:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiGOPUU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 11:20:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B3C27FF3
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 08:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E47E2B82B3F
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 15:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D7B9C341CA
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657898416;
        bh=q9g67ujdA1v6UzI34htdZTT2fsSIkcchhFQ1w8dcUtk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MfLUbA2zYH1cfdoI+dvOm/5ijZg22aMJw8qRIAWDgYuAF/2Bcl3TlIRPT4KzIlAeC
         voB/BWNvYCfW2zd9uPpjuLEXd3F9BQTqqmZjTGmXLVDTGeNqqVb2hCFyWzyqcIYAX8
         HvL4hJEO3R5aGcBXWRSIa5Q787OhaKob61SWLSQgGNBLgUF6zcCU51STDGRNLnipbj
         9gQiPHyqrBggfL5KSk757q9FfcdZQjFg1ceKrr8ZHBicxZE1JMFZxHtp7Y9TZZM1fV
         I8AXersnLRX/D5ZJ99w4g8+vWWP3dzYl63rvVEVwbTeYcjnTShyba6j/PIezcqc5yC
         DT9YSDNY29Qsw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 766E1C05FD6; Fri, 15 Jul 2022 15:20:16 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 15:20:16 +0000
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
Message-ID: <bug-216248-137361-H9j6UeuqfH@https.bugzilla.kernel.org/>
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

--- Comment #14 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
> [    0.688308] ACPI CPPC: CPPC v2 _OSC not acked

OK good, this confirms that your system had _OSC not advertising.
> [    0.688392] ACPI CPPC: Flexible address space capability not supported

That does confirm that your assertion of the bisect was the cause.

I'm attaching a patch that I think can help the problem.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
