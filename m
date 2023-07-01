Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C5F744804
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jul 2023 10:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjGAIVW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Jul 2023 04:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGAIVU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Jul 2023 04:21:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461C0B9
        for <linux-pm@vger.kernel.org>; Sat,  1 Jul 2023 01:21:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDFEF6020F
        for <linux-pm@vger.kernel.org>; Sat,  1 Jul 2023 08:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A4DAC433CB
        for <linux-pm@vger.kernel.org>; Sat,  1 Jul 2023 08:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688199678;
        bh=JqUVZ+3qyXLGKbR/WiY/Mv4XPoFGhbENlp3FqtNEhWk=;
        h=From:To:Subject:Date:From;
        b=l9ujaLUagIeJ0NGBQ7eNqdA0Pqi0EKoLKq/zgrU5cArp6FKfv+ZLJgd/Duwn7yCPk
         IH6bNOMR1OgWT1nu0maXkmgslz6+poV+pnI5YhKa8SPlLVQl0UcBJVP4OtFsPqPf31
         uLnxw2HbSWPRMziO2DgeTiNC/h/kvjTONu3oFht4uOjKnXBiPfPp4qU9n9arwVvPR0
         LNwIS1G+CUoHf1ejR8tKzqRtDftBK6fZ3GSJThX8QFfQftK+JQmKtgKa7YIFJnvpof
         WmzOKt1dXD4o3yauMFef4Ip8fnuH01lOI0gqAUbH/zvhRiyBP1DaVGL1hDrvkI4AUo
         pJ7vq2FqwXi8w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0D0E7C53BCD; Sat,  1 Jul 2023 08:21:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217618] New: Changing maximum frequency and boost state does
 not work with amd-pstate in passive mode plus the schedutil governor
Date:   Sat, 01 Jul 2023 08:21:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: putr4.s@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cc cf_regression
Message-ID: <bug-217618-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217618

            Bug ID: 217618
           Summary: Changing maximum frequency and boost state does not
                    work with amd-pstate in passive mode plus the
                    schedutil governor
           Product: Power Management
           Version: 2.5
    Kernel Version: 6.4.0
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: putr4.s@gmail.com
                CC: ray.huang@amd.com
        Regression: No

I have a HP Omen 16-n0000 laptop with a Ryzen 7 6800H, and if I have amd-ps=
tate
set to passive mode (either by booting with `amd_pstate=3Dpassive` kernel c=
mdline
or by running `echo "passive" | sudo tee
/sys/devices/system/cpu/amd_pstate/status` on runtime) and the governor lef=
t to
the default schedutil then changing the maximum allowed frequency (via `sudo
cpupower frequency-set -g 3200MHz` for example) does nothing, the CPU
frequencies (and temperatures along with it) still goes up high. Disabling
boost via `echo 0 | sudo tee /sys/devices/system/cpu/cpufreq/boost` also do=
es
not work with the schedutil governor.

However, if I switch to the ondemand governor then both the boost and maxim=
um
frequency settings work as expected.

The distro I am using is Arch Linux, with kernel 6.4.0 from the testing rep=
o,
although this issue has been present since at least kernel 6.2.x when I fir=
st
got this laptop. I can recompile the kernel myself to test patches if there=
 are
any.

Also, for what it's worth amd-pstate in guided mode also ignores both the
maximum frequency and boost knobs, but it does that with both the schedutil=
 and
ondemand governors so I guess that's expected(?).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
