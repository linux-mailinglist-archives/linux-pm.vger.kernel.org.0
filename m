Return-Path: <linux-pm+bounces-24759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC059A7A74F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 17:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9E73B69C7
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F6F250C12;
	Thu,  3 Apr 2025 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBNL0Dhb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB31E24E4A6
	for <linux-pm@vger.kernel.org>; Thu,  3 Apr 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743695781; cv=none; b=B3jzNhQCp5sc/7i8qMVi6qOVbAvWcj9//HcobaTRe7xSV+3jr8TkzZTNiEwU5J1P1cmc/VLG6YFgkMXRxFlZBvhhfxNeCY2w5w2dZesIHICj4oywZQRW13QnXbaruddU/7V4rNu+pJD/o5rXP01VRMf0rzhS6XegvAG0wIrVNhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743695781; c=relaxed/simple;
	bh=KCKOvMLcQl20SFn4Y6202YMYWvD8kd3yt+S0nsoRWDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFhgA3CZtvBuc0+/x/LPMRkW8m0XZTmKVooeG5jNBGaZLPhrnxPW7OkO2hb4cnMwbPCeSXVu6KsJEjkDFfr2O0qcVzR/fFGIEvZFROWyfa7K/eu+IC+Iad8LT3qhmzzZ7xazencsx7URe0VyGhOJ2Qj592/Abm2mA5TunebvUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kBNL0Dhb; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7023843e467so10881227b3.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Apr 2025 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743695777; x=1744300577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HXCFU9YonjJhyDLHpnnxPkRURBU3+SLjAkNFJPgsSI=;
        b=kBNL0DhbNR8Dj5SOwUVGMD2gKvrb30mqHgk+5cAUNsbbqGyCwSesGAlpmHskKo36sM
         ckeVPa5VFvtaNk6zYOYWpCHvdHQd73YqG5flbRsFdEuPUPBUEgDpweMWlEsPbgtxfDyb
         rSNuOmfl6v9cO1z9I4bcu5KY7pLWevWsuMpWPueKw1/sBVPNMYStlMecH2GJhWj2S0B6
         yJL0CVpHP9brQaeAl7swovyY0VQiS9c/4oRo+wXqUxoTxzPFbW7Z1rllkp6K7O3RoIHp
         r8tpU9D5ePGS2wzz1aqpGwDhX1SRkuCnyDTanqVUbwxiboVS2tHBIEbtpZn13KfF68lH
         t7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743695777; x=1744300577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HXCFU9YonjJhyDLHpnnxPkRURBU3+SLjAkNFJPgsSI=;
        b=XZO6FR9yaTYuzELJg4JEdh9x76LVLw522UkfyuHiiMmMIgYgedJgv7dWBbA+gCVEXx
         N2oNRH0keiOHC0IuizKQmJ7/4zALWhhY0zojl1OzrgNbF1eGPOTGJycBUT/FAh1/J+a9
         GRZ+1Ukb5850IwPjw9HwCdre2uriuDvWWACi6NNBsRCCVQ+26hsqMpiab6NYZxIg5H6v
         Df2psjskezhNKU3uJWlZzfLL+x1zL9vUEvm20HpkvY78gqL6Jj5oD0DRutWrazxPv/KY
         3XjJzkIyLfhK5S9Zwxd93/7UYsKAfA1GJLfLQttm+lkEfDKMyuMiZuSMH8Pe9/bP3FF0
         1tdg==
X-Gm-Message-State: AOJu0YwjBhE/QkxeiKyELBomehNPfafhjNhpivLCEBQvACwSLJgJR+Z2
	GsQIk3/Hl0yy5b3wKodgxUuRG4F8pURkgVAuVyieHnA0mviNasgjTNs0nM7IiIQJ6RhvgjKKYyd
	Nh3gL8tiUrrVVaoNujCdJlBYY7C0Re57C61DDFjDb5+Y8P0lI
