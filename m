Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A31D2632A1
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 18:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgIIQqh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 12:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730940AbgIIQHk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2020 12:07:40 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3C2C06134C
        for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2020 06:58:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so3057568wrp.8
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2020 06:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:autocrypt:cc:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eBH73PCNIO1FFhctRAZbYzQQykgJUSLfCaIpA+XFJt4=;
        b=ah7HF7exP4/EXw0luSSJj977PqTSCiirtUGfu/aTG2ZS6fmJwKPIYCQ7I8uflq1TAO
         kgtK+5jE9A+7XLIhfhdQhpLaOZNRD2TeLhX6aZmfaSy8EgjlveuRS4KwhbnBgw2vapD0
         J9zFbUu9LSOQNIDZ8MlWqsdnu4trcBuRU3VN4Kvg5oqqVOBa/T9voRKZad7ObUulF4T3
         u7iincLtfCoMDAl50lz73DQkm0Dyqnv1XJqgKXRPqjCXA6xPVH2aR2aS2tNWmFh8MjV6
         W33EIkW6w2uyHavMTTVyeZGPAYn+8CDlneEVichmE61jOGdaGrN3m/0tXdr2XmWb6GKb
         Q8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:cc
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eBH73PCNIO1FFhctRAZbYzQQykgJUSLfCaIpA+XFJt4=;
        b=Eu7ZNnW9ryDJT9kxUIO3gPOQ+xZdAXAO4HUv5tUOgD6yErqDhPLTr7X59JOKhle4Lu
         dk6qwcJ4hygRZ5rUWN2i9GoNRWFayp5dtf8nqLr8BAGXPPTrAvbeFkUKFTwMCgbBpe43
         Myhhcwe5/S/SAJ89llx3RFcbVe5DqrjmOqJFHNVfVt6z6NZOhDbcloG6wHSIY2/03vUx
         OHNAn7+/1iYjKjy1h/DjsEXrOl45Waj3T9+1+gaBThJhEdIMgGw1QVJ24QIMa3hhEAVp
         0L9+FTza/A600pFLMKhtLfe/wv8jsZEoqbXSb2CaxSICg/DZ8AHE+9dlGhpuMnizO0Xx
         Shfg==
X-Gm-Message-State: AOAM532U+040G+mWywV68AsITjyZSLKCIeICaokTQSx/o+G1K5kSfU+m
        xZTlQTwkw52Gf8Dj0JNyBTqXs540vN3mpg==
X-Google-Smtp-Source: ABdhPJwAzRykE3ZncAPBm3t3mtmCJo0wHvEUg2GwTUYRbmReWKA8t4cFQ3+QN1CYV8Z9piKg/2HWoA==
X-Received: by 2002:adf:81a3:: with SMTP id 32mr4042031wra.368.1599659900838;
        Wed, 09 Sep 2020 06:58:20 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h17sm4586643wro.27.2020.09.09.06.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 06:58:20 -0700 (PDT)
Subject: Re: [PATCH 2/2] interconnect: qcom: Add MSM8939 interconnect provider
 driver
To:     Jun Nie <jun.nie@linaro.org>, shawn.guo@linaro.org
References: <20200831075329.30374-1-jun.nie@linaro.org>
 <20200831075329.30374-2-jun.nie@linaro.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Cc:     linux-pm@vger.kernel.org
Message-ID: <0df97fbd-f0f5-3719-cebc-1d7525a43e60@linaro.org>
Date:   Wed, 9 Sep 2020 16:58:19 +0300
MIME-Version: 1.0
In-Reply-To: <20200831075329.30374-2-jun.nie@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jun,

Thanks for working on this!

On 8/31/20 10:53, Jun Nie wrote:
> Add driver for the Qualcomm interconnect buses found in MSM8939 based
> platforms. The topology consists of four NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/interconnect/qcom/Kconfig   |   9 +
>  drivers/interconnect/qcom/Makefile  |   2 +
>  drivers/interconnect/qcom/msm8939.c | 576 ++++++++++++++++++++++++++++

All this looks almost the same as msm8916. Do you think we can we move the
identical code into common file and leave just the topology and the msm8939-
specific stuff in msm8939.c?

Thanks,
Georgi
