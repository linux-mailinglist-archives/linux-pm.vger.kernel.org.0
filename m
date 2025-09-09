Return-Path: <linux-pm+bounces-34230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6753EB4A932
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 12:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E3C188ABBA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A382C026F;
	Tue,  9 Sep 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GC/z7LbL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D642D23B6
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411881; cv=none; b=lFmWyQ2EFLR7YeFtU89XTNUZE8ZdvGIT5IrWnN3gy4He62FlYqOOSqUdV74PHIoO0ztTFY+DCxb4z3EZrbWcDb6F0DL0aEJNfiHf5tqWpjUhOLw1q8L9RHdzb0RmSFPP0iLN+ObjyA0II5MhMZyZG/TOxs/O0jQntMfDft9Qj5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411881; c=relaxed/simple;
	bh=vLeBSs9UlsM0Nvan6ljMar45tgpAptKGKo+XZ+E4kHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TD1hpGKRsQbmjYT4ZnEHJM964tA4bYccaLVDSKAXnhaMYLe+8+YPxjezoCGWwKuxHPdzRgg0Ysm716hRREl+AUXpwIQnR3WzYrXdpMyqjwKqLVedqiYn2HGn9sV2tx7dxiyfGJCQuUtSLvVi6EBBSiyBfuQrvaK6+zKTykITqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GC/z7LbL; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-336c79c89daso48813331fa.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 02:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757411877; x=1758016677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9Q/SBeaavLyqr+XPkX2WQCCkix4ESkAOHpRDrEhCu8=;
        b=GC/z7LbLUcb/5BJUCveJOtkVK3zmvVB5lRtoPtgATPl0naLYuXllIWPx648j2j2Z2e
         HMA0AfjxfkufcZiOV0Ql5aNw6Eyq0E7qPW/RQEH4Zkp9D1PsBvPnGET9QScRMgM/ix+H
         QJQo65Eezf4ESRf9oZwtG3KZVYgtaxL53cCmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757411877; x=1758016677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9Q/SBeaavLyqr+XPkX2WQCCkix4ESkAOHpRDrEhCu8=;
        b=jfd4ZyhYsPCcORKFgG5SfBuVOfF5R0eAJ86EVxh5angbzlqaUxAL+mYwOfCcF8a/n7
         CmDQ+qIPdOIMl1LbrtQKuW8idT/YjlnxhYlNwEpgnXUivnzZAOxtUFizoTJv9ZaC+z4j
         4aVFG5Fyd2d61Meqq6w0A93OwHtAVBL2lhDhZZVea6gAP0s+yNDYgtWALyQaJHaM7ZLB
         OsfvljJOalGAzm2ckZKzoh1HzvSon51lu8RJMLelsUcelOvHqLxH0HM6G4UXvx7Y/mz7
         Rarf2xhue7KTwXaeoll4RrAeeoQwHLVAsmMPMqcvIssqPIoaqi+MrntCV7vtR9FbTCGn
         mHDw==
X-Forwarded-Encrypted: i=1; AJvYcCXAf47Fn9WKpm+cdwandVuIQ5ML3S77yEKiDyCogxKb/e2iYL5BDeT9aYohbvytWaUywbs3w4IwzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0kBNF6QOWbQBGX/3EZqiugdtRNJLZfKjD2rihGAecxBrapgMv
	HIlj17jlq9pr/02IZdSvosgfvvUNkqf8VUQNWNBCxBMdZY8kl63ddwtYcXS/Dc0xMQUcripeqiQ
	NymjND6yl6UZnIWKFzloXVDxlJz0S6cdURKzmqCVo
X-Gm-Gg: ASbGncuBO+cp3kkQEaRcPFC//kZ0R2gGEN7oarb6p6cqsQI7Y9RLHbMjC8nTkNaPQD0
	0en4qmKqVKTnQwPw/BM7ZcCG4M+JPPiY24J7yL5ZvCWZJ6cafdrau149OclsCK9jtUDY8IvCIdZ
	CgrUcqfwByFxsrAjG0bN6r39RUvGZ3+86SCOt/uH5l2NEN4SOlTDDPEGBLB3cDR8zBM2/vmFBVm
	raOQZud6/CPzAr5x6lXEdLzufPM4/8HyFz4fHy5V3zQtsQQ
X-Google-Smtp-Source: AGHT+IHtBPyRAgJpbhrMNhQvYhuKCwVHTEcLjpAEXVvG2Qe+VaW+WbYg4882F6R1NtG5see0MuJ+hLu/7q6vsaofizo=
X-Received: by 2002:a05:651c:50f:b0:336:e05c:e3d4 with SMTP id
 38308e7fff4ca-33b5e8f6aedmr36499581fa.23.1757411877143; Tue, 09 Sep 2025
 02:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909073819.25295-1-johan@kernel.org>
In-Reply-To: <20250909073819.25295-1-johan@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 9 Sep 2025 17:57:45 +0800
X-Gm-Features: Ac12FXySeIcZbJr55CfFDecjeH7ZG6WTjgfFt9EkkcubagtMiSJ1iQX0YbRtXW8
Message-ID: <CAGXv+5EcnLJHG_50mYb2YB0_q1XOztF84c9tAJJfKZxSCWuUCQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: mediatek: fix device leak on probe failure
To: Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Jia-Wei Chang <jia-wei.chang@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 5:40=E2=80=AFPM Johan Hovold <johan@kernel.org> wrot=
e:
>
> Make sure to drop the reference to the cci device taken by
> of_find_device_by_node() on probe failure (e.g. probe deferral).
>
> Fixes: 0daa47325bae ("cpufreq: mediatek: Link CCI device to CPU")
> Cc: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Cc: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediate=
k-cpufreq.c
> index f3f02c4b6888..21537a05785d 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -404,9 +404,11 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvf=
s_info *info, int cpu)
>         }
>
>         info->cpu_clk =3D clk_get(cpu_dev, "cpu");
> -       if (IS_ERR(info->cpu_clk))
> -               return dev_err_probe(cpu_dev, PTR_ERR(info->cpu_clk),
> -                                    "cpu%d: failed to get cpu clk\n", cp=
u);
> +       if (IS_ERR(info->cpu_clk)) {
> +               ret =3D PTR_ERR(info->cpu_clk);
> +               dev_err_probe(cpu_dev, ret, "cpu%d: failed to get cpu clk=
\n", cpu);
> +               goto out_put_cci_dev;
> +       }
>
>         info->inter_clk =3D clk_get(cpu_dev, "intermediate");
>         if (IS_ERR(info->inter_clk)) {
> @@ -552,6 +554,10 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvf=
s_info *info, int cpu)
>  out_free_mux_clock:
>         clk_put(info->cpu_clk);
>
> +out_put_cci_dev:
> +       if (info->soc_data->ccifreq_supported)
> +               put_device(info->cci_dev);

put_device() has a check for NULL, so the if isn't really needed.

Either way,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> +
>         return ret;
>  }
>
> @@ -569,6 +575,8 @@ static void mtk_cpu_dvfs_info_release(struct mtk_cpu_=
dvfs_info *info)
>         clk_put(info->inter_clk);
>         dev_pm_opp_of_cpumask_remove_table(&info->cpus);
>         dev_pm_opp_unregister_notifier(info->cpu_dev, &info->opp_nb);
> +       if (info->soc_data->ccifreq_supported)
> +               put_device(info->cci_dev);
>  }
>
>  static int mtk_cpufreq_init(struct cpufreq_policy *policy)
> --
> 2.49.1
>
>

