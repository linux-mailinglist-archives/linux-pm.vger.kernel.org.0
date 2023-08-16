Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D1877DCC7
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 10:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243116AbjHPIwi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 04:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243171AbjHPIwR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 04:52:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C68526AF
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 01:52:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe5c0e587eso63058155e9.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 01:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692175933; x=1692780733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZF/nTYGo6AW2Li21Ls1m8D3SKJzTrxJCZtlOZBDuU7k=;
        b=gtqKb9bOjk1bosBMYoHQt15/YI3AowGeIPy7hx2pMkR+bxlJSMT96PCo6XaJF/0CY+
         5awBgQOqscd33S46Fpoc9oDU7iNHIwrgT0s0/g6KWvKQJOSEfMUU75yKvEWJC7g9cSAn
         8tArOgt9Ykq0WgEvBQfayMkOkW9cdCppdF/QfCOlTMwRcmoIBbKuikjXvLyR86WdRdvg
         tGZyRDP1oVVqB82zxEtcBdDn3jGt3fcaANqcaz/Pcu2SEg7cD9xTSa/LWwL7I8820nnE
         wsN+6E0s3Foa9qIDOjksQls1sQSrbUl7Z+GH3KrEydLRO0zPbFAMJ+GJKdQF73hnnKZk
         YjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692175933; x=1692780733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZF/nTYGo6AW2Li21Ls1m8D3SKJzTrxJCZtlOZBDuU7k=;
        b=TJTkfo7VNanPwxfBRaukXSyPYuRnqYP4exwCclfKoGgmnizklObP64VtjdN070q4Xr
         rCQjsbDaa+gAab3gGnckXsCxbwwgcbRqUlfZwVqA/42ytzLYXiobiTliXmylSzD+EotY
         2RBXrd/oQYP5yaGNAQeGZ35ha0JCKXKFRpMg6wgAAilSwIleLmHCuVlI1CZN0+AwXD7R
         Y8/NvNuLdKYATMdkAAH3epLwh6HhhyxKHC+Ou9d4ykjySATZyDYQk9jJGrW/jIH7iWsp
         C9ntKsnwAI0Ixt4vxV7+UBgApeYl6grFNcZd66RPAfU+wJh7Nbh/nS9PXxz/j7fDcklC
         pngQ==
X-Gm-Message-State: AOJu0YynzqdPjacVDPVRv6wtNUR9UsviThUH1aIqA5fU1OTGcNgk73O1
        L+E4O5dK9uz7TQgxfmBqMm0G+Q==
X-Google-Smtp-Source: AGHT+IFU7+fWoHJZgaDyV1OqwMo/9sJ3P6CAcyUM64PehXJvMQe4Ai52t2bXxImv6lcC98UcBoHxsQ==
X-Received: by 2002:a05:600c:289:b0:3f7:f2d0:b904 with SMTP id 9-20020a05600c028900b003f7f2d0b904mr905156wmk.8.1692175932743;
        Wed, 16 Aug 2023 01:52:12 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id t15-20020a7bc3cf000000b003fe601a7d46sm23473464wmj.45.2023.08.16.01.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 01:52:12 -0700 (PDT)
Message-ID: <69a2bef8-efcc-2ca2-debd-201555833e43@linaro.org>
Date:   Wed, 16 Aug 2023 10:52:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal/drivers/sun8i: Free calibration nvmem after
 reading it
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230719-thermal-sun8i-free-nvmem-v1-1-f553d5afef79@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230719-thermal-sun8i-free-nvmem-v1-1-f553d5afef79@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/07/2023 02:58, Mark Brown wrote:
> The sun8i thermal driver reads calibration data via the nvmem API at
> startup, updating the device configuration and not referencing the data
> again.  Rather than explicitly freeing the nvmem data the driver relies
> on devm_ to release it, even though the data is never referenced again.
> The allocation is still tracked so it's not leaked but this is notable
> when looking at the code and is a little wasteful so let's instead
> explicitly free the nvmem after we're done with it.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

