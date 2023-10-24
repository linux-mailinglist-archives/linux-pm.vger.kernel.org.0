Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0C07D4E5F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Oct 2023 12:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjJXK5A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Oct 2023 06:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbjJXK4x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2023 06:56:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF1D10D1
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 03:56:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0141C433CA
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 10:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698145005;
        bh=BbbvGohHqY8PNzh+Jzn7IGAm4cE8tj717zarH6crdWM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JKo6SjHhJxr0dHvgh6ZFOTPX8OtHu8R5kLpqyEwIZ7iuJPABLeK+0F3lDbCjidX9c
         pfrLM7T1g7cMFm+pO7Y+hVUDNAIMDrYpuKfXHs37HbkMBm2nWKiqHrMvTNO4dQF174
         46iGYcIrfeoAnT6G6StZmh6AL0capudV7DAUxiKePnHEGbz+ViuwCwLQMKRJ9XRxza
         6m/XL255iSUGi3OhxtzCsyshtW6Ff7+XkKy5TA3Lct/QetFbyFUMRTaRcgK2V+f2Aa
         utTuWeUBeFKSy+814N/t/8mrWhynj8kMDujwWQMknfvZoiDTMvRaMFT2fjqcDJHFyh
         bVpEe066VpYMQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CF611C53BD1; Tue, 24 Oct 2023 10:56:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218041] Buffer overrun in devfreq trans_stat_show()
Date:   Tue, 24 Oct 2023 10:56:45 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component assigned_to product
Message-ID: <bug-218041-137361-jezH8LoupD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218041-137361@https.bugzilla.kernel.org/>
References: <bug-218041-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218041

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|Other                       |cpufreq
           Assignee|drivers_other@kernel-bugs.o |linux-pm@vger.kernel.org
                   |sdl.org                     |
            Product|Drivers                     |Power Management

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
