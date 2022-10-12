Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746685FBF34
	for <lists+linux-pm@lfdr.de>; Wed, 12 Oct 2022 04:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiJLChD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Oct 2022 22:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLChC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Oct 2022 22:37:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D017A503
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2022 19:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6425B818D3
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 02:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85A3AC43470
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 02:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665542219;
        bh=Zvy0wv6ue/b3LVZOgdF8y9Q1sSV2hVc4+QPGEnPpWDQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=O6c6FHPjzba3MSrcWNfbSAxVM7Adg/snz40a2wRTgeemhu5F88eLiCap4KD5ZzBWd
         0kSqKsoz/Q0s74ik98m/Fr1esHrtiXat0RRf8yoIhXTRfsbxYM4jdlQa711zwrLVqO
         NTZtQ08w4dVDzBHtJ8s1rydTy4R8JidIsQFRAo+K4N1AtKAkR9RfAavu98lwi3ikB0
         ulhV2Oy8AK/GR1kJd4RugCop+FyRWm5sWhuZjAl4SkL2zgzavufmQeleF9MHEVTOz5
         ovq4LMP4bSCXc0p5tU8h4VtGd410sOlaFNOuClQdLsxrtOXCjxu5c9/wNfDqhWHqVt
         0ci275M5quZmA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6A54CC05F8A; Wed, 12 Oct 2022 02:36:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Wed, 12 Oct 2022 02:36:59 +0000
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
X-Bugzilla-Changed-Fields: cc rep_platform
Message-ID: <bug-215800-137361-BdiZY2gQxE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mario.limonciello@amd.com
           Hardware|x86-64                      |AMD

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
