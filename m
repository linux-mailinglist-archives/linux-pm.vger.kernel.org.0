Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC072B137
	for <lists+linux-pm@lfdr.de>; Sun, 11 Jun 2023 11:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjFKJqQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Jun 2023 05:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKJqQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Jun 2023 05:46:16 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C625EBC
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 02:46:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5147e8972a1so5855471a12.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 02:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686476773; x=1689068773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kgj2E8ULVnK2Tdu4A0s7nIRfjHGYYKYecJtglfc2Rgk=;
        b=jZVzqoFY7komMteaw86mZNCDGRSfWwZf+2JYLj/QEnP9wLpTt4Fl99AFTkfamxyjEc
         P3O0uuI9JJwFNFEVTS00IyOXJnemS63PPzaAGq0f+ncpBLq1nixh0zaf5hDwASAIm9Tq
         A1JSGsvwRzJ8rzGp761JUvT1X43LFthxlDZcWzXuOfPIyE+n+NS+Ilaphx8pdXdv7r3q
         6LshwE1FYIpEAYWP0jzzgm3xtdZnvz0ciEnIKPBVmEuL1pdKHSR0YcoZPR3ZedArNn5H
         4dXKrSMvzG6GE64zHkwrRgA+gDkniwTK3om5c6nz2fiVIjw/QloPVMdMQ4vs+tHaq5x6
         1RVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686476773; x=1689068773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgj2E8ULVnK2Tdu4A0s7nIRfjHGYYKYecJtglfc2Rgk=;
        b=EzWazdxjGA1E/rs05dspu800NKnBerpm4Mj2RUm+qUkxY6d59oQWjQCVNT37HZKrqI
         YHt9BKYagcT/bK2CQgPBve6/VFf9mSIm0rTq5HmiHJBukgMSTZ06YFWikMErY6E9ra8o
         Z+aJomyiniuXfpaYXxER21utvoMYuFWtThqNOeyB6druMn1qe1olW7S76n9DMyFhVOdf
         EXBXGugSffpaRHV7niLpYM5Fgtn5iSUxsuD4fLn3NJtvaX0fi/q0YDQQzBrcqaX1D5ok
         d/h3M+2alTbUlWlRyo7z7HAG0s6IaSh+jsdk0UbqZfUF9DvqjekWwYRmmpVE11tanJe7
         bQQQ==
X-Gm-Message-State: AC+VfDxWxk8SdE8l6m2IfG1hsMM1WfnC3dNO+z4wsPurNw4KHDGjkPB0
        UPYg/M3xBkjMuYUCAttgLAFJLQ==
X-Google-Smtp-Source: ACHHUZ5rFvnEPdfaRg5ZSWf2Ja6DZrQv8duWnhdFSOc2DCo69LdKdJqe2hSqT2E0pyrAaiMALMhVlQ==
X-Received: by 2002:a17:907:5c6:b0:974:1d8b:ca5e with SMTP id wg6-20020a17090705c600b009741d8bca5emr6689735ejb.14.1686476773245;
        Sun, 11 Jun 2023 02:46:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z20-20020a1709060f1400b00977e7f7d599sm3589682eji.71.2023.06.11.02.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 02:46:12 -0700 (PDT)
Message-ID: <f132af34-e1b1-1278-316e-ac2c3cfbbbbc@linaro.org>
Date:   Sun, 11 Jun 2023 11:46:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: sun8i: Add binding for
 D1/T113s THS controller
To:     Maksim Kiselev <bigunclemax@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
References: <20230610203549.1127334-1-bigunclemax@gmail.com>
 <20230610203549.1127334-2-bigunclemax@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230610203549.1127334-2-bigunclemax@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/06/2023 22:35, Maksim Kiselev wrote:
> From: Maxim Kiselev <bigunclemax@gmail.com>
> 
> Add a binding for D1/T113s thermal sensor controller.
> 
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

You are the same person, so use only one SoB.



Best regards,
Krzysztof

