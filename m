Return-Path: <linux-pm+bounces-521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8477FE136
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 21:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C391C20B6C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 20:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8456360EE0;
	Wed, 29 Nov 2023 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD87510C4
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 12:37:18 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1fa8dc2a0bfso74965fac.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 12:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701290238; x=1701895038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kaPFnXz3uFkFS2yqfCBrP9sAdT75G7reJ0wVRLh8o4=;
        b=c+FNpqQIK6+Z4HHJXWskom3MvPevzqbF8z5PgRO23pGwECd37AmpbPuQE0U5NpPHow
         4EHwIq/XG27qTmAx4+yUUjUvTnmY3Sju8ewUegodw89atlr3vB1ryYASJ7CmYCxoBYiv
         54ZHi9RqcWSgD/YuYMZAMGObfOowA4R3DlNCf2cOOz6TrHd+NUSAuzK+7WFa8vYhAQDw
         rSmEgPRkDRML0g5nTFmkjWZYVgSJJVCO+62ntGDL2prZGHxgfVDSGXG6WIaGhxYgg8L/
         69NseYZkpOPzDP0Cmjcg7+aCixOWIQ5rIwVdrmc2GcMtA6n7HhIzIy08bBffRwnLGze2
         maOg==
X-Gm-Message-State: AOJu0YzQLFBGRofpRNeCD/FCCXGEijQJ9B4TMrj5gmtt+lGqW2mxewUw
	HoD022hTfYl6WLfgMZgdPpvisl0cuZyw1UGNviA=
X-Google-Smtp-Source: AGHT+IHJu52+c/dBsujezQ65Eh5pxZwHmsd7iJdLdzFdcDV4vovnuKXgnzZVDn6Z6SDdTwC7CdmKD4AeuAAoE/e/fvg=
X-Received: by 2002:a05:6871:5810:b0:1fa:3b96:efda with SMTP id
 oj16-20020a056871581000b001fa3b96efdamr15326176oac.2.1701290238082; Wed, 29
 Nov 2023 12:37:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00d201d96670$e15ab9d0$a4102d70$@telus.net> <CAJvTdKmv-6rp=z=emS1VGdWgTmRfhSUrmUPLk8Hj+5=CvH0+nw@mail.gmail.com>
 <CAJvTdKmG2JkJBy4UNc101JZUHzUaC=a=U9Xwg9MgQs7wcDvYrA@mail.gmail.com> <001b01da22dc$e0f764b0$a2e62e10$@telus.net>
In-Reply-To: <001b01da22dc$e0f764b0$a2e62e10$@telus.net>
From: Len Brown <lenb@kernel.org>
Date: Wed, 29 Nov 2023 15:37:05 -0500
Message-ID: <CAJvTdK=Bvkw+ro_quJ3y=+GAf1MHv5AiBu2kAY+V3Wn259maAg@mail.gmail.com>
Subject: Re: [PATCH] tools/power/x86/turbostat: Fix added raw MSR output
To: Doug Smythies <dsmythies@telus.net>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 10:58=E2=80=AFAM Doug Smythies <dsmythies@telus.net=
> wrote:

> > "turbostat --cpu cpu-set" can accept "package" as the cpu-set.  This
> > will print out one row per package, and will give you the information
> > that you really want -- even on a multi-package system.  However, it
> > isn't as pretty as the system summary that you printed, because it
> > pre-prints the headers (and the system summary) every interval.
> >
> > It may make more sense to tweak (or simply filter) the output of
> > "--cpu package" to produce the output you are looking for....
>
> Thanks for that.
> Yes, the format of the information isn't pretty but it is probably
> good enough. I use --add MSRs rarely.

The format for "--cpu package" comes with a caveat too.
The system summary is generated from the info from all the CPUs
sampled, eg. sum or average, depending on the metric.

But the per-package row is *not* a combination of all the CPUs in the
package, it is the values for just the CPU that has been anointed as
1st in that package.

This is fine for your per-package MSR output, but the other metrics,
say %Busy, may be quite different on that first CPU in the package vs
the average of the whole package.

For this reason, an accurate picture really does need the system
summary and the "first CPU in package" per-package row.

Fundamentally, we can't put both per-system and per-CPU info onto the
same row except under limited conditions.
Your example of a package-scope raw MSR on a single package system
seems to be such a valid condition.

Maybe in your 3rd hunk simply add...
if (topo.num_packages =3D=3D 1)

thanks,
Len Brown, Intel

