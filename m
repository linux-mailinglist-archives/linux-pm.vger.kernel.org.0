Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AB077DED6
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 12:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243868AbjHPKdN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 06:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243810AbjHPKcs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 06:32:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE871BEE
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 03:32:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31956020336so3295078f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 03:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692181965; x=1692786765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YC9zSjW5qJSLaHkjlLNtCDqndh0xP9swEagVyGknaqU=;
        b=wpEs/CpPrI3h+HCkYEr01NY3QqBMr2yKvpUYmnhgogr/P7kZSDcxaIQaawdGNRPE22
         j4f7zj5xJhTQw0gs/WT4tvtb8ZlQpWGHGnbZSkkzs2mHl80GvBaOiG2t7Yo8lm9ur8hB
         wHO3g/R4TgJZl0V0rcZcDlDGpFYodp9LSCYRQtLXTMtlEjWgmg/2TsL4FOgHsZlYZWqT
         XfcqNpEiLNdF3rO/ESTI8OmhsNQqpycYadi44h0f5Du7zaxfftvBrcG5RIqIvTKygTdS
         AyOUueRPAAPRtS8vd78zQlUqTsBGPGjtwT4pnpGGzHpKelJ7JqeGmdojyOa1JILm2Ecx
         lDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692181965; x=1692786765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YC9zSjW5qJSLaHkjlLNtCDqndh0xP9swEagVyGknaqU=;
        b=XxINc+tuVC5Fo02eI9lAFE/A0VPuvwp7vNHmc1b4k43zoA1ZKWhFO4HjZT3YyB2Fgs
         TMokqm8V7vtN0IUo2YSaO/N3ZoFj/iQrY5uPPA2qKOHC2jUB3RDYPY64bUS+Sd9BxSFz
         sr45YunW/aPMgJF5leHSy5gU8dE2UTZ0V2L/rG0Y08bzui81owhzC1/eU3iSsHoW3pvv
         Mf6LGWW3INLRCRVe1xbutUaBGkJQOR1UbglfvIxJP8Bnt6N4BUyJxNhzcqAhC3ZLg2et
         zoGs1bYDfjZzEkdcY4DhugQeTcROsYxVnqmk5Dd5ngn4dpTe9hJWkvZKaIR8cotdPnem
         elYw==
X-Gm-Message-State: AOJu0YxPVY4WiJgg8H1/f3exKGsYyiotzqchtfTFa7UplHWp/LFCvW+s
        2A0tBC1tT9GxQ9PzsW8RhMQ/qsZL6fPVBoXr/DE=
X-Google-Smtp-Source: AGHT+IEz3ZApHcg9tH0Wrn9dq79bBukMYWbSso0EoozDFpWboS2hbhfJ66cm9MP+tf15RtnZqY9vRQ==
X-Received: by 2002:adf:e588:0:b0:317:de66:259b with SMTP id l8-20020adfe588000000b00317de66259bmr3563667wrm.15.1692181965592;
        Wed, 16 Aug 2023 03:32:45 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l6-20020adff486000000b003143867d2ebsm20913347wro.63.2023.08.16.03.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:32:45 -0700 (PDT)
Message-ID: <87248920-c5d6-1ab7-db87-f0dc34b787ec@linaro.org>
Date:   Wed, 16 Aug 2023 12:32:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal: sun8i_thermal: remove unneeded call to
 platform_set_drvdata()
Content-Language: en-US
To:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
        rui.zhang@intel.com, amitk@kernel.org, rafael@kernel.org,
        tiny.windzz@gmail.com, anarsoul@gmail.com, alex@shruggie.ro
References: <20230811194032.4240-1-aboutphysycs@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230811194032.4240-1-aboutphysycs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/08/2023 21:40, Andrei Coardos wrote:
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.
> 
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---

Applied, thanks

Are you checking neither dev_get_drvdata is used ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

