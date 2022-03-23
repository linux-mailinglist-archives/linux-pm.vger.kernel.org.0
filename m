Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EFC4E5581
	for <lists+linux-pm@lfdr.de>; Wed, 23 Mar 2022 16:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbiCWPmy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Mar 2022 11:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiCWPmy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Mar 2022 11:42:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E51B5642D
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 08:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6869B81F55
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 15:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 764D5C340F2
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648050082;
        bh=JqUJkYQkKblT0CD6rICHLTHn5LfqraBGDGSEAx4d0r8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FWFUProwY9jX2x6tZjh5kZXBtWG2P46IGpgRu7cnhS4OTnAMvObsu3yUwMPxAVuk2
         zZIlzXbknFuO+qGXWm8wwrXmOFCWq1R5T6zIcclPpRYJlkdcI9ZtQ1p2BURF1Bitjh
         NihskIRgOozIuKDZh5u3Xu5Vv5DokUKCSkrkCzhtKXb9eHhodr+jlkP14Fhbul6Mjm
         jZaHQYfL+Fu7l/Bjt8M2N6zwazDUq0rG0eaiSQfvG398vFnMmCPcDgGHwZll6W4Vpl
         LZm7k96/bITTUPCf65Lje3hcGyRfJO+FYjsIIJa/6yWUKq2bRgp9DcW95Fl4HPaDlt
         lCZSy2B9sxgMQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 58B9ACAC6E2; Wed, 23 Mar 2022 15:41:22 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215729] amd-pstate driver has a much higher idle power
 consumption for a desktop Zen 3 CPU
Date:   Wed, 23 Mar 2022 15:41:22 +0000
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
Message-ID: <bug-215729-137361-q1SfV5pMyN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215729-137361@https.bugzilla.kernel.org/>
References: <bug-215729-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215729

--- Comment #5 from Artem S. Tashkinov (aros@gmx.com) ---
Under amd-pstate:

# lscpu

    Frequency boost:     enabled
    CPU max MHz:         4929.0000
    CPU min MHz:         550.0000
    BogoMIPS:            7599.66

(everything else is obviously the same)

# ./cpupower frequency-info
analyzing CPU 0:
  driver: amd-pstate
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency: 131 us
  hardware limits: 550 MHz - 4.93 GHz
  available cpufreq governors: conservative ondemand userspace powersave
performance schedutil
  current policy: frequency should be within 550 MHz and 4.93 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency: Unable to call hardware
  current CPU frequency: 903 MHz (asserted by call to kernel)
  boost state support:
    Supported: yes
    Active: yes
    AMD PSTATE Highest Performance: 166. Maximum Frequency: 4.93 GHz.
    AMD PSTATE Nominal Performance: 128. Nominal Frequency: 3.80 GHz.
    AMD PSTATE Lowest Non-linear Performance: 59. Lowest Non-linear Frequen=
cy:
1.75 GHz.
    AMD PSTATE Lowest Performance: 19. Lowest Frequency: 550 MHz.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
