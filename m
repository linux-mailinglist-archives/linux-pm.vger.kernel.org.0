Return-Path: <linux-pm+bounces-27467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFC3ABFDC5
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 22:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD9B9E4A0B
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 20:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A94528F945;
	Wed, 21 May 2025 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCBlyJzP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3E280CE3;
	Wed, 21 May 2025 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747858855; cv=none; b=M82Rh2CAm3lhjFUIYbivG3yRenQvpF+tni6FHTk3GeRtjKvX8Y8PLt+amuZ+VTW34hHcTmuCgBB908UlO/Bo/X4ajtHfPzYMTgEOvjigS8ruRP0+Txeqgk4vNAJEN5jRZAFvm4HqDvDRoMWQJcC06bm2MSD9dPZxBZvmW9mK5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747858855; c=relaxed/simple;
	bh=qZtAJsOAdcfa7hXX7PvJtBfXv8Uq0T9+N3VVswvcZRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETB58o8+9RQ0Tpt0sKrRF4NRiyKnbx3ZoFZwA32tF/I0kYBeq+kkCTNplkH/Fb2yuRl2cO6RTdB8W0tIvbsTDkSZHrkC/yx7qO2VCBgMtuEfRPsk2NuiNNf7pJ+BKC2VKbhdw4Jro3/B++YYkkEb+w3Q2sbDOZGQh2IjpIllaZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCBlyJzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DDCC4CEEF;
	Wed, 21 May 2025 20:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747858854;
	bh=qZtAJsOAdcfa7hXX7PvJtBfXv8Uq0T9+N3VVswvcZRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YCBlyJzPyzczgiGAkQt/dcreOgYTrdJkswAfXvf3/1YIwZ3MQXqUD5mU31KR4523Q
	 fIyYArF9tqB5pjlSwTMp8TUcktJqFHNReCQtVzo230fK1JilknqOEfLnRUJmEGagks
	 BZkIlDPn98Yjd34LMzP5/FLlnojCqVMG5oCNvr2+LVej01e9Bleolf2jZyV4dJ8qvY
	 J2B6E6EsLT0fMM+VDEnqomwWBx7AU3Wz5CEOarDE00AJ2V5szPYyFi/k5pWWY2dj85
	 y3RKimZlAF1FzO8DuJKmCPo8DkOH8BrsjFjWbX1R1CkAzuBmQU2hb0anxG+rcGlqCa
	 DXLRCP3BcFBpA==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-606668f8d51so4824528eaf.0;
        Wed, 21 May 2025 13:20:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5FxUpyHFqTSm5qz5ZJkB582cpUa0WxlZqm3/gqY1o0CoY5EgE1RD/YD3tOO0W2dX48pZl1XQFHealRNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzHqG7F97qXxzhvn7aS3At7zFHkSKAV1+NbqyljcbxeMvuEcPx
	l5+KDeZJBFjFSvyRAV3urLUeJidwXwdIfTVpErmf/6wrVDfct9vS9r9on9tVJHEKePYodKAIuyU
	Y9QZvQyFQQmJEuQnh+S8nrzdB0Z0Ny8Q=
X-Google-Smtp-Source: AGHT+IE2VdnJQ4AnnakgoFUvelTUgOXmSTDuL5jgaHAFtXgVXMeo4WKhzUiW39HRwx4lsboi6m6qeB65lwnhbuEqo+o=
X-Received: by 2002:a05:6820:4a14:b0:60b:7d88:8dfe with SMTP id
 006d021491bc7-60b7d889dfdmr2722669eaf.3.1747858854183; Wed, 21 May 2025
 13:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519070908.930879-1-yubowen8@huawei.com> <20250519100252.wme2gfdvl752efe2@vireshk-i7>
In-Reply-To: <20250519100252.wme2gfdvl752efe2@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 May 2025 22:20:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0haaPh7E15mN-mFuA4tktwWh0eC2AZBzf3_3BTbSz833g@mail.gmail.com>
X-Gm-Features: AX0GCFvXZ0pVn3JGYaHQ4lNduI__HvCXlL0iB4JN65cLedyq3Lgsbtm9GoRYU3A
Message-ID: <CAJZ5v0haaPh7E15mN-mFuA4tktwWh0eC2AZBzf3_3BTbSz833g@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Replace magic number
To: Viresh Kumar <viresh.kumar@linaro.org>, Bowen Yu <yubowen8@huawei.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com, zhanjie9@hisilicon.com, jonathan.cameron@huawei.com, 
	lihuisong@huawei.com, zhenglifeng1@huawei.com, cenxinghai@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 12:02=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 19-05-25, 15:09, Bowen Yu wrote:
> > Setting the length of str_governor with a magic number could cause
> > overflow when max length increases, it is better to use the defined
> > macro in this case.
> >
> > Signed-off-by: Bowen Yu <yubowen8@huawei.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 0c842edd1a76..a3a376f030f0 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -809,7 +809,7 @@ static ssize_t show_scaling_governor(struct cpufreq=
_policy *policy, char *buf)
> >  static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
> >                                       const char *buf, size_t count)
> >  {
> > -     char str_governor[16];
> > +     char str_governor[CPUFREQ_NAME_LEN];
> >       int ret;
> >
> >       ret =3D sscanf(buf, "%15s", str_governor);
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.16 material, thanks!

