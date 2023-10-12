Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235D47C7154
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 17:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347251AbjJLPYG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 11:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343999AbjJLPYF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 11:24:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AF0B8
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 08:24:04 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso11237835e9.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697124242; x=1697729042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=We1PipUaRJ2GmRv7NyqA8SqBPMWku7fp5p2NGcKu6y8=;
        b=ajGpRcEtYpHcL/8N/myAF5/Jndhkzr85EAjL8k5M3hiW/C6VlmFOIW77msi2f98Xgg
         FQQv+cPv1ZH3KySqW2LWPzz2JMthb0rw2B4wFGyPV0i+OJ/fgF0u3VYjXzcrTFMAL5jx
         y4kbDpSk/8lDFjZCIH6vlyAzhp0VFCWXgt2zSZ92GzuI2wecJ6WXAmYKP5jkDZtCmZm/
         djJDkE9A5p2QYcSbCG+3Al1xkoU4S7Wd+3AEde772zUjqpXrR7k7AkyphRQetLrUPvd6
         IUOfoxjvBBGwhW2uToLjKC4KdX6ss0vSdFhtS/mWCLisMH2uGPqd7WAk+TTu/tJO5tsb
         R10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697124242; x=1697729042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=We1PipUaRJ2GmRv7NyqA8SqBPMWku7fp5p2NGcKu6y8=;
        b=oM2qcGJFFkbgPG8uCu3dmrkjaGvenDleZH3cp4GOoJslsLJ4DVnqb3wrH7e21ZDVSI
         CQ6XzQnIqXF530611hPEUm2XE7t1bShhpHaKF60aM/54fWJtVJ2c5Jx/mGWHVIENm2cn
         njlI2BCv4pi6wXDwb0NL0qwuOFR2eJwBc6O3pQIVNvBV84bcaOuc9+ofID/w9MLprgHN
         iGVQZbwVY8boOmCsnlQj2arjz1Fyb7jNzS4craqe5GllZ4ASUlwxEeLjIFk5JoA9gnix
         45CbWFMUoI1hvG+d9/nGhKbE0Ku+QLP7Jt49y07X9qzjSO/zLNRFSKiKM3+qXCWqaRgx
         QW1Q==
X-Gm-Message-State: AOJu0YwRfNgKXtvM04u0vWAemDslVOLwMypO3Tq/5wHiorMU6fkBbREJ
        1xAWYq7nyQnK8Gr2d5N7XbNQFg==
X-Google-Smtp-Source: AGHT+IGaTzOx/6hybNBs9W8g0AcuD4Z+IJKW3BY68R2VfyDSeURDOB+dCGHwpPdaNmhmzzqe6VG29Q==
X-Received: by 2002:a1c:4c13:0:b0:406:7d74:a29b with SMTP id z19-20020a1c4c13000000b004067d74a29bmr21127609wmf.13.1697124242353;
        Thu, 12 Oct 2023 08:24:02 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id q19-20020a1cf313000000b00405bbfd5d16sm119132wmq.7.2023.10.12.08.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 08:24:01 -0700 (PDT)
Message-ID: <d248e126-2b0e-4f9a-adf4-94740dc472da@linaro.org>
Date:   Thu, 12 Oct 2023 17:24:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] thermal: gov_step_wise: Fold
 update_passive_instance() into its caller
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <13365827.uLZWGnKmhe@kreacher> <9177552.CDJkKcVGEf@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9177552.CDJkKcVGEf@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2023 19:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Fold update_passive_instance() into thermal_zone_trip_update() that is
> its only caller so as to make the code in question easeir to follow.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

