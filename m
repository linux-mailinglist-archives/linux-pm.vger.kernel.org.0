Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD475604B4
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 17:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiF2Pfi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 11:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiF2Pfh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 11:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CAF2FE72
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 08:35:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D93D615ED
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 15:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A70E0C341CF
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656516935;
        bh=POa7GCwwzCmGisR1EErVzwkb+qc/SIJ5GVb8RQuurLI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DD7r050NoHgDvWT+Pi7Df9GK6ueD8wl5Upvx9lcdYPv8PPbawGjH82E2N9qugDNoB
         o7HJYDFN1hWo9WCn+XFDSLuoyGGvcwF4waSS3qJIv53q6CKgm1Sb7nnYaZan54JQ6U
         I/l/bzcQdjELK2bAn3j5NKm3lOnOcjqbQAqpZvs+/MLOElH5VBPjJYCXtq8dwO/GX+
         b4/S97ljJm5BKpDrkkKg0O1qPomgG15V41tVUbySvW/4r+3CkDMbdboLsEYbSwMV2x
         OHfVoyFNlXd+en/n7s5aW1E0mcGFyCDJ8xBuEPt+qim6OkKDx/EwMmJGen1kwAj00O
         /jvyB3XH73aYw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 92A04C05FD6; Wed, 29 Jun 2022 15:35:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Wed, 29 Jun 2022 15:35:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: a@annel.in
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215938-137361-bU1wKaGkKL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

a@annel.in changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |a@annel.in

--- Comment #16 from a@annel.in ---
*** Bug 216189 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
