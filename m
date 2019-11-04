Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 672E4EE7DD
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 20:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfKDTDg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 14:03:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfKDTDg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 14:03:36 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 22A5260EB7; Mon,  4 Nov 2019 19:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572894214;
        bh=/H4+77c+INHSgDJpw4w2/4J7BBW6P7Sh7p+XlTmzsIE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dyVESEWyZNDuFSLC+RtG8SKLHt3dX4AicqrXwxNk4dNCa2y1rJ7BYySlgNq6eX8cr
         DEcryGc/uuU96J65GQJ+Fqjpqnf+yaGLppERwE54wxuKBEboURfpfbSDWX/uZZZm8a
         Zjyvktrsd2gQuYt+dsS+UlHkMWeSHGK/C1agNCnk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.46.162.237] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2334060EB7;
        Mon,  4 Nov 2019 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572894210;
        bh=/H4+77c+INHSgDJpw4w2/4J7BBW6P7Sh7p+XlTmzsIE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a8bcLff0WMNPyelh26JeCCUzP7QbbjQuqKIseejAmM91cPoer6EkFbt0X4U/Ifq/S
         zh5cMtvGeEg4xXNWSRUIc4RCjKubRv4DvyTqhuGi0AmNs5mEI1lNXs0XyZydZF3tK4
         1KmD/qTLN0LF0qG1HWaDxAJihfGdNh/i9JfCrn4g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2334060EB7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
Subject: Re: [RFC PATCH 3/4] interconnect: qcom: Refactor icc rpmh support
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     evgreen@google.com, sboyd@kernel.org, ilina@codeaurora.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <1571278852-8023-1-git-send-email-daidavid1@codeaurora.org>
 <1571278852-8023-4-git-send-email-daidavid1@codeaurora.org>
 <307e8a19-9e37-8cf2-56db-67a2642c2f0a@linaro.org>
From:   David Dai <daidavid1@codeaurora.org>
Message-ID: <128e117d-fa71-29ea-f0a2-03c484408e4c@codeaurora.org>
Date:   Mon, 4 Nov 2019 11:03:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <307e8a19-9e37-8cf2-56db-67a2642c2f0a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for the review Georgi.

On 10/28/2019 9:31 AM, Georgi Djakov wrote:
> Hi David,
>
> On 17.10.19 г. 5:20 ч., David Dai wrote:
>> Add bcm voter driver and add support for RPMh specific interconnect
>> providers so that they may be re-used for icc-next RPMh based provider
>> drivers.
> For icc-next? You mean to be re-used for other RPMh based drivers?

Yes, meant for other RPMh based QTI platforms. I'll phrase this a bit 
better.


>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> ---
>>   drivers/interconnect/qcom/Kconfig     |   8 +
>>   drivers/interconnect/qcom/Makefile    |   4 +
>>   drivers/interconnect/qcom/bcm-voter.c | 355 ++++++++++++++++++++++++++++++++++
>>   drivers/interconnect/qcom/bcm-voter.h |  28 +++
>>   drivers/interconnect/qcom/icc-rpmh.c  | 154 +++++++++++++++
>>   drivers/interconnect/qcom/icc-rpmh.h  | 150 ++++++++++++++
>>   6 files changed, 699 insertions(+)
>>   create mode 100644 drivers/interconnect/qcom/bcm-voter.c
>>   create mode 100644 drivers/interconnect/qcom/bcm-voter.h
>>   create mode 100644 drivers/interconnect/qcom/icc-rpmh.c
>>   create mode 100644 drivers/interconnect/qcom/icc-rpmh.h
>>
>> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
>> index 6ab4012..8ff255d 100644
>> --- a/drivers/interconnect/qcom/Kconfig
>> +++ b/drivers/interconnect/qcom/Kconfig
>> @@ -18,9 +18,17 @@ config INTERCONNECT_QCOM_SDM845
>>   	tristate "Qualcomm SDM845 interconnect driver"
>>   	depends on INTERCONNECT_QCOM
>>   	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
>> +	select INTERCONNECT_QCOM_RPMH
>> +	select INTERCONNECT_QCOM_BCM_VOTER
>>   	help
>>   	  This is a driver for the Qualcomm Network-on-Chip on sdm845-based
>>   	  platforms.
>>   
>> +config INTERCONNECT_QCOM_BCM_VOTER
>> +	tristate
>> +
>> +config INTERCONNECT_QCOM_RPMH
>> +	tristate
>> +>  config INTERCONNECT_QCOM_SMD_RPM
>>   	tristate
>> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
>> index 67dafb7..0f5e88d 100644
>> --- a/drivers/interconnect/qcom/Makefile
>> +++ b/drivers/interconnect/qcom/Makefile
>> @@ -3,7 +3,11 @@
>>   qnoc-qcs404-objs			:= qcs404.o
>>   qnoc-sdm845-objs			:= sdm845.o
>>   icc-smd-rpm-objs			:= smd-rpm.o
>> +bcm-voter-objs				:= bcm-voter.o
> Maybe icc-bcm-voter-objs. Does the BCM vote for stuff other than bandwidth?

