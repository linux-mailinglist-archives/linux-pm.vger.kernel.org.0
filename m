Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D8D39AA2A
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFCSkB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 14:40:01 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:55080 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhFCSkB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 14:40:01 -0400
Received: by mail-wm1-f43.google.com with SMTP id o127so3985104wmo.4;
        Thu, 03 Jun 2021 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EDVa1hQD92Hd4TfTRJ9ezW3anq6FpQm21V7DLXjucNM=;
        b=SQ7zq/n8ufD25BlX9+FJeMjLXMu/ZveV/6My3ed1unrCRRQyjSAAjePxuQqFebMKYg
         b+LaQmLg0NEfXpm3l9rpfFdzoWGxzjebMwtEyKxJjduMbea4+OiEz+13P7ihLFk5WRjI
         v2xpZZmNxKMrYYuNFFretPB9q9CMfQSqwieVzJEhxP6WjIFrValsPoJTBJNLUQLzOXE4
         uCG6Lv3Mzx0vClfytH5XY9KAuTLZpiHmkLdwFWG7n137jy2waieXr4AJObdMd851ISH/
         hnUV8lMPGZTEk0VtmFm+BG+g9LPR6+UREgt9kpGPiVHWplGJ2g75XvGqw7loOU59MGqZ
         Kptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EDVa1hQD92Hd4TfTRJ9ezW3anq6FpQm21V7DLXjucNM=;
        b=oEnz7vCO2Bs91VkwV7fBlW+eAv+9YyWShbu/bX4kufTMECKX5/OI8E0D6YMSOe8Jri
         hzz5RJdr+Uf6VaZtGBj/L7ZZ07t2Bh5Fltvzmi2DNNG9uPZ5JjO73ZaqXxbnkWUSEwnH
         BWFYjzNgZO/5aWl0JwMxoOlB1cj7jFh2UeBt3vS+GPPfSvMLd7XiBdJyY4JBfg0h9kmn
         j2bRnU/OV/Xe4LSuqWkYm2gGHSDVzLjMGq1ZiDGrnKFpIGgeVHuOsMEmcw0PYP+iBAqn
         hR/9Ivvhj5Ei4KGFr2WgvvsvUr8t9yN2RM9+zgJqwa4Pp84o//mTKhmZrkgTpeivyouQ
         6LjQ==
X-Gm-Message-State: AOAM5321uI5DvWTF4Ud6S5pjXbnBKTngsNcsfRqPZarf1oWTLurRjsxV
        qtBD/mgGBgbUAmH4BTiq1Do=
X-Google-Smtp-Source: ABdhPJyTl53cubqGsxgPtmBhUo1CDrmy9SSXBFOy0TMQmmfbn8+wi1n1FNJwJof4P0tyOc/S8qgO6A==
X-Received: by 2002:a1c:ed03:: with SMTP id l3mr432730wmh.130.1622745435301;
        Thu, 03 Jun 2021 11:37:15 -0700 (PDT)
Received: from [10.18.0.23] ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id v7sm4819182wrf.82.2021.06.03.11.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 11:37:14 -0700 (PDT)
Subject: Re: [PATCH] power: supply: surface-charger: Fix type of integer
 variable
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20210511092421.1928586-1-luzmaximilian@gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <55aafbea-96d4-29f2-8d8b-68f8ac970c6b@gmail.com>
Date:   Thu, 3 Jun 2021 20:37:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210511092421.1928586-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/11/21 11:24 AM, Maximilian Luz wrote:
> The ac->state field is __le32, not u32. So change the variable we're
> temporarily storing it in to __le32 as well.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: e61ffb344591 ("power: supply: Add AC driver for Surface Aggregator Module")
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Friendly ping :)

> ---
>   drivers/power/supply/surface_charger.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/supply/surface_charger.c
> index 81a5b79822c9..a060c36c7766 100644
> --- a/drivers/power/supply/surface_charger.c
> +++ b/drivers/power/supply/surface_charger.c
> @@ -66,7 +66,7 @@ struct spwr_ac_device {
>   
>   static int spwr_ac_update_unlocked(struct spwr_ac_device *ac)
>   {
> -	u32 old = ac->state;
> +	__le32 old = ac->state;
>   	int status;
>   
>   	lockdep_assert_held(&ac->lock);
> 
