Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C0667AF5D
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 11:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbjAYKKp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 05:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjAYKKo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 05:10:44 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF25F773
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 02:10:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t18so3677220wro.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 02:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+YbmCODXrWbUn0nWKxLJPq1L6PfEga2OS1d1Yrw45IU=;
        b=EWZ+hu4S4a62p8gA2V9ZYPkv1qLN+s8IMtIROJN7y8CarZG2svVmLvXgd+cIXCTqYK
         NmDzRiCF06lhNIqcgTEj1tarMHcDsKa7kHDQPaG8pOtIq/W5AbCQB6RvTcD1myTpCzRp
         TRVPIsNn/MVN84z/l/E40mM1M3YZ9xN3d/JOW4gawseKTBi9l/HQ5vDPs0OzNhZfxYZO
         aDNpO0Ibc/PEQId4AU9aFKgNJhl4vADNywb3qlpc3BO7gpS9YHIB2cwG5XYpu1Xj9faD
         FC0dRFpKpviOy+GKJ1IlFSq1v3ihdct8DCv97iaxXiys1mUD8mQh4tZ+cpBZvSJ/9qt+
         sssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+YbmCODXrWbUn0nWKxLJPq1L6PfEga2OS1d1Yrw45IU=;
        b=HV9Or2hqfylHCrEWMVSNpECETkdtRou+BL9KUtb8vHIUlN1rS622r1t424Z7MGlO+Z
         uqjQcL1Qjk+JpPBMz2W01IHMmRe8DTpHWPNqlFELdaECfZjyF8rHEWVDBogfkPODiO34
         LXt7IQoOKeRmvpiyF40jwc+9ymFMJy4NYIkXUw50/9WSYcdGfaxCTbf11V0rQGM5tK+B
         qyxyE5wNn/CWugq2jTrlnInzBLy9FhA4fjiHUB0gwRPLlZoJ0rSOQHoxJCPwm8F8IwLG
         u+JDuSaifcgb18N9rSF9nXpr6pok8vNO9mfeAQPni8tgDRgok3FY0Jw1dXmoBuuN15lE
         tzug==
X-Gm-Message-State: AO0yUKX4/Cv5N03otKqCAERa3GbcRrwoY+QTyEX3sCXySNbVPLmHNK0p
        o3c5yaH+L+ffIUgVkNRzV9rPzg==
X-Google-Smtp-Source: AK7set8k1yyqihkL7lEDeuIamGfJrPidQaf3VL7shCTdtPbifYjaUj0j3ZCA+tCz22qbl5k7/4CR7Q==
X-Received: by 2002:adf:facb:0:b0:2bf:b746:6224 with SMTP id a11-20020adffacb000000b002bfb7466224mr2062674wrs.0.1674641440862;
        Wed, 25 Jan 2023 02:10:40 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s8-20020a5d69c8000000b002755e301eeasm4024686wrw.100.2023.01.25.02.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 02:10:40 -0800 (PST)
Message-ID: <859715d1-a442-7f64-2345-60d0fe28bdb5@linaro.org>
Date:   Wed, 25 Jan 2023 11:10:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] dt-bindings: Add missing
 (unevaluated|additional)Properties on child node schemas
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230124230228.372305-1-robh@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124230228.372305-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/01/2023 00:02, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present.
> 
> Add unevaluatedProperties or additionalProperties as appropriate, and
> then add any missing properties flagged by the addition.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

