Return-Path: <linux-pm+bounces-34194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E16D1B4A16B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 07:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FEC37AB3E3
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 05:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F262F7AD6;
	Tue,  9 Sep 2025 05:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD0f0QVu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2835D2264A3;
	Tue,  9 Sep 2025 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396607; cv=none; b=MmDj47+rBolCKGESlTjKdMtqeKO1OJxW7J1FnmiqOqB5a5HqEGnY70Dqk97bmCVGRwdhanAQRAS/sdiI/9FdrjZbcQSKfLRiNWEagjl0FobE4E69bIDUIw9/PFFBy+U3CH+y35px1dCbZxlj7lCZn1sbvM/PVuFPdV2z+B8VDaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396607; c=relaxed/simple;
	bh=1JLWB9NxHUYB0N6l6hiWHN/rHGZX8pA98KRFRV3h72Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnK/y7+WK0HFsjrfvspZiWsSzUZGQo5WwpUX3cYQavjb58REXcNtUHS1NKSfY/1Mc5L4aa5w1dlRSILharBRZfQiextWXn6oIUTsE3wSgPb1CeiucoL6jUcq+fEsWyRSoaE5JFFtosuf4iVgl/WmSOkpN10zxEKEl8oyDX+QPjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD0f0QVu; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-336ce4a894cso39182451fa.1;
        Mon, 08 Sep 2025 22:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757396603; x=1758001403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1G6Fm4HNrV/bD2bs71ctmqkCh2KbDqFBUWnpt06ckp8=;
        b=dD0f0QVu+U2TUvR2HlvPKN28OTip5jypb4FQsReRkc+vu7jR7Xma+gmriEnOkjAXsz
         sYzE9+AvHYT1vVkzG3D62rV0xM21drBwrfO78mc96dzkiqY3bJScMfiYTYY0KE4rKEbN
         CE37Aqz8eJDJYrHq7hS6ziVA51r3FbLPFzn9VdsXueCw64YKRoPXwcrxVr4OFXGExMEk
         21bfoEQ+rkrU2HyDkFZw73XyfW3wCIobhFUKsIxlmbs1LqchM5i7bYjAvXUgVJMzU3Jk
         2g9sQ0wMspD3ysl9TPqxcP3FncDgq9iV0nbXEi7k6bkMA8lTQgOThdvmN3yum5lKX1tG
         9bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757396603; x=1758001403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1G6Fm4HNrV/bD2bs71ctmqkCh2KbDqFBUWnpt06ckp8=;
        b=Qnxq5nbm5sR5TrmiHLBw1HW/woV7Wa2qPHAQKsLmr55v+RVz/4MrICCasZc8oekyLx
         17UYedrJX2UIowfbFKF/9PHG0jDesL5qlIbSZTX/PyLUmmecubpfAUvfcfykxBDYBX8i
         XZHD2kwsGZonDhsavA5i0jxFnzJHhrdB+nDBWjtKkG/+26sJQcShqOYZwsFvRyQfYM3/
         s0PgEAjQ+JZiwXbQq+j1RJVbKsmRVSBvo9HGXn+My2xo4eIclmIaXT5bYkHAUNaqooU4
         c2k8YRa6Kf6yGIKGnOeVkzzYLgxsCSBjOnOkXZVdRnN+D3qDQJZUV3CF/cdZTac2w1yK
         mACQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCMueoYooEoDlCynrcGFBrhAeiPlswMDvmcxl//sGNzZRwbBZ4YVRjUH7mzCW5hiVEuZxTxjLt7kQ=@vger.kernel.org, AJvYcCXH1Jsn6p83EfFzz1Q5fGBImRtI1ma0ZkLbGm2Oi0qps0SylfQnvErWbamtDxvPqhaq/Y4PiMb4aZEF@vger.kernel.org, AJvYcCXJ5Kg+DlYI7HbguHsAJSAFKlvmUJixaqxQtmQSwiPztmxWMRekNlz0EmrSWD3cdTD3tgSoN4yXcGSqZFhd@vger.kernel.org, AJvYcCXQqSfm8NiNSg5uEeu68XeWDL2j1eVfnzhwD/8GGPf5K57IieN60OPGfCCljACeTs4jCKs0PvkDIQNSxCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv3ACKzqjFUHNUgOSSuE60nkJBmn933VuQQ0auw1Cp2mahME7P
	PXe2gkuJlGckJci0iQk8rTXQzeoRuEsfLxx66i6wFbtoMcLjsf23YDtt1+3Klqb9I8v2Pi9VeLP
	+adJPhutb1vesM1RgVvFy/NNJORScd4EcI/Tx4io=
