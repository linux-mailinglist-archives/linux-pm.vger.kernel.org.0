Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7EF6D33F5
	for <lists+linux-pm@lfdr.de>; Sat,  1 Apr 2023 22:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjDAUwQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Apr 2023 16:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjDAUwI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2023 16:52:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370E52952F
        for <linux-pm@vger.kernel.org>; Sat,  1 Apr 2023 13:51:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m8so3973512wmq.5
        for <linux-pm@vger.kernel.org>; Sat, 01 Apr 2023 13:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680382317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UMEGkXCvg7/CGHXH3d3dGgGNTGrxC2XQcGrgCdNoPME=;
        b=R8Q8NOGOSVBDe/QebqkipZUS+N88Rq/PBjCw4V7x/npzW3GwFWca0J2gO+EdlzOlbi
         efbPSkdAr/+lXSXG9Op9JcPpF1kHBXl8XFM7Bf8FWrs/0EjTwmAElts0Nj9blrIbgVHv
         LMM25G5bwhfh9ADPFG52cABNRf5Las7c6ztSwlxI9Bx5PE09XkQozcT7gV8zQOvWt3qU
         SdxwY9RfYT29A9RkeyPqe4wjuNoaZ20Raqxz5hAjrViECDSivs3UZk55XmXDAfrF6tV9
         b4F7vjA581/JK94Ug3QDvV6gP/akEAIh9x84ZrEVjj+5nfuyozadiyQ/cdR+h6RlaRkT
         C5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680382317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMEGkXCvg7/CGHXH3d3dGgGNTGrxC2XQcGrgCdNoPME=;
        b=Fldi11BJlVEkYto2eeg7uwS69rJtJvz+p2+M1iO3R7WIHjpGUkQLMFz57+2QdnKNxP
         wdPkwXRTm3xasP105TyF7T8q7aiCo8zEw9aFIRYban7jcyZecEGalB0/l/N23j546/T7
         LvjjdjX/cNAy8hcre+KsqezghTzzOEABAbiczOD1mKNm4NWDAhqAvhmZ5XCqXocAFu/p
         Okd9yV8Ktu0XjEjjyrZHaLmv9AYbKfMkkNjx3kVnQ9HPsl9kk9EuwAXDdX3WxKt3HdtZ
         wuHVGzNIHsdqjjLaGvxYZvZLimd3AOq44rLsWBb0NpQFrK6qh/vLwjgxDRKWf0BLijWv
         RxDw==
X-Gm-Message-State: AO0yUKW43ApDon6A4/9Zivra5lVJIoU9h0F3mqIdinUOHs3x8oz/+JSV
        PBNScfoc/BxhBs1nyFqeCTVPig==
X-Google-Smtp-Source: AK7set99TkACr0I2jVXwkGkUioKzfXxq2WJuqXn9pqAYA/4kbGZCzC8In0m4IIw4vt8k4LjpmeVgRw==
X-Received: by 2002:a7b:cb93:0:b0:3ee:814b:9c39 with SMTP id m19-20020a7bcb93000000b003ee814b9c39mr23073849wmi.18.1680382317297;
        Sat, 01 Apr 2023 13:51:57 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b36a:1186:309c:1f9a? ([2a05:6e02:1041:c10:b36a:1186:309c:1f9a])
        by smtp.googlemail.com with ESMTPSA id n2-20020a05600c4f8200b003ef5e5f93f5sm14298909wmq.19.2023.04.01.13.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 13:51:56 -0700 (PDT)
Message-ID: <0a86d734-000e-560b-8f47-1c0a113c01ee@linaro.org>
Date:   Sat, 1 Apr 2023 22:51:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/4] thermal/drivers/mediatek/lvts_thermal: Add AP domain
 for mt8195
Content-Language: en-US
To:     bchihi@baylibre.com, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230307154524.118541-1-bchihi@baylibre.com>
 <20230307154524.118541-3-bchihi@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230307154524.118541-3-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/03/2023 16:45, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add MT8195 AP Domain support to LVTS Driver.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---

Applied, thanks

Changed the commit log to reflect the comments change

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

