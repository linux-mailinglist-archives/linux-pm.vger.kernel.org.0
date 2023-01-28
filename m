Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98CB67F761
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jan 2023 11:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjA1Ku2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Jan 2023 05:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjA1Ku0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Jan 2023 05:50:26 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523A9023
        for <linux-pm@vger.kernel.org>; Sat, 28 Jan 2023 02:50:24 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id q8so5070887wmo.5
        for <linux-pm@vger.kernel.org>; Sat, 28 Jan 2023 02:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YaOTMZCAzgKrIAUlQhEpyZEYtdqL85tdGpXqE3dUxAY=;
        b=qOvpqV9opnMpa4pSBiep3eGvxDk1njLZRogz0l6TdkuXNfno63B1MfvYT7nIoSxmMN
         eS7BrQty2F9ViffyCwMiW6/749Q72JJ4ZZIMvYorbUakKI5AOzL3VhhLtRL0OB3pzubP
         5BnqKME5cqWxv3/0fKx61Lqr4hDqVLkZ/4iF4o+2DnNBIXN6heP5XzmgZkYu9cKMRuTk
         HUIezcG762YEnzTUvBUqSeu96gVtIOGFCmxpaxgE82y/78BnArdoZH23XtNre7qEvDtS
         YT1CEjkko9mZQatYkPUeUMkhijRKasPtB4K49ojbW7Ns4GtbaRmPFY7fl7pnPEFupm1k
         fAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaOTMZCAzgKrIAUlQhEpyZEYtdqL85tdGpXqE3dUxAY=;
        b=eQwTaplQhdn1P//sNJiUtlCrzEUk7zSg8uhXI9Hmca03lAwUqt2jW5Lj0OqWECKncM
         bmw5G55OUUE1i9AzK4Za5tZAje9vzlDZ1NSMgPDVpfgWtNvXHBiwCEJXKHHVsv4VfdSE
         /vbAALgSNDjoKbhwQQUkvWs4Wlr1p6mRQhXVu1UWZt5Q/40Tx0asHeLGl3NzskAMBuBe
         XqLwssXRA7+FWTDVIslwrYkHoX+RD9PRO1p0rlPPSFI1EdtjiIvKnibssL/0j4uKN5II
         Nh68zamsJpCMg2U2EN7sLzalLF1IGirW5WEUXO6qPKOSLZPVEUraWU9tZyR1hQNSkz+y
         SXHA==
X-Gm-Message-State: AFqh2krBwWp1robgV3nzjaUf486qDDY6uP/xZxoGIE7gAZwUCkm7qRcS
        yl/2gNM/oBm3S2rbM7kathXWGQ==
X-Google-Smtp-Source: AMrXdXtQdBiLWEzmCwbTdL75wdJctW/pF0mG4rl7sNjikcyTEOXbOzQ9/BGPt7iBfP/i9tFYKnBUHQ==
X-Received: by 2002:a05:600c:3596:b0:3da:1357:4ca2 with SMTP id p22-20020a05600c359600b003da13574ca2mr44919912wmq.11.1674903023483;
        Sat, 28 Jan 2023 02:50:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id az26-20020a05600c601a00b003d99469ece1sm10620035wmb.24.2023.01.28.02.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 02:50:23 -0800 (PST)
Message-ID: <b0b49007-7882-bb44-df26-8d2132b34bc0@linaro.org>
Date:   Sat, 28 Jan 2023 11:50:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v12 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal
 controllers dt-binding definition
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, bchihi@baylibre.com,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230124131717.128660-3-bchihi@baylibre.com>
 <20230126161048.94089-1-bchihi@baylibre.com>
 <2ce57abd-203f-04b9-f0de-8e524d6afaae@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2ce57abd-203f-04b9-f0de-8e524d6afaae@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/01/2023 23:10, Daniel Lezcano wrote:
> 
> Hi Rob,
> 
> I think Balsam took into account your comments. Is it fine for you ?
> 

The patchset was not sent to us at all, so it is the second version we
see. Therefore it's not v12 for us. It's v2 and it still needs fixes.

I replied with minor comments (which could be fixed during applying) and
the license concern (which you rather cannot change while applying).

Best regards,
Krzysztof

