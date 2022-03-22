Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7066A4E49D7
	for <lists+linux-pm@lfdr.de>; Wed, 23 Mar 2022 00:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbiCWAAm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Mar 2022 20:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCWAAl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2022 20:00:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB581FA65
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2022 16:59:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3601B81DAB
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2022 23:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56D26C340F3
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2022 23:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647993551;
        bh=AK57SBTwC7FJH0qaUmhd20bVaqki16Zowf2h2T7SnKY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JFA8hz/WBrdln/Mpi8jSsWQzhsPflrVZK2biMaVOvVMV0uniDqIVsFv2ndFiScvkK
         QPh3mvK/cEjDQSid5utJkZh/xPLi+/xP4V6rrnJE8ybEpUWvsG8GoB459ngo0X63L1
         rqfGbYwq8qaCg8TZaBWBiR9Z02Bf5+/stHSi+ec8dxWSnBbR5CQuDMBUnFHoP80v6S
         WiVcoZykLv/wPrb+hXfxHixTlhyRUtIShA1WUURG0kBuwzOirGVgQo7a5nDRgYCuol
         3WVFMJX0lNQ6rdqMX6PyASTlXwDcMfJvFl4eancQAV8QxjZaIVa0+XzOGymXyGiYKF
         XeVptjO8efaBw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 46DB5C05FD6; Tue, 22 Mar 2022 23:59:11 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215729] amd-pstate driver has a much higher idle power
 consumption for a desktop Zen 3 CPU
Date:   Tue, 22 Mar 2022 23:59:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215729-137361-xrVsPP4xWJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215729-137361@https.bugzilla.kernel.org/>
References: <bug-215729-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215729

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
At least under Windows 10 I see effective frequencies around 50MHz (i.e. co=
res
are idling as much as possible), that doesn't seem to be the case with Linu=
x.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
