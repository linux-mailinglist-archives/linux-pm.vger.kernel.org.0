Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88F57355DB
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jun 2023 13:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjFSLaV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jun 2023 07:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjFSLaN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2023 07:30:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07A6E63
        for <linux-pm@vger.kernel.org>; Mon, 19 Jun 2023 04:29:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f8f3786f1dso36611685e9.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Jun 2023 04:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687174169; x=1689766169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wLqkDUhOM58cxbBxnu/hyC38pz5+u7v4rctjX5PZ1kk=;
        b=yFMm8XUICQJ8I5rYUu+lYCCxbFfIGzjTYMQEJaT985vnIWHoUvgBE3AP9stgP/cxi5
         TwzQWVLIxQkBkfoEWZ3lxRYNzuw5EY0DtQmp5ZwPzqtxskJaXvUIAp0DMrFbW0zQid4d
         snzY/bx0zwBn+ZtT2OeYsgnu0M/d38xNFaHMC+S/KI9zpokfz568ZbiRkKWo8VW7kmnr
         HnoSDjX7aWx9rZ9yz5lFmWDES9N21tIyHIxAKzQdnwmXljsQ9V8G4LoOQIDrfU19f2VZ
         Y5v6JYBlRkm5eUznSK+Vj5333zrMoCqLD+gnomRb6D3gOEm2jC8L5CXv1DYLQl5xXiA2
         UR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687174169; x=1689766169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLqkDUhOM58cxbBxnu/hyC38pz5+u7v4rctjX5PZ1kk=;
        b=HnFvocoz5QSe8tMHrrfCwt/aRY0iGjiPhbVsuZs8Sx1oSGZHCoIOiuiAl6Y8A84erf
         gtg/XYagyBwJOr/LWdhuDG8pgVG2l5ae5573vYb56rOzGlTebO7PE6SXiJ+sCu/uWDzQ
         7k5VdjSsGcmcAsRoHQ8/KSG+F+XIlQQAJ9BwtzXHR9KvG+6eOhEUEj9PYOhVOnfnPPnS
         c+y8Ty2iFSsiY9V67Mqw3behW0bxiDHV3Aom4RxCu+cIrjvgphg+GuPelpy1v1qml6QF
         fxdt0ziiBNPimgbE1m245TlL6S2wM9BKVTsD7thOTaFggD9IujvgOPTz0FI2JGT6rntR
         59yg==
X-Gm-Message-State: AC+VfDwFL0sFGq5A3jVGR3OJoZEm+Ye/f6/5HhOThuU7dz2rqgHeCTk4
        9Fb5osDXKg6iQJq8Z/u3A4k4lg==
X-Google-Smtp-Source: ACHHUZ6MKC3sxe3z5Hb6e/JbduVA5LHQQz3xvf4OR7eMVT8FkOxxUoRx9lpKhkkq8E+z0gnQf7cXsw==
X-Received: by 2002:a05:600c:2182:b0:3f9:b2db:88e5 with SMTP id e2-20020a05600c218200b003f9b2db88e5mr1013177wme.32.1687174169451;
        Mon, 19 Jun 2023 04:29:29 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:13d0:1b6c:ce40:5429? ([2a05:6e02:1041:c10:13d0:1b6c:ce40:5429])
        by smtp.googlemail.com with ESMTPSA id n18-20020a05600c4f9200b003f9b3829269sm1670550wmq.2.2023.06.19.04.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 04:29:29 -0700 (PDT)
Message-ID: <498bfa83-8ba8-14f1-2da2-27d0793f762f@linaro.org>
Date:   Mon, 19 Jun 2023 13:29:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal: stm32: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
References: <20230616165641.1055854-1-u.kleine-koenig@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230616165641.1055854-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/06/2023 18:56, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code.  However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> st_thermal_unregister() always returned zero, so convert it to return void
> without any loss and then just drop the return from st_mmap_remove().
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

