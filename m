Return-Path: <linux-pm+bounces-22150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19808A36E10
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 13:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167A63A9C8E
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 12:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1CB1A4F09;
	Sat, 15 Feb 2025 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRr4JdPb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17D61922DE;
	Sat, 15 Feb 2025 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739622747; cv=none; b=p8mADPDwszUU4+4ISR8Q5++a/FTBLjYj6PTBgHrEM5SJbAT0U0/I4tffbSY58+jfbb6Oc8mbm+OLSlQ14Z1xhkB2F7FDGpD/R3p3YRt2XKh36M2RwB1T+CkqTGWQEj7yUdoQW8JYBxyM4KoJKvG6ZAMGIt72Ub7H5wiypJMUVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739622747; c=relaxed/simple;
	bh=pxL3I6JpZRiZ/DicB595jlWhSGuCzMtUKNs9R2zf78k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XT9Igu0MgAH2EOaLoGce7vh40dPs6J7XZ3UrjHRGXJunbtCEx5jZy3kAEX5iEthvE1fNVATU6kAvR+BKixfYWDPW+CTwB+NA1AgNKXw368WRrsTtPJz1NPHgEuTDevp8+YVG59ZFDGr6KetuiRkmMiYOZ7/2n8vVkidoT//8awA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRr4JdPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5478AC4CEE6;
	Sat, 15 Feb 2025 12:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739622747;
	bh=pxL3I6JpZRiZ/DicB595jlWhSGuCzMtUKNs9R2zf78k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QRr4JdPbOBm7uPjxegJgT8qmTfu71kXzdqdJv/GUVigIUtAwTaCAQ7JQqxPQ/uB3Z
	 3Aumnd864/zcvukheZadPeKpTW2dTJgjU7u2OtKwUC8WuEaD64IUg90iIuQt/UX0pc
	 B8Z26oNPQSQwWRyJiYpNX3rExj1tH8paF6yawdl3H1w1hvhIH2IpDPYiawZ7ReLWlZ
	 KSznlemYJ/srAfQDoRe2Rduvs6CKHH6pkC8dHZgt2FMFsDifVewmRY3bxo52ANh99F
	 KlH+E/jH0+ZD7Q4LQGZfsRn9h7QD8Om+fzu0F3arzCkJpsyA6JdbCAfz522KqHuIPx
	 fNEqmSOLbMZDw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5fa9778fa2cso1567139eaf.0;
        Sat, 15 Feb 2025 04:32:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWXPFLJCSwhcFw30dsdRsyyaIiYhy962khFAa9R2fX3fVGY+6td2ZEstEOgjJFDrW1/gNsMJlUtLKE=@vger.kernel.org, AJvYcCXiTU4f2XPXtt9gwqulEyOrkzK+CeQ51/NZfMhAU+cy0EKLAA0G911VpwpdQcvJftBecFRoNxQ+1QKq46w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/RSNPrWx3Gemolng5e1VZ1o5x9BFYIDGMDPQvc1f8P+xMrcHA
	E69aDmOLXsdyVqOM/XLpkQlp+6V1KsymNeezswG4cCwIwgYJjXoOwubIRUv2DWAjQbXoISTuKF3
	itfqWX10bL7khc99s+aYQFq8YYu4=
