Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEDF533D00
	for <lists+linux-pm@lfdr.de>; Wed, 25 May 2022 14:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiEYMvi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 May 2022 08:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiEYMvh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2022 08:51:37 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51F39D4E3
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 05:51:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c5-20020a1c3505000000b0038e37907b5bso1071454wma.0
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O9h3T+Zmsq+gsSjavzG80oSaUN7uUIMz2AyYp3GE7EY=;
        b=D5qx041TUB/Ueiuu9L+xJI9aIGJjacpJ0Ua9B8v4YTwn9+abXYd3va2HU3pbQBFVCY
         TABWhlkGHbyv/z2k4fqApmmDNyto5jki5N4Makr135HVBQDIxZONHr4rU2ol0HNV6lh5
         V1vVM1px9mo03P62GOk0tTIkeyktTXooDSB+hgreCFOHaLh1MZL8v++MELmuqHZWooFx
         JRS/GwJmFpfIC1LVAA9kRddrRiPVW6xvAWgR+Qf7AcRRE8QNYe0YCklCJXoXSUmyx11j
         BdiOhOTwlU+eM/4m+w2M5hxaSL56JvRTBnFVTp5zC7wgVXwEN9c1uHJzBZmEtGIvAgM5
         LjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O9h3T+Zmsq+gsSjavzG80oSaUN7uUIMz2AyYp3GE7EY=;
        b=kx18ZjLzqU7jeJddLyPy5nDVRQjFY7yzFNApOod9iyGYs+ihKGi8Wjqx9JhITueM+h
         tefgCu412sOZGUqzsTbaz+ay7w4fhdIvY3MM0pa8SSmXPYoCS9/lNf4oIgFxPgfTEiR7
         QOQUZVueKD4CVhYA5GqnbRsOxmJRMMUiqESgRroW9+OdinACX3MqgjeFX01nrXHA2Zuc
         XOvIGWplqQNCgTXU2eOXyCcGoN34r9yod/rDUwux4QLJOFWxZs0y/4bSTwH3P/88ajW8
         LL9t1sZiwW5i+2C7PfBA8BVa6lU5ZotkMsmJxMRkl7c314O0P2WvzXtabdc6BWhnRD/+
         N9vw==
X-Gm-Message-State: AOAM530c7dWv6HgnkHQJUmqDiAPESDeozGtRls88jhZIxUqKoIeuae7Z
        rj8vXzlxPMO7/GW1aiH1I1l2MA==
X-Google-Smtp-Source: ABdhPJy5XKfq1yokbHHFsQxJDwadX+psJHwzNX2vKGsEXTGquqSIJWW+fIEoDLvYg/ffeMQpKSJ66w==
X-Received: by 2002:a05:600c:26d2:b0:397:49cd:2cda with SMTP id 18-20020a05600c26d200b0039749cd2cdamr8195843wmv.141.1653483095255;
        Wed, 25 May 2022 05:51:35 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 129-20020a1c1987000000b00397550b387bsm2270838wmz.23.2022.05.25.05.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 05:51:34 -0700 (PDT)
Message-ID: <ef871d78-12d2-e19e-9a12-6288256116a7@linaro.org>
Date:   Wed, 25 May 2022 13:51:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/5] qcom-cpufreq-nvmem: Add msm8939 with some fixups
Content-Language: en-US
To:     agross@kernel.org, bjorn.andersson@linaro.org, ilia.lin@kernel.org,
        rafael@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220418162226.2983117-1-bryan.odonoghue@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20220418162226.2983117-1-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/04/2022 17:22, Bryan O'Donoghue wrote:
> Fix up some missing compat strings for the qcom-cpufreq-nvmem yaml.
> Add in msm8939 as a compatible qcom-cpufreq-nvmem.
> 
> Bryan O'Donoghue (5):
>    dt-bindings: opp: Add missing compat devices
>    dt-bindings: opp: Add msm8939 to the compatible list
>    cpufreq: blocklist Qualcomm msm8939 in cpufreq-dt-platdev
>    cpufreq: qcom-cpufreq-nvmem: Rename qcs404 data to cpr_genpd
>    cpufreq: qcom-cpufreq-nvmem: Add msm8939 as cpr_genpd
> 
>   .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 8 ++++++++
>   drivers/cpufreq/cpufreq-dt-platdev.c                     | 1 +
>   drivers/cpufreq/qcom-cpufreq-nvmem.c                     | 9 +++++----
>   3 files changed, 14 insertions(+), 4 deletions(-)
> 
ping
