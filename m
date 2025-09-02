Return-Path: <linux-pm+bounces-33661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F87B40BE8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 19:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 150E77ABB38
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3578C341646;
	Tue,  2 Sep 2025 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNlDoo4a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9F4C9D;
	Tue,  2 Sep 2025 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833725; cv=none; b=PEmGPTIzqDYxJAt6QpfJ3nY3ovE4Rz3xbk7ebFwrCWxZqCCFvBnFGKay3/pRuH5+3iF/MREsUzG9bDJcWgtlx9/+r87TIqEH0e1Vtl/BUbhqrVK9CEPUn4qFp8ZtMLi9QysW8TrXqwGFV9EH5eVc+4ANfBmsMLXE/4rxF/+9xmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833725; c=relaxed/simple;
	bh=B6M7C6RAvQGIo2fAq8KjeI0slfKrcN2+BChM7Fx5Yek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrK0IEDCRusCHGNZzFJ5A8sH44LqTBKKXNMSBM4yVkhUSc1D3hnja/GPgLSiVq+b5+oAaTYQmwOj8IzEjDWYJc2UIP++nByYZuMifLwx5zNRMvKIvhyUz6LW3PfPCUoLYv4jx8PgDzaV2v+4Deupxem5Ux5CkX98CIJFggRtVzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNlDoo4a; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f74c6d316so3070315e87.0;
        Tue, 02 Sep 2025 10:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756833721; x=1757438521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHL/9iHScP0f81WBDBOizsme4Dv5vS87EI96jZlcSN0=;
        b=VNlDoo4aabpzvnbp+UD/sxN7uinL2Th/IL3DVcU9Gpki4+6sxp2sVDtAARO2GhoZdQ
         3Cw5XKrTM7wub1dUyLuSEr43ZP69TrKyY68pvUguQf4CjO3RbL64NGsJfy+eZrnd46Bm
         oSh7kHDgZFAWsIs8DHTJaTVMFnOT/4wwNiwk5aINdSVx3kznQ/bAWMiXtoSklJIGRrdf
         p3tt3LgpBiM0H0DUWJephh0rRd68wruoHTkURT+SEsR4chhGTFguej4JWpvTWHaBTAsW
         qRIsyox1WSGhJ9y5bMILn9e3KUEkSz4jXYdjAML1q9AFW5i8Q9D1ud37n/aaDjKPNYUx
         7YZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756833721; x=1757438521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHL/9iHScP0f81WBDBOizsme4Dv5vS87EI96jZlcSN0=;
        b=g79gPu7YLF0TsmSZWA1PSa0db4TTNbSHNK1rd4Xm8VCZPRKOwVeG6Uzogml+7MI/UF
         tQrWho/qF7ecvK89WR7uK/su3LdE99mIPTXM/1+GmzG1bFja0dmdwc5BzwXOq7BTjfqF
         Kj6+mjKLnNOO7o1poNSBCi/6nHZyx+PfFQ5n/uA0BzDT4nwxWNaWpd/KwphD54i7bSmD
         /qrRegUxUtTg6bt0Cknw+Evqn2wRjZ1RTPsSwYuQAwfpk5NAdyi1ORKX/HJAhwetpaIi
         2jvVfSodyyJCQcD/wBlVSph24ucJkDqDk0li59Pzh3GuyhDYKjBNiw+eDEXuUWt0Wzgq
         rkMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC+DyHkKepa4K/jpZdlgYGA+vIxWI513Im26ziCtjuyFz+lLO7DwvK7wWsyr/OFj+35/LVkhtDHXOEOAM=@vger.kernel.org, AJvYcCUFXJsNtGZs3YJbOTU0dHFlf5AAa39t7ihWgliANvOM5RdkxxkQxnCFp85EMpNx7TjviP/6PeMDzShInzAY@vger.kernel.org, AJvYcCVVr5Tm6Ttx9rneoZexUZW+or/kQsQCwiOUGtY22H8gO4cAqIO9IEKbNapV77CBpGNzyPOjyDsCSknu@vger.kernel.org, AJvYcCW0w4zVmTbvOFXLrraYAz3QV3t4HpoQUosbD9pot3Rahlh/BegTTKV0X7sL46P8YfqzEx9soDgphWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJhA1bACAwP99VB6aJ/qmURmn3vVnUFAd+MZCgOXGuwy8LHN01
	ByMpAl1S+4l+USC4500G/AU0x6ACnjXhnWFr6uzvshb5AiJPRY534Rns3cDC39ZGGzdinjTcTv9
	rUef/h6Z1YvXyRphpxqqzLMyrzc0/Lh4=
