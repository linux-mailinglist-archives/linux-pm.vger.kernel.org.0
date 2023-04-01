Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA866D3370
	for <lists+linux-pm@lfdr.de>; Sat,  1 Apr 2023 21:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjDATWp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Apr 2023 15:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjDATWo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2023 15:22:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC991C1F7
        for <linux-pm@vger.kernel.org>; Sat,  1 Apr 2023 12:22:32 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j1-20020a05600c1c0100b003f04da00d07so212071wms.1
        for <linux-pm@vger.kernel.org>; Sat, 01 Apr 2023 12:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680376950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsdIX4QaNsFy8jAUYtXLUiYq0pMM/KF7S/HscFFRFa8=;
        b=wLou/172SsZ4tbZKAmsf4wdm/jkdhPJhgp/9PODUlSx+8zj3bvceTjgZUslKBzMWw8
         dbzF5WM+xXp7t01zz37q83r+zoMvSKVW3P/J28MwkqEbL9aNMV8iCK1aq/f4+7SIi4B9
         qp2UZBwhIDmh3rDtCB63WKwzAN5BUgdGepgfYA2wOSMqur9AYXlb5tF5t3JYnBT9m+FF
         QZNbjh2HDQTcX3YBnp/khnrydEiI2K5FE2h9klkr7WGo/ExSeTZ8Jium1tK606uJuIKM
         bxjPVjsLqxf1k5WstPx4prev8VXkZHddRS3F63SKw/dTy0euJ1u4Vad24HvY2PFiL49V
         8UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680376950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsdIX4QaNsFy8jAUYtXLUiYq0pMM/KF7S/HscFFRFa8=;
        b=H3ixJo7oxgA65kGzVj7nH40IqBYYCL5H47XucqcqR7K+XWPrseUn9bTBYkUyazz3LP
         /me4C2KxaNML55QoqJ1RkTDWFOTqd5ek15ow7nm9AmpLmwbvOAmmwN4NO41QmHhlN2UR
         jcGB8GXu6XeuTFNZaQJFBW4gSwCl0HbHT/Fus/cnU+yrl3oRIkUsaRuP4Pc6KpVC1hPZ
         pGuOxjvEiD4BIVnoAPMnAfzDzhh3/zQB89rrj1u6YK5XW/vNDGY3hm3fCD91uX1AGs8d
         WAMDzxKfNTWeplZeOexn+vgIS8afrDxIuKbBq1Y3jtRFOVnJhdaiaQ6le0xcnqmWjfnq
         ba7A==
X-Gm-Message-State: AO0yUKXU4IHV30/9aG9bAlVt8yzjZAyq0KqthGfbeWIGUxPxl52+zZ6c
        WE4EBnGtv/JeIypX/lrwoGRy2Q==
X-Google-Smtp-Source: AK7set9y5bHkZCySLIhsJfaK02RbOBp8M7OwMT91WfVTWaYaVc0pGHqd8wtNzjk/5/WSJSDGT1LTiA==
X-Received: by 2002:a7b:cd88:0:b0:3ee:7061:1bdd with SMTP id y8-20020a7bcd88000000b003ee70611bddmr22820919wmj.4.1680376950405;
        Sat, 01 Apr 2023 12:22:30 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b36a:1186:309c:1f9a? ([2a05:6e02:1041:c10:b36a:1186:309c:1f9a])
        by smtp.googlemail.com with ESMTPSA id r5-20020adfe685000000b002e61e002943sm4791678wrm.116.2023.04.01.12.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 12:22:29 -0700 (PDT)
Message-ID: <93ffd73a-4544-5148-0159-1a9ea773c0a0@linaro.org>
Date:   Sat, 1 Apr 2023 21:22:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 12/19] thermal: cpuidle_cooling: Adjust includes to remove
 of_device.h
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org
References: <20230329-dt-cpu-header-cleanups-v1-0-581e2605fe47@kernel.org>
 <20230329-dt-cpu-header-cleanups-v1-12-581e2605fe47@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230329-dt-cpu-header-cleanups-v1-12-581e2605fe47@kernel.org>
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

On 29/03/2023 17:52, Rob Herring wrote:
> Now that of_cpu_device_node_get() is defined in of.h, of_device.h is just
> implicitly including other includes, and is no longer needed. Adjust the
> include files with what was implicitly included by of_device.h (cpu.h and
> of.h) and drop including of_device.h.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack and I will take the series via the DT tree.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

