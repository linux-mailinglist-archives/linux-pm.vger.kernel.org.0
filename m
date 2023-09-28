Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F167B10CD
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 04:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjI1CbV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 22:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjI1CbT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 22:31:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1CBCE1
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 19:31:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4599BC433CA
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 02:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695868273;
        bh=Ghg30JdaQot9VnpDG64lpCqB0WoDfWYBkS3GaErlZv8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=g+PmmH3hznCChIywqbMmgrFsJSNY0Qmi0ylGTnUbDzAZ84N97qd37xHMcjaLkPXNI
         zVxlBQwTv7p6ipLj79BHtIjNMNEDjtS0RNmunxVAqIfuX9c6uuipUwlcKLyp5poG/H
         lL4MVQrXp2x3L23NSMzV2xervZcjPVSHjdU2fAjVnIt6v1X+bcdvfuw9G9THeQzyP+
         dBJjx4RoDadBTyKfwCUIBCAgo7Wauwp3Z3Mgxn5wlT8dfSEpFoXGGNUeAD2zU9Wf6h
         7wKWe+rQ2q/b8oWVSZHRasV3vFSp8ufOU8/uSQl+uhFzgYmpX2yJLAQEJF1wRAHKR+
         Ps+KX7k6sa/Jw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3115AC53BD0; Thu, 28 Sep 2023 02:31:13 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215801] Rmmod'ing amd-pstate doesn't restore acpi-cpufreq
Date:   Thu, 28 Sep 2023 02:31:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215801-137361-PxM3rN2Ggb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215801-137361@https.bugzilla.kernel.org/>
References: <bug-215801-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215801

--- Comment #5 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Artem S. Tashkinov from comment #4)
> (In reply to Perry Yuan(AMD) from comment #3)
> > (In reply to Artem S. Tashkinov from comment #2)
> > > This is still relevant as of Linux 6.6.
> > >=20
> > > Would be great if removing amd-pstate enabled acpi-cpufreq.
> >=20
> > Normally the system hardware needs to reinitialize CPPC and low-level p=
ower
> > management firmware when CPPC driver loading, so it better to change gr=
ub
> > parameters and reboot again.
> > dynamically removing amd-pstate and load acpi_cpufreq probably cause so=
me
> > potential issues.=20
> >=20
> > Perry.
>=20
> Could you add this as a note to the amd pstate driver documentation?
>=20
> Documentation/admin-guide/pm/amd-pstate.rst
>=20
> Thank you!


Sure, we can add this to amd-pstate.rst with a new update.=20

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
