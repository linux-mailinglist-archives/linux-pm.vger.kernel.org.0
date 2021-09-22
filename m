Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656F6414334
	for <lists+linux-pm@lfdr.de>; Wed, 22 Sep 2021 10:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhIVIHV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Sep 2021 04:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbhIVIHU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Sep 2021 04:07:20 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDA0C061574;
        Wed, 22 Sep 2021 01:05:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f129so1875358pgc.1;
        Wed, 22 Sep 2021 01:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3vgj0hW3KSHhJ1FNGvvnjMW3NitG36aDXcJz/7heGcA=;
        b=FAkBVWugynwfJI5lWaQvYEy5zoZ/PcwxIzBamJjPUP+b2SJ39zuwELnOxZD4mWY7qI
         VL+NRFb28mlUzCzMNFU8j2NXe+OzTklHCFA1mSE3MXf4GK+Sx65lA1keQKFwGlsrg9tU
         tRonpRLFulMJRQa9KRODt+Cp+UQlzyTtiUHLtMgCsrKSVqTJbk4CqpICjwqwgiMymCpa
         zVNq1/Yg3KD7mrkYF4M7le9Q4d3Gn8986+7TMsBcQHgo7Q+GySY6qjBPrwQu5mqiJ3iI
         EdQMGVC+gVV9oJFAEklO3sPTpktjuuiE5r4+kATExB81e4C/gPw5qi069u7USlKJNEiM
         KluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3vgj0hW3KSHhJ1FNGvvnjMW3NitG36aDXcJz/7heGcA=;
        b=e8HNrhaTTjfcmwLQai4PLyHPYmWL+nJCRjvEgVrZJ69awBa+Cd/HIaZ16ej5bdrxmy
         ly3TF8SlPPOii48+fffczdK8Gnak98BlFm2hiRRaO2XUaDvcXpsiVaakaf7iFgplaQc4
         q8B1fYFPVFHMx+5YCxQ7/FzKJf609WeSJN9suyrrECibDsdZhXrl83SMiaLM3A5Q5usn
         OK472jpHgMhFyd8Bu2SUIuG+zt63Zc7oV9xi94/2ocMZXMxDSYstR0LsSE16UyQfMXi5
         NYfA33KqGkE1IjFxLDA8s0d6tnjC2pZTyZzSJ9VrJf3oiE8Iu6QmR8Ju+ygWXoEFsPmf
         a1YQ==
X-Gm-Message-State: AOAM532AsEo0jmffvcWWnQhAEiB2z/65MQJLkOSilnrdxzGAx1q9aSdV
        mtEkO3Df2JcCGVUlBaU5WoQ=
X-Google-Smtp-Source: ABdhPJwdylx2gAkFtmU9FHajYgZBLBBYYbPpvbp7sGfAL2p7//GTWekKTYSd4s/OpU5ahmIuNorN4g==
X-Received: by 2002:a62:7b14:0:b0:447:c4c9:ce3f with SMTP id w20-20020a627b14000000b00447c4c9ce3fmr12556780pfc.15.1632297950610;
        Wed, 22 Sep 2021 01:05:50 -0700 (PDT)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id c23sm1599245pgb.74.2021.09.22.01.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 01:05:50 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] devfreq: exynos-ppmu: simplify parsing event-type
 from DT
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20210920071540.38337-1-krzysztof.kozlowski@canonical.com>
 <20210920071753.38560-2-krzysztof.kozlowski@canonical.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <35ad437f-7527-e9b1-4819-8f4faa765e26@gmail.com>
Date:   Wed, 22 Sep 2021 17:05:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210920071753.38560-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 21. 9. 20. 오후 4:17, Krzysztof Kozlowski wrote:
> When parsing devicetree, the function of_get_devfreq_events(), for each
> device child node, iterates over array of possible events "ppmu_events"
> till it finds one matching by node name.  When match is found the
> ppmu_events[i] points to element having both the name of the event and
> the counters ID.
> 
> Each PPMU device child node might have an "event-name" property with the
> name of the event, however due to the design of devfreq it must be the
> same as the device node name.  If it is not the same, the devfreq client
> won't be able to use it via devfreq_event_get_edev_by_phandle().
> 
> Since PPMU device child node name must be equal to the "event-name"
> property (event-name == ppmu_events[i].name), there is no need to find
> the counters ID by the "event-name".  Instead use ppmu_events[i].id
> which must be equal to it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   drivers/devfreq/event/exynos-ppmu.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index 541bd13ab61d..9b849d781116 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -566,13 +566,10 @@ static int of_get_devfreq_events(struct device_node *np,
>   			 * use default if not.
>   			 */
>   			if (info->ppmu_type == EXYNOS_TYPE_PPMU_V2) {
> -				int id;
>   				/* Not all registers take the same value for
>   				 * read+write data count.
>   				 */
> -				id = __exynos_ppmu_find_ppmu_id(desc[j].name);
> -
> -				switch (id) {
> +				switch (ppmu_events[i].id) {
>   				case PPMU_PMNCNT0:
>   				case PPMU_PMNCNT1:
>   				case PPMU_PMNCNT2:
> 

Applied it. Thanks.


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
