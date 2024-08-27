Return-Path: <linux-pm+bounces-12956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 467D09607F9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 12:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4801C21FC5
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEDF19E837;
	Tue, 27 Aug 2024 10:56:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A6719DF41;
	Tue, 27 Aug 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756161; cv=none; b=BotMzRWZQAV/Jg59Chp5aZGzW253NG3yibIRrgELeXFOlD81EaMX8gsWLvQwXofOEAbWLOH5QpQF4NWymkcrJI3mWdbSOmrEo/tePvwCTsUDLKZw2/42I4pPQuUcAba7FV1282jSg1GrEg3IHyKT+TkOnwjDi5kHPyP65u9N93Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756161; c=relaxed/simple;
	bh=4oBV8H5bs6V7KC17pgVHrSStgbbQbPBeJsp1/aceqNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruEkyWte2thgqMZwajCIjcHmtl8Y6hW1OzI607zhQCIPISSReE8/8TBiM9aPXXMsVWbalfx/gr9QvMVrjBMea3lNmbCM7AnSwFZSJ1u4gp46k0F3oOfX1lJWuTKj4T2eqIFPBKqgUlH8AHaWp+J/RKheGOUOJZC6vMNb1SUxz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6b8d96aa4c3so45161427b3.1;
        Tue, 27 Aug 2024 03:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724756155; x=1725360955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qo2NMwoxAQ1U2hSpFIW4sKP1B7w0umymouG5LJGc8hU=;
        b=tMX1Dw9Z+zGNWhjGgBlnTjrOPMMDgNMxkP9EzaABEGB56zn7GkHHBi608bXtY0Fgjk
         lTy2ejwiwnxctC7LgOtg2Ez9ynnKIkagkTxqT53e7yyc3EC6EfxM4ogPrnp24ngpaIZD
         0Kuy0CfI4eAtlfWfRcT+cff/fpEDkPMBKpbMs6Av3mClyLL/ln31IGTLYF9eDxblPAi3
         XPk5gT8+x5p6e2S11kOi0a/Wjljw0ly2ORNSxVh2jNYFCpkrpN2XS7knuXkzFapmdt5N
         wiSw28JjTwQ7c6PudlVqoFQi/AcjHOMeMs10jJ3J24/1IiZgjKiYXaRuNQ6fuDvrIzyE
         hv5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEUYa5weDMTeSTBtJOzQJhrckP/E3G+Jhy93zh5fe/2lu5xAlHgpmS/Rhdbpl8xeHCadxF/hxmhTE=@vger.kernel.org, AJvYcCW/O4EY5BhYPz7EqTc31DfojVqrcKQzkOY7QFJNWvdsuXoQV+8e5ON+Jjtg5J5QyBvJXKBCxICatr0aoub9VnXpuDA=@vger.kernel.org, AJvYcCXevh5vIM4l/N1wILi26zRB0VfCRj5rOTWJ9+i8JCCTtcTqQOQqekuVdeqAxYof3zeK+uApMlN42+ttl3WH@vger.kernel.org, AJvYcCXjyiu2msfh1AXmpdACrjZx+ehysfpAHrqTL3Gk0oouOMr1XE2prmui7X17UkhP6YHRxYLeTF+ljL2Ea/bN@vger.kernel.org
X-Gm-Message-State: AOJu0YwCNLc2MLekUBkrs1kRjbny8AEcOO6Ria0UohKkgPnEvw8gy2TS
	XfdJ56LwPfjZfF++mQvDay+6Ux5xItp829lIsUaNFvvSYv5zIamDBY00HOxh
X-Google-Smtp-Source: AGHT+IETCHIGK0mw721enGSsiHio9F34nf8fMRrHd76WZv69hnIg/7XiAuB9jHfhRho4v3uBI4sk8Q==
X-Received: by 2002:a05:690c:f82:b0:62c:e6c0:e887 with SMTP id 00721157ae682-6cfb950a938mr29761547b3.9.1724756155382;
        Tue, 27 Aug 2024 03:55:55 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39de3e7d9sm18617947b3.128.2024.08.27.03.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 03:55:54 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e1633202008so5249104276.2;
        Tue, 27 Aug 2024 03:55:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1z0Udm9zoeM3IQOFyeenSQLYJpx2yx7cgvGb8yfeCoV5llNKY7CICZ6g8BCN/rfW4IHGuw+6p7YhZs0pdpHgX77M=@vger.kernel.org, AJvYcCUEzwgKCk1MaYoaZHfqkp9EhLlUj/iK4dB5HIfFlhr9/poZyCajC6rUZq2SJWdaCTTL0RG+PTqKDdqmZJK7@vger.kernel.org, AJvYcCVFj/7SgI2UFAFEDYQm1Vnt9diD2heqtr5UMpg5SFfgis85Lj3tyL1+zqJqTookxbwh0sOoPLW54j/jobd7@vger.kernel.org, AJvYcCVHBPjzhh7j36So4wkZIBIl9XOeoQU9SlsgMYz9mCk4gU81vWRbnG3X/V6bK/qE+U+R2HIHt+nJQPg=@vger.kernel.org
