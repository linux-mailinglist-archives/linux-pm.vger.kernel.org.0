Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B10D5614FC
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 10:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiF3I0p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 04:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiF3I0Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 04:26:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C674DF48
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 01:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB1A961F01
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 08:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31B64C341CD
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 08:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656577582;
        bh=CaZuS93nFmG57XOcu+wUiUdFD1Ce9/+KhFx+ywquBL8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=elf0k1qi8QkfejQwHCYnZItPvkx5dXYKvlxGLh+0SpnaqxdcFR1jjm4Cksx1vHwJk
         j3ytS8snwH4mbfi7R1X1Wb09DmTY1eFqtnMq6ij3Z1X/GyNFZEHRa6srQYesFZewgt
         9nikZuEJyMd6dmXFN+a5DNqatY37ydnTZVxsauVygPb+ScUA44Ib0RKsGu37dLPmoU
         AvFBFBIHdsJgr7vaYEOFHlzoRPMLmhjJEyT4mhSXGdiFRPmmQr97pYOOQca1MRei/V
         6QpZ5EiJVuxN7iziaszKeAPlZ4OWhEhZAwohT2aUeG6umQQUuKYO34L46j/gA+UdzG
         Tsk7aq8k8VDSA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 16BC1CC13B0; Thu, 30 Jun 2022 08:26:22 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216189] amd-pstate stops working after S3 suspend
Date:   Thu, 30 Jun 2022 08:26:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sujinzhou2008@126.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216189-137361-XsuNU4FK1J@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216189-137361@https.bugzilla.kernel.org/>
References: <bug-216189-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216189

Joe (sujinzhou2008@126.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sujinzhou2008@126.com

--- Comment #3 from Joe (sujinzhou2008@126.com) ---
Hello,=20

The fixed patch has been accepted. It will be updated in 5.19.

Here is the detail

On Thu, Jun 23, 2022 at 9:53 AM Huang Rui <ray.huang@amd.com> wrote:
>
> On Thu, Jun 23, 2022 at 11:15:09AM +0800, Su, Jinzhou (Joe) wrote:
> > When system resumes from S3, the CPPC enable register will be=20
> > cleared and reset to 0. So sets this bit to enable CPPC interface by=20
> > writing 1 to this register.
> >
> > Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
>
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> Cc: stable@vger.kernel.org
>
> You can add one line below your commit description to Cc stable=20
> mailing list. And next time in V2, it's better to use subject-prefix=20
> optional to mark it as v2 like below:
>
> git format-patch --subject-prefix=3D"PATCH v2" HEAD~
>
> Other looks good for me, patch is
>
> Acked-by: Huang Rui <ray.huang@amd.com>
>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c=20
> > b/drivers/cpufreq/amd-pstate.c index 7be38bc6a673..9ac75c1cde9c=20
> > 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -566,6 +566,28 @@ static int amd_pstate_cpu_exit(struct cpufreq_poli=
cy
> *policy)
> >       return 0;
> >  }
> >
> > +static int amd_pstate_cpu_resume(struct cpufreq_policy *policy) {
> > +     int ret;
> > +
> > +     ret =3D amd_pstate_enable(true);
> > +     if (ret)
> > +             pr_err("failed to enable amd-pstate during resume,=20
> > + return %d\n", ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy) {
> > +     int ret;
> > +
> > +     ret =3D amd_pstate_enable(false);
> > +     if (ret)
> > +             pr_err("failed to disable amd-pstate during suspend,=20
> > + return %d\n", ret);
> > +
> > +     return ret;
> > +}
> > +
> >  /* Sysfs attributes */
> >
> >  /*
> > @@ -636,6 +658,8 @@ static struct cpufreq_driver amd_pstate_driver =3D {
> >       .target         =3D amd_pstate_target,
> >       .init           =3D amd_pstate_cpu_init,
> >       .exit           =3D amd_pstate_cpu_exit,
> > +     .suspend        =3D amd_pstate_cpu_suspend,
> > +     .resume         =3D amd_pstate_cpu_resume,
> >       .set_boost      =3D amd_pstate_set_boost,
> >       .name           =3D "amd-pstate",
> >       .attr           =3D amd_pstate_attr,
> > --

Applied with some edits in the subject and changelog, and a CC:stable tag
added, as 5.19-rc material.

Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
