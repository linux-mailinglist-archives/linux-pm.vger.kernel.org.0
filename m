Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916C07453A8
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jul 2023 03:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGCBj7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 21:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCBj6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 21:39:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515BB180
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 18:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB6CF60CBB
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 01:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 472CEC433C9
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 01:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688348397;
        bh=KfApBBXuEv4erfEveQFXevrfso//eeGVAQKOhGVUb5E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Xu5zAE43g7vN5oQ+UdD0d+xV5rzFmx4t0EaZYF9QqdFgpVJI24khUnabE/M00b5Cd
         0rdNzruxH96NZBsGQG8BpLn8X9LJqAlHKbhSpG8TkMEGnX4wGcIACAsG7QRS0qO/7l
         lx80ZkLX569dcNCrgtS4ISAseGkipIqsG3YA50lG0w+AKE2NeEGsq9gDo1VxcmcxZ4
         rCGBgeid5OM5x6Chu56Z+mjTmPGRVqY2irW7YKq7qRCOXrNCPnrpoHr9XKOk9NM62f
         AgU4gqC4GCzYNRMEX07pluGGUpXCGCf2UBekwDQtN3E65CvlcfID6nvqnyP5MGKowS
         RC/XMiQNsY8mA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2A492C53BD2; Mon,  3 Jul 2023 01:39:57 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217618] Changing maximum frequency and boost state does not
 work with amd-pstate in passive mode plus the schedutil governor
Date:   Mon, 03 Jul 2023 01:39:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217618-137361-ORmv6n1guG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217618-137361@https.bugzilla.kernel.org/>
References: <bug-217618-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217618

Perry Yuan(AMD) (Perry.Yuan@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |Perry.Yuan@amd.com

--- Comment #1 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Hi Sariputra,=20

thank you for reporting this issue, could you let me know the values of your
system?

# cat /sys/devices/system/cpu/cpu*/cpufreq/amd_pstate_max_freq
# cat /sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
