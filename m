Return-Path: <linux-pm+bounces-17101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F1B9C030B
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 11:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D1AEB20F88
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 10:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFC11E32DC;
	Thu,  7 Nov 2024 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+YK2QK3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0415A1D932F;
	Thu,  7 Nov 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977128; cv=none; b=Ok7h1NJm5JVmWEW+NOIFZZO6jcwvv8enhqBetkq3gCc+MJ8TgyIFqgGEl7upX902bwACv63e0qAYQ4YkfCYo/sUqVy5clS0qaCH0c1MMQI5vqza3qD43OUiJZvq+arXPtEiv/rqUzvC7f5aS6ivoHZ1OfQ7DyujSurn0TJnGWu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977128; c=relaxed/simple;
	bh=FvXI9LhKQeUyEplKY3xQXpUbOHKklovDwuvsPa0FIdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWOzJkeIN7k2mYSS3Zt+QZbEv6ZKPH8tDBcGV30zKts4MOhuDe6/EsUUvCa5HFOCPcGc/9q5z+zQDWQ/HkZG3ryYREHrFcfTheFxi9fcQp7oSbBzdabB/SO84XhxgfHT1IN/aexcmvvz9VbVTG7soVfumubFx3FjxRudPdFclt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+YK2QK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E57C4CED2;
	Thu,  7 Nov 2024 10:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730977127;
	bh=FvXI9LhKQeUyEplKY3xQXpUbOHKklovDwuvsPa0FIdI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D+YK2QK3bY9HMIGw7PP0W+FGdYOIyfbBhL+0ZUX2Uwb3cCnnVr6JKe3h51E+RfpXy
	 cbAr7jN2qdrCy8yppAxovWKtk4pTu7aT/iu67eB6+dlXr0J4dbWMyugPo+qAzRkxjx
	 FnuwV3DGweob7c7INN6/eW8aTBM15hdorcOUOV3jaqXu4mVHI910Aibx5t44XehpT4
	 7EYwuPFJ0JGN1rv8/ogM3QXGKTGB7X0IgdjTkSulsBILJ7MclSvBuUtOFYuh5ETlnO
	 lhlBbokNCT0KvPZ7xW6wyxpibDIId39j0iTXOd8R7/byF1HDrb+R41Vu9yCuEQLWbw
	 ufIEu9kn8U3fQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-290d8d5332cso428415fac.2;
        Thu, 07 Nov 2024 02:58:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHW2Hf9IXHAzmh4qrOu0IBJtzf3roErtMFINdjjy8OiXjM+PQtQACw+YCkY/550iobqPUs5ihg7b0=@vger.kernel.org, AJvYcCUjkUmcUuTm9CNqmxOdbH0g6pdoRQzrwpfDmQ3aBr6bcwqcrj3YJlbRV8d7PsrvsJig+0iAr7kywZgqXCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp/fy1mowBeX8QkwmCO2pT2keHIGprMLGd/mQNHFVsorRD0nb9
	kzhLqVZ99eZavSrBUXny1xhqWaxgn62nCHXyPF4fqs2fez0eYi/R7yoxS56sW8VJdWqrbJbfV8w
	nDc1EcEvN2yRS9RiMWJRiMmHdx+I=
X-Google-Smtp-Source: AGHT+IGaFG/lGWoIgTdUCj6fF06/lKof9rgBxrGEdVjSBcAfxC5ZYl2aCRdvEnk/gXTBVlwbjmLcKxom0jCcxDGADBs=
X-Received: by 2002:a05:6870:780e:b0:288:5c55:dfd5 with SMTP id
 586e51a60fabf-2949effac51mr24463758fac.31.1730977126802; Thu, 07 Nov 2024
 02:58:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104113615.1397410-1-ruanjinjie@huawei.com> <786c90d1-29e7-72a7-acc6-394b3bbaeb75@huawei.com>
In-Reply-To: <786c90d1-29e7-72a7-acc6-394b3bbaeb75@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 7 Nov 2024 11:58:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jC9_03euACrmahnDRBgU=0O60p0rkChR2BVOxx0J2Pzw@mail.gmail.com>
Message-ID: <CAJZ5v0jC9_03euACrmahnDRBgU=0O60p0rkChR2BVOxx0J2Pzw@mail.gmail.com>
Subject: Re: [PATCH v2] PM: EM: Fix wrong return value in mtk_cpufreq_get_cpu_power()
To: Jinjie Ruan <ruanjinjie@huawei.com>, viresh.kumar@linaro.org
Cc: rafael@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, hector.yuan@mediatek.com, 
	lukasz.luba@arm.com, qperret@google.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 2:50=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com> =
wrote:
>
>
>
> On 2024/11/4 19:36, Jinjie Ruan wrote:
> > mtk_cpufreq_get_cpu_power() return 0 if the policy is NULL. Then in
> > em_create_perf_table(), the later zero check for power is not invalid
> > as power is uninitialized. As Lukasz suggested, it must return -EINVAL =
when
> > the 'policy' is not found. So return -EINVAL to fix it.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 4855e26bcf4d ("cpufreq: mediatek-hw: Add support for CPUFREQ HW"=
)
> > Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>
> Hi, could this be merged.

It's for Viresh to take care of and please replace the "PM: EM:"
prefix in the subject with the proper cpufreq driver one.

Thanks!

> > ---
> > v2:
> > - Fix the driver instead of em_create_perf_table() as suggested.
> > - Update the commit message.
> > - Add Suggested-by.
> > ---
> >  drivers/cpufreq/mediatek-cpufreq-hw.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/me=
diatek-cpufreq-hw.c
> > index 8925e096d5b9..aeb5e6304542 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> > @@ -62,7 +62,7 @@ mtk_cpufreq_get_cpu_power(struct device *cpu_dev, uns=
igned long *uW,
> >
> >       policy =3D cpufreq_cpu_get_raw(cpu_dev->id);
> >       if (!policy)
> > -             return 0;
> > +             return -EINVAL;
> >
> >       data =3D policy->driver_data;
> >

