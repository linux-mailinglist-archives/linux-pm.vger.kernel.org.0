Return-Path: <linux-pm+bounces-13040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EEE9629F7
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 16:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21C0284D85
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C139189900;
	Wed, 28 Aug 2024 14:13:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E298218E02A;
	Wed, 28 Aug 2024 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854437; cv=none; b=FLp/+wTxbgWrZnJcgNrDGTjuAEFfEiFzN8q6Ew2pYgGdYDGlkIuffQSSnF7IyKNUGR503o33Hr6lccesA0HX0AtpbysF0E42XGh2coIceoyHTtDvkalexS0bz5Hu7LwNR+1NLi+iUoxDO/08jUaIwy9kCI78YmnqC4DiiDsBJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854437; c=relaxed/simple;
	bh=lQw5IXbIgR7J91Fs5P8TJVg4q3mpXXl2Homce8Cp3Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLws8Ty/3LIgpSMI7yHb9K3aI5SMQ5ccTQEyGfqQyo5Q64xdreWbWjRtvRhj7preLbK8EHmB407GLjhmEbFCH7vIqcC8eMZ9JMt16WMYRfJsTI6hm+SUEwvSFlBdx4QBXBMfrr7sN6FmqTmarSrZEY2Be4vEe2FwUnWqS2J4Y4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53436e04447so708259e87.1;
        Wed, 28 Aug 2024 07:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854432; x=1725459232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfggEhwHyOU2sq8xoB6q7hwwxN+IvnAAtnYfI0ptIPU=;
        b=EK2tXSMQCVflkGcQ+2sQAtl/J2/trvD2AUCaBfgL8pu7BGeTo7BlH36V4kr4qeg+Yt
         gkD9K4pc7BR4EIEhnFIXpDSn7QD8UQ7zx3qI7n6rmAhjOFFHnHDsBnOP8Fh7Ju44putS
         Xt9GOsTOeUYXGm8a1jld10AbWTMD0Wv/CcO+W/3LXzyaiaHgWQ7KayGk+5Apx/GSwe9r
         y4XZ44lrDEVMEFimZl7OZJcuWSG1t3VDL2zgadGXWwVi2rv222fVmQwDauzS8Sj/WGlN
         isHjzr2ndJOM7DTeXS5X/Jl+vUZvfzUQyJBSC2MUBGZB0lOlO3RLY5aDOEFI4X9Wk9zE
         FNVg==
X-Forwarded-Encrypted: i=1; AJvYcCUTyEwjoOjl5lnrVguHL/pOHhC6PVJNdGJ0JkxNBIMRSPwTXs44P8b2g/PsgB0KcVVzwA5enGMZYrs4kyis@vger.kernel.org, AJvYcCUVs5+4i+V6yp/cfNayfIiWLm+KDBgExrnwqqpl6kosXQJ6vwoJpGvG6I5YwtdiRcM9VL76FH8J3qM=@vger.kernel.org, AJvYcCVJ6DIih71RFCRG8oXJWNDpV2hJ5JCq+7MBv6WDQmqt/nhzyJysrFhHgSjPq2h9wb0pCjjR90zAXHBQRIoLDN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKFByun4f2nHKaFNbyBSuSPbaHC4EsPLV9dxO56l0n59l7m/OA
	/axVoIfb5ws3dDkhPFwo8yK2VNQqKzXnefphMM7njDFIqJYTla2oeA1yhg==
X-Google-Smtp-Source: AGHT+IEFiEsRkjyQY12sznbZL9UdZkjyFLeKD2kKWSFTCYTWyWg/zh4C69GCQF7H2Q0l4CF2BVR9pQ==
X-Received: by 2002:a05:6512:2806:b0:52f:cc9e:449d with SMTP id 2adb3069b0e04-5345673d65amr680560e87.3.1724854431598;
        Wed, 28 Aug 2024 07:13:51 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea2a64fsm2187537e87.57.2024.08.28.07.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 07:13:50 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f401b2347dso6937721fa.1;
        Wed, 28 Aug 2024 07:13:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXk03NCi8elueuoMLyvwjgFOSFotaKMU/HWems1MPWdbjmDu8gzQf0lDrIHtS8aoEBlFFLltbps8o=@vger.kernel.org, AJvYcCWhxrI3+Dv3+n9+NI3ddG0ddu+PUvw1SV/jA2CMVxAxax74uHRExbuAawQ9MV5mEyW3UGSut0AdT1bR10LW@vger.kernel.org, AJvYcCWvacXAT1iU9iqlx/5hnV8a7Ef7Tw6yfkMKooUkcx6GcH25hoP2Roa4TyZ/fb+rGzuFqks7ovWbQdxfFGDHdY4=@vger.kernel.org
X-Received: by 2002:a05:651c:546:b0:2ef:1f5e:92be with SMTP id
 38308e7fff4ca-2f5232705c1mr9467481fa.9.1724854430536; Wed, 28 Aug 2024
 07:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828093447.271503-1-colin.i.king@gmail.com>
In-Reply-To: <20240828093447.271503-1-colin.i.king@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 28 Aug 2024 22:13:37 +0800
X-Gmail-Original-Message-ID: <CAGb2v64D9ciU1UPMii9P9yiP4jEjsNH_3SVhaN3XmR85QH3q6Q@mail.gmail.com>
Message-ID: <CAGb2v64D9ciU1UPMii9P9yiP4jEjsNH_3SVhaN3XmR85QH3q6Q@mail.gmail.com>
Subject: Re: [PATCH][next] power: supply: axp20x_usb_power: Fix spelling
 mistake "reqested" -> "requested"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 5:34=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a spelling mistake in a dev_warn message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  drivers/power/supply/axp20x_usb_power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supp=
ly/axp20x_usb_power.c
> index 69fbb5861934..ab45ee6c283c 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -326,7 +326,7 @@ static int axp20x_usb_power_set_input_current_limit(s=
truct axp20x_usb_power *pow
>
>         if (power->max_input_cur && (intval > power->max_input_cur)) {
>                 dev_warn(power->dev,
> -                        "reqested current %d clamped to max current %d\n=
",
> +                        "requested current %d clamped to max current %d\=
n",
>                          intval, power->max_input_cur);
>                 intval =3D power->max_input_cur;
>         }
> --
> 2.39.2
>

