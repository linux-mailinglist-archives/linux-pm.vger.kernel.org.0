Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE833B4A19
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jun 2021 23:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFYVXL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 17:23:11 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32606 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229776AbhFYVXL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Jun 2021 17:23:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624656050; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=NoMSS2jZh3W33/EPGm5FlNAQrsA0EwTvpmlsWbO0PCs=; b=lQMxPUUCgwqkKfIPB1hI+KlWKLYrzLtg2YJolUNk7aFDHpAoZw/YqA6vUohiHKgEdvH0Ozwy
 uKQRBoFFxy7BRQRvdRJch6xtUQQGLKHu2pFeoyQYbMtl1l7ptem6YKTfNjH+jgT35h/r+HBM
 92DRra1BuxT2FS9D/xsj3kKIczs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60d648ad7e5ba0fdc06f5383 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Jun 2021 21:20:45
 GMT
Sender: mdtipton=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9503CC4323A; Fri, 25 Jun 2021 21:20:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.114] (047-133-151-001.res.spectrum.com [47.133.151.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D13E2C433D3;
        Fri, 25 Jun 2021 21:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D13E2C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mdtipton@codeaurora.org
Subject: Re: [PATCH] interconnect: Aggregate bandwidth votes for unused nodes
 in sync_state()
To:     Odelu Kukatla <okukatla@codeaurora.org>, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, sibis@codeaurora.org, saravanak@google.com,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
References: <1624122509-17508-1-git-send-email-okukatla@codeaurora.org>
From:   Mike Tipton <mdtipton@codeaurora.org>
Message-ID: <f93ad53b-f413-f8dc-2068-2c217cbed543@codeaurora.org>
Date:   Fri, 25 Jun 2021 14:20:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624122509-17508-1-git-send-email-okukatla@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/19/2021 10:08 AM, Odelu Kukatla wrote:
> When removing the initial bandwidth votes in sync_state(), make sure
> to call the aggregate() function for nodes which don't have any
> clients yet. aggregate_requests() does not invoke aggregate()
> for unused nodes.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>   drivers/interconnect/core.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 8a1e70e..1d9a00a 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -1106,7 +1106,16 @@ void icc_sync_state(struct device *dev)
>   		dev_dbg(p->dev, "interconnect provider is in synced state\n");
>   		list_for_each_entry(n, &p->nodes, node_list) {
>   			if (n->init_avg || n->init_peak) {
> -				aggregate_requests(n);
> +				if (hlist_empty(&n->req_list)) {
> +					if (p->pre_aggregate)
> +						p->pre_aggregate(n);
> +
> +					p->aggregate(n, 0, 0, 0, &n->avg_bw,
> +						&n->peak_bw);
> +				} else {
> +					aggregate_requests(n);
> +				}
> +
>   				p->set(n, n);
>   			}
>   		}
> 

I ran into this issue myself last week. There is an alternative fix that 
I think is a little cleaner. The reason we need the aggregate() call 
here is that the icc-rpmh providers only add BCMs to the commit list in 
the aggregate() callback. If aggregate() isn't called, then we don't 
commit anything to HW. But, if we instead add BCMs to the commit list in 
pre_aggregate(), then the existing aggregate_requests() call is 
sufficient, since that always calls pre_aggregate() even when req_list 
is empty. That means we'd need to update icc_node_add() to call 
pre_aggregate() before aggregate(), otherwise we wouldn't commit the 
initial floors. But I think always calling pre_aggregate() before 
aggregate() is a reasonable requirement.

I've posted these changes in a patch series along with a separate 
sync-state-related fix. The solutions could co-exist, but they are 
largely redundant.

