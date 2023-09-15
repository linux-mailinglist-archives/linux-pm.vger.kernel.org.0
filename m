Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0F97A1C41
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 12:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjIOKaU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 06:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjIOKaA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 06:30:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81723A99
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 03:25:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C1CFC43391
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 10:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694773460;
        bh=m1yN1kEE2UoM3G1ELTP375d97djsdLwhqrJGNUb8xpI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hQ8mGvKbfU9IpFRRO83gcZl/NOeE2gPMxDZu5p5GoYpBcoaTK6jwwUR3glecQB8P6
         diERYPrDeQcJcChiAtRl7MCIm4EzIri9wkX3CQnc/KPZoWtJghpgaHdhOVBCqRTlBV
         9u6Adb+1tXcKEEzAAn8gwfqleps+qV1vOTknWqnPERV+8vAa4AUvmDp930343bYYmd
         CPOpRt4pqJG2b9HumIWnE9r574bRj7uPkOOQXYpqjjr94wTI2/BPGAK5LYdeQiYFri
         SodjWVLfNzJ9jYhTssUCLBt48I8OouCM9rEDyzRhwVUnLmVKMJRmeJa1Gqk6GWeuZE
         ZVZ8FbB00CtVg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4C6C3C4332E; Fri, 15 Sep 2023 10:24:20 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215729] amd-pstate driver has a much higher idle power
 consumption for a desktop Zen 3 CPU
Date:   Fri, 15 Sep 2023 10:24:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215729-137361-0Ly8iMpwkM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215729-137361@https.bugzilla.kernel.org/>
References: <bug-215729-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215729

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--- Comment #11 from Artem S. Tashkinov (aros@gmx.com) ---
~1W is nothing to worry about, let's close this bug report.

For mobile CPUs there's seemingly no difference at all.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