X-Google-Smtp-Source: AGHT+IGAd2rTamR3KLwnmSkmf+oNHNwrp8eoOfLrNSgoT5cvLyMqY6pP7GSarmem7uRju5IRW1XuzorG5veNC9k+0WE=
X-Received: by 2002:a05:6870:c14e:b0:29e:76c8:be2e with SMTP id
 586e51a60fabf-2bc99d5095cmr1379769fac.28.1739622746568; Sat, 15 Feb 2025
 04:32:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2314745.iZASKD2KPV@rjwysocki.net> <CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQGwNWeteJWqpW29BojhQ@mail.gmail.com>
 <CAJZ5v0h44Yxp95pHW+75gk5yWKviLO1_YK_cZNFKaGnid7nx9A@mail.gmail.com>
 <CAJZ5v0iMZ=6YgKR3ZZuiv7DF4=vfoFRonSoXO_zV65oZH2rOgA@mail.gmail.com>
 <CAPDyKFq91JnCFhEuitOJPZtq78-Y3CUy4p0bNE1wK+eYCste6g@mail.gmail.com>
 <CAJZ5v0iuLA9N5Vi-JNa8=uTO-kpsKNsRGKegYnCYLEhAn=nW9g@mail.gmail.com>
 <CAPDyKFr1LmYji1Yh=mrx03eeW8ukFr9rE0hk277iam174TjGig@mail.gmail.com>
 <CAJZ5v0hsEg7eFRg2Q2sbn0DkUoBu0F08B+0yVGAicKyQ91NKuA@mail.gmail.com> <CAPDyKFoLM-sW8SfcZa2v-ruFYYxz3ZR7oXw_G+SCwvcZoEPEKA@mail.gmail.com>
In-Reply-To: <CAPDyKFoLM-sW8SfcZa2v-ruFYYxz3ZR7oXw_G+SCwvcZoEPEKA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 15 Feb 2025 13:32:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hVMm3=G2WshxVc==7W=BTzepKAh2NgpVHwANUV5n9T9w@mail.gmail.com>
X-Gm-Features: AWEUYZl2I4qRn-r7REC1Xw5ikgbnMAmruwiMVCqLH431nRBmDVuGI3raeJHkHq8
Message-ID: <CAJZ5v0hVMm3=G2WshxVc==7W=BTzepKAh2NgpVHwANUV5n9T9w@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] PM: Make the core and pm_runtime_force_suspend/resume()
 agree more
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 10:55=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Thu, 13 Feb 2025 at 21:17, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Thu, Feb 13, 2025 at 2:11=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > On Wed, 12 Feb 2025 at 18:05, Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > > >
> > > > On Wed, Feb 12, 2025 at 4:15=E2=80=AFPM Ulf Hansson <ulf.hansson@li=
naro.org> wrote:
> > > > >
> > > > > On Wed, 12 Feb 2025 at 12:33, Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> > > > > >
> > > > > > On Wed, Feb 12, 2025 at 11:59=E2=80=AFAM Rafael J. Wysocki <raf=
ael@kernel.org> wrote:
> > > > > > >
> > > > > > > On Wed, Feb 12, 2025 at 10:12=E2=80=AFAM Ulf Hansson <ulf.han=
sson@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, 11 Feb 2025 at 22:25, Rafael J. Wysocki <rjw@rjwyso=
cki.net> wrote:
> > > > > > > > >
> > > > > > > > > Hi Everyone,
> > > > > > > > >
> > > > > > > > > This series is a result of the discussion on a recently r=
eported issue
> > > > > > > > > with device runtime PM status propagation during system r=
esume and
> > > > > > > > > the resulting patches:
> > > > > > > > >
> > > > > > > > > https://lore.kernel.org/linux-pm/12619233.O9o76ZdvQC@rjwy=
socki.net/
> > > > > > > > > https://lore.kernel.org/linux-pm/6137505.lOV4Wx5bFT@rjwys=
ocki.net/
> > > > > > > > >
> > > > > > > > > Overall, due to restrictions related to pm_runtime_force_=
suspend() and
> > > > > > > > > pm_runtime_force_resume(), it was necessary to limit the =
RPM_ACTIVE
> > > > > > > > > setting propagation to the parent of the first device in =
a dependency
> > > > > > > > > chain that turned out to have to be resumed during system=
 resume even
> > > > > > > > > though it was runtime-suspended before system suspend.
> > > > > > > > >
> > > > > > > > > Those restrictions are that (1) pm_runtime_force_suspend(=
) attempts to
> > > > > > > > > suspend devices that have never had runtime PM enabled if=
 their runtime
