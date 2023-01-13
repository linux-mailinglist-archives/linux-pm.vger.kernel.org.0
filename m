Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1066693F0
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jan 2023 11:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbjAMKVY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Jan 2023 05:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241074AbjAMKUz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2023 05:20:55 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F7B7576B
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2023 02:20:46 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ja17so14932756wmb.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2023 02:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nAzNrVVW7gg1bFcsxBgDddUqhdnQKd+U+xlIh6TFquE=;
        b=secIgLArSbqiD/2YBc+7VJ3GTd7MGPC9ac8h4umbbBSOkoH58xi7PImMZMZlYJmIAm
         Kde7rWJOK3Da6jQDbLwpKkFW7vJTc4708F2CBr0eFPumSBrxDrYBJSYffSE78b0TV5iF
         AcIyAqqaN9B1nUnMocWdOYA3yjH9GJNHyuL3DZ0YuBecKIMkrk6FQqIKLs79tV2iT9DM
         D0e5ORnohomP3DVxxXBudgMARV1r3D81jhGTh4ma3haIbqtGoLy/lF+HxzdzDCbhE5zt
         6un+fLDkklev5EuCfotSCb/gzDjF7IMk3Lo9N4pf9DOHAYvkbQfoHpF4qurkD6AuOoTd
         3gBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAzNrVVW7gg1bFcsxBgDddUqhdnQKd+U+xlIh6TFquE=;
        b=BEMB86kgMPZYovtSeJjcespSWPoDWmBCDHhgXodzUkOhbURob1FSGeugwzJCeKrcU5
         wy2DU73Tgpoel1IpGRMoWCqNtaMiw9cUHBmKW5HCLLeESNoFlo0PGdmZnHjdaTTdO0uT
         RRSQuOTtY009E2zybfqp78n2pYOVElsTVkceHpMgZL7olthjrKwWegVBd3VxMxttI7S8
         2L3v40d6/+8uRvY79eefA953jlltTFr+sJO0EPLNYzlzrgbgJSN4Lz12/4edj0jLIrKM
         Ibkn7fTq/bGkqaHv+cYkbI7z5QyJaPvCl+mfRs4WXxhuCE9vKaTdfjo0dPB50nGBy1g6
         AzxA==
X-Gm-Message-State: AFqh2kqX/T9J82yLqjAxcWz7QRQxodYyN1j2t2jqrQqStTydDBus+Qy0
        WjNw6J7/14GICjkogsLAxznyypVYkzBrMIXg
X-Google-Smtp-Source: AMrXdXu8tuTkN+JKTWzEC1gT8vmsUxx0+pDWEp1BC/ReXUqFM78DKgQYFm6+Ng9wyTK/rgR/GJUV1Q==
X-Received: by 2002:a05:600c:1819:b0:3cf:8d51:fae1 with SMTP id n25-20020a05600c181900b003cf8d51fae1mr57896528wmp.0.1673605244705;
        Fri, 13 Jan 2023 02:20:44 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm22234922wmq.9.2023.01.13.02.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 02:20:44 -0800 (PST)
Message-ID: <89e2f479-cea3-0545-8990-91c9283d7e50@linaro.org>
Date:   Fri, 13 Jan 2023 11:20:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: uniphier: use regular comment syntax
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230113064507.17224-1-rdunlap@infradead.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230113064507.17224-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/01/2023 07:45, Randy Dunlap wrote:
> Use "/*" comment for the file's initial comment since it is not
> in kernel-doc format. This prevents a kernel-doc warning:
> 
> drivers/thermal/uniphier_thermal.c:26: warning: expecting prototype for uniphier_thermal.c(). Prototype was for PVTCTLEN() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

