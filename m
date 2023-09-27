Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C919B7B04DB
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 15:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjI0NBe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 09:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjI0NBd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 09:01:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FAC126
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 06:01:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00F00C433C8
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695819692;
        bh=ipXEUhy3xcd0B3OiwwvhVWuXlqDT/WZqSoniI+txUGM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ej01828kRlOnC79eqxdd0mPIwtnJ/H4QZH7H5cELB6eNWGCxHmgOtnnamp4RfviuF
         cMbQP2enOa7scfv46AyGHCLC7WtGsMI7nVVbSV73Swirh97FVYnwpqAdR0hNj2pDM4
         UAUsd7tS0GfQG4RdUUm3ziTZDQOfr75qTsRQwQN5kl3ocDG0EbyKpR9haB+IRWoRkZ
         ZZ5Bos78klH8F8Se9zt8eZvbqeEZC3rcAgkSjDp5JfnWnI1yhVHpmQcBHDdGPe3i+y
         8Ps28N8jEPL65C+WEyykMBxspmdhMbxS8xkqMNU5V/r7J5k68Z+1FqotwR2uyDGRp8
         FK0fCFA1XoVHg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D8E32C53BD0; Wed, 27 Sep 2023 13:01:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215801] Rmmod'ing amd-pstate doesn't restore acpi-cpufreq
Date:   Wed, 27 Sep 2023 13:01:31 +0000
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
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215801-137361-nSv7SrUCVv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215801-137361@https.bugzilla.kernel.org/>
References: <bug-215801-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215801

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |WILL_NOT_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
