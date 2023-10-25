Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952297D6539
	for <lists+linux-pm@lfdr.de>; Wed, 25 Oct 2023 10:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjJYIed (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Oct 2023 04:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjJYIed (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 04:34:33 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E0D123
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 01:34:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507d1cc0538so7780604e87.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 01:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698222868; x=1698827668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dhRq6ELvC7uQFtRIB/5lAoX6fyatLerNjrGGdcwBi58=;
        b=zNpW4DbJgZkeZa8jyfn8SvS/f5V0rf5482L99Cmal28nG03jmM496iiLPqGbU5cHTB
         g6mDqe2o42sog37pIZF/lbg6BQTAnmWURaoYV8L0LXsWwE1CNcY2t9uQQZJWgerhEFI5
         Npz3NdNKqyP0uHVx4081Xl7ZnWlJfdvQyzE5YqRikJNlnSWHW7ZteKboI0tMGZdLcTWZ
         a01+dA95sAA8tZ54Zh3BSu/kBp+N+8RcXKSmdikyH1sIpkOmHdA8NAdPG4uAecI3s5k4
         UNk47yR1zUnPbQiGQSey+q/Lw3nULPSklTp+1cxxxqFMUfsVGL0T6MWKcNmkDE+IakOQ
         k/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698222868; x=1698827668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhRq6ELvC7uQFtRIB/5lAoX6fyatLerNjrGGdcwBi58=;
        b=JOPDJdTS+P2YUWqL5Hd7WzdBPYPaKzYtbcnOB2EUcD3KfoPZ11nmi+uEkOsjuEpF7W
         6HKoccdLBycCln8Cy9/rm/hy0smc/76FAN+JfUAurji3LsWbLOsfBp8KfuB4WWZ5JyG0
         5b37vb4S0pq908s1tsT5gRN2q71uW3pWwuS+Wa50eOf7y5JOs9RvuniaY7GZK10YRZ5n
         YMU8XuYwL9Nb7HhbAMIS60budJ+TKV/rzlQ6uW98ZEqy1k0DnWbEn60ygZ7HMnzwFSR1
         KnZeempgZdpvixvdCFzp2d9TAK8WyovoLSlhxED8pmG7JUZj8cKJ8PfNuIj5oy+koBtp
         Yn+g==
X-Gm-Message-State: AOJu0Yy4U8fRGMTG5IDNV/56v1x50V1TdFHdlQoAzNNVwSojwmSJYA/E
        5v631biQKE++/DivgfkYA2Cv+w==
X-Google-Smtp-Source: AGHT+IGxr5NzwFM8t4H2W5t7uvDgwxYIdSy+ilWWzmNrKaEX65sH0IwwKO21xx6dAbCpIvwpHzKUoA==
X-Received: by 2002:ac2:5e9c:0:b0:507:8f1b:ff59 with SMTP id b28-20020ac25e9c000000b005078f1bff59mr9803097lfq.62.1698222868312;
        Wed, 25 Oct 2023 01:34:28 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q23-20020ac25297000000b0050481c400e9sm2452724lfm.287.2023.10.25.01.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 01:34:27 -0700 (PDT)
Message-ID: <39d9fa16-8bf2-4698-9fa3-63841850fa45@linaro.org>
Date:   Wed, 25 Oct 2023 10:34:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: introduce RPMh Network-On-Chip
 Interconnect on SM8650 SoC
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231025-topic-sm8650-upstream-interconnect-v1-0-b7277e03aa3d@linaro.org>
 <20231025-topic-sm8650-upstream-interconnect-v1-2-b7277e03aa3d@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-interconnect-v1-2-b7277e03aa3d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/25/23 09:33, Neil Armstrong wrote:
> Add RPMh Network-On-Chip Interconnect support for the SM8650 platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
