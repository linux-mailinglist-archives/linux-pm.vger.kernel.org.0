Return-Path: <linux-pm+bounces-35765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5670BC0857
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 09:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78EB33BBB19
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 07:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBD2255F57;
	Tue,  7 Oct 2025 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XFPrusBk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F55F25393E
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759823481; cv=none; b=qa7cJ4x6iFqS9W/ptBwg9ldlpuEL6vI2zjW2g4T1j8fnfRmAH5fDYIyrIF2eWN3dmUVcwtjH9roSSyRQb0h18tY3iTkTBOy8ekXKynJ0woYpLsVM/vs9PWzls+ltmzDAXKXRZCX6OV/DXr8UpRTPa/EmpYgn5WYCpnNM2Z2CKO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759823481; c=relaxed/simple;
	bh=YW33Rk+nnKSgtJ/tN28wpQI04VHAiH52dyQW3hzpb1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTI7O6giLboT4iBo7ENTvGAaK35qHfbW+7JfO7sbzjrc4CE5QzX93WvMoKETS1pSbPOdKFhK3DbTAfscIWNYji13FnO2KBUGsfZNLNlEy+Fu0/14rIED+eO72yEX2L8OwVozjm6awKxsgFQUyI6jtvxGkjYZ9m5iI8vCAezN+38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XFPrusBk; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-78f75b0a058so61750336d6.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Oct 2025 00:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759823479; x=1760428279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60IeKMHui+PjqfYpDC5iEMtORllnqEY6yjxQ6KcN6RM=;
        b=XFPrusBkRX40AQmrb4yw/CO62MmFcn9EYqykLzDn1fUztuTY0FluDi93fvPt1kL/2I
         EHDE6G3KWYHAk+UFxf4qJYJG8h5sgbxOQ3GIqi2h2xumXLVaDSk/qVJUy7cjFEUSFUUy
         uIrlz99UxKfr7z8rjNrv6Hb9EIhictj7CAC3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759823479; x=1760428279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60IeKMHui+PjqfYpDC5iEMtORllnqEY6yjxQ6KcN6RM=;
        b=pORhElJjq1gZnhsZOwaSBtys5zKECW00XwJ6JPMlN7BOp4Tc8u0Rb+aTsvhNrwuoOx
         scytjVo5qX81W4v47pPOL8mBq/7w6AM25wCJ1bbII841ihsJfXT3XLcNb8NONmLwWXSD
         d61hnJwXQjrNs/ktNP/uyghkpyky8eQkchVXc+tCn2uVRVp3RhROSVfoT2iUDJXbgaXo
         g0uFHWtQrgsBrF8z1l5AnCCf2CZcJgAO9m9sokFH/c5fGAaFOhwg2yHcdidlZqzglap4
         U2SETCyn1TckkJmjyrDYNshOg1xbgw1SVRXqfPWcywb6NzeAcYGhWeSarbJCycY4tllr
         FXXA==
X-Forwarded-Encrypted: i=1; AJvYcCUy9POcnKX/moHis39S8NqgCBvoMMPRhXAzqRvvjR3ep8Z2etGPY1hNtg/gEkWMRyQz5vX0y9bvQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0JTvA3axyFS2rUNK/lNsmpZTM9spopxvrDP3aNYxVxpJtFCnZ
	IWQ5IZU944uIT8wSz6QL5mWdiQBaagEJqYGR+9rfD0UfFqNQGqwCtuf15WMhqTOg8CmG9UAz6Wq
	yrMuCfw==
