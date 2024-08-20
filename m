Return-Path: <linux-pm+bounces-12545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38027958176
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 10:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7AFF2828BD
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC1018C024;
	Tue, 20 Aug 2024 08:55:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A9818C008;
	Tue, 20 Aug 2024 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724144150; cv=none; b=DV+rEf+9Z/H2veGjcXwQkpOh6XEP5Nbn8llp995bsOBOeCM5r2WvrNkXMG5ozCxhl1UsaF9d2C0atkI/0zeoZHpdJ5WSeV1b2wYeCcdwx3izR0hK+MdPQz3hH1wdNP1jWNCIGPubw97iPirw/Tn0rxhRIzURAGr7kq36AAui70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724144150; c=relaxed/simple;
	bh=gDH1pqLw3GiMaUrtMiCBK1HOFWaAfQXDmmSKhPrz08M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNqZxPI8UnMnV3d3Du/rCKhhzYx2NzfwBn6hMhoWjZX9N8tlbBVee4FtZ3QDPFFN+m3p+7pvhG11JQhwurJNhlo4zc1UYSNPYfUcgaxUnXuveVnu2mcApTC7A639xiVb/jG0+AyIaVjLUOOMzpinojIpveteDXjulnvtqCcv5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e162df8bab4so1885736276.0;
        Tue, 20 Aug 2024 01:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724144146; x=1724748946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=739gK9PCxp/9rrLNn1FcjCtYFSGZ1gQJc34AHkkD9ls=;
        b=kYCRPPGAX2A6p/MfZgs0UgXBXXCLoDBVk/KUOxLj1fZtxUH3Jv84GfllYulhyqhZOO
         twiYMMgovGhbbg6HiPWl/4sO1RmS0te+TSZMOiFqEyL2BirvQ1rLzrm5Hbb27uV1j6+F
         6DwyALQLh68nQk77ZhuuYuYr/WiSaTG9hCP/xLh1DMr0qjku6rTV0Ewm+QWgS+JZ5j4v
         fWXglREYDntBkAtWuLPS/8gxYG3E9jSRC5yRu+rZzhupQkqNVHMNPuHQGQ7cc0l3nI0B
         TWobHxR0qu/2FjZ+v/JL5Zkfw0fkNuxJvMadpAWDAreKsCOXLQKd47pgWkS8anLo+Sy6
         dzug==
X-Forwarded-Encrypted: i=1; AJvYcCUQ4BPOjS9wxmFq3pyfQxTBaU53/DU9nwZYmUEOf3FmbnjFLlR+BK8oOVIR6Gm9JX+TPlDfT58iedozpfl5nyCBlOmwc0RhSbgYujQBUzcl4tfrZNFCnwLSUUdhUU5vQYmqXgbJIOuxKKYfoAwc/NQsh+Pafxt1Mk6xjQG4lmf6m34vnLTTiA==
X-Gm-Message-State: AOJu0YzA7g8Wo6fuHhIGNSaoYE0BLbpHOViz3dxU1QVmJKd/X0RoSS5Y
	G/ro/5X8CghDQGmvAtTRCo/Y1lScfuM+Sg+xfZDq5Q3kHZMcm3scblJ2coeFIP0=
X-Google-Smtp-Source: AGHT+IG3CgtVSGrEail5jDUg0CfL0JwM8NoZfrcbLjj+KFe8j/+TzcmOXnaPcyVc3BZKGujRyTUzXA==
X-Received: by 2002:a05:6902:158b:b0:e03:5bca:aee6 with SMTP id 3f1490d57ef6-e1180fa9f2cmr14871442276.54.1724144145816;
        Tue, 20 Aug 2024 01:55:45 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e117203314csm2510071276.57.2024.08.20.01.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 01:55:45 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6b59a67ba12so25506727b3.1;
        Tue, 20 Aug 2024 01:55:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGxCHqMTqyH6md07IE1iMSgraVGJeFsoCfxNIkpl8ZZCndNqGLOAU6ncrrD5DdPk/3PXpe0rfkfhLMEy5TQi8C+wkEa6tm+ddFKvtTylW7yDjJYlr4t9WEnbx0mNOPrTRm6Dr8dOm5RLQ/PZ4y/1THc398h11qRBMz8gI2Lek1783b+BLKSg==
X-Received: by 2002:a05:690c:6ac3:b0:6ac:ce34:9726 with SMTP id
 00721157ae682-6b1b8ce89demr171065287b3.18.1724144145160; Tue, 20 Aug 2024
 01:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527142557.321610-1-ulf.hansson@linaro.org> <20240527142557.321610-4-ulf.hansson@linaro.org>
In-Reply-To: <20240527142557.321610-4-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Aug 2024 10:55:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUoZBJewA6nQZLhnbebZuoZo85UCCfwuOv8or_N_e-0qg@mail.gmail.com>
Message-ID: <CAMuHMdUoZBJewA6nQZLhnbebZuoZo85UCCfwuOv8or_N_e-0qg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] pmdomain: core: Use dev_name() instead of
 kobject_get_path() in debugfs
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-rt-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Mon, May 27, 2024 at 4:27=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> Using kobject_get_path() means a dynamic memory allocation gets done, whi=
ch
> doesn't work on a PREEMPT_RT based configuration while holding genpd's ra=
w
> spinlock.
>
> To fix the problem, let's convert into using the simpler dev_name(). This
> means the information about the path doesn't get presented in debugfs, bu=
t
> hopefully this shouldn't be an issue.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> Changes in v2:
>         - New patch.

Thanks for your patch, which is now commit 9094e53ff5c86ebe ("pmdomain:
core: Use dev_name() instead of kobject_get_path() in debugfs")
in pmdomain/next.

> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -3215,16 +3214,9 @@ static int genpd_summary_one(struct seq_file *s,
>         }
>
>         list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
> -               kobj_path =3D kobject_get_path(&pm_data->dev->kobj,
> -                               genpd_is_irq_safe(genpd) ?
> -                               GFP_ATOMIC : GFP_KERNEL);
> -               if (kobj_path =3D=3D NULL)
> -                       continue;
> -
> -               seq_printf(s, "\n    %-50s  ", kobj_path);
> +               seq_printf(s, "\n    %-50s  ", dev_name(pm_data->dev));

While some of the old names didn't even fit in 50 characters, the new
names need much less space, so perhaps this is a good opportunity to
decrease the table width?

>                 rtpm_status_str(s, pm_data->dev);
>                 perf_status_str(s, pm_data->dev);
> -               kfree(kobj_path);
>         }
>
>         seq_puts(s, "\n");

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

