Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E1E2B720E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 00:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgKQXRo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 18:17:44 -0500
Received: from z5.mailgun.us ([104.130.96.5]:33520 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgKQXRn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Nov 2020 18:17:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605655062; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=WkHo0o60buZOjHlAwAOZsrA79RHdlfjTT5XNeSesXKQ=; b=WsALQyj9WvrVDO4+Orhw/StkvkC/pijKEYZF9njx3BtDBIuabd0alHHIprf185BANoSP4Vj4
 XMoaVc1vlJmoFImqLE4bAaz+LyfufdyioCRdtpLWiPtn5/1LoZ+pJHYS3WOcIiYCoIH1e1yC
 l7kRspmXmzH4/kz9bd+M0JII9Mw=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fb459edf2d9c8cbca586f2e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 17 Nov 2020 23:17:01
 GMT
Sender: mdtipton=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF335C433ED; Tue, 17 Nov 2020 23:17:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.159] (ip70-179-20-127.sd.sd.cox.net [70.179.20.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17967C433C6;
        Tue, 17 Nov 2020 23:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17967C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mdtipton@codeaurora.org
Subject: Re: [PATCH] interconnect: qcom: qcs404: Remove gpu and display nodes
To:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201111100734.307-1-georgi.djakov@linaro.org>
From:   Mike Tipton <mdtipton@codeaurora.org>
Message-ID: <357bd51c-7217-3e9b-ead9-a20f99c264f6@codeaurora.org>
Date:   Tue, 17 Nov 2020 15:16:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201111100734.307-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/11/2020 2:07 AM, Georgi Djakov wrote:
> The following errors are noticed during boot on a QCS404 board:
> [    2.926647] qcom_icc_rpm_smd_send mas 6 error -6
> [    2.934573] qcom_icc_rpm_smd_send mas 8 error -6
> 
> These errors show when we try to configure the GPU and display nodes,
> which are defined in the topology, but these hardware blocks actually
> do not exist on QCS404. According to the datasheet, GPU and display
> are only present on QCS405 and QCS407.

Even on QCS405/407 where GPU and display are present, you'd still get 
these errors since these particular nodes aren't supported on RPM and 
are purely local. Instead of removing these we should just change their 
mas_rpm_id to -1. It's harmless to leave them in for QCS404 since 
they're only used for path aggregation. The same code can support all 
variants of the QCS400 series. We just wouldn't expect anyone to 
actually vote these paths on QCS404. Similar to how the gcc-qcs404 clock 
provider still registers the GPU and MDP clocks.

> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>   drivers/interconnect/qcom/qcs404.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
> index 9f992422e92f..2ed544e23ff3 100644
> --- a/drivers/interconnect/qcom/qcs404.c
> +++ b/drivers/interconnect/qcom/qcs404.c
> @@ -20,8 +20,6 @@
>   
>   enum {
>   	QCS404_MASTER_AMPSS_M0 = 1,
> -	QCS404_MASTER_GRAPHICS_3D,
> -	QCS404_MASTER_MDP_PORT0,
>   	QCS404_SNOC_BIMC_1_MAS,
>   	QCS404_MASTER_TCU_0,
>   	QCS404_MASTER_SPDM,
> @@ -156,8 +154,6 @@ struct qcom_icc_desc {
>   	}
>   
>   DEFINE_QNODE(mas_apps_proc, QCS404_MASTER_AMPSS_M0, 8, 0, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
> -DEFINE_QNODE(mas_oxili, QCS404_MASTER_GRAPHICS_3D, 8, 6, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
> -DEFINE_QNODE(mas_mdp, QCS404_MASTER_MDP_PORT0, 8, 8, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV >   DEFINE_QNODE(mas_snoc_bimc_1, QCS404_SNOC_BIMC_1_MAS, 8, 76, -1, 
QCS404_SLAVE_EBI_CH0);
>   DEFINE_QNODE(mas_tcu_0, QCS404_MASTER_TCU_0, 8, -1, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
>   DEFINE_QNODE(mas_spdm, QCS404_MASTER_SPDM, 4, -1, -1, QCS404_PNOC_INT_3);
> @@ -231,8 +227,6 @@ DEFINE_QNODE(slv_lpass, QCS404_SLAVE_LPASS, 4, -1, -1, 0);
>   
>   static struct qcom_icc_node *qcs404_bimc_nodes[] = {
>   	[MASTER_AMPSS_M0] = &mas_apps_proc,
> -	[MASTER_OXILI] = &mas_oxili,
> -	[MASTER_MDP_PORT0] = &mas_mdp,
>   	[MASTER_SNOC_BIMC_1] = &mas_snoc_bimc_1,
>   	[MASTER_TCU_0] = &mas_tcu_0,
>   	[SLAVE_EBI_CH0] = &slv_ebi,
> @@ -460,6 +454,9 @@ static int qnoc_probe(struct platform_device *pdev)
>   	for (i = 0; i < num_nodes; i++) {
>   		size_t j;
>   
> +		if (!qnodes[i])
> +			continue;
> +
>   		node = icc_node_create(qnodes[i]->id);
>   		if (IS_ERR(node)) {
>   			ret = PTR_ERR(node);
> 
