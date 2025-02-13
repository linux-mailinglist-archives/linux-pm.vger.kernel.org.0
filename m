Return-Path: <linux-pm+bounces-22004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBF7A33CB6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 11:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586E57A1E07
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 10:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675A72135AD;
	Thu, 13 Feb 2025 10:27:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C711212FA8;
	Thu, 13 Feb 2025 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442428; cv=none; b=QEz6A4DSL/IZX+ExxLi/lY0aB05yS9HbkIMALc5JJ918TfAHT3AAuWHueiXJbucJXePBNYU0yqYmrrDghJlww8+9fgr3TjnzYN9xBqa0TuUzgLVHqfS3AYTT54cE2UJ211lZZ8OgdvALh/tGW+Hg9jO5UYVBwrpDA195WEOeIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442428; c=relaxed/simple;
	bh=nXgtec5yfvXrRWWYRsZ4bDFNattFo59xnRbwG8aLwJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLl9GVycJbyyaXXRN6rBWbfUei2/onY4eR6mWyKPuA9c3rRUGGfQqPHn7ajMobMY5ntRdWHPr2/YeWDPsgnGHxzrrFWAjPBuTdCKJjHQI24K4+YDph5p+4reAHTUKmSzXP6vbXPvBkvscVUknoZFp8h481Tw+Q2nHCKDOkt3hCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86718541914so978000241.1;
        Thu, 13 Feb 2025 02:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739442424; x=1740047224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4BQvSjdPvwvlHZOZKVU4dEkUHYrrJIZUOAsZTtgVLc=;
        b=VGlkPrPViZuvkTt2ZlXb/Tzsqh6Ssqu0CJCG4FFPE3lqUyNrsLTQZJvNh7v4oXtehp
         krWbjIaqvXzvIPRXWtSdwD2rMJnK27D2IMUUabzt6RHW478CPZHGt8hPx/4F9VTvXtnq
         MEa0FFYeE8Lr0v3tXk5Jk0v6dZXcn3yivh++2GziJKT6Bk5WIWPkqjEYszoiBGb99RVA
         wEt/nPQFn/O3B+i8JzjasYGiPHtA4Vcrxzq3Vmu/YN09Td1D8iPm4vitiiaSNNK8uy7x
         3qAABfFgsAkQ5g5wy3SZMKSs7wWCW/mQyxyuWimSY0S/VKKSnpnt1bgZfFyLDNNFtxTH
         q+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJHkvNa9xjaHlK9zpOoFBRqO/VXeBXOUIAJs0O63plNZ/H8rEDD+AdvcFU9RTLSsQsjKVRFuK1kw==@vger.kernel.org, AJvYcCVZBzw1rK/eESbQbNU3lVPaqkG/s4tW5RXUBBL4WVyunzmDbZ1j5CkSe8F24+KS/9Vu3joumIcGb+JnMUserI13u7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YythjcXtHVcI4GBabjXbs98MR8dYwzVKBvWQQ++OQZ1ZRnkYMcY
	U0zgtf2JL1drhenliIj1ZgrPJ34VkeWNT2uTYM79zrzLXZfr8zO+AyQ89kXIgmE=
X-Gm-Gg: ASbGncs5g9S1zRhMZGR1mMiu2ELXsXix4UNwTxsuPuGUW2CsbNCoL2sjT/m/0o/Fsn7
	nAAq3whPf9pyEatulzhgRharArG3xg42pLONXoOQ4XvZU0gbDUcxzfJ1xwLT67RhhRMy8cn/38P
	f0VekGJcjG4VA9A/OtyhfDlHe2/1Hs5R/j8ih56EYgJ3v7Jtc7TyB194qjQB+3aOuku6GfFuekr
	ZeQsbN3jRofl3z81Pi3SszTyih46PKezuElpxV/Qie0MNfrNgaL8A2/pwRbxCE/kaoFvCYOXifA
	jvvXQvPqLGaIg2uu3pOsJAUzNo9ZgT9kbn4YamNkutaBtKeoZnjS7A==
