Return-Path: <linux-pm+bounces-34352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 814E4B513C1
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 12:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC0B7A590F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 10:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94C33126AE;
	Wed, 10 Sep 2025 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcVj4qEF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4E306493
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499716; cv=none; b=dRTwonEWG4FqRNA7kVBujZKVwBkPxI2PI/OhZWjeEbaZpyl+38NtkEzqY4D9KCzdqOZ6WmkOu/Myy1iw1oMKdjBO4VSPIVpxbB6jDYpsnCuRi3NmweQChu6mfYZO7U6BlG8/65OUuI6zlod2/Fl6fA9g93raDznqpgpFTYZOMZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499716; c=relaxed/simple;
	bh=yrVyn3V6aAztgIoV6+HguoUJUYcfI42wgA0V0OhlJ14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8jjFQkCplJecIv1ELG3HI0x6R0HkesjSqE+O6WkrUQa8cUzql7Gkfc0IXHRjUSgagFyetdS/INY8S0RRrOgqWmLgGFtNb9BbUZqxxmxgFG2Kx4Iq5qatxakY9V/ME706rBN+pDDuv2R6l6LscnOJwc9BqaU/5YUhbsLJhL1nmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcVj4qEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172DFC4CEF0
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 10:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757499716;
	bh=yrVyn3V6aAztgIoV6+HguoUJUYcfI42wgA0V0OhlJ14=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dcVj4qEF1pmN8+klQXXEdKFvcOcL8mcEAC4VGlGLUzBkeHA9DYN+mtfVI6qCrcAet
	 Gno9odmTqBsm9jfamk5o/1B5/glI2R6ojev9oCHXd2GWFmF92L5sJYMU369EK9Vv5k
	 RhZ0VecyRqcsaw2HpTt9sDfCIaKv9JMVqDKVNMy87m0VMvXqQo4SwLs+ZPkxoAeRX6
	 RzT2h9kuY+iYppYVn+0w9mZOTo/xyTqGDArWe5wzhPKGV9l1rrnisaVXqsKgJ5OkcS
	 WOSIoELJl8uI+PjfAZWo3vfIS0WYohx/l8kJmjl36HQnR9vJwfH24nRlH8/ZRc5kSi
	 tAZQZvfTGUk9A==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-746da717f35so2825423a34.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 03:21:56 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxdf6tpDVWHnm9/MHZ8kRi2K0KZUwROES62/S+dP+uFIggsFD5w
	Me2U3zNVOm+1+ILezLPM4DhFFutdzKyrX2uODOwF5odDpQx94YS8W980jfrY0FkRhQxf23eujZ4
	jqg/tjiyFjmsSgaWiCltDDJ8u3Rwr5Z8=
X-Google-Smtp-Source: AGHT+IE2mwQLuun6oXjMMCRbkpIPPscqMaw9NfYkdmN5GH0yqZyaPz4+uTubmwcB33ra4Sjxbe1J4Z7AudR/pYILVss=
X-Received: by 2002:a05:6830:2b06:b0:747:4744:a4d6 with SMTP id
 46e09a7af769-74c7548c385mr7200370a34.17.1757499715344; Wed, 10 Sep 2025
 03:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906115316.3010384-1-kaushlendra.kumar@intel.com> <20250908070243.jfz3glf4qy4eohm5@vireshk-i7>
