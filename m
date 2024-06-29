Return-Path: <linux-pm+bounces-10231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF8B91CAF3
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 06:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFF62848D9
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 04:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B8C1EA91;
	Sat, 29 Jun 2024 04:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHQVdcNN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6061DA53;
	Sat, 29 Jun 2024 04:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719635156; cv=none; b=rhMGvRhe67zTRqrPe5keS+UTD+kQPNp0XLRwLuu6D2y5tNdydXZ1/nmQoQiW2VNRZjx0PEfLJAZ0xMn0KAd9G1auOZ0aRmt57YPjCLcS8hrGgfeShXiXvAhAoMNEl5Z8l+Bh5QDZOhcI6L8LBmfV6wADvXy0hQquL68/XXNVIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719635156; c=relaxed/simple;
	bh=pbUWmzBZxa7d97eWO0V0lrZEifzBld3FlFLlGxEXEcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPt6DoCccfdM71lp2qvIXj+PgrCLKArT3fscSm9iXFalIuRplhewxdcVkj+yWg7oBznNJLgAzKrvqJx/BaT4MZPcDPtVtddGA1EYMLty8GwEi21i8rVrcYLvsvXRbW/4SeZ20sx6AxvdBUae4dS1Hoi6A6QRMjIKTJZfbzeuNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHQVdcNN; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5c21ba58227so645800eaf.0;
        Fri, 28 Jun 2024 21:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719635154; x=1720239954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30kxa0Q+gUHVRJCK4oP0++E6pyeV3ESDyAZnq2q+C5o=;
        b=NHQVdcNNbc/e/xktlU6oxlx/Th6rEzy2MMItZGrkidNa6vy4mYJ5xkA7sfq4OAYNHB
         gwU39nTSTQuiJ91boANXaV6AG5I1TC+b7XHX7E3bDTtPKP4f2RHunLNm6BwqbDfiaS3E
         brhrTD6S0L4bXEHIvL8Lycio0jmFzSZN4baVs/ri/h80erjBLsH/kahmY4n53isr6y1I
         +gJRZQv++KwY5NBGMEjyPSwshfqUzn09lGMgrkMlwFmtz0M59T3i0ycCTTvTW6vm8R4/
         WEH7CAcbSUJwwD+LOtWu3QOeSEkwWHtA8O6EwkPreIr8evn4wbJe3aUPqf5c/0YWgy1j
         VI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719635154; x=1720239954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30kxa0Q+gUHVRJCK4oP0++E6pyeV3ESDyAZnq2q+C5o=;
        b=nLXjGtX6D75odboFQTLt85EKCfGi42N2RYVHubO6Y9XGkbGYWHm219XieVxfmdiBU2
         EHaJHYTJ5JEdtyyd/+gfVXLo1/w+bICiLZDV8WAQoo7LOTgE5pvyVmix2XNQOsWLJeIH
         XHgPvdeHur834w6ddXBoazPOi0DdbgaZnOIhkmgq1uyxASCoIiKqf3hjputxObxNxuaq
         GOXUdkvatjkFfMRglL4ol7kyUkjhEH+aUApLDzoLPBDKvVEzzIi0v0dAnUDfOaT3rnY7
         p/0vThwP9LZ1jsa+O6IGOezVuhYjNayp0eD812cw5QE68zfOaT1AX6EBgrJ2UZ+g/McO
         jUdg==
X-Forwarded-Encrypted: i=1; AJvYcCXY5WiaK8T9JnfMj6VuXT9kjbvieF6OCy/VP1T8+IPEoWc2M6SXYHno6+Qxloe8DGrmeGAoUh88dta0o/wFpq+adBPPfZEhDkLAwNiQtathU6egnIsDwVvlGYINUMa/7XJjW+PQhsd0sSXdDs1F60EjYd41oyOEzftO/0XC7udS0B4MTEGwRPVqUg==
X-Gm-Message-State: AOJu0YztXjiQ5QyBMkDTwjmP+BrFk17WtbvCIT7JfY3/r4OFGoDIS2D5
	J9artIyF+G4o3p1VjToMDtW4myXTKn4Rr7IwREAjPSvDCARw0ldDkgMBzE+5YPjBAtTon5A35km
	LyQhrA+F4Mf50qB6U0OEZFeViCpg=
X-Google-Smtp-Source: AGHT+IHTyqC+oWHQSDqh/4MuJ4c4xX2WdLH/YKVOYoC1crgGxMG+PzC2Z4AqXkc0NcLW8CJto3S2vXHr58J93giO4SY=
X-Received: by 2002:a4a:4884:0:b0:5c2:23ee:bc33 with SMTP id
 006d021491bc7-5c439051779mr68928eaf.5.1719635154450; Fri, 28 Jun 2024
 21:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510094034.12493-1-linux.amoon@gmail.com> <CANAwSgTRfEChziyys251-FezSevSq9pxHLJixVCAybJhq5YAqw@mail.gmail.com>
 <15b164aa-601f-4dad-8115-14a715608319@kernel.org>
In-Reply-To: <15b164aa-601f-4dad-8115-14a715608319@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 29 Jun 2024 09:55:37 +0530
Message-ID: <CANAwSgRyZ=43yBxiAmj-+5xL0b9FBkoDeR88BJ8FqDTQX7KVFg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PM / devfreq: exynos: Use Use devm_clk_get_enabled()
 helpers
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chanwoo,

On Wed, 26 Jun 2024 at 20:00, Chanwoo Choi <chanwoo@kernel.org> wrote:
>
> 24. 6. 17. 17:24=EC=97=90 Anand Moon =EC=9D=B4(=EA=B0=80) =EC=93=B4 =EA=
=B8=80:
> > Hi All,
> >
> > On Fri, 10 May 2024 at 15:10, Anand Moon <linux.amoon@gmail.com> wrote:
> >>
> >> The devm_clk_get_enabled() helpers:
> >>     - call devm_clk_get()
> >>     - call clk_prepare_enable() and register what is needed in order t=
o
> >>      call clk_disable_unprepare() when needed, as a managed resource.
> >>
> >> This simplifies the code and avoids the calls to clk_disable_unprepare=
().
> >>
> >> While at it, use dev_err_probe consistently, and use its return value
> >> to return the error code.
> >>
> >> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >
> > Gentle ping?
> >
> > Thanks
> > -Anand
> >
>
> Applied it. Thanks.
> I'm sorry for late reply.
>
Thanks & Regards
-Anand

> --
> Best Regards,
> Samsung Electronics
> Chanwoo Choi
>

