Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F157A79CD
	for <lists+linux-pm@lfdr.de>; Wed, 20 Sep 2023 12:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjITKyb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Sep 2023 06:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbjITKya (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2023 06:54:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896C897
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 03:54:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25812C433C7
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 10:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695207264;
        bh=zEQrPc8hjkK8CBPoM2flSYQsHpPiV3Rc5aCHpvAFj0s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YPPGI0GCeL6PiJDyD1otMlK4pBOW3d5RWa98BOj9KDAS2Tx7dBGm1uR2uzoDzjI10
         6s4V0TzqWLHJTQj7TLG6L1P51vqQuKK0NUGJH++fi1Ao2R5VZxBsXjngV4MfxUxbzL
         SUdQqKTNDvuidqVq42x3S07JL8rBzff6ocI2UE91MgDcP4Rf5E8IbFoZHbMRyYhAS+
         GVOJG8UuWHED6+OcI0ZAhXgXqsXHsyVIvY3ntc4LtS7d1QEyrGMIaWezUparhD1saG
         55vhdIEVQ3UMLHxjRgPtI2bPlQsRQbIAWQ2yxbZ5dZeTYxMTD8nKTouFcSkn6n1tQj
         Paf2O5CUIxVhg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 13938C53BC6; Wed, 20 Sep 2023 10:54:24 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215801] Rmmod'ing amd-pstate doesn't restore acpi-cpufreq
Date:   Wed, 20 Sep 2023 10:54:23 +0000
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
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215801-137361-k1xUGvJ5JB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215801-137361@https.bugzilla.kernel.org/>
References: <bug-215801-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215801

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
This is still relevant as of Linux 6.6.

Would be great if removing amd-pstate enabled acpi-cpufreq.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
