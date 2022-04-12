Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3D14FDC1B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Apr 2022 13:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345240AbiDLKO2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Apr 2022 06:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbiDLJmZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2022 05:42:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A2661A28
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 01:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6EF0B81B75
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 08:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51256C385A5
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 08:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649753200;
        bh=oE3D8WDtjWO9aZxgaiCSDzFF3HBnEufRUgyvwpJcPI4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WoCsgMhvZ424X3lpgoDX3kc/vEBLWNvWsZJKsz86ak3hOZt0wUkOic04Z3d8OWjRL
         egVUwH41Tzheo47B9s7fjThhTQeifiQkV2uVM706QtBc/K1twmuFPCl9A/Own7DQjw
         K7kiBtC+bHS2MAHfczABlf8o0I/9UtwYROqI4J5131aCiuJXGY8kkU7cnfclGVdYjo
         +ML/sZLFTvL2TUI7ctkBpn/paMMKVffhiKEf0G2S1/bE2XfmaA2VMSMCphNf1AjJKJ
         V0FCE7RWrLJI25D5Uf23gKrjGRA6HSEGav7RIIuQSuh+5G+LY82CyExNI4IYNnm/39
         xymp8gXaz4BBQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 30BE6CC13AD; Tue, 12 Apr 2022 08:46:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Tue, 12 Apr 2022 08:46:39 +0000
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
Message-ID: <bug-215800-137361-WixYeQd9MU@https.bugzilla.kernel.org/>
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

--- Comment #9 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Joe from comment #7)
> Created attachment 300747 [details]
> Max freq

Changing scaling_max_freq makes the CPU stay at frequencies 2.2GHz or below.

Enter e.g. 3000000 (3GHz) as scaling_max_freq for all cores, then observe t=
hat
scaling_cur_freq never exceeds 2.2GHz.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
