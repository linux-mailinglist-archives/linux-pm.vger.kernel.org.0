Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E17651DF83
	for <lists+linux-pm@lfdr.de>; Fri,  6 May 2022 21:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389550AbiEFTOd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 May 2022 15:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245289AbiEFTOc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2022 15:14:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0240356402
        for <linux-pm@vger.kernel.org>; Fri,  6 May 2022 12:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2BB4B83908
        for <linux-pm@vger.kernel.org>; Fri,  6 May 2022 19:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D463C385B0
        for <linux-pm@vger.kernel.org>; Fri,  6 May 2022 19:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651864245;
        bh=ymzU4idt7viwNSkaeGVwnLiXxg7P5YFDQ+ntC9sdFhM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Fe0F8oq17hDBuW/OxzZlJSkednjo4Qayv9iapTrDk7oAIwD9f2mWh0+jLmq/w1wcL
         PRAtSRoF3gsBsoF2DKJqL5tJLW2JVxSJg+Wl/zxjdmOH/5dvu0A30tYiqsM/klLQTA
         k0iUy7hU4WovoBLC80d6Sjt+lqUgOeq2R73zGlaj/mCK1k1+hqG2ArGeOEIkFp1RUv
         941l2CGp0bHU1tcYKAbrpGVmJybzaYehNegsyQChjUJTVvGgx24zK94ZDINfKkdzz5
         nBQ2kN8b8vp5ZAh0YbO3d/9D9z9mYkrj/lHfmfJN6DsjZrxr02sqKbQbB0lsh699Eo
         YNNxnqxc2GKNw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3D26BC05F98; Fri,  6 May 2022 19:10:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211791] AMD CPU /proc/cpuinfo reported max potential boost
 frequency instead of actual operating frequency
Date:   Fri, 06 May 2022 19:10:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-211791-137361-yQIyz9AyQK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211791-137361@https.bugzilla.kernel.org/>
References: <bug-211791-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211791

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
