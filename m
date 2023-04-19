Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576736E742C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Apr 2023 09:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjDSHlg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Apr 2023 03:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjDSHlA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2023 03:41:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226229773
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 00:40:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f09b9ac51dso84807515e9.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 00:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681890037; x=1684482037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TdAF+ibqcFz4f6UdI5r5abisS6qF8hg1G7lhZkeAXYk=;
        b=BfbLruzbZXWfqzZ3zxLzyF8TUbZEB/dqtePUEBJC9VGlEGntmEqBL8S43nzFefkEHo
         1XS6njc7OJKnT6PmsgBi3jLJTsoas3icCqyD8cL2pGM5bS2K4aOejmYpm0AB4+J/NaCL
         Z8ROYe6XwwMaqUZ42rnlDmWzID/rNw57tFSURGS0qM5OdKtzbn8QkgTdncMAgjPPMk8D
         UYoIpME+xD+PtmLkeU389Z0wL+18w2FhaCH30zqkwFt8LZQjgA5oLrnRTkbKG3UYebpi
         pTQFvjulMDHNFeurQy5b3a/Zzz23KPbi7YdgXKNdmNt7m0dq224Ty0ug/KZOwR8vz+Kk
         3qEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681890037; x=1684482037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdAF+ibqcFz4f6UdI5r5abisS6qF8hg1G7lhZkeAXYk=;
        b=ecC2m+vqEoMOnLYQs2FS/emKycJyH9DcJRpNZCDoSa5W4GHvcXhFMJ4Nqxcvc4DSPm
         Q72quTb9ci7fPgtVLVWo04+2JuPxMzbCUGgF6GAtyr8lFACp/ZfYStcCL+jso82XRkmS
         WH1YYtTcfO4dx3XzfJKBlViUbnFrFq0w0DrKsuqwHwvu58yd1zxLYg+Fk/mOYVhz5WSa
         Q3/8f/NO1k0KZM9vPr8Ahr/izHROj6NE8pxmG7jgezevncASSulTvAFDyeh8Qck/AGVi
         DPo8BAEG+i9DE4gAu2PXwWMT2Rd1eo7f/HYLjSw/j4UdpK/HA1Yws3vFKjwH/g0VUX3k
         PKfw==
X-Gm-Message-State: AAQBX9ccIVImkDW/VpWYPg42YmCKMP4nsTwkDKfrfTutAJVZ9toMmSD8
        QeDbHq/9zBJw4Vr/aclJuLJQzA==
X-Google-Smtp-Source: AKy350aqsESRxHSlCOW+FSrqiu4xHkLPIZBcls/gKehP6GtGDpV1jQDp02cCciwOdN4V0BccDQ0Iwg==
X-Received: by 2002:adf:ffc1:0:b0:2db:9c64:f759 with SMTP id x1-20020adfffc1000000b002db9c64f759mr1213937wrs.1.1681890037542;
        Wed, 19 Apr 2023 00:40:37 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id i15-20020a05600c354f00b003f180d6dbebsm968171wmq.48.2023.04.19.00.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 00:40:37 -0700 (PDT)
Message-ID: <d825230e-4265-6c3b-a9ea-c8ba5f13449b@linaro.org>
Date:   Wed, 19 Apr 2023 09:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: mediatek: Use of_address_to_resource()
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230319163231.226738-1-robh@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230319163231.226738-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/03/2023 17:32, Rob Herring wrote:
> Replace of_get_address() and of_translate_address() calls with single
> call to of_address_to_resource().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

