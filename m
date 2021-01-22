Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF51E3005CF
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 15:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbhAVOpr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 09:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbhAVOpn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 09:45:43 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5C9C0613D6;
        Fri, 22 Jan 2021 06:45:01 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h7so7857334lfc.6;
        Fri, 22 Jan 2021 06:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NYuOyrBA3kXFTfAu9fsVq/4HwU5w715PStR0pet3new=;
        b=smgHIiRtqAR4oFQybNgfFViCTJNEoL+9sLgCQsENKXurosOdtnYuwWORw8Ftp+axZ/
         YwgHm4Olx0Sst5TfcQ/phN5F9jwtcey/jWcut/QAVPVoFwpJaMLeFVlGkacOCCZNSvXN
         X5/lDsWAbRUNgcefIuiOa8V7gcWD+acLAO1ZRvWPV/9bkBybcYi+JD0ix2J1D/lbjqle
         qt8A1DDaS/ofe3uId3raZZUjPintMF8JDncnU+OEQqcrPzluaS2mu4NuytmgqfGcAbGB
         6zeiv2JlFL6zUhvCBDp/08x7IkS2u7j69LOttLYHa5fUGgIltN+8ZFEtaWN2Sc3ScqTk
         radw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NYuOyrBA3kXFTfAu9fsVq/4HwU5w715PStR0pet3new=;
        b=dLNHZ+jkiLDFc6BYbWNCRQDSxDDl44STGcrMf5LWLct0iP5cFdsiB8QysfDaIVQRr5
         6n4rb15iep31h9zUdluX5G9EckP581WDCaETUZv5EL3w7ZlTG8Vg6bKi1l/+WZ1dvsNP
         pDGEU71oqTOv6anlD3ySGWTX+9yOYdCFiaU2/QDF7gdlCYHtwkb/osen0lr9aICJdn5U
         sYX7m9w9SLg7w+xczKYoQEoJEjHWI2JQ+W/p2hMBSgZ3FfW6m9AFV6WVM1lMuy/0G1PL
         LGWepSKomhZWCHuWCCGtO/HNlzbcveHgxkxj6Ub0VzGuVRbvnjPBaEYPfpP1Qpk2d+pr
         sX2w==
X-Gm-Message-State: AOAM531jreLavHgFXDAuz3a2zqkFnMBqWoc+g+RHtK+3QcwL5R4U7UL1
        0JsDNjoodCWTbIsxmXLnCb9I10trdsw=
X-Google-Smtp-Source: ABdhPJw8XtkbXMHQKa7wXDFyovXWAYZmF75FV6lprfRYIKEs2uxaT521qAxhGKiyoI1hB+nko5nZ2g==
X-Received: by 2002:a19:589:: with SMTP id 131mr1541965lff.525.1611326695453;
        Fri, 22 Jan 2021 06:44:55 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id u15sm153998lfl.267.2021.01.22.06.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 06:44:54 -0800 (PST)
Subject: Re: [PATCH v4 4/4] opp: Make _set_opp_custom() work without
 regulators
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210120222649.28149-1-digetx@gmail.com>
 <20210120222649.28149-5-digetx@gmail.com>
 <20210122072626.mlbthef43hjldnyr@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <688c9aea-62b3-b52b-fee0-0d78cb28443d@gmail.com>
Date:   Fri, 22 Jan 2021 17:44:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210122072626.mlbthef43hjldnyr@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

22.01.2021 10:26, Viresh Kumar пишет:
> On 21-01-21, 01:26, Dmitry Osipenko wrote:
>> Check whether OPP table has regulators in _set_opp_custom() and set up
>> dev_pm_set_opp_data accordingly. Now _set_opp_custom() works properly,
>> i.e. it doesn't crash if OPP table doesn't have assigned regulators.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/opp/core.c | 26 +++++++++++++++++---------
>>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> I have applied this instead:
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 32d653774adc..805fc2602808 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -828,24 +828,31 @@ static int _set_opp_custom(const struct opp_table *opp_table,
>                            struct dev_pm_opp_supply *old_supply,
>                            struct dev_pm_opp_supply *new_supply)
>  {
> -       struct dev_pm_set_opp_data *data;
> +       struct dev_pm_set_opp_data *data = opp_table->set_opp_data;
>         int size;
>  
> -       data = opp_table->set_opp_data;
> +       /*
> +        * We support this only if dev_pm_opp_set_regulators() was called
> +        * earlier.
> +        */
> +       if (opp_table->sod_supplies) {
> +               size = sizeof(*old_supply) * opp_table->regulator_count;
> +               if (!old_supply)
> +                       memset(data->old_opp.supplies, 0, size);
> +               else
> +                       memcpy(data->old_opp.supplies, old_supply, size);
> +
> +               memcpy(data->new_opp.supplies, new_supply, size);
> +               data->regulator_count = opp_table->regulator_count;
> +       } else {
> +               data->regulator_count = 0;
> +       }
> +
>         data->regulators = opp_table->regulators;
> -       data->regulator_count = opp_table->regulator_count;
>         data->clk = opp_table->clk;
>         data->dev = dev;
> -
>         data->old_opp.rate = old_freq;
> -       size = sizeof(*old_supply) * opp_table->regulator_count;
> -       if (!old_supply)
> -               memset(data->old_opp.supplies, 0, size);
> -       else
> -               memcpy(data->old_opp.supplies, old_supply, size);
> -
>         data->new_opp.rate = freq;
> -       memcpy(data->new_opp.supplies, new_supply, size);
>  
>         return opp_table->set_opp(data);
>  }
> 
> 

I replied to the wrong email, but this also looks good :) Thanks!

