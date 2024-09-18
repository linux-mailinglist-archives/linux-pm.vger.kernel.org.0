Return-Path: <linux-pm+bounces-14419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFCC97BE5C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 17:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1F31F2251D
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BE11C8FBA;
	Wed, 18 Sep 2024 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u8Dv+xMf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E71C6F72
	for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2024 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671889; cv=none; b=FC45RcEGADgSOoAvlaauG0ica6FWeAhXCLr0FX0Ilc2V9sHLluhV9awd4iIvmqrhJAVqgbEzHmrlIFx3kKC8ciFwpN0PyKxB1nzNWYG9657pFJ6HB7JkIgrpc5CorfgLxLBybLLmvRCx6Iudxv2rTRP0W35RL8eBxzyWIAz9WQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671889; c=relaxed/simple;
	bh=L1NHWyy0NjF2dTP/ARc8BHAy85ATCfvirgTS6lcHILE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCvmT2gAq0m0HHJY87bL3pchtOneRK3OhIKPERXZ44+iM7s9pBx4eXhgbXnFQIYSIOeHvRUntBHvyi5fKesdwSLU7M6vyKJBmDjvGY3Ik6v+Rh75khWDBp7YWl9IXpCY6qrotV73Zrl3oAOh0vnhHkbySwBMhI0TzTUVocqfi+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u8Dv+xMf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a7903cb7dso441484766b.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2024 08:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726671885; x=1727276685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rAUj5z86FV+d6rAd4UOajymFlz61iSG2wpZ0JHsQ42s=;
        b=u8Dv+xMf99nDwj/LZ89SRX6Xtt13al6gnFfD0R/U3FVBL1KkmkDugiCKEYXojPa7mr
         G1ZIW3zCHcawyA+3x1oDERVpGMRdV2PTp/jJsxAJMOKH4w8/3msA9R6L7BbSw1DP5J1g
         v6Y73KwvrQNac5MjcFyzVQShlLqBlyyfQnJPhOXkwDbMJJA5wjcFCQueLQrqDtrGsutT
         Luj3xbjdcH30wbUxn0XXmxUAfC/R4EFK4KGBlK9tlH2caOOLqlf8nDdg+YIN2j8xhD8f
         zdRJ09fs1H+2CSEpdxtpgWYghSZjaZISIqkEr2UlS/85RWDr6nPzdwPNIEK2l5LN+R26
         bG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726671885; x=1727276685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAUj5z86FV+d6rAd4UOajymFlz61iSG2wpZ0JHsQ42s=;
        b=hDoVEbpwz547oQbnL6pXQZ65hSTjqIxeNTWSSkM7KFeO5sTRSz/mqI5KuCahkihP2s
         02xQx35R/XxnewQH79rKD4Xb0AqhxU0H9xrKyUimM2wKZLS9M+2V/B4hn6Jb/VNzG0lo
         vM1y1jRG0ZkSWb4saTB/NAdWttUWLiTT42cYlzFaMOpdMs2bABhW+XRtFV7TDg+U/PIB
         cnjPWPiqr9onTV1gT2o46mwosZonrMH++1wpp1M7IHT+w3sQ2lFs8qO+T+OzJrDvZs63
         WaKLzKmtjgooNjyWmMhCilTkUGsQH5Gd2oKCkrygc7xZMq69FRdhX2mysNBMCqOSjRBR
         Fkyg==
X-Gm-Message-State: AOJu0Yyzr6Rgv97u6apmEK5LPk2+OKeSlc/dfFGMLM5Mr3XwMRm3KSLm
	9xZIbxiv+vewziAI5SzwJNP1gU1PjOZybCsVYw12KskMHaDCTQevFgOUMHhp6SkFZTglRvq+Hiw
	6Atdm7Tv0Y93zX2K4Q7dUicQHYIVZJ/wcBKbqcA==
X-Google-Smtp-Source: AGHT+IGEa1MCEaD0bdULC6b+TJ4wo1e1Num6uxETKpo/Rg0Pz+70M8LeHhF+ZrzyZIixLx67E+kqWhsRXxF1Divl44g=
X-Received: by 2002:a05:6402:5108:b0:5c2:6311:c9d1 with SMTP id
 4fb4d7f45d1cf-5c41e1b5325mr25680316a12.22.1726671885023; Wed, 18 Sep 2024
 08:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909095529.2325103-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20240909095529.2325103-1-marcin.juszkiewicz@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 18 Sep 2024 20:34:32 +0530
Message-ID: <CAKohpokMUqaMUJaSfdyY39idmh_ycYj+hi5sMSBmZV1CQ511qA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: use proper units for frequency
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Sept 2024 at 15:25, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> When I booted my RK3588 based system I noticed that cpufreq complained
> about system clock:
>
> [  +0.007211] cpufreq: cpufreq_online: CPU0: Running at unlisted initial frequency: 816000 KHz, changing to: 1008000 KHz
>
> Then I realized that unit is displayed wrong: "KHz" instead of "kHz".
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 04fc786dd2c0..76da29c2bd3f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1539,7 +1539,7 @@ static int cpufreq_online(unsigned int cpu)
>                          * frequency for longer duration. Hence, a BUG_ON().
>                          */
>                         BUG_ON(ret);
> -                       pr_info("%s: CPU%d: Running at unlisted initial frequency: %u KHz, changing to: %u KHz\n",
> +                       pr_info("%s: CPU%d: Running at unlisted initial frequency: %u kHz, changing to: %u kHz\n",
>                                 __func__, policy->cpu, old_freq, policy->cur);
>                 }
>         }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

