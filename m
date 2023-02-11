Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F518692F77
	for <lists+linux-pm@lfdr.de>; Sat, 11 Feb 2023 09:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBKImn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Feb 2023 03:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjBKImj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Feb 2023 03:42:39 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9C410EA
        for <linux-pm@vger.kernel.org>; Sat, 11 Feb 2023 00:42:24 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso297964wmo.3
        for <linux-pm@vger.kernel.org>; Sat, 11 Feb 2023 00:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zm6tZzRPpLSdwewPh8Cjrqb6SnkkB2RFD3sd4GX+fHw=;
        b=S+FPrS/QS8u9WryS2/v6coBIg+7GlDMlyFWoFwNhxF5YxP5AEQqllk1poQlnlj+QDu
         MvTdgR8CWrmWLLrywFq3AdMBSC7UlYwB8XuXd95LC7vBSFF/9lcitIJ2V51UvDOoQl/u
         KmEbenkg83E+86olCC+8+a/5tVxa8dVonRTTVKN1NLhxRSISM6BnZqD0ah1oWPi635i9
         8D/hWEUwU1UOGJFeV0BiEtFm2BVQ3Ls8vGK5s1Be3+Qv49BdD57Y5nJuVPsp+JVWonc+
         9J3vLyfHogDHPrQy5wFK4zrRRAKpuhIsEmxrVmIUhQRyG0snV92vP5dUNCB5uOYyhGzn
         ONjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zm6tZzRPpLSdwewPh8Cjrqb6SnkkB2RFD3sd4GX+fHw=;
        b=X/YKJEMYtqHJcalvCgeqibBlIYHBxNIPlZmBcsO4/pCg9hBoAcCZ82nbuOvE0fZ8sz
         xTxFLrTNrhmF3oSdg4qcLf51w09BoOVCmk9CJCb9xAP4uGAELiVW1EWiMIQN4nG0rPVZ
         cA/lv+i7yZIt+Rc2hebeE9OCkNh+oMC/snV3ejLXfWOwRYS87d8kXGJYIvxUOiTAXd0D
         WV8bZixzvizLMjvTQIwE6xTxcf70Oyp5bX/3vttCKXNAxdj866sppli46bGF6moo79AT
         Z7GIuorFddE7KslJt+WnLVGGEr5FL8Su4VM3vG+efWfVsxtvcNhRW9oXWfA5X5kevOk+
         tLPg==
X-Gm-Message-State: AO0yUKXWHeDd0k/lxHkHUTzI31a1vbJ+E9p6C3DeQmmUBwmz6Xg2/7mT
        IRmSPGYjTN4qDzV7MKXUBI5AXs63ad7jIg7t
X-Google-Smtp-Source: AK7set9BYdQ4oEJkhYxqqAaCp9+jRYuzSeBKPpn0nIirSY68afikmcswjhCqbJBPr0cCU+OguxkRRg==
X-Received: by 2002:a05:600c:4383:b0:3dc:57e8:1d1c with SMTP id e3-20020a05600c438300b003dc57e81d1cmr18324261wmn.9.1676104942876;
        Sat, 11 Feb 2023 00:42:22 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id i20-20020a1c5414000000b003dc53217e07sm7769913wmb.16.2023.02.11.00.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 00:42:22 -0800 (PST)
Message-ID: <f6df8325-5e68-57fc-c8d5-26f42fe983e5@linaro.org>
Date:   Sat, 11 Feb 2023 09:42:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] tools/lib/thermal: Fix include path for libnl3 in
 pkg-config file.
Content-Language: en-US
To:     Vibhav Pant <vibhavp@gmail.com>, rafael@kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org
References: <20230211081935.62690-1-vibhavp@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230211081935.62690-1-vibhavp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/02/2023 09:19, Vibhav Pant wrote:
> Fixes pkg-config returning malformed CFLAGS for libthermal.
> 
> Signed-off-by: Vibhav Pant <vibhavp@gmail.com>
> ---

Applied

Thanks for the fix

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

