Return-Path: <linux-pm+bounces-147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D00117F67D5
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 20:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AB3AB20FA4
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 19:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF57F4D11A;
	Thu, 23 Nov 2023 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA55091;
	Thu, 23 Nov 2023 11:50:14 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1efba24b038so279087fac.1;
        Thu, 23 Nov 2023 11:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700769014; x=1701373814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPnVIP7WE+e1m6kbF0iZl32seDul9DiRZGTrCiOrxg0=;
        b=FNIWBW2c7Kj6ZofayiRNXObglnaSc+VU/SNbg0ft6JE7UTzJc5Mebgwio3mbx1OjpK
         6zs8uu89SJPbQRvoflVlE8chKohmuZgGOgSR9+5PXUXDWawDo8Tf8MgMZyPCKM9JJ1f4
         GvlDXoxOEI0JMhAYQrhvBq+hWEZC9vXXmmvZFIp/+ht1a2qNnPJXYhmhaEkpS8TC4zpD
         Y4OdVYauiQ7/HaUyK9oQFpWhtuOwEv2I0IbJ3F7MpArbSnF5PO8wVKnsHWq8HbVtsvom
         leRFITfw7BAGE3PhPFRFVsXS6J336C04r3Fhf24HrS+cktjJnSFn4KCjt/s8hvqYi29M
         awug==
X-Gm-Message-State: AOJu0YzMXzcUP4hmO2AxCShoIGz0fHgEORzW1hXUyAlY1rAzyYuOLYMy
	WVBIOiBWF0GWAUg3fptvOEqaNRQuRgBOOa8pg931+S1/
X-Google-Smtp-Source: AGHT+IFUFtQSgD+W8Yy8QPiwQE4p1RlFzJFt/GSUiRGPuyvIdEEMv1z9wpYE6RAlbcCC6n75J8HSPBnaL6jFaFWFHNM=
X-Received: by 2002:a05:6871:530f:b0:1d0:e372:6cf8 with SMTP id
 hx15-20020a056871530f00b001d0e3726cf8mr463783oac.2.1700769014104; Thu, 23 Nov
 2023 11:50:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025192225.468228-1-lukasz.luba@arm.com> <CAJZ5v0gniBtFduwjhDku+OZzjvkCaFK7ew0uJTfW254XKTOyyw@mail.gmail.com>
 <ce8f1a13-b56f-4419-a954-8d987af44112@arm.com> <5fd9ce52-9216-47ae-9ed3-fabb0f3b02fd@arm.com>
In-Reply-To: <5fd9ce52-9216-47ae-9ed3-fabb0f3b02fd@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Nov 2023 20:50:01 +0100
Message-ID: <CAJZ5v0jL38PgFYVXFj2Py5NvUU0xFGU45w=TdcBXqr7v+xToag@mail.gmail.com>
Subject: Re: [PATCH 0/7] Minor cleanup for thermal gov power allocator
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Thu, Nov 23, 2023 at 4:19=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Rafael,
>
> Gentle ping
>
> On 10/26/23 13:22, Lukasz Luba wrote:
> >
> >
> > On 10/26/23 09:54, Rafael J. Wysocki wrote:
> >> On Wed, Oct 25, 2023 at 9:21=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.c=
om> wrote:
> >>>
> >>> Hi all,
> >>>
> >>> The patch set does some small clean up for Intelligent Power Allocato=
r.
> >>> Those changes are not expected to alter the general functionality.
> >>> They just
> >>> improve the code reading. Only patch 3/7 might improve the use case f=
or
> >>> binding the governor to thermal zone (very unlikely in real products,
> >>> but
> >>> it's needed for correctness).
> >>>
> >>> The changes are based on top of current PM thermal branch, so with th=
e
> >>> new trip points.
> >>>
> >>> Regards,
> >>> Lukasz
> >>>
> >>> Lukasz Luba (7):
> >>>    thermal: gov_power_allocator: Rename trip_max_desired_temperature
> >>>    thermal: gov_power_allocator: Setup trip points earlier
> >>>    thermal: gov_power_allocator: Check the cooling devices only for
> >>>      trip_max
> >>>    thermal: gov_power_allocator: Rearrange the order of variables
> >>>    thermal: gov_power_allocator: Use shorter variable when possible
> >>>    thermal: gov_power_allocator: Remove unneeded local variables
> >>>    thermal: gov_power_allocator: Clean needed variables at the beginn=
ing
> >>>
> >>>   drivers/thermal/gov_power_allocator.c | 123 ++++++++++++++---------=
---
> >>>   1 file changed, 64 insertions(+), 59 deletions(-)
> >>>
> >>> --
> >>
> >> The series looks good to me overall, but I'd prefer to make these
> >> changes in the 6.8 cycle, because the 6.7 merge window is around the
> >> corner and there is quite a bit of thermal material in this cycle
> >> already.
> >
> > Thanks for having a look! Yes, I agree, we can wait after the
> > merge window. It just have to be cleaned one day a bit and I postponed
> > this a few times, so no rush ;)
>
> I've seen you've created the new pm/thermal. Could you consider to take
> those in, please?

Sure, I'll get to them presumably tomorrow and if not then early next week.

> I would send some RFC on top showing the issue with reading back the CPU
> max frequency from the PM_QoS chain.

Sounds good.