In-Reply-To: <20250908070243.jfz3glf4qy4eohm5@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Sep 2025 12:21:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iAcfr8KcaMds9a3=CSM_=Q6w6rfV2KsKaLXGettGUjQg@mail.gmail.com>
X-Gm-Features: Ac12FXw0hbvxaGPuSApkgf5nccl8jKGYtB5vHOzDq-TtWAhqsEXfC_3xw-k3eCA
Message-ID: <CAJZ5v0iAcfr8KcaMds9a3=CSM_=Q6w6rfV2KsKaLXGettGUjQg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: conservative: Replace sscanf() with kstrtouint()
To: Viresh Kumar <viresh.kumar@linaro.org>, 
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:02=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 06-09-25, 17:23, Kaushlendra Kumar wrote:
> > Replace sscanf() with kstrtouint() in all sysfs store functions to impr=
ove
> > input validation and security. The kstrtouint() function provides bette=
r
> > error detection, overflow protection, and consistent error handling
> > compared to sscanf().
> >
> > The kstrtouint() function provides:
> > - Robust error detection for invalid input strings
> > - Built-in overflow protection and boundary checking
> > - Consistent error reporting (0 for success, negative for failure)
> >
> > This maintains existing functionality while improving input validation
> > robustness and following kernel coding best practices for string parsin=
g.
> >
> > Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> > ---
> >  drivers/cpufreq/cpufreq_conservative.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/c=
pufreq_conservative.c
> > index 56500b25d77c..cce6a8d113e1 100644
> > --- a/drivers/cpufreq/cpufreq_conservative.c
> > +++ b/drivers/cpufreq/cpufreq_conservative.c
> > @@ -152,9 +152,9 @@ static ssize_t sampling_down_factor_store(struct go=
v_attr_set *attr_set,
> >       struct dbs_data *dbs_data =3D to_dbs_data(attr_set);
> >       unsigned int input;
> >       int ret;
> > -     ret =3D sscanf(buf, "%u", &input);
> > +     ret =3D kstrtouint(buf, 0, &input);
> >
> > -     if (ret !=3D 1 || input > MAX_SAMPLING_DOWN_FACTOR || input < 1)
> > +     if (ret || input > MAX_SAMPLING_DOWN_FACTOR || input < 1)
> >               return -EINVAL;
> >
> >       dbs_data->sampling_down_factor =3D input;
> > @@ -168,9 +168,9 @@ static ssize_t up_threshold_store(struct gov_attr_s=
et *attr_set,
> >       struct cs_dbs_tuners *cs_tuners =3D dbs_data->tuners;
> >       unsigned int input;
> >       int ret;
> > -     ret =3D sscanf(buf, "%u", &input);
> > +     ret =3D kstrtouint(buf, 0, &input);
> >
> > -     if (ret !=3D 1 || input > 100 || input <=3D cs_tuners->down_thres=
hold)
> > +     if (ret || input > 100 || input <=3D cs_tuners->down_threshold)
> >               return -EINVAL;
> >
> >       dbs_data->up_threshold =3D input;
> > @@ -184,10 +184,10 @@ static ssize_t down_threshold_store(struct gov_at=
tr_set *attr_set,
> >       struct cs_dbs_tuners *cs_tuners =3D dbs_data->tuners;
> >       unsigned int input;
> >       int ret;
> > -     ret =3D sscanf(buf, "%u", &input);
> > +     ret =3D kstrtouint(buf, 0, &input);
> >
> >       /* cannot be lower than 1 otherwise freq will not fall */
> > -     if (ret !=3D 1 || input < 1 || input >=3D dbs_data->up_threshold)
> > +     if (ret || input < 1 || input >=3D dbs_data->up_threshold)
> >               return -EINVAL;
> >
> >       cs_tuners->down_threshold =3D input;
> > @@ -201,9 +201,9 @@ static ssize_t ignore_nice_load_store(struct gov_at=
tr_set *attr_set,
> >       unsigned int input;
> >       int ret;
> >
> > -     ret =3D sscanf(buf, "%u", &input);
> > -     if (ret !=3D 1)
> > -             return -EINVAL;
> > +     ret =3D kstrtouint(buf, 0, &input);
> > +     if (ret)
> > +             return ret;
> >
> >       if (input > 1)
> >               input =3D 1;
> > @@ -226,10 +226,10 @@ static ssize_t freq_step_store(struct gov_attr_se=
t *attr_set, const char *buf,
> >       struct cs_dbs_tuners *cs_tuners =3D dbs_data->tuners;
> >       unsigned int input;
> >       int ret;
> > -     ret =3D sscanf(buf, "%u", &input);
> > +     ret =3D kstrtouint(buf, 0, &input);
> >
> > -     if (ret !=3D 1)
> > -             return -EINVAL;
> > +     if (ret)
> > +             return ret;
> >
> >       if (input > 100)
> >               input =3D 100;
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.18 material, thanks!