Ok. Only used for bandwidth at the moment.


>> +icc-rpmh-obj				:= icc-rpmh.o
>>   
>>   obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
>>   obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
>> +obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += bcm-voter.o
>> +obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
>> diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
>> new file mode 100644
>> index 0000000..f74ae5f
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/bcm-voter.c
> [..]
>> +/**
>> + * of_bcm_voter_get - gets a bcm voter handle from DT node
>> + * @dev: device pointer for the consumer device
>> + * @name: name for the bcm voter device
>> + *
>> + * This function will match a device_node pointer for the phandle
>> + * specified in the device DT and return a bcm_voter handle on success.
>> + *
>> + * Returns bcm_voter pointer or ERR_PTR() on error. EPROBE_DEFER is returned
>> + * when matching bcm voter is yet to be found.
>> + */
>> +struct bcm_voter *of_bcm_voter_get(struct device *dev, const char *name)
>> +{
>> +	struct bcm_voter *voter = ERR_PTR(-EPROBE_DEFER);
>> +	struct bcm_voter *temp;
>> +	struct device_node *np, *node;
>> +	int idx = 0;
>> +
>> +	if (!dev || !dev->of_node)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	np = dev->of_node;
>> +
>> +	if (name) {
>> +		idx = of_property_match_string(np, "qcom,bcm-voter-names", name);
>> +		if (idx < 0)
>> +			return ERR_PTR(idx);
>> +	}
>> +
>> +	node = of_parse_phandle(np, "qcom,bcm-voters", idx);
>> +
>> +	list_for_each_entry(temp, &bcm_voters, voter_node) {
>> +		if (temp->np == node)
>> +			voter = temp;
>> +			break;
> Missing curly braces!

Oops, will fix.


>> +	}
>> +
>> +	return voter;
>> +}
>> +EXPORT_SYMBOL_GPL(of_bcm_voter_get);
>> +
> [..]
>> +++ b/drivers/interconnect/qcom/bcm-voter.h
>> @@ -0,0 +1,28 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>> + *
>> + */
>> +
>> +#ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_BCM_VOTER_H__
>> +#define __DRIVERS_INTERCONNECT_QCOM_ICC_BCM_VOTER_H__
> Doesn't match the path - icc-bcm-voter.h vs bcm-voter.h?

Will rename the bcm-voter to icc-bcm-voter as suggested above.


>> +
>> +#include <soc/qcom/cmd-db.h>
>> +#include <soc/qcom/rpmh.h>
>> +#include <soc/qcom/tcs.h>
>> +
>> +#include "icc-rpmh.h"
>> +
>> +#define DEFINE_QBCM(_name, _bcmname, _keepalive, _numnodes, ...)	\
>> +		static struct qcom_icc_bcm _name = {			\
>> +		.name = _bcmname,					\
>> +		.keepalive = _keepalive,				\
>> +		.num_nodes = _numnodes,					\
>> +		.nodes = { __VA_ARGS__ },				\
>> +	}
>> +
>> +struct bcm_voter *of_bcm_voter_get(struct device *dev, const char *name);
>> +void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm);
>> +int qcom_icc_bcm_voter_commit(struct bcm_voter *voter);
>> +
>> +#endif
>> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
>> new file mode 100644
>> index 0000000..abe9f1e
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/icc-rpmh.c
>> @@ -0,0 +1,154 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>> + *
>> + */
>> +
>> +#include <asm/div64.h>
>> +#include <dt-bindings/interconnect/qcom,sdm845.h>
>> +#include <linux/interconnect.h>
>> +#include <linux/interconnect-provider.h>
>> +
>> +#include "icc-rpmh.h"
>> +#include "bcm-voter.h"
>> +
>> +/**
>> + * qcom_icc_pre_aggregate - cleans up stale values from prior icc_set
>> + * @node: icc node to operate on
>> + */
>> +void qcom_icc_pre_aggregate(struct icc_node *node)
>> +{
>> +	size_t i;
>> +	struct qcom_icc_node *qn;
>> +
>> +	qn = node->data;
>> +
>> +	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
>> +		qn->sum_avg[i] = 0;
>> +		qn->max_peak[i] = 0;
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_icc_pre_aggregate);
>> +
>> +/**
>> + * qcom_icc_aggregate - aggregate bw for buckets indicated by tag
>> + * @node: node to aggregate
>> + * @tag: tag to indicate which buckets to aggregate
>> + * @avg_bw: new bw to sum aggregate
>> + * @peak_bw: new bw to max aggregate
>> + * @agg_avg: existing aggregate avg bw val
>> + * @agg_peak: existing aggregate peak bw val
>> + */
>> +int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>> +		       u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> Nit: Please match the open parenthesis.

