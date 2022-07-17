Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D24577678
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jul 2022 15:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiGQN5K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jul 2022 09:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGQN5K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jul 2022 09:57:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49D013D08
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 06:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C46AB80CB1
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 13:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A715C341CF
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 13:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658066227;
        bh=8fbHovB7vHX1yqgpr34oFIn3V2Hea7wX9hBfLy23wYc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=o2Ql39Mg9F+Xnw8xEmoe2mV7jVhIdqH+EV4JvC/Vezeo9HZRWl3q9ToiZBcYMhV2d
         HRGa8EAk3PviYuvLT9BI1QTOvigxeHyFp0eIf5K7p7wgDE3SPyidj3z2UaDf1vsrbg
         bRavapH1yAOmN/eDm8DYVIHBP3z6IHjsewuJxOE7Pawqbv7I8ry095oY5nvZWAHrEN
         SrHkvwn8S7j0b7p5hJsVb1dB/rBlV4D5RC3mDA3VKbGyJkXdFq8UuOuZK76kSax2rm
         4cSkPUgPgh44R47Aj/iSgjl/CIPjLaYOr2bMG5uySV3cRPURC+r3X63i+0Hwm+JysU
         46Q05fCvpucUw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1A4EFCC13AD; Sun, 17 Jul 2022 13:57:07 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Sun, 17 Jul 2022 13:57:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pandre0x59@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216248-137361-ExyySn8pGo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216248-137361@https.bugzilla.kernel.org/>
References: <bug-216248-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216248

--- Comment #19 from phandrix (pandre0x59@gmail.com) ---
For example here:
https://forum.manjaro.org/t/testing-update-2022-07-17-kernel-5-18-octopi-ha=
skell-python/116789/12

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
