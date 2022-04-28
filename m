Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E03512F02
	for <lists+linux-pm@lfdr.de>; Thu, 28 Apr 2022 10:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbiD1IxF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Apr 2022 04:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344298AbiD1Iw6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2022 04:52:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB1FDF06
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 01:49:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F565B82C32
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 08:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2996C385B8
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 08:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651135780;
        bh=v7RJc2SB4Ep7joYv3Ebg/xA1k222+xKIlbIBHmpr2fY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=D7Ssnm+/IXdRQg1wa2xU8ztzIjA1IpW5RS3z5KkJimqPUkgsCS2U5w6J/J5TY82dI
         6Z5zjIRLPRUuEFFk0P4vwQACB6QlS2Yxrvucnollgz08xrqbpUlzkon/U03hRNHHay
         urN/RA3w1NzXeIgd2n8fBTSboaH+CMMJdGaY50oIt/gzMn6H8mmRVJ2cHax9/RYSQ3
         /ouGDhfM4ZEB6WUtLTYg/J7Bvoo7V39c/nexPtn83BqECwb2qOsNAk0196HMKNdoE9
         etrHGtaMlUFac28ICVH2dN550L/kQX6wtLTmkDsaLv7skL4hA8oldu+B8nsoq0S52K
         RyHJrdXifWGCQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B8CF0CAC6E2; Thu, 28 Apr 2022 08:49:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215729] amd-pstate driver has a much higher idle power
 consumption for a desktop Zen 3 CPU
Date:   Thu, 28 Apr 2022 08:49:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sujinzhou2008@126.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215729-137361-dkqvhBHJQe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215729-137361@https.bugzilla.kernel.org/>
References: <bug-215729-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215729

Joe (sujinzhou2008@126.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sujinzhou2008@126.com

--- Comment #8 from Joe (sujinzhou2008@126.com) ---
Hello,

I reproduce this issue on my local.=20=20

Your device (CPU family:  25, Model:  33) should be shared memory solution =
with
AMD P-state driver. Updating CPPC request with shared memory will need more
energy  than writing MSR register directly. We are checking this issue now.

For ondemand governor, could you please try to reduce the sampling_rate and
then check to energy consumption again? Thanks a lot!

Here is the command=20

cd /sys/devices/system/cpu/cpufreq/ondemand
echo 50000 > sampling_rate

Thanks
Joe

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
