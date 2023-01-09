Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C986627A4
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 14:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbjAINs4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Jan 2023 08:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjAINsQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2023 08:48:16 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F71EC73
        for <linux-pm@vger.kernel.org>; Mon,  9 Jan 2023 05:48:15 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bt23so12998078lfb.5
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2023 05:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dwqzZFISvafi8zkvWTtaScmDC57kh3qUjLgthypKWsI=;
        b=mimWdywpciUKLMQYwVgBoYvenSqH61mEKHwK3fMabzqG05uXgWFZ6MfKDBm+2sub4K
         vB67rxK4qwcWx15RrSX73LU3Ypina1tOvtAs50h1AFH94ee9hjxU6qdQV9cy1Wvtil1X
         IVdwbi011d+J+38VtuJ9Y27Qag/MKrgj699xft/99C6NeTkkSn8qQv4KIllACtMAj+SE
         n36jb6bBhQCx1KpEwZxSc2qGmfodgSuC/Y2jBfbL90neRD82zeTg5tYi7HaUJ2OkCuUg
         UCZwBOWTzyUUDHEcPfQ+wwspXWKdh2gNQEOZFHw1QjtR3KgQ85MKy7fkxtg6xIKm2yFM
         V50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwqzZFISvafi8zkvWTtaScmDC57kh3qUjLgthypKWsI=;
        b=okHnmp/LJ2Lly24uVi9CkbHCOSp47WWwmP+f1ZXwcYosgETLyaCa8W7lhwoRHEaZp2
         9vqsXzML6yN4wnFmJJVB0lI0519ayYv91qVmthAGTpacGgKiNppXz2zIyD/Dz22mZV83
         klmF8Te8TMh2346HQhL8TnB+uYq0Uew/pClkvsR7UDHkChdUDswKdfAbr8MGgoBElnkt
         Uz/XbL+T5FYg57T3rXCbKtgF560U7W9Wq6J07efIGdL82NTYFYovCBfCOF8ExZMWc/Iz
         RdvMc+wUbGyl9vr3DJxYzZpE2EVBxpO0a4e8emVXfYoHQEQQivRhNpnnFIJXIKqL/CIq
         c5fQ==
X-Gm-Message-State: AFqh2krvfggbvewMtJRhKNeEIzM6/M7UBnK1UekKXpwO0K69OPIzvMBu
        wW8e8n643hA1D7vBa4MuTSITXQ==
X-Google-Smtp-Source: AMrXdXsxy6dFySGxdbgt+sMudUu02+nfElsontrzn/57g9cMxAnGF70XTPlr273myAoYacFubSr0aQ==
X-Received: by 2002:a05:6512:3b91:b0:4a4:68b8:f4e5 with SMTP id g17-20020a0565123b9100b004a468b8f4e5mr22500096lfv.43.1673272093881;
        Mon, 09 Jan 2023 05:48:13 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id o16-20020ac24e90000000b004b5323639d8sm1626551lfr.155.2023.01.09.05.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 05:48:13 -0800 (PST)
Message-ID: <5ddcd402-419c-cfc9-4b48-32186c3f18c2@linaro.org>
Date:   Mon, 9 Jan 2023 14:48:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 07/12] interconnect: qcom: sc8280xp: Drop IP0
 interconnects
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>, Alex Elder <elder@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
 <20230109002935.244320-8-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230109002935.244320-8-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9.01.2023 01:29, Dmitry Baryshkov wrote:
> Similar to the sdx55 and sc7180, let's drop the MASTER_IPA_CORE and
> SLAVE_IPA_CORE interconnects for this platofm. There are no actual users
> of this intercoonect. The IP0 resource will be handled by clk-rpmh
> driver.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/interconnect/qcom/sc8280xp.c | 25 -------------------------
>  drivers/interconnect/qcom/sc8280xp.h |  4 ++--
>  2 files changed, 2 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
> index 507fe5f89791..e56df893ec3e 100644
> --- a/drivers/interconnect/qcom/sc8280xp.c
> +++ b/drivers/interconnect/qcom/sc8280xp.c
> @@ -284,15 +284,6 @@ static struct qcom_icc_node xm_ufs_card = {
>  	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
>  };
>  
> -static struct qcom_icc_node ipa_core_master = {
> -	.name = "ipa_core_master",
> -	.id = SC8280XP_MASTER_IPA_CORE,
> -	.channels = 1,
> -	.buswidth = 8,
> -	.num_links = 1,
> -	.links = { SC8280XP_SLAVE_IPA_CORE },
> -};
> -
>  static struct qcom_icc_node qup0_core_master = {
>  	.name = "qup0_core_master",
>  	.id = SC8280XP_MASTER_QUP_CORE_0,
> @@ -882,13 +873,6 @@ static struct qcom_icc_node srvc_aggre2_noc = {
>  	.buswidth = 4,
>  };
>  
> -static struct qcom_icc_node ipa_core_slave = {
> -	.name = "ipa_core_slave",
> -	.id = SC8280XP_SLAVE_IPA_CORE,
> -	.channels = 1,
> -	.buswidth = 8,
> -};
> -
>  static struct qcom_icc_node qup0_core_slave = {
>  	.name = "qup0_core_slave",
>  	.id = SC8280XP_SLAVE_QUP_CORE_0,
> @@ -1845,12 +1829,6 @@ static struct qcom_icc_bcm bcm_cn3 = {
>  	},
>  };
>  
> -static struct qcom_icc_bcm bcm_ip0 = {
> -	.name = "IP0",
> -	.num_nodes = 1,
> -	.nodes = { &ipa_core_slave },
> -};
> -
>  static struct qcom_icc_bcm bcm_mc0 = {
>  	.name = "MC0",
>  	.keepalive = true,
> @@ -2077,18 +2055,15 @@ static const struct qcom_icc_desc sc8280xp_aggre2_noc = {
>  };
>  
>  static struct qcom_icc_bcm * const clk_virt_bcms[] = {
> -	&bcm_ip0,
>  	&bcm_qup0,
>  	&bcm_qup1,
>  	&bcm_qup2,
>  };
>  
>  static struct qcom_icc_node * const clk_virt_nodes[] = {
> -	[MASTER_IPA_CORE] = &ipa_core_master,
Will the icc framework take a null entry gracefully?

Konrad
>  	[MASTER_QUP_CORE_0] = &qup0_core_master,
>  	[MASTER_QUP_CORE_1] = &qup1_core_master,
>  	[MASTER_QUP_CORE_2] = &qup2_core_master,
> -	[SLAVE_IPA_CORE] = &ipa_core_slave,
>  	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
>  	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
>  	[SLAVE_QUP_CORE_2] = &qup2_core_slave,
> diff --git a/drivers/interconnect/qcom/sc8280xp.h b/drivers/interconnect/qcom/sc8280xp.h
> index 74d8fa412d65..c5c410fd5ec3 100644
> --- a/drivers/interconnect/qcom/sc8280xp.h
> +++ b/drivers/interconnect/qcom/sc8280xp.h
> @@ -10,7 +10,7 @@
>  #define SC8280XP_MASTER_PCIE_TCU			1
>  #define SC8280XP_MASTER_SYS_TCU				2
>  #define SC8280XP_MASTER_APPSS_PROC			3
> -#define SC8280XP_MASTER_IPA_CORE			4
> +/* 4 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
>  #define SC8280XP_MASTER_LLCC				5
>  #define SC8280XP_MASTER_CNOC_LPASS_AG_NOC		6
>  #define SC8280XP_MASTER_CDSP_NOC_CFG			7
> @@ -84,7 +84,7 @@
>  #define SC8280XP_MASTER_USB4_0				75
>  #define SC8280XP_MASTER_USB4_1				76
>  #define SC8280XP_SLAVE_EBI1				512
> -#define SC8280XP_SLAVE_IPA_CORE				513
> +/* 513 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
>  #define SC8280XP_SLAVE_AHB2PHY_0			514
>  #define SC8280XP_SLAVE_AHB2PHY_1			515
>  #define SC8280XP_SLAVE_AHB2PHY_2			516
