Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BB27A7A0B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Sep 2023 13:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjITLHo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Sep 2023 07:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjITLHn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2023 07:07:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767B8D9
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 04:07:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C2EBC43395
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 11:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695208057;
        bh=WPfFxQXN4Gnx1xzLBtpSolE0yEOcVMC3oBUirgRvX4A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NBwdzEJ6J8ywJaQHxux96kqbl6srliRuNbRIHGSMONuv+SoJiJnga/PtBkMGQAAEY
         4zdU6HhDO3G84EYwMQ1T1LCIPwoJufhMxGVy7W01QMqfLW2HjENQQl5QnY40moUgW7
         aAaAqXgYIp8xcH1NZ9GsDPlXgZZsHhz/SxOeFFxGzd7KW/liJO5XJ7m/z6xLmIwTAL
         EOwhWnoT63ckrzVRO+xjjEJKEBjSbbeEZ1z2NWXP87b+hpuI6sWcqqSoZeigw5Trbt
         WaFEVw1vHyuyd25YNAMGoDJYKYNbUCTxJk5LHXmupvWrkLvgQur/+mymHYC01JjXeF
         68Jgnfk8dCCyw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0BF72C53BD0; Wed, 20 Sep 2023 11:07:37 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date:   Wed, 20 Sep 2023 11:07:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-Urk3PZfhu0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
*** Bug 215800 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
