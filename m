Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A86172A9DD
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jun 2023 09:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjFJH0o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Jun 2023 03:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjFJH0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Jun 2023 03:26:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547CE3AA7;
        Sat, 10 Jun 2023 00:26:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5BF1614BD;
        Sat, 10 Jun 2023 07:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EDFC433D2;
        Sat, 10 Jun 2023 07:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686382000;
        bh=W4jAN5UtwwRCSlIWle0GSOyMn537BHsZC7BQMLVcuso=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nHqf/X2WwS16FkCQqkbtsIGJPGK4tdgajjbr3+J5l9qwiuj+QBSaS2nvl39WYjtnH
         CbhCanA3aoqZbL+0ogRyFxFZuW4IAJQhVDRJAP8nCOBdm6a2SACHI8PleVWH8Xf4qo
         jJa+n5jF4kdFCyoDcpVMd/b7+jFfIM1VE/YkErJJG0tJYYz7X8Udf0PMDWp6wHa3Oz
         E6Pclxu7gFLMRgCeXDVf4XDHV1pBl86bB+z33ToSZBL05bNi9+FJBJ6d4mmlWuWBsR
         62fPopZPUqoMuIbsv09yQe9yaHR5jhk2jpZikcQc/Md3dSN7857OK/G0gF3nAUsR6W
         hpymSt7ftZOBw==
Message-ID: <a69eca09-1f6d-6cae-061a-d483c9fb3715@kernel.org>
Date:   Sat, 10 Jun 2023 10:26:32 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v6 3/4] clk: qcom: cbf-msm8996: scale CBF clock according
 to the CPUfreq
To:     Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-pm@vger.kernel.org
References: <20230512001334.2983048-1-dmitry.baryshkov@linaro.org>
 <20230512001334.2983048-4-dmitry.baryshkov@linaro.org>
 <20230610001815.zgo23zlwo3z6e3y6@ripper>
Content-Language: en-US
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230610001815.zgo23zlwo3z6e3y6@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10.06.23 3:18, Bjorn Andersson wrote:
> On Fri, May 12, 2023 at 03:13:33AM +0300, Dmitry Baryshkov wrote:
>> Turn CBF into the interconnect provider. Scale CBF frequency (bandwidth)
>> according to CPU frequencies.
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> Tested-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Georgi,
> 
> Dmitry tells me that you picked up the interconnect patches, I don't see
> an immutable branch in your tree with them, but this patch has a build
> time dependency on them. Could you please pick this through your tree as
> well?

It's done. Thanks a lot Bjorn!

BR,
Georgi

> Acked-by: Bjorn Andersson <andersson@kernel.org>
> 
> Regards,
> Bjorn
> 
>> ---
>>   drivers/clk/qcom/Kconfig        |  1 +
>>   drivers/clk/qcom/clk-cbf-8996.c | 60 ++++++++++++++++++++++++++++++++-
>>   2 files changed, 60 insertions(+), 1 deletion(-)
>>