> > > > > > > > > PM status is currently RPM_ACTIVE and (2) pm_runtime_forc=
e_resume()
> > > > > > > > > will skip device whose runtime PM status is currently RPM=
_ACTIVE.
> > > > > > > > >
> > > > > > > > > The purpose of this series is to eliminate the above rest=
rictions and
> > > > > > > > > get pm_runtime_force_suspend() and pm_runtime_force_resum=
e() to agree
> > > > > > > > > more with what the core does.
> > > > > > > >
> > > > > > > > For my understanding, would you mind elaborating a bit more=
 around the
> > > > > > > > end-goal with this?
> > > > > > >
> > > > > > > The end goal is, of course, full integration of runtime PM wi=
th system
> > > > > > > sleep for all devices.  Eventually.
> > > > > > >
> > > > > > > And it is necessary to make the core and
> > > > > > > pm_runtime_force_suspend|resume() work together better for th=
is
> > > > > > > purpose.
> > > > > > >
> > > > > > > > Are you trying to make adaptations for
> > > > > > > > pm_runtime_force_suspend|resume() and the PM core, such tha=
t drivers
> > > > > > > > that uses pm_runtime_force_suspend|resume() should be able =
to cope
> > > > > > > > with other drivers for child-devices that make use of
> > > > > > > > DPM_FLAG_SMART_SUSPEND?
> > > > > > >
> > > > > > > Yes.
> > > > > > >
> > > > > > > This is a more general case, though, when a device that was
> > > > > > > runtime-suspended before system suspend and is left in suspen=
d during
> > > > > > > it, needs to be resumed during the system resume that follows=
.
> > > > > > >
> > > > > > > Currently, DPM_FLAG_SMART_SUSPEND can lead to this sometimes =
and it
> > > > > > > cannot happen otherwise, but I think that it is a generally v=
alid
> > > > > > > case.
> > > > > > >
> > > > > > > > If we can make this work, it would enable the propagation o=
f
> > > > > > > > RPM_ACTIVE in the PM core for more devices, but still not f=
or all,
> > > > > > > > right?
> > > > > > >
> > > > > > > It is all until there is a known case in which it isn't.  So =
either
> > > > > > > you know a specific case in which it doesn't work, or I don't=
 see a
> > > > > > > reason for avoiding it.
> > > > > > >
> > > > > > > ATM the only specific case in which it doesn't work is when
> > > > > > > pm_runtime_force_suspend|resume() are used.
> > > > > > >
> > > > > > > > The point is, the other bigger issue that I pointed out in =
our earlier
> > > > > > > > discussions; all those devices where their drivers/buses do=
n't cope
> > > > > > > > with the behaviour of the DPM_FLAG_SMART_SUSPEND flag, will=
 prevent
> > > > > > > > the PM core from *unconditionally* propagating the RPM_ACTI=
VE to
> > > > > > > > parents. I guess this is the best we can do then?
> > > > > > >
> > > > > > > OK, what are they?
> > > > > > >
> > > > > > > You keep saying that they exist without giving any examples.
> > > > > >
> > > > > > To put it more bluntly, I'm not aware of any place other than
> > > > > > pm_runtime_force_suspend|resume() that can be confused by chang=
ing the
> > > > > > runtime PM status of a device with runtime PM disabled (either
> > > > > > permanently, or transiently during a system suspend-resume cycl=
e) to
> > > > > > RPM_ACTIVE, so if there are any such places, I would appreciate
> > > > > > letting me know what they are.
> > > > >
> > > > > Well, sorry I thought you were aware. Anyway, I believe you need =
to do
> > > > > your own investigation as it's simply too time consuming for me t=
o
> > > > > find them all. The problem is that it's not just a simple pattern=
 to
> > > > > search for, so we would need some clever scripting to move forwar=
d to
> > > > > find them.
> > > > >
> > > > > To start with, we should look for drivers that enable runtime PM,=
 by
> > > > > calling pm_runtime_enable().
> > > > >
> > > > > Additionally, in their system suspend callback they should typica=
lly
> > > > > *not* use pm_runtime_suspended(), pm_runtime_status_suspended() o=
r
> > > > > pm_runtime_active() as that is usually (but no always) indicating=
 that
