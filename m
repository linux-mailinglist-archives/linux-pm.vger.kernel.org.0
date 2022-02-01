Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C7C4A5696
	for <lists+linux-pm@lfdr.de>; Tue,  1 Feb 2022 06:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiBAFWJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Feb 2022 00:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbiBAFUx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Feb 2022 00:20:53 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F180C061775
        for <linux-pm@vger.kernel.org>; Mon, 31 Jan 2022 21:20:49 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id w27-20020a9d5a9b000000b005a17d68ae89so15150569oth.12
        for <linux-pm@vger.kernel.org>; Mon, 31 Jan 2022 21:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F9HwklFMgrH0ZHo9rfrNQ1EtdGLFrJIK/z09jxQ6sQE=;
        b=NCBTFggGO1gX9FqyqbBI0ltcoWZj8mJa769wa6/KSNbC9l2eF3cU7jQuNvMoQcRd9H
         x2ltL54rif8kfP6tHwjX0Fm4qooi1XAlWv7gQ1gvpMgWDmF5s1yyImLGd5hLDZalfEeB
         WaX+CtM0qv+4vtKpm+n7faiKwkk24J7PgE32Gx78wZXjRc3bgGACgNtk5bHx7tjXopBf
         lfaTJ6/eEEybaneS0IHinTd7g8SQJyfQh+M4AZYljUix0ww/ts9067dtYJ96iU//8Xlh
         mAipd6OVms+UJ7xESwUONmb0oiHgUqSEPokef4R9xBRuftCu613+czXsKrFaauIUFtxe
         lZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F9HwklFMgrH0ZHo9rfrNQ1EtdGLFrJIK/z09jxQ6sQE=;
        b=5RYGy0tyVOBd0J0YKk7Z82IunTqdhROMFF2PQw9JAw8xVU/QgsICCr/j1lzvtg49ts
         lKk7obVzG4wXdtQ15Qus/V6vTZZ5h4iBk/Z+ymsPcNGEIo5oM0GFSzzXDJvwMuu1Pebt
         SaC6MTBizrIMsu7XCrx10qFPfs1vR7iRcaYx5vkOpC/emPhdnQKtvSzU8LHmAIhjM+8I
         3RVUsw5Gdhndd4BCqqHFA9KLtL4Kb30tPK+oJM9enLRGbJHL5no2bKy4mSuC6duLavU8
         XFt1riQDpLRjcH0TLkl6DdbY6bkmlCSA2XZbU2bTAbCnN3PMxmKPjUHG05j6gxZL+w5m
         a02A==
X-Gm-Message-State: AOAM531RprC0o0ZFiYjSLQ7l422rYV+DLtqNemPl1DxQKWopABLegeGR
        8GQFyKH+YcAkUB2V3zHWyzYaNg==
X-Google-Smtp-Source: ABdhPJxQgX0OxvwSIzQuemWh5fh9ef7s10rXI9v+cOHjLYoj53CFX2N69eo+c6EVORP4GKgX9ujvCw==
X-Received: by 2002:a05:6830:1f2f:: with SMTP id e15mr13175426oth.175.1643692848578;
        Mon, 31 Jan 2022 21:20:48 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:48 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     ulf.hansson@linaro.org, Maulik Shah <quic_mkshah@quicinc.com>
Cc:     quic_rjendra@quicinc.com, daniel.lezcano@linaro.org,
        quic_lsrao@quicinc.com, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 00/10] Add APSS RSC to Cluster power domain
Date:   Mon, 31 Jan 2022 23:19:58 -0600
Message-Id: <164369277345.3095904.10944386444643776011.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com>
References: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 9 Jan 2022 22:54:57 +0530, Maulik Shah wrote:
> This series patches 1 to 4 adds/corrects the cpuidle states/
> apps_rsc TCS configuration to make it same as downstream kernel.
> 
> The patches 5, 6 and 7 adds apps_rsc device to cluster power domain such
> that when cluster is going to power down the cluster pre off notification
> will program the 'sleep' and 'wake' votes in SLEEP TCS and WAKE TCSes.
> 
> [...]

Applied, thanks!

[01/10] arm64: dts: qcom: sm8150: Correct TCS configuration for apps rsc
        commit: 17ac8af678b6da6a8f1df7da8ebf2c5198741827
[02/10] arm64: dts: qcom: sm8250: Add cpuidle states
        commit: 32bc936d732171d48c9c8f96c4fa25ac3ed7e1c7
[03/10] arm64: dts: qcom: sm8350: Correct TCS configuration for apps rsc
        commit: a131255e4ad1ef8d4873ecba21561ba272b2547a
[04/10] arm64: dts: qcom: sm8450: Update cpuidle states parameters
        commit: 6574702b0d394d2acc9ff808c4a79df8b9999173

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
