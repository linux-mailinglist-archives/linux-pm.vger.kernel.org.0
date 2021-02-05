Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6EC310B92
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 14:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbhBENLN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 08:11:13 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:43314 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBENJE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 08:09:04 -0500
Received: by mail-ot1-f43.google.com with SMTP id v1so6775135ott.10;
        Fri, 05 Feb 2021 05:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WX8ErsF7ufGENF0dnMlQjeqhkThVBYcUlVXRDpEQYKY=;
        b=fygE3kiSMor8zTUVrxN0TO6hoSpze5jgrgRxB2T4xYbHnLq2DOjhP/WjRGG+I8xI8D
         5GiphqjTEN6e3eqmFt6M0hnF61cZc26OYiake4AzYXPuFXsrNSyHq6t1/CR4YwQkXshG
         HSJ1wumQRaB19trPD7o/U07tYnm1Akst0O+Znve4+qEUCQKQXGjCYVIPzwL5C2pMxuMe
         XtFQvQ3QBCztr1XIfx9/X0kKAgLIwVGkC6idiXPWeUjvx0AIzr0s5nQyfiHaSbJnppU+
         q3Pap/R3oHzBCALv2Dle/TbQjumUNXP/R0T7putGoUYyd/sFGAGVy4UyzWq+gEyro5ay
         jsRg==
X-Gm-Message-State: AOAM530lHWePi2NxJK2YNCCrd18NkUcWIV7e4BNv0oCA4V+OmervMacy
        Htm4zAFU0eWVjveMvUfcDQaUQ8l0sN7vDk2Jr/o=
X-Google-Smtp-Source: ABdhPJwLLPJaUTt4hMFqS8aDV3vSP0ZLRDiuSz3VqpP3va5aV1c7z5uo4VXRXbCxxIeFG31SZhg5JfA4Vs0insAxEyQ=
X-Received: by 2002:a9d:6acf:: with SMTP id m15mr3299035otq.260.1612530503122;
 Fri, 05 Feb 2021 05:08:23 -0800 (PST)
MIME-Version: 1.0
References: <20210205125144.1407032-1-unixbhaskar@gmail.com>
In-Reply-To: <20210205125144.1407032-1-unixbhaskar@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Feb 2021 14:08:09 +0100
Message-ID: <CAJZ5v0hokLPQML9wWuo9aqcQGZeMc5k9a+fzPKs4mZe5p11_mw@mail.gmail.com>
Subject: Re: [PATCH] drivers: cpufreq: Change a word with a word , good one in
 the file powernow-k7.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 5, 2021 at 1:55 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
>
>
> s/fucked/messed/

I wouldn't make the changelog so explicit, just say "Use more
appropriate language" or similar.

>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/cpufreq/powernow-k7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
> index 5d515fc34836..2e114fc75e68 100644
> --- a/drivers/cpufreq/powernow-k7.c
> +++ b/drivers/cpufreq/powernow-k7.c
> @@ -574,7 +574,7 @@ static int acer_cpufreq_pst(const struct dmi_system_id *d)
>  }
>
>  /*
> - * Some Athlon laptops have really fucked PST tables.
> + * Some Athlon laptops have really messed PST tables.

Or even "broken".

>   * A BIOS update is all that can save them.
>   * Mention this, and disable cpufreq.
>   */
> --
> 2.30.0
>