X-Gm-Gg: ASbGncspXHrqxldgqooC43lDjhI3YSrTom24WjTA1gRak29xvW88gr5GLbEcqgH8pp5
	IxrC34gg8xjFzkPUpHRDexrej2R9FxMFjmcHO//JvSY++O+wYRkqxIp2a/q0XTpz5Gx4SAcYAxb
	KVDbLEnlbdbbApdT0iLjEx+xlHFa4DItHkIfMHDOY7fo2bhI9BtlgWGyaNhmgBBbZt90NI2DZN1
	mCl7iAC7G/6SCyanA==
X-Google-Smtp-Source: AGHT+IFnQAtfbNXUxujuvpaZBVeXodUsf4RXFRUXQ8ktfLXToDvcxeXnGxXIgaFmJAGt6UaM90HbCfaGi6DB9sgP+uA=
X-Received: by 2002:a2e:be9e:0:b0:337:e190:6814 with SMTP id
 38308e7fff4ca-33b5cfd0d57mr33329871fa.20.1757396602983; Mon, 08 Sep 2025
 22:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
 <20250831-tegra186-icc-v1-3-607ddc53b507@gmail.com> <20250901055322.eorgaa3sycydjrrj@vireshk-i7>
 <CALHNRZ_EbtHSXaDQ+1gGf3HjdyW5Q54EDN901-r8A_aXLbDJkw@mail.gmail.com> <20250903050107.sbri6snqrzq4hale@vireshk-i7>
