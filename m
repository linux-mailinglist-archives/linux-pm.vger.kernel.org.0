Return-Path: <linux-pm+bounces-15031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D787D98C5A7
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 20:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1539A1C22763
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 18:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A734C1CDA05;
	Tue,  1 Oct 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUkwHxAN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7BB1CCEE5;
	Tue,  1 Oct 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808403; cv=none; b=JEAY4RSYcCDGMzdlB3zc+KA4Xx/HBBGZRekNp/eo0TxxB+Nrq/KNzp5q6P5yKZxeqE5I1xeByWjN+B0GqBaaFIZCqto6rUSxBAU+XudVggtpEHn073rHjs9a4ozqwzbkd/9U5ZXxHCLNcsbSOmwSoFEHamDDQntYRY7hLt9SMrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808403; c=relaxed/simple;
	bh=jh+t3dmkHCotb7wINLd4pPDMGTUKPGJ6tpTFX6J4CLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRs3mdOPxWBtOU3OTWfd/+BQZrBJKL2DpnOVhUC7CHvtoxr/guN2X4U2C+ryG6waEQiodF23S8fX9x3hwSGSoDTvoJ7bmSRTXRc1sQy6OpmMvSCpM0gCgiFEMSms0laOFDe4ZJOIKXAV+JZmhwLJ3eBaq2kEwHa+H0Qarrxsr6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUkwHxAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE688C4CED3;
	Tue,  1 Oct 2024 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727808403;
	bh=jh+t3dmkHCotb7wINLd4pPDMGTUKPGJ6tpTFX6J4CLY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uUkwHxANS+k/BBzpPhfB1sySeQGSMcAuuAvHByFIrDZYa+q5oQJmLUHl/sZzUwPxk
	 9MiR4/EQF1usxXVgwAbHm2hBV5h0k0sewGe5/MG5oYYInbc4knOH29rZYIwQC6p4+K
	 BcPS4yOojLCayKgjSuoNpp2rroJSzKASY44n3UIouTPR3RcMRcXLGPJ5FXw9qQNfLc
	 D+84FkeKgu13VZOeIISuvO0gkSSzt1Cf3vXdN7q1rl2Aci1NGvU0lv9l8Ze9f15NeN
	 I9uxDfEhmXQXSmyeBkhQFBe4XLjHJS0f12NkFal+mrZoVEXlIsrQz7UTmXHwiWN+wd
	 4OLw7LcOF3grA==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-713861d3af6so1861291a34.3;
        Tue, 01 Oct 2024 11:46:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8N1C3yQ7TtPCM83sxVmiudKKTQfBy4DggIwSWZTGAuetb7oeQpbM+tOMYiL10ZWnKGFE5lKEgIT4JRv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSFo/ZXRZzUTLn0H1PgAHLOC8RRRBvNS2q7JiWRNWj9/sNIti
	Q41zoCuYclCv0XPj1XphFhjvJMbDCBgCSQObovlzRmLS1Ict1Las70ZUnVq3tdY3DTVmFniNR/Q
	k+H7nmvSiZvXcGn9/eImeaazSrz4=
X-Google-Smtp-Source: AGHT+IGo9j9lm9CuUE7Ofpl0HS+aMA3wMgmqBtwoI6BfRUAHjViuMJmo2+mwoHAgzCCx/7RthdyPMVZHWH8dwrbYa6Q=
X-Received: by 2002:a05:6830:3894:b0:710:e987:2659 with SMTP id
 46e09a7af769-7153cded0acmr666373a34.22.1727808402297; Tue, 01 Oct 2024
 11:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917134246.584026-1-mikisabate@gmail.com> <20241001063220.dj53f3dbdiwnpkrh@vireshk-i7>
In-Reply-To: <20241001063220.dj53f3dbdiwnpkrh@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 1 Oct 2024 20:46:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i+BaCdBOoAk6a7EjDdwpjyimR_=r10kYvq9btOj3f_Rw@mail.gmail.com>
Message-ID: <CAJZ5v0i+BaCdBOoAk6a7EjDdwpjyimR_=r10kYvq9btOj3f_Rw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Avoid a bad reference count on CPU node
To: Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mikisabate@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 8:32=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 17-09-24, 15:42, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
> > In the parse_perf_domain function, if the call to
> > of_parse_phandle_with_args returns an error, then the reference to the
> > CPU device node that was acquired at the start of the function would no=
t
> > be properly decremented.
> >
> > Address this by declaring the variable with the __free(device_node)
> > cleanup attribute.
> >
> > Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
> > ---
> >  include/linux/cpufreq.h | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index d4d2f4d1d7cb..aabec598f79a 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -1113,10 +1113,9 @@ static inline int parse_perf_domain(int cpu, con=
st char *list_name,
> >                                   const char *cell_name,
> >                                   struct of_phandle_args *args)
> >  {
> > -     struct device_node *cpu_np;
> >       int ret;
> >
> > -     cpu_np =3D of_cpu_device_node_get(cpu);
> > +     struct device_node *cpu_np __free(device_node) =3D of_cpu_device_=
node_get(cpu);
> >       if (!cpu_np)
> >               return -ENODEV;
> >
> > @@ -1124,9 +1123,6 @@ static inline int parse_perf_domain(int cpu, cons=
t char *list_name,
> >                                        args);
> >       if (ret < 0)
> >               return ret;
> > -
> > -     of_node_put(cpu_np);
> > -
> >       return 0;
> >  }
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> --

Applied as 6.12-rc material, thanks!

