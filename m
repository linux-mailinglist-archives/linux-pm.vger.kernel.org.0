Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ECE575E62
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiGOJVq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 05:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGOJVp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 05:21:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515A4606BB
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 02:21:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9F53B82B4D
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 09:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E162C341CA
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 09:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657876902;
        bh=JUwoEZwqheMKWycXToK6OBFFCXBrAnwhoJ96Tsc4sUo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fpCTzkNkTkyjgrFBe8sNFr1a+LkbuePLFw944m6SEbHlryocls8w7SJ+4fc1qNti3
         rSP6iUB3ebuWuRz6G1lcaIVuSevKACkx1mFb9XNhVkgWNmfkdeUNii+0hgi+wL6FIY
         oZ0T8Hx0iSsg6obYB1w4PiqK00yz/wjQCChZUWcmZqWl/kF6GSXianVXD7c/SJ0hJD
         hybFWMG+jYENHR0ZHjMVgEEBMAigRjc1uaGz9UMQuD3Si3TVJr53BYkAeVgP6T/0Fw
         xP+IBeVs2BzVZSJbuEU6nrqSl/9ZiU38redqQqG/NNkmZyB2A5kNnvyJpMa4FBllAW
         JcyDlm6mpvBoA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6A5C4CC13BA; Fri, 15 Jul 2022 09:21:42 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 09:21:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arek.rusi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216248-137361-UYj3BJQKWV@https.bugzilla.kernel.org/>
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

--- Comment #8 from Arek Ru=C5=9Bniak (arek.rusi@gmail.com) ---
# cpupower frequency-info=20
analyzing CPU 0:
  driver: acpi-cpufreq
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 1.20 GHz - 3.20 GHz
  available frequency steps:  3.20 GHz, 1.30 GHz, 1.20 GHz
  available cpufreq governors: conservative ondemand userspace powersave
performance schedutil
  current policy: frequency should be within 1.20 GHz and 3.20 GHz.
                  The governor "schedutil" may decide which speed to use
                  within this range.
  current CPU frequency: 1.20 GHz (asserted by call to hardware)
  boost state support:
    Supported: yes
    Active: yes
    Boost States: 0
    Total States: 3
    Pstate-P0:  3200MHz
    Pstate-P1:  1300MHz
    Pstate-P2:  1200MHz

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