X-Gm-Gg: ASbGncs21YpXnsZyi6veNX+zHg1aKR118H8/W+gYN5M9OOytVJkjy7z+R4eQk0detk3
	keUrE600/zc1ozNC6CNIaugIkvgL+3aVd3sr5iY11d+C522Ma49T/aYcQ1pxdr6I1ToaXLBfkCW
	DUlbi22rnx9ErsrsnQvB8JeBM8aUU4L0IBS6pTTg==
X-Google-Smtp-Source: AGHT+IFtup6lzCCDcgglb/vouYIF02tq5aB9fUksxAEAz4mtg2896UBjPrAGsh8END8a/G1BpCJH1h+ZLmjMPi7nqts=
X-Received: by 2002:a05:690c:4807:b0:6fd:41e1:83d8 with SMTP id
 00721157ae682-703d0790885mr56680357b3.6.1743695777536; Thu, 03 Apr 2025
 08:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402120613.1116711-1-ulf.hansson@linaro.org> <20250403080815.jsdoydcczkeuvmy6@lcpd911>
In-Reply-To: <20250403080815.jsdoydcczkeuvmy6@lcpd911>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Apr 2025 17:55:41 +0200
X-Gm-Features: ATxdqUE_uiMj0ReQyXslvnN9euZTVAjRRAl_6-w9vMIxjplB4kuU0aE6cNyzWdE
Message-ID: <CAPDyKFrgYVMvaBf13ksdJ6Zr6bvLo1Jmz8yLiyg_43hs65STVQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Reset genpd->states to avoid freeing
 invalid data
To: Dhruva Gole <d-gole@ti.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Apr 2025 at 10:08, Dhruva Gole <d-gole@ti.com> wrote:
>
> On Apr 02, 2025 at 14:06:13 +0200, Ulf Hansson wrote:
> > If genpd_alloc_data() allocates data for the default power-states for t=
he
> > genpd, let's make sure to also reset the pointer in the error path. Thi=
s
> > makes sure a genpd provider driver doesn't end up trying to free the da=
ta
> > again, but using an invalid pointer.
>
> I maybe missing something but if kfree works similar to [1]GNU free() won=
't
> it make the genpd->states NULL anyway? Have you actually seen scenarios
> where the genpd->states is remaining non-NULL even after kfree?

Yes. kfree() doesn't reset the pointer to the data.

>
> [1]
> https://www.gnu.org/software/libc/manual/html_node/Freeing-after-Malloc.h=
tml#:~:text=3DThe%20free%20function%20deallocates%20the%20block%20of%20memo=
ry%20pointed%20at%20by%20ptr%20.&text=3DOccasionally%2C%20free%20can%20actu=
ally%20return,malloc%20to%20reuse%20the%20space.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/pmdomain/core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 9b2f28b34bb5..c179464047fe 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -2229,8 +2229,10 @@ static int genpd_alloc_data(struct generic_pm_do=
main *genpd)
> >       return 0;
> >  put:
> >       put_device(&genpd->dev);
> > -     if (genpd->free_states =3D=3D genpd_free_default_power_state)
> > +     if (genpd->free_states =3D=3D genpd_free_default_power_state) {
> >               kfree(genpd->states);
> > +             genpd->states =3D NULL;
>
> Also the coding convention for kfree in other places in pmdomains
> doesn't seem to follow this practise either...

Right. I am not suggesting changing them all. Only this one, as it's a
special case and an error path.

genpd->states may be allocated by both the genpd provider driver and
internally by genpd via pm_genpd_init(), hence we need to be a bit
more careful.

>
> $> rg -A1 kfree drivers/pmdomain
>
> Is this something we're planning to start following in pmdomains from
> now on?

As I said, this is a special case.

>
> > +     }
> >  free:
> >       if (genpd_is_cpu_domain(genpd))
> >               free_cpumask_var(genpd->cpus);
> > --
> > 2.43.0
> >
> >

Kind regards
Uffe

