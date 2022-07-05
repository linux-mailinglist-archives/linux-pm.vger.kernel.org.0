Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9566566095
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 03:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiGEBPA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jul 2022 21:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiGEBO7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jul 2022 21:14:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF198E0A0
        for <linux-pm@vger.kernel.org>; Mon,  4 Jul 2022 18:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75EFDB81603
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 01:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 245C7C341CB
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 01:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656983696;
        bh=jw8bqrC2OBdjAxKFuF6TOelq+zV3fdaXLO4F+2Uzvdg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jUtzETG0BBmXw+4y9NRheqehBzFJ7zpZ6dL08xBBI7AWPsiJEbSo4GMDMto4Mgu2M
         TYWaLNYuE/bCC8dRQUVdyn/d3D5B4oH/3XeCSNrnhrXB7BWtsm9tJWNVcyU/Ls2OrI
         rIiCfvUxuZL7p8bt2xuNZCJVQMV5DT37b5yuI7Vh/bfxhwrKM+RczxsTx8E6FAtU9s
         R3PkUFBF6SymB6he9YfnT9XaBwtOzdeDJUxdSxgGHQpdswjpLj7IFmyeQdg0aZGhTn
         mXfWr1Po3l1X8SaB3pq598GWN9m+tB5CAEekttKLmefCgdLC1ULbtLtexMOBmACSQ2
         NfYw7Bg7l5PIw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0C735CC13B6; Tue,  5 Jul 2022 01:14:56 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Tue, 05 Jul 2022 01:14:55 +0000
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
Message-ID: <bug-215800-137361-CNEBmuIdPD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #22 from perry_yuan@outlook.com ---
(In reply to Artem S. Tashkinov from comment #21)
> /sys/devices/system/cpu/cpufreq/policy0
>=20
> amd_pstate_highest_perf:166
> scaling_min_freq:550000
> scaling_available_governors:conservative ondemand userspace powersave
> performance schedutil=20
> scaling_governor:ondemand
> cpuinfo_max_freq:4929000
> amd_pstate_lowest_nonlinear_freq:1752000
> amd_pstate_max_freq:4929000
> related_cpus:0
> scaling_cur_freq:1247422
> scaling_setspeed:<unsupported>
> affected_cpus:0
> scaling_max_freq:1600000
> cpuinfo_transition_latency:131072
> scaling_driver:amd-pstate
> cpuinfo_min_freq:550000
>=20
> Why do I have two wildly different amd_pstate_highest_perf=3D166 and
> highest_perf=3D186?
>=20
> What's the relationship between the two?
>=20
> Anyways, the issue remains. As far as I can see
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/
> drivers/cpufreq/amd-pstate.c has seen near zero activity for the past thr=
ee
> months.
 modprobe amd-pstate replace=3D1(In reply to Artem S. Tashkinov from commen=
t #19)
> All the same with 5.18.3.
>=20
> Steps to reproduce:
>=20
> echo 3000000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_=
freq
>=20
> Now all the CPU cores are stuck below 2.2GHz.
>=20
> This is after `modprobe amd-pstate replace=3D1`
>=20
> I really don't understand what else I can do. This is reproducible with a
> single command on my Ryzen 7 5800X CPU.

Please drop the replace parameter when loading driver, that patch is not me=
rged
by upstream yet.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
