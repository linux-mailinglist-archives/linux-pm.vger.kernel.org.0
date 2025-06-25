Return-Path: <linux-pm+bounces-29531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62390AE8E4E
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 21:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B71F3A34C3
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 19:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85BF2DAFA8;
	Wed, 25 Jun 2025 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fLpnq0jh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43882BF01C
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878907; cv=none; b=Qd0vOMhDgsRsuSqfeKhRl3a5mAIWh8AT4miBiGc238MObIStOF8oeWO2dMO3fc7nAvG0mFnX4LD8zQllGgI2b6ghGsTiVMSGZw8zJfB2cV+fJPysJUg/eubUDlP+y+WTvAm+Rh1fpckFUUfoNPQ/F9uU/YMRQdfzQGl2Bk8idlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878907; c=relaxed/simple;
	bh=ZovO7nkOrLL9nxNDPkAositSdpf1H/zY80uV73Q8ZrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rs5MHmD8Lc6pc8jmnBMiD5ZRpnJ5ejxAUvpD+7DyDbTI98IlOlCnhVRbO/CfoqjcGPxfG0qjVRX/W8lD2Cr9Tj9KkfpnYyhNQYSqtyJR/fzaphidb10i9/mmHmPZVfgHIAQT3F/Esu8CKL8Q1eU9RT4gcFsFhByH81QlqjEXTQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fLpnq0jh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-553d52cb80dso340053e87.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750878904; x=1751483704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+nO7EW7s/VWpRpXMmnbCZRaJqIoHvIZE+sg3t4NDGI=;
        b=fLpnq0jhBTUamh1+q29Gn67BH6xXxBTITB4Nl0+VAeH1Wok6gSKFqJ/pZOmjhnqcch
         vBQb67m9FqdpsMJrpYGsYrxPlSTu2VJ2lCXHuS77uH+oj+icHS5FKI5wDL/P8AJEoG94
         WWhMh50ATqDziJ0L37/cj40nzj9FWgyGn7pUNA0DLSO99VCSezCvgkGOxcr5z5MWRu3L
         RbZFU5SGo5bqyNISRsn4VJBN9hfr5zuWX0hcg4gADRcu76YdEz7QuoNsSIeXY/27SHWn
         FQeLnSSFvR+azacn676//wnbO723oskygb9BpImAQEf97nQx0LG3qMfvmxOg+rGzYoLc
         9Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750878904; x=1751483704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+nO7EW7s/VWpRpXMmnbCZRaJqIoHvIZE+sg3t4NDGI=;
        b=JDl371EFChsL8adSdpu7u5oh3ynTi0iSWvsn6d9URmDTV0ZgV6V8qZSSTBZDYfWTnr
         AX447OsAQWkggT7r4dgHnO9PzR2B1scpTnn0eIscE92mABc1GwgjDyfhquXaTjBfxoka
         zr8WwN8lg3ae8GDjXeh9oPS8NwolVFRx+r2sUTh5M1hALjjaHC8M7Oy/myTHocemrV6p
         7UJz4TVNq86QdvOWnQ2bFp0WIEiWuhs6LGW6DPtd6HMTlzeT8TKJexQWHvrrbk3vsd9d
         u0gbY+3swbZpbdj8k2jJfOaJiXO7/gX5pMBzND12Ly9z8ng3e0WdX9Yig9UBmbJzRGk/
         PV1A==
X-Forwarded-Encrypted: i=1; AJvYcCVSGMXQJ5Og3FZrq092b/kr//bpLryl+IyTVWSnRDPfqIexv0OF3nA/amvS2KoHr9KisNbBjwtAPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy44U4SqjyqwKOf4kH1ALpeJqzDu5hOj4Fy1+09tLS7BEisf5aT
	OtW2gzTmB7ed8aCFsFi4/smhHu12rPQMRiWL4yJ8Fk755QratodCu31CQSeZA5ui4iwItIXIh8c
	z4O51Pc7ffi1Ir0VeJOSGoxwZ7L9ANVnIYMNcAbOEDw==
X-Gm-Gg: ASbGncsMgS+EIVg1PedKFxHa8m9M4eTkKoqpiScfEeQhObUk21PW782uXH/kvW9Pq5p
	i9nH8c5l9Ztn0xSHhfwTUsoG0LkaRVP+lAbV+1t2Z41HQxfJy1V8j2PVGJ4qtCZK2J702gR9ehs
	a5+rePGjEB9yicPJCk2ZMuyap4NIWRsTeRiVmEJRdsS2Q3t4GSuVG/gdRyJfj3XiRM6+gkl1bZh
	u8=
X-Google-Smtp-Source: AGHT+IHiy8uQHEJstlc44iLzXYCv+/voqeXmoVlZJZj8RwfXYP5wtTyCCwGrLUkGxOoxzeeSzpmhiDT6FCJq3MOd9Vs=
X-Received: by 2002:a05:6512:3b97:b0:550:d4fc:a0d with SMTP id
 2adb3069b0e04-55502caae30mr266969e87.24.1750878903790; Wed, 25 Jun 2025
 12:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625-topic-wcn6855_pwrseq-v1-1-cfb96d599ff8@oss.qualcomm.com>
In-Reply-To: <20250625-topic-wcn6855_pwrseq-v1-1-cfb96d599ff8@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 25 Jun 2025 21:14:52 +0200
X-Gm-Features: Ac12FXydmvIBgtZ0Bi7QXSKV1DZmvRjRc8QGW87jPOBPQsfn7d_l6wCJbPac4qE
Message-ID: <CAMRc=MeUU842TVDsPNn_Wcy8KtCQ_nz0qYt+muQJEn87g0kS+g@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: qcom-wcn: Fix bluetooth-wifi copypasta
 for WCN6855
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 5:55=E2=80=AFPM Konrad Dybcio <konradybcio@kernel.o=
rg> wrote:
>
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Prevent a name conflict (which is surprisingly not caught by the
> framework).
>
> Fixes: bd4c8bafcf50 ("power: sequencing: qcom-wcn: improve support for wc=
n6855")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/s=
equencing/pwrseq-qcom-wcn.c
> index e8f5030f2639a69254ad5efe0a313d2f3d10fa1d..7d8d6b3407495c28a780d5bb0=
668b2b35837b48a 100644
> --- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
> +++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> @@ -155,7 +155,7 @@ static const struct pwrseq_unit_data pwrseq_qcom_wcn_=
bt_unit_data =3D {
>  };
>
>  static const struct pwrseq_unit_data pwrseq_qcom_wcn6855_bt_unit_data =
=3D {
> -       .name =3D "wlan-enable",
> +       .name =3D "bluetooth-enable",
>         .deps =3D pwrseq_qcom_wcn6855_unit_deps,
>         .enable =3D pwrseq_qcom_wcn_bt_enable,
>         .disable =3D pwrseq_qcom_wcn_bt_disable,
>
> ---

Thanks for the catch. Unlike target names, the unit names are mostly
for human convenience. That's why it didn't really break anything. If
you have no objections, I will queue it for v6.17 as I have already a
bunch of changes queued up and there's no point bothering Torvalds
with a one-liner that's not urgent.

Bartosz

