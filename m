Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2A43B9638
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 20:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhGASvS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 14:51:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25676 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhGASvS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Jul 2021 14:51:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625165327; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=blxOe96Hr8SQcdVl95JnLY5mZV4CcHsOypImKe+oKsg=;
 b=NyFt8josEdOYJEVHT6kXhhsAU3QHR3QFk3+a2NBEchsw4VWMeZn0hROnNb4FIWf8fN5uwY7E
 iGFOKIWPYRjQhWKo7Su0tntsqdLqVaiafVZagAwwCPYdpM7dQxqvWJSLa0ZFt6eSKmMmm8OL
 H90KeIfwWih6oHkOHtkiI7VuvvQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60de0e0eec0b18a745fd994c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Jul 2021 18:48:46
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A7CA0C43460; Thu,  1 Jul 2021 18:48:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA2A6C433F1;
        Thu,  1 Jul 2021 18:48:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 02 Jul 2021 00:18:44 +0530
From:   okukatla@codeaurora.org
To:     Mike Tipton <mdtipton@codeaurora.org>
Cc:     djakov@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        saravanak@google.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdtipton=codeaurora.org@codeaurora.org
Subject: Re: [PATCH 3/4] interconnect: qcom: icc-rpmh: Ensure floor BW is
 enforced for all nodes
In-Reply-To: <20210625212839.24155-4-mdtipton@codeaurora.org>
References: <20210625212839.24155-1-mdtipton@codeaurora.org>
 <20210625212839.24155-4-mdtipton@codeaurora.org>
Message-ID: <afaf4cb4ccc60a1c7c937a296f199f70@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-06-26 02:58, Mike Tipton wrote:
> We currently only enforce BW floors for a subset of nodes in a path.
> All BCMs that need updating are queued in the pre_aggregate/aggregate
> phase. The first set() commits all queued BCMs and subsequent set()
> calls short-circuit without committing anything. Since the floor BW
> isn't set in sum_avg/max_peak until set(), then some BCMs are committed
> before their associated nodes reflect the floor.
> 
> Set the floor as each node is being aggregated. This ensures that all
> all relevant floors are set before the BCMs are committed.
> 
> Fixes: 266cd33b5913 ("interconnect: qcom: Ensure that the floor
> bandwidth value is enforced")
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> ---
>  drivers/interconnect/qcom/icc-rpmh.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c
> b/drivers/interconnect/qcom/icc-rpmh.c
> index bf01d09dba6c..f118f57eae37 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -57,6 +57,11 @@ int qcom_icc_aggregate(struct icc_node *node, u32
> tag, u32 avg_bw,
>  			qn->sum_avg[i] += avg_bw;
>  			qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
>  		}
> +
> +		if (node->init_avg || node->init_peak) {
> +			qn->sum_avg[i] = max_t(u64, qn->sum_avg[i], node->init_avg);
> +			qn->max_peak[i] = max_t(u64, qn->max_peak[i], node->init_peak);
> +		}
Hi Mike,
Original problem is BCMs not getting added to commit_list for unused 
nodes, right? that is solved by moving *_bcm_voter_add() to 
pre_aggregate().
I could not get why we need to do above change, we are enforcing node 
votes with floor votes in framework + below code snippet that you 
removed.
How would adding this code in qcom_icc_aggregate() make difference? Is 
there any other issue that i am not to able to get?
>  	}
> 
>  	*agg_avg += avg_bw;
> @@ -90,11 +95,6 @@ int qcom_icc_set(struct icc_node *src, struct 
> icc_node *dst)
>  	qp = to_qcom_provider(node->provider);
>  	qn = node->data;
> 
> -	qn->sum_avg[QCOM_ICC_BUCKET_AMC] = max_t(u64,
> qn->sum_avg[QCOM_ICC_BUCKET_AMC],
> -						 node->avg_bw);
> -	qn->max_peak[QCOM_ICC_BUCKET_AMC] = max_t(u64,
> qn->max_peak[QCOM_ICC_BUCKET_AMC],
> -						  node->peak_bw);
> -
>  	qcom_icc_bcm_voter_commit(qp->voter);
> 
>  	return 0;