X-Gm-Gg: ASbGncusWsZhIbDHxiv4o1I4rcm++zwToBS4wlFXfVJx3s46XIkY4u3F9AhBzjsLRWY
	dXXS8b37zaE7KJL81UnH1CnSxJr7to0ayunv233pvjF6rvMQMCBmDoLmOuJ667IfpGV478xMjQU
	hOsYn8lbpd8OXPJWmVmMaU51+GkPToB3C5DqkLMIIL9a7GFBWVJiPKATnTDFkbJqgcq2RAYtB6r
	+QB0nzfv8z1ijutAQ==
X-Google-Smtp-Source: AGHT+IE8oTTq+xEDbODxk6NkVp632kFnXlauLi5KyQdm1eD41EnADMVC5Pj54/S9hW5DBLjU9xVeRCbpJzdGAY5g6ME=
X-Received: by 2002:a05:6512:6812:b0:55f:44b8:1eda with SMTP id
 2adb3069b0e04-55f709c5066mr3203274e87.57.1756833720986; Tue, 02 Sep 2025
 10:22:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
 <20250831-tegra186-icc-v1-3-607ddc53b507@gmail.com> <20250901055322.eorgaa3sycydjrrj@vireshk-i7>
In-Reply-To: <20250901055322.eorgaa3sycydjrrj@vireshk-i7>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 2 Sep 2025 12:21:48 -0500
X-Gm-Features: Ac12FXwAMFX1p_PsOnmUDjM6sbNKJYvGiQz3wZmgcPdZm7OguorJSHmUZJm_-T4
Message-ID: <CALHNRZ_EbtHSXaDQ+1gGf3HjdyW5Q54EDN901-r8A_aXLbDJkw@mail.gmail.com>
Subject: Re: [PATCH 3/8] cpufreq: tegra186: add OPP support and set bandwidth
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 12:53=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 31-08-25, 22:33, Aaron Kling via B4 Relay wrote:
> > diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra=
186-cpufreq.c
> > index bd94beebc4cc2fe6870e13ca55343cedb9729e99..f0abb44e2ed00a301161565=
e4c4f62cfed4a5814 100644
> > --- a/drivers/cpufreq/tegra186-cpufreq.c
> > +++ b/drivers/cpufreq/tegra186-cpufreq.c
> > @@ -18,6 +18,7 @@
> >  #define EDVD_CORE_VOLT_FREQ_F_SHIFT  0
> >  #define EDVD_CORE_VOLT_FREQ_F_MASK   0xffff
> >  #define EDVD_CORE_VOLT_FREQ_V_SHIFT  16
> > +#define KHZ                          1000
>
> Can reuse:
>
> include/linux/units.h:#define HZ_PER_KHZ                1000UL

Will do.

