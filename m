Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BA856644E
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 09:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiGEHgY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 03:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGEHgX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 03:36:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF09DFC9
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 00:36:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53F72B8163D
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 07:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAD4DC341D0
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 07:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657006579;
        bh=ZQSkmWaaUIu/zbq62umRyYgh1rez/Yo2Y8Nihyg4E0w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ounb/Vc1judcttZD1gg5Z72TxDDZq4dZB3Xi3DDFmmYPsI4a6NTcoHg3BsjSa29Am
         HxSsxlHG38kITiyidZqz4fnZsNctpM26Saw3RtyV5ROOiykpUY7KlHSj6/UtuUrRik
         QNE0V0GRfiuiBwIt5E5sJAJOQJ60LghcPuvEXC6b9ce0xaJXF2+ete3utZvNY2mEhC
         NHrz8bcLT8W/+sM3QqkVAEIqaTMbyFgCSHIFp/TMlhdVP0SbZOTViEFwVS6afSiZ0x
         DIOl2x4R+1jWkb486m6B5QHQf3RyLM0YDe1m71x3xwhW3QRKeHKXtEWKqj7Rq8msWm
         Ir2Cua2cFWVmA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C9399CC13B1; Tue,  5 Jul 2022 07:36:19 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Tue, 05 Jul 2022 07:36:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dev@alexmaras.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215938-137361-aLmCx7U7BS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

Alex Maras (dev@alexmaras.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #18 from Alex Maras (dev@alexmaras.com) ---
Thanks Perry - tested and working as expected. I'm now able to set the CPU =
freq
with amd-pstate, suspend, resume and see that the cpu frequency limits are =
now
respected correctly, and changing both the governor and the frequency limits
works as expected.=20

I've set this to resolved with a code fix.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
