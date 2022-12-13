Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971ED64B1EE
	for <lists+linux-pm@lfdr.de>; Tue, 13 Dec 2022 10:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiLMJMg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Dec 2022 04:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiLMJMN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Dec 2022 04:12:13 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB36F1DA6E
        for <linux-pm@vger.kernel.org>; Tue, 13 Dec 2022 01:07:53 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id o5so14912679wrm.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Dec 2022 01:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkFkokkWiyDzbuKyCSfyWxnVwbu4mx5eY0akTQb8bTY=;
        b=GzV70pDAwINszjiO9T29alS1felleWq3Qze2TsakhS/Jb8S4sipEHNbX+aNV+zoSmK
         fia2IRwjVoACvjaKSbjohXaPSunlUuNb2uVUMJtMOoVE/EYarpKDxb9NXFY0RsZ1zLQD
         Gxy93xD/2ANO1lNjacnivbRyNMD2xKVmVgNL/tQqgj7lzkYt03hrfhy3NwaFyegzs5PA
         2fwF6shA9OK+bm82uhbU21P97W1rWmD9OqThTWcVIn2OSp8Vic2EylGMdYvcJUGci7Zf
         PoC/s2525xGKDf5XzT7UzixYQnNIm7cFKefXQgMrZc8EUAmWuB60OxcBUb8thYGDxJHN
         nxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkFkokkWiyDzbuKyCSfyWxnVwbu4mx5eY0akTQb8bTY=;
        b=TJie2TK7/x3XhEMPmBJOHrdK+JsuhuenG+OkOx63zRPJp+Ey4WkN8YmbSL9KVyZ4NK
         WwVyobj+ZUShNiMHv1dncNzDYt6nfqfykGC+U0JDCJPqmbzc7tp0U/M4MjBzwmDSH4UG
         q+PsravHdPT4lNDWoyX+tUNNGiMDLL7R8aG6TBq5GAN21g+43iPRaoDJIzxLrdOwnbgE
         l0sXNvsfUljQp4jF7v9PXXbUU+CwbR+d+V3faeSixXIa6Yfd7MxL9rYSY67/PMhotuy7
         CLsEek1LJvTgVenyNxNmK9SdAieDlDr4xc2yf0LwkUoXP4BrbGXbacGIGaWwFfgpydqq
         bbFw==
X-Gm-Message-State: ANoB5pkGyHv9F0078VMBDKJJzDku9FtYGV2nvGdzV6vh3rcNMCg6Y6uI
        cHFoCNXH/AkYD3XTljrFsg4uww==
X-Google-Smtp-Source: AA0mqf7eYxVNmZhTIWWcc6J36rQn3eaqeZsFCwPcHNkYHz2p6rkpqAaq3qmgh12TAt+ba8Vbjbz40Q==
X-Received: by 2002:a05:6000:90a:b0:241:ef59:e427 with SMTP id bz10-20020a056000090a00b00241ef59e427mr12675021wrb.5.1670922472381;
        Tue, 13 Dec 2022 01:07:52 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bn1-20020a056000060100b00242269c8b8esm11176525wrb.25.2022.12.13.01.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 01:07:52 -0800 (PST)
Message-ID: <25d4ec8e-0de4-4f82-a3e4-a6ea5b07a75c@linaro.org>
Date:   Tue, 13 Dec 2022 10:07:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: imx_sc_thermal: Drop empty platform remove
 function
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221212220217.3777176-1-u.kleine-koenig@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221212220217.3777176-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/12/2022 23:02, Uwe Kleine-König wrote:
> A remove callback just returning 0 is equivalent to no remove callback
> at all. So drop the useless function.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Applied thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

