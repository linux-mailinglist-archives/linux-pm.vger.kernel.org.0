Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4C373BAD1
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jun 2023 16:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjFWOyV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jun 2023 10:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjFWOyD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jun 2023 10:54:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E85172C
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 07:54:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA1BA618AC
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 14:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36EF6C433C0
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 14:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687532040;
        bh=PyOdWajb/C3aGJGa1w4ylbiPHAGvr1nOmZc35KHD2n4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tb+NCdrK+nx/YxNKxQWatUNz+9I8ljfKDYHE9TQTl+h89bI9//d9WteD99hm8L0do
         lme1A2rvPRNAEUODY4nVXw+fXbmycWtKq/x6ozoHD/yWsic6edfb6Ri8JZMrXaFunv
         bWSulRBa2/F/Fn0FkVmI9sTiaUoZMYEWYoaazNKhqpxhbPD2POTGXoK2PU3Hhq89Bm
         dugHOX49ula0vcJc3brrpWSZiP0LWACbltEhzzMUdJx4FKyyLowH/1aszBNBw9EzWt
         n5GFrVIOflEHmyT+i/sBpN+KZ8lNtL2KUnkpIRzl2/gvNNX3iKApKMlkBiC57ETWDa
         8mTY2dY1CS0qA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 246DFC53BCD; Fri, 23 Jun 2023 14:54:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217589] Intel CPU maximum boost frequency reduced after resume
 from suspend to RAM
Date:   Fri, 23 Jun 2023 14:53:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bjackson0971@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217589-137361-gQxCF1XnTh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217589-137361@https.bugzilla.kernel.org/>
References: <bug-217589-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217589

--- Comment #2 from Brad  Jackson (bjackson0971@gmail.com) ---
The CPU was overclocked by setting the CPU ratio in the BIOS
(https://youtu.be/X26WU900IAQ?t=3D2632). This is the only way I'm aware of =
to
overclock on Linux. There is no Intel XTU for Linux and I don't know of a w=
ay
to increase maximum frequency by writing to /sys/devices.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