Ok.


>> +{
>> +	size_t i;
>> +	struct qcom_icc_node *qn;
>> +	struct qcom_icc_provider *qp;
>> +
>> +	qn = node->data;
>> +	qp = to_qcom_provider(node->provider);
>> +
>> +	if (!tag)
>> +		tag = QCOM_ICC_TAG_ALWAYS;
>> +
>> +	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
>> +		if (tag & BIT(i)) {
>> +			qn->sum_avg[i] += avg_bw;
>> +			qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
>> +		}
>> +	}
>> +
>> +	*agg_avg += avg_bw;
>> +	*agg_peak = max_t(u32, *agg_peak, peak_bw);
>> +
>> +	for (i = 0; i < qn->num_bcms; i++)
>> +		qcom_icc_bcm_voter_add(qp->voter, qn->bcms[i]);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_icc_aggregate);
>> +
>> +/**
>> + * qcom_icc_set - set the constraints based on path
>> + * @src: source node for the path to set constraints on
>> + * @dst: destination node for the path to set constraints on
>> + *
>> + * Return: 0 on success, or an error code otherwise
>> + */
>> +int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>> +{
>> +	struct qcom_icc_provider *qp;
>> +	struct icc_node *node;
>> +	int ret = 0;
>> +
>> +	if (!src)
>> +		pr_err("src(%d)\n", 0);
>> +	else
>> +		pr_err("src(%d)\n", src->id);
> pr_err?

This needs to be removed.


>> +
>> +	if (!src)
>> +		node = dst;
>> +	else
>> +		node = src;
>> +
>> +	qp = to_qcom_provider(node->provider);
>> +
>> +	qcom_icc_bcm_voter_commit(qp->voter);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_icc_set);
> [..]
>> +++ b/drivers/interconnect/qcom/icc-rpmh.h
>> @@ -0,0 +1,150 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>> + *
>> + */
>> +
>> +#ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPMH_H__
>> +#define __DRIVERS_INTERCONNECT_QCOM_ICC_RPMH_H__
>> +
>> +#define to_qcom_provider(_provider) \
>> +	container_of(_provider, struct qcom_icc_provider, provider)
>> +
>> +/**
>> + * struct qcom_icc_provider - Qualcomm specific interconnect provider
>> + * @dev: reference to the NoC device
>> + * @bcms: list of bcms that maps to the provider
>> + * @num_bcms: number of @bcms
>> + * @voter: bcm voter targeted by this provider
>> + */
>> +struct qcom_icc_provider {
>> +	struct icc_provider provider;
>> +	struct device *dev;
>> +	struct qcom_icc_bcm **bcms;
>> +	size_t num_bcms;
>> +	struct bcm_voter *voter;
>> +};
>> +
>> +/**
>> + * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager (BCM)
>> + * @unit: divisor used to convert bytes/sec bw value to an RPMh msg
>> + * @width: multiplier used to convert bytes/sec bw value to an RPMh msg
>> + * @vcd: virtual clock domain that this bcm belongs to
>> + * @reserved: reserved field
>> + */
>> +struct bcm_db {
>> +	__le32 unit;
>> +	__le16 width;
>> +	u8 vcd;
>> +	u8 reserved;
>> +};
> The same also exists in clk-rpmh.c. Should we move it to some common place?

Yes, this should be refactored into the rpmh headers.

