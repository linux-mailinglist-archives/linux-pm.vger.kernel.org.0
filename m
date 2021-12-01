Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC4E46476C
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 07:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347007AbhLAGzN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 01:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239448AbhLAGzM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 01:55:12 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFDFC061574;
        Tue, 30 Nov 2021 22:51:52 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so378392wmb.0;
        Tue, 30 Nov 2021 22:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0sN6XqAFPTaH5Gvce9FdZDLEXzC/PKsUE1aQy/LgvDM=;
        b=dx8DMlScqRCHmWv7GyagLcZyqx6S+ZczKF0Dtqy5l1l7jgBFxbM0Ww/mMtc+qoPtl9
         GX7yMfwGbTtIBn9CwEnuiR+KlMNnLX7nEZzM3jd1gBONdO5Cq8WSqyszG7Cf5FTbwyQ1
         y0rXMPNrf072pbtw6uhZM/Tsnv6cbAMCQp5TbrjtnFREbXnPHXVxmADIVwL8aIa2iU8V
         xScYKJSdEeULF4cbVXF3OmISG09Ar8kjUWEPJR71WjD4MXPTSjp5h342zl5LYHKPTk9V
         Knxlje5lg+2qwCYfR9J7peDLTGTu0S3SwjBAMzwDHdlrkIm6MQoPoGJG7utSMmrACvzE
         ypbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0sN6XqAFPTaH5Gvce9FdZDLEXzC/PKsUE1aQy/LgvDM=;
        b=yKSqNpmQz7cBWbd5qjZEIoAOVwhiobSGxHLEbUPxymDOmcSPqdEiKEm5L9/fwYGrp1
         e7YiJxR00nvU0wNfUYwbgTLefRY87s46eu0BlonwIHpz+x9a25k8P4/w0Ou7UGZqG3z4
         A/3PdEWIiS96nC/+1BCN0Q1sbcITV9slqZ+6adwcP3FthFwqxeEEB2R5KR4uJUOGrXkr
         UJPN7eHUEVw4XCai/qIEZk+/C2HrSLveIirz8UKPrCiivSYeAyGbMe8emP/kN5r9kQGW
         B/Hrc1ovrVGqq5DM4dUmwpu6UPuIEiyWZT1iLXkPD+WJDLiiwUBOr9MvmSojjqu5XO9M
         MzUg==
X-Gm-Message-State: AOAM533MZjSWzpgNfYG87M0eBBrxqebA5LGt+LXDO4gyyUrTFQ5Kdm8C
        QGQkYPf+BYv93/wRf6dgXhAP3Q3oECo=
X-Google-Smtp-Source: ABdhPJydsRGcsJosQgb3L3fKQBcUj4HzNJDN29np4avQK7Y4CccDtRAfiOJWYIb+5CD5sPTb1N+OXQ==
X-Received: by 2002:a05:600c:1d01:: with SMTP id l1mr4798353wms.44.1638341510709;
        Tue, 30 Nov 2021 22:51:50 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:b136:4fc9:1071:a7cc? (p200300ea8f1a0f00b1364fc91071a7cc.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:b136:4fc9:1071:a7cc])
        by smtp.googlemail.com with ESMTPSA id z6sm55909wmp.9.2021.11.30.22.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 22:51:50 -0800 (PST)
Message-ID: <750ed3a5-0f4e-7718-33b4-ad056ae91990@gmail.com>
Date:   Wed, 1 Dec 2021 07:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: crypto: stm32 - Revert broken pm_runtime_resume_and_get changes
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Shixin Liu <liushixin2@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
References: <4239b61f-f8c5-462f-2951-fbba2dec8b1d@gmail.com>
 <20211201063041.GC684@gondor.apana.org.au>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20211201063041.GC684@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01.12.2021 07:30, Herbert Xu wrote:
