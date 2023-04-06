Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58846D91DD
	for <lists+linux-pm@lfdr.de>; Thu,  6 Apr 2023 10:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbjDFImb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Apr 2023 04:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjDFIma (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Apr 2023 04:42:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0964961BF;
        Thu,  6 Apr 2023 01:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8445963D3A;
        Thu,  6 Apr 2023 08:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BF2C433EF;
        Thu,  6 Apr 2023 08:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680770547;
        bh=i3Ygol4vLeOR82TBK9DpW4bTLHkspuPPD6gKyABYHMI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i5+gAyOI7VCazBa5+/A5mCmEIM4o3q3BpZtKQaaY0H6gzleKFszck/GDN5kMVk1gL
         AjPmGg8DTt/RJ1pd031YBTz+AlshMAPFf5cCiSJVfNw41eLFseMutPsVF0EhbHGVWk
         UegmFQ+3591c38spZk/PVV8j1uI9viGaUDyU5YuQr459vXSKZWdPMT708dEkzjsd77
         psxxNtfE4TM+UpKND0WlNovrI7SIalxPc3xj6oxd6miAVba2ecpFOM2i5GBnnTUXSN
         8mLNKmInlBgwidENNWhlJENR/FmmBBbAdA5qZ9gCWPEXoP/CxpWwzebvQzDtLnv1R2
         dTSMkkXDHf6xg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pkLCL-006FGs-2X;
        Thu, 06 Apr 2023 09:42:25 +0100
Date:   Thu, 06 Apr 2023 09:42:24 +0100
Message-ID: <86o7o1v1u7.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     David Dai <davidai@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [RFC PATCH 0/6] Improve VM DVFS and task placement behavior
In-Reply-To: <CAGETcx90SiaztPO21GsHSr18XUTHoLWt3Jv+y=EW5yfjJgzJHw@mail.gmail.com>
References: <20230330224348.1006691-1-davidai@google.com>
        <ZCx97IKjsBibjdGc@linux.dev>
        <86sfdfv0e1.wl-maz@kernel.org>
        <CAGETcx90SiaztPO21GsHSr18XUTHoLWt3Jv+y=EW5yfjJgzJHw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/28.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: saravanak@google.com, davidai@google.com, oliver.upton@linux.dev, rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, pbonzini@redhat.com, corbet@lwn.net, james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, lpieralisi@kernel.org, sudeep.holla@arm.com, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, kernel-team@android.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 05 Apr 2023 22:00:59 +0100,
Saravana Kannan <saravanak@google.com> wrote:
>=20
> On Tue, Apr 4, 2023 at 1:49=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrot=
e:
> >
> > On Tue, 04 Apr 2023 20:43:40 +0100,
> > Oliver Upton <oliver.upton@linux.dev> wrote:
> > >
> > > Folks,
> > >
> > > On Thu, Mar 30, 2023 at 03:43:35PM -0700, David Dai wrote:
> > >
> > > <snip>
> > >
> > > > PCMark
> > > > Higher is better
> > > > +-------------------+----------+------------+--------+-------+-----=
---+
> > > > | Test Case (score) | Baseline |  Hypercall | %delta |  MMIO | %del=
ta |
> > > > +-------------------+----------+------------+--------+-------+-----=
---+
> > > > | Weighted Total    |     6136 |       7274 |   +19% |  6867 |   +1=
2% |
> > > > +-------------------+----------+------------+--------+-------+-----=
---+
> > > > | Web Browsing      |     5558 |       6273 |   +13% |  6035 |    +=
9% |
> > > > +-------------------+----------+------------+--------+-------+-----=
---+
> > > > | Video Editing     |     4921 |       5221 |    +6% |  5167 |    +=
5% |
> > > > +-------------------+----------+------------+--------+-------+-----=
---+
> > > > | Writing           |     6864 |       8825 |   +29% |  8529 |   +2=
4% |
> > > > +-------------------+----------+------------+--------+-------+-----=
---+
> > > > | Photo Editing     |     7983 |      11593 |   +45% | 10812 |   +3=
5% |
> > > > +-------------------+----------+------------+--------+-------+-----=
---+
> > > > | Data Manipulation |     5814 |       6081 |    +5% |  5327 |    -=
8% |
> > > > +-------------------+----------+------------+--------+-------+-----=
---+
> > > >
> > > > PCMark Performance/mAh
> > > > Higher is better
> > > > +-----------+----------+-----------+--------+------+--------+
> > > > |           | Baseline | Hypercall | %delta | MMIO | %delta |
> > > > +-----------+----------+-----------+--------+------+--------+
> > > > | Score/mAh |       79 |        88 |   +11% |   83 |    +7% |
> > > > +-----------+----------+-----------+--------+------+--------+
> > > >
> > > > Roblox
> > > > Higher is better
> > > > +-----+----------+------------+--------+-------+--------+
> > > > |     | Baseline |  Hypercall | %delta |  MMIO | %delta |
> > > > +-----+----------+------------+--------+-------+--------+
> > > > | FPS |    18.25 |      28.66 |   +57% | 24.06 |   +32% |
> > > > +-----+----------+------------+--------+-------+--------+
> > > >
> > > > Roblox Frames/mAh
> > > > Higher is better
> > > > +------------+----------+------------+--------+--------+--------+
> > > > |            | Baseline |  Hypercall | %delta |   MMIO | %delta |
> > > > +------------+----------+------------+--------+--------+--------+
> > > > | Frames/mAh |    91.25 |     114.64 |   +26% | 103.11 |   +13% |
> > > > +------------+----------+------------+--------+--------+--------+
> > >
> > > </snip>
> > >
> > > > Next steps:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > We are continuing to look into communication mechanisms other than
> > > > hypercalls that are just as/more efficient and avoid switching into=
 the VMM
> > > > userspace. Any inputs in this regard are greatly appreciated.
>=20
> Hi Oliver and Marc,
>=20
> Replying to both of you in this one email.
>=20
> > >
> > > We're highly unlikely to entertain such an interface in KVM.
> > >
> > > The entire feature is dependent on pinning vCPUs to physical cores, f=
or which
> > > userspace is in the driver's seat. That is a well established and doc=
umented
> > > policy which can be seen in the way we handle heterogeneous systems a=
nd
> > > vPMU.
> > >
> > > Additionally, this bloats the KVM PV ABI with highly VMM-dependent in=
terfaces
> > > that I would not expect to benefit the typical user of KVM.
> > >
> > > Based on the data above, it would appear that the userspace implement=
ation is
> > > in the same neighborhood as a KVM-based implementation, which only fu=
rther
> > > weakens the case for moving this into the kernel.
>=20
> Oliver,
>=20
> Sorry if the tables/data aren't presented in an intuitive way, but
> MMIO vs hypercall is definitely not in the same neighborhood. The
> hypercall method often gives close to 2x the improvement that the MMIO
> method gives. For example:
>=20
> - Roblox FPS: MMIO improves it by 32% vs hypercall improves it by 57%.
> - Frames/mAh: MMIO improves it by 13% vs hypercall improves it by 26%.
> - PC Mark Data manipulation: MMIO makes it worse by 8% vs hypercall
> improves it by 5%
>=20
> Hypercall does better for other cases too, just not as good. For example,
> - PC Mark Photo editing: Going from MMIO to hypercall gives a 10% improve=
ment.
>=20
> These are all pretty non-trivial, at least in the mobile world. Heck,
> whole teams would spend months for 2% improvement in battery :)
>
> > >
> > > I certainly can appreciate the motivation for the series, but this fe=
ature
> > > should be in userspace as some form of a virtual device.
> >
> > +1 on all of the above.
>=20
> Marc and Oliver,
>=20
> We are not tied to hypercalls. We want to do the right thing here, but
> MMIO going all the way to userspace definitely doesn't cut it as is.
> This is where we need some guidance. See more below.

