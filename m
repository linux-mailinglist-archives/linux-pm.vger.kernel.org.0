Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2999A4FB48E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 09:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiDKHYn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Apr 2022 03:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243307AbiDKHYm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2022 03:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6694038D90
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 00:22:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93D95613CA
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 07:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF1A7C385AB
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 07:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649661747;
        bh=/O6nIA8yDRCB4uazwRDhEaEmkgR+Jisu60E3369IM4U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dRszyIwVoVwQju1W9qW1FzhQA5h4GZUpzrtM/9goEdGOdFWPCh9ysiN+o1n7XilyT
         ngwetcHx5ez38HVeciZGtK/VZwGj8PNCXbJ6F/5We8umNf3h/0oeucdORdTKP2EGs+
         m0XeU0+58Qcy44S0Z9mjVvuyvfa9QMEiWJM8nmebmUkbbMYlhMt1AnxN6calkZjDds
         UGFbF7vl6wEUAIMyQzzMNiDzdtf21C4YigLvuyQ1yZEJUKwk+kXfCUj2rZEniIBUas
         eXi+2GJVrtQhG5669LBSfZTQlPjdpFTJtHUtIZZCTlb4FKGWcJJFnvlQ5KvetM1Snb
         z2uRpGqc9FN7g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C584EC05FCE; Mon, 11 Apr 2022 07:22:26 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Mon, 11 Apr 2022 07:22:25 +0000
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
Message-ID: <bug-215800-137361-GlbKLL2VM9@https.bugzilla.kernel.org/>
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

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Huang Rui,

Could you check, please?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
