Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A291174B2D8
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 16:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjGGOMJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 10:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjGGOMF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 10:12:05 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDC92122
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 07:12:01 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so21185715e9.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 07:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688739120; x=1691331120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycpGNLsgt/ES0G1zwIWkJIdAtFjomLDl2xkjlXWSTo4=;
        b=DVbjMVlxHE9pu3YlBytLFnpsxwPBMrs4rpCRfT0334ztrG4dfj5UIdU8xKhSyHlI9y
         dGLp86nBHpb1Wu+ID9UCtE6PciybqIGVT99TKQf3pGyXZk5VATe4xCQLgdm8jDwy0J4t
         aw4jAa8+T0nz9r55f4c6Evev2l5Gqc6l5K0eSgnO3ZeyyNdDyYHbDCh7SnwkUciF2r0L
         eXqCFb4R0FaCMGVkNY6mryVPdOytgJr4TglhKevcsFBxYZJJLojSXS2c8UtF6mjIpuh9
         p22MJ0bzcWpPT1A5c6tcjU7D7C5B63Z/0/R/xV6iet0dSYSSVVFX1IOId8dTN6lYtbb3
         thUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688739120; x=1691331120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycpGNLsgt/ES0G1zwIWkJIdAtFjomLDl2xkjlXWSTo4=;
        b=G0imv6vmAvwQZKibCj5vWz9LyfDjNxIC6+rOqxcPwd72VZzdjM/nTUb/KayNyDoLo0
         yNrIqD37UzCr78Lq5D8bY/Ji2P9gM6vGW2ZuTZv3+1IzXWlAnaf9L1SUpylAoY+NhFq8
         IjcoEg+EgtjO7SoMgqQR/bn1AElHMkZDlr4CflsYewMBeBZcOYO4oLRJuLju2i89klrv
         O4VGXvxYf3NA3Xwyh2zrRJMd+Em1sqBERWlhO+tQVYEeTZJg0Z6zMo9gRz55HuvVYi02
         jKNJ12yqsqQLl7xr/ybNnb/eSUrD34TKNwmQTB29JmqyHfUWbmZsYDhdTvc7tfX33dbn
         ErVw==
X-Gm-Message-State: ABy/qLZwjij58N8I7LRPnY6gANbhupv/WvQPQgHNJnHV7pffiLgQJ9AW
        7yH6vF0GBknr9PkhBtnJ79lTcw==
X-Google-Smtp-Source: APBJJlFfVX3E+RmKYUQNq3SgciMbgNUkXY9Sjj/5oyQe0BzJbpLNP6WT1j91P4EKn7/5h62zHXUB0g==
X-Received: by 2002:a1c:4b0a:0:b0:3fb:d1db:545b with SMTP id y10-20020a1c4b0a000000b003fbd1db545bmr4005976wma.20.1688739120033;
        Fri, 07 Jul 2023 07:12:00 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id l22-20020a7bc456000000b003fbb5142c4bsm2579548wmi.18.2023.07.07.07.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 07:11:59 -0700 (PDT)
Message-ID: <6fb74321-2f85-1a08-e16e-97346bd7e82a@baylibre.com>
Date:   Fri, 7 Jul 2023 16:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 6/6] thermal/drivers/mediatek/lvts_thermal: Manage
 threshold between sensors
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230706153823.201943-1-nfraprado@collabora.com>
 <20230706153823.201943-7-nfraprado@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230706153823.201943-7-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 06/07/2023 17:37, Nícolas F. R. A. Prado wrote:
> Each LVTS thermal controller can have up to four sensors, each capable
> of triggering its own interrupt when its measured temperature crosses
> the configured threshold. The threshold for each sensor is handled
> separately by the thermal framework, since each one is registered with
> its own thermal zone and trips. However, the temperature thresholds are
> configured on the controller, and therefore are shared between all
> sensors on that controller.
> 
> When the temperature measured by the sensors is different enough to
> cause the thermal framework to configure different thresholds for each
> one, interrupts start triggering on sensors outside the last threshold
> configured.
> 
> To address the issue, track the thresholds required by each sensor and
> only actually set the highest one in the hardware, and disable
> interrupts for all sensors outside the current configured range.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
