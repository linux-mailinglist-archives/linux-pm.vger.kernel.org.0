Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C3E567E20
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 08:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiGFGAn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 02:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGFGAm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 02:00:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BF512AA2
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 23:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 978CB61D38
        for <linux-pm@vger.kernel.org>; Wed,  6 Jul 2022 06:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1919C341CF
        for <linux-pm@vger.kernel.org>; Wed,  6 Jul 2022 06:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657087241;
        bh=YjUAyIO5LtuS6PDvo1e6TOeiV+RbUt1/XyVTxR4y7UE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=swGB3j5ncfP9IRN4+BdQaEyLAFf6NXuetpyHIXOqSvqNJA2SrB6JxRbicLM41TBZd
         GtchSWvc201ELWZBGwSqiEoZHYFK/QPL+PiawxqAvYx7PAIqtUXgQokpMzcl8ZXpH5
         1I7vQbQMk8klJjF63d8fFx/IxyPoF7HGavoeG9N7VCylFA+qDze0ecqflh+ZegjMq5
         nl+a9DDy7mNWNWJJgZAYcs96OQnxEyqI2vvS4NzG8gA2upNoiMNG0j4wNLNGqS8Uwr
         rfpcSMKAaM5041Tpho50xVDOY9tGqF2OltwJEGj097ymRAkMAxXg5o07gpnGb3nuzo
         esOx97OPqxAbg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DED73CC13B9; Wed,  6 Jul 2022 06:00:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Wed, 06 Jul 2022 06:00:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: a@annel.in
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215938-137361-x327VlpRUc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

--- Comment #20 from a@annel.in ---
Guys, have you get amd_pstate working with schedutil governor?=20=20
On my system, it completely ignores frequency limits and boost state.=20

```
~  sudo cpupower frequency-set -g schedutil -d 1200MHz -u 1600MHz=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
~  sudo cpupower frequency-info=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20
analyzing CPU 0:
  driver: amd-pstate
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency: 131 us
  hardware limits: 400 MHz - 1.90 GHz
  available cpufreq governors: ondemand performance schedutil
  current policy: frequency should be within 1.20 GHz and 1.60 GHz.
                  The governor "schedutil" may decide which speed to use
                  within this range.
  current CPU frequency: Unable to call hardware
  current CPU frequency: 2.60 GHz (asserted by call to kernel)
  boost state support:
    Supported: yes
    Active: no
    AMD PSTATE Highest Performance: 166. Maximum Frequency: 4.51 GHz.
    AMD PSTATE Nominal Performance: 70. Nominal Frequency: 1.90 GHz.
    AMD PSTATE Lowest Non-linear Performance: 41. Lowest Non-linear Frequen=
cy:
1.11 GHz.
    AMD PSTATE Lowest Performance: 15. Lowest Frequency: 400 MHz.
```

Other governors (ondemand/performance) works as intended.=20=20
Is it a bug or something else?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
