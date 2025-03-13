Return-Path: <linux-pm+bounces-23976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FB4A5F101
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 11:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D9C17D48E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 10:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CAD1EE013;
	Thu, 13 Mar 2025 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSI3nUBW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA7416BE17;
	Thu, 13 Mar 2025 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862139; cv=none; b=d+3I1YyRDGQwFsf9tZpoBqAgH+CY2wSc4Ct6DkeTkKsjWVN1EcSMxljpPhlfunNfCUW+qerB+8PbHOk+eqHu7H+jzDujTPJchY3zPZe8A3+0XaQh91tWNef4u4mDb5/5TqHFZBScmfnjMdLEzIVctE2exorVwAJtmks1cUOweCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862139; c=relaxed/simple;
	bh=Npgx+feD9B5ju6h0vSLbNEvVLPehQS1oYhr9YCjF7/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5Pv1B0pzo2nujJbHCwpJeGURh1SIcCHf21bcJwVauVrEy9/atrQAuo8SCWGx/neC5uFrljD9I5RZBZjr3VPUKvLuulFnaBnkHZk79LZNU3EC+4WCoVEMi2KwUtMBA4uLAbRbq7ANW+vB7AjZDdmRScMyDOu6q1kFu7upxo8ryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSI3nUBW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac29af3382dso130466366b.2;
        Thu, 13 Mar 2025 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741862136; x=1742466936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UNbbqeHoDPt7k8hD93XF4WARB2PnI7whAsDobeRau8o=;
        b=ZSI3nUBW0KxQVJXsXwckcupNAfSVggqQBYjYxhnYvD7N/z87Cku0ihzwSrl1Npf2ob
         e5nk5103wo/r4rwjj8UHmtbYJX4lIlFEE9cLP5j2ulN4XjPfaWICE3t00O58tr2La/5j
         hUkk2sOVIilEOKbpfv7S7rJIou0LpDhVuvA/6jqON7Fnp/nko9083J5XSJdAxE95d4lo
         DURHGfsSrYtcAIkm4F0qROzPmN9eyza5kZ1ilpzhiAmBb4DVxHfDljeRA0mEmUoHGBy3
         E8WAqr2bQ5E4pE/WyjEpCCeLONOST4Q+WrQAe/d2CwaC7FuHAhwCVPTfd12YBdevYCIp
         4FTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741862136; x=1742466936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNbbqeHoDPt7k8hD93XF4WARB2PnI7whAsDobeRau8o=;
        b=vHBRXog58CFI8k3vaOxmDnc7KIBQaGZdt9p1h9fo+BMF4YbmBGuwXIqAbKZsXz8gUw
         IMGLvzQwtmmYEWiibbHHyPRavzK8dri2hqqIyZ2KIvBJpP/aaqRDaBeo9ks/e7aoQQ8r
         3im/s8NyA5f8l1PhiyGmFXKOIr8S9GGT1YaVJst0qI2HwVso1JewWA2dLBi9xZn0nPqL
         3g23ui5ItSSTNRtq4uzh6MVjIA6Mu1XM1DYwl4zX5eQL672zt7Fuj7EJe3nMH7ENJHFw
         Qm78gNvKuHM1D6aIW8bD+Rotzl3Evk0yKm8qKGcHx6QSQsRbZ48NJ5yF3bVoHvLAzMUZ
         ZQXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9PqC19M6PF94GG9D6Ed9podM14Lf2PM4WYRb9pMs60KrMSb2Hk3LSYNCCHKzPSRlnUwTMaAKJcw86Fh4=@vger.kernel.org, AJvYcCX/rL2b+vAZf+q63hAeyAHKoJ4+jpFskIUA56uUqsEBOeLavKEoyiCsp6BeIL9zEXn9cAww3vnnsYs=@vger.kernel.org, AJvYcCX3brVwidG4whySLPJ3W13LWun2VQxnkr3JEKhsY9EgF7lj4SqYjNoxVxFz2swodYnb1q4IwTwVna6e01gpgXuPxPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjQ8PuwahkuN15WMIc07H7Uwk+UG+wv54haklRwDFK8lMjOThP
	UI0MkTyWj8azPGkEKdASVuiscw/d5Cpa4pWcIHJRw0ZODpWAMA/h55A21zCQENKsFTyEMWgVA7k
	/a8jqpv6pOcIBIjSbzZwUmH2JRf2ziA==
X-Gm-Gg: ASbGncuTDHZYGTy1MwmR8TK3TZ1O3NX2UWsO8gpy5+Fm4vfqMaL7VIxv+/4pZiQCQfj
	yApJKs+TtjkTyx+heh1Ws8IExBqmbNRpeJNV98AFkKOPsXyjnc23H9lBRULOAB9BcIj0hr3tlFy
	BNoZdf1S3D0c445w/odPKmAcbbow==
X-Google-Smtp-Source: AGHT+IGVDv1pE4BCE3Na+yhBb8R0foRSsykxpcDNkCfJpVC2H375ipT8Y9+Iaqn+hyKEC5XYMz497CWVlxAo0aZojpo=
X-Received: by 2002:a17:907:890:b0:abf:768f:9a1f with SMTP id
 a640c23a62f3a-ac252f5ad70mr2132021166b.42.1741862135398; Thu, 13 Mar 2025
 03:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310143450.8276-1-linux.amoon@gmail.com> <20250310143450.8276-5-linux.amoon@gmail.com>
 <25fa661b-98e4-468b-bb4d-4a2c95f32b71@kernel.org> <CANAwSgTeZ83oqatrsWQxT+4RYwEtEqma=R4XX_iGrP2N=phz9Q@mail.gmail.com>
 <43506f83-13d7-46c5-b022-473ac78f0cab@kernel.org>
In-Reply-To: <43506f83-13d7-46c5-b022-473ac78f0cab@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 13 Mar 2025 16:05:18 +0530
X-Gm-Features: AQ5f1JogTFqIfMNUkGXZqHbmGpfdP1dSo4ev8vVzdcAwRmde2Tjv4RErgvCNJmA
Message-ID: <CANAwSgQeE0NQp_xwWcYBgZVQnm1N4PaQbaoMXGyFK4KKWAzxNw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] drivers/thermal/exymos: Use guard notation when
 acquiring mutex
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 13 Mar 2025 at 13:19, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 12/03/2025 15:59, Anand Moon wrote:
> >>
> >>> +          mutex_lock(&_T->lock), mutex_unlock(&_T->lock))
> >>> +
> >>>  /*
> >>>   * TMU treats temperature as a mapped temperature code.
> >>>   * The temperature is converted differently depending on the calibration type.
> >>> @@ -256,7 +260,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
> >>>       unsigned int status;
> >>>       int ret = 0;
> >>>
> >>> -     mutex_lock(&data->lock);
> >>> +     guard(mutex)(&data->lock);
> >>
> >> Which you do not use... Please don't use cleanup.h if you do not know
> >> it. It leads to bugs.
> >>
> > Ok, I will drop this include of cleanup.h.
>
> So the guards as well...
>
Ok I will drop this patch thanks.

> Best regards,
> Krzysztof

Thanks
-Anand