I don't buy this assertion at all. An MMIO in userspace is already
much better than nothing. One of my many objection to the whole series
is that it is built as a massively invasive thing that has too many
fingers in too many pies, with unsustainable assumptions such as 1:1
mapping between CPU and vCPUs.

I'd rather you build something simple first (pure userspace using
MMIOs), work out where the bottlenecks are, and work with us to add
what is needed to get to something sensible, and only that. I'm not
willing to sacrifice maintainability for maximum performance (the
whole thing reminds me of the in-kernel http server...).

>=20
> > The one thing I'd like to understand that the comment seems to imply
> > that there is a significant difference in overhead between a hypercall
> > and an MMIO. In my experience, both are pretty similar in cost for a
> > handling location (both in userspace or both in the kernel).
>=20
> I think the main difference really is that in our hypercall vs MMIO
> comparison the hypercall is handled in the kernel vs MMIO goes all the
> way to userspace. I agree with you that the difference probably won't
> be significant if both of them go to the same "depth" in the privilege
> levels.
>=20
> > MMIO
> > handling is a tiny bit more expensive due to a guaranteed TLB miss
> > followed by a walk of the in-kernel device ranges, but that's all. It
> > should hardly register.
> >
> > And if you really want some super-low latency, low overhead
> > signalling, maybe an exception is the wrong tool for the job. Shared
> > memory communication could be more appropriate.
>=20
> Yeah, that's one of our next steps. Ideally, we want to use shared
> memory for the host to guest information flow. It's a 32-bit value
> representing the current frequency that the host can update whenever
> the host CPU frequency changes and the guest can read whenever it
> needs it.

Why should the guest care? Why can't the guest ask for an arbitrary
capacity, and get what it gets? You give no information as to *why*
you are doing what you are doing...

>=20
> For guest to host information flow, we'll need a kick from guest to
> host because we need to take action on the host side when threads
> migrate between vCPUs and cause a significant change in vCPU util.
> Again it can be just a shared memory and some kick. This is what we
> are currently trying to figure out how to do.

That kick would have to go to userspace. There is no way I'm willing
to introduce scheduling primitives inside KVM (the ones we have are
ridiculously bad anyway), and I very much want to avoid extra PV gunk.

> If there are APIs to do this, can you point us to those please? We'd
> also want the shared memory to be accessible by the VMM (so, shared
> between guest kernel, host kernel and VMM).

By default, *ALL* the memory is shared. Isn't that wonderful?

>=20
> Are the above next steps sane? Or is that a no-go? The main thing we
> want to cut out is the need for having to switch to userspace for
> every single interaction because, as is, it leaves a lot on the table.

Well, for a start, you could disclose how often you hit this DVFS
"device", and when are the critical state changes that must happen
immediately vs those that can simply be posted without having to take
immediate effect.

This sort of information would be much more interesting than a bunch
of benchmarks I know nothing about.

Thanks,

	M.

--=20
Without deviation from the norm, progress is not possible.
