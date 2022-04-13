Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D594FFC07
	for <lists+linux-pm@lfdr.de>; Wed, 13 Apr 2022 19:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbiDMRFw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Apr 2022 13:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiDMRFv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2022 13:05:51 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366BA6A077
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 10:03:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k22so3560400wrd.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0yLDSxiCmo1vPfzkHClHDDByY1Ws1nWQQ4UZOm9UXtk=;
        b=HkYQBpchIPl+48Uab9cAoTU5Wjcd3uWlV7smQYZD+pLK3Tm1hL1OeZZdagNAJbFtla
         C1tWy5dUa21NCEhzzPWWaHZe337iuXcGOr/PF8RDPdSvsKDP/2qp/EbGCjvYPcHiMn5Q
         VCsNuI231/vXz7BSIelxfiAMinvTlSxZI9W+K076UQAoLGxECG8TWiw6Ih3j7BS3LyTM
         MefoWQJAwWV0EfslfPQsOZSPiZ8wzG0LVirmZuJcc1B/cvv2tmJ0TTq/Q4pI8Z48pTbr
         VpCnqcSLlTG3QtDa10XjtU3otMQMgNdLGHpUf1ZsOYiAaEMoIBLI6sMF6s85nV/wXGQJ
         La7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0yLDSxiCmo1vPfzkHClHDDByY1Ws1nWQQ4UZOm9UXtk=;
        b=Db2f648rJrE4uuqIzwGwaylCyPJVvKh/CbkMQfNzbzH8XzeMKYatas2E2UF5VIUI4P
         elNQ7Pa0N+pj/nWndkeTkBED6K7xU45kWqsXXeGWgvAtVls8Z3tOK1/ro/R1wGU42uRi
         AQbLSpF4rltYJFGsCDIQDlesXSyUMphJ3uOwiO5ZKtVJEipkE800TZ+2dVQjRfDtIDwc
         YMd+sVSU1XriIFakVDWi6oG3vOlJkbEXhMOSxei9KozKcdS0SlOaB3PwwsXh9CxgwBbk
         eUy/BkCzmIYaXI81luUJhyBt+aCcPxdQ2yF9a//rgwPbt2d6lpA9Xz+RFYRcT6/wLYU7
         PzPw==
X-Gm-Message-State: AOAM5313fx/XuRNo1VeWTQJzddCt8rbLgnFsmkQ/BSsUCgPUSQJdWDSK
        53VF1n1YZ6DB7mbPx8qWC/5x9A==
X-Google-Smtp-Source: ABdhPJz7yBEbdI93k1h+c7twYXWgjSi5VtNTTU5oAOtrtOWtupF+zOHTDOnEkOjtdX7PRjSU0nGCAA==
X-Received: by 2002:a5d:6484:0:b0:205:8a53:f365 with SMTP id o4-20020a5d6484000000b002058a53f365mr33059640wri.121.1649869408710;
        Wed, 13 Apr 2022 10:03:28 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id a18-20020a05600c349200b0038ca453a887sm3051782wmq.19.2022.04.13.10.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 10:03:28 -0700 (PDT)
Message-ID: <5bfca9d4-dd15-c766-b787-f96ea69f9914@linaro.org>
Date:   Wed, 13 Apr 2022 19:03:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] thermal: bcm2711_thermal: Don't clamp temperature at zero
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20220412195423.104511-1-stefan.wahren@i2se.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220412195423.104511-1-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/04/2022 21:54, Stefan Wahren wrote:
> The thermal sensor on BCM2711 is capable of negative temperatures, so don't
> clamp the measurements at zero. Since this was the only use for variable t,
> drop it.
> 
> This change based on a patch by Dom Cobley, who also tested the fix.
> 
> Fixes: 59b781352dc4 ("thermal: Add BCM2711 thermal driver")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