> On Sat, Nov 27, 2021 at 02:39:52PM +0100, Heiner Kallweit wrote:
>> When discussing whether pm_runtime_resume_and_get() should be annotated as
>> __must_check, I became aware of RPM usage in crypto/stm32.
>>
>> Following two patches replace usage of pm_runtime_get_sync() with
>> pm_runtime_resume_and_get() w/o checking the return code.
>>
>> 747bf30fd944 ("crypto: stm32/cryp - Fix PM reference leak on stm32-cryp.c")
>> 1cb3ad701970 ("crypto: stm32/hash - Fix PM reference leak on stm32-hash.c")
>>
>> This results in RPM usage like the following in stm32_hash_export():
>>
>> pm_runtime_resume_and_get(hdev->dev);
>> ...
>> pm_runtime_mark_last_busy(hdev->dev);
>> pm_runtime_put_autosuspend(hdev->dev);
>>
>> This is broken. After pm_runtime_resume_and_get() the usage count may be
>> incremented or not. If not, then the call to pm_runtime_put_autosuspend()
>> results in exactly the imbalance that the patch claims to fix.
>>
>> Therefore I think both patches should be reverted, or the return code
>> of pm_runtime_resume_and_get() has to be checked and properly handled
>> in the driver logic.
> 
> I agree.  But we can't revert them completely because it does
> fix some genuine issues with the ones where we do check the error
> code.  What about this patch?

Looks good to me, thanks!

> 
> ---8<---
> We should not call pm_runtime_resume_and_get where the reference
> count is expected to be incremented unconditionally.  This patch
> reverts these calls to the original unconditional get_sync call.
> 
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> Fixes: 747bf30fd944 ("crypto: stm32/cryp - Fix PM reference leak...")
> Fixes: 1cb3ad701970 ("crypto: stm32/hash - Fix PM reference leak...")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
> index 7389a0536ff0..05087831e199 100644
> --- a/drivers/crypto/stm32/stm32-cryp.c
> +++ b/drivers/crypto/stm32/stm32-cryp.c
> @@ -542,7 +542,7 @@ static int stm32_cryp_hw_init(struct stm32_cryp *cryp)
>  	int ret;
>  	u32 cfg, hw_mode;
>  
> -	pm_runtime_resume_and_get(cryp->dev);
> +	pm_runtime_get_sync(cryp->dev);
>  
>  	/* Disable interrupt */
>  	stm32_cryp_write(cryp, CRYP_IMSCR, 0);
> diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
> index 389de9e3302d..d33006d43f76 100644
> --- a/drivers/crypto/stm32/stm32-hash.c
> +++ b/drivers/crypto/stm32/stm32-hash.c
> @@ -813,7 +813,7 @@ static void stm32_hash_finish_req(struct ahash_request *req, int err)
>  static int stm32_hash_hw_init(struct stm32_hash_dev *hdev,
>  			      struct stm32_hash_request_ctx *rctx)
>  {
> -	pm_runtime_resume_and_get(hdev->dev);
> +	pm_runtime_get_sync(hdev->dev);
>  
>  	if (!(HASH_FLAGS_INIT & hdev->flags)) {
>  		stm32_hash_write(hdev, HASH_CR, HASH_CR_INIT);
> @@ -962,7 +962,7 @@ static int stm32_hash_export(struct ahash_request *req, void *out)
>  	u32 *preg;
>  	unsigned int i;
>  
> -	pm_runtime_resume_and_get(hdev->dev);
> +	pm_runtime_get_sync(hdev->dev);
>  
>  	while ((stm32_hash_read(hdev, HASH_SR) & HASH_SR_BUSY))
>  		cpu_relax();
> @@ -1000,7 +1000,7 @@ static int stm32_hash_import(struct ahash_request *req, const void *in)
>  
>  	preg = rctx->hw_context;
>  
> -	pm_runtime_resume_and_get(hdev->dev);
> +	pm_runtime_get_sync(hdev->dev);
>  
>  	stm32_hash_write(hdev, HASH_IMR, *preg++);
>  	stm32_hash_write(hdev, HASH_STR, *preg++);
> 

