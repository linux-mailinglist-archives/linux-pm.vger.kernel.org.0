Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4697D4F3F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Oct 2023 13:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjJXLwZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Oct 2023 07:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjJXLwY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2023 07:52:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD39A128
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 04:52:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AE12C433C7
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 11:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698148342;
        bh=kuF6QlJd9pUUqJLT4aP4Y1UVoQgjMWIiGhJrKcdTa8g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=a41EIvEnqWBJqwst9mTjFtqj1N5rY88kOV4L2lPXMmGCK1G6FnihflJXd5p4VlHSW
         PmY7WCx10h5db7D/XMbDOMwOSVcL2s/2eWX+BDVplPyoIU0epFuNGO0A7n7yf4pZdk
         bEbozR2InPZpggRY5PgumYays1SjBw9IBv+gVf1W01qaywwipqDaZB5jLIIGAu8dTg
         XB++vzad5uLn1fsupLQ6ERisEL68umdpULwYa2fG7yoZ7+wKdXg4DeajXTcLLLg8C4
         YN2hPQnUqIoX4eYGdoRfUdXqg99stXSfw8hJ7lc8Gm5G/r+XSIvAue36GpM4Nq+kzI
         rfsUr3Eo4f46w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4CD1DC53BD0; Tue, 24 Oct 2023 11:52:22 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218041] Buffer overrun in devfreq trans_stat_show()
Date:   Tue, 24 Oct 2023 11:52:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ansuelsmth@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218041-137361-k29u0im03L@https.bugzilla.kernel.org/>
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

--- Comment #3 from Christian Marangi (Ansuel) (ansuelsmth@gmail.com) ---
Can you describe the amount of frequency? An easy fix would be truncating t=
he
output but I don't think it would be a correct fix...

If there isn't a bug in how the char are count I feel like the only solutio=
n is
moving this to debugfs where there isn't the PAGE_SIZE limit.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
