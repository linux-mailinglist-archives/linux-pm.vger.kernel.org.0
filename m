Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6591763DE4
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jul 2023 19:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGZRq1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jul 2023 13:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjGZRq0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2023 13:46:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE302728
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2023 10:46:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fba03becc6so1662682e87.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2023 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690393580; x=1690998380;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DAOp2wTsOv7dVIC8g3WfkG1LXpVqrRxAqcUivavPBHE=;
        b=CflZLy88F37RksY7HxEtkp22EFvW+UOYRHPOS8S9TBXiK2KgVgLcAGpL1ze9iQnI0q
         /DVhjfd84Rn82Qmos9s8LPCVQ6l5sf0WUVRd3rvPoidJWKxMnx2HfRCrPoxKozo4w78Z
         F2M06WvX10BDDlKCFVaMguhiar+w+hObzh3i+hrgCSARGmldVViS8DB6atC7VPxfBi5G
         C185Q+2BZrBVV5ccYDJhaFHBjAM0HVZm0+62xN72S00bvoCn3JTh7VjqNhZ4dt+1I2fC
         yMAPXti+pwIDxb6CrJJrmydoLFNzMqTLcFCq1XM3e7U02cXzHXj6KXfWJzR1+6zi2KbD
         rifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690393580; x=1690998380;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DAOp2wTsOv7dVIC8g3WfkG1LXpVqrRxAqcUivavPBHE=;
        b=DAatGw5IEQ/Bb9nUmQk+HDAJ9hTN7aALlGFSQ1SxaSC60gXCejcPHBUW8xG+nkSSCL
         MzzLVLtaWAhvMdu+MePAGy1rXv8XCDOobzzWfQr85OYaPJF75y3czz34swjAr3zHlmxQ
         eIIGT5fjHj2KpCVBe5XKXTkH+3sesrskAU/SODOkovprt7EsvAKv1IdNZZnCnAH7D16x
         PdstBqG/2FP3+tAujH1SMgtn4X4+BsrernkjXQozaHnlr19xFuQhaHfxWaqBrdFc3KJ0
         BHpt1a8kPyxb5a55o6Yx5VQ9hFgBQ/UGKAnQcpEjAQjpS7S6jpv6kf22knENF6dxI0iP
         jd5Q==
X-Gm-Message-State: ABy/qLZw7+bEHSeIMzwUio59jyzKZSffiQsJCbpR0Mi2Gv2y9mt6y2mp
        ZVPDCWLpCNvBPtMpHqRag4AUEQ==
X-Google-Smtp-Source: APBJJlEUnRX0sisPCFb4JA5/mRFwropHhnlJHPpvL7xIMYTEg1ASCWgRbzXDQaSDpXzKVqAYU/x5uw==
X-Received: by 2002:a19:ca4e:0:b0:4f9:5693:3d2c with SMTP id h14-20020a19ca4e000000b004f956933d2cmr54554lfj.34.1690393580109;
        Wed, 26 Jul 2023 10:46:20 -0700 (PDT)
Received: from [192.168.1.101] (abyl5.neoplus.adsl.tpnet.pl. [83.9.31.5])
        by smtp.gmail.com with ESMTPSA id a4-20020a19f804000000b004fdbb36a677sm3411912lff.288.2023.07.26.10.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 10:46:19 -0700 (PDT)
Message-ID: <0e5e5343-1831-c922-8f79-93cb9073dee3@linaro.org>
Date:   Wed, 26 Jul 2023 19:46:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] interconnect: qcom: qcm2290: Set AB coefficients
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org>
 <20230726-topic-icc_coeff-v1-2-31616960818c@linaro.org>
 <ZMFVZJa647SNwrJX@gerhold.net>
 <5667c93a-408f-3802-b168-f3a145dfcb43@linaro.org>
 <ZMFXNZbYdpnFVsoV@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZMFXNZbYdpnFVsoV@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26.07.2023 19:26, Stephan Gerhold wrote:
> On Wed, Jul 26, 2023 at 07:20:27PM +0200, Konrad Dybcio wrote:
>> On 26.07.2023 19:18, Stephan Gerhold wrote:
>>> On Wed, Jul 26, 2023 at 06:25:44PM +0200, Konrad Dybcio wrote:
>>>> Some buses need additional manual adjustments atop the usual
>>>> calculations. Fill in the missing coefficients.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>
>>> What about the funny util-fact/vrail-comp on the mas-apps-proc node
>>> downstream?
>> Can't see it neither on msm-5.4 (with the icc API) nor in the 4.19 (msmbus)
>> device tree.
>>
> 
> Not sure where to get up-to-date device trees nowadays. The AOSP repo
> I was looking at has this commit where it was added:
> https://android.googlesource.com/kernel/msm-extra/devicetree/+/02f8c342b23c20a5cf967df649814be37a08227c%5E%21/#F0
Oh right, take a look at this one:

https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/commit/201df022706e100cef8d28983c6a7b883fcaec5a

I guess I'll need to update the icc driver then.

Konrad
