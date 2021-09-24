Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CC6417DEA
	for <lists+linux-pm@lfdr.de>; Sat, 25 Sep 2021 00:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345479AbhIXWp6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 18:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345636AbhIXWp4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Sep 2021 18:45:56 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDC2C0614ED
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 15:44:23 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r26so16589000oij.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 15:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aT6PGCkfFncvQ02pWWpD+cjAoPpE7N0nwI03xARf6nc=;
        b=PCmlVYezCc+6GF3Gbr0DDg+qJ5lEqnrovDEBcz52iwgdJ4j5VSzh6amczofyFKSVI/
         NrRCKDI1ZYOjO8Dl6hMlDkZdicT7c3XB5RVQ2LYPz5WB8OTSMg5m0Nq94H6yLNQ78FFq
         h3OQfQqprhSCoxJUj8p8///J+n4e47B95WsF5ToKLIEWhWSxQPADViwn5RSkGe0uEJRC
         4KuWWmvQcj72DzCsbGGBPeQI7z3peJ+3nAfMfUWI8LHfr5G8IalTM0e7HJ1CTPRs4XZG
         p1bTOZ+/McfFVZA10tBdZcMEE5fkLaXQg+Ff0km20CxK7BVCIxHu2xREEaHl3t5nFtFk
         lV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aT6PGCkfFncvQ02pWWpD+cjAoPpE7N0nwI03xARf6nc=;
        b=TJwmja4szO7zjNDPzTCEES/Y3iNds3yKqVxBTulW8Cp720dUwo4V50KwuG8gfQaomc
         FNJ91Knt6ay2egKwOY3fmt3DexVEu6otslXiBAzRUKe4/eZaRP6e7KlUL5bHVUhqJDJ/
         s9g0Kpf6OA5A+6tXejYUMbGFsuowAFQlXm51Q6mgOWwJRdfjaT22lf74rb9JKy/EZk/H
         gbW66TiMXqgV1jeX7Nz5Wt5hA/tc5Lhrh/0Hca88Wv2HrpB/evct9DJ773+Dfb/fuMr/
         q0EehCNPEaziJvlalufMGaibS56x/+8tOAVZPuVpCMt8XZyV9n0aW4kWVffyG7z6++NH
         NAPA==
X-Gm-Message-State: AOAM531aLAMcX86uugQlujXN78jvMQvJsZykWrEwsA4NelaQMgD4ZSQX
        AP01ojrpkAXGpmFX2SYgW5F+rw==
X-Google-Smtp-Source: ABdhPJzR8TfKHOJ9wfri+64aYAbQV0HcxwGNIVS0ipSncoBUjvD1yYrHw9IuohW36CdYMMqjt/83Cw==
X-Received: by 2002:aca:e002:: with SMTP id x2mr3454614oig.19.1632523462457;
        Fri, 24 Sep 2021 15:44:22 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a23sm2374956otp.44.2021.09.24.15.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 15:44:22 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>, Georgi Djakov <djakov@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v2 3/3] arm64: dts: qcom: sdm630: Add missing a2noc qos clocks
Date:   Fri, 24 Sep 2021 17:44:20 -0500
Message-Id: <163252328671.1213592.16008455401574085015.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210824043435.23190-4-shawn.guo@linaro.org>
References: <20210824043435.23190-1-shawn.guo@linaro.org> <20210824043435.23190-4-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 24 Aug 2021 12:34:35 +0800, Shawn Guo wrote:
> It adds the missing a2noc clocks required for QoS registers programming
> per downstream kernel[1].
> 
> [1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-bus.dtsi?h=LA.UM.8.2.r1-04800-sdm660.0#n43
> 
> 

Applied, thanks!

[3/3] arm64: dts: qcom: sdm630: Add missing a2noc qos clocks
      commit: 1878f4b7ec9ed013da8a7efb63fed1fbae0215ae

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
