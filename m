Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3657750568
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jul 2023 13:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjGLLE3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jul 2023 07:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjGLLEY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2023 07:04:24 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A13F1BC6
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 04:04:20 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666ecf9a081so6021411b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 04:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689159859; x=1691751859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C066j8+9OqPKeXyj3bfl8U68n9ZB9W8Lq5zG3Pmt0vc=;
        b=thXJh3IZOc/iwIXY0mkcg9tHoTkxeIigWWMNmihKQ2AyofInEYh4hKNj/xgsaBqNla
         kwEdjNB53sB+Ji45sznXAgSmVzoZdLvxzNeIuto/MaG267FQKmL5pfN88D6jSbST7ZYQ
         RVinxbqukeLrV2KEfYcYyNoxkQmsYqQal2Z0XdplbtUr2D7DzK2HxFqmMyeT2/87ozrz
         Q+mjKGgihMixJ2dhvFYjKjEPubHuxiJ4cpLdryUsEPv8AJcrZTGDeFnEDwr9xE+YzF+6
         +xCyipY32MKoGq34HtRU2rhNjf11mpoE/2zFijFPdkamW5CXlfWSzhsCssm0rDMSOiQV
         vX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689159859; x=1691751859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C066j8+9OqPKeXyj3bfl8U68n9ZB9W8Lq5zG3Pmt0vc=;
        b=XBnIpZkacHHT9TtwyAQ2GrsB8WCwHD3ijfzWsAmyHyiYjG16Egtst0cEslswPCCVyr
         NJSTZU+WggGsUx/zqjRnsP/qxHUWTU9Sh73U4xkDK0ZHoMlWQ0vUzHoBp8MAMHiVInF9
         l4rKGvAC2bOscoWVg8WApPGjYZNQL1DpMpHrX1b9QHJyY+B3aDk1Rrr6eqHGyIQCWmUc
         k6ru1SwysiryJNsNLclLpzyeGZPs3iv6/blz2e8id2UEMaI2IBEMtI0UPf3MrjUTHX54
         OTfj4dF9bR+NOlHtTzbIl8RPWW1PriZk36/Y8+VIV2sqmpWQKAdOo5oXLdIkJQw98ifX
         ZdXw==
X-Gm-Message-State: ABy/qLaPg/wmG7zOXwVNwbXmZWGUN+PY7kH8zEkt2C9TDGVjw/EBxdoF
        Wy1AtXJ3l4UB/LjAUoviaWLs
X-Google-Smtp-Source: APBJJlEumOiYoWYoICB8e/oNkTZqTMI6x6HJ3CGrLma4L8XSLhE1BTaahWbqrQxktnIBz8ws+sldrw==
X-Received: by 2002:a05:6a00:3a14:b0:668:8705:57cf with SMTP id fj20-20020a056a003a1400b00668870557cfmr21660438pfb.25.1689159859368;
        Wed, 12 Jul 2023 04:04:19 -0700 (PDT)
Received: from thinkpad ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id i13-20020aa787cd000000b00674364577dasm3331941pfo.203.2023.07.12.04.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:04:19 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:34:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH 04/14] arm64: dts: qcom: sdm845: Fix the min frequency of
 "ice_core_clk"
Message-ID: <20230712110403.GR102214@thinkpad>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-5-manivannan.sadhasivam@linaro.org>
 <4cc0156e-4324-9f15-089e-9946148753c9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cc0156e-4324-9f15-089e-9946148753c9@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 12, 2023 at 12:45:40PM +0200, Konrad Dybcio wrote:
> On 12.07.2023 12:31, Manivannan Sadhasivam wrote:
> > Minimum frequency of the "ice_core_clk" should be 75MHz as specified in the
> > downstream vendor devicetree. So fix it!
> > 
> > https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.7.3.r1-09300-sdm845.0/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > 
> > Fixes: cc16687fbd74 ("arm64: dts: qcom: sdm845: add UFS controller")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> Would it make sense to move the ICE to the new bindings instead?
> 

That can be done later if required. Fixing the frequency just in this patch
allows it to get backported to stable.

> Can sdm845's ICE also work with the sdcard slot?
> 

I do not have any info on this.

- Mani

> Konrad
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 9ed74bf72d05..89520a9fe1e3 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -2614,7 +2614,7 @@ ufs_mem_hc: ufshc@1d84000 {
> >  				<0 0>,
> >  				<0 0>,
> >  				<0 0>,
> > -				<0 300000000>;
> > +				<75000000 300000000>;
> >  
> >  			status = "disabled";
> >  		};

-- 
மணிவண்ணன் சதாசிவம்