In-Reply-To: <20250903050107.sbri6snqrzq4hale@vireshk-i7>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 9 Sep 2025 00:43:11 -0500
X-Gm-Features: Ac12FXzAJuPe-CvFuYuufxqv80GNsivKH6j8HchajG_Xb4CMnT3WaKxDxqCkLXs
Message-ID: <CALHNRZ-qkhDc5uO8g18T97RgHZCQ59Zh2Vn+yEX-W3+GSfj_sA@mail.gmail.com>
Subject: Re: [PATCH 3/8] cpufreq: tegra186: add OPP support and set bandwidth
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sumit Gupta <sumitg@nvidia.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 12:01=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> +Sumit
>
> On 02-09-25, 12:21, Aaron Kling wrote:
> > On Mon, Sep 1, 2025 at 12:53=E2=80=AFAM Viresh Kumar <viresh.kumar@lina=
ro.org> wrote:
> > > On 31-08-25, 22:33, Aaron Kling via B4 Relay wrote:
> > > > +static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, uns=
igned long freq_khz)
> > > > +{
> > > > +     struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_dat=
a();
> > > > +     struct dev_pm_opp *opp;
> > > > +     struct device *dev;
> > > > +     int ret;
> > > > +
> > > > +     dev =3D get_cpu_device(policy->cpu);
> > > > +     if (!dev)
> > > > +             return -ENODEV;
> > > > +
> > > > +     opp =3D dev_pm_opp_find_freq_exact(dev, freq_khz * KHZ, true)=
;
> > > > +     if (IS_ERR(opp))
> > > > +             return PTR_ERR(opp);
> > > > +
> > > > +     ret =3D dev_pm_opp_set_opp(dev, opp);
> > >
> > > Won't it be easier to use dev_pm_opp_set_rate() instead ?
> >
> > I'm not very familiar with the opp system. If I read correctly,
> > dev_pm_opp_set_rate() will round to the closest rate while this code
> > will fail if the exact rate isn't found. This code is based on the
> > existing tegra194-cpufreq driver. And I'm unsure if this was done for
> > a reason.
>
> Sumit, any explanation for this ?
>
> > I have seen unexpected rates returned from clk_round_rate in
> > the development of this topic, so that could be related.
>
> Right, but we should end up configuring a valid rate from the OPP
> table.
>
> > > > +static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy =
*policy,
> > > > +                                         struct cpufreq_frequency_=
table *bpmp_lut,
> > > > +                                         struct cpufreq_frequency_=
table **opp_table)
> > > > +{
> > > > +     struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_dat=
a();
> > > > +     struct cpufreq_frequency_table *freq_table =3D NULL;
> > > > +     struct cpufreq_frequency_table *pos;
> > > > +     struct device *cpu_dev;
> > > > +     struct dev_pm_opp *opp;
> > > > +     unsigned long rate;
> > > > +     int ret, max_opps;
> > > > +     int j =3D 0;
> > > > +
> > > > +     cpu_dev =3D get_cpu_device(policy->cpu);
> > > > +     if (!cpu_dev) {
> > > > +             pr_err("%s: failed to get cpu%d device\n", __func__, =
policy->cpu);
> > > > +             return -ENODEV;
> > > > +     }
> > > > +
> > > > +     /* Initialize OPP table mentioned in operating-points-v2 prop=
erty in DT */
> > > > +     ret =3D dev_pm_opp_of_add_table_indexed(cpu_dev, 0);
> > > > +     if (!ret) {
> > >
> > > If you handle the error case here, then the below can move out of the
> > > if/else block.
> >
> > I'd prefer not to deviate too much from the tegra194-cpufreq code this
> > is based on, so the drivers can be more easily kept in parity to each
> > other.
>
> I am not sure if that is really important here. The kernel normally
> contains code in this format:
>
> if (err)
>         return;
>
> keep-working;
>
> If you want both the drivers to have similar code, then maybe that
> code should be moved to another file and used by both. But we
> shouldn't keep them same when we feel that we can do better.
>
> > But I will look at making this a bit cleaner as per this and
> > the next comment.
>
> Thanks.
>
> > > > +             max_opps =3D dev_pm_opp_get_opp_count(cpu_dev);
> > > > +             if (max_opps <=3D 0) {
> > > > +                     dev_err(cpu_dev, "Failed to add OPPs\n");
> > > > +                     return max_opps;
> > > > +             }
> > > > +
> > > > +             /* Disable all opps and cross-validate against LUT la=
ter */
> > > > +             for (rate =3D 0; ; rate++) {
> > >
> > > Maybe using while(1) would be more readable ?
> > >
> > > > +                     opp =3D dev_pm_opp_find_freq_ceil(cpu_dev, &r=
ate);
> > > > +                     if (IS_ERR(opp))
> > > > +                             break;
> > > > +
> > > > +                     dev_pm_opp_put(opp);
> > > > +                     dev_pm_opp_disable(cpu_dev, rate);
> > > > +             }
> > > > +     } else {
> > > > +             dev_err(cpu_dev, "Invalid or empty opp table in devic=
e tree\n");
> > > > +             data->icc_dram_bw_scaling =3D false;
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     freq_table =3D kcalloc((max_opps + 1), sizeof(*freq_table), G=
FP_KERNEL);
> > > > +     if (!freq_table)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     /*
> > > > +      * Cross check the frequencies from BPMP-FW LUT against the O=
PP's present in DT.
> > > > +      * Enable only those DT OPP's which are present in LUT also.
> > > > +      */
> > > > +     cpufreq_for_each_valid_entry(pos, bpmp_lut) {
> > > > +             opp =3D dev_pm_opp_find_freq_exact(cpu_dev, pos->freq=
uency * KHZ, false);
> > > > +             if (IS_ERR(opp))
> > > > +                     continue;
> > > > +
> > > > +             dev_pm_opp_put(opp);
> > > > +
> > > > +             ret =3D dev_pm_opp_enable(cpu_dev, pos->frequency * K=
HZ);
> > > > +             if (ret < 0)
> > > > +                     return ret;
> > > > +
> > > > +             freq_table[j].driver_data =3D pos->driver_data;
> > > > +             freq_table[j].frequency =3D pos->frequency;
> > > > +             j++;
> > > > +     }
> > > > +
> > > > +     freq_table[j].driver_data =3D pos->driver_data;
> > > > +     freq_table[j].frequency =3D CPUFREQ_TABLE_END;
> > > > +
> > > > +     *opp_table =3D &freq_table[0];
> > > > +
> > > > +     dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
> > > > +
> > > > +     tegra_cpufreq_set_bw(policy, freq_table[j - 1].frequency);
> > >
> > > Maybe a comment on why exactly you are changing the freq here ?
>
> I meant bandwidth here.
>
> > To my knowledge, this does not change any clocks. The intent here is
> > to prime the interconnect data. In the pre-req series, there's a
> > change that sets all clocks to max frequency during probe. Then my use
> > case involves setting performance governor by default on some boots.
> > During testing, I noticed that the interconnect data provided by this
> > driver was all zeroes. Which led me to notice that set_bw is only
> > called when the target frequency changes. Which wasn't happening
> > because clocks were already set to max. If my understanding here is
> > wrong or there's a better way to handle this, I will fix it.
>
> There are a lot of synchronization issues here because we are trying
> to set clk and bw separately. I guess other variables, like regulator,
> level, etc. (if used) will also be out of sync here.
>
> I think the right way to fix this would be to call set-opp for the
> device, so all the variables are configured properly.

That's what the tegra_cpufreq_set_bw function does. Matches the passed
frequency in the opp table and calls dev_pm_opp_set_opp.

Aaron

