Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4FD7B1F18
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 15:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjI1N7j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Sep 2023 09:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjI1N7j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 09:59:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4896D19D
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 06:59:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4054496bde3so112223475e9.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 06:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695909576; x=1696514376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhhlYA35JIyrxQlMTea1XefnagrA3i1o9FxEDIuqteo=;
        b=SE+6chA3AHCW/trGM4JC54JNvq9TVx8jxZV4wlpjj9xLP8jjDRfqjldWEdKKRi5sdp
         pChHVewNwkwUok5an0MxyywEB8EvSOG0yWS5tMVDD/+sBaSAv+/TyYetgzj7MEAv1wt9
         Rf0MD+RwSkuFKKaigTp6/JCdF/6utsM282TDNRJ6YF9X01ZmqWMGW2Cf4Xt28Wx1Y7hK
         1TB2FcTScqX6pXAoUmDKb8ZjZDhUBX8tnMv4SAtRY81irXZtP5pzFp60w+5RMNr0RuSX
         Z3QKNlVMhJppIl3TxW/vgloT09UQvYCK3XLzYtSd/64FXueTiptIsKY/igAvZU9wwSXH
         rzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695909576; x=1696514376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhhlYA35JIyrxQlMTea1XefnagrA3i1o9FxEDIuqteo=;
        b=uNo/rSP0AngUOiQwM4s0mLVPRAtexuontQikJptW3pr/eTFTCKlYA6qMqUYl/9McBF
         ubmpL0InXdm8hieJep/vohMvm8+yPOebgDi6kqDloW7YOQb31qZHBdvQEICPGI/Og93f
         VqAx07isCqfsQ5IXaq0Q5nQsQBv5tsENP8uPoHEDI+LmSnTKIdY9LNb4gxROf+wvEIIP
         sX+rD0xtfJLsllFbx6wj3QlcGii1BXS3vdb+zUSyD9gL6acmO/nRTOPk56efT+XvDx0s
         3zW6VppC34cnawL3ibfkWNQcv0uLBNzjBCmJ3X8MEn9SwbZ25pfqlDAEYLuTblybLxA9
         GrTQ==
X-Gm-Message-State: AOJu0YwCWGKR21xv7G6WUiqi8HRRnK45pnlV3ZsxBaoch4SZlGwJ9LCP
        g/Aaop5TcQHzE2ssOZR7QHVeAQ==
X-Google-Smtp-Source: AGHT+IFf0WMdJFrrwFCWhFWD8gg8bNzNZO+0q58x8serItqk+y/a0NXsekyGiLITmtbOMbiJWC1y4Q==
X-Received: by 2002:a7b:c7d2:0:b0:405:1dbd:f77 with SMTP id z18-20020a7bc7d2000000b004051dbd0f77mr1258665wmk.31.1695909575629;
        Thu, 28 Sep 2023 06:59:35 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 14-20020a05600c230e00b00402f7b50517sm20323236wmo.40.2023.09.28.06.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 06:59:34 -0700 (PDT)
Message-ID: <419fda62-224b-cb20-ee78-7e0627c4ee9d@linaro.org>
Date:   Thu, 28 Sep 2023 15:59:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] thermal/drivers/mediatek/lvts_thermal: fix error check
 in lvts_debugfs_init()
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Cc:     opensource.kernel@vivo.com
References: <20230921091057.3812-1-duminjie@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230921091057.3812-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/09/2023 11:10, Minjie Du wrote:
> debugfs_create_dir() function returns an error value embedded in
> the pointer (PTR_ERR). Evaluate the return value using IS_ERR
> rather than checking for NULL.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

