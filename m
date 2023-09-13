Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA46F79E1F8
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 10:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbjIMIYh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Sep 2023 04:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238694AbjIMIYh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2023 04:24:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00947198E
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 01:24:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c7912416bso6939150f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694593471; x=1695198271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggBtgbLm5SRuIxjEQCR6fuKEBJ2k5vc95TNuMoN5/ZQ=;
        b=DDaOo+qw7hHbp4PDorXm6rDfWBnPLe9yv8JtiqRd0/wmNz0sA2YMq8xcsRog8qalC3
         PsF6U3EBmt5RPXDOGLiYmNmDMiZUKEau0BNorIJZaBnXDzNPDpo2xuXyLdnu8wywxu+E
         pNo10dXTbvsi/e3yKeBV5IfD8M9r3kVHA9QsmA7Fg2Nr6ELTZO1O7UKSPTp8UtEtgYE8
         pilvmSKP0uEsdl+ILmtT+SgTlhEOvj4YFRam8nuu7ilQZupT7U1/AeiNFevRFlKmAv7J
         T1d2kZSLXnHNzXL9M8jxAWHwnaEmMBRlZkg7GUeiT/vc9//HIJRqmrJNa8u/j6jOtJMG
         /Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593471; x=1695198271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggBtgbLm5SRuIxjEQCR6fuKEBJ2k5vc95TNuMoN5/ZQ=;
        b=hdYh74QVkennnPaRgwra4mTVtcPlrtZC+/Qb9Bm2oMcfeJd2R8uw2XC9k/WUJ9v4Zx
         JWrWkEo5zVqpawGd4+N5hUPpVTrKh6k/1Hh0hk55Noy/Dzw5XJibdc8TYlb+odOYWJpv
         3SlXt+cK4r7oHu3A3nsbvxO8O6W/X9uNm01PBkmcBqb2pbShqj1izJad1npuk2jDrFJt
         5BBJO58m7ZGo3e8QTZXTiAIBVjr4HLUK5r/5ZAiEUL7SsxKbgOuyls0XIazmEaAZwyum
         V+OAIEJVDOoHiYU4sTIgJkUJCgGrbv1EVhzEEU46KTJGj3duelcAzcKCpw7c6V45zkvP
         UbOA==
X-Gm-Message-State: AOJu0YyNpmsKBY/VhuV+eTEfn2x4Cz1/eQVJJmy3ULatGQEOVycIxD7+
        FoqKTMcQDMPfCHN5X0ITlGs8j94vbNWLtWOuTo0=
X-Google-Smtp-Source: AGHT+IFXabWAiPieo98hnbDGr9uxhTqkqa82VC7vCktG6bVMPMlapg+rIO/G/+Q7tHCURas6Bl2+Lg==
X-Received: by 2002:a05:6000:1a54:b0:317:6470:3271 with SMTP id t20-20020a0560001a5400b0031764703271mr1425384wry.45.1694593471335;
        Wed, 13 Sep 2023 01:24:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id z12-20020a1c4c0c000000b003fee6e170f9sm1274208wmf.45.2023.09.13.01.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:24:30 -0700 (PDT)
Message-ID: <793f87d4-129c-33bc-38dd-b4b2c93dd241@linaro.org>
Date:   Wed, 13 Sep 2023 10:24:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: Add compatibles for
 SDX75
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com
References: <1694513046-24064-1-git-send-email-quic_rohiagar@quicinc.com>
 <1694513046-24064-2-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1694513046-24064-2-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/09/2023 12:04, Rohit Agarwal wrote:
> Add dt-bindings compatibles and interconnect IDs for
> Qualcomm SDX75 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