X-Google-Smtp-Source: AGHT+IHvA3+YrUJiEWttnbxu9B6Mf3qZXcRp1ksm3t4/m4q7GIHs3Z7AjZRdanvLczZ+3ZJuTPd4aQ==
X-Received: by 2002:a05:6122:4897:b0:516:1e32:f8c7 with SMTP id 71dfb90a1353d-520786743d8mr2036544e0c.0.1739442424378;
        Thu, 13 Feb 2025 02:27:04 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e8547fd6sm144797241.3.2025.02.13.02.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 02:27:04 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4b9486a15a0so1041117137.0;
        Thu, 13 Feb 2025 02:27:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkHAG9RnbOU9AGBycB8JFubmnDYyKL/UTi/WOABnvr1cd40W6UtFfrDIHHjK1/EMHeXLDuFF+K/k8K+B0XoudeVQs=@vger.kernel.org, AJvYcCVo1ebY2wFd3rPH499XC0PMt9JBQSAvArcGItWc3sLnG3Xqsd4GVzFC3iCSY/ZR+kjk7b5+Q4xddg==@vger.kernel.org
X-Received: by 2002:a05:6102:2424:b0:4bb:b7ff:c486 with SMTP id
 ada2fe7eead31-4bc050376fbmr1353306137.12.1739442424014; Thu, 13 Feb 2025
 02:27:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdXN9A-1P_qe=BwKjLaoqxU8iJUQK6h8=s-apR4Y0em_0Q@mail.gmail.com>
 <CAMuHMdXXWH0Do5zXWJ1Uc6dyEb9o1chGSyeyzgDrX+v1wZ7e_A@mail.gmail.com> <CAGETcx_wA9RB9QhMPqsLHDFZ4cwOFgE8dBL9ssFkT=J6DEgjGg@mail.gmail.com>
In-Reply-To: <CAGETcx_wA9RB9QhMPqsLHDFZ4cwOFgE8dBL9ssFkT=J6DEgjGg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Feb 2025 11:26:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUCXJkg3rkngXf7cqa50u-TEAOntV6O=Nvg33Q9diPJPw@mail.gmail.com>
X-Gm-Features: AWEUYZmKRqIGNWtC5Wby5dZMR568x7wkurDrEaa0GNlacN_xsgZ6oH6hx-u5EoQ
Message-ID: <CAMuHMdUCXJkg3rkngXf7cqa50u-TEAOntV6O=Nvg33Q9diPJPw@mail.gmail.com>
Subject: Re: s2idle blocked on dev->power.completion
To: Saravana Kannan <saravanak@google.com>
Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
	Linux PM list <linux-pm@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

On Thu, 13 Feb 2025 at 09:31, Saravana Kannan <saravanak@google.com> wrote:
> On Mon, Feb 10, 2025 at 2:24=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Fri, 7 Feb 2025 at 16:08, Geert Uytterhoeven <geert@linux-m68k.org> =
wrote:
> > > Instrumenting all dev->power.completion accesses in
> > > drivers/base/power/main.c reveals that resume is blocked in dpm_wait(=
)
> > > in the call to wait_for_completion() for regulator-1p2v, which is
> > > indeed a dependency for the SN65DSI86 DSI-DP bridge.  Comparing
> >
> > [...]
> >
> > > Looking at /sys/devices/virtual/devlink, the non-working case has the
> > > following extra entries:
> >
> > Note that the SN65DSI86 DSI-DP bridge driver uses the auxiliary bus
> > to create four subdevices:
> >   - ti_sn65dsi86.aux.0,
> >   - ti_sn65dsi86.bridge.0,
> >   - ti_sn65dsi86.gpio.0,
> >   - ti_sn65dsi86.pwm.0.
> > None of them have supplier:* symlinks in sysfs, so perhaps that is
> > the root cause of the issue?
>
> Sorry, I haven't had time to look into this closely. Couple of
> questions/suggestions that might give you some answers.
>
> Is this an issue only happening for s2idle or for s2ram too? I'd guess
> both, but if not, that might tell you something?

The two (very similar) boards I could reproduce the issue on do not
support s2ram yet.

> The only reason the wait_for_completion() wouldn't work is because the
> supplier is not "completing"?

Yes, the diff shows ca. 70 additional calls to "complete_all()" in the
good case.

> There's some weird direct_complete logic
> that I haven't fully understood. You can look at that to see if some
> of the devices are skipping their resumes and hence the "completes"
> too? Also, runtime PM and some flag can cause some lazy resume or
> avoid suspending already suspended devices behavior. Check that too.

Thanks, will give it a try...

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

