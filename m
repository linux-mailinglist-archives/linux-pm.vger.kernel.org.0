Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9E78BE9F
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 08:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjH2Gmd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 02:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjH2GmE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 02:42:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEB918D
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 23:42:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4e6so701244a12.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 23:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693291320; x=1693896120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FjfPeAhfUYBw/sXIgz8fmHiXM0sr1IQcX1df/SswdE4=;
        b=VuhACe9AiWTu/WV9z8211V3yy1g2LRWqtdEvx0zlz7tzFvGeb2FkT7M5FQZSrrIxfm
         4ex8HVLmHKTiUkGfUVzYyB+RPiIosm5kHUNsR/tWJbltCYZyWciRq2wgOZcxQh3/pZs5
         yMKcSmKU/1Pco6PIseuKUQaby9oyzOX3OfOUWG3/QxZ/arXk8KPGL3mPq3KH4n9sHYgw
         zYEhRiycXviWNI2zT/6WlPy2YsoUJed5Ie8LfDK7l+JzBFwpad6Xus3QiSLioIU0roni
         MaEL1aj/8uV5e4EGdobgD3/UczFeziqM7qCqTFzPsmivhnBOSzA5KalZGnT7B3y+A37e
         rrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693291320; x=1693896120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FjfPeAhfUYBw/sXIgz8fmHiXM0sr1IQcX1df/SswdE4=;
        b=VScFiNpKBGpqVBU5vihLmD12WdAMQaumCfsKxk+RgSWTp6NCCmr217PWNvF3DMfPH9
         V+2r6rPAemVYT5Vr+7i+oEaO9pwuKpYBSI8+xwJmrREEu5spxTcjm9CseqCYx4oz/E3q
         FG7YZSu8nvTFqIPchLsQAMMQBFbx1+EyCXLbXpFAnWBopit3NfYD2FqoG3tHdnfH5HOK
         SUe4txXPGA3/NfVgV6DMrpsVgLEpVOX1FMJVxI1cK59OMBSSVxhJ4tQ5LRWiKFN9MmXh
         9m0zxa3xN55SB+ztdHoG6v4zLoWXR005J1pV5MTQzY9l4k0VHjcYK4Ic+Tu+7VVGaCAJ
         4QOw==
X-Gm-Message-State: AOJu0YwaV2MVO9Pe74U7Cei98YSNot2aYxFkD+QUjRMtQUpwlzAFCE8d
        B70KhVBdWES2Zx1RG9TW6MUdyQ==
X-Google-Smtp-Source: AGHT+IE2hnf68ZZs5cjHk7ilR0OikTToDljPRaazsKZjQ74t15LWrQSogMSxNi+uen/atOSHa2B98Q==
X-Received: by 2002:aa7:ccc9:0:b0:523:1ea3:b9a6 with SMTP id y9-20020aa7ccc9000000b005231ea3b9a6mr20326288edt.39.1693291319940;
        Mon, 28 Aug 2023 23:41:59 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id o8-20020aa7d3c8000000b0052544bca116sm5286014edr.13.2023.08.28.23.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 23:41:59 -0700 (PDT)
Message-ID: <6aa6f1b0-0ccc-c2a7-8be1-ffd444193400@linaro.org>
Date:   Tue, 29 Aug 2023 08:41:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/3] dt-bindings: thermal-zones: Document
 critical-action
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>, daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
References: <20230828195902.1645169-1-festevam@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230828195902.1645169-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/08/2023 21:59, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Document the critical-action property to describe the thermal action
> the OS should perform after the critical temperature is reached.


We see that from the diff. You should explain here why you need it, why
this is good idea. You should provide here answers to my concerns on v1,
so you do not get exactly the same question from Conor or Rob or anyone
else.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

