Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2704D19FC
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 15:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347310AbiCHOHG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 09:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347296AbiCHOHG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 09:07:06 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4D249F8F
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 06:06:08 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so1564084wms.4
        for <linux-pm@vger.kernel.org>; Tue, 08 Mar 2022 06:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=YIiKmaAv0jfkwMQ3/YJwiKUInE3iPjcQmLg3VXVO7ns=;
        b=Twi5VphyBmw2kd6/DH9/5mzqFGHZ1pwNvDEj+Q/UmEh4goe5TbJBWNcDpoUG6fObxR
         0N6ZUmT3CWurqwzxqqhQZLJUvq76AUKBV6GZktT34RD3+nVzN8TYfg7pcYs5F2zJVnMr
         sp7ngWEPrXW9SLgk9i7g9jGm5kJ/otl7QQB3vGdnjYUU/gBip9zniZ4/HHFV6AFQXucQ
         blMrzY6YWF0fxx8HyrkBjhkomRAKnM+M26lRFBEv2HBZBuusGldIrRD2eRio2ZhjLTXK
         gwZf4tyBq9FqL7m2M2JsRNLBgSP4lxQsFgH3QiJ5wDW5nGxmZTGo2KLWFfKaSFedOr2d
         Ai9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YIiKmaAv0jfkwMQ3/YJwiKUInE3iPjcQmLg3VXVO7ns=;
        b=ynX03en3ZTCYl4i0/I4uDs525uHo+C+mxSTX2KSV9bE0qNCKymkbfhrttCesU5ZgLp
         uPtzT7aTX+NtIWSaNkOEEX4i77g5rLRdhvbjXtEBowo6UizTOMPdKc8EhItEbEFR0d7N
         w9tXciFCxdTFrdFbMQ0u8R9YkMKHNcsb+5kf4y95poo13GBokWZPrASTYDZNUadeDoZO
         4ZIGwuNM5G9zEWZ5Hdyobdazc7VFU9oq7AT0R12GG0JKRTUz6h4Qxt614G0JVC0dV/Zo
         g16W7WhNMe0radspA93XEQU1DQ8+J/QYbBvEu6uYzGVUidTdVinFsL7lIqYy879KaWkg
         M3DQ==
X-Gm-Message-State: AOAM533tTV8G2FwGw29CN5NLltzIEaNUXh36hmg+22+jhYtL8x2+ctRU
        dMF+M91CS43NT2XRNih28GeCig==
X-Google-Smtp-Source: ABdhPJyqc3uZctdMTU4CXLw5I0yjukAcwGJK6f9VsX4vNKTOQkzD3NVn9cnc+Rknx4ywALYX/tDL1w==
X-Received: by 2002:a05:600c:3d0b:b0:389:a525:7b92 with SMTP id bh11-20020a05600c3d0b00b00389a5257b92mr3852383wmb.152.1646748367242;
        Tue, 08 Mar 2022 06:06:07 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:6cbe:1901:15e:e188? ([2a01:e34:ed2f:f020:6cbe:1901:15e:e188])
        by smtp.googlemail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm2917880wmq.35.2022.03.08.06.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:06:06 -0800 (PST)
Message-ID: <2d120cbb-3919-9a14-4ea9-6e95423d10c6@linaro.org>
Date:   Tue, 8 Mar 2022 15:06:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] MAINTAINERS: thermal: samsung: update Krzysztof
 Kozlowski's email
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220308065648.6443-1-krzysztof.kozlowski@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220308065648.6443-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/03/2022 07:56, Krzysztof Kozlowski wrote:
> Use Krzysztof Kozlowski's @kernel.org account in dt-bindings maintainer
> entry.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Hi Daniel,
> 
> Could you take this one directly

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
