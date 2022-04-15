Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03A1502F95
	for <lists+linux-pm@lfdr.de>; Fri, 15 Apr 2022 22:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348933AbiDOUOa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Apr 2022 16:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351673AbiDOUO3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Apr 2022 16:14:29 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB2FD9E91
        for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2022 13:12:00 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id f5so5352631ilj.13
        for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2022 13:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mvSvqL6kka2POoPBqEb30mmz0+bGVlzGfy1i76kGDWo=;
        b=KHmK/mR3OenLbbhdRJrv7vZgpxAk+wqETTeIrklldo8PgCRpB0ZlXiw3Ex1EQ7W5R5
         +INqFK6Sitv97z+TGDHnr1otCc5rpELvfn6IP03xTpPSO6+Rk+Brwn1nSGDDHfFyKlNT
         FjRb5Y0ECvnCqUqUJBEcbtI3+duCZKmMO4ib1vV3qR9R6LscshyTNrDZerz1mArENyHK
         moag6jI1MfIsnmvDd7CWFCam+7FrYNT013kUp2KDYjmN6QcCdirA59aQnBY267k6gpr2
         rtUMwXZvBz7SgU/4jjx/c8LaUrpSRvGKQoSzO7xTvdB8Ifuv0qFPgWNMnSNAIx8jGLEe
         kPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mvSvqL6kka2POoPBqEb30mmz0+bGVlzGfy1i76kGDWo=;
        b=bgIHE2jxts/OBqU1Ncq6Vuduo/imVXZyGYuD3lIX5a890VZXFiaNRpGNZVMa+xaviw
         amp108AOH6JOlWXUm4YKEwh+SKgyKmKMA7mUHxMXNNVQhM+6vatOU/JPNJXuYRoVZpE3
         64Whr7TQhZStlf7PnlwN0QHK5s9gqp6gbrC9uQZ1Xej5Sw8VmSiYNVyMpRSAZN/p03bc
         7b7jeHbC9D+OEesiQ87ENvV6mh/eD8+o7ftjR0y9EzUeoHrPMIZVK+jFBRiaJ9HLkjDf
         OZYt83dA0Z69lvCfnEdktH7o+uy9i5cxzIGZES/EOfiBVYH/JdZDBC0gOHOZAbuuZu9N
         PzpQ==
X-Gm-Message-State: AOAM533D5oZWzWF6+OejifxrBGUsu+IZmzhzQ6MGJ/C4/TKOjQNthJQB
        4GFzYjqNbA75Su5mpjfMB5J+E8v6bpNc6Q==
X-Google-Smtp-Source: ABdhPJyf88LAbPDLTrhasaJVEAZlbWp27gqQVF5Z4wtsCIb65knob6t8ZSUmSnlF8h4vKxQGET8r7g==
X-Received: by 2002:a05:6e02:1a28:b0:2cc:244:f516 with SMTP id g8-20020a056e021a2800b002cc0244f516mr191882ile.181.1650053519561;
        Fri, 15 Apr 2022 13:11:59 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id h24-20020a6bfb18000000b006497692016bsm3459029iog.15.2022.04.15.13.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 13:11:59 -0700 (PDT)
Message-ID: <1da896f9-a86e-4e2b-ff36-bd0a4c8d819b@linaro.org>
Date:   Fri, 15 Apr 2022 15:11:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/2] ARM: dts: qcom: sdx55: Remove ipa interconnect node
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>
References: <20220412220033.1273607-1-swboyd@chromium.org>
 <20220415005828.1980055-1-swboyd@chromium.org>
 <20220415005828.1980055-2-swboyd@chromium.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220415005828.1980055-2-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/14/22 7:58 PM, Stephen Boyd wrote:
> This device node is unused now that we've removed the driver that
> consumed it in the kernel. Drop the unused node to save some space.

Look good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Cc: Alex Elder <elder@linaro.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Mike Tipton <quic_mdtipton@quicinc.com>
> Cc: Georgi Djakov <djakov@kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   arch/arm/boot/dts/qcom-sdx55.dtsi | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
> index d455795da44c..f1e12a112cd0 100644
> --- a/arch/arm/boot/dts/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
> @@ -275,13 +275,6 @@ system_noc: interconnect@162c000 {
>   			qcom,bcm-voters = <&apps_bcm_voter>;
>   		};
>   
> -		ipa_virt: interconnect@1e00000 {
> -			compatible = "qcom,sdx55-ipa-virt";
> -			reg = <0x01e00000 0x100000>;
> -			#interconnect-cells = <1>;
> -			qcom,bcm-voters = <&apps_bcm_voter>;
> -		};
> -
>   		qpic_bam: dma-controller@1b04000 {
>   			compatible = "qcom,bam-v1.7.0";
>   			reg = <0x01b04000 0x1c000>;