X-Received: by 2002:a05:690c:9e:b0:6b2:28c3:b706 with SMTP id
 00721157ae682-6cfbb6fe00dmr29288707b3.34.1724756154320; Tue, 27 Aug 2024
 03:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org>
 <20240823-cleanup-h-guard-pm-domain-v1-9-8320722eaf39@linaro.org>
 <CAMuHMdV0R0+u1eCiUOHhL5w-wzge9KhgyumJSd28oF9kQmnx_Q@mail.gmail.com>
 <a48f1a0b-0e20-4782-bf6b-c430da9ae391@linaro.org> <58f5d332-2f2a-4607-9662-e71fd23b1316@linaro.org>
In-Reply-To: <58f5d332-2f2a-4607-9662-e71fd23b1316@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Aug 2024 12:55:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUQ5AD1QoO5F1nAy+GJoGtbi2ztKfK=2buU1MNeO8etJw@mail.gmail.com>
Message-ID: <CAMuHMdUQ5AD1QoO5F1nAy+GJoGtbi2ztKfK=2buU1MNeO8etJw@mail.gmail.com>
Subject: Re: [PATCH 09/10] pmdomain: renesas: rcar-gen4-sysc: Use scoped
 device node handling to simplify error paths
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Tue, Aug 27, 2024 at 11:39=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 27/08/2024 11:33, Krzysztof Kozlowski wrote:
> > On 27/08/2024 09:48, Geert Uytterhoeven wrote:
> >> On Fri, Aug 23, 2024 at 2:51=E2=80=AFPM Krzysztof Kozlowski
> >> <krzysztof.kozlowski@linaro.org> wrote:
> >>> Obtain the device node reference with scoped/cleanup.h to reduce erro=
r
> >>> handling and make the code a bit simpler.
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> Thanks for your patch!
> >>
> >>> --- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
> >>> +++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
> >>> @@ -303,12 +304,12 @@ static int __init rcar_gen4_sysc_pd_init(void)
> >>>         const struct rcar_gen4_sysc_info *info;
> >>>         const struct of_device_id *match;
> >>>         struct rcar_gen4_pm_domains *domains;
> >>> -       struct device_node *np;
> >>>         void __iomem *base;
> >>>         unsigned int i;
> >>>         int error;
> >>>
> >>> -       np =3D of_find_matching_node_and_match(NULL, rcar_gen4_sysc_m=
atches, &match);
> >>> +       struct device_node *np __free(device_node) =3D
> >>> +               of_find_matching_node_and_match(NULL, rcar_gen4_sysc_=
matches, &match);
> >>
> >> This breaks the declarations/blank-line/code structure, so please move
> >> this up.
> >
> > What do you mean "declaration structure"? That's the way how variables

First a block with declarations, then a blank line, followed by the actual =
code
(yeah, the pre-C99 style ;-)

> > with constructors are expected to be declared - within the code.

When it matters.

> Continuing thoughts, so you prefer:
>
>         struct rcar_gen4_pm_domains *domains;
>         void __iomem *base;
>         struct device_node *np __free(device_node) =3D
>                 of_find_matching_node_and_match(NULL, rcar_gen4_sysc_matc=
hes, &match);
>
> (assuming I will put it at the end of declarations).
>
> Are you sure this is more readable? It's really long line so it
> obfuscates a bit the declarations. The point of the scoped assignment is =
that
> you declare it at point of need/first use.

You're missing reverse Christmas tree order...

> >> If you insist on keeping assignment to and validation of np together,
> >> the line should be split in declaration and assignment.
> >
> > No, that would be inconsistent with cleanup/constructor coding style.
> > Maybe this is something new, so let me bring previous discussions:

[...]

> > and finally it will reach documentation (although it focuses on

Oh, "finally" as in not yet upstream ;-)

> > unwinding process to be specific - "When the unwind order ..."):
> > https://lore.kernel.org/all/171175585714.2192972.12661675876300167762.s=
tgit@dwillia2-xfh.jf.intel.com/

"When the unwind order matters..."

So it's perfectly fine to have:

    static int __init rcar_gen4_sysc_pd_init(void)
    {
            struct device_node *np __free(device_node) =3D NULL;
            struct rcar_gen4_pm_domains *domains;
            const struct rcar_gen4_sysc_info *info;
            const struct of_device_id *match;
            void __iomem *base;
            unsigned int i;
            int error;

            np =3D of_find_matching_node_and_match(NULL,
rcar_gen4_sysc_matches, &match);
            if (!np)
                    return -ENODEV;

            ...
    }

But my first suggestion:

    static int __init rcar_gen4_sysc_pd_init(void)
    {
            struct device_node *np __free(device_node) =3D
                    of_find_matching_node_and_match(NULL,
rcar_gen4_sysc_matches, &match);
            struct rcar_gen4_pm_domains *domains;
            const struct rcar_gen4_sysc_info *info;
            const struct of_device_id *match;
            void __iomem *base;
            unsigned int i;
            int error;

            if (!np)
                    return -ENODEV;

            ...
    }

is safer w.r.t. to future modification.

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

