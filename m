Return-Path: <linux-pm+bounces-18918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B759EB347
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 15:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A60028183C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3267A1B4256;
	Tue, 10 Dec 2024 14:28:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB9E1B2195;
	Tue, 10 Dec 2024 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840937; cv=none; b=VZDvBvoLk6A5Cm/SfIJ2O53/88S/AfiIhks+x8xC2k4cF64hK0weE8s7s0ZQPAoZfYJEMUEkNGVagBOmjdtjyODbvL1WDwikapi+KATjZ+9iMghQnIguQ2W5VkcKRVQY24y3ofn3zK+fdmwPBrDZzyK3ALWKVSKWtmT5wAfuF60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840937; c=relaxed/simple;
	bh=DO/NC3Lt0wMt+JWwd2lxWrUtTInAw+KOPEue7pgClmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LH+TJw+RV74SzQk+i5fyufnBy8tthm7DALqU3qDpC9Jky9+BgObi9UURYxSCuWFH04KSkKk7criYCZrrDc/FytF9XcGbEkaPClrWFd94X/UM+E2JQuCYLjfQDvRKehkgZz6jNaY+C9Zl6QPpnavu86eRdYU7wQ+0zPGN1YiShaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5188311e61cso565591e0c.2;
        Tue, 10 Dec 2024 06:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733840933; x=1734445733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1UGUtE3JZONvX3ZU1usLPTPg2Sj35dvZCSUIlPuCyM=;
        b=PTodSrmqQbW4KShgQbfVuTBl6TetxYNcqtvC6xTAcxSxPEX/HrQ1dld83YIyf35qrq
         UcsyMKqKZkmJfmFKAnNmnfP2C0NPH2jszK0FPe6cw2jVRd2eyjjiMDd5SwPRFRp/n9e1
         4BjCgDhH8SP5F02hu4AchHyn7bVULO3t7TVShwHkunvjGGMVKLDzQeDq4ZQx4BtPyRlg
         XlC6lXB0Vh1jfn3tKmFlduaQsebOcYoB7VV4yCm2n7+DLnipc7Zs/ClDPVMk9VvVQRUO
         /qz6FN9Bu1fjnq8kKosQzXtFFwc+1k2QkEeuyOI4z3U5PYfIuT0N35l5t5MVr643GhX7
         Tckw==
X-Forwarded-Encrypted: i=1; AJvYcCUr2HgLcRhpVFTI4f0P9i0VggLWIyyWznFYOps1sIBIKG5zom0IXJ7RyH52Spgjuqu/+0TWVgiqxTu/@vger.kernel.org, AJvYcCUrB9e95jcgRCHd7m5MkW2eHkB5N8kJhdJVd6OAPHVoXUypMwpFrEhK731TSvbZzUdaw4KJPGP28TFH5kfBQukTO9c=@vger.kernel.org, AJvYcCXb0VSrlH/x5K6LmJsfLPsLYCs9rFADqOO1VMt2xDRn1tm2mKzWOB2mBbo94Nhq8GrnoYilit0BOU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPWPH97615+K3cP4G1RAD/1qilzsQyQez6x2sEAwXsiYP0mpyB
	mRQ6SY6w3Xb95o7WQLeM975n3GC3lF/EPg+snwgFv+dVKhss57U9NOZ7amn+
X-Gm-Gg: ASbGncsRFFQl3MjAvf6wbpvQasH6Av7akTs7POmQXdrLhwrIlFbVtAbFqCfeC6C56L2
	CQAMVFKKjmSf+arzokfgQBVwnlnA3BmIhmckuJOB1pj+d9bA6LSOdOY0+nYLqBc8M9caugee5xU
	OlHkMbaBApV/S4xGsNhstpx5lNQ8WC1tw1gwSCMffFkAVgZ0P0w0OxPMIbg1j4Nm7tuw/rX/SMr
	fdxVKpvDYW9Y+nwAq1dNWShPhta463S0uqheJ0j+gK+WQl5dsE2Fs8Vd957KmCw7aYP/oWU2c07
	td7fcFHQQTEUZjVO
X-Google-Smtp-Source: AGHT+IGm/dnMEmM9P9bHqg9v9ulCXXADNNPznSrswFJ/S0qcG1+tABYxZGZTXzXHy3iKVZDFTTc1yQ==
X-Received: by 2002:a05:6122:4d0c:b0:518:9582:db90 with SMTP id 71dfb90a1353d-5189582e36fmr1259398e0c.11.1733840933192;
        Tue, 10 Dec 2024 06:28:53 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-515eaf5a6c0sm983358e0c.45.2024.12.10.06.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 06:28:53 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-85c4e74e2baso1078714241.0;
        Tue, 10 Dec 2024 06:28:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7u4i3N7oJPwjI9k0iUFBxR2O2yFR2BeSu+fjeQQiVudZdI6Qm+O/E9bYIWnXOJMfpCgRZr3mSV3A=@vger.kernel.org, AJvYcCVrs5+C8T/vuUHG/r6pbTXomflg1SoL3fhM4zTZmMwEqJk/eEbzEk5z398/pRqVhKsGlmR0WbKfLTxK@vger.kernel.org, AJvYcCWPVCG8hcccSYM3/1qLmfohj/GBaA8eZM/FrIaxadTPjss9b/uCoK4ga6Zl3uiWYWgejVVuOC5boTeZdhJXdzvgyPU=@vger.kernel.org