>
> > +static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, unsigne=
d long freq_khz)
> > +{
> > +     struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
> > +     struct dev_pm_opp *opp;
> > +     struct device *dev;
> > +     int ret;
> > +
> > +     dev =3D get_cpu_device(policy->cpu);
> > +     if (!dev)
> > +             return -ENODEV;
> > +
> > +     opp =3D dev_pm_opp_find_freq_exact(dev, freq_khz * KHZ, true);
> > +     if (IS_ERR(opp))
> > +             return PTR_ERR(opp);
> > +
> > +     ret =3D dev_pm_opp_set_opp(dev, opp);
>
> Won't it be easier to use dev_pm_opp_set_rate() instead ?

I'm not very familiar with the opp system. If I read correctly,
dev_pm_opp_set_rate() will round to the closest rate while this code
will fail if the exact rate isn't found. This code is based on the
existing tegra194-cpufreq driver. And I'm unsure if this was done for
a reason. I have seen unexpected rates returned from clk_round_rate in
the development of this topic, so that could be related.

>
> > +     if (ret)
> > +             data->icc_dram_bw_scaling =3D false;
> > +
> > +     dev_pm_opp_put(opp);
>
> The OPP core supports scope based cleanup helpers now, maybe use them
> to remove all these put calls.

I will look into this.

>
> > +     return ret;
> > +}
> > +
> > +static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *pol=
icy,
> > +                                         struct cpufreq_frequency_tabl=
e *bpmp_lut,
> > +                                         struct cpufreq_frequency_tabl=
e **opp_table)
> > +{
> > +     struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
> > +     struct cpufreq_frequency_table *freq_table =3D NULL;
> > +     struct cpufreq_frequency_table *pos;
> > +     struct device *cpu_dev;
> > +     struct dev_pm_opp *opp;
> > +     unsigned long rate;
> > +     int ret, max_opps;
> > +     int j =3D 0;
> > +
> > +     cpu_dev =3D get_cpu_device(policy->cpu);
> > +     if (!cpu_dev) {
> > +             pr_err("%s: failed to get cpu%d device\n", __func__, poli=
cy->cpu);
> > +             return -ENODEV;
> > +     }
> > +
> > +     /* Initialize OPP table mentioned in operating-points-v2 property=
 in DT */
> > +     ret =3D dev_pm_opp_of_add_table_indexed(cpu_dev, 0);
> > +     if (!ret) {
>
> If you handle the error case here, then the below can move out of the
> if/else block.

I'd prefer not to deviate too much from the tegra194-cpufreq code this
is based on, so the drivers can be more easily kept in parity to each
other. But I will look at making this a bit cleaner as per this and
the next comment.

>
> > +             max_opps =3D dev_pm_opp_get_opp_count(cpu_dev);
> > +             if (max_opps <=3D 0) {
> > +                     dev_err(cpu_dev, "Failed to add OPPs\n");
> > +                     return max_opps;
> > +             }
> > +
> > +             /* Disable all opps and cross-validate against LUT later =
*/
> > +             for (rate =3D 0; ; rate++) {
>
> Maybe using while(1) would be more readable ?
>
> > +                     opp =3D dev_pm_opp_find_freq_ceil(cpu_dev, &rate)=
;
> > +                     if (IS_ERR(opp))
> > +                             break;
> > +
> > +                     dev_pm_opp_put(opp);
> > +                     dev_pm_opp_disable(cpu_dev, rate);
> > +             }
> > +     } else {
> > +             dev_err(cpu_dev, "Invalid or empty opp table in device tr=
ee\n");
> > +             data->icc_dram_bw_scaling =3D false;
> > +             return ret;
> > +     }
> > +
> > +     freq_table =3D kcalloc((max_opps + 1), sizeof(*freq_table), GFP_K=
ERNEL);
> > +     if (!freq_table)
> > +             return -ENOMEM;
> > +
> > +     /*
> > +      * Cross check the frequencies from BPMP-FW LUT against the OPP's=
 present in DT.
> > +      * Enable only those DT OPP's which are present in LUT also.
> > +      */
> > +     cpufreq_for_each_valid_entry(pos, bpmp_lut) {
> > +             opp =3D dev_pm_opp_find_freq_exact(cpu_dev, pos->frequenc=
y * KHZ, false);
> > +             if (IS_ERR(opp))
> > +                     continue;
> > +
> > +             dev_pm_opp_put(opp);
> > +
> > +             ret =3D dev_pm_opp_enable(cpu_dev, pos->frequency * KHZ);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             freq_table[j].driver_data =3D pos->driver_data;
> > +             freq_table[j].frequency =3D pos->frequency;
> > +             j++;
> > +     }
> > +
> > +     freq_table[j].driver_data =3D pos->driver_data;
> > +     freq_table[j].frequency =3D CPUFREQ_TABLE_END;
> > +
> > +     *opp_table =3D &freq_table[0];
> > +
> > +     dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
> > +
> > +     tegra_cpufreq_set_bw(policy, freq_table[j - 1].frequency);
>
> Maybe a comment on why exactly you are changing the freq here ?

To my knowledge, this does not change any clocks. The intent here is
to prime the interconnect data. In the pre-req series, there's a
change that sets all clocks to max frequency during probe. Then my use
case involves setting performance governor by default on some boots.
During testing, I noticed that the interconnect data provided by this
driver was all zeroes. Which led me to notice that set_bw is only
called when the target frequency changes. Which wasn't happening
because clocks were already set to max. If my understanding here is
wrong or there's a better way to handle this, I will fix it.

Aaron

