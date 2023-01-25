Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1E067BDDA
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 22:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbjAYVNr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 16:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjAYVNr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 16:13:47 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4DB7AA1
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 13:13:38 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q8so14700483wmo.5
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 13:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JsLcxuxMTOazJRO3G1nL5/Q+Xnan4zO8kzHASnq1QZA=;
        b=BgPfXAy0xOw1jZzEbavomqOSRnTH55mU8tvfwtEZ211OT7cCuz4uXG8XLn1gMe7ONe
         WcCxHjrR7rmB4hCxBmvLnkyg1JeznuygjjtRQn7ShAW9vY/v1z6kaULuOCpQ3bTLU9LZ
         3VMp3nITMf74K8HDDlOagxUdAPoZSPLi1hlwVQIQjK6feAVtBoWa/psdPMOKVRijpms9
         Ij4B56IAUPDeJMzPlunCf/IZJVGvXMLU7jdEEvTmWPW8I2wht4agM1ZJHcJIyAGa22Vp
         Phu69pBL4/G/FWVWHETfTq7FEamrTTNYm/eoHFbNobTwA787DvNT6MeMxv+RLzTcuxda
         8EGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsLcxuxMTOazJRO3G1nL5/Q+Xnan4zO8kzHASnq1QZA=;
        b=3psonkU4vKgZ2WN8YhDIR711yCSU8tICoXFj4S4XX+eiVnO4OFrsFITg/L5x5R5mM2
         RgLyyTibPinebyeIqZfuwZoVEXuVm0Io+ScfNmBiPXn06OpF7a35FS1Y0LAhpoBWM2P0
         OIYVe2q0n8fwDdfwa1maKSye4LjkJ4C78zI3jr3mQj1wgRp1QdazigYSdnW3CBzr9DeJ
         7g2VV2s7TzoJLqoZkc+2wI1QqzQJmk+v7A6LCWBGp7MA6KU0frGo6crTJIz0RA/0zWh2
         CLSlrQRpZ7rsiVY2g8+AeYOZguBfNYrTZ5Zw7d/Dm7a+suJYEwh3V2yETmC+p66xqCYp
         j9eg==
X-Gm-Message-State: AFqh2kqPt80WidjaxKCd0SHvlaxbGW0NhdjJrpSam/n2AXgqlEav/XOs
        sH2YefiuTiUE5bWmHUuQOy/zIg==
X-Google-Smtp-Source: AMrXdXsPYFyzktUf5LMtw863JQqiB8bnQdiNRPJy/rhWvqe1b+FhuVVb7GKiJsFGeACA50mg+EvsQQ==
X-Received: by 2002:a05:600c:5028:b0:3db:1dea:75c9 with SMTP id n40-20020a05600c502800b003db1dea75c9mr25055623wmr.28.1674681216854;
        Wed, 25 Jan 2023 13:13:36 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w19-20020a05600c099300b003cfd4e6400csm2807723wmp.19.2023.01.25.13.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 13:13:36 -0800 (PST)
Message-ID: <d4b8eee7-ab0a-03ab-01ba-a71e290099d6@linaro.org>
Date:   Wed, 25 Jan 2023 22:13:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v11 2/6] dt-bindings/thermal/mediatek: Add LVTS thermal
 controllers dt-binding definition
To:     Rob Herring <robh@kernel.org>
Cc:     bchihi@baylibre.com, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230124131717.128660-1-bchihi@baylibre.com>
 <20230124131717.128660-3-bchihi@baylibre.com>
 <2471a5de-b7a6-fea7-152f-4fe25063abf9@linaro.org>
 <20230125203528.GB2855708-robh@kernel.org>
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230125203528.GB2855708-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/01/2023 21:35, Rob Herring wrote:
> On Wed, Jan 25, 2023 at 12:14:17PM +0100, Daniel Lezcano wrote:
>> On 24/01/2023 14:17, bchihi@baylibre.com wrote:
>>> From: Balsam CHIHI <bchihi@baylibre.com>
>>>
>>> Add LVTS thermal controllers dt-binding definition for mt8195.
>>>
>>> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
>>> ---
>>
>> Krzysztof, Rob,
>>
>> are you ok with these changes ?
> 
> It says v11, but I sure don't recall the 10 other versions...

Ah, yes indeed. I remember Krzysztof told Balsam to fix the recipient 
list because some maintainers were missing.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

