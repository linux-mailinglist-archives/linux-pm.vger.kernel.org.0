Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4233B4FF05C
	for <lists+linux-pm@lfdr.de>; Wed, 13 Apr 2022 09:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiDMHJH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Apr 2022 03:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiDMHJG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2022 03:09:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373C71C901
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 00:06:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5A6F60B9C
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 07:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33F62C385AB
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 07:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649833605;
        bh=UeHH8PlKMMTqh171vQFdH50aOTSV+Ffvp3hmgYndxnI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CqeUxyZq3p/y/2iJzyVO79NpCQ2ffArRjh4vD8EUCp7+ohQF3wSCg4c9Cy7qZtfeR
         HPxbm9Pq0VFrsiIG5lVGusN+NLGOREcFnE2Nt1S8VfM5ZM6Zw3D1+JioyNtusetgZJ
         FiFm6bgmPV4IvXwwIWNNg1aRlFIQc68+gcbw5P95neqmK5IyFtuXRj6ZMrYebK410Z
         xohEaBJ4HkBI+CGsBq79es3iBqjKmncX/zk7DRH+Wmg+bZJ61Ne0O7qHOkGhpytAZA
         RlvPPAnMZOBlCYxJnFHXab//Ur4sHAYqR3SwXAojdEFIvdpSAlFmFOJ7V/v38kiaKy
         aYQSWTxCrkX8w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1266FC05FCE; Wed, 13 Apr 2022 07:06:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Wed, 13 Apr 2022 07:06:44 +0000
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
Message-ID: <bug-215800-137361-BovomeINv9@https.bugzilla.kernel.org/>
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

--- Comment #12 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Joe from comment #11)
> OK, so it seems you change the scaling_max_freq to 2.2G, after that, even
> you change back to 3G or cpuinfo_max_freq, the scaling_cur_freq is still
> less than 2.2GHz.
>=20
> I tried 2 devices on my local, can not reproduce this issue.
>=20
> After you set scaling_max_freq to 3G or higher, You can try to run "stress
> --cpu 128" with increasing the workload to check if the scaling_cur_freq =
can
> exceeds 2.2GHz.

I've run tests now a dozen times already: once I change cpuinfo_max_freq my=
 CPU
never goes above 2.2GHz no matter what I do even if I restore the value sto=
red
in this variable/file.

This is further corroborated by more than halved performance and decreased
power consumption - it doesn't go above ~55W.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
