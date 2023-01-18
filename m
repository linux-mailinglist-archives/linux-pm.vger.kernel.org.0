Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DD6672A6C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 22:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjARV0X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 16:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjARV0M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 16:26:12 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3206664683
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:25:54 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j17so169710wms.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zil7aav59xp1kmtYrTwI3GdRzU8n332Kso/dG002S4A=;
        b=i8WooNMldKqXXA62+jHgbA5SWV31eZG2CYd0AkjQv9BQmsf3ovny7eQ1Vb2iY3NOz/
         2Wd1sZBhAwXgYm6rRcAcjWvSbEAZeaoVEfGKhoS0u0P7bOiigmDOOSWXeyW6Cgkc03mP
         B9LcEuGynk7Cmp1zRQ7BpTv/xboiALK5tEukyV6uuhIM/UqVksF05dfemGxOMlp1k1os
         JoOZEusYg5zfWWqlXBQRsPFKnbkK5Ice8lZrlWfZTeVBH7++FvC3aVtL/3zGVtULa+Kg
         xj/mgyyOUaErjWAy/CVRCx/DwoCwPiR/qaJcTFS8+PA9FlsBa7XyXahgbbvGz7qzAPaX
         wOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zil7aav59xp1kmtYrTwI3GdRzU8n332Kso/dG002S4A=;
        b=X3Cou02kqwtztMTKpP4gk6z/UsrwKKeUKexPQZhrISLVnExfF5PDMg4keF9iQlMA+I
         KslDzs8bqQw8RZsIh89EvT/6SJj5yshhcy3Sx6/Rr6gGtpSpRj3HKd9AVPlZH7n3aQdD
         SZ58MkCy7jsXbV5SX/6W+idM+qk6kmPbermMcyyJCRucAXAYUp1zPa6jfclct9Va+zAn
         om2ZLIRDh+3cq9O3swZ2cPSDUadkFHMhOOuSwK3W18JifKLGlWKLAYb/I5iJ9d8ZMF+H
         SzS/pgac9YyGIKkbGdVc17f4cRSx2o9oTYrhxs66tiJNkRfSNRpfbes1f1FrtorxCpaU
         veMg==
X-Gm-Message-State: AFqh2kpZwMF9HmQsn/oXZWIE7G9qSCYzQugOHHYp1nHbTRw3dEa/fuBD
        cqGrhSAJw1mzDEHrJC0SnkAcTA==
X-Google-Smtp-Source: AMrXdXvDFzyXbKQnmabWrlMlH8ff7a7TL7lghPjq1R4Hqk3e8Nt9Fq6g6cgsifSVeJ5sGdAssmVbDQ==
X-Received: by 2002:a1c:7415:0:b0:3da:fd07:1e3 with SMTP id p21-20020a1c7415000000b003dafd0701e3mr7758444wmc.22.1674077152611;
        Wed, 18 Jan 2023 13:25:52 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m9-20020a7bca49000000b003d98f92692fsm2926123wml.17.2023.01.18.13.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:25:52 -0800 (PST)
Message-ID: <97902a78-f1f8-3526-69a4-bf4c70597a89@linaro.org>
Date:   Wed, 18 Jan 2023 22:25:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gdGhlcm1hbDoga2lya3dvb2Q6IFVzZcKgZGV2bV9w?=
 =?UTF-8?Q?latform=5fget=5fand=5fioremap=5fresource=28=29?=
Content-Language: en-US
To:     ye.xingchen@zte.com.cn
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202301181642412733780@zte.com.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <202301181642412733780@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/01/2023 09:42, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---

Applied, thanks

In future, please send a series rather than individual patches

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

