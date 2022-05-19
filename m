Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D77D52C9DE
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 04:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiESCls (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 May 2022 22:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiESCls (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2022 22:41:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2601AFB33
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2022 19:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D7ABB82284
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 02:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33FFBC34113
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 02:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652928103;
        bh=+uDCYLjZ3RI33AGKdts1VUoX86YdW4WKDNAld9oVOyc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pZzSLCZToTKlH/+dQ8cQyWS3YcfI7RGuug6XJXgffYQ8s/OUw6TTkb5x+jhFPjJZ1
         IuK0ozTGvZOvTGYSihMn5IwSvDkm4857gbuOKUu86qotzfoSpuSU7XoZ1yTvha0nNN
         m1uooFAClwBhdO5CGonMjn/bJJrFOXN7LXIOHnqsB08+TMh21XmbukRpxNTPDJdBMB
         oO8PmNmfRtik43ljbEwwyQlJxk+jH9YmfDegoryXdDS6viMSS67KvJMZgfpbmXnbm0
         0ECQzInucdGpBNn5rw32WA2Q6+yP4qfDc9wFQVKcAJN3jiRIDffkDH5IqxOHxJw8HK
         Uvl9eHxFoX36Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 201F1CC13B5; Thu, 19 May 2022 02:41:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Thu, 19 May 2022 02:41:42 +0000
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
Message-ID: <bug-215800-137361-UZxZojbnEd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #18 from perry_yuan@outlook.com ---
(In reply to Artem S. Tashkinov from comment #0)
> For my Ryzen 7 5800X I've tried (under root) numbers from 600 000 to 2 200
> 000 and they all work:
>=20
> echo $number | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
>=20
> However anything above 2 200 000 instead makes the CPU stay at 2.2GHz.
>=20
> This is after booting with acpi-cpufreq and loading amd-pstate with
> replace=3D1.
>=20
> Even switching to the performance governor keeps all the cores at 2.2GHz.
>=20
> I've also tried the userspace governor and again only frequencies up to
> 2.2GHz work. Anything above will be ignored.
>=20
> I've tried to fix the issue by `cat cpuinfo_max_freq > scaling_max_freq` =
but
> that didn't work.
>=20
> That looks like a bug.

I would like to confirm which kernel version or patch cause the regression,
so need you help to verify the regression root cause, then I will reproduce=
 the
issue to fix it on my side.


Perry

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
