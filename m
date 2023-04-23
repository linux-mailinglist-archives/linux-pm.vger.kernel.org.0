Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A9D6EBE12
	for <lists+linux-pm@lfdr.de>; Sun, 23 Apr 2023 10:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjDWImC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Apr 2023 04:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWImB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Apr 2023 04:42:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9241BC2
        for <linux-pm@vger.kernel.org>; Sun, 23 Apr 2023 01:42:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A053060C2A
        for <linux-pm@vger.kernel.org>; Sun, 23 Apr 2023 08:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0940DC433D2
        for <linux-pm@vger.kernel.org>; Sun, 23 Apr 2023 08:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682239320;
        bh=JLFjmXRGy0ivUEuNYMjf0buFKBninMb9oeGcnwrrF9c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jHAmA1DJrMRfPpS10V6Nll6emrJQDYe00XqLtLgOLdmxuVMBvdR2kEf757AmJ0AJq
         DgbLySNQ24xRUCNe3gjb7iRMCwi1S92jp5meNfwenaNx7kBYnIuikl7joHUA1G5ga5
         d3JzDnpBevYafcECzqEFXuA3QA5a7VS+f3GvNWh1ajiiUyYJ1MK4E7/V0axKYgmZow
         6kNtXFgs1jgxLohNu0AS2qd9VAGxG0xee9HieBfwfMx3f8hxldDC/f3TKzo2J1sjAg
         Y454+5o4zxyGKUEZsh1IDM/N7fbdIg90mVhAQX4g+qZOfoz8EO2b4BYJThvpT2UUv8
         wisqPv8QNDvOg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DB6A3C43143; Sun, 23 Apr 2023 08:41:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217361] AMD P-state driver is too aggressive by default
Date:   Sun, 23 Apr 2023 08:41:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ahmedmohsin6@gmail.com
X-Bugzilla-Status: REJECTED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217361-137361-SNVkRKRhws@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217361-137361@https.bugzilla.kernel.org/>
References: <bug-217361-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217361

--- Comment #4 from ahmedmohsin6@gmail.com ---
(In reply to Artem S. Tashkinov from comment #3)
> You're using the "powersave" governor which keeps the CPU at the lowest
> performance at all times.
>=20
> Please switch to ondemand or schedutil

Is this change intended then? Powersave mode in acpi_cpufreq wasn't this
lowest. I'd like to save battery since I'm on a laptop.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
