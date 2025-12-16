Return-Path: <linux-pm+bounces-39631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4989DCC2ACB
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 13:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5270830B673F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 12:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C55365A1E;
	Tue, 16 Dec 2025 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMVixauf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1289365A1A
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887196; cv=none; b=A9KaLEeikszlD6E/L1vaiiJGlEP91GyQC8v93/m58+A75ZgR+30P52Ri6RBejQGuCtjSaNsBfwmfJT9X5hrs6k4/I0M8oKgmHc7R5qfxqgJEvPsWnB8hr665GH+sv+9SJjwXeedpDUgVG65gykfhWIhAmPI80OphxwjI8YqgaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887196; c=relaxed/simple;
	bh=hKHuDit993lc1q2Al9n8aciwxpC6SvBUJvGKQXPTrug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULHDYGkr3TtJ6lz7inEP/r14rhW8MAJgOtiCqmsF8SgJBJxQ5o2BUsrLyxxH9lV3malxcNSAJSm8CQSE60vZJk0JEgJMYJr2tlM/1LEjU+4hmlWm7aJuYlB2UCtjgZuvj6TK4JE5eOF1upizpDar4BzmOB4RlJn/xBaDy6FcEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMVixauf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66303C4AF0C
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 12:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765887196;
	bh=hKHuDit993lc1q2Al9n8aciwxpC6SvBUJvGKQXPTrug=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aMVixaufw0P/G2WP45HK0kUK9kXygaoPLw9VNN8FqYoc6uSAsqiAHrQF3OFCot399
	 cPJdV0zf/0d1sgLO2sR6wr2QLsS7KsCexJnCXGgUf5nSdhWB4A1N/FqPpNImqGGt/S
	 GjGQAwm5BdSUP/kfEH3ajFpjd/K9hG7j7HQ/+RjEIGXw3h8fu7+qY9EVriV970bvUz
	 yGOlKkwBvqywJLwuEx41u5B++W4geB9GbMWqN/0+D9zzUtcNuZd0ApBa3Pc3vSkjt1
	 hNIcfCZqFmlfF80u3u9m1lt/gB17PKWNeh+3XkUcLmCdo+JmgtmGui79pU6Phc+N7d
	 wiP9J2PRlQEvA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-65791c35134so2777192eaf.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 04:13:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDzNB1Nmi0eST9nFK3bL3xgJsvABV1vn/5eJxhnAx+Ajwv/Y9K2TI1B1Sd8oA+zy4sh9fiAaKAZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh5fOitFv6h0Po4PAAXcggIId5seMDODOAh+gaZE/8187k6kiI
	Rz8XX9WfR65RkIsiM7c936dXnTdjT/d5OOuxQeaqmpkjDFWyGDeDHcgx2i8/XlhBQ4CNkL87DGn
	/K3xVriFeKkFqmo/1KNJtYxBALMT81PQ=
X-Google-Smtp-Source: AGHT+IFDszZ0Cx3PxMASCNPcLeXv11ryMcRdj1eFMDTfmjxcBCg+kZMk30cZo6m33vFb9vh76IOAOB6WEvCpWrjO/Lk=
X-Received: by 2002:a05:6820:4dfb:b0:659:9a49:8e8d with SMTP id
 006d021491bc7-65b45165dd9mr6051477eaf.17.1765887195573; Tue, 16 Dec 2025
 04:13:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202072727.1368285-1-zhenglifeng1@huawei.com>
 <20251202072727.1368285-2-zhenglifeng1@huawei.com> <bad4857d-ba90-4587-b36f-6999fc66a898@hisilicon.com>
In-Reply-To: <bad4857d-ba90-4587-b36f-6999fc66a898@hisilicon.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Dec 2025 13:13:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hauCnTb4uLwkQ0d058mPq2Aub=MGyXTQSWi1vFGJnOgg@mail.gmail.com>
X-Gm-Features: AQt7F2r1_bX2If2NyhSzLIE6Mfww20vqxL1J4dhHOTVt7VcScWWsGzkxo4tzhb4
Message-ID: <CAJZ5v0hauCnTb4uLwkQ0d058mPq2Aub=MGyXTQSWi1vFGJnOgg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] cpufreq: Return -EOPNOTSUPP if no policy is boost supported
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, lihuisong@huawei.com, yubowen8@huawei.com, 
	zhangpengjie2@huawei.com, wangzhi12@huawei.com, linhongye@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 2:50=E2=80=AFAM Jie Zhan <zhanjie9@hisilicon.com> wr=
ote:
>
>
> On 12/2/2025 3:27 PM, Lifeng Zheng wrote:
> > In cpufreq_boost_trigger_state(), if all the policies are boost
> > unsupported, policy_set_boost() will not be called and this function wi=
ll
> > return 0. But it is better to return an error to indicate that the plat=
form
> > doesn't support boost.
> >
> > Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> LGTM.  Thanks!
>
> Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>

Applied along with the [2/2] as 6.20 material, thanks!

> > ---
> >  drivers/cpufreq/cpufreq.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index e8d7544b77b8..a4399e5490da 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2806,7 +2806,7 @@ static int cpufreq_boost_trigger_state(int state)
> >  {
> >       struct cpufreq_policy *policy;
> >       unsigned long flags;
> > -     int ret =3D 0;
> > +     int ret =3D -EOPNOTSUPP;
> >
> >       /*
> >        * Don't compare 'cpufreq_driver->boost_enabled' with 'state' her=
e to
> > @@ -2826,6 +2826,10 @@ static int cpufreq_boost_trigger_state(int state=
)
> >               if (ret)
> >                       goto err_reset_state;
> >       }
> > +
> > +     if (ret)
> > +             goto err_reset_state;
> > +
> >       cpus_read_unlock();
> >
> >       return 0;

