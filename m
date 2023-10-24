Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF597D53A9
	for <lists+linux-pm@lfdr.de>; Tue, 24 Oct 2023 16:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjJXOJk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Oct 2023 10:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjJXOJj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2023 10:09:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1ABA4
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 07:09:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D42C1C433C8
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698156577;
        bh=2YuVfWJRCm9wsUXcVykYFuj7EDjHp7AfNcgNx7Zb/+8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Z57zuDX17VgA1Rnoti/QwhKuP2vLc7wIe09Bskr1blpC2ueglWG3w+VxoqkD7yRFA
         97vmaO2DLUIBzR8uoBAz0VU8ICv5X7OSm2fegG6lHLmy4gkhhLAvby6nmmkeSOsuhj
         1xTPJJ5VNZXCjDJ8pS5wFWD6fUFvVfrrKL7tVoxXHCNdq6KWXOMdlpB46fAVDqVtRu
         7HjfsgmUJE5oQaVXuHs2x3ABv/ybjnbuskO2GOS/cN23rwygbIpBIrqtpnIpUjIiVS
         qvEm1DNQYJU1SPADftMdMXtlUDVp3y8qr4lf7422Z3uWUaRZovSsw3F4MCv796vjlW
         5BfYO56/l/skw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C208BC53BD0; Tue, 24 Oct 2023 14:09:37 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218041] Buffer overrun in devfreq trans_stat_show()
Date:   Tue, 24 Oct 2023 14:09:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tnifc@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218041-137361-Xh3HnqpUBs@https.bugzilla.kernel.org/>
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

--- Comment #4 from tnifc@protonmail.com ---
(In reply to Christian Marangi (Ansuel) from comment #3)
> Can you describe the amount of frequency?

There are 20 available frequencies on the Tegra 30 "Ouya" device.

$ cat /sys/class/devfreq/6000c800.actmon/available_frequencies=20=20
12750000 25500000 27000000 51000000 54000000 102000000 108000000 204000000
266500000 333500000 375000000 400000000 416000000 450000000 500000000 53300=
0000
625000000 667000000 750000000 800000000

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
