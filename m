Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4208548800
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jun 2022 18:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356425AbiFMM4h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jun 2022 08:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355005AbiFMMzy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2022 08:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A37A12605
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 04:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C37B60B6B
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 11:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F03E2C3411E
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 11:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655119006;
        bh=hhmJ7FDbbuJLtIr9qR/V5eDpyGEg7QnstsNuwjZ1zIs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UIspn8YnYbQ0GaFIcrclG1QDLYC1SSwvHxNJKYlv0qiSovRwhtqnp5vy+CDmPSgtX
         RVBahO9LO+NREr8oXE1IpyB/d5dPUDXO/YZgpHUmmZcVlbh75zqrhA7z1zRSuhUQVX
         h8z29mVrhBWLhBZ7mBch/eGaLTJMEc/eQNa2RBm2e1eBdCgdryHRCdTkR0WQ53kgzY
         T2nm2U6fNKnrvhjGfXK16KtcvINmDo3Z8lm4X3S6RmD/aQO8ZttiaqPs52ynHyh9mE
         /jHn/3lYthRT5lKcbfHY08sLWCpvVsi7baUZxk41QQORCEl62lMIFWOqclQqnadTQT
         zxOvaXUlGRdNQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DD7E6CBF854; Mon, 13 Jun 2022 11:16:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Mon, 13 Jun 2022 11:16:45 +0000
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
X-Bugzilla-Changed-Fields: cc cf_kernel_version
Message-ID: <bug-215800-137361-gMsDIenUjJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |aros@gmx.com
     Kernel Version|5.17.1                      |5.18.3

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
