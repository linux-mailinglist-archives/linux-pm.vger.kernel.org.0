Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384AC7B6D07
	for <lists+linux-pm@lfdr.de>; Tue,  3 Oct 2023 17:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjJCPZk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Oct 2023 11:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjJCPZj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Oct 2023 11:25:39 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5906B0
        for <linux-pm@vger.kernel.org>; Tue,  3 Oct 2023 08:25:34 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d86574d9bcaso1090461276.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Oct 2023 08:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696346734; x=1696951534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pGVoL3ekhfgR5Li2+FLv1BzUDvf3zy7Wq5DWcyBdbUU=;
        b=WDC2/YcOqOniJIvVAev2kD5+N8BOqvh0iSj2BU3c8ZT/3+1YXSZiIYEsbaM6R3VWd2
         zi0eeoDNBe6LEtF2CAxPXfgdO2jE5FtahMTycF9M7rOPu1MFuFsgPe/N0i2uADHxXItD
         IASDEKvLCssIhYWUtePBkzbLfg3zTHZXN6aq3yUwgnObN6+1xisuYLMto7C1fV9T8oax
         Byv2KVJkf4SQfDu/GoKopwQGcBGbzvLFtFVHmW8V3jkqaLYAsa2k62WpXi8wvXYgNTl1
         0dGfsGVUjvBsF117P5oZWKMSZLfL5VpSY/xf8p3LJFxKjtbrvNek7VWE+NWY0WLYAOaX
         dBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346734; x=1696951534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGVoL3ekhfgR5Li2+FLv1BzUDvf3zy7Wq5DWcyBdbUU=;
        b=hOX2murBI39yM1IPWO8t9GYFEbYLL9cLNSUoZrhAhJrYVlVe/xHPVYGsmU6ha10B+r
         f2cDfwEVo401sZJ7c/jmOHyZkAQ9RAu7ZELNSCWtcriNyea79b+OM4yifj4VuBOQMCBc
         x7GSi6ieRqLOc9nOqMUfwmZJimcXLRXplQ4utMXnbU+vqQAO2MBQjnsYiuV+liNs4Dws
         vWbTAoV1qHANu2sBc3VpC18qjSXNOatvh1vcCIPelvxJs3h0pOM63oF2/JJyJlxqMbL9
         cSjVsjNESpMGnaR8MddFHGoo9s5EEqDNEP/RpkaBKDzg6yya36ofkrEzf8GAVDtXBclA
         p4Qw==
X-Gm-Message-State: AOJu0Yx5nq2g+TxP3SEXwcaOLBEm049o6ljJw5N6gX0zJGspE+Fc1P/P
        whBHrIBJ6GgKXKlaPZOpqqQxNb+4EXwOBmx/Iz717Q==
X-Google-Smtp-Source: AGHT+IHBCWgvfAHbcGjjccmTpSVhnByEgwm/tEgNLZP140ckpYMr/fckGC2+3rb/UBI5wvFTHimxcVKC8uoXZflpXQM=
X-Received: by 2002:a25:e013:0:b0:d86:57ff:210c with SMTP id
 x19-20020a25e013000000b00d8657ff210cmr15084071ybg.17.1696346734044; Tue, 03
 Oct 2023 08:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231003111232.42663-1-manivannan.sadhasivam@linaro.org> <20231003111232.42663-7-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20231003111232.42663-7-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 3 Oct 2023 18:25:22 +0300
Message-ID: <CAA8EJppOuAnVsnV0tYLyGqyJy3xVt2ToTZ+r9hyNd=VgK1Ez8Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: sm8250: Add OPP table support to UFSHC
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 3 Oct 2023 at 14:16, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> UFS host controller, when scaling gears, should choose appropriate
> performance state of RPMh power domain controller along with clock
> frequency. So let's add the OPP table support to specify both clock
> frequency and RPMh performance states replacing the old "freq-table-hz"
> property.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 39 +++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index a4e58ad731c3..33abd84aae53 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2198,21 +2198,42 @@ ufs_mem_hc: ufshc@1d84000 {
>                                 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>                                 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
>                                 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> -                       freq-table-hz =
> -                               <37500000 300000000>,
> -                               <0 0>,
> -                               <0 0>,
> -                               <37500000 300000000>,
> -                               <0 0>,
> -                               <0 0>,
> -                               <0 0>,
> -                               <0 0>;
> +
> +                       operating-points-v2 = <&ufs_opp_table>;
>
>                         interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI_CH0 0>,
>                                         <&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
>                         interconnect-names = "ufs-ddr", "cpu-ufs";
>
>                         status = "disabled";
> +
> +                       ufs_opp_table: opp-table {
> +                               compatible = "operating-points-v2";
> +
> +                               opp-37500000 {
> +                                       opp-hz = /bits/ 64 <37500000>,
> +                                                /bits/ 64 <0>,
> +                                                /bits/ 64 <0>,
> +                                                /bits/ 64 <37500000>,
> +                                                /bits/ 64 <0>,
> +                                                /bits/ 64 <0>,
> +                                                /bits/ 64 <0>,
> +                                                /bits/ 64 <0>;

I must say I still consider this to be uglier than hard coding clock
names in the driver.

> +                                       required-opps = <&rpmhpd_opp_low_svs>;
> +                               };
> +
> +                               opp-300000000 {
> +                                       opp-hz = /bits/ 64 <300000000>,
> +                                                /bits/ 64 <0>,
> +                                                /bits/ 64 <0>,
> +                                                /bits/ 64 <300000000>,
> +                                                /bits/ 64 <0>,
> +                                                /bits/ 64 <0>,
> +                                                /bits/ 64 <0>,
> +                                                /bits/ 64 <0>;
> +                                       required-opps = <&rpmhpd_opp_nom>;
> +                               };
> +                       };
>                 };
>
>                 ufs_mem_phy: phy@1d87000 {
> --
> 2.25.1
>


-- 
With best wishes
Dmitry
