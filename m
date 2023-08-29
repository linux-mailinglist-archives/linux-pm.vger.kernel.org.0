Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D84A78C1DE
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 11:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjH2J5R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 05:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjH2J4z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 05:56:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA35CE2
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 02:56:26 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso411600466b.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 02:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693302972; x=1693907772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Jps0qXeyPLdx+b5De4g4xbuY+7aT5vkCHcXrjuUV+Y=;
        b=hkG7xTYtJQ2ENM4yJoPTcBPNN0RU4igvZPm/ioBwG9SyLNMoZKiCrkg/CqcfrEOS7c
         /a0Xv1R9MLRvK28utRXeksnBTTDhjskyQMWRTzaaziDgCYFGmdOMsWptrXgInmeTAp7m
         dB3xN6a9EMLtjCopFh2gVU/uMs8bGMiR+23QKQ68a47UV5Q81E7dd/7TS+xEmTKuhLSl
         BmtujFHozhifeHO5l3bh4y0gL3YjdfG3yEiayf3rLzypfELB3CtAPB0Mf+LDD1ZmOQpS
         Jp96InuYxq6Rpsbgsazvf9g+mj28O8FBMvADte0AIPIkPna06rdxNmRfub70QWO0K/5v
         Ea1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693302972; x=1693907772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Jps0qXeyPLdx+b5De4g4xbuY+7aT5vkCHcXrjuUV+Y=;
        b=SqKI4cMcosD06onkp7Kh+Hmx6ZkBdBh1VFdoeTJ04MhZ7B9wxEpf2TFSuI+Dacp+MC
         vt+0d7GHumIqHUINWQaFU09LbeaJ+88OerxLBeCQzVMP51peNRMagsFnokyy+thXrxYi
         nsEqY0RSaBHA2xooy7LZEOJkXnc6wcKe43N4rqP94VHaFWwKgkIW2XjhqLZxQMu4GDWL
         5QUFF+rB3rVn2nQTK5CK1++km0fZrvtYHOO3zFIDg6HzThxZfqWSzP+1eTyYo219Ve83
         KxJfKUl+weL760UhOsFyOfcRFAiNWbXVst69ay+FRE6+k4OLoCSy7ohJtng+9M5oglti
         Ds0w==
X-Gm-Message-State: AOJu0YyauzujYG4tj1LGCDi+100T1UuXQB7Cl47J1M6BachWY55/6Ciq
        nU+GJVbbQ9EWX0WyTUMUkJYIVQ==
X-Google-Smtp-Source: AGHT+IEjhxFak4PhQe3Tgs47lEQYmobKxofGOlrRmfYW9HU2F55i2HVmIX6rN/v0yjl1q+ycOMRmMw==
X-Received: by 2002:a17:906:2091:b0:9a2:ecd:d962 with SMTP id 17-20020a170906209100b009a20ecdd962mr9825131ejq.4.1693302970981;
        Tue, 29 Aug 2023 02:56:10 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063b5900b0099cc3c7ace2sm5878362ejf.140.2023.08.29.02.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 02:56:10 -0700 (PDT)
Message-ID: <a3b9ff0f-fff9-9439-5ec9-95a4de9bdfaa@linaro.org>
Date:   Tue, 29 Aug 2023 11:56:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 04/11] thermal: exynos: remove fine-grained clk management
Content-Language: en-US
To:     Mateusz Majewski <m.majewski2@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20230829091853.626011-1-m.majewski2@samsung.com>
 <CGME20230829092412eucas1p2b79a6f90b9077a3a5486845b7e68bbc6@eucas1p2.samsung.com>
 <20230829091853.626011-5-m.majewski2@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829091853.626011-5-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/08/2023 11:18, Mateusz Majewski wrote:
> This clock only controls the register operations. The gain in power
> efficiency is therefore quite dubious, while there is price of added
> complexity that is important to get right (as a register operation might
> outright hang the CPU if the clock is not enabled).

So once it is done right, this stops being argument. The benefit is to
keep this clock disabled most of the time, which now we lost.

I don't find this patch correct approach.

Best regards,
Krzysztof

