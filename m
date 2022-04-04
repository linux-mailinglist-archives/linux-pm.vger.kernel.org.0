Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2474F1A6A
	for <lists+linux-pm@lfdr.de>; Mon,  4 Apr 2022 23:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356184AbiDDVSZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Apr 2022 17:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379395AbiDDREZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 13:04:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3345640A27
        for <linux-pm@vger.kernel.org>; Mon,  4 Apr 2022 10:02:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k23so17853506ejd.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Apr 2022 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AZy7e16Ig1JG7qj3MBTWcZiECGvCR3TfCcY9SM2k7uA=;
        b=TkwLryzG8xq8ZJgUcCjQo23owBZZxVZFlkUrfEjVt10WatBuovqiDNcaYbAr25omCj
         d/kdNNsblDqCmWG5ynrU8fhTXwQ/8Ch/9Es+pyux5G6XK9KlilWd6omMRts4Qr5EVCOD
         vT85iI2i9IE/qPYUVU9NmGMmM53GkB4/i/SaTw9UAzzF0fYfcXY5EVrC8qm7/w4jB6DI
         iI0q2d55LAvT0MvFWh0m8iwFkBjqZ4+uErSypFFgzJUqqdQ3WSZwOkiq1AaAApg8LADP
         LOsfRO1HtVp7I2biiAyX3xEtqSmtatDXPSIpc592+g14AaVuhm+poLEgUDxFYxX8L/xy
         9UqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AZy7e16Ig1JG7qj3MBTWcZiECGvCR3TfCcY9SM2k7uA=;
        b=N+mIRr5uomUwtBqPz0eiida/Bmi22UnDTa2+C5kdzO8XTAKz1art82vk38dxaKF93K
         bGK36ZzVO06tdXpScV9UsCKXoy7vliTuNHUHHeIJz7f7QEFY1YOmiglm0rRm0mv/2kj5
         Kh5SQQcXS8NadbRuPc7VKhX2D0/EjUimXCBfeD/gqgFx5hP4YRXYC24inVYRQHsJG3Fp
         e8jZ1ZOdCUiIJ6BYKQfiQkD6yg7/uTVKAnme1ZHfDrNNCN8xrqr+mOW+5kJaj9ahewbn
         Ir4813EhQlEbfm6M0ZqTn050u+apzAySFmtftqaa6KfeMaLp3sjrcqunPpYOnvMuyozv
         WVpA==
X-Gm-Message-State: AOAM532FPjbwi3j7APMImbPNaqyRShuMgAgCZoMWhw+wDqNvr6a7gXb3
        8/fbnpaJmik+cCCvm6uPsoSnDg==
X-Google-Smtp-Source: ABdhPJw30fbKCfQKHVKnmx6muF5fQbHs2yESn5RWTv0aghy4f7F4Sy0XYE4R1cIxrr0pe2nLy7vXTQ==
X-Received: by 2002:a17:907:7205:b0:6e7:ee50:ea94 with SMTP id dr5-20020a170907720500b006e7ee50ea94mr1050231ejc.351.1649091747789;
        Mon, 04 Apr 2022 10:02:27 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id hs12-20020a1709073e8c00b006dfdfdac005sm4588927ejc.174.2022.04.04.10.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:02:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v3 8/8] ARM: dts: exynos: remove deprecated unit address for LPDDR3 timings on Odroid
Date:   Mon,  4 Apr 2022 19:02:24 +0200
Message-Id: <164909174137.1688710.5639682730055944531.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220206135918.211990-1-krzysztof.kozlowski@canonical.com>
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com> <20220206135918.211990-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 6 Feb 2022 14:59:18 +0100, Krzysztof Kozlowski wrote:
> Passing maximum frequency of LPDDR3 memory timings as unit address was
> deprecated in favor of 'max-freq' property.
> 
> 

Applied, thanks!

[8/8] ARM: dts: exynos: remove deprecated unit address for LPDDR3 timings on Odroid
      commit: c3d3727c8531ba78fc725995ce34cf948ebf1dae

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
