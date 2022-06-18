Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599F2550184
	for <lists+linux-pm@lfdr.de>; Sat, 18 Jun 2022 03:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383797AbiFRBCq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jun 2022 21:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383739AbiFRBCo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 21:02:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADA92DDF
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 18:02:43 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso8369963pjb.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 18:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0DQDSG7vpMhAghxTWTUioir0FFHVEEY00Bb6PEI7mmA=;
        b=VZ9hmLoIfZy3Gv2bUDe1d7P5vdzrlmwX+NQy3m99tg79e0urCWEGw6Nb90Q+ysZ5Yv
         1sUTQqlVo2dAKBDnpKuEn/VH0lzk9WUkbmaz9XlVigQjn0H4x1P3V2GBPRddB0Zfagwv
         K+RK3mh4MqMk7h7lyV+JK5CphtV8ecMhkGmO6fGoRs91jK+hpDDRPwlaR6OXlEHrzgGL
         Ho9MpaVHzm3VNJADWD7wKr/lkZRzUowMMQsX+95C9Wf7XrYdjx/0APy4WKhOxIiiL5sA
         8v/gUQUYVdttl0azzvip7rzLpISsEdtFXOAZ7tCpNnLYHa+EKdhLp1K4z/dHMqWntN+D
         iOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0DQDSG7vpMhAghxTWTUioir0FFHVEEY00Bb6PEI7mmA=;
        b=o+2iISklEiJd0Q11qUJv47OOc/UhvBwKoIgpW5yyDXVYovC+6cZx7lul2JAbg7d6Ul
         6ps/nW/ovv9d0waXbJUJmH1GywbppU4r3wSryI49qghwqrFZZMvEYj7mWMIwIV4FyJsQ
         IYxjM30WKj0mlkqHLHYoMcAsnhJVUh3l3AfzBHt4UOAVEgVPRxMkcqwpMSIJSWc+le0h
         HNZNOCvBlQUwKOPnk4/J9mg+9Mca4rsBpq/dQad34uxXTtWncXFgoy+i/EFvM+UVjBmf
         HRGWlu4cOkmU0NdHOXLag7A91R/la2WrRyRZh1xylhBxgvjVcuZ7EjlPbcCDnly0h9Iu
         EvcQ==
X-Gm-Message-State: AJIora8HX2HFJGkG7PAndTPSLVzRwgb3RIH5aeXWdkEaqoN8YRaMxHjW
        0/PvxgadxY34vj7IVPepWry21w==
X-Google-Smtp-Source: AGRyM1uaYDSo4SeaMwOX4NuS5P558iYahkc4hsUv8eFKbvNiaUT+2mdq7FveVa0/03GkLts7bHgLnA==
X-Received: by 2002:a17:90b:3904:b0:1ea:d976:aff7 with SMTP id ob4-20020a17090b390400b001ead976aff7mr13658747pjb.4.1655514163076;
        Fri, 17 Jun 2022 18:02:43 -0700 (PDT)
Received: from [172.31.235.92] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id q2-20020a639802000000b003fc4894c270sm4311961pgd.69.2022.06.17.18.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 18:02:42 -0700 (PDT)
Message-ID: <b3311560-bbba-7fd9-7cda-65cfbd33458f@linaro.org>
Date:   Fri, 17 Jun 2022 18:02:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/9] dt-bindings: thermal: Define trips node in $defs
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
 <20220617070847.186876-2-francesco.dolcini@toradex.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220617070847.186876-2-francesco.dolcini@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/06/2022 00:08, Francesco Dolcini wrote:
> Move `trips` definition to `#/$defs/trips-base` and just reference it
> from the trips node. This allows to easily re-use this binding from
> another binding file.
> 
> No functional changes expected.

If you want to re-use trips, they should be rather moved to separate
YAML file... but anyway this should not be done per-driver bindings, but
in more general way. Either the problem - using one DTS for different
temperature grades - looks generic or is wrong at the core. In the first
option, the generic bindings should be fixed. In the second case - using
same DTS for different HW is not correct approach and why only thermal
should be specific? I can imagine that cooling devices might have
different settings, regulator voltages for DVFS could be a bit different...

Best regards,
Krzysztof
