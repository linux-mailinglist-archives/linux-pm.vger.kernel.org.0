Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD1875BF6F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jul 2023 09:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjGUHSJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jul 2023 03:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGUHSH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2023 03:18:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45109FC
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 00:18:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8a44ee159so10592295ad.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 00:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689923885; x=1690528685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xgra1BbjJ2TX4LJXSTiv0VpjCyIk0jpZ//hvoXBk3V0=;
        b=b4MYGFDLTZkoT24IR8U5mw8aCuPkq5W9pn72K+9QLHAx4bD9fuTYh7Zd6jJqTDulFi
         Q5+UClv+pgLMRp5nq8gyjLmgoTf0RO4/Taky/8lu1VVPc4XzV47YX5/XXrBw2GblMIeZ
         BJj7rjghVciP1AbWBdCiOfSfsDZuJW9AOAHjyiLml4BW4LjwlB2LFC32pVz0rxHQtot/
         2bZG31h0NQcdRWgDP6skU6BVrnuoWcTv0ildGVJtsTO9nPNdIuc+0c74pcJXMk0NWdHJ
         8J5lkgokPLJJqhLzuTHIVkH1Ti8SAF9TmzUbKJfA07iHtqgc+TmkaJEzZL8PGKmmuxDD
         FQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689923885; x=1690528685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgra1BbjJ2TX4LJXSTiv0VpjCyIk0jpZ//hvoXBk3V0=;
        b=T62ZxI4FxNuc5/xoWG/lITYrEwG1YkGOc6aYCWWpZbo0Wuc8en5jc6KKB/Ps0sXI4O
         aSwhVUaJzLErA096T9O7WSKR5p3/2xp90DRqNqD8XoWPdLgZ4d6QzykahKxOTEIGgWQW
         cKcrl1jodyEJuDpnFDeu15pDWmhhVEAEPpfV+wsjSqZGT1UMQ4BibAqhIt/Xkj8GVcBA
         5uenL1gV7pqMpgbseU6Jd/7hvbmftOTeAhKrzMg06ai7WalpjtPo1LTLGY2uyQgybK7b
         wTWHChUjNyGRCtbdK3ogf9n5FMAwnt3K5R/cKc5iYUEbn5CfXny2mFnfkiMvHXzp/9bw
         +1VA==
X-Gm-Message-State: ABy/qLZrf+SD+/i864kQTDP5A3dAQ/0HdB4I+YQbxGWy24xJ/ctYAt83
        dHKvSwIZoHWQ+OssendPTvsZnw==
X-Google-Smtp-Source: APBJJlGOEY7gHS/A9+kCu38TOUt7LFXF5kKuzGNRk2oieuEA63WC3YwDiKytWENvZdB/oVsM0A7/Lg==
X-Received: by 2002:a17:902:934a:b0:1b8:af85:e959 with SMTP id g10-20020a170902934a00b001b8af85e959mr894543plp.53.1689923884709;
        Fri, 21 Jul 2023 00:18:04 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902ecd100b001ba066c589dsm2671961plh.137.2023.07.21.00.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 00:18:04 -0700 (PDT)
Date:   Fri, 21 Jul 2023 12:48:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/15] arm64: dts: qcom: sdm845: Fix the min frequency
 of "ice_core_clk"
Message-ID: <20230721071801.e6ngfnkwg2ujsklg@vireshk-i7>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
 <20230720054100.9940-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720054100.9940-5-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-07-23, 11:10, Manivannan Sadhasivam wrote:
> Minimum frequency of the "ice_core_clk" should be 75MHz as specified in the
> downstream vendor devicetree. So fix it!
> 
> https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.7.3.r1-09300-sdm845.0/arch/arm64/boot/dts/qcom/sdm845.dtsi
> 
> Fixes: 433f9a57298f ("arm64: dts: sdm845: add Inline Crypto Engine registers and clock")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 9ed74bf72d05..89520a9fe1e3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2614,7 +2614,7 @@ ufs_mem_hc: ufshc@1d84000 {
>  				<0 0>,
>  				<0 0>,
>  				<0 0>,
> -				<0 300000000>;
> +				<75000000 300000000>;
>  
>  			status = "disabled";
>  		};

Please keep new feature and fixes like this in separate series. This
could be merged directly in the currently ongoing kernel rc and
doesn't need to wait for this series.

Or at least keep the commit at the top, so another maintainer can
simply pick it.

-- 
viresh
