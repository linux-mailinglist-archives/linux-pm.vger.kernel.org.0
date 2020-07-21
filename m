Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A000B22837B
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 17:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgGUPUU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 11:20:20 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:20459 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728127AbgGUPUU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 11:20:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595344819; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=sP+1vwr+zxdZpM1tMnq7FuFYXRL2RmZSOSnV6M8A46g=;
 b=TRJFFtuTiBYWydrdOlnqauQ45e5pOiuJS6hQ3EegPxyDz14GiNNLSqmuDOqz8e7PrBNRTl6G
 f8wA+mYuVyOF7kYF8x+mQ2e6Quq7t1ymh+np5rL5BoPupso5AEG3EeGMrLmSwkSyXkyorA/v
 Ih4oGpf/lJUQNwE0SalFUNQr7x8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f1707b27c8ca473a86a819b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Jul 2020 15:20:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4648BC433AD; Tue, 21 Jul 2020 15:20:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: adhudase)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF890C43395;
        Tue, 21 Jul 2020 15:20:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 21 Jul 2020 20:50:16 +0530
From:   adhudase@codeaurora.org
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, okukatla@codeaurora.org,
        mka@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Do not skip aggregation for disabled paths
In-Reply-To: <20200721120740.3436-1-georgi.djakov@linaro.org>
References: <20200721120740.3436-1-georgi.djakov@linaro.org>
Message-ID: <51df476d9b3470a545042bd34812c79c@codeaurora.org>
X-Sender: adhudase@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-07-21 17:37, Georgi Djakov wrote:
> When an interconnect path is being disabled, currently we don't 
> aggregate
> the requests for it afterwards. But the re-aggregation step shouldn't 
> be
> skipped, as it may leave the nodes with outdated bandwidth data. This
> outdated data may actually keep the path still enabled and prevent the
> device from going into lower power states.
> 
> Reported-by: Atul Dhudase <adhudase@codeaurora.org>
> Fixes: 7d374b209083 ("interconnect: Add helpers for enabling/disabling 
> a path")
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---

Tested-by: Atul Dhudase <adhudase@codeaurora.org>
Reviewed-by: Atul Dhudase <adhudase@codeaurora.org>

>  drivers/interconnect/core.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 37d5ec970cc1..5174dcb31ab7 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -243,6 +243,7 @@ static int aggregate_requests(struct icc_node 
> *node)
>  {
>  	struct icc_provider *p = node->provider;
>  	struct icc_req *r;
> +	u32 avg_bw, peak_bw;
> 
>  	node->avg_bw = 0;
>  	node->peak_bw = 0;
> @@ -251,9 +252,14 @@ static int aggregate_requests(struct icc_node 
> *node)
>  		p->pre_aggregate(node);
> 
>  	hlist_for_each_entry(r, &node->req_list, req_node) {
> -		if (!r->enabled)
> -			continue;
> -		p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
> +		if (r->enabled) {
> +			avg_bw = r->avg_bw;
> +			peak_bw = r->peak_bw;
> +		} else {
> +			avg_bw = 0;
> +			peak_bw = 0;
> +		}
> +		p->aggregate(node, r->tag, avg_bw, peak_bw,
>  			     &node->avg_bw, &node->peak_bw);
>  	}
