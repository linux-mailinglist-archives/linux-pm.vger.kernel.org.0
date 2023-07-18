Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA007588B1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jul 2023 00:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjGRWqC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jul 2023 18:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGRWqB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2023 18:46:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E55819AF
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2023 15:45:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso64766235e9.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2023 15:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689720341; x=1692312341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0dM6vGQp7Yzqc9VcgY+1jMISgn/S3Msr5TJcQ3ba1vA=;
        b=w0bArvFa/qc2nxE5FLuei55K0a3o16zZL9S7p7nipeYsKhDa0w8YtFoBwLugBATvKk
         KQxIabqNDG0GX89legNxHyZRa5xlIt6r2E5wbTv6a/Nqy8tMYuhoSfHmQFB854Sf88K6
         N4N9dQilcLw9j/LtBXeCqty8DiDzW34bEbyTEMEzfWSxUfM33DgfvckRS3w0catafznn
         Kwp92At82HRvKajEG7SAi5XVQ0TaJLuB/mq5/20S8CDsaYefiiil/bddj/af0shg6Tyq
         BPTiTpSi2oGyFmFoB+i8MCmGfgwAFlvegtXdyBdhz2+VAunIRMV0c3ngDQCfrsgzhuf1
         RoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689720341; x=1692312341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dM6vGQp7Yzqc9VcgY+1jMISgn/S3Msr5TJcQ3ba1vA=;
        b=HNCyVjt8sQyo1PPCNcDn8XIjUHoi7t+lTqQ7lvBaqC2bjIPwWpN7QJfJYUKOUX6jk2
         LSf0i/k88OBeo2hfTsJJgXvH07Mc4eRlmqxt87nCfOjaVejI/UdY3096PqBXWOKvzOy+
         299DT8b+hyjoeqBW9d7xcC+riMjzP0QLV9XJJQ7IzQrXdqKpuPkkCAK3KEW22p5NF5LB
         ngLidyFthl2xQThnv+8aaDe4W+vc6drNcwwpqRppbtgBWUbFMf7QEKFyid+szO5KwZDs
         rjdXbkvW++kgbzgRGuaB0r9Q6PA02/tHbaNmDFradaiycutD1XgHdwSsYpaTjma4TteU
         aUVQ==
X-Gm-Message-State: ABy/qLZ2ZzNqUZAo5jsKdKMmWEPt+1QZY4sGeCviqntByazzHvMPMgdU
        XURX71Id/NVypbT8MvsMY5Cv5Q==
X-Google-Smtp-Source: APBJJlGhrcrJnFIlEMLY7hs8MezIOypcFTEuP+BkeBlFBEbnXYeMU1V6y+qZVPPihG8UxOO6tUbYbA==
X-Received: by 2002:a1c:740d:0:b0:3fc:70:2f76 with SMTP id p13-20020a1c740d000000b003fc00702f76mr3048258wmc.20.1689720341326;
        Tue, 18 Jul 2023 15:45:41 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bh17-20020a05600c3d1100b003fbb1ce274fsm4382033wmb.0.2023.07.18.15.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 15:45:41 -0700 (PDT)
Message-ID: <8b89f009-bcfe-3a90-f19e-0b5894a5ebd1@linaro.org>
Date:   Wed, 19 Jul 2023 00:45:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 0/7] ACPI: thermal: Use trip point table to register
 thermal zones
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <13318886.uLZWGnKmhe@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rafael,

On 18/07/2023 20:01, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This patch series makes the ACPI thermal driver register thermal zones
> with the help of thermal_zone_device_register_with_trips(), so it
> doesn't need to use the thermal zone callbacks related to trip points
> any more (and they are dropped in the last patch).

Yay!

> The approach presented here is quite radically different from the
> previous attempts, as it doesn't really rearrange the driver's
> internal data structures, but adds the trip table support on top of
> them.  For this purpose, it uses an additional field in struct thermal_trip
> introduced in the first patch.
> 
> I have run it on my test-bed systems, but this is not too representative,
> because they each have only one ACPI thermal zone with only one (critical)
> trip point in it.

Rui created some ACPI fake tables I was able to run them in a KVM 
machine with fake thermal zones.

I can share the setup if you are interested in

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

