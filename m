Return-Path: <linux-pm+bounces-10286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB08991E48B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 17:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354461F2534A
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E0616D334;
	Mon,  1 Jul 2024 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGIasQMv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EAF3236;
	Mon,  1 Jul 2024 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848888; cv=none; b=HEa+h8AuEbRp5kLct2QCD0+xt+zeqsKVpAFziB2+HFwVvkeR9E3z+mCgW3e8gnWc72URUKG++hoiZwu8sOhDEOqXU60zUNjQrYHLk/ToCkkDvsgg/Red3zn6sInye/ZoSdixu3qbpSdslC+HRoYaj4SToz9KUL6JEESW2BAu9hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848888; c=relaxed/simple;
	bh=/VH/3Ey/xG35l3GHO0Mz0W9la2fMePm/3Z9rnD2V+4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6QA3jpTIs9cq1oz0Lz9BbEjKzuDX76jDeRcUoCeUiFktVXMM+fB62LhDwvOzy2LETQPSUjprHTA+GinAdjH4kZpw2Wl8rHoGi+RwVt2mvVgBjmOLqcvOWf5CusC7Z0gE3UDVomFtMfMtl+z4VZqbb07rvyQz2G1O88H27NVQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGIasQMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497E5C32786;
	Mon,  1 Jul 2024 15:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719848888;
	bh=/VH/3Ey/xG35l3GHO0Mz0W9la2fMePm/3Z9rnD2V+4E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uGIasQMvuXMBB49ZwGgSdjKkJ8GxSNlpuI/4jSIxI+HVxLyA6ba5Ft2v0vltED1tp
	 wSrRbiA4FvUw2kc4/flO1/Uu7Bz0DpJ29MgGk8dHIPAC+/OVk70MVuSTwyEiK5iZNG
	 6GlAyJIyuRxnm2n6cIYQf/kTk9Z4szxmy/JShyIVkh0Nb9x/i6D9bvIufSSjLnOWWH
	 h0f03dCuywssH1NZAzEIEZBODP2/YJt/Qu0zJIw4UKtHzxHUk2cTT9zwOoXRMDZ8vR
	 It/Etw85yrhQWGZ3l0pJ9tz+e+0sdN+Fw36ZsINa4ta0UHKRlrwYLxFqMN+O0c4ZNK
	 G/wYP4mApcpfw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25cc44857a1so335434fac.3;
        Mon, 01 Jul 2024 08:48:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWfLnGrvcIJyBtHtSO2hmnQ/BYmeXzejqZnpgDep1DIZI6oE3+RdGsPQxcsEAkjU2S6UulIYy9k1M8i9jo82XcAreS0cTfmwrzYedxvvxic3NpD8EV8m1CDv0311etLeVKK/z6lCrRP27lMDcLBnW4CoLyM++WrgIOTcZZVgZKR+pZ
X-Gm-Message-State: AOJu0Yy25keq0x7YIKLJvl7U4LExnUAzJYmU7fS7v2Qg93pwxsm6K5Dq
	HZhkPnTDbl2ZOkKVkAZUuJORooyPiWooc9k0haBHpopk3GicBtamT4iCxtRGEBBIekUeGS1EJIw
	SzCfwf/+iZGi7IjqkR2VXzVonvC8=
X-Google-Smtp-Source: AGHT+IH/fEob6+VKSIrt2TPZFzQS/Lx2tB+/dy8MJsM5vB+GatoWKl4OltK48wxmENCyhWXyGLXsRaNEcgrxy/sWOm0=
X-Received: by 2002:a05:6870:b155:b0:254:d417:351f with SMTP id
 586e51a60fabf-25db338f8f9mr6474785fac.1.1719848887517; Mon, 01 Jul 2024
 08:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
 <CAJZ5v0iO6MrX3QxAu4Wj4grUL2g7gPPXO3f8PFmZBot-Ud32TQ@mail.gmail.com> <9c2971dd-2f2d-426f-9107-eae93d5dd554@linaro.org>
