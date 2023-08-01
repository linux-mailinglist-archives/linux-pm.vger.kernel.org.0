Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7081B76A89F
	for <lists+linux-pm@lfdr.de>; Tue,  1 Aug 2023 08:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjHAGDJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Aug 2023 02:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjHAGDH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 02:03:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC868E7D
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 23:03:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 516AE61291
        for <linux-pm@vger.kernel.org>; Tue,  1 Aug 2023 06:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1659C433C8
        for <linux-pm@vger.kernel.org>; Tue,  1 Aug 2023 06:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690869785;
        bh=bVALq83PQZjjLUIGvXG2vDHmcJXdRcERAEwrvCFSLrc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=s8VF5kF3C1YiYcoCZVnRePx3UjqqHnBLWpQnrI21IWJ/EVeo2OuRJA2NP94njoFgN
         BZXtlh1DuHBFaGomVcb7VBwHne9IICsO5OnoDJVupFzQH1BpcwdBWxYTW34p0btsBg
         wTDNnuiNg5MUKVkQfQKePQH+O+c8wwQLaFfo9AwYvZK7oby0QDLzC9e0hAI/QGpPKA
         vPSmEKUfEXa/nYp3LpSKXtMH+3ydxqFyu9Gx9w85rSDLDFvwuI/w45TVwXLBF5+otG
         c9jPR0Xt/FnTXq7bYqxPHISTI2fzjgHQICrzgPtescVgo4k+VxuKywa8jMnWXpoeaK
         6S9JQEziilrZw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9640BC53BD1; Tue,  1 Aug 2023 06:03:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217630] Kernel fails to load amd_pstate driver on 3970x while
 Windows works well on the same machine
Date:   Tue, 01 Aug 2023 06:03:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: johnypean@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217630-137361-QZoxIewiUR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217630-137361@https.bugzilla.kernel.org/>
References: <bug-217630-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217630

--- Comment #4 from Jan Kosterec (johnypean@gmail.com) ---
Almost the same HW here.
3970x CPU, Gigabyte Designare TRX40 rev 1.1, BIOS v. FD.
linux kernel v. 6.4.7
No combination of settings activates amd_pstate driver. Error in syslog:

kernel: amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

In bios there are available setting CPPC and prefered cores, all enabled.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
