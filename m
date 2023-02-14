Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012B0696144
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 11:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBNKrM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 05:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjBNKrL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 05:47:11 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFAC26586
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 02:46:49 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a3so4951917ejb.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 02:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bSZu2dCpB4pUnfEG7IZ7hWgBfaAKgOTGJQciP+JhljI=;
        b=aInsRALgA9wZYs93mqIJfVgwnQuxi8FJcVt7WdnlcIoY/NwQulebHxmweQjHMbfsiQ
         vq6JJyxTh8yirL735aQ7KfJ/Ued/I3W63m/SLwzueFUtAPZCXT7NAM747gy0YAckbJtd
         DeE+BZMjvwVTLVg3Fmr882truHpV/P0nxG/2ZiMYgX5yeMDmASvEnfJKR90qJkryIjOg
         4O0aQZPubX3k9resjMZh6If4fx6fXbkeYDZmbxxfpd1oh2qXmdwSR+ft+4hUVsqj9QHk
         QkOjnHrNxHZZFZoAA3OB9vCK/ZDcxQjlUoUoUdz4mrt2idONS0Yr1QvdlUjUE5wBHgGG
         p3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSZu2dCpB4pUnfEG7IZ7hWgBfaAKgOTGJQciP+JhljI=;
        b=sNwnCAeRwuSvdksQEHcG/Z1fF29Phuc56q1aCLumPnjBk6labb8H2K09BqNn/dZN/8
         FzoXUKmTPCefubZ3c+K0QRzSAmI95hE2WiCrCyRYma+BAtKUpQgTZ017OAAQRwZldzgK
         6QDlT0YKxyiFpcYLjHF/1JTifncyk80ebwVD2E3eqXJPNd1aYW9X0XbReSxv8yVfoPZI
         PciEdUrLe962cU3lVgRwIC1NncEgikHIwEQkBkpqwUZuBKfxeYnjrjXKR3iFxlrFInxS
         oJXZcpuw0YqVUrHBueNPrpDJsQIEi2ouuu5qxGp0j5/SSapS9T8q20Bzl4aFjkqvcyGU
         Jkng==
X-Gm-Message-State: AO0yUKUTOumV5H/NGP+4y/rw5no+B8QUnw9Qhku2CPqElzKSg5gScsMH
        12bRr0Xd/bgqr/LO8RaM0mwvPw==
X-Google-Smtp-Source: AK7set+SZIbDQUqGvv3dWu5Z+4Ra/zloJPpjrNsbIKyCqSc+rR30uYZQqR/vfvaa2Dts5ofkLbFpQg==
X-Received: by 2002:a17:907:7245:b0:8a5:8620:575 with SMTP id ds5-20020a170907724500b008a586200575mr3170288ejc.3.1676371605817;
        Tue, 14 Feb 2023 02:46:45 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id sd18-20020a170906ce3200b008b1329cd4cdsm449192ejb.190.2023.02.14.02.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 02:46:45 -0800 (PST)
Message-ID: <9e9a2822-2b4b-a4e7-d430-e6233ff0c7f1@linaro.org>
Date:   Tue, 14 Feb 2023 11:46:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] interconnect: qcom: qcm2290: Fix MASTER_SNOC_BIMC_NRT
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230103142120.15605-1-konrad.dybcio@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230103142120.15605-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3.01.2023 15:21, Konrad Dybcio wrote:
> Due to what seems to be a copy-paste error, the _NRT master was
> identical to the _RT master, which should not be the case.. Fix it
> using the values available from the downstream kernel [1].
> 
> [1] https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/heads/android-msm-bramble-4.19-android11-qpr1/qcom/scuba-bus.dtsi#127
> Fixes: 1a14b1ac3935 ("interconnect: qcom: Add QCM2290 driver support")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
Gentle bump

Konrad
> Not tested on real hw.
> 
>  drivers/interconnect/qcom/qcm2290.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
> index 0da612d6398c..a29cdb4fac03 100644
> --- a/drivers/interconnect/qcom/qcm2290.c
> +++ b/drivers/interconnect/qcom/qcm2290.c
> @@ -147,9 +147,9 @@ static struct qcom_icc_node mas_snoc_bimc_nrt = {
>  	.name = "mas_snoc_bimc_nrt",
>  	.buswidth = 16,
>  	.qos.ap_owned = true,
> -	.qos.qos_port = 2,
> +	.qos.qos_port = 3,
>  	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
> -	.mas_rpm_id = 163,
> +	.mas_rpm_id = 164,
>  	.slv_rpm_id = -1,
>  	.num_links = ARRAY_SIZE(mas_snoc_bimc_nrt_links),
>  	.links = mas_snoc_bimc_nrt_links,
