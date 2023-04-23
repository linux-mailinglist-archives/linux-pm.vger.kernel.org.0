Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE6F6EBD6E
	for <lists+linux-pm@lfdr.de>; Sun, 23 Apr 2023 08:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDWGiy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Apr 2023 02:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDWGiy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Apr 2023 02:38:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1891D1728
        for <linux-pm@vger.kernel.org>; Sat, 22 Apr 2023 23:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A769A60E8A
        for <linux-pm@vger.kernel.org>; Sun, 23 Apr 2023 06:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08EB3C4339B
        for <linux-pm@vger.kernel.org>; Sun, 23 Apr 2023 06:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682231932;
        bh=NjWxyBEO3cov1vUTJ5TD8BGR2w3dYRRh6D9RiwrfaNI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=i1Ui0vEM6V4FZ+/V5AQibXh9rtBknaUSIJL0j4cz1uLHhnWSTmXJqbs2qvC+0QhB1
         tYNXQq8u6Uj6xaYUwmv0r2WuxZuVKAlFF1NjZpf6He13POhXCM9E93mbV9VqgaFJrk
         Uitv1UnNchZC2J1V3jTeejY3m1PEf1lViUSeWzaoQqLp4x8DvdFhiEdon1C5/qJFx+
         /q90nnuphMuHm++aZKQ1N1GpVaVcdaJO6LIZbCGuBFnjIMxxgv1NCFkcdbBDoEQjly
         B//5ZwM5QifGVWNM3E2cEZDJ+xl8d18jETYibeuCEvNxiqnm5yLPt4rfe6pNuUOaL9
         M6/wlSq+5wDig==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E62F3C43145; Sun, 23 Apr 2023 06:38:51 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217361] AMD P-state driver is too aggressive by default
Date:   Sun, 23 Apr 2023 06:38:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component assigned_to product
Message-ID: <bug-217361-137361-URlBg3EavY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217361-137361@https.bugzilla.kernel.org/>
References: <bug-217361-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217361

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
