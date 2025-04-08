Return-Path: <linux-pm+bounces-24940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6698CA80EC5
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 16:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A047D8A470C
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 14:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9491DF252;
	Tue,  8 Apr 2025 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlcnOx2v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933818E75A;
	Tue,  8 Apr 2025 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123102; cv=none; b=aQMXV2Qy8h+4TKG+Dq+jeSpEre8oSSQcFUBL5KgQ0tTLpS91Vgj3aNtLk3bfv7P1hwMFuszjUuB7y5WV6ol6+39+m22153T6zbFcltyHWV0IGkjoyfUzgEq2PfeHNnKnCshKF7MMf9VOy7DC2w0CUKyB7g4BJ+eynRyNQI+BdPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123102; c=relaxed/simple;
	bh=4602jiZbb6y/68K9OMjhxQx5fW+hJyFyiR+Ly6hKoVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loFJjcwXoLRN7pExktKuohTzqjERAhQWdMM5uIxc7XKGEQLUwtCxrE6P/Est2ZGhQUQLCck/xnMLHodT2YwmoM5Akyeur1ZEysR08SF/dEt8dDPIA/5VCJLoD7baqLkRv4hnRvNLoWkfIaTYSLfTuBsirU3fsWHufHkterBzJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlcnOx2v; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-3061513d353so62999311fa.2;
        Tue, 08 Apr 2025 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744123099; x=1744727899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Q7bxwJNCvq8bg2MwJK2kdA3pNJuhT9mZBUaAlfBwAA=;
        b=OlcnOx2vpR2pJDp1fnpJBxNlbRZD7BuTFoNzlz8SYDVcg91vKGCp3Q8n9DDeJ9Vwp3
         SuxSA8dYgaDOsLt1W4o1CzEFVpzP1tQNnAHpFONXufqhvUyJIfmWymK7YOw44kq6UNfr
         b91aADNRKx1cjrmzJytIVF3icMZeuQKVfi7BbEvI4jbFh9bB7Nls6rAuZhW5R6jedr05
         CQ2hEThP2+I1BRJBUZ4aYpoXuGMxuKaFKsJfJlft31tb4mYAHcjXHEZ/LTwtt6zQHnZ/
         n8pAhwrafOVuhd9cWATbaXD3Ua7i1Ej12Bgy5PITwfiqQJUn331OsYh0BG6ZXzOafO4S
         Qu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744123099; x=1744727899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Q7bxwJNCvq8bg2MwJK2kdA3pNJuhT9mZBUaAlfBwAA=;
        b=DEcTmeGKRdSJgAvvPqNQ80ezljJmcZw/nqR3vXbk7JPIW9t+fHD5YclYlXhlU4GSUU
         Yl1FECyF0EUDKwP9QJkexsmCpeWbf5FQBRYnYvSjnkJ2IKA39raF53XjJJGB3chp/KXh
         cdm6exXmmNQsHX4jU85N6zTmA94R80fLEh9Lfyfv6hCYqGGwWPI4Hx12XqXqIhLTFlfQ
         dnZAJw/D3SCJHmGHm0HTZ45RD9wxOemsunYta3OJoLbJv5B8KjnjXr1ZbJegdXlx25rg
         lSBUEnypr/GW7Kinee11fat19oRZvLcQSuOBmFQ1yZ5GMCpiqxFKCO9alRzVpWXFCJ/0
         1Ijw==
X-Forwarded-Encrypted: i=1; AJvYcCURm5+S2py6OWrm2pPJBDQ2O/qFTBfuQ1J5/shDy/SPkMvKbp55mg98EOJCqnYME1prrOln1iQvgA==@vger.kernel.org, AJvYcCUvMEkZ9oitalBIyl6FliPVZcTJgpKrr7eRdEIVoJAJChecbrgNxXw9PO7slN03rnFo4XvLO6Do4m4=@vger.kernel.org, AJvYcCXqpd+/2MEgrJzcb36LnPZ6evEZ5cTJFpF1UpN9x4IjFK0Bmp8PfzrkDvmA+ZL8BCyHLmM6gAbSg+Q5AsRg@vger.kernel.org
X-Gm-Message-State: AOJu0YwpAvdLYaC0XE7bqRjZqSVMxRMtPPk2sDCo8Yv3jFWXakwmTYRq
	FVAod8VeZWuWxrn+VDEaX3NgzM4HNCV/zv/5pIWhNVYCzuOOeuSyF82cT2gRQMCjHCfRztt6Ml7
	Fg+av+H7kr79xDqSWkgJHW6e2H4vBXGlo
