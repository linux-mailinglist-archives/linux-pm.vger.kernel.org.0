Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A244765A7
	for <lists+linux-pm@lfdr.de>; Wed, 15 Dec 2021 23:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhLOW1u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Dec 2021 17:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhLOW1t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Dec 2021 17:27:49 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09CBC061401
        for <linux-pm@vger.kernel.org>; Wed, 15 Dec 2021 14:27:48 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so26695733otl.8
        for <linux-pm@vger.kernel.org>; Wed, 15 Dec 2021 14:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dIqIom+6jORRTxpmI0psBmUBPM2tyjb0zli2DVcltbs=;
        b=v3ER2xjV23bBf34X2L2KBXPBzhIy9SFNBuwoR9+Cvf+FxslgIDIjKVXZUv/qHNRFuL
         A/JzCe87bLGAgK/L7ukIXC7LhZClCkRLnwTI+g5yUeXu901ZIMoZovxy0TFO4OUr2b34
         +CAHXbj0H2PxHhrKs2OBZ1vIKRO5ZwBxVelYoQZkY4UJ2WSa+h581FVgwT8nf6alcIiY
         t8iXPhYfuOiKTBLa9PzRy5IX7wQZyoHNlajf99RtcKkuyZVjWsMhBE2xmjHP5nxR9mjP
         DuTTUEfd0lBgdn7Ees8npXyIj1UjXs2o4YmP43Iah1uRAPxujRGPk6bKCxaFz+/VgdCq
         vTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dIqIom+6jORRTxpmI0psBmUBPM2tyjb0zli2DVcltbs=;
        b=Dd61d+hRXskXcLCXw9WO+GH9nt8gMiDmn/Okaz67Pzdb7QEyTSCjix/HLiHNBWw3kg
         HjVC7GV2f1YOID9uUrhmkmPYWOK/eO1DAKCtyy4HjrLWUU3JLld1QrDbihooIDE7iWM9
         pLiq0AztJO/WQZCVjsWSjCStwTIXcVp6Uj/Ts5cHrmjDSfid90SdJ09G8yZDubRfXA/7
         lvcQsenNFExbhYBWphsJmh0u8tC74prl34cMdebW20htcZP02gaKzBWSlswHhtcky2Um
         loqhsILjvECMqSqwWg4SFyMLiSOEvh+LEbiGjyvum5j37o6Kgpvx8k7s6Waax6ZY+M87
         3DGw==
X-Gm-Message-State: AOAM530qDqllm7xl6xsdzO/eJHDbfa2aH1J/2iSYNzw6cJB5ndY/82en
        E5S4qCz5qXaLEonnokMVvxcCaw==
X-Google-Smtp-Source: ABdhPJzrOMqt+icTtTZcyUIkwkwGfQe+HYzLL7ff67WDZyGhsplapFWooR+59CLml9IBdkHvC4Ah6w==
X-Received: by 2002:a05:6830:1be9:: with SMTP id k9mr10310267otb.123.1639607268004;
        Wed, 15 Dec 2021 14:27:48 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t14sm700500oth.81.2021.12.15.14.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:27:47 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/4] arm64: dts: qcom: sdm845: Add thermal zones for PM8998 ADC
Date:   Wed, 15 Dec 2021 16:27:19 -0600
Message-Id: <163960723735.3062250.11642427389865484794.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211005032531.2251928-1-bjorn.andersson@linaro.org>
References: <20211005032531.2251928-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 4 Oct 2021 20:25:27 -0700, Bjorn Andersson wrote:
> Describe ADC channels, related thermal monitor channels and add thermal
> zones for these.
> 
> Bjorn Andersson (4):
>   dt-bindings: thermal: qcom: add HC variant of adc-thermal monitor
>     bindings
>   thermal/drivers/qcom/spmi-adc-tm5: Add support for HC variant
>   arm64: dts: qcom: pm8998: Add ADC Thermal Monitor node
>   arm64: dts: qcom: sdm845: mtp: Add vadc channels and thermal zones
> 
> [...]

Applied, thanks!

[3/4] arm64: dts: qcom: pm8998: Add ADC Thermal Monitor node
      commit: 4cc7c85cccc87e436a86b4281ddcd886eb0bf58f
[4/4] arm64: dts: qcom: sdm845: mtp: Add vadc channels and thermal zones
      commit: d5e12f3823aed1e35ee2411bdf0ab61dc1011387

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
