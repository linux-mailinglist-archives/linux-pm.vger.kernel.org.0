Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FEE575682
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jul 2022 22:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbiGNUpN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jul 2022 16:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiGNUpK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jul 2022 16:45:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201FE4D16D
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2022 13:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B173B60C23
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2022 20:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1210AC34115
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2022 20:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657831509;
        bh=eVPRRwvmbeNCprMJeh0iTeO9aqNVxhavLhm3ZGMOLFU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dUFYH/fSJmuOSUjsFhr5ZuAT/el88sLv3EwRiICSRVfAOQEDmjUYk+bXw4R374wxH
         SVNvFhdRb2lzbC1X3cYDVfvmspGo6G532FZ1EsHlJFi+YX0K/lahlDw/OQxRJIZ50f
         nO4JM/Igqww80wHSL43hPUYPw8zM9bI1ajpZcwkdW9mGxKSrVfJXe/06nnhBATJLRe
         qmSsS53DJBUs+3gpXQn8EQJIrj0fyr5UmaTzX76bAYD8ci/0ADClsqVUE10+kJ2aZB
         x3zfQUCR8oI9iAj+srV/Ev4tOxNTCqWsN3VbEarAIikYt9EIIJTChMt81klPoK01Hc
         Z34YNJG0gpjFA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E48F2CC13AD; Thu, 14 Jul 2022 20:45:08 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Thu, 14 Jul 2022 20:45:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arek.rusi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_regression
Message-ID: <bug-216248-137361-ckFUmAGjzn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216248-137361@https.bugzilla.kernel.org/>
References: <bug-216248-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216248

Arek Ru=C5=9Bniak (arek.rusi@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
