Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798FF63ED9E
	for <lists+linux-pm@lfdr.de>; Thu,  1 Dec 2022 11:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiLAKYZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Dec 2022 05:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLAKYT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Dec 2022 05:24:19 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D147B5AE1C
        for <linux-pm@vger.kernel.org>; Thu,  1 Dec 2022 02:24:16 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g7so1782293lfv.5
        for <linux-pm@vger.kernel.org>; Thu, 01 Dec 2022 02:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MOKCsWU9dpS78BQKpOF6+3MH224JB/Yua7RRiJjPQZE=;
        b=hMt87amZFrubMI9BhGQjAJmTbGJ5ZsanZQI7+o9bTMXBR8XN628h/bA8frWYx+q1zO
         VvpdJDDR2JXc2KJ+rPjsUNbugjWnMEDOGpBi6y8nTEHT1gr0GyqXY7FcqmEByFbermXg
         zFTT8pBt4yJ2xxhQS46rK8/oRPTQzf8qvsvk4cXsZWp4gEA4/Cx9F9V0WLzM6VTxrfuk
         MKICrrCq9P7oMENjjYI1ZV4adN2y24FJbVgxWubNrYoyGpuJ4WSZmwUMRz1IqcOBYaeS
         ia7+IjdC2jvfws3MDfbaGQtxUiWj6WTSQOVWLOdnAW9j5Sz0Y+1WM0D7BuPlHDwi0rPR
         dq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOKCsWU9dpS78BQKpOF6+3MH224JB/Yua7RRiJjPQZE=;
        b=VM3lfjgSdyPmvKnv4jIVTTQfz4zW564rlC6Ke9UNQIN2h6fBt4b6Rz4Qx5BtIO6LzT
         cNCzVMcNhQjUda5kOpMsTIlXrP5PHklwfuLfdgQ5lg2golZLGi4hn8tRh0hcRXAqzjmY
         Y4G/DKfQ2Le4N/kbLVHNDCPOxOHxeXwGB54BVkOwIrABFnVkkjES21ioMvmA2vNk1enB
         OBS6KslmSNedkiqHPA/vojoTV9Myn5ENcRVu9Evo/XQll4Lc8hFdl+LbtEslyeTb1rKQ
         +slIIBERyefjjMOPWjDhyZct2Jtrd5RCIBydj1AeL3vC+TNUF7m/iXkTdtRwfcgRl4p6
         Sn5w==
X-Gm-Message-State: ANoB5plwg3DRDQAdsckrtzjrwOK+Eqca4Ev4Ee9gTJRaOGuRY9gZAigN
        ETdNKiXlfm0m7YAxdWlvO5kpGg==
X-Google-Smtp-Source: AA0mqf7r3BQ5/HpAV+glVVdTQU7t+frMVE2dbBkvTrDqpG+FKt3YhVWMYhPp8xyRfmLzXmCTRryVIQ==
X-Received: by 2002:a05:6512:1505:b0:4af:b5d0:695e with SMTP id bq5-20020a056512150500b004afb5d0695emr22904274lfb.6.1669890255214;
        Thu, 01 Dec 2022 02:24:15 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w8-20020a05651234c800b004ab2cb8deb5sm603169lfr.18.2022.12.01.02.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 02:24:13 -0800 (PST)
Message-ID: <2c83bd3f-90a1-7562-7fec-22b4aeeb6fde@linaro.org>
Date:   Thu, 1 Dec 2022 11:24:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: Fix maintainer email for a few ROHM ICs
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <7986d30480df6179a3989fba4cd13817738635c5.1669877740.git.mazziesaccount@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7986d30480df6179a3989fba4cd13817738635c5.1669877740.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/12/2022 07:57, Matti Vaittinen wrote:
> The email backend used by ROHM keeps labeling patches as spam. This can
> result to missing the patches.
> 
> Switch my mail address from a company mail to a personal one.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> 
> I did this a while ago for my email addresses at the MAINTAINERS. Forgot
> the dt-bindings and doing the conversion for bindings now.

You can also add mailmap entry.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

