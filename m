Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED476716D8
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 10:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjARJAi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 04:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjARI7R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 03:59:17 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F105F39D
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 00:18:50 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r9so10290959wrw.4
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 00:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0hEkd0ysfwynvDAeHLSyvcKkJlGfnDtvDBH2lgZqaw=;
        b=Cur0e32YY5qCzlLEctN2Zb27XLMLenD+PXApcuhhXMBNQ9PIX5L6ScqlqwdNHGhNsT
         PcenlLH8b698Xq1c/EGrWPzU79lxakgqOA0WkW/0cyho/gxytfJViDUUzZYH3F5mOWWP
         ZXSdvahBjh5DToovwXVepk9VMKz5lIlA+G0VTddjGi44jTCDe0WKOaL2lpapvBilb0WX
         IfkQz6WzLUg2eQSi9k/fRuAfy29xUnJ1+pQqoghCgmQ59q0Ov6fyru0rmo9b2krwUXnt
         UOSiUPK40u+kly90yjudihJojN/zaq7Fjn/bDh0f2bQwdECaLfoeDwLM7KaRpcSgxLbP
         TkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0hEkd0ysfwynvDAeHLSyvcKkJlGfnDtvDBH2lgZqaw=;
        b=tg1o02oNbruIHlLGcPdIwY8cZvvtVtFVaoWXoawGP/c3xEL0ZSFdCs8MpsuyUY2uty
         xoAYlBBhTdjVOi4J9Kjw+ZcxY2wXjmGd03OzxY1pnR+ne0qduQDI5mHTocnk9wSPhm1X
         6ZVIWAhI/4skA2mS8lJCuoXWSkxl9f37NlnvXmCIc+LULFjrziKDVqd7Tg3K3FqUMpek
         yfnTwo8kMJFZU5XPUMOkFArXIDHF9A2D5+EYjHJvB59XgLRwByJ4kDRYwvLVaUpjIsyY
         Jwl6IONxCteBhFlvM5/ES0nYvaGiqJpicT8vj/RToWMH+zRprMfkKLg0wAEUoU88LBSL
         6YxQ==
X-Gm-Message-State: AFqh2krnEod7iPcAy+abusIzIAvF8igQvhpnAcpoaXby5JC9zsQvIK0x
        2SfyOiOjHTi3iIa67ZkzaSy3eaN8uxNO9pxc
X-Google-Smtp-Source: AMrXdXsBQGUlE7qI6KECAJ7MOJ6Z+LkSVfm4jetRokZ6qobuXFx5t7ftxvGzwd2hxlLMLBPSGDt58g==
X-Received: by 2002:adf:dece:0:b0:2bd:f671:22b with SMTP id i14-20020adfdece000000b002bdf671022bmr4774137wrn.55.1674029929105;
        Wed, 18 Jan 2023 00:18:49 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w5-20020adfcd05000000b002bdc914a139sm20958509wrm.108.2023.01.18.00.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 00:18:48 -0800 (PST)
Message-ID: <2608bee3-7571-dc82-caa9-0aab2735512e@linaro.org>
Date:   Wed, 18 Jan 2023 09:18:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal/idle_inject: Support 100% idle injection
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com
References: <20230117182240.2817822-1-srinivas.pandruvada@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230117182240.2817822-1-srinivas.pandruvada@linux.intel.com>
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

On 17/01/2023 19:22, Srinivas Pandruvada wrote:
> The users of idle injection framework allow 100% idle injection. For
> example: thermal/cpuidle_cooling.c driver. When the ratio set to 100%,
> the runtime_duration becomes zero.
> 
> In the function idle_inject_set_duration() in idle injection framework
> run_duration_us == 0 is silently ignored, without any error (it is a
> void function). So, the caller will assume that everything is fine and
> 100% idle is effective. But in reality the idle inject will be whatever
> set before.
> 
> There are two options:
> - The caller change their max state to 99% instead of 100% and
> document that 100% is not supported by idle inject framework
> - Support 100% idle support in idle inject framework
> 
> Since there are other protections via RT throttling, this framework can
> allow 100% idle. The RT throttling will be activated at 95% idle by
> default. The caller disabling RT throttling and injecting 100% idle,
> should be aware that CPU can't be used at all.
> 
> The idle inject timer is started for (run_duration_us + idle_duration_us)
> duration. Hence replace (run_duration_us && idle_duration_us) with
> (run_duration_us + idle_duration_us) in the function
> idle_inject_set_duration(). Also check for !(run_duration_us +
> idle_duration_us) to return -EINVAL in the function idle_inject_start().
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

