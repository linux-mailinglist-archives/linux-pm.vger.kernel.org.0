Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53449351AE4
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhDASD1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 14:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbhDAR7Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 13:59:24 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D42C061225
        for <linux-pm@vger.kernel.org>; Thu,  1 Apr 2021 05:27:16 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id r17so1914872ilt.0
        for <linux-pm@vger.kernel.org>; Thu, 01 Apr 2021 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iWl62oGTxpsnb8MfsXXVQ5OE+zxxuQ8ZrjZT5mqhmk8=;
        b=m3677M48tkn2V4ziKwwwBU2+rjUUc5Y3kj9IMK3hkZIsyEAd+wXLJPXp9d2zToyTZY
         OtfzMXSxLpduWxLqZdB5iSGbld4WQ4wx09lwTchEkZim1b4qw598CREf3Cj8U5CrMJJZ
         yWNUM3aYMlHDLxX9T6S0zoY30xB+V4HRp8h0996xITMmbP+CwG33gV5IGbnuSHwSFcNR
         UpMROF7sOkhWtZZSrwV0YFKVy+2ta9KN79NWM+hB73LuOq3yVUbbkY1faeq8wh3RI8py
         rEkjdFtpH6W3uwW45xeGv/oDcvlyw3ul7ACWkVz9KSVZeGxpK1Cy0RAvfonUTZqDCnxl
         279g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iWl62oGTxpsnb8MfsXXVQ5OE+zxxuQ8ZrjZT5mqhmk8=;
        b=MTsTHBhc4jd+LrJ+KLD4qb3zrGnfJQDbs6G//51ja6UeJDcBRZ13nzwTWfQW6wlme2
         D5iD5GnF4PqMb/QiDan2MG8yf1waRh52sR5VX6r/ZGKdk8dIyFdegjjjSXxdJoebuqXw
         D3+1AFcB5D+BT4cytjXDv2Tl1YUJ287clm4UTf6mWOOlvQR/cDcH2il5IQW5NOg0QpRE
         W/IxWlopnOgk97K5eoo673EUQBKm7Yelz50BN5jYETW9r2+WGZ3LBOYw3oc5DbG8xF1M
         pR+889eMhiCKtWxDO+EsI0nrWMhDpZ0KQNTZWBnzYfKPDYDncFj/6kObsROfklH3leU6
         cO3g==
X-Gm-Message-State: AOAM533243TI+LjBwtZwp3toj44bB9R7GgxPCtN82AEvdmtFEaDShLJm
        1P/g5L6TF1idfk79ZvSeqTcjxqMrUEsxOrUQ
X-Google-Smtp-Source: ABdhPJxz4i1NViOjDljoXKjIaTUxYrlyylEQ9VAbjNxwF2W8jdt1X3/G2E9h4ykpRvGW5oG6LbrB4Q==
X-Received: by 2002:a05:6e02:1a45:: with SMTP id u5mr6717204ilv.4.1617280035922;
        Thu, 01 Apr 2021 05:27:15 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id k4sm2846785iol.18.2021.04.01.05.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 05:27:15 -0700 (PDT)
Subject: Re: [PATCH] interconnect: qcom: sm8350: Add missing link between
 nodes
To:     Georgi Djakov <georgi.djakov@linaro.org>, djakov@kernel.org,
        vkoul@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210401094435.28937-1-georgi.djakov@linaro.org>
From:   Alex Elder <elder@linaro.org>
Message-ID: <7ab2be33-9269-8c28-71d7-1611e60c72fe@linaro.org>
Date:   Thu, 1 Apr 2021 07:27:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210401094435.28937-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/1/21 4:44 AM, Georgi Djakov wrote:
> There is a link between the GEM NoC and C NoC nodes, which is currently
> missing from the topology. Let's add it to allow consumers request paths
> that use this link.
> 
> Reported-by: Alex Elder <elder@linaro.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks Georgi.

Tested-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/interconnect/qcom/sm8350.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
> index 01202989a5b2..579b6ce8e046 100644
> --- a/drivers/interconnect/qcom/sm8350.c
> +++ b/drivers/interconnect/qcom/sm8350.c
> @@ -139,7 +139,7 @@ DEFINE_QNODE(qhs_llcc, SM8350_SLAVE_LLCC_CFG, 1, 4);
>   DEFINE_QNODE(qns_gemnoc, SM8350_SLAVE_GEM_NOC_CFG, 1, 4);
>   DEFINE_QNODE(qhs_mdsp_ms_mpu_cfg, SM8350_SLAVE_MSS_PROC_MS_MPU_CFG, 1, 4);
>   DEFINE_QNODE(qhs_modem_ms_mpu_cfg, SM8350_SLAVE_MCDMA_MS_MPU_CFG, 1, 4);
> -DEFINE_QNODE(qns_gem_noc_cnoc, SM8350_SLAVE_GEM_NOC_CNOC, 1, 16);
> +DEFINE_QNODE(qns_gem_noc_cnoc, SM8350_SLAVE_GEM_NOC_CNOC, 1, 16, SM8350_MASTER_GEM_NOC_CNOC);
>   DEFINE_QNODE(qns_llcc, SM8350_SLAVE_LLCC, 4, 16, SM8350_MASTER_LLCC);
>   DEFINE_QNODE(qns_pcie, SM8350_SLAVE_MEM_NOC_PCIE_SNOC, 1, 8);
>   DEFINE_QNODE(srvc_even_gemnoc, SM8350_SLAVE_SERVICE_GEM_NOC_1, 1, 4);
> 

