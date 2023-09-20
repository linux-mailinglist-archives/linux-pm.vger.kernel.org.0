Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01897A8307
	for <lists+linux-pm@lfdr.de>; Wed, 20 Sep 2023 15:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjITNPn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Sep 2023 09:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbjITNPl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2023 09:15:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E73AB9
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 06:15:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05F97C433C9
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 13:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695215732;
        bh=naD1jth9r9VNN4nZsjIDudZxZ9w7U7o7xfY9yO9sWKo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sSVyGAm2WPIefkWcgzb4tfSOc4McHHYotO7og3rE+elsBL6tOPhxYCxGttW06fWkh
         yVqQymHo3GlqGsRORKqr0VEifhAbfNf0wMnJm/c9VUerRD6yHjNWtHmWKALhzmT7nl
         NiJ16EbcgQt4qNJ6E+/urzJKd7/0xDla/+BXnztzXgTqbABghPzthfd8jErGB6C3dB
         BkJA6TMqmOYONOWMBprRT1RuQUJN61VS/7uEB4pwpQ/cCJAC7QSMFEqTGt38nkzWGR
         SFfT1kpik2kOVPqif8w+ddc2TgmrNVP6rt7LaFMTM5jzwEwyym0+3s+pB93aKUYT8u
         wJsnC2HCLWYdQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E0749C53BC6; Wed, 20 Sep 2023 13:15:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date:   Wed, 20 Sep 2023 13:15:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: bagasdotme@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-FM1ho6aZUB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #2 from Bagas Sanjaya (bagasdotme@gmail.com) ---
On Wed, Sep 20, 2023 at 11:06:51AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217931
>=20
>             Bug ID: 217931
>            Summary: amd-pstate lacks crucial features: CPU frequency and
>                     boost control
>            Product: Power Management
>            Version: 2.5
>           Hardware: AMD
>                 OS: Linux
>             Status: NEW
>           Severity: high
>           Priority: P3
>          Component: cpufreq
>           Assignee: linux-pm@vger.kernel.org
>           Reporter: aros@gmx.com
>         Regression: No
>=20
> Created attachment 305131
>   --> https://bugzilla.kernel.org/attachment.cgi?id=3D305131&action=3Dedit
> Power Options: Processor Power Management in Windows
>=20
> It would be really great if amd-pstate had a feature parity with
> acpi-cpufreq,
> namely
>=20
> 1) Being able to set operating frequencies (maximum, minimum and
> user-defined)

ondemand, conservative, performance?

>=20
> 2) Being able to enable/disable boost

What is boost?

>=20
> Currently both features are not available and frequency control is simply
> ignored (bug 215800).
>=20
> Rationale:
>=20
> 1) This is required for benchmarking and proper temperature control. Boost
> frequencies are subject to multiple limitations (power in watts, amperage,
> voltage, temperature, BIOS limitations) and can change depending on the
> workload. Setting a low enough frequency allows to run benchmarks in the
> controlled environment and get proper data.
>=20
> Windows allows to do that easily, see the attached screenshot.
>=20
> 2) Disabling boost is an easy option to subdue operating temperatures tho=
ugh
> if
> the previous issue is tackled, it's not really needed.

For example, after compiling the kernel one needs to cool down system,
right?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