> > > > > they got it right. Then there are those that don't have system
> > > > > suspend/resume callbacks assigned at all (or uses some other subs=
ystem
> > > > > specific callback for this), but only uses runtime PM.
> > > > >
> > > > > On top of that, drivers that makes use of
> > > > > pm_runtime_force_suspend|resume() should be disregarded, which ha=
s
> > > > > reached beyond 300 as this point.
> > > > >
> > > > > Anyway, here is just one example that I found from a quick search=
.
> > > > > drivers/i2c/busses/i2c-qcom-geni.c
> > > >
> > > > OK, I see.
> > > >
> > > > It sets the status to RPM_SUSPENDED in geni_i2c_suspend_noirq(), if
> > > > not suspended already, and assumes it to stay this way across
> > > > geni_i2c_resume_noirq() until someone resumes it via runtime PM.
> > > >
> > > > Fair enough, but somebody should tell them that they don't need to =
use
> > > > pm_runtime_disable/enable() in _noirq.
> > > >
> > > > > >
> > > > > > Note that rpm_active() could start producing confusing results =
if the
> > > > > > runtime PM status of a device with runtime PM disabled is chang=
ed from
> > > > > > RPM_ACTIVE to RPM_SUSPENDED because it will then start to retur=
n
> > > > > > -EACCES instead of 1, but changing the status to RPM_ACTIVE wil=
l not
> > > > > > confuse it the same way.
> > > > >
> > > > > Trust me, it will cause problems.
> > > > >
> > > > > Drivers may call pm_runtime_get_sync() to turn on the resources f=
or
> > > > > the device after the system has resumed, when runtime PM has been
> > > > > re-enabled for the device by the PM core.
> > > > >
> > > > > Those calls to pm_runtime_get_sync() will then not end up invokin=
g any
> > > > > if ->runtime_resume() callbacks for the device since its state is
> > > > > already RPM_ACTIVE. Hence, the device will remain in a low power =
state
> > > > > even if the driver believes it has been powered on. In many cases=
,
> > > > > accessing the device (like reading/writing a register) will often=
 just
> > > > > just hang in these cases, but in worst cases we could end up gett=
ing
> > > > > even more difficult bugs to debug.
> > > >
> > > > Sure, that would be a problem.
> > > >
> > > > I think I need to find a different way to address the problem I'm
> > > > seeing, that is to resume devices that were runtime-suspended befor=
e
> > > > system suspend along with their superiors.
> > > >
> > > > One way to do it would be to just defer their resume to the point w=
hen
> > > > the core has enabled runtime PM for them, which means that it has a=
lso
> > > > enabled runtime PM for all of their superiors, and then call
> > > > pm_runtime_resume().
> > > >
> > > > This should work unless one of the superiors has runtime PM disable=
d
> > > > at that point, of course.
> > >
> > > Right, so typically users of pm_runtime_force_suspend|resume() from
> > > the regular ->suspend|resume() callbacks would not work, because they
> > > disable/enable runtime PM. Although, we could probably fix this quite
> > > easily by making some adaptations in
> > > pm_runtime_force_suspend|resume().
> > >
> > > I am not sure if this approach would have any other issue though, but
> > > it seems like it could make sense to explore this approach. In genera=
l
> > > drivers should cope with their devices being runtime resumed if
> > > runtime PM is enabled, right!?

In theory.

In practice, though, to start with, this can only be done for devices
whose drivers opt-in (or don't care) and starting with "leaf" devices
(no children or consumers).

> > > If this works, it seems like a generic and a good solution to me.
> >
> > For PCI ports, though, it would require some tuning of
> > ->runtime_resume(), so it is not as simple as it would seem to be in
> > the end.
>
> Okay. Perhaps it would be worth it to try this out anyway, as it would
> allow us to keep the PM core as simple as possible?

Except that initially it will need the same opt-in from everybody
involved as the set active propagation, at least initially, so IMV it
is better to start enforcing the opt-in requirement first and then
convert stuff to the new approach.