>> +
>> +#define MAX_LINKS		128
>> +#define MAX_BCMS		64
>> +#define MAX_BCM_PER_NODE	3
>> +#define MAX_VCD			10
>> +
>> +/*
>> + * The AMC bucket denotes constraints that are applied to hardware when
>> + * icc_set_bw() completes, whereas the WAKE and SLEEP constraints are applied
>> + * when the execution environment transitions between active and low power mode.
>> + */
>> +#define QCOM_ICC_BUCKET_AMC		0
>> +#define QCOM_ICC_BUCKET_WAKE		1
>> +#define QCOM_ICC_BUCKET_SLEEP		2
>> +#define QCOM_ICC_NUM_BUCKETS		3
>> +#define QCOM_ICC_TAG_AMC		BIT(QCOM_ICC_BUCKET_AMC)
>> +#define QCOM_ICC_TAG_WAKE		BIT(QCOM_ICC_BUCKET_WAKE)
>> +#define QCOM_ICC_TAG_SLEEP		BIT(QCOM_ICC_BUCKET_SLEEP)
>> +#define QCOM_ICC_TAG_ACTIVE_ONLY	(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE)
>> +#define QCOM_ICC_TAG_ALWAYS		(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE |\
>> +					 QCOM_ICC_TAG_SLEEP)
>> +
>> +/**
>> + * struct qcom_icc_node - Qualcomm specific interconnect nodes
>> + * @name: the node name used in debugfs
>> + * @links: an array of nodes where we can go next while traversing
>> + * @id: a unique node identifier
>> + * @num_links: the total number of @links
>> + * @channels: num of channels at this node
>> + * @buswidth: width of the interconnect between a node and the bus
>> + * @sum_avg: current sum aggregate value of all avg bw requests
>> + * @max_peak: current max aggregate value of all peak bw requests
>> + * @bcms: list of bcms associated with this logical node
>> + * @num_bcms: num of @bcms
>> + */
>> +struct qcom_icc_node {
>> +	const char *name;
>> +	u16 links[MAX_LINKS];
>> +	u16 id;
>> +	u16 num_links;
>> +	u16 channels;
>> +	u16 buswidth;
>> +	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
>> +	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
>> +	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
>> +	size_t num_bcms;
>> +};
>> +
>> +/**
>> + * struct qcom_icc_bcm - Qualcomm specific hardware accelerator nodes
>> + * known as Bus Clock Manager (BCM)
>> + * @name: the bcm node name used to fetch BCM data from command db
>> + * @type: latency or bandwidth bcm
>> + * @addr: address offsets used when voting to RPMH
>> + * @vote_x: aggregated threshold values, represents sum_bw when @type is bw bcm
>> + * @vote_y: aggregated threshold values, represents peak_bw when @type is bw bcm
>> + * @dirty: flag used to indicate whether the bcm needs to be committed
>> + * @keepalive: flag used to indicate whether a keepalive is required
>> + * @aux_data: auxiliary data used when calculating threshold values and
>> + * communicating with RPMh
>> + * @list: used to link to other bcms when compiling lists for commit
>> + * @ws_list: used to keep track of bcms that may transition between wake/sleep
>> + * @num_nodes: total number of @num_nodes
>> + * @nodes: list of qcom_icc_nodes that this BCM encapsulates
>> + */
>> +struct qcom_icc_bcm {
>> +	const char *name;
>> +	u32 type;
>> +	u32 addr;
>> +	u64 vote_x[QCOM_ICC_NUM_BUCKETS];
>> +	u64 vote_y[QCOM_ICC_NUM_BUCKETS];
>> +	bool dirty;
>> +	bool keepalive;
>> +	struct bcm_db aux_data;
>> +	struct list_head list;
>> +	struct list_head ws_list;
>> +	size_t num_nodes;
>> +	struct qcom_icc_node *nodes[];
>> +};
>> +
>> +struct qcom_icc_fabric {
>> +	struct qcom_icc_node **nodes;
>> +	size_t num_nodes;
>> +};
> Is this used?

No, this needs to be removed.


>> +
>> +struct qcom_icc_desc {
>> +	struct qcom_icc_node **nodes;
>> +	size_t num_nodes;
>> +	struct qcom_icc_bcm **bcms;
>> +	size_t num_bcms;
>> +};
>> +
>> +#define DEFINE_QNODE(_name, _id, _channels, _buswidth,			\
>> +			_numlinks, ...)					\
>> +		static struct qcom_icc_node _name = {			\
>> +		.id = _id,						\
>> +		.name = #_name,						\
>> +		.channels = _channels,					\
>> +		.buswidth = _buswidth,					\
>> +		.num_links = _numlinks,					\
>> +		.links = { __VA_ARGS__ },				\
>> +	}
>> +
>> +int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>> +			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
>> +int qcom_icc_set(struct icc_node *src, struct icc_node *dst);
>> +int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev);
>> +void qcom_icc_pre_aggregate(struct icc_node *node);
>> +
>> +#endif
> Thanks for working on this!
>
> BR,
> Georgi

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

