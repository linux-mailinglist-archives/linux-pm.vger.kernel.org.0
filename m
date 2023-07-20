Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6AC75AE5B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jul 2023 14:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjGTM3I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jul 2023 08:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjGTM3F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2023 08:29:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA09E2137
        for <linux-pm@vger.kernel.org>; Thu, 20 Jul 2023 05:29:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9928abc11deso130667666b.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Jul 2023 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689856141; x=1690460941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qT08SpiUgGvZlb5GGVVX+9XlZeGdvNK6gZUUp4GQe4I=;
        b=aJC4VDp7xASAEEOi8/qpOa/R8RvMG4+HI/RSw7nxnJW2UqXlWdTtvHDydnXQz/tBoD
         xprc/1ABLfWeFOVN6ucWJNMxFY9pbJbOweaj4n7BYxHBnrbnyWhz/pH5bVCW2fol3sbj
         YZlpRMRSKQqw+ykKGOy5AebhrgkVXAI+13dvKOChRpayrRE4ExwvLM8wHE4k3+2Bmr/H
         FrOqa9txmUZzMzvcoCYS4tPOFr4IdO2xoJuDXFS0/mabdZWPtlcZ6pXk1oQvbtpSlCGU
         upisJebK3IVg1a7p9rF6ysCaWssYnBziGBoZFqTeD91heliKNzWTcmQm1TtD9+acOCyl
         NILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689856141; x=1690460941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qT08SpiUgGvZlb5GGVVX+9XlZeGdvNK6gZUUp4GQe4I=;
        b=RDFFBLESfiz502lCz/DMmeO9xYPuelrg77TOWpzh9pFTIvuFnfFYRKvoBy5iAOFAbK
         r2r5i/rdq/ZvgmFKdwNV/9dBW40WLjm/vc2HD8/b85YOuWBR4+iULz/oIHPNUZJWE3VZ
         ugzPGv1aSHnLcv4rs1LYFMC3QCRDpwl/ZTiUYhLYCBx7wpqZWS1cw2QJ3sfLZwWK7pwI
         DTvqmMePtRi84RintJPGzKa29RYvbch6wAyR9ikf9ROYOp/LbHtAOaS6b2vBETCSuP6N
         p4Ml6IIKPLNUpO2CPFhDWdW0ou4oYq44zCRn2xaKieN3ieNXMBa89HAPTi/nrDAnizQ5
         C1SA==
X-Gm-Message-State: ABy/qLY08c350o0BI+GIu1WGc3JTDHd/twNa8nooe6b7iKwNDaPxk7ty
        /97gyxsKa7kabEh6+57Pn+drug==
X-Google-Smtp-Source: APBJJlH9gN4lf1BG5Y8ta65Sfu3M9TLXppFnMOerf85WeJjxbXv1xrrpgEvY1a8kb0r+/RrnlMyfXQ==
X-Received: by 2002:a17:906:cc:b0:974:1ef7:1e88 with SMTP id 12-20020a17090600cc00b009741ef71e88mr4941096eji.13.1689856140998;
        Thu, 20 Jul 2023 05:29:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o15-20020a17090611cf00b0098963eb0c3dsm645173eja.26.2023.07.20.05.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 05:29:00 -0700 (PDT)
Message-ID: <490e5fe1-8eb8-8af4-c48a-646d3ab16d61@linaro.org>
Date:   Thu, 20 Jul 2023 14:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] power: supply: max17042_battery: Do not use CONFIG_
 prefix in regular C code
To:     Przemyslaw <przemekchwiala@gmail.com>, hdegoede@redhat.com,
        m.szyprowski@samsung.com, sebastian.krzyszkowiak@puri.sm,
        kernel@puri.sm, sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com
References: <20230720122528.154008-1-przemekchwiala@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230720122528.154008-1-przemekchwiala@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/07/2023 14:25, Przemyslaw wrote:
> From: przemoch <przemekchwiala@gmail.com>

Please use the same name in commit author and SoB.

> 
> Using CONFIG_ prefix for macros is not a good practice.
> Use CONFIG_ prefix in Kconfig only.
> 
> Signed-off-by: Przemyslaw Chwiala <przemekchwiala@gmail.com>

Code is okay, so please send v2 with fixed author.

Best regards,
Krzysztof

