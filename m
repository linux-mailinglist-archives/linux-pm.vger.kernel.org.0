Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF3F3F6373
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 18:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhHXQzE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 12:55:04 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:35456 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhHXQzD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Aug 2021 12:55:03 -0400
Received: by mail-oo1-f41.google.com with SMTP id o17-20020a4a64110000b0290263e1ba7ff9so6711747ooc.2;
        Tue, 24 Aug 2021 09:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BN9h0+FpUk0o6i8pFJyVsEj7oE46Agrtf2bQvcQp2C4=;
        b=IxCoo6BdkcygnPbcmK+8OO2vJQ1IsbUG2uzkp+0TlDGH8p2J4j4bEAkse3rrUQEzNE
         0lHZPK7q9EQi2FiOcXTkBShAt62kpvY/gaH6sFl2OVVNevIh0P1c4XklDe47ZnNvhIqp
         1/4/7ty0WGADLNhwpPvq01+kaweuDifBdZg5xMNRsKveyyfmoVwsiW+EGDuSbjJ1FQ3Z
         nyHht/1+UKdLRZDPO89u8I2IyIada0Ww8ejfmKmTEHwAEcWYCS6jWxRqFV8dbUuo1Kek
         wOTOWaaVegxVucvn+p28MlXPRR6zOIPbxfxI2Gh0u5V1EJdHI7bKCfCadmzJQaeymwyq
         u3VQ==
X-Gm-Message-State: AOAM531zPGCmiGZy2HtjJXtaCjiNPP/hnrjFmcGfEGGFzjsL3srIbqKc
        H+KMiT6PgGQXKDni7t0ZZw==
X-Google-Smtp-Source: ABdhPJxCuPjalOTnEUsf0GBi3unFaOfI6Wx88SGEOV9NGjoa4ZqaGtcFKTPdqa0Kn/nTjyiEtADicQ==
X-Received: by 2002:a4a:e3cf:: with SMTP id m15mr30966128oov.21.1629824059186;
        Tue, 24 Aug 2021 09:54:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u14sm4805507oth.73.2021.08.24.09.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:54:18 -0700 (PDT)
Received: (nullmailer pid 618860 invoked by uid 1000);
        Tue, 24 Aug 2021 16:54:17 -0000
Date:   Tue, 24 Aug 2021 11:54:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: sdm660: Add missing
 a2noc qos clocks
Message-ID: <YSUkObWtKWJUDzyS@robh.at.kernel.org>
References: <20210824043435.23190-1-shawn.guo@linaro.org>
 <20210824043435.23190-2-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824043435.23190-2-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 24 Aug 2021 12:34:33 +0800, Shawn Guo wrote:
> It adds the missing a2noc clocks required for QoS registers programming
> per downstream kernel[1].
> 
> [1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-bus.dtsi?h=LA.UM.8.2.r1-04800-sdm660.0#n43
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../bindings/interconnect/qcom,sdm660.yaml    | 46 +++++++++++++++++--
>  1 file changed, 42 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
