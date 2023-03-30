Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5D56D098D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Mar 2023 17:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjC3P3b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Mar 2023 11:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjC3P3Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2023 11:29:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C761E07C
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2023 08:29:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so12057276wms.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2023 08:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680190132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGsCmW7EUS3nfy+7BnW+WgqTabyFkZU2nitm+ST7mKI=;
        b=gfO4wBAMcJ8t0kHqH3xynuzyyJtZvI+YL4+NG4UxqIGIKLSk/xeTl9+QRt0iGEMX78
         lQuRe1xmTJx/kG4vG/MRGVaWIzpRw4kxDOewTMPZ3zQZOrnYPQUv1elti0HcD6zry7iE
         QpFJlXVAw/c0/QOdVRskbll0h55wlArViYWeAxqpnFZaq14KttfJuCEzqqL4Ic+KdNeZ
         vGMKORaRMZUmXug8ZScqebP7bntofChz5sdm1Y8o+Q+ojC8BcpbzprXgt3Zr45HhqhW6
         Uo51KawFOXgSypTUNxCjaszoGWxh05pyb1jB5kL7NQM7g+ZHZv3Ri7ISt/sK7ZvPadGS
         xFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680190132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGsCmW7EUS3nfy+7BnW+WgqTabyFkZU2nitm+ST7mKI=;
        b=Xya9uMeqgswwwQ+O6ASskwUelzVI2jUdmkeCG+Qbu4ychwlSUR9BzLWz6/g7v0HUzR
         3be9KD0bt3o+IDnPbGMFCZN9rlNcB9JopBlT2JsOph7tP6GzKj3qE3gkMpTBtcYYVc95
         doCcbLPomb2qyAFM1vW4XhNsKVHQxm7R6OUxgZ8b60+VUnd8d+OfWn4rh6w9eT6givXB
         Ao+u95B9J0aTdwR2glX5PAkBICLotlu6kS6ck+kSsm9Hg3RPEWhAYgBjDiGDHjW/fz4m
         qzkKr29XeScUY8hrGSeeIsf8zFF6AShN4ddhaPEOhYKP1KlMfN8GlV2aRN2AELbdsf0M
         39Gg==
X-Gm-Message-State: AO0yUKXVeUmrXX0L38lfIHT+S5RNjs+8lVUqqQICOtAC/PIS7jMgV57x
        2xu8IbyxLisqdACnqiATkAdY/gQ5HwxNLuBF73I=
X-Google-Smtp-Source: AK7set9JBCqQOXk+u/rw68P8YwukfO3REwzC5Umey4FtmvcIbY6E6CbTxzim81BNiRT8Js8+wSeCng==
X-Received: by 2002:a7b:cc98:0:b0:3ed:2702:feea with SMTP id p24-20020a7bcc98000000b003ed2702feeamr16821936wma.41.1680190132118;
        Thu, 30 Mar 2023 08:28:52 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9ee7:40a0:eee0:62cc? ([2a05:6e02:1041:c10:9ee7:40a0:eee0:62cc])
        by smtp.googlemail.com with ESMTPSA id s15-20020a05600c45cf00b003eb2e33f327sm13485297wmo.2.2023.03.30.08.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 08:28:51 -0700 (PDT)
Message-ID: <95fce357-87f5-93b2-c57f-f561a79dfc34@linaro.org>
Date:   Thu, 30 Mar 2023 17:28:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND] [PATCHv3 1/7] thermal: rockchip: Simplify getting match
 data
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230308112253.15659-1-sebastian.reichel@collabora.com>
 <20230308112253.15659-2-sebastian.reichel@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230308112253.15659-2-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/03/2023 12:22, Sebastian Reichel wrote:
> It's possible to directly get the match data in a generic
> way nowadays.
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