X-Gm-Gg: ASbGncvSZ9pSsCoJd0ylZUDpEbq6snLuqiCaaHbOtRXDj6H9wW5DueKAKaAD5awj8ul
	p27pm1+FDlZQiPdvKMBVZjCWNBOA86t7P1ujghLhZktVjUKH6njN04+VkGr9ufxGTTgbQF4uuZg
	M7Omf6Wd0pk/juzOr7ot6DvL2bWQ==
X-Google-Smtp-Source: AGHT+IHU10fpaX9Y+BK0PT1SISRH+YFkz7nb8FFJqSdolPlNMzG1qkWD7zj329MmOVdStqbKBKnJK+oXqDOOT6sYTtk=
X-Received: by 2002:a05:651c:1442:b0:30c:6f3a:dce9 with SMTP id
 38308e7fff4ca-30f1650c370mr35717131fa.10.1744123098278; Tue, 08 Apr 2025
 07:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250405055447.73925-1-bsdhenrymartin@gmail.com>
 <20250407-wondrous-turtle-of-foundation-e92250@sudeepholla> <20250408055505.oked4a3drsym46wz@vireshk-i7>
In-Reply-To: <20250408055505.oked4a3drsym46wz@vireshk-i7>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Tue, 8 Apr 2025 22:38:07 +0800
X-Gm-Features: ATxdqUGy8OGeNNfaWbovLbK4n8MBpz3d2_OV8hx-iHgIR4LNXqu-6gTdwL3S9-4
Message-ID: <CAEnQdOo8CUe5Xpdo=qkCtv-E9gs-BvxUAgVa1Hvptp-2iFX0_w@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, cristian.marussi@arm.com, rafael@kernel.org, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> How about `if (unlikely(!policy))` instead ?
Agreed, unlikely() makes sense here since the NULL check is for an
exceptional case.
I'll update all relevant patches accordingly.

> Henry, this change applies to all the patches you have sent. Also please =
send
> them as a single series, as they are related changes.
Noted. I=E2=80=99ll consolidate the patches into a single series with a pro=
per
cover letter and
resend them shortly.

Viresh Kumar <viresh.kumar@linaro.org> =E4=BA=8E2025=E5=B9=B44=E6=9C=888=E6=
=97=A5=E5=91=A8=E4=BA=8C 13:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On 07-04-25, 12:30, Sudeep Holla wrote:
> > On Sat, Apr 05, 2025 at 01:54:47PM +0800, Henry Martin wrote:
> > > cpufreq_cpu_get_raw() can return NULL when the target CPU is not pres=
ent
> > > in the policy->cpus mask. scmi_cpufreq_get_rate() does not check for
> > > this case, which results in a NULL pointer dereference.
> > >
> > > Add NULL check after cpufreq_cpu_get_raw() to prevent this issue.
> > >
> > > Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI=
 message protocol")
> > > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > > ---
> > >  drivers/cpufreq/scmi-cpufreq.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cp=
ufreq.c
> > > index c310aeebc8f3..c735f39245bf 100644
> > > --- a/drivers/cpufreq/scmi-cpufreq.c
> > > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > > @@ -37,11 +37,17 @@ static struct cpufreq_driver scmi_cpufreq_driver;
> > >
> > >  static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
> > >  {
> > > -   struct cpufreq_policy *policy =3D cpufreq_cpu_get_raw(cpu);
> > > -   struct scmi_data *priv =3D policy->driver_data;
> > > +   struct cpufreq_policy *policy;
> > > +   struct scmi_data *priv;
> > >     unsigned long rate;
> > >     int ret;
> > >
> > > +   policy =3D cpufreq_cpu_get_raw(cpu);
> > > +   if (!policy)
> >
> > How about `if (unlikely(!policy))` instead ?
>
> Henry, this change applies to all the patches you have sent. Also please =
send
> them as a single series, as they are related changes.
>
> --
> viresh

