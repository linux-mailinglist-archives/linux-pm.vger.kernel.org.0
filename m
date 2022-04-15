Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11399502F96
	for <lists+linux-pm@lfdr.de>; Fri, 15 Apr 2022 22:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351512AbiDOUOJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Apr 2022 16:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbiDOUOJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Apr 2022 16:14:09 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB770D7901
        for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2022 13:11:39 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id r11so5383199ila.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2022 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0h4kOw13GPXSZXPL1aFf+vHZzuFNnu2SrOyKDVhlRIA=;
        b=NlhPZwWCO7FasxaGZw/zJ09wLrjrr7u1BX1PCAWm9lk+27gpfhHcbV8F1yi2OAQAeM
         x76MUCMVaJxluw5Rkb2kNQtgksV9v7BP7p3jJNjQv4LONZLzoHA8iXPqTHGZ9FMg4aWs
         cAd74g+dn65csQAY0aCQzKINt37eihgLEm5gnZv68kVe8VuLXKTO+SgQlw6zuy7cJks4
         LTa0omUHRU7t4tZ8XyMMLsoMGNelEs+PbRIiWvtlobkSUQfpksDDsy2FYIAHtOS+0Rtd
         bk5pZk9Q1Pi9d6yN4zOHNWVuwym8wWlfMC49tnyH+a2Mu2Y1SZkxZUX4DaPDah5zfjR3
         G9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0h4kOw13GPXSZXPL1aFf+vHZzuFNnu2SrOyKDVhlRIA=;
        b=q6JSXyVBVJAdguL/VXoC6vh/Ig0SYIscoqHV5YwUUuZTsSGZg2xT9Ddi06QC36J+Cj
         /ba95YDZcEYn5s+RkJ9yakZb00iH5iqW4QE4d904USuc9GnphhX2WscxReMQhqwBwQc0
         lOQLEiVAnDYPm3iLF0CfoKUhkqOya0DPlZmrycX6s0Tql+TaImg0UuatqG6NManqHEyN
         OKn0OoD+awXU+ZLVeDrMxO1aIb/HheSUFn1WTOFx4bR7VQ0VeSm4ajf5KC/7tG9Qzn+h
         m63JV6biBTITzJXCDml0SSs31Y+/0fLDOW47VjRJcxOFZKgb2PAu7tJUmbDewocns+LM
         SgWQ==
X-Gm-Message-State: AOAM533zsjcagfhLglevFOWdFCvu1lFid3CuQzRVYQVSYwymLbzmnlTS
        KByM8hcFxeO6uj0PtblIXtBsjg==
X-Google-Smtp-Source: ABdhPJyTBoYl3cMDgpDoRgLgnManLiP13mZe+WlzTYZ9CFELNXvXNBHNOWQZnOFkuViPHCIJuHoTIQ==
X-Received: by 2002:a05:6e02:1445:b0:2ca:becb:94fd with SMTP id p5-20020a056e02144500b002cabecb94fdmr200511ilo.98.1650053499173;
        Fri, 15 Apr 2022 13:11:39 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id w20-20020a056e0213f400b002cac6dfd465sm3107473ilj.69.2022.04.15.13.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 13:11:38 -0700 (PDT)
Message-ID: <efd1815f-54fd-3035-4583-a74601ccce71@linaro.org>
Date:   Fri, 15 Apr 2022 15:11:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/2] arm64: dts: qcom: sc7180: Remove ipa interconnect
 node
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
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220415005828.1980055-1-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/14/22 7:58 PM, Stephen Boyd wrote:
> This device node is unused now that we've removed the driver that
> consumed it in the kernel. Drop the unused node to save some space.
> 
> Cc: Alex Elder <elder@linaro.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Mike Tipton <quic_mdtipton@quicinc.com>
> Cc: Georgi Djakov <djakov@kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>


> ---
>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index e1c46b80f14a..1ff96ef30e3f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1421,13 +1421,6 @@ mmss_noc: interconnect@1740000 {
>   			qcom,bcm-voters = <&apps_bcm_voter>;
>   		};
>   
> -		ipa_virt: interconnect@1e00000 {
> -			compatible = "qcom,sc7180-ipa-virt";
> -			reg = <0 0x01e00000 0 0x1000>;
> -			#interconnect-cells = <2>;
> -			qcom,bcm-voters = <&apps_bcm_voter>;
> -		};
> -
>   		ipa: ipa@1e40000 {
>   			compatible = "qcom,sc7180-ipa";
>   

