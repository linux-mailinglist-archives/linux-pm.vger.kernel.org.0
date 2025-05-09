Return-Path: <linux-pm+bounces-26970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40351AB1B1E
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 18:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9169FA0217A
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919662356B1;
	Fri,  9 May 2025 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Np91o4oi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156120C030;
	Fri,  9 May 2025 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809857; cv=none; b=kyonxcCjdmwdDxrcIgcl/zNOtZTf0qoTZE2t1jEJQI8FIs7U/QUHDCXihbEyTstF3vheo2/4Ma5kOtCwzUZdsg1V+pxJIY0nJfJ66O8D7YnJNCQSKScGw1CYs1eY+G8dYx4pl4n1EflXhI1r6DxvOl/k4oc1qbC0lNYkT1/xzhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809857; c=relaxed/simple;
	bh=f+HzxQPWwken1azUW8kFJMFBZlKUu3T4KQof9pysA/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaQGLdkBOLjznH/c215g9lCwtlzXmsHiBMgZ+MimkVNzAKY71aisvr8pczA7mOE3W4DmBiqX+USl7a0iybqR5j1IboAhXq1NvNgy8skau50/HHsGWfMB/j06LbQlOsIYMMMlOfXlfRReJzXalyaFW9dmRK5j5LhFs3qtt6VJAv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Np91o4oi; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-326b9930730so12700821fa.0;
        Fri, 09 May 2025 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746809854; x=1747414654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG/qN/B1wwOujzXnr45jOXtdzYz6t+IOg1u2LQ5o1Xs=;
        b=Np91o4oiUXIEBSIlVkzhgGN7TVH2L6yGhMKE+P0uv5gP0OMLmx3z3subOW663c/PmJ
         WAYuc4r5g88Rf5eHqnNkZS9ddG7fnZjx0whNBpO+H2oJRU2brptQaJfAqN5ho0sMsy9n
         +zA9VfELxl7d0Df+xzQJ2h1ZHkqI+ui+bATDAthbl8SrsTK7vmJ44VoY9JYARxGWucz+
         enr+GZNuiXuPszqwAosf52TzIPFsJBWK/iGXgcqZNRQLnq9XDuLWNwA+8HMF8nx73UU2
         /0Kxup4QecXG4HFSUet0Di931mmRfKAKutBaITbiZ02kYy6+BtpeEZkJYtwmaZsn0ajz
         fEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746809854; x=1747414654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG/qN/B1wwOujzXnr45jOXtdzYz6t+IOg1u2LQ5o1Xs=;
        b=Pm+9kg0ChOjEF6iKkr4Ao3Bh2XBpbWiwC+D3ALf1w1PYJ1Tnilk341WsW3ZLhNdMh/
         2nsOp6cFwXrCN+YS3HOT7W7IfGFj9AweT5RsWdtXzaEfNHThRuTnukOaFt3PeLhlvo0e
         c4OiaDUwl/zRaAWtwglr/xF7/RD6Kmi7e6Mc/+EYsuTfp83zkcc2aAQlNl7wvsWHGHBE
         PJm9xlnkZWhW0LlP4Vo/zmyVesluMO3AJQB5/1HO4hFN/Yc0SEdOFMu1WfhfqTfVKQ5z
         QXm0LOxm82/naJlEJYzq7nTRKxlQTzjNRHL3pjLaMsuiGKwFgzSLeIqlunNhTpgzLLh+
         DfKA==
