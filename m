Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508F3500432
	for <lists+linux-pm@lfdr.de>; Thu, 14 Apr 2022 04:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiDNCdH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Apr 2022 22:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiDNCdG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2022 22:33:06 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C63CC23
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 19:30:43 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-dacc470e03so3960712fac.5
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 19:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7X6E8VDuzQ2F6uzfOyPSrPGa6oXVkDPvWJCmwSR7mdo=;
        b=bo0blbPqgTEVW7RMqPw1KP4Oe7hINNAR2sPuU9TD3hbvp0BU91R9sK8aymt3DNT2Jp
         rRzKFRc9bN6xdz90wo2eRfib4wtO/vJiaUo3cVBDS5vE0YPOM/aATj19OSP2hJRmUG8r
         +sf0T52pDSmqXnBkg0B9xO3lzgCm/6spBgrrYC6Bt0/UrX01eanO/OwXa2S7GqXDB9eg
         AjfeZxHetIo+V684w7eCscmFr05tON/5YOi8/SHSKEOL2O1U99fIidbNOriMptDljSZ4
         jFN5menkSvIy44jD/eAowSrcmDTLW1L0X+6Pe02O0vGmiLNcUZTY0llEqJDByhGUpbCK
         zKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7X6E8VDuzQ2F6uzfOyPSrPGa6oXVkDPvWJCmwSR7mdo=;
        b=M/BW5ogYxFt3DQntID6BDhw3/sfiEQKBtSDHR+CPiN2FPPTzG3BgVIk2t1YrdPHC79
         e7N8If8CbwK1z8D54uMdLB1QPdGwKoeUDJvitTUW+L/rzhiRPdTB6fyrvVLf/WzcVF9a
         6rZcloDzJARi6X2WG3nUsSEgUsuVOu0RYflUk8QHK8q7R91m5C5nrPCSHXcuEGzmYcMb
         21CqcYYJWXPuv+43QQP4c1msBdSxZV3sdSLaGQfMCQP+WywYQolibr6bEx1ddchYFMRW
         vUKKDozP4H00isUDh17Qxf0iMdOuAMNo3t3NR7ekzWHLHqtU10KgigHTgaFhEUv6a5mq
         5qVA==
X-Gm-Message-State: AOAM530jJ331ytjS1OBy0JE3SNzotIYcaqPcqm0Uevfhfw/mFaOEqrDo
        xrU6UVIK2Q0nOM1XGXen6IIRVA==
X-Google-Smtp-Source: ABdhPJzUtEe+aXzU9LlPHKE08voE5cBhh6v8HbXuxYfmuSt7QTqtLUQm5R5Mwd3zhNzmSqC17u65TA==
X-Received: by 2002:a05:6870:9604:b0:de:a876:fbba with SMTP id d4-20020a056870960400b000dea876fbbamr670561oaq.239.1649903442911;
        Wed, 13 Apr 2022 19:30:42 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id d17-20020a056830045100b005e9d02b0be2sm285463otc.58.2022.04.13.19.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 19:30:42 -0700 (PDT)
Date:   Wed, 13 Apr 2022 19:32:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Georgi Djakov <djakov@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Alex Elder <elder@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 0/2] interconnect: qcom: Remove IP0 resource
Message-ID: <YleH1+V9RCtMGege@ripper>
References: <20220412220033.1273607-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412220033.1273607-1-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 12 Apr 15:00 PDT 2022, Stephen Boyd wrote:

> These two patches remove the IP0 interconnect used for IPA because
> they're also present in the clk-rpmh driver. I see there are some more
> IP0 usages in the interconnect drivers, but I don't see a corresponding
> IPA clk in clk-rpmh, so I left these out. We can remove all of them if
> desired, but the sc7180 patch is most important to me as it fixes
> boot on my trogdor lazor device.
>  
> Stephen Boyd (2):
>   interconnect: qcom: sc7180: Drop IP0 interconnects
>   interconnect: qcom: sdx55: Drop IP0 interconnects
> 
>  drivers/interconnect/qcom/sc7180.c | 21 ---------------------
>  drivers/interconnect/qcom/sdx55.c  | 21 ---------------------
>  2 files changed, 42 deletions(-)
> 
> Cc: Alex Elder <elder@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Mike Tipton <quic_mdtipton@quicinc.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> base-commit: 3123109284176b1532874591f7c81f3837bbdc17
> -- 
> https://chromeos.dev
> 
