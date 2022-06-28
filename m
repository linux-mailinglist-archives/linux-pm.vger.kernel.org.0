Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8351655CC76
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 15:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiF1JKb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jun 2022 05:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343725AbiF1JKa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2022 05:10:30 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD5210FC4
        for <linux-pm@vger.kernel.org>; Tue, 28 Jun 2022 02:10:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e28so11524052wra.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Jun 2022 02:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbgN1CKL41QDae7eKkqr8BaTjawclCJDoaPr1MzFLwM=;
        b=pOa5VprVzlXvuF7+FKxWG4/Uoqsz2AJ7EkRgukj2nJwxDesbw1fbQADxKm15sUsT7t
         v1vX+r6h0258bMbm1sF5zL1rzzWrlabChUGHYDz8r+cDhwLehTcSHWUTeQwIqfjtIeiH
         bBog9uFVAPw6fSLRV2fot7tuSY/Qi0XgkqH1eb4ARc+hjlKy8oBR/iosz4sW/vG8Eh08
         myF3PYp21xqPDNj0qI3anxuiVt3xq6u71FHL3GXzY98kiPqk8l4xE/z1ATBKiw9yI17W
         /7evqPeVzUU1qJDdcePkdsuo9u4iaMYpJsCusP6CLxAvW6CzfTc9wPJDuoLEcPoTpQji
         GX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbgN1CKL41QDae7eKkqr8BaTjawclCJDoaPr1MzFLwM=;
        b=KUIFII4CWqnsZsuem/mtnVjucoXrCShyfSyC3ZsnYJJ4OkllsBbLyNk11UnBJk+dQX
         PmuI7Dp3H5PjxIesLYbhtvq+zvjvASWpV/nmVrtTdnGOFDjw+hZmVZ48eNKLBGILKiUi
         RcpSFVzulYPHcAwvdD8coAse7vSDzKr7cNRaHedavD1u9Uzwxsb5Aw1hILO1jYrKcTcH
         f5qxmP0mCrGbzsOqp/0RHFNZ4cCdCS3OXiaJKza9xMoME0Ak0F+p0QFJnOKdmh5DlAjL
         selKPni+E1e/YFSuWn30MGFHYIlukmMN/N4wMTE8Gmi7Exrl4vAjgycXFIxGmiUaKPWF
         98fw==
X-Gm-Message-State: AJIora+60a9PQj6/f+3fLPoltwHUBa2fDv95r2pGKhAF88CWNJQyiH7h
        IeismW5LwUjPfs9pK+zPL10fpg==
X-Google-Smtp-Source: AGRyM1v7gHQR+wVeyct8aWcBwub8IuK3R4svyt1Ip8itwvHfAfKR3WQQPvslk2AhBmSp5Bgh0RsEZg==
X-Received: by 2002:a5d:6c64:0:b0:216:5680:b41e with SMTP id r4-20020a5d6c64000000b002165680b41emr16279405wrz.216.1656407428287;
        Tue, 28 Jun 2022 02:10:28 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d11-20020a5d4f8b000000b0020c7ec0fdf4sm15205819wru.117.2022.06.28.02.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:09:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        rafael@kernel.org, ilia.lin@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     robh@kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: qcom-cpufreq-nvmem: fix board compatible in example
Date:   Tue, 28 Jun 2022 11:09:07 +0200
Message-Id: <165640734233.20304.15218544381740726576.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220627143340.477120-1-krzysztof.kozlowski@linaro.org>
References: <20220627143340.477120-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 27 Jun 2022 16:33:40 +0200, Krzysztof Kozlowski wrote:
> In the example, alone compatible "qcom,qcs404" is not correct.  Add
> proper board compatibles for QCS404 Evaluation Board.
> 
> 

Applied, thanks!

[1/1] dt-bindings: cpufreq: qcom-cpufreq-nvmem: fix board compatible in example
      https://git.kernel.org/krzk/linux-dt/c/062529700fdb843eee921961eb3cbc6a51419491

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
