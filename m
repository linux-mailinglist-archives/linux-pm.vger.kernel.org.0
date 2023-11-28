Return-Path: <linux-pm+bounces-399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D90E7FBDE8
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 16:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC361C20EC1
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6C85D495;
	Tue, 28 Nov 2023 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4ED10D2;
	Tue, 28 Nov 2023 07:17:16 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1d542f05b9aso848519fac.1;
        Tue, 28 Nov 2023 07:17:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701184635; x=1701789435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEkj8M4mMYU4cH7Z21tsJI4k0QP7SojOHiRyJb1hJ0I=;
        b=GH3I69rfOjvaEPmWQZ+42r0t2fjX1WkF6cVT+4W+jOJ3ya57Tzat2uBcxtkbSJARJh
         98Z3rfBhxV3LLEJyMlmCBni7ihaeTtK/BAi8Xaug3gd6s3OqCl9za8pb1w0zoKJlh9+g
         NpXcx75FBH4JkdiQZSdcMpkGzOdUr7Up6b81bBjAjwV/XMycv+Ke76aGlSCOJg6ZbOMG
         6hqTNYGwiRMNc1ln629QTBw/pImUTJsQ4JKN31FV9Ta7VKvMktp+rFSThygWeN8Kym+K
         l9ppGVUF0s3dLzOq1dPwZtsJooLUrPTPF5A3yvfYrq2zVs5Uaddr8gnG2daMnqBDSSS2
         p7Ug==
X-Gm-Message-State: AOJu0YzZ1hwest/yAQ4e6fOQ+mzadJ3Jcb5R0u4+P1onzwedgYpVNj/z
	5uyvQhL8ErbUj4yA8IkmewvQyxcA8Xg3/LbU+SYi8tNj
X-Google-Smtp-Source: AGHT+IGO6lVuufssgJxlHErLx8cNfkoXVgmPyzhZzoNhZHiM1fyrnI3WgBFl895DPfO4iwj+fOtLradnhm1C0E/x8Q0=
X-Received: by 2002:a05:6871:e710:b0:1fa:3480:bf2c with SMTP id
 qa16-20020a056871e71000b001fa3480bf2cmr13343158oac.0.1701184635409; Tue, 28
 Nov 2023 07:17:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025192225.468228-1-lukasz.luba@arm.com> <CAJZ5v0gniBtFduwjhDku+OZzjvkCaFK7ew0uJTfW254XKTOyyw@mail.gmail.com>
 <ce8f1a13-b56f-4419-a954-8d987af44112@arm.com> <5fd9ce52-9216-47ae-9ed3-fabb0f3b02fd@arm.com>
 <CAJZ5v0jL38PgFYVXFj2Py5NvUU0xFGU45w=TdcBXqr7v+xToag@mail.gmail.com> <49344fb7-78c0-4fc8-9687-22d039b5318f@arm.com>
In-Reply-To: <49344fb7-78c0-4fc8-9687-22d039b5318f@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 Nov 2023 16:17:04 +0100
Message-ID: <CAJZ5v0iq7sbNdxfVd1HAKKHpqHWSzcHE3EH9hK3s65OLDQFeEQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Minor cleanup for thermal gov power allocator
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 8:44=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 11/23/23 19:50, Rafael J. Wysocki wrote:
> > Hi Lukasz,
> >
> > On Thu, Nov 23, 2023 at 4:19=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.co=
m> wrote:
> >>
> >> Hi Rafael,
> >>
> >> Gentle ping
> >>
> >> On 10/26/23 13:22, Lukasz Luba wrote:
> >>>
> >>>
> >>> On 10/26/23 09:54, Rafael J. Wysocki wrote:
> >>>> On Wed, Oct 25, 2023 at 9:21=E2=80=AFPM Lukasz Luba <lukasz.luba@arm=
.com> wrote:
> >>>>>
> >>>>> Hi all,
> >>>>>
> >>>>> The patch set does some small clean up for Intelligent Power Alloca=
tor.
> >>>>> Those changes are not expected to alter the general functionality.
> >>>>> They just
> >>>>> improve the code reading. Only patch 3/7 might improve the use case=
 for
> >>>>> binding the governor to thermal zone (very unlikely in real product=
s,
> >>>>> but
> >>>>> it's needed for correctness).
> >>>>>
> >>>>> The changes are based on top of current PM thermal branch, so with =
the
> >>>>> new trip points.
> >>>>>
> >>>>> Regards,
> >>>>> Lukasz
> >>>>>
> >>>>> Lukasz Luba (7):
> >>>>>     thermal: gov_power_allocator: Rename trip_max_desired_temperatu=
re
> >>>>>     thermal: gov_power_allocator: Setup trip points earlier
> >>>>>     thermal: gov_power_allocator: Check the cooling devices only fo=
r
> >>>>>       trip_max
> >>>>>     thermal: gov_power_allocator: Rearrange the order of variables
> >>>>>     thermal: gov_power_allocator: Use shorter variable when possibl=
e
> >>>>>     thermal: gov_power_allocator: Remove unneeded local variables
> >>>>>     thermal: gov_power_allocator: Clean needed variables at the beg=
inning
> >>>>>
> >>>>>    drivers/thermal/gov_power_allocator.c | 123 ++++++++++++++------=
------
> >>>>>    1 file changed, 64 insertions(+), 59 deletions(-)
> >>>>>
> >>>>> --
> >>>>
> >>>> The series looks good to me overall, but I'd prefer to make these
> >>>> changes in the 6.8 cycle, because the 6.7 merge window is around the
> >>>> corner and there is quite a bit of thermal material in this cycle
> >>>> already.
> >>>
> >>> Thanks for having a look! Yes, I agree, we can wait after the
> >>> merge window. It just have to be cleaned one day a bit and I postpone=
d
> >>> this a few times, so no rush ;)
> >>
> >> I've seen you've created the new pm/thermal. Could you consider to tak=
e
> >> those in, please?
> >
> > Sure, I'll get to them presumably tomorrow and if not then early next w=
eek.
>
> OK, thank you Rafael!

I've queued up the whole lot for 6.8 and in the process I've edited
all of the changelogs and some subjects for clarity and English
grammar improvements.

Thanks!

