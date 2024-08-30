Return-Path: <linux-pm+bounces-13251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903BF966613
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 17:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3388D281E2D
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155C71B1D7C;
	Fri, 30 Aug 2024 15:50:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFB5EEC3;
	Fri, 30 Aug 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033055; cv=none; b=nFfAuKUyajVQ0YLX0QuyV+zb+PbAewrghTdLeOHyj5j48S2Qn9qBmtQHtdZBoc4bYWNxROMKs0IU0CEJz9HpJUQz7qqrYbV0MudHkBK6QgS9+wIioBBaP1HEjupSBhwk+6r9tlosmjLeKlp3wRSNg/0Esy9lJMPG0dAiQZOImqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033055; c=relaxed/simple;
	bh=pR1h+Ynwrb+FY5Cr0unLWbeM38nnOcTAB2TbBnhRC7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cW76fqOAMTPbStfean5cY1WrBtvGxuW45uwLRhdFyxkUYVu4Ja0aPLJElxUfHZp/eFu/2Y7BROBuhcy6IVgCiHXWGOFeP3iSmeZpfmUb8HeKt62KPT1i65XSbLSxmNCa9R4nxC5Y/bji+mrk09RP3KNwI68KKpN6c4L6GxGiB1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1651f48c31so2125608276.0;
        Fri, 30 Aug 2024 08:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725033051; x=1725637851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9rRrd8by4zG0DRHaV4H43h1ldObXNHsdDSkPr6H2YA=;
        b=ESn5HrzEWcJUDCox0b4qWxQswZoF15G5dxsmvdw+QISABJOqRSAAknLB+AvzEqlBKY
         6c8VXXuBJlDRd4YIplYAF9s9Q9oFJ6dl+Yqs/03WSAMzR7yqZ42mU+f24apyYdsYfatQ
         DbgOGL1XJN5yTipdxHt4gbboyLMTVe7NIfH/xEgDw6hvBZMh53P+CKm6Psf0gjXDggVS
         0wqofHB59/0nXZSJYv0U5Hnyn67sVIqb5rzXzKf+1qTB8mxU0SYhpsMVCRFrCBiJw+ba
         41FIXhSsGT+FsOtK/8macqDtaiDtpeKFTquV+ox4L7rCoaYe244eKp0SN6SLzezVj2c5
         k+1g==
X-Forwarded-Encrypted: i=1; AJvYcCU3Ib5eStm8+FtAG+lpXHVULtCyYG4Z8Fi9tHbHEOg1yW6DtzBa9R51N9qXI8ZPNkyum9x6Ro7YSdK0LlI=@vger.kernel.org, AJvYcCVEpYLEHCrU7OxgAjF1GMArDF2fFURcqOWR+89C86S7my6Uph1II2XZl0EXMxsRumcqt/K6vBTHb7c=@vger.kernel.org, AJvYcCVbBr9JkfUYTimWY4dsZ3VneezVN+KYdU1O4e1D2OifdiwH/EoQSy39Wf1Y61+97eJcMqOpQk3ibBMtDXHW7K8=@vger.kernel.org, AJvYcCWcaDhFBlKmtMt4TuK+xbNbEHFVi+9FFah5nRV6ixzSXxJ6Aqd+NSdo1iCW7adJWXMENHi1tGQVFEPH9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxHbw5Kizd9xp4yZdjJB3w1rWVLdvhHyzyIqwZw+OPwybtP3uo
	6MGCpSPPjp51V35zsGdnwEH5cZTMnmp8Ujc9dzxfx0zEuxXYim2ayHY3Sz4m
