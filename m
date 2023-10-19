Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0D17CECE9
	for <lists+linux-pm@lfdr.de>; Thu, 19 Oct 2023 02:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjJSApA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Oct 2023 20:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSAo7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2023 20:44:59 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89499123
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 17:44:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-407da05f05aso18093765e9.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 17:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697676296; x=1698281096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqMmbDT+DUxZelBUqzkYFvCgJc6iT9B6fZUcTJM+gGk=;
        b=yvbehv31tXdJ5/vjKEukVSeLAK7oMUULjkKurcjsDiBcDlcJ3YSbfXVyPqQ5ysPysb
         TcdgXfXSpZ/GVXtgX7JTqMd2yNzyJ5JUhQcYZuhMddGgFV7kuXhDkKkgkVYFNyVxJ6HV
         WdmUy/bU11Ep569HcBvcRzwlaaywYMrK3uCxHR6TOy51tze56DiF3/vjS+FnOLOVR5Yq
         +sI03dr9J6q+J4PJ1IAeNYwXVTJsWvrWqqM8fvBN5ehrGjvOEQ38M4lc77ErEmkQ/jr7
         3ZT4zO0b67ej4LgGSWE6yvWQtL9VKjXOQcnYk91e0So4J8kJ2JeDJxR9HUPuWQ+LKjFL
         Tgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697676296; x=1698281096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqMmbDT+DUxZelBUqzkYFvCgJc6iT9B6fZUcTJM+gGk=;
        b=u8iSjnSDaT3b0eJ7sOj0Ie7YRfX8ouJjtri27o7pRXMTNFBj7BHOYLzBjxUzUBj8ua
         WCQs8c517YAwO9VJOc8gdsR6pE9H+sLCMabUg9N78hGWzUBnf/cOAKmuzaMAcyPHkC3F
         3/X++ovdGwqKDTGBgZCGTp5OOGLP+IXPezE5NwkLXHJiu9HYd/WnZQFlJ1xhqlFg4MeA
         /WrM61gHRDI9Bqej1iHhLzkJ/IGBQZVl8zzt9p3tBy+bn8BNMGN4P8CpRG6fbu6pXPFf
         S6cdGjo5q+xEc0iUQtq+URiPkse7cJETsWOHF/E7QK760e3KV6OFGYVRb1+j5vnDBOVC
         EDfQ==
X-Gm-Message-State: AOJu0YyBdhPrGFvo4FBcciOL5eTt9IHfz9+72kM1tHZLgfX495BWFIjG
        YVluTO+ikHFE4M2/WDWi3sFeBw==
X-Google-Smtp-Source: AGHT+IHUpjP1fIZk/icMCfXuumPUX2ZnGdbVENpHqgXkoRfa/UzehhHFAMC9Rqok2c4BqwR4/sPJMg==
X-Received: by 2002:a05:600c:35cc:b0:3fa:934c:8356 with SMTP id r12-20020a05600c35cc00b003fa934c8356mr595689wmq.10.1697676295769;
        Wed, 18 Oct 2023 17:44:55 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6dcf:7c4b:2bce:3cb2? ([2a05:6e02:1041:c10:6dcf:7c4b:2bce:3cb2])
        by smtp.googlemail.com with ESMTPSA id fm12-20020a05600c0c0c00b004030e8ff964sm2985879wmb.34.2023.10.18.17.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 17:44:55 -0700 (PDT)
Message-ID: <608614fa-20f8-472c-8e38-916ff7d80e4d@linaro.org>
Date:   Thu, 19 Oct 2023 02:44:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Add LVTS support for mt8192
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dunlap@infradead.org, e.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, ames.lo@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
References: <20231017190545.157282-1-bero@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231017190545.157282-1-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/10/2023 21:05, Bernhard Rosenkränzer wrote:
> Add full LVTS support (MCU thermal domain + AP thermal domain) to MediaTek MT8192 SoC.
> Also, add Suspend and Resume support to LVTS Driver (all SoCs),
> and update the documentation that describes the Calibration Data Offsets.

Applied patches 1,2,3 and 5, letting the patch 4 to go through the 
Mediatek tree

Thanks

   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

