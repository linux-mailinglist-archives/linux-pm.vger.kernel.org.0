Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE7D7BFE7D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 15:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjJJNxr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 09:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjJJNxb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 09:53:31 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E6D1BF5
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 06:40:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c00df105f8so72193381fa.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696945235; x=1697550035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XxximMkoWGQA+uzz71VUStaHnVSe2K/WIUNaeHglvcc=;
        b=LqV+ZEePymX0b2CYVfcmrvRnvP85Ofakx8Pjdst4wUPz3S7lkMC6GuMgPueHipAj9a
         Qa9B3UvKidAUN2IURc/nGqPKVs5RbVDHBoSPhBNoLm3KCd7VtE3ULkXt/vRZoawa3hKr
         31OY5msVJ6FfyljsiancWRyaP7M+wddn5OZWmnjx2prezuxh26Tyf8EgyhDe9DvCLEVb
         6B5D70vp9NrGEYHWu1gNmUu+gcIScZqaB3q+2IsnOJ6D6TdB+i2EgvOdwcDcHPDutkxq
         V2RKJlt9s6/lgG98fRRHM9e7uALhf9Pz6x8u0q8bzxmADpnhNuLrgEdPSObPSELn9pZT
         NwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945235; x=1697550035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxximMkoWGQA+uzz71VUStaHnVSe2K/WIUNaeHglvcc=;
        b=oyeaIftcJ4bdL/We79RnDxMtqRQwFgAysJ3MJYTll40fzGCxahcyonIkgvmI1oSltl
         n4YlD3jFZvmOjZcbi44sJ1sgC6XYaK+W6fAyV9+fOJre7E+m45hnZSkZwi63JVjG/LPa
         gkHqcV8XIHxexiOw9iBZhXF22T67zf13upkRHd7mGDpwGZGWRn77/LBKWyHwIH8SoSMe
         hY+jMLASFbQvTqQWS7H6cf/ZT3SM2aK8UNS6n/+mPdjpqQOYBBO/qG5crk9GOtXgDUmZ
         Yh0oK+lELAOOW/Awc2dWSQsTTbfH/H2S1chHLhbo2HieWBhHO/n/bcI9ermeNMNjDozh
         6Btg==
X-Gm-Message-State: AOJu0Yzb0zv9ciD6jSUQUcTYA0VQ0ft+4l3KYHJP2QAEr48Sc7fUc7+q
        ytEN8dxRzeUGMwPVOnk5P/zVzw==
X-Google-Smtp-Source: AGHT+IF6lr0SvRheFgchDQzYQqCJnSx8Bi6IESHLFO+fVACAqFpnSaNlGIZF0isBSwL9absMNKdW/Q==
X-Received: by 2002:a2e:9a84:0:b0:2c2:8e57:24a7 with SMTP id p4-20020a2e9a84000000b002c28e5724a7mr16879591lji.21.1696945234817;
        Tue, 10 Oct 2023 06:40:34 -0700 (PDT)
Received: from [172.30.204.192] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y9-20020a2e3209000000b002b9b9fd0f92sm2348720ljy.105.2023.10.10.06.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 06:40:34 -0700 (PDT)
Message-ID: <e255dcbd-6342-49e6-9bfe-17a47b2a3c8a@linaro.org>
Date:   Tue, 10 Oct 2023 15:40:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] ARM: dts: qcom: ipq8064: Add CPU OPP table
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
References: <20230930102218.229613-1-robimarko@gmail.com>
 <20230930102218.229613-4-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230930102218.229613-4-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/30/23 12:21, Robert Marko wrote:
> From: Christian Marangi <ansuelsmth@gmail.com>
> 
> Add CPU OPP table for IPQ8062, IPQ8064 and IPQ8065 SoC.
> Use opp-supported-hw binding to correctly enable and disable the
> frequency as IPQ8062 supports up to 1.0Ghz, IPQ8064 supports up to
> 1.4GHz with 1.2GHz as an additional frequency and IPQ8065 supports
> 1.7GHZ but doesn't have 1.2GHZ frequency and has to be disabled.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
Christian/Robert, can you provide a downstream source for this?

Konrad
