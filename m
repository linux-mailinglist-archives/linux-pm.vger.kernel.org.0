Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C630420618
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 08:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhJDHA3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 03:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbhJDHA3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 03:00:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC916C061745
        for <linux-pm@vger.kernel.org>; Sun,  3 Oct 2021 23:58:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so2833692pjb.5
        for <linux-pm@vger.kernel.org>; Sun, 03 Oct 2021 23:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7NQLC0CBpzZQKLFn2CPvxGDT2PispmvfZ9mt7LCx8S8=;
        b=Q5lozMPfGyLnq8Ai11eVCshTt5a6HMdyat3eZQVrjDX9SMe9oG2EGPxgBBTgJ5qO9o
         N/j0Ilrbm2dTYwe/VB93l8dhQeeh1yxmYt4p6CtdUS1rBBQvY7Sp/9ZJ4FGwSyqmYr60
         I4373XXYJfHaEuNfgXk7JW8nsH4PBQUFN2N5UTYMv2zlJ90NHKthZe3yYDbi0nwIToVq
         Z2kAASGfcS7YxGUqo6bQkD38OpsaeujCQQJXeG33kBpWUJFjZ55o9NpAZpFlIvQ+Wa1m
         dhovIWOEwwujjSFL+gh1snubCZMVIMdmHKZqh7lsxTrK/uc1ZmIQR6jikJtVAZfzIgku
         8j3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7NQLC0CBpzZQKLFn2CPvxGDT2PispmvfZ9mt7LCx8S8=;
        b=yiTKn6Mu1K26lQNo34UlahykbwkYHme6qoIE/1j3NNs48CtXDnOyXcBoH03TF+2Vkq
         HYqzIS3ip0+QagK7jK9r6CERyATFqQHoP0JfNqOBBV7ZYgxvQ4n9rZ4axz/CqJmECia9
         TVgdWq5a6XXh333WmudffyVrxIeI3ymwEVMlMT3YuboMnQ9E+O5sVnD697RfSYUyOBx3
         I5CvrtgJ8UkBBTjowwELzImWeyeldduUe2dpmR7dR04dP2WIcLjV9wj1bCvfDvigYIjR
         WitfvfBayw7nWleqjD+MzPKh8QAO+KMyjQxXaDPuBn3SKpRkoJ6qy+an5w6SPfmA+Z+W
         0nnw==
X-Gm-Message-State: AOAM530jY0DepWtUSjuT6oVQy4vCnMvOk1UUjrCDhtFfnsjvZSFSoGmi
        8cBT2pkntdrzS24U/jORLmvqb0GzdHc/bA==
X-Google-Smtp-Source: ABdhPJzk9QfzO3wNBh8AzygDT3L+GhgGCcTyNWzVv0y7ygMcryg2CKHlzsdMyZ+52INja1eTFBaQfw==
X-Received: by 2002:a17:902:eccf:b0:13e:b002:d8bd with SMTP id a15-20020a170902eccf00b0013eb002d8bdmr6838260plh.48.1633330720209;
        Sun, 03 Oct 2021 23:58:40 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id t8sm8696202pgv.35.2021.10.03.23.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 23:58:39 -0700 (PDT)
Date:   Mon, 4 Oct 2021 12:28:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Han Wang <zjuwanghan@outlook.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cpufreq: remove useless INIT_LIST_HEAD()
Message-ID: <20211004065837.nmymvhowjz3zuilu@vireshk-i7>
References: <MN2PR10MB40938AC3AE715AD1E6B9A008C1FC9@MN2PR10MB4093.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR10MB40938AC3AE715AD1E6B9A008C1FC9@MN2PR10MB4093.namprd10.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-08-21, 21:07, Han Wang wrote:
> list cpu_data_list has been inited staticly through LIST_HEAD,
> so there's no need to call another INIT_LIST_HEAD. Simply remove
> it from cppc_cpufreq_init.
> 
> Signed-off-by: Han Wang <zjuwanghan@outlook.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index d4c27022b..db1719626 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -741,8 +741,6 @@ static int __init cppc_cpufreq_init(void)
>  	if ((acpi_disabled) || !acpi_cpc_valid())
>  		return -ENODEV;
>  
> -	INIT_LIST_HEAD(&cpu_data_list);
> -
>  	cppc_check_hisi_workaround();
>  	cppc_freq_invariance_init();

Applied. Thanks.

-- 
viresh
