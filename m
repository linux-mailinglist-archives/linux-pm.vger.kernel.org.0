Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A614E78BE6B
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 08:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjH2G3B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 02:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjH2G24 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 02:28:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66085CC9
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 23:28:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bfcf4c814so514883066b.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 23:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693290524; x=1693895324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rk5O5cxE3H0kwoH1WMJzLdh2Fpjs5TVwpzODQP6Z++M=;
        b=QqICDRIUDF1jyEERa8At+Vs3w+GMlzAd48wUa/b79coZ3jsDfVTjDRQmjrGUN5TIsd
         IxRW0xdPGhE+0BuYHu1AernHobQeJfWYbYarMI2G1lFyyEpz9qDUz01T9nldsCFtLu5A
         Hw/kY+K8xF4MphaMHmN+eTIbTZDGn6CB6fyizcbrty1sqQKlp4g/P+vZ+C1lz4c0NGsp
         PfeRNUCy80y18ff2Lk+5rFfly7ACiAFVm6e07u1VAmaWScdQ+dTaKZabgq98xitKrQtu
         OzOzhaxVJ4KIJZMtercxdY/dckhP+qs5rp4G3Cp7B/XPqn27dKkBSoK0js4RYRMP6U1O
         R9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693290524; x=1693895324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rk5O5cxE3H0kwoH1WMJzLdh2Fpjs5TVwpzODQP6Z++M=;
        b=A/9PtbOZDs3IddYiujHlxPMhIne4GLukWoDAUPPB61YU7flMksHT0u+TO0YZY0iaHP
         CE/nl+ChbM2qw/81Q24aX8NKP36k5bxTHmrRQ0LXN2Opv/ue1bfOfP7ViqXDjDJZTPh2
         N6v871tnjG9eTX4VUNtu4+mPKb1XxCrQ5kSJICr9RzVQ1ed8ot10LNzSZ2g1LbKCtMF0
         0MQ7A4STM2tSXl3HScEwaTzgeOO6fj2YvMatdjVVr9Flvoj97q2MxRmWzZRQN0ulLsiY
         RMSjYHTSTOdFEVhtFaQyj4axEt4fF2q7jRXAOkDjOriw2F2pX6gQFozfEIHbw7WyVSMP
         PS7A==
X-Gm-Message-State: AOJu0Yzw1UslN2UvnZf9ggJ7VdQJKTrho+Ys5F+gKF/RjH2JDiNix4g7
        MW27FGmiv14tZUu9RLX7OJUtTw==
X-Google-Smtp-Source: AGHT+IFLXFOGO7lW2CrMpZOyjDWN+69cmgGskpd1u+5hxqW7nLvyH3fWdwwRExeQ8+sQRCgE6jKjdg==
X-Received: by 2002:a17:907:c20d:b0:9a5:c919:55cb with SMTP id ti13-20020a170907c20d00b009a5c91955cbmr826089ejc.73.1693290524597;
        Mon, 28 Aug 2023 23:28:44 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id lv12-20020a170906bc8c00b009a19701e7b5sm5563521ejb.96.2023.08.28.23.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 23:28:44 -0700 (PDT)
Message-ID: <256bfc91-31da-c3c8-7b9b-610bb4a73038@linaro.org>
Date:   Tue, 29 Aug 2023 08:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/5] soc: loongson: loongson_pm2: Add missing compatible
 for Loongson-2K2000
To:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev
References: <cover.1693218539.git.zhoubinbin@loongson.cn>
 <8468bdbea87003dc05bd10d15b51e6d27f306a20.1693218539.git.zhoubinbin@loongson.cn>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8468bdbea87003dc05bd10d15b51e6d27f306a20.1693218539.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/08/2023 14:38, Binbin Zhou wrote:
> Add compatible for Loongson-2K2000, which also has the Loongson2
> Power Management Unit system controller.
> 
> This is a missing compatible, now we add it.

How is it missing? Was support for it added before but not complete?



Best regards,
Krzysztof