X-Gm-Gg: ASbGncs5Oj8Twg+aG9Lo+Ze6p5Z9PiN8tcdCnVggym/M7aowmuZ7wCXOOxrWw13p+hG
	2hZ9zSjz2lt+qKwFMK9X/6Q+otwZUv4e8iVqsK3N8Q/Nxpo+TcH6aWg4ETnjas5BxWBF5m98ZFb
	S/ejtkRuPiqZVHjcnANXHDJT9SHdMh2WvUo9Nr0y/LLq8jcbM2pu4mDQ8XdYjXHClJL68SqdPrZ
	+xXIJAdMEsXzfFj8Rri/2Z9spyymBJduRoNg/2zOaDL7N3cOcPbx4nms4nYCpFuvUVtH3KEn05F
	XX+1MyNCLusUOHC7UTmJwQ6qXIdQXkls2fah5boJkE9W1sMkNVs13Nx5PCRcbOFJXxO1Bl3pCHf
	eoekkx6B3F9CVZCrwIsYozyF2+9BVOmQRskZ1/klNNxtYG726Z0ECdPcGvDNv/zha+UTJHJK6xR
	fI4jO4bvcIgQ==
X-Google-Smtp-Source: AGHT+IH4n65IfZOXljNHpLQGA+leKuq70SME9vEi3KThYdtrmJClugehQdxjvPEFIrtgTaS0Tn89xw==
X-Received: by 2002:a05:6214:491:b0:726:91d:bdb8 with SMTP id 6a1803df08f44-879dc856529mr205231896d6.55.1759823478528;
        Tue, 07 Oct 2025 00:51:18 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf53343sm139019676d6.54.2025.10.07.00.51.18
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 00:51:18 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e576fef9c6so265521cf.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Oct 2025 00:51:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlu891BIjlM7BqAd0rXBQjFb1zAFi79DCJeagBhv3vXVabcODKiDCh4ywiqKqHkYm7OAgZeq4YDA==@vger.kernel.org
X-Received: by 2002:a05:622a:112:b0:4e5:7827:9c83 with SMTP id
 d75a77b69052e-4e6e01d5960mr3804511cf.3.1759823477313; Tue, 07 Oct 2025
 00:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007063551.3147937-1-senozhatsky@chromium.org>
In-Reply-To: <20251007063551.3147937-1-senozhatsky@chromium.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 7 Oct 2025 16:50:58 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DxxPTH08MJGKzaDkgzcChArvN6pEQtmX63zytKn0C58w@mail.gmail.com>
X-Gm-Features: AS18NWAReY2sfeJP1qf_JcUDg1z5QtaCqURfL8VBeE5DMUAU_66L911L0sT9YhI
Message-ID: <CAAFQd5DxxPTH08MJGKzaDkgzcChArvN6pEQtmX63zytKn0C58w@mail.gmail.com>
Subject: Re: [PATCHv2] PM: dpm: add module param to backtrace all CPUs
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 3:36=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Add dpm_watchdog_all_cpu_backtrace module parameter which
> controls all CPU backtrace dump before DPM panics the system.
> This is expected to help understanding what might have caused
> device timeout.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/base/power/main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e83503bdc1fd..7a8807ec9a5d 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -34,6 +34,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/devfreq.h>
>  #include <linux/timer.h>
> +#include <linux/nmi.h>
>
>  #include "../base.h"
>  #include "power.h"
> @@ -515,6 +516,11 @@ struct dpm_watchdog {
>  #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
>         struct dpm_watchdog wd
>
> +static bool __read_mostly dpm_watchdog_all_cpu_backtrace;
> +module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
> +MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
> +                "Backtrace all CPUs on DPM watchdog timeout");
> +
>  /**
>   * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
>   * @t: The timer that PM watchdog depends on.
> @@ -530,8 +536,12 @@ static void dpm_watchdog_handler(struct timer_list *=
t)
>         unsigned int time_left;
>
>         if (wd->fatal) {
> +               unsigned int this_cpu =3D smp_processor_id();
> +
>                 dev_emerg(wd->dev, "**** DPM device timeout ****\n");
>                 show_stack(wd->tsk, NULL, KERN_EMERG);
> +               if (dpm_watchdog_all_cpu_backtrace)
> +                       trigger_allbutcpu_cpu_backtrace(this_cpu);
>                 panic("%s %s: unrecoverable failure\n",
>                         dev_driver_string(wd->dev), dev_name(wd->dev));
>         }
> --
> 2.51.0.618.g983fd99d29-goog
>

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best,
Tomasz

