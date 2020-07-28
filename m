Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D1323027E
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 08:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgG1GSd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jul 2020 02:18:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:19832 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbgG1GSc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Jul 2020 02:18:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595917110; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=ptC3NElqN7QOiSiiLpeT0GwFnbmdSfadBu5MLmEGp4U=; b=r6Py/p6ZjtnZBaho/KqloN9DPK+6zFZxVs8V3yy0c80rHU+3d8Cuxg6dPAu1dp15OschO7av
 5O2MrLb91/tiYNlKDSB9MAqbjfl7M39VsHG+nFd6ehgdcILrRCOYs4IpOASpmBNbuCOIwlWc
 IgD+8ESjcnpO5vw6pKH8bJI6vG0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f1fc3347ab15087eb33de4e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Jul 2020 06:18:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A947AC43391; Tue, 28 Jul 2020 06:18:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.117] (ip70-179-20-127.sd.sd.cox.net [70.179.20.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70072C433C6;
        Tue, 28 Jul 2020 06:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70072C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
Subject: Re: [PATCH v2 1/2] interconnect: Add sync state support
To:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>, okukatla@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200722110139.24778-1-georgi.djakov@linaro.org>
 <20200722110139.24778-2-georgi.djakov@linaro.org>
 <CAGETcx-QM8P2nVxcQJZz+m5Zwi==2qLfinb0FkDXJ7dNVP5bEA@mail.gmail.com>
From:   Mike Tipton <mdtipton@codeaurora.org>
Message-ID: <e4f68ae5-5cf7-bac4-e7f2-c074327ea659@codeaurora.org>
Date:   Mon, 27 Jul 2020 23:18:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx-QM8P2nVxcQJZz+m5Zwi==2qLfinb0FkDXJ7dNVP5bEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/22/2020 10:07 AM, Saravana Kannan wrote:
> On Wed, Jul 22, 2020 at 4:01 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> The bootloaders often do some initial configuration of the interconnects
>> in the system and we want to keep this configuration until all consumers
>> have probed and expressed their bandwidth needs. This is because we don't
>> want to change the configuration by starting to disable unused paths until
>> every user had a chance to request the amount of bandwidth it needs.
>>
>> To accomplish this we will implement an interconnect specific sync_state
>> callback which will synchronize (aggregate and set) the current bandwidth
>> settings when all consumers have been probed.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>   drivers/interconnect/core.c           | 61 +++++++++++++++++++++++++++
>>   include/linux/interconnect-provider.h |  5 +++
>>   2 files changed, 66 insertions(+)
>>
>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>> index e5f998744501..0c4e38d9f1fa 100644
>> --- a/drivers/interconnect/core.c
>> +++ b/drivers/interconnect/core.c
>> @@ -26,6 +26,8 @@
>>
>>   static DEFINE_IDR(icc_idr);
>>   static LIST_HEAD(icc_providers);
>> +static int providers_count;
>> +static bool synced_state;
>>   static DEFINE_MUTEX(icc_lock);
>>   static struct dentry *icc_debugfs_dir;
>>
>> @@ -255,6 +257,12 @@ static int aggregate_requests(struct icc_node *node)
>>                          continue;
>>                  p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
>>                               &node->avg_bw, &node->peak_bw);
>> +
>> +               /* during boot use the initial bandwidth as a floor value */
>> +               if (!synced_state) {
>> +                       node->avg_bw = max(node->avg_bw, node->init_avg);
>> +                       node->peak_bw = max(node->peak_bw, node->init_peak);
>> +               }
> 
> Sorry I didn't reply earlier.
> 
> I liked your previous approach with the get_bw ops. The v2 approach
> forces every interconnect provider driver to set up these values even
> if they are okay with just maxing out the bandwidth. Also, if they can
> actually query their hardware, this adds additional steps for them.

The problem with using something like get_bw() is that while we can 
dynamically query the HW, we have far less granularity in HW than we 
have nodes in the framework. We vote at BCM-level granularity, but each 
BCM can have many nodes. For example, the sdm845 CN0 BCM has 47 nodes. 
If we implement get_bw() generically, then it would return the BW for 
each node, which would be the queried BCM vote scaled to account for 
differences in BCM/node widths. While this could be useful in general as 
an informational callback, we wouldn't want to use this as a proxy for 
our initial BW vote requirements. For CN0, we wouldn't want or need to 
vote 47 times for the same CN0 BCM. Each of the 47 node requests would 
result in the same BCM request.

All we'd really need is a single node per-BCM to serve as the proxy 
node. We'd query the HW, scale the queried value for the chosen proxy 
node, and set init_avg/init_peak appropriately. This would save a lot of 
unnecessary votes. Based on the current implementation, the set() call 
in icc_node_add() for initial BW wouldn't trigger any actual HW requests 
since we only queue BCMs that require updating in the aggregate() 
callback. However, the set() call in icc_sync_state() would, since we 
re-aggregate each node that has a non-zero init_avg/init_peak.

There's nothing stopping us from implementing get_bw() as if it were 
get_initial_bw(), but that only works until the framework decides to use 
get_bw() for more things than just the initial vote. I suppose we could 
also just have a "get_initial_bw" callback, but it only needs to be 
called once, so doesn't necessarily need a callback as opposed to 
additional init_avg/init_peak members in the icc_node struct.

> 
> I think the default should be:
> 1. Query the current bandwidth at boot and use that.
> 2. If that's not available, max out the bandwidth.
> 
> The interconnect providers that don't like maxing out and don't have
> real get_bw() capability can just cache and return the last set_bw()
> values. And they start off with those cached values matching whatever
> init_bw they need.
> 
> That way, the default case (can get bw or don't care about maxing out)
> would be easy and the extra work would be limited to drivers that want
> neither. >
> -Saravana
> 
