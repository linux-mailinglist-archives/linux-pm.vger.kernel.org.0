Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A508065FF5A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 12:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjAFLJ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 06:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjAFLJZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 06:09:25 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7768571498
        for <linux-pm@vger.kernel.org>; Fri,  6 Jan 2023 03:09:24 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id az7so967934wrb.5
        for <linux-pm@vger.kernel.org>; Fri, 06 Jan 2023 03:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NG9dI4XhzCl+b3Gp7Tvxu9PI8w7dD/LzEOXVng8l0Ao=;
        b=U/WmJaCsUbxjTydbg4Af/tWcwcxtNTesw7pTDU/XaAczQRZdVmUq7fi8tH6CSi0+Kc
         ipDuMqJHRQ15Y8+zdFdoEOe8jt5y9S5mLwF6qm5IVlN71q20h5/SzARpYpiBspBhPB9M
         vV04LPulrZs2jXAeenTOwxxWrLBsgMLoK3Ggmkx+HeLIH3unLDGW4gwWRRVwcOgKKj+O
         VtnRdFp14fsvwujeznv1mhdJnp1RVS9WebDWeooHtUJqkTpzs/S8l4KO0Rvn4AICerMb
         2UiBM2IBzJUQQC2XNyhSEjrzG09d4V0JvxfV0cGYQ3+1jk5rTq3YZV3oplBfnkSh7FGG
         uscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NG9dI4XhzCl+b3Gp7Tvxu9PI8w7dD/LzEOXVng8l0Ao=;
        b=uWcxR3/tgB7oHxdxUEmJA23Neyiz5Vw/CoLSdos9u+uuGXkd2f6z54c4uk7hLM3X4L
         k6R3AgaCqZWy2MmCVA5hk2P5ZsenMwz+pTfNEmsFacUc8vPmRm4hC3PCpIWfLRCPYYVj
         5BQVhxiAm3YNYLfqHaDfhgaPBPx8zroxhHdy+W3TIZHQQ7LHZkMBiNmkhWfQuxm4NAS6
         MaKD2ZARkXE0j7V7MH1ainXjNN+la+s3fZboULgFL22MuhLDojAVWZHZQjPmQ9iW5u8q
         1mGScQ4ad3EdLDQOmPFu+5D59QDxHmytxDEsLL2z9twRWzJptMLzyklIT4J9Dg3iBKpQ
         yZ6A==
X-Gm-Message-State: AFqh2kojEWl1IyNNcFRYjRAY7X/bmiAXg5nDf2O1d7iTuMDh4ajFpQTg
        gJ/RL7qs+5ULSXgpO5DWuUsg9Q==
X-Google-Smtp-Source: AMrXdXuecYwI1nTafgjoLujoRH+Hy7/rmJKdE2TfsSYxWshCtXsL95CSTshxkTNACZ0m+fYffqlT6Q==
X-Received: by 2002:a5d:69cd:0:b0:242:6b2f:4988 with SMTP id s13-20020a5d69cd000000b002426b2f4988mr34423991wrw.46.1673003363081;
        Fri, 06 Jan 2023 03:09:23 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b1-20020adf9b01000000b0028e55b44a99sm857396wrc.17.2023.01.06.03.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 03:09:22 -0800 (PST)
Message-ID: <4f2df0c4-d251-befe-800e-82e43e07721b@linaro.org>
Date:   Fri, 6 Jan 2023 12:09:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 9/9] dt-bindings: interconnect: qcom: drop IPA_CORE
 related defines
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Alex Elder <elder@linaro.org>, Johan Hovold <johan@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
 <20230106073313.1720029-10-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230106073313.1720029-10-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/01/2023 08:33, Dmitry Baryshkov wrote:
> These interconnects are modeled as clks, not interconnects, therefore
> remove corresponding defines from the binding as they're unused.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  include/dt-bindings/interconnect/qcom,sc7180.h   | 3 ---
>  include/dt-bindings/interconnect/qcom,sc8180x.h  | 3 ---
>  include/dt-bindings/interconnect/qcom,sc8280xp.h | 2 --
>  include/dt-bindings/interconnect/qcom,sdx55.h    | 2 --
>  include/dt-bindings/interconnect/qcom,sm8150.h   | 3 ---
>  include/dt-bindings/interconnect/qcom,sm8250.h   | 3 ---
>  6 files changed, 16 deletions(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

