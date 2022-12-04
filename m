Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531DC641DEF
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 17:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiLDQfb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 11:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLDQf3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 11:35:29 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA65112D29
        for <linux-pm@vger.kernel.org>; Sun,  4 Dec 2022 08:35:28 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so8291939wms.0
        for <linux-pm@vger.kernel.org>; Sun, 04 Dec 2022 08:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NgLhDQ3h2DNCcZbHVmbcSC5B8MM10iPbjjewq19xUhY=;
        b=utdfQjoTjOR9N+XaQ2Qv2LTPvXuptLuZoXE7gCcyliPDPCcvRtUZdpqvYrIpofvM4B
         QCV7v1Mq4k9UtJGk47ug34+HaArgGw8pw9pNQ6j9+lw0bu0yYAVdp0m8L1dgXgg2RwbH
         g6WnsLmwID4JfY2FKOVFpDp0r5c+RNuPmtxPV1xQ/dV4GjXRhVA8Xri7gCcnQk93ZSG3
         rDtb8UvO4Tcxlzbp1EYZ7CUK+ZjTyaYkHmYkh/7hB9Fq4T/9te8oSgd3XyKmYIaloN9d
         8J9iivJMzFrf4F9hmxabFiamZtpNspqNgmy8SfSJe4C0kahpOlSip+8JAdCCyVep7XC5
         UhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NgLhDQ3h2DNCcZbHVmbcSC5B8MM10iPbjjewq19xUhY=;
        b=cjHkpiD3cIAORncau5zom3AlOURZWdZdgOq41kJLz5QOoSeY4mo+nxgT1G61n4Fplm
         yk8TlWnvpV8tuX5xR6ZwTk9H/HyHzXsv1oWJJy25FV3vt4+9uYn2DwDYpr3ihBWkm7is
         KLkMyLjGNhsruLSi+LxT1+BmR7DOSLnFnh9+X+paTBSNy6zwBm7NAq0roxuRaHZpG26q
         4UbpSH12S/oiB7TppHLjqAogP0qUDa8q9LbLodEGj7mgRN7XWBVfTAcIUy+PhJU0aIGk
         DV3T9nsJ+R6RTtqbqX3i5W5wPWne+6z0QVT4g2KRgp09htAPcwir6+HTBn7myeYO0S7o
         b4Rw==
X-Gm-Message-State: ANoB5pl7PsRvhWM0zHiZVXSm67Lzfk6/Hp+rRZ6FYCviYW5R7vlC7ItV
        DObyt83cEJZqAdrXCq+Hsf1W+Q==
X-Google-Smtp-Source: AA0mqf6EVGXn/Sj7OVJ0ZDHDfgC87RfINcdRrP03nB3j4eUlNnMon615Cihs2rX7n1UO58Y2JkEKXQ==
X-Received: by 2002:a7b:cb97:0:b0:3cf:ac0d:3f80 with SMTP id m23-20020a7bcb97000000b003cfac0d3f80mr43474835wmi.185.1670171727279;
        Sun, 04 Dec 2022 08:35:27 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id k4-20020adfd844000000b0023659925b2asm12293231wrl.51.2022.12.04.08.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 08:35:26 -0800 (PST)
Message-ID: <f92346e3-8b8a-e5cb-2c9c-638dc60734cf@linaro.org>
Date:   Sun, 4 Dec 2022 17:35:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: qcom-spmi-adc-tm5: suppress probe-deferral error
 message
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221102152630.696-1-johan+linaro@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221102152630.696-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/11/2022 16:26, Johan Hovold wrote:
> Drivers should not be logging errors on probe deferral. Switch to using
> dev_err_probe() to log failures when parsing the devicetree to avoid
> errors like:
> 
> 	qcom-spmi-adc-tm5 c440000.spmi:pmic@0:adc-tm@3400: get dt data failed: -517
> 
> when a channel is not yet available.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

