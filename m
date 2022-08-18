Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D578D597FBD
	for <lists+linux-pm@lfdr.de>; Thu, 18 Aug 2022 10:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244060AbiHRIFb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Aug 2022 04:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244018AbiHRIFU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Aug 2022 04:05:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D856B8FA
        for <linux-pm@vger.kernel.org>; Thu, 18 Aug 2022 01:05:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h5so873330lfk.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Aug 2022 01:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gfZ6MsoFE5jfEV37UdOoYOaar2s4GNvRAwl/M63/AlI=;
        b=rQMuU2eWLhIM2a+DQocFMdsW206Zcmqv+rKhQZt78H44OXhXo4oH57q6ZzfkW5iQzc
         UojmU46AxmoaNGK6L2iL3pdUapy2Vk4DZrlhHvzPAjzvXB56FksFaDzTlAKZhIOJUWqh
         MnoGok23tPObs/uTcHZoPRXuj2AOMBudfJ4zV/LMfEjrLBT3ixeQqRuzH6VSNRxLtU6I
         5qQtpDm1jX5dQoJHobwSSHKmebkQfrFngswDfBbsM5+nIsmnYeP1k+qmHP0t4eW4RknC
         7uOFFJvCCJJDJDQoU5eNUgKDFhc8RiNktfStUVjMEsVs/EbLKOxt/N2VyGsrSvcYIGJw
         tJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gfZ6MsoFE5jfEV37UdOoYOaar2s4GNvRAwl/M63/AlI=;
        b=nfYczREKIFWJsU1FvETPfc9dZjEkhP/ODOHf/aiLzUF3qzToNEzMfDL8b9eAhnEn+p
         PWHMAiE3O/lRA0LAldhJy8qQ69A0SeC3Owh+W7NB8xJofzyLZlUChnBbdAzdHSvwTCue
         Oa8Mxe2GQDiTFMtSrLD7yVh7OYvMHv41S5Rvc1ru+bpKjAwdEy847MON4YtB50SCVH2M
         jQmB8wINKFl1KjzzbUo9XiJ2cqux1+iiTGpbFaQ2XqxTEwtObO84DoNHuZellHuwxMHj
         OKvRfxMsZq/x98RO3fsHvyAEXkRWnDlLZQzIXx2xyFfh5Ls+ZYpc/GW9EzDRvs+gVmoc
         NoHg==
X-Gm-Message-State: ACgBeo0NN8ShVHP4NGh4XVQjgNdXGQ+o/b+Rw8axUwSWrBVEDqlsS1M+
        ebfCzsUvtGLEOmbZ08YHQkDhpQ==
X-Google-Smtp-Source: AA6agR4MY5zLrsvPl+gMCyCecVO9jEL8G+mcnFJIwfzsMgLHb8ic2PChW5wYutO7CRXiGU4QAXL47w==
X-Received: by 2002:a05:6512:10c3:b0:491:d857:f35e with SMTP id k3-20020a05651210c300b00491d857f35emr554119lfg.102.1660809916496;
        Thu, 18 Aug 2022 01:05:16 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id y27-20020ac255bb000000b0048b17ecee71sm121441lfg.302.2022.08.18.01.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 01:05:15 -0700 (PDT)
Message-ID: <685783e3-9636-e512-7810-1f87ac5d9328@linaro.org>
Date:   Thu, 18 Aug 2022 11:05:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] soc: qcom: pmic_glink: Introduce base PMIC GLINK
 driver
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220818031512.319310-1-bjorn.andersson@linaro.org>
 <20220818031512.319310-3-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220818031512.319310-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/08/2022 06:15, Bjorn Andersson wrote:
> The PMIC GLINK service runs on one of the co-processors of some modern
> Qualcomm platforms and implements USB-C and battery managements. It uses
> a message based protocol over GLINK for communication with the OS, hence
> the name.
> 
> The driver implemented provides the rpmsg device for communication and
> uses auxilirary bus to spawn off individual devices in respsective

typos:
auxiliary
respective
> subsystem. The auxilirary devices are spawned off from a

auxiliary

> platform_device, so that the drm_bridge is available early, to allow the
> DisplayPort driver to probe even before the remoteproc has spun up.
> 

(...)

> +
> +static int pmic_glink_init(void)
> +{
> +	platform_driver_register(&pmic_glink_driver);
> +	register_rpmsg_driver(&pmic_glink_rpmsg_driver);
> +
> +	return 0;
> +};
> +module_init(pmic_glink_init);
> +
> +static void pmic_glink_exit(void)
> +{
> +	platform_driver_unregister(&pmic_glink_driver);
> +	unregister_rpmsg_driver(&pmic_glink_rpmsg_driver);

Shouldn't this be in reversed order of init()? So first unregister
rpmsg, then platform driver.

> +};
> +module_exit(pmic_glink_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm PMIC GLINK driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/soc/qcom/pmic_glink.h b/include/linux/soc/qcom/pmic_glink.h
> new file mode 100644
> index 000000000000..40470f8dfc1e
> --- /dev/null
> +++ b/include/linux/soc/qcom/pmic_glink.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022, Linaro Ltd
> + */
> +#ifndef __PMIC_GLINK_H__

I propose more detailed guard:
__SOC_QCOM_PMIC_GLINK_H__

> +#define __PMIC_GLINK_H__


Best regards,
Krzysztof
