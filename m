Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099194C3736
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 21:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiBXUzQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 15:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiBXUzD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 15:55:03 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A96227582
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 12:54:22 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so2211094otl.6
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 12:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YfJFTU/SisfAPs9JKDHMGgPqhCwNHsIGV8L1A8XDLlU=;
        b=OMHLyMTq5+u9d9yoBScCGhM0BMPqB37McuH7aXNiL4K0QOIXtqW0+i/rd191UaHlR0
         XeoPHj4uww9/n9rn7V3FC00ZfBFaZp3PT2qk+DXEIwUqTwNtspKi7yvSYDzxtvDIg5LC
         lENwFIRMwvmKgLy4X00RmM2WaMXvrnOc8mAIQkGVF8hQsz1eoOac7xXoAID53s/HMp41
         tdpI7xj2dBDIxEdFgsv2onYcaLyDt4UiyQN2fht+cex1EVpmQP1OaY3ayG6PP3eynjp1
         3RLSXPYRun0c+c3Z0XROaHjgAhUQQrgq4lTDV+3+AhYSogmxb7vFxfh80XyYopz1DC4B
         86ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfJFTU/SisfAPs9JKDHMGgPqhCwNHsIGV8L1A8XDLlU=;
        b=t7QKCcllsXaE/LSPdXhKjAe0TX8d7sU/w/NQHNlEsG2MEtpcvlKONa3tgQgozxbaLO
         4zsxt6L1BUJSebJ44eldhJ5T99OokjVjNh4cTKjeCcEYqKBE2MFtyorMa9tNOclHfQ6v
         L5DmKNtElffQZzghWiYjFPMESjmvLxkN/FcUrTP9d5MArcmp8XTLn7109Ihl19CXxcz1
         XDzouS9Se//k8LKQckQ50Pw6rdQWqAPvM9u/8u0enKv7C2k5vnp2DA3y/Yd43zshGsiz
         odNGV4TPnfT/A2UcOxXjQ8viO9jgEjW46UZ3EwlgaBlnknhXEbvfeHQV90A+46AnoewH
         tk4w==
X-Gm-Message-State: AOAM530n1Mch2AHGAeLnJftx+9tDi8yQNvJesvIzP2rhs4Ylv9ZnLlL/
        fJKTGprCFpqk/UZW+8d0RFkXWg==
X-Google-Smtp-Source: ABdhPJyrRmbj+mSeiaX+91lpDoKZG7xScJ0qAqLMuj1UY/gOm6vTRI8pWT6D58WwacbQQoADffwrdQ==
X-Received: by 2002:a9d:730b:0:b0:5af:3058:b962 with SMTP id e11-20020a9d730b000000b005af3058b962mr1615926otk.135.1645736061326;
        Thu, 24 Feb 2022 12:54:21 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm191259oou.10.2022.02.24.12.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:54:20 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     mka@chromium.org, dianders@chromium.org,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        linux-pm@vger.kernel.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org
Subject: Re: (subset) [PATCH v4] arm64: dts: qcom: sc7280: Add cpu OPP tables
Date:   Thu, 24 Feb 2022 14:54:06 -0600
Message-Id: <164573604161.1471031.14236592247266780650.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1644428757-25575-1-git-send-email-quic_sibis@quicinc.com>
References: <1644428757-25575-1-git-send-email-quic_sibis@quicinc.com>
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

On Wed, 9 Feb 2022 23:15:57 +0530, Sibi Sankar wrote:
> Add OPP tables required to scale DDR/L3 per freq-domain on SC7280 SoCs.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Add cpu OPP tables
      commit: 1e8853c698276d20cdee99a8019f9f5e54c5c0a1

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
