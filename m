Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24407CA1BB
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 10:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjJPIg1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 04:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjJPIg0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 04:36:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EA1DE
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 01:36:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E72FC433CD
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697445384;
        bh=dN+rvqsiAHjdfD6VU2cyaHKFZGv5dASeFeGH+dJLSaQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=himZnA0yj01Jw+fBQx36nKoGUOlVayb0N2kOWqWqPaM1mX3Rrx70thIgTK4MjfXL7
         Hyy+9201AYCqVcFkzNhrCuboVawKeZk+Wc3kdMj/lUdTLHElC8nyb5Tq/J6FEYB5B2
         BMynZvX7E9K0IOeCZEk5eT79UAlIT90xgdFZRnugIo6g4d/LLprQGbWD9MOQlh/5ED
         WJtbBouNVL5Cb/9P6/rcfQOdLHihQyf91py8BNZ2LcYpTIFnLgVpb8ybebtepUxju/
         jBgX4xvXKSwYhkvfBRf9ebs9MdiOj8ERAo1qVXUy7UHV3iXgS1pDfvwq1SQJP/JrJd
         fk4eUN69iSBYg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 60172C53BD2; Mon, 16 Oct 2023 08:36:24 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218013] [question] option
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y available in config kernel?
Date:   Mon, 16 Oct 2023 08:36:24 +0000
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
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218013-137361-z39HwRGVYB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218013-137361@https.bugzilla.kernel.org/>
References: <bug-218013-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218013

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|REOPENED                    |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
The ondemand governor is incompatible with {amd|intel} pstate drivers.

There's nothing that can be done about that.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