X-Google-Smtp-Source: AGHT+IEnxjbb625z35jyuOSWamT1+BtdB5PhaZWPpvsFbBwq1T+CkcZ71k711hjYpmUhmlcbs6Dxig==
X-Received: by 2002:a05:6902:200e:b0:e11:44b9:6bb7 with SMTP id 3f1490d57ef6-e1a7a02da19mr3059439276.24.1725033051571;
        Fri, 30 Aug 2024 08:50:51 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1a6266e430sm649103276.15.2024.08.30.08.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 08:50:51 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6b4412fac76so17361807b3.1;
        Fri, 30 Aug 2024 08:50:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGcnsBBNH64Z0GA1St1YkOfIbiVZTh4VgcQTM+btaeOft/HtxuM2RQeGXh4K59auRS3ENPjodt7HkIPA==@vger.kernel.org, AJvYcCVwhjMRSev5t3F6DJ0XWdcdghI6QDyAMnMlEZlWaFsCRsLXhjwg51MRBSZAvqz+U5w2paxUqlgLSM2adOc=@vger.kernel.org, AJvYcCX4iQYwjiQR+GYOtC/vVcD9uxKexMwgdbDRAJsrDOgjVUi+trbDBy1VezbqM+kb5WZIuKWFbFwl0MWMFRGDG/s=@vger.kernel.org, AJvYcCXUm/WFFIdv27iaO9lhGDnW/AzvkecGJqLNBDhehbc66Ok0MtniRtJrN5LwyRNshjEly++A/lisyBY=@vger.kernel.org
X-Received: by 2002:a05:690c:4e0c:b0:672:8ad4:9461 with SMTP id
 00721157ae682-6d41000902bmr23176987b3.41.1725033050177; Fri, 30 Aug 2024
 08:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
 <20240527142557.321610-4-ulf.hansson@linaro.org> <CAMuHMdUoZBJewA6nQZLhnbebZuoZo85UCCfwuOv8or_N_e-0qg@mail.gmail.com>
 <CAPDyKFqcpxUJWL7FoRSXLXVhS5B9PjcTY5ryG8HAY_E1Btgwag@mail.gmail.com>
In-Reply-To: <CAPDyKFqcpxUJWL7FoRSXLXVhS5B9PjcTY5ryG8HAY_E1Btgwag@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Aug 2024 17:50:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWB2zjF1jajkQzFpt2=4oj25myG1CJ5i6450gkUVX19+g@mail.gmail.com>
Message-ID: <CAMuHMdWB2zjF1jajkQzFpt2=4oj25myG1CJ5i6450gkUVX19+g@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] pmdomain: core: Use dev_name() instead of
 kobject_get_path() in debugfs
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-rt-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Tue, Aug 20, 2024 at 10:58=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> On Tue, 20 Aug 2024 at 10:55, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> > On Mon, May 27, 2024 at 4:27=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > > Using kobject_get_path() means a dynamic memory allocation gets done,=
 which
> > > doesn't work on a PREEMPT_RT based configuration while holding genpd'=
s raw
> > > spinlock.
> > >
> > > To fix the problem, let's convert into using the simpler dev_name(). =
This
> > > means the information about the path doesn't get presented in debugfs=
, but
> > > hopefully this shouldn't be an issue.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > > Changes in v2:
> > >         - New patch.
> >
> > Thanks for your patch, which is now commit 9094e53ff5c86ebe ("pmdomain:
> > core: Use dev_name() instead of kobject_get_path() in debugfs")
> > in pmdomain/next.
> >
> > > --- a/drivers/pmdomain/core.c
> > > +++ b/drivers/pmdomain/core.c
> > > @@ -3215,16 +3214,9 @@ static int genpd_summary_one(struct seq_file *=
s,
> > >         }
> > >
> > >         list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
> > > -               kobj_path =3D kobject_get_path(&pm_data->dev->kobj,
> > > -                               genpd_is_irq_safe(genpd) ?
> > > -                               GFP_ATOMIC : GFP_KERNEL);
> > > -               if (kobj_path =3D=3D NULL)
> > > -                       continue;
> > > -
> > > -               seq_printf(s, "\n    %-50s  ", kobj_path);
> > > +               seq_printf(s, "\n    %-50s  ", dev_name(pm_data->dev)=
);
> >
> > While some of the old names didn't even fit in 50 characters, the new
> > names need much less space, so perhaps this is a good opportunity to
> > decrease the table width?
>
> Sure, it seems reasonable! Do you want to send a patch?

I started looking into it.  Then I noticed that on some systems
(e.g. TI am335x) the device names may have a longer format than
the typical <unit-address>.<nodename>. So I wanted to verify on
BeagleBone Black, but recent kernels crash during early boot.
Apparently that platform was broken between v6.8 and v6.9-rc1.
And during bisection, I encountered 3 different failure modes...

To be continued...

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

