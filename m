Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A6E6D28DD
	for <lists+linux-pm@lfdr.de>; Fri, 31 Mar 2023 21:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCaTzM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Mar 2023 15:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjCaTzK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2023 15:55:10 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0DA1D85C
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2023 12:55:05 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c9so19923267lfb.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2023 12:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680292504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEAdsWFoJkjHMBHPH+95D7sNzjTrQQXZjQsPPw6S5ME=;
        b=QHMDarZLHJx852b9ZiSCLRBCBfsdzCzB+ayx7onpF4Ubjl00oklAe/Tae7+J1W+A4h
         ge19SjCS5lLzAgF8M0zOXUDwoe7z+hq6viXKSWEdXyQJFjXP9jFZz/22v4+Ka4gM4M/5
         X6Loauj4O+GPcS91IePJcMnTyIgs+KHqBOTJiu3tZhc9jXkQ6XQXsSH8zYKWWhKckbJ+
         M0wBCxEiOjw0jznArcsxVG7lOeDNqhz43aaKp1UiNn5uIRuRx2zGpPMZoS/RLm2puVoS
         2YIEXAL4u7fzmnA4Wvphi10UIcvXLiiXyFStu8HKecc1ZrnyrctBqCRGiTZLoE3cTBRa
         CPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680292504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEAdsWFoJkjHMBHPH+95D7sNzjTrQQXZjQsPPw6S5ME=;
        b=2MSxAvnOk2WKDatRxxT3Pdq/bmNuE0WXVfAlwMKL44k12IdjnlAl9uvj6wXPhYvDYw
         pZQY4rTSgsAbrcioBY/A5I6D1mf6nmeeS/ykqnFafxLCkeJEZn9kxDJvpsdxw2fojC9A
         RtdaPVrEYr6SSftYh4jcrH8bSB0ah0bmO+0cd3Yogh7Y8SQ3N07ysjWSogp3Nk0bkbjJ
         dGIq8Bxo49MByTNjD9+UzVyfJ5T7xQAoyT0Q5EL2pRk75iV7HHI5dlShwItCgWPLY3OB
         34KMqpQt+ptuMunwO5boRsIHcgmEbYXO5XtaYARgZNXXZ+l/tF9py6kdYTIicvtUh3ui
         OtTQ==
X-Gm-Message-State: AAQBX9daGwCHhxD1fmo7hjmRCioyVjxN6FmfRVm26f24tmKvNZe4B5b1
        w/XUm+PVh+httwwOb3zQIa+qwFzOzJ8KA933hFo=
X-Google-Smtp-Source: AKy350blOH0hz8YKwsWEVTSNDXs3DPnS+Rg0iYOlqM2SWTQvHnTcF2lKkfwXoiKP2kVsFyFNZ3+BRA==
X-Received: by 2002:ac2:508b:0:b0:4dd:ab39:86e0 with SMTP id f11-20020ac2508b000000b004ddab3986e0mr8888617lfm.27.1680292503924;
        Fri, 31 Mar 2023 12:55:03 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c4-20020a197604000000b004e856a4159bsm505196lff.20.2023.03.31.12.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 12:55:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: memory-controller: Drop unneeded quotes
Date:   Fri, 31 Mar 2023 21:55:00 +0200
Message-Id: <168029249648.4333.1979310609371530218.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230331182119.1899919-1-robh@kernel.org>
References: <20230331182119.1899919-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 31 Mar 2023 13:21:18 -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> 

Applied, thanks!

[1/1] dt-bindings: memory-controller: Drop unneeded quotes
      https://git.kernel.org/krzk/linux-mem-ctrl/c/69d170c4c28ba0490bd42630cc09d7e1834bbb3d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