In-Reply-To: <9c2971dd-2f2d-426f-9107-eae93d5dd554@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jul 2024 17:47:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ip9P7uD76i-SDxpea1Qj_8vgqhQ-jJt2h5iqYsMUaCzg@mail.gmail.com>
Message-ID: <CAJZ5v0ip9P7uD76i-SDxpea1Qj_8vgqhQ-jJt2h5iqYsMUaCzg@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Introduce user trip points
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 5:13=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 28/06/2024 15:56, Rafael J. Wysocki wrote:
> > On Thu, Jun 27, 2024 at 10:55=E2=80=AFAM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> Currently the thermal framework has 4 trip point types:
> >>
> >> - active : basically for fans (or anything requiring energy to cool
> >>    down)
> >>
> >> - passive : a performance limiter
> >>
> >> - hot : for a last action before reaching critical
> >>
> >> - critical : a without return threshold leading to a system shutdown
> >>
> >> A thermal zone monitors the temperature regarding these trip
> >> points. The old way to do that is actively polling the temperature
> >> which is very bad for embedded systems, especially mobile and it is
> >> even worse today as we can have more than fifty thermal zones. The
> >> modern way is to rely on the driver to send an interrupt when the trip
> >> points are crossed, so the system can sleep while the temperature
> >> monitoring is offloaded to a dedicated hardware.
> >>
> >> However, the thermal aspect is also managed from userspace to protect
> >> the user, especially tracking down the skin temperature sensor. The
> >> logic is more complex than what we found in the kernel because it
> >> needs multiple sources indicating the thermal situation of the entire
> >> system.
> >>
> >> For this reason it needs to setup trip points at different levels in
> >> order to get informed about what is going on with some thermal zones
> >> when running some specific application.
> >>
> >> For instance, the skin temperature must be limited to 43=C2=B0C on a l=
ong
> >> run but can go to 48=C2=B0C for 10 minutes, or 60=C2=B0C for 1 minute.
> >>
> >> The thermal engine must then rely on trip points to monitor those
> >> temperatures. Unfortunately, today there is only 'active' and
> >> 'passive' trip points which has a specific meaning for the kernel, not
> >> the userspace. That leads to hacks in different platforms for mobile
> >> and embedded systems where 'active' trip points are used to send
> >> notification to the userspace. This is obviously not right because
> >> these trip are handled by the kernel.
> >>
> >> This patch introduces the 'user' trip point type where its semantic is
> >> simple: do nothing at the kernel level, just send a notification to
> >> the user space.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>   .../devicetree/bindings/thermal/thermal-zones.yaml        | 1 +
> >>   drivers/thermal/thermal_core.c                            | 8 ++++++=
++
> >>   drivers/thermal/thermal_of.c                              | 1 +
> >>   drivers/thermal/thermal_trace.h                           | 4 +++-
> >>   drivers/thermal/thermal_trip.c                            | 1 +
> >>   include/uapi/linux/thermal.h                              | 1 +
> >>   6 files changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.y=
aml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >> index 68398e7e8655..cb9ea54a192e 100644
> >> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >> @@ -153,6 +153,7 @@ patternProperties:
> >>                 type:
> >>                   $ref: /schemas/types.yaml#/definitions/string
> >>                   enum:
> >> +                  - user     # enable user notification
> >>                     - active   # enable active cooling e.g. fans
> >>                     - passive  # enable passive cooling e.g. throttlin=
g cpu
> >>                     - hot      # send notification to driver
> >> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_=
core.c
> >> index 2aa04c46a425..506f880d9aa9 100644
> >> --- a/drivers/thermal/thermal_core.c
> >> +++ b/drivers/thermal/thermal_core.c
> >> @@ -734,6 +734,14 @@ int thermal_bind_cdev_to_trip(struct thermal_zone=
_device *tz,
> >>          if (tz !=3D pos1 || cdev !=3D pos2)
> >>                  return -EINVAL;
> >>
> >> +       /*
> >> +        * It is not allowed to bind a cooling device with a trip
> >> +        * point user type because no mitigation should happen from
> >> +        * the kernel with these trip points
> >> +        */
> >> +       if (trip->type =3D=3D THERMAL_TRIP_USER)
> >> +               return -EINVAL;
> >
> > Maybe print a debug message when bailing out here?
>
> After thinking a bit about the message, it sounds to me that is a really
> an error in the firmware if we end up binding an 'user' trip point.
>
> What about the following message:
>
> dev_err(tz->device, "Trying to bind the cooling device '%s' with an
> 'user' trip point id=3D%d", cdev->type, trip->id);

s/an// I think.

Also I wouldn't use dev_err() as it indicates a kernel issue.  Maybe
dev_info(tz->device, FW_BUG ...)?