X-Forwarded-Encrypted: i=1; AJvYcCWXSHIFg7Mmepl6yY9zUQxaI2FITEBpRax2/BXp10pbr+seU2Y4xNjHgGJ4+qzPZxqWOckewvoqQyGzB8I=@vger.kernel.org, AJvYcCWcoQ8/tLscqAUhWpcajSQ1CqfEFo909Og2Dgw41UqTk0lxXflljhABmdI+Jo8OJhBVxrJIdG6+Rh/he6k=@vger.kernel.org, AJvYcCXkL64f+Gq15dGD/IGm9QMm7pGSM/xkpFEcbz3m7h6GuTkS0R5m/izv0aVvPD7/ZuLplfXYj52sQPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5B3exjUsCsZGh1vMurSa+ikfpHdbh6l7t0iibhhKVuUhnGV26
	Kqz/FGm1r08fzrmCPEjWK3jn98wBbSswuT1aFGiB0J3Qx0eBozMse8Q0s7rNJWwajs+Ci21y4fI
	0GGXPtaDEXcxmUHGdaTxLC3a9XRw=
X-Gm-Gg: ASbGncsg7ACsaYj0XE3kClrdId6pZX8jxLxJSu9B4ioHqSzXklrpKD0pf7FwYkLX3fX
	SC188S1gfpR7O5w+rKyjyA4SgknZ4BXa+cvuQYOvUji0pt9+CVMJqq5zJMA3XO46DsVpRnuElkH
	gbO+YXP56wuHxcwiRRnpgd23c=
X-Google-Smtp-Source: AGHT+IFi0cF1V2iQpXTJCR3ehLfO/KkBUNbi40rI+b+xnbSC/u9nzRUrq6I2aH8N0QpOvZtq/8HaO2OBzNmgALN9d6c=
X-Received: by 2002:a05:651c:146a:b0:30b:c22d:83b3 with SMTP id
 38308e7fff4ca-326c45d5a16mr15986021fa.15.1746809853513; Fri, 09 May 2025
 09:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-1-d142bcbd0234@gmail.com> <040b0d8b-e862-48dd-9b77-9266a5194f99@nvidia.com>
In-Reply-To: <040b0d8b-e862-48dd-9b77-9266a5194f99@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Fri, 9 May 2025 11:57:20 -0500
X-Gm-Features: AX0GCFuVMPqFC7B8B51EiIFyIqN0yLO5E4GUOE7AbDBM_ioXLvtK80spl4zANbI
Message-ID: <CALHNRZ_AH-OkDak_RDoA3FB6EVO78r5G=5zosiJEXk4UGLH=fQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] cpufreq: tegra124: Remove use of disable_cpufreq
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 6:04=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> wr=
ote:
>
>
>
> On 09/05/2025 01:04, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > Instead, unregister the cpufreq device for this fatal fail case.
>
> This is not a complete sentence. Seems to be a continuation of the
> subject which is not clear to the reader (at least not to me). No
> mention of why or what this is fixing, if anything?

I can clean up the subject and message in a new revision. More on the
reasoning below.

> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >   drivers/cpufreq/tegra124-cpufreq.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra=
124-cpufreq.c
> > index 514146d98bca2d8aa59980a14dff3487cd8045f6..bc0691e8971f9454def37f4=
89e4a3e244100b9f4 100644
> > --- a/drivers/cpufreq/tegra124-cpufreq.c
> > +++ b/drivers/cpufreq/tegra124-cpufreq.c
> > @@ -168,7 +168,10 @@ static int __maybe_unused tegra124_cpufreq_resume(=
struct device *dev)
> >   disable_dfll:
> >       clk_disable_unprepare(priv->dfll_clk);
> >   disable_cpufreq:
> > -     disable_cpufreq();
> > +     if (!IS_ERR(priv->cpufreq_dt_pdev)) {
> > +             platform_device_unregister(priv->cpufreq_dt_pdev);
> > +             priv->cpufreq_dt_pdev =3D ERR_PTR(-ENODEV);
> > +     }
>
> So you are proposing to unregister the device in resume? That seems odd.
> I see there is no remove for this driver, but I really don't see the
> value in this.

This was suggested by Viresh in v1 [0] to replace the call to
disable_cpufreq, which is not currently an exported function. I'm open
to other suggestions.

Sincerely,
Aaron

[0] https://lore.kernel.org/all/20250421054452.fdlrrhtsimyucbup@vireshk-i7/

