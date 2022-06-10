Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1819546B60
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jun 2022 19:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbiFJRDk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jun 2022 13:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346733AbiFJRDk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2022 13:03:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A37A36309
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 10:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 361CAB83666
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 17:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE560C3411F
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 17:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654880617;
        bh=6P0LKE1YK6F3lmCibd3x9fyMYxvIR5n6zWbUf2gs1cg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Gm2yODg8QEpMJfBLuRrriXwvAa5fzLGoOrOrmTsAkOA0eN/3QGmkmT0fabEjpfRcb
         CvruqF3FhwiNyaC7xpRZH5Gs7y7DTdqV8MVnWZSydaVzZFCPxP+WdNDDQhBdAlKvaM
         zGJMpBAnLEI4KVURKxmA+cIgFA8pLsVHO3SWxW8/6j50/5SnIEgFpP5zpn9ka2Kjmb
         x6EC6/761TuvZOUl7ArfrOEyUKm6BnBuoUDharvJnsvq+NTAhmkG7QRUePy3p96wfY
         ovz7qFYrKPIjUMyfz2roTvNgGFr+bTNbE6orvsCpgQfYBr+9pt+S+11kQmOVFVsG78
         0wW1qkMCszcbw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D4A51CC13B1; Fri, 10 Jun 2022 17:03:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Fri, 10 Jun 2022 17:03:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: perry_yuan@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215938-137361-IdN1f2pVN7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

--- Comment #12 from perry_yuan@outlook.com ---
(In reply to Alex Maras from comment #8)
> Created attachment 301080 [details]
> dmesg output after sleeping - with debug params
>=20
> I've attached the dmesg output here after applying those kernel params. My
> kernel version has the latest commit. I'll compile from git to ensure the
> results are the same in the meantime.=20
>=20
> The dmesg results are interesting - cat-ing scaling_cur_freq still shows =
the
> same behavior, but dmesg doesn't show any values above 1.4gHz. I ran
> `stress` either side of sleeping and watched the scaling_cur_freq, and can
> confirm that it was maxing out at 1.4gHz before suspend, and not limited
> after suspend.

Hi Alex.
Could you help to try if you can change the cores frequency when you switch=
 to
userspace governor after suspend/resume test?


 # sudo cpupower frequency-set -g userspace
 # systemctl suspend=20
 Resume from Suspend pressing power button or keyboards.
 # cd /sys/devices/system/cpu/cpufreq/policy0
 # echo 1752589 > scaling_setspeed  //change this core freq to see if it ca=
n be
changed=20
 # cat scaling_setspeed
 # cat scaling_governor
 # cat scaling_cur_freq


I would like to see if the cpu cores still can change freq or not after
resuming.

If the cpu freq cannot be changed, even you change the cpuinfo_max_freq, co=
re
freq(scaling_cur_freq) will not be limited  successfully as well.=20


Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
