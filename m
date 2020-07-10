Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E015E21AE49
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 07:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgGJFES (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 01:04:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:35696 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbgGJFEP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 01:04:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594357453; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=KilR/VqLipT8uIZpR6gEOQZ5SOim8a1e0XSTSCjBCeo=; b=xMqE5ZP16eWK2fhVrFViaACG1hqXMoFulI+sRelDShUP0pjF7vmcoVpmXQGZbN/zeqjygBfv
 7AZz6PNk0QeZ1+CVpSEstTq5KxP4DXqrpz+twByfDamzFlrBwH+YKhQo+c5hcK/GknZBeEcY
 zPuOcaA7/F1V3ZSHP0EKm+68ycQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5f07f6cba19992ac65b60c36 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 10 Jul 2020 05:04:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C07B0C433CB; Fri, 10 Jul 2020 05:04:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.117] (ip70-179-20-127.sd.sd.cox.net [70.179.20.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 51DA4C433C6;
        Fri, 10 Jul 2020 05:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51DA4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
Subject: Re: [PATCH 1/4] interconnect: Add sync state support
To:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org
Cc:     saravanak@google.com, okukatla@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200709110705.30359-1-georgi.djakov@linaro.org>
 <20200709110705.30359-2-georgi.djakov@linaro.org>
From:   Mike Tipton <mdtipton@codeaurora.org>
Message-ID: <50291b4d-7ca7-48a0-384f-beefcc94f7cc@codeaurora.org>
Date:   Thu, 9 Jul 2020 22:04:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709110705.30359-2-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/9/2020 4:07 AM, Georgi Djakov wrote:
> The bootloaders often do some initial configuration of the interconnects
> in the system and we want to keep this configuration until all consumers
> have probed and expressed their bandwidth needs. This is because we don't
> want to change the configuration by starting to disable unused paths until
> every user had a chance to request the amount of bandwidth it needs.
> 
> To accomplish this we will implement an interconnect specific sync_state
> callback which will synchronize (aggregate and set) the current bandwidth
> settings when all consumers have been probed.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>   drivers/interconnect/core.c           | 56 +++++++++++++++++++++++++++
>   include/linux/interconnect-provider.h |  3 ++
>   2 files changed, 59 insertions(+)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index e5f998744501..e53adfee1ee3 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -26,6 +26,8 @@
>   
>   static DEFINE_IDR(icc_idr);
>   static LIST_HEAD(icc_providers);
> +static int providers_count;
> +static bool synced_state;
>   static DEFINE_MUTEX(icc_lock);
>   static struct dentry *icc_debugfs_dir;
>   
> @@ -255,6 +257,10 @@ static int aggregate_requests(struct icc_node *node)
>   			continue;
>   		p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
>   			     &node->avg_bw, &node->peak_bw);
> +
> +		/* during boot use the initial bandwidth as a floor value */
> +		if (!synced_state)
> +			node->peak_bw = max(node->peak_bw, node->init_bw);
>   	}
>   
>   	return 0;
> @@ -919,6 +925,12 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>   	node->provider = provider;
>   	list_add_tail(&node->node_list, &provider->nodes);
>   
> +	/* get the bandwidth value and sync it with the hardware */
> +	if (node->init_bw && provider->set) {
> +		node->peak_bw = node->init_bw;
> +		provider->set(node, node);
> +	}
> +

We'll need separate initial values for avg_bw/peak_bw. Some of our BCMs 
only support one or the other. Voting for one it doesn't support is a 
NOP. Additionally, some targets bring multiple subsystems out of reset 
in bootloaders and in those cases we'd need BCM to sum our initial 
avg_bw with the other subsystems.

>   	mutex_unlock(&icc_lock);
>   }
>   EXPORT_SYMBOL_GPL(icc_node_add);
> @@ -1014,8 +1026,52 @@ int icc_provider_del(struct icc_provider *provider)
>   }
>   EXPORT_SYMBOL_GPL(icc_provider_del);
>   
> +static int of_count_icc_providers(struct device_node *np)
> +{
> +	struct device_node *child;
> +	int count = 0;
> +
> +	for_each_available_child_of_node(np, child) {
> +		if (of_property_read_bool(child, "#interconnect-cells"))
> +			count++;
> +		count += of_count_icc_providers(child);
> +	}
> +	of_node_put(np);
> +
> +	return count;
> +}
> +
> +void icc_sync_state(struct device *dev)
> +{
> +	struct icc_provider *p;
> +	struct icc_node *n;
> +	static int count;
> +
> +	count++;
> +
> +	if (count < providers_count)
> +		return;
> +
> +	mutex_lock(&icc_lock);
> +	list_for_each_entry(p, &icc_providers, provider_list) {
> +		dev_dbg(p->dev, "interconnect provider is in synced state\n");
> +		list_for_each_entry(n, &p->nodes, node_list) {
> +			aggregate_requests(n);
> +			p->set(n, n);

We could skip re-aggregating/setting for nodes that don't specify an 
initial BW. That'll save a lot of unnecessary HW voting. In practice, 
we'll only need to specify an initial minimum BW for a small subset of 
nodes (likely only one per-BCM we care about). Technically we only need 
to re-aggregate/set if the current BW vote is limited by init_bw, but 
that optimization is less important than skipping the majority that 
don't have an init_bw.

> +		}
> +	}
> +	mutex_unlock(&icc_lock);
> +	synced_state = true;
> +}
> +EXPORT_SYMBOL_GPL(icc_sync_state);
> +
>   static int __init icc_init(void)
>   {
> +	struct device_node *root = of_find_node_by_path("/");
> +
> +	providers_count = of_count_icc_providers(root);
> +	of_node_put(root);
> +
>   	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
>   	debugfs_create_file("interconnect_summary", 0444,
>   			    icc_debugfs_dir, NULL, &icc_summary_fops);
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> index 0c494534b4d3..153fb7616f96 100644
> --- a/include/linux/interconnect-provider.h
> +++ b/include/linux/interconnect-provider.h
> @@ -71,6 +71,7 @@ struct icc_provider {
>    * @req_list: a list of QoS constraint requests associated with this node
>    * @avg_bw: aggregated value of average bandwidth requests from all consumers
>    * @peak_bw: aggregated value of peak bandwidth requests from all consumers
> + * @init_bw: the bandwidth value that is read from the hardware during init
>    * @data: pointer to private data
>    */
>   struct icc_node {
> @@ -87,6 +88,7 @@ struct icc_node {
>   	struct hlist_head	req_list;
>   	u32			avg_bw;
>   	u32			peak_bw;
> +	u32			init_bw;
>   	void			*data;
>   };
>   
> @@ -103,6 +105,7 @@ void icc_node_del(struct icc_node *node);
>   int icc_nodes_remove(struct icc_provider *provider);
>   int icc_provider_add(struct icc_provider *provider);
>   int icc_provider_del(struct icc_provider *provider);
> +void icc_sync_state(struct device *dev);
>   
>   #else
>   
> 
