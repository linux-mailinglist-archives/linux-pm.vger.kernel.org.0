Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3AE7D5A8F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Oct 2023 20:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjJXSdo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Oct 2023 14:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjJXSdo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2023 14:33:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E45B0
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 11:33:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 803FCC433C7
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 18:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698172421;
        bh=kwCjzZsT/5fMmo/ychJiUbKKVJhmqeJsYULqE/jPcfo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ok8PX6GDTVujDpRxqv/czTDiccDxboDUiyyLOBlYyYgQPJw+t+sy+Nq8Gi1vc2w0g
         ycTePczJjOA51w2Lce79yaBogbFPO87SwHi/tVBzJ0I8AsAcB5miupsJ84qZCKyfZX
         QWTJIhDuF2aM3dtq/+4ZvDiVB/WnJAZEhWT79wItEloulEGS68R7G3GW7S0bqcBDlG
         KYdmWINwx6XMQwIc8klSBboZVDUh98DX6WjwGPZ3oMYU2ZokVfBgOFaqYv7wwbZm0z
         RimFWqQ5lpO1RFVYH0VND6Nnv2deVAjV/W1cuYgOS9PEA09pyUOEV1BUNn/pxu3GNF
         VIo+166JudcVg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5FC65C53BD0; Tue, 24 Oct 2023 18:33:41 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218041] Buffer overrun in devfreq trans_stat_show()
Date:   Tue, 24 Oct 2023 18:33:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ansuelsmth@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218041-137361-J9i4PWH2d5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218041-137361@https.bugzilla.kernel.org/>
References: <bug-218041-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218041

--- Comment #5 from Christian Marangi (Ansuel) (ansuelsmth@gmail.com) ---
Thanks for the report. I checked how the equivalent function for cpufreq wo=
rks
and as I tought it does fail the thing to write exceed PAGE_SIZE. I sent a
patch upstream that fix the missing check.

sysfs stuff is ABI so moving this to debugfs is a no go (due to we don't br=
eak
userspace rule) so this is the only solution currently.

If accepted, it will be queued for stable backport.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
