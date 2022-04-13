Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED55A4FF3CF
	for <lists+linux-pm@lfdr.de>; Wed, 13 Apr 2022 11:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiDMJoY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Apr 2022 05:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbiDMJoJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2022 05:44:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F525642A
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 02:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47B2F61C65
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 09:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7A32C385A8
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 09:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649842903;
        bh=B2ogiJo+AnCFZ8cD4AJB+xaxKMSs6tK+Z073DzPCj0Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QMFKGkfuyGysKI4OnP+V5w7PxK+o6+n0udLtcQK5Sl0C0L7hFq07jf5FqywrNifAt
         SZW6XzuUG6wCPDbaQ3pw4x5ejbpm7rh3TUb7kdU7iJyXW1WybS89xl9wod+E9EcJzs
         zlHxo74stuZnb/dhT7yn8wHKcixW9iBIfPCYnoqflupRYyD6CFPnlf+E/jcgwdOdJR
         a2Lx3heR77viym4TJ1+6UV6eGTXJWtuxI3USDdfM9gMQn3J9QsEwXIL5Tpu0Iggbe1
         gccY9S0N1w8uwjD9O9436Ad0tQhelAbGMnDUNcjgtWHHzRpdpZLe1/aR97PtnWarB6
         NgWp/GirqpwaQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 86042CC13AD; Wed, 13 Apr 2022 09:41:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Wed, 13 Apr 2022 09:41:43 +0000
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
Message-ID: <bug-215800-137361-EUVWnJUR6K@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #14 from Artem S. Tashkinov (aros@gmx.com) ---
Here's another weirdness/quirk:

After suspending and resuming the maximum CPU frequency increases to 3800MHz
(which is the base frequency for Ryzen 7 5800X).

Boost is _enabled_.

Not sure if it warrants yet another bug report.

Let's limit them to three.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
