Return-Path: <linux-pm+bounces-35464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ADCBA3B31
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 14:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273313B0297
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF1F2EAD18;
	Fri, 26 Sep 2025 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KgVB4PFY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077BA29B214
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891142; cv=none; b=UfEkhtmhLVo6XefJgaySgB+jJinOCS+VE1mIIvxdFxGG8aOmB5vOcjSNFv+UbbWZf+ADJ5T9SbALweMOMe9sz1IsFL24y+7czr+eavhG7mh13+nwSjSZ3CUx++qiD2yYa0InuPHm1+LHP0gp/WepDKu4StpTrOPw2MFq+xS930A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891142; c=relaxed/simple;
	bh=NrPTGUoLWdQsj2LPuD42yQfi3Grjh00Qivq8Q3RDB2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjTtuCBThJhLijx4iRzeJWIG7HJOToTFzo8kIGet5moXyyrSfSKaPTxwHKsoimED/JESphPPvXZGLafzVRWY/Y9Qf1jyOzCVyqlEabhddtAXOXlJkF3IP4O6YFOOZAdlVWPPFRhuYqdLZf9wxOkSzBiOnO1MQ6xSwUBfHTWh+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KgVB4PFY; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6353ff1a78dso1434369d50.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 05:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758891140; x=1759495940; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oeq95/+JFRlc8XyWn/nswZYQ27eu4+ApswNk/R1twrM=;
        b=KgVB4PFYIFe9nPm9V+YdYHN77n91R8WQ7jFBY0Zmudw/Qn2pTMpGQG6K5jnUIkqojU
         TrxtExscXuyZHkf/VG1S+4iSiUQWCOTeGm5ZED9w65rliY5q7qZTHMohSMmzRSEAYma1
         CQXiRcvYfckoKdPOUrFZwAy0AJv9lnbGf2klaExScc338ByqnH+/7LRAfuFBLTlERhl9
         O9J4M+fdnd0rMKJ2Lsr/+IqsJ/YqJkKsVvxrjG1no5eScUWnMwiT5EQ062f8ri+6akcw
         0lA+A0U/9ucSCU2/1eGbp+1zuu2KghX9n8H09dZsSQnngGBwZ9ttETBC9QrKEeKN6qE0
         Xlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758891140; x=1759495940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeq95/+JFRlc8XyWn/nswZYQ27eu4+ApswNk/R1twrM=;
        b=s0jetWvqc15AtBJyMFUfjfxz06XCNPbr9v7fc478ILBMdZzlGHE8aE6Xxj8JXUsO5M
         ZNtnMFm7WcqyZcMCfm34vtwpdYfq1c6ubHXsVrHXa/pc6euM5KIWykZJ9mQXV7Q2if0C
         OxnsFHL6E2IMuUrtczjBFAPKzhGLkcFMEURXl1anORW4OGNtKEYvblHJpKR9VTcl8S/x
         cHCroVVMMiHZ1u3xoheRyJLBdw6Gj433KXmMwGv5t1I1uq4NIHPSxb1CsySiGSOlsPTQ
         8uc+3gpAGl/AF/PQXpIZsxCUd6Tkt37THse/pR+AI/1P6pDUfYOeVnHBT3pzU7NSegVS
         ye9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUdh1AmSvD/lCODlb+jtijvvRU5K/AuDvJmp05uAC1AxM5bFZ4b85QiqW6NHP4V/xcUN81hkfHtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg1GqgWsnIuiSGTvcmexGdQhn9XKw4w5QpNBx1RXIHLnFAeSDa
	HD8AxqowjbiE29zkqp4++KwSqrMYovOi3R7wYBmiaIg58bgGcUou4/9wbnaAlFTBRCBqtsizwmK
	qt/MkBSz9gDxgdd5LIQcv+Qe44psS1CK77QSs2Ayakw==
X-Gm-Gg: ASbGnctuqu8OSQ4Eng0YZgR66gCZs8bKwSHtdpXmSdxVW3Od9I+UHrqpgkTtihlx596
	VrrSTpldyvZvKDeAHjoGJCHJ8v4YKl0KfivELlYb4d1x9ENd3k+ncXk6cfdqrxobbPGSrb6ZRe+
	QYcAKypj6/I+z8nMbcIuCXvjFihBIerp91vHzu8rge3svrIvuAoYln1rFaJNI3AJcf1xDCxGzGI
	+SxFTNg
X-Google-Smtp-Source: AGHT+IFbegjMBskXETWZWAHtZmLSq0HPSiddGUE92rJmk6oAyCGRgWRczPzi/diLvmOjt/dbfSTu3Ew31MNwwvilOAo=
X-Received: by 2002:a05:690e:144c:b0:635:4ecd:75a0 with SMTP id
 956f58d0204a3-6361a89a815mr5888996d50.46.1758891139937; Fri, 26 Sep 2025
 05:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNYQkVuVpP3Daq7x@stanley.mountain>
In-Reply-To: <aNYQkVuVpP3Daq7x@stanley.mountain>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 26 Sep 2025 14:51:43 +0200
X-Gm-Features: AS18NWAJ6VxhUJBeyo9x7sMCxxohCMAJ5raPfUmiVSZRv8RZbBNqJRlbPHJDbI0
Message-ID: <CAPDyKFq7mwW7ys6_1wnhf+BYBeDcsxgcL5HxGhnpxv1vMO2qaA@mail.gmail.com>
Subject: Re: [PATCH next] pmdomain: thead: Fix error pointer vs NULL bug in th1520_pd_reboot_init()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Icenowy Zheng <uwu@icenowy.me>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 06:03, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The devm_auxiliary_device_create() returns NULL on error.  It never
> returns error pointers.  Using PTR_ERR_OR_ZERO() here means the function
> always returns success.  Replace the PTR_ERR_OR_ZERO() call check with
> a NULL check.
>
> Fixes: 64581f41f4c4 ("pmdomain: thead: create auxiliary device for rebooting")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/pmdomain/thead/th1520-pm-domains.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
> index 5213994101a5..d7cb9633c7c8 100644
> --- a/drivers/pmdomain/thead/th1520-pm-domains.c
> +++ b/drivers/pmdomain/thead/th1520-pm-domains.c
> @@ -179,8 +179,10 @@ static int th1520_pd_reboot_init(struct device *dev,
>         struct auxiliary_device *adev;
>
>         adev = devm_auxiliary_device_create(dev, "reboot", aon_chan);
> +       if (!adev)
> +               return -ENODEV;
>
> -       return PTR_ERR_OR_ZERO(adev);
> +       return 0;
>  }
>
>  static int th1520_pd_probe(struct platform_device *pdev)
> --
> 2.51.0
>