X-Received: by 2002:a05:6102:3049:b0:4af:f740:c1b4 with SMTP id
 ada2fe7eead31-4aff740ca07mr7756339137.5.1733840932791; Tue, 10 Dec 2024
 06:28:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728377971.git.geert+renesas@glider.be> <CAMuHMdXsmAqQL+2+D_y+u1z4nn8JO+xF-mq6wWJ0pAH58n5Wiw@mail.gmail.com>
 <b273599f-8653-4e98-ac64-09c91b0a1592@arm.com> <CAMuHMdUYnTRDHRdWYHBdJ3hNBKOXBtRMOsu1NiJFET7P-+zc4g@mail.gmail.com>
 <96d1f356-b36b-4c14-bdd5-c38836bac418@arm.com> <CAMuHMdW25MC-RoCw72_EJ22e4Ae36N1CM8a-r=r7e=kA2-AgHA@mail.gmail.com>
 <CAMuHMdUoEA0W_1jmUPZ48Zi7N1wbo435-LvAf35O=EvYvO6KDQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUoEA0W_1jmUPZ48Zi7N1wbo435-LvAf35O=EvYvO6KDQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Dec 2024 15:28:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXUhqdSCvsDbqu0To8psuBuWpnZtqy+PRTcVqdFeQ2rYQ@mail.gmail.com>
Message-ID: <CAMuHMdXUhqdSCvsDbqu0To8psuBuWpnZtqy+PRTcVqdFeQ2rYQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] arm64: dts: renesas: Re-add voltages to OPP tables
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Wed, Nov 13, 2024 at 5:58=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Mon, Nov 4, 2024 at 4:15=E2=80=AFPM Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:
> > On Mon, Oct 28, 2024 at 2:41=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.co=
m> wrote:
> > > On 10/28/24 11:34, Geert Uytterhoeven wrote:
> > > > On Fri, Oct 25, 2024 at 5:40=E2=80=AFPM Lukasz Luba <lukasz.luba@ar=
m.com> wrote:
> > > >> On 10/22/24 14:36, Geert Uytterhoeven wrote:
> > > >>> On Tue, Oct 8, 2024 at 11:14=E2=80=AFAM Geert Uytterhoeven
> > > >>> <geert+renesas@glider.be> wrote:
> > > >>>> When CONFIG_ENERGY_MODEL=3Dy, an error is printed on RZ/G2E and =
R-Car E3:
> > > >>>>
> > > >>>>       cpu cpu0: EM: invalid perf. state: -22
> > > >>>>
> > > >>>> This happens because the Operating Points Parameters tables do n=
ot list
> > > >>>> voltages, as they are all identical.  Previously, it was assumed=
 they
> > > >>>> were optional, and unused, when none of the CPU nodes is tied to=
 a
> > > >>>> regulator using the "cpu-supply" property.  This assumption turn=
ed out
> > > >>>> to be incorrect, causing the reported error message.
> > > >>>>
> > > >>>> This RFC patch series fixes this by adding the missing voltages.
> > > >>>>
> > > >>>> Note that the Energy Model calculates energy efficiency by divid=
ing the
> > > >>>> (estimated) CPU power consumption by CPU core clock frequency.  =
When all
> > > >>>> voltages have the same value, the former is proportional to cloc=
k
> > > >>>> frequency, and energy efficiency becomes a constant.  Hence all
> > > >>>> operating points are considered to have the same efficiency, and=
 the
> > > >>>> Energy Model always picks the one with the highest clock rate (s=
ee also
> > > >>>> [1]).
> > > >>>>
> > > >>>> Alternatively, the Energy Model could be changed to silently ign=
ore OPP
> > > >>>> tables with missing frequencies.  IMHO this is not an unusual ca=
se.
> > > >>>>
> > > >>>> Which approach should be taken?
> > > >>>> Thanks for your comments!
> > > >>>
> > > >>> Any comments from the Energy Model and PM people?
> > > >>
> > > >> My apologies for delay.
> > > >>
> > > >> So you had issue with bogus Voltage values and removed them.
> > > >>
> > > >> There is another way to setup EM properly, via DT:
> > > >> "opp-microwatt" [1].
> > > >>
> > > >> That micro watt value won't confuse other subsystems, like
> > > >> your regulator fwk. It will only be used by the EM fwk.
> > > >>
> > > >> This would be an alternative to your voltage values.
> > > >> Sounds better to you?
> > > >
> > > > For opp-microwatt, I do need to know the actual power consumption
> > > > of the core, right?
> > >
> > > Correct. You can try to derived that in a way you did and put below.
> > > Although, Dhrystone is a synthetic micro-benchmark with small
> > > impact to data caches, so it will not use much power.
> >
> > Do you have a suggestion for a better load test? stress-ng?
> >
> > > > Full system power consumption while running the in-kernel
> > > > Dhrystones benchmark:
> > > >
> > > > 800 MHz: avg 4972,55 mW, stdef 20,474 mW
> > > > 1000 MHz: avg 5025,93 mW, stdef 18,644 mW
> > > > 1200 MHz: avg 5059,63 mW, stdef 15,425 mW
> > >
> > > Right. From those power values can be try to derive the
> > > 'CPU only power' values - assuming only one core was
> > > running the test.
> > >
> > > AFAIU you don't have proper DVFS due to missing voltage scaling.
> >
> > Indeed.
> >
> > > Therefore...
> > > Out of that I got these CPU power values:
> > > 800MHz -> 174mW
> >
> > =3D> 217.5 =C2=B5W/MHz
> >
> > > 1000MHz -> 212mW
> >
> > =3D> 212 =C2=B5W/MHz
> >
> > > 1200MHz -> 261mW
>
> BTW, how did you get from my avg mW values above to your CPU power mW
> values? I seem to be missing something...

Ping...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

