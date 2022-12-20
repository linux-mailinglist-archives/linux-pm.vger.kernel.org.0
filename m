Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FC16521C1
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 14:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiLTNvd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 08:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiLTNvb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 08:51:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E542D1182B
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 05:51:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id co23so11806259wrb.4
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 05:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KSVHHiftXz1SaJvaqwZXHIr1bCfcokCRkz80PsPXv/o=;
        b=udf/EOpxJCW5nWGoFn81be5KBKk6phNXV8jvKcmVwbM5fjnDMySdpdXl9KQ9UKmIXx
         LjjHu2Sg7IUL5N+4OpdjGaDpY9gyUUai5zFbRHUq4Jat1wzSxrVL/2c/3jD20uAjtPzk
         t8r6YmRgn3eo+/xTyiNXrbyb2BcQBGAhNIaJ/5pMNcSqKjIW0TIxArEJhgHfLBarX8wC
         yqHx+9z6axU9SSuF3WZ6ZvAPMufSvJ7KOmynJOanEv8OWP/dQkyGMZkI9MdReDGWOC30
         dSI44aWw+to7wI3RrPwT2I9286aMdFKYI6bFUv4IozB/XF4FgxWXApH2yrCAuRMYvftZ
         wyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSVHHiftXz1SaJvaqwZXHIr1bCfcokCRkz80PsPXv/o=;
        b=D8wqHhZHozhA3UK930nYcGyXtgB40+9Bj8KwFidhViKSexGJO0RJbJJSYO3JwA37ZK
         qCYInLMa6zBEBcLMOmh/ghSMtZvctgxteT+RVhCFrYJLQpFgy46NUsfEjbT64QB/KSDM
         /G2jUgzjhtzXn0si3+qac4OlGf5emm5uJrY1AvVyeV+v6bH9tcIAj1ZdURXJ3Yac3onE
         W4bOZgvuor80kVdcQcAzWf/0WpJ1bD9Bhe0qvgv/l7QAE1D7WPkCm92/S3cn2rx1P6Mz
         Mlg24fKmTURtVUDd9DAWya3ZRAvGwXdlxb3M+UsV2aaa3WB8ftP5S4anlDAYnAmMWePE
         KNiw==
X-Gm-Message-State: ANoB5pmmRH8wS9rupNtdzrum1aJqWknqIld5Q9AlKo1ld7gJ0yvbFOli
        +ZL40IhvSNtOCAtoAiK6ZLqVHg==
X-Google-Smtp-Source: AA0mqf7/dTg6DQx4d222Cyr+0q8ntLywbW1eEDWUCRTVzvJZ5bme/fbrLvO3Fy0XSXHRB9S1zexung==
X-Received: by 2002:adf:e301:0:b0:242:30c8:c36a with SMTP id b1-20020adfe301000000b0024230c8c36amr28796424wrj.45.1671544288508;
        Tue, 20 Dec 2022 05:51:28 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b002421a8f4fa6sm12946768wrh.92.2022.12.20.05.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 05:51:28 -0800 (PST)
Message-ID: <12316775-38d8-2016-da51-55a9c8d77671@linaro.org>
Date:   Tue, 20 Dec 2022 13:51:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 08/15] thermal/drivers/tsens: Drop single-cell code for
 msm8939
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
 <20221220024721.947147-9-dmitry.baryshkov@linaro.org>
 <78fd7174-9aa4-f067-72ca-514c8fb09ee5@linaro.org>
 <d0a6b9cb-f321-7d5b-5767-acd12cfd78f1@linaro.org>
 <5bd2c0cd-741c-8865-5f35-25baf6787480@nexus-software.ie>
 <5f4046df-906b-5673-81b9-ab37294ba443@linaro.org>
 <2ddd32c8-b69c-0da9-af5c-22a8cb8eaaf0@linaro.org>
 <CAA8EJpqDDi+U4QO9_B=gChbZgXT8hs1QeTtxAY2z3iUtekz4aQ@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAA8EJpqDDi+U4QO9_B=gChbZgXT8hs1QeTtxAY2z3iUtekz4aQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/12/2022 13:29, Dmitry Baryshkov wrote:
> Would me doing the dtsi patch for you to test on 8939 help you in any way?

Yep.

I'd be happy enough with whatever re-enabling work is required to offset 
the removal.

---
bod
