Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100644FF020
	for <lists+linux-pm@lfdr.de>; Wed, 13 Apr 2022 08:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiDMGxQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Apr 2022 02:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiDMGxQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2022 02:53:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E80610F2
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 23:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1013BB8207A
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 06:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EB19C385AC
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 06:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649832653;
        bh=2vhSm9E3+eA2YiC50KoY4t4OwffjyvN/xQOtz924EBw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=M95NOFb/A1sW6VrHBTTaVn7Cr8WvQx1J8jb3kfeFhr9XZoDRgXmOfQPlU9XNLVtBP
         ksdwizCfqxGKJyNezyyhZy563Zz8WjMGQ5CoGOj7vzdSTjXVJnlcDE9fC1RBS5pXE8
         aoQWzGIOGHCiesXxYlXm1JWR82+1vIjv/62MzDY1dHLpq763PkKmTrpGZR3E6xS3rI
         Y9Qxxc8t+5Rnl/LydVGKwNC19rTmSwiQPQRY+0wIlpQdGuH6fkxhj9hkFmanUKp2xY
         0CHQkyXIojV9LSf9OG6fg921M1MkhGgOJKjmsIHFMVTQbwRkKNal3CbPm/IPfJyAil
         M1hj4GQUiY+jQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 736ADC05FD2; Wed, 13 Apr 2022 06:50:53 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Wed, 13 Apr 2022 06:50:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sujinzhou2008@126.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215800-137361-GqjPXilLW9@https.bugzilla.kernel.org/>
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

--- Comment #11 from Joe (sujinzhou2008@126.com) ---
OK, so it seems you change the scaling_max_freq to 2.2G, after that, even y=
ou
change back to 3G or cpuinfo_max_freq, the scaling_cur_freq is still less t=
han
2.2GHz.

I tried 2 devices on my local, can not reproduce this issue.

After you set scaling_max_freq to 3G or higher, You can try to run "stress
--cpu 128" with increasing the workload to check if the scaling_cur_freq can
exceeds 2.2GHz.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
