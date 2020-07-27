Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D170922EA7A
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 12:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgG0KyY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 06:54:24 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:13650 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728350AbgG0KyY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 06:54:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595847263; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=/E07zcWP7cDl0cKYrcOVvgqPqfhXiQamtMhLxP/YTkw=;
 b=YGeVg23QjS9hF2wvZk+Akkwl0U2kT+Typ1mZvtBUdlLvkJ/ckxBcl4CMrbhNFVR9Dasb0I5p
 28SnO6C4nZgK1xdOD+yZTM1ujDfPFwIGL2keQ5s8L/oRXlCdiAiIgGJ5ooexai/he7Dglcgv
 WU1NzCwMaJ6IBmorA63DdWBcZ2Q=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5f1eb2577ab15087ebfc0f5a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Jul 2020 10:54:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25E83C433CB; Mon, 27 Jul 2020 10:54:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 953A0C433C9;
        Mon, 27 Jul 2020 10:54:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Jul 2020 16:24:14 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org, mka@chromium.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 3/6] interconnect: qcom: sdm845: Replace xlate with
 xlate_extended
In-Reply-To: <20200723130942.28491-4-georgi.djakov@linaro.org>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
 <20200723130942.28491-4-georgi.djakov@linaro.org>
Message-ID: <5e145c668b5c9c6709e102145b8d403b@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-07-23 18:39, Georgi Djakov wrote:
> Use the qcom_icc_xlate_extended() in order to parse tags, that are
> specified as an additional arguments to the path endpoints in DT.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> ---
>  drivers/interconnect/qcom/sdm845.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/sdm845.c
> b/drivers/interconnect/qcom/sdm845.c
> index f6c7b969520d..3b81dbb71b0b 100644
> --- a/drivers/interconnect/qcom/sdm845.c
> +++ b/drivers/interconnect/qcom/sdm845.c
> @@ -469,7 +469,7 @@ static int qnoc_probe(struct platform_device *pdev)
>  	provider->set = qcom_icc_set;
>  	provider->pre_aggregate = qcom_icc_pre_aggregate;
>  	provider->aggregate = qcom_icc_aggregate;
> -	provider->xlate = of_icc_xlate_onecell;
> +	provider->xlate_extended = qcom_icc_xlate_extended;
>  	INIT_LIST_HEAD(&provider->nodes);
>  	provider->data = data;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
