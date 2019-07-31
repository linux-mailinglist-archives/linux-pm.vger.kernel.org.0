Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A837B73F
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 02:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfGaAhI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 20:37:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50480 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfGaAhH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 20:37:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0DA446037C; Wed, 31 Jul 2019 00:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564533425;
        bh=32eETmy3gzVOx1/6TECmdEq4btluC6NePPSwhFQdvuI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mKoWOGgeaqV9DoKB6edSUfHiaANYWQjbpnfJrV7y+LtJLZIVl1qZWIrMojFYDvprL
         NOjnkye2nMqIZl0Jm7SQ3Z4dtQNMyTLurXmjezrxLMlIC7h8r9zDO750YfVBD5FRAA
         KrWjHIWS7EPIRR0xxe/JSOo4cjvLOXQXHtbyOfSs=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CC2C6037C;
        Wed, 31 Jul 2019 00:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564533422;
        bh=32eETmy3gzVOx1/6TECmdEq4btluC6NePPSwhFQdvuI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C/BV8wHCgJ6cVBhIX032EBp75V3fCQF4yJ8Vvtxjl1HmwIMPqMTBPTMOVs1tRIKcN
         IUQvKJJF2uxVEl6sPDcXXkuUKFGfP9kG+TyoDRm+r4SWEgusgW//iBzWl3ADVnWodw
         GvkIWefRtsmd7wOdSajYRyC49rMC2gglJchbbGug=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CC2C6037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add tagging and wake/sleep
 support for sdm845
To:     Evan Green <evgreen@chromium.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, Doug Anderson <dianders@chromium.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        grahamr@qti.qualcomm.com
References: <20190618091724.28232-1-georgi.djakov@linaro.org>
 <20190618091724.28232-3-georgi.djakov@linaro.org>
 <CAE=gft7=ZbK3ARtWyv8n_hWJ4kuXRs0UA0QsE420pqL8R1quUQ@mail.gmail.com>
 <05d9fea0-c040-d609-38bf-11cddbe6aa4d@codeaurora.org>
 <CAE=gft4pQXyCdRsMkN7Xs-R5HU=2baYhCPqSsw=uqOfT+hTJDg@mail.gmail.com>
 <1fa30512-a0aa-dcc1-4160-778100a03e7c@codeaurora.org>
 <CAE=gft5_ZNUd7WC3c6t59Dwg32jeapvPFLxnESt143SaLqdO3g@mail.gmail.com>
From:   David Dai <daidavid1@codeaurora.org>
Message-ID: <37f56f17-9988-522f-f66c-2865954a52d0@codeaurora.org>
Date:   Tue, 30 Jul 2019 17:37:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAE=gft5_ZNUd7WC3c6t59Dwg32jeapvPFLxnESt143SaLqdO3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/30/2019 3:54 PM, Evan Green wrote:
> On Thu, Jul 18, 2019 at 10:59 AM David Dai <daidavid1@codeaurora.org> wrote:
>> On 7/16/2019 1:15 PM, Evan Green wrote:
>>> On Mon, Jul 15, 2019 at 4:34 PM David Dai <daidavid1@codeaurora.org> wrote:
>>>> Hi Evan,
>>>>
>>>> Thanks for the continued help in reviewing these patches!
>>> No problem. I want to do more, but haven't found time to do the
>>> prerequisite research before jumping into some of the other
>>> discussions yet.
>>>
>>>> On 7/11/2019 10:06 AM, Evan Green wrote:
>>>>> Hi Georgi and David,
>>>>>
>>>>> On Tue, Jun 18, 2019 at 2:17 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>>>>> From: David Dai <daidavid1@codeaurora.org>
>>>>>>
>>>>>> Add support for wake and sleep commands by using a tag to indicate
>>>>>> whether or not the aggregate and set requests fall into execution
>>>>>> state specific bucket.
>>>>>>
>>>>>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>>>>>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>>>>>> ---
>>>>>>     drivers/interconnect/qcom/sdm845.c | 129 ++++++++++++++++++++++-------
>>>>>>     1 file changed, 98 insertions(+), 31 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
>>>>>> index fb526004c82e..c100aab39415 100644
>>>>>> --- a/drivers/interconnect/qcom/sdm845.c
>>>>>> +++ b/drivers/interconnect/qcom/sdm845.c
>>>>>> @@ -66,6 +66,17 @@ struct bcm_db {
>>>>>>     #define SDM845_MAX_BCM_PER_NODE        2
>>>>>>     #define SDM845_MAX_VCD         10
>>>>>>
>>>>>> +#define QCOM_ICC_BUCKET_AMC            0
>>>>> What is AMC again? Is it the "right now" bucket? Maybe a comment on
>>>>> the meaning of this bucket would be helpful.
>>>> That's correct. Will add a comment for this.
>>>>>> +#define QCOM_ICC_BUCKET_WAKE           1
>>>>>> +#define QCOM_ICC_BUCKET_SLEEP          2
>>>>>> +#define QCOM_ICC_NUM_BUCKETS           3
>>>>>> +#define QCOM_ICC_TAG_AMC               BIT(QCOM_ICC_BUCKET_AMC)
>>>>>> +#define QCOM_ICC_TAG_WAKE              BIT(QCOM_ICC_BUCKET_WAKE)
>>>>>> +#define QCOM_ICC_TAG_SLEEP             BIT(QCOM_ICC_BUCKET_SLEEP)
>>>>>> +#define QCOM_ICC_TAG_ACTIVE_ONLY       (QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE)
>>>>>> +#define QCOM_ICC_TAG_ALWAYS            (QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE |\
>>>>>> +                                        QCOM_ICC_TAG_SLEEP)
>>>>>> +
>>>>>>     /**
>>>>>>      * struct qcom_icc_node - Qualcomm specific interconnect nodes
>>>>>>      * @name: the node name used in debugfs
>>>>>> @@ -75,7 +86,9 @@ struct bcm_db {
>>>>>>      * @channels: num of channels at this node
>>>>>>      * @buswidth: width of the interconnect between a node and the bus
>>>>>>      * @sum_avg: current sum aggregate value of all avg bw requests
>>>>>> + * @sum_avg_cached: previous sum aggregate value of all avg bw requests
>>>>>>      * @max_peak: current max aggregate value of all peak bw requests
>>>>>> + * @max_peak_cached: previous max aggregate value of all peak bw requests
>>>>>>      * @bcms: list of bcms associated with this logical node
>>>>>>      * @num_bcms: num of @bcms
>>>>>>      */
>>>>>> @@ -86,8 +99,10 @@ struct qcom_icc_node {
>>>>>>            u16 num_links;
>>>>>>            u16 channels;
>>>>>>            u16 buswidth;
>>>>>> -       u64 sum_avg;
>>>>>> -       u64 max_peak;
>>>>>> +       u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
>>>>>> +       u64 sum_avg_cached[QCOM_ICC_NUM_BUCKETS];
>>>>>> +       u64 max_peak[QCOM_ICC_NUM_BUCKETS];
>>>>>> +       u64 max_peak_cached[QCOM_ICC_NUM_BUCKETS];
>>>>>>            struct qcom_icc_bcm *bcms[SDM845_MAX_BCM_PER_NODE];
>>>>>>            size_t num_bcms;
>>>>>>     };
>>>>>> @@ -112,8 +127,8 @@ struct qcom_icc_bcm {
>>>>>>            const char *name;
>>>>>>            u32 type;
>>>>>>            u32 addr;
>>>>>> -       u64 vote_x;
>>>>>> -       u64 vote_y;
>>>>>> +       u64 vote_x[QCOM_ICC_NUM_BUCKETS];
>>>>>> +       u64 vote_y[QCOM_ICC_NUM_BUCKETS];
>>>>>>            bool dirty;
>>>>>>            bool keepalive;
>>>>>>            struct bcm_db aux_data;
>>>>>> @@ -555,7 +570,7 @@ inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
>>>>>>                    cmd->wait = true;
>>>>>>     }
>>>>>>
>>>>>> -static void tcs_list_gen(struct list_head *bcm_list,
>>>>>> +static void tcs_list_gen(struct list_head *bcm_list, int bucket,
>>>>>>                             struct tcs_cmd tcs_list[SDM845_MAX_VCD],
>>>>>>                             int n[SDM845_MAX_VCD])
>>>>>>     {
>>>>>> @@ -573,8 +588,8 @@ static void tcs_list_gen(struct list_head *bcm_list,
>>>>>>                            commit = true;
>>>>>>                            cur_vcd_size = 0;
>>>>>>                    }
>>>>>> -               tcs_cmd_gen(&tcs_list[idx], bcm->vote_x, bcm->vote_y,
>>>>>> -                           bcm->addr, commit);
>>>>>> +               tcs_cmd_gen(&tcs_list[idx], bcm->vote_x[bucket],
>>>>>> +                           bcm->vote_y[bucket], bcm->addr, commit);
>>>>>>                    idx++;
>>>>>>                    n[batch]++;
>>>>>>                    /*
>>>>>> @@ -595,32 +610,39 @@ static void tcs_list_gen(struct list_head *bcm_list,
>>>>>>
>>>>>>     static void bcm_aggregate(struct qcom_icc_bcm *bcm)
>>>>>>     {
>>>>>> -       size_t i;
>>>>>> -       u64 agg_avg = 0;
>>>>>> -       u64 agg_peak = 0;
>>>>>> +       size_t i, bucket;
>>>>>> +       u64 agg_avg[QCOM_ICC_NUM_BUCKETS] = {0};
>>>>>> +       u64 agg_peak[QCOM_ICC_NUM_BUCKETS] = {0};
>>>>>>            u64 temp;
>>>>>>
>>>>>> -       for (i = 0; i < bcm->num_nodes; i++) {
>>>>>> -               temp = bcm->nodes[i]->sum_avg * bcm->aux_data.width;
>>>>>> -               do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
>>>>>> -               agg_avg = max(agg_avg, temp);
>>>>>> +       for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
>>>>>> +               for (i = 0; i < bcm->num_nodes; i++) {
>>>>>> +                       temp = bcm->nodes[i]->sum_avg_cached[bucket] * bcm->aux_data.width;
>>>>>> +                       do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
>>>>>> +                       agg_avg[bucket] = max(agg_avg[bucket], temp);
>>>>>>
>>>>>> -               temp = bcm->nodes[i]->max_peak * bcm->aux_data.width;
>>>>>> -               do_div(temp, bcm->nodes[i]->buswidth);
>>>>> Why is it that this one doesn't have the multiply by
>>>>> bcm->nodes[i]->channels again? I can't recall if there was a reason.
>>>>> If it's correct maybe it deserves a comment.
>>>> I think the rationale behind this is generally for consumers to target a
>>>> certain minimum threshold to satisfy some structural latency
>>>> requirements as opposed to strictly throughput, and it may be easier for
>>>> consumers to reuse certain values to support hitting some minimum NoC
>>>> frequencies without having to be concerned with the number of channels
>>>> that may change from platform to platform.
>>> I was mostly pointing out that sum_avg seems to have the multiply, but
>>> max_peak does not. I would have expected those two things to be of the
>>> same units, and get the same treatment. Maybe the hardware is taking
>>> in different final units for that field, one that is per-channel and
>>> one that isn't?
>> The hardware isn't treating the values differently. I couldn't find any
>> justification other than the intuition mentioned above for the ease of
>> voting from the consumer perspective. The consumer would know that this
>> peak_bw value results in some floor performance from the system to
>> satisfy its latency requirements. The same approach would work if we
>> accounted for the number of channels as well, but given that channels
>> may vary from platform to platform or even on the same platform that
>> shares multiple channel configurations(DDR), it can be difficult for
>> consumers to keep track of and have to adjust their votes constantly(to
>> try to hit some frequency/latency requirement, this intuition doesn't
>> apply for avg_bw since we're concerned with throughput in that case).
>>
>>>>>> -               agg_peak = max(agg_peak, temp);
>>>>>> -       }
>>>>>> +                       temp = bcm->nodes[i]->max_peak_cached[bucket] * bcm->aux_data.width;
>>>>>> +                       do_div(temp, bcm->nodes[i]->buswidth);
>>>>>> +                       agg_peak[bucket] = max(agg_peak[bucket], temp);
>>>>>>
>>>>>> -       temp = agg_avg * 1000ULL;
>>>>>> -       do_div(temp, bcm->aux_data.unit);
>>>>>> -       bcm->vote_x = temp;
>>>>>> +                       bcm->nodes[i]->sum_avg[bucket] = 0;
>>>>>> +                       bcm->nodes[i]->max_peak[bucket] = 0;
>>>>> I don't understand the sum_avg vs sum_avg_cached. Here's what I understand:
>>>>> 1. qcom_icc_aggregate() does the math from the incoming values on
>>>>> sum_avg, and then clobbers sum_avg_cached with those values.
>>>>> 2. bcm_aggregate() uses sum_avg_cached in its calculations, then clears sum_avg.
>>>>>
>>>>> But I don't get why that's needed. Why not just have sum_avg? Wouldn't
>>>>> it work the same? Ok, it wouldn't if you ended up calling
>>>>> bcm_aggregate() multiple times on the same bcm. But you have a dirty
>>>>> flag that prevents this from happening. So I think it's safe to remove
>>>>> the cached arrays, and just clear out the sum_avg when you aggregate.
>>>> You are correct in that the dirty flag would prevent another repeat of
>>>> the bcm_aggregate() call in the same icc_set request. But consider a
>>>> following icc_set request on a different node that shares the same BCM,
>>>> the next bcm_aggregate() would result in an incorrect aggregate sum_avg
>>>> for the BCM since the avg_sum from the previous node(from the previous
>>>> icc_set) was cleared out. We need a way to retain the current state of
>>>> all nodes to accurately aggregate the bw values for the BCM.
>>> I don't get it. qcom_icc_aggregate() clobbers sum_avg_cached. So
>>> they're only ever a) equal, like after qcom_icc_aggregate(), or b)
>>> sum_avg is zeroed, and sum_avg_cached is its old value. A new
>>> icc_set_bw() would call aggregate_requests(), which would clobber
>>> sum_avg_cached to sum_avg for every BCM involved. Then the core would
>>> call apply_constraints(), then qcom_icc_set(), which would use
>>> sum_avg_cached, and clear out sum_avg, being sure with the dirty flag
>>> that bcm_aggregate() is only called once per BCM. This all happens
>>> under the mutex held in the core. A new request would start the whole
>>> thing over, since sum_avg is cleared. It seems to me that flow would
>>> work the same with one array as it does with two. Maybe you can walk
>>> me through a scenario?
>>> -Evan
>> Let's walk through the scenario you've just described with the
>> assumption that there's only one avg_sum value per node with two
>> icc_set_bw() requests on two different nodes(say 2MB for node 1 and 1MB
>> for node 2) under the same BCM(say BCM A). The first
>> qcom_icc_aggregate() aggregates to a 2MB avg_sum at the node1 followed
>> by apply_constraints(), qcom_icc_set(), bcm_aggregate() which causes BCM
>> A to aggregate to max(node1->avg_sum, node2->avg_sum) and reach a vote_x
>> of 2MB(for simplicity let's ignore unit). We then clear out
>> node1->avg_sum before we start the next icc_set_bw(). In the following
>> icc_set_bw(), the qcom_icc_aggregate() aggregates to 1MB in node2
>> followed by apply_constraints(), qcom_icc_set(), bcm_aggregate(), but
>> now incorrectly aggregates BCM A to 1MB by looking at
>> max(node1->avg_sum, node2->avg_sum) because node1->avg_sum was cleared
>> out when in reality BCM A should have a vote_x value of 2MB at this
>> point. The subsequent bcm_aggregate do not re-aggregate all of the
>> requests for each of its nodes, but assumes that the aggregated results
>> at the nodes are correct.
> Ah, I finally get it. Thanks for the detailed explanation. It's pretty
> confusing that there are essentially two connected graphs laid on top
> of each other, one graph consisting of nodes the framework deals with,
> and another graph that groups those nodes together into BCMs. I was
> failing to understand that bcm_aggregate loops over nodes that have
> nothing to do with the current request, and so it needs to remember
> the old totals from former requests. You've got the two arrays
> basically to differentiate between "add together all requests for this
> node", and "max all nodes into a BCM", since you need to reset sum_avg
> at the start of the first call to qcom_icc_aggregate().
Well it's not really two graphs since the BCMs aren't really connected 
to each other, they only have association with some groups of physical 
nodes that share a clock domain(There's some nuances here, but let's 
assume for the sake of simplicity). Their only job is to aggregate to 
some threshold value and select a performance point and they don't 
contain any information about the connectivity of the nodes.
> I had suggested a callback in the core earlier to tell the providers
> "I'm about to start aggregating on these nodes", which would have
> allowed you to clear sum_avg in that callback and reduce down to one
> array. IMO that's a lot easier to understand than these double arrays,
> but maybe it's just me that gets confused.
I do admit looking at this is somewhat confusing. I'm not totally 
against the idea of adding another callback in the framework, maybe we 
can re-evaluate this when there are other providers using the 
interconnect framework. I'd prefer to have the justification of needing 
additional ops in the core if somehow there's some hardware out there 
that dictates that we need some pre or post aggregation stage as opposed 
to easier book keeping? Though I do like the idea of reducing complexity 
overall, any thoughts on this Georgi?
>
> Why do we bother with the individual nodes at all, why don't we just
> build a graph out of the BCMs themselves and pass that to the
> framework? I guess you can't do that because of .channels and
> .bus_width, you wouldn't know what to multiply/divide by to translate
> to a vote value? Hm... it would be great to make this simpler, but I'm
> out of suggestions for now.

I appreciate the thought, but not only do the nodes provide the 
width/channel, they provide all the connectivity data and an accurate 
representation of the NoC topology. There's no way to aggregate the 
nodes and the paths properly if we lose out on the granularity that the 
current graph provides(Imagine the example of two nodes on some mutually 
exclusive path under the same BCM again using avg_bw, 1MBps on node1 and 
1MBps node2 should result in an aggregate BCM node of 1MBps since they 
physically don't share the same port where as if we clobbered the nodes 
together and represent them under a single BCM, it would suggest that 
they share the same physical port and aggregate 2MBps when in reality 
they don't need to be since they are parallel).

> -Evan
>
>>>>>> +               }
>>>>>>
>>>>>> -       temp = agg_peak * 1000ULL;
>>>>>> -       do_div(temp, bcm->aux_data.unit);
>>>>>> -       bcm->vote_y = temp;
>>>>>> +               temp = agg_avg[bucket] * 1000ULL;
>>>>>> +               do_div(temp, bcm->aux_data.unit);
>>>>>> +               bcm->vote_x[bucket] = temp;
>>>>>>
>>>>>> -       if (bcm->keepalive && bcm->vote_x == 0 && bcm->vote_y == 0) {
>>>>>> -               bcm->vote_x = 1;
>>>>>> -               bcm->vote_y = 1;
>>>>>> +               temp = agg_peak[bucket] * 1000ULL;
>>>>>> +               do_div(temp, bcm->aux_data.unit);
>>>>>> +               bcm->vote_y[bucket] = temp;
>>>>>> +       }
>>>>>> +
>>>>>> +       if (bcm->keepalive && bcm->vote_x[0] == 0 && bcm->vote_y[0] == 0) {
>>>>>> +               bcm->vote_x[QCOM_ICC_BUCKET_AMC] = 1;
>>>>>> +               bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = 1;
>>>>>> +               bcm->vote_y[QCOM_ICC_BUCKET_AMC] = 1;
>>>>>> +               bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = 1;
>>>>>>            }
>>>>>>
>>>>>>            bcm->dirty = false;
>>>>>> @@ -631,15 +653,25 @@ static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>>>>>>     {
>>>>>>            size_t i;
>>>>>>            struct qcom_icc_node *qn;
>>>>>> +       unsigned long tag_word = (unsigned long)tag;
>>>>>>
>>>>>>            qn = node->data;
>>>>>>
>>>>>> +       if (!tag)
>>>>>> +               tag_word = QCOM_ICC_TAG_ALWAYS;
>>>>>> +
>>>>>> +       for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
>>>>>> +               if (test_bit(i, &tag_word)) {
>>>>> I guess all this extra business with tag_word and casting is so that
>>>>> you can use test_bit, which is presumably a tiny bit faster? Does this
>>>>> actually make a measurable difference? Maybe in the name of simplicity
>>>>> we just do if (tag & BIT(i)), and then optimize if we find that
>>>>> conditional to be a hotspot?
>>>> Using (tag & BIT(i)) as opposed to test_bit seems reasonable to me.
>>>>>> +                       qn->sum_avg[i] += avg_bw;
>>>>>> +                       qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
>>>>>> +                       qn->sum_avg_cached[i] = qn->sum_avg[i];
>>>>>> +                       qn->max_peak_cached[i] = qn->max_peak[i];
>>>>>> +               }
>>>>>> +       }
>>>>>> +
>>>>>>            *agg_avg += avg_bw;
>>>>>>            *agg_peak = max_t(u32, *agg_peak, peak_bw);
>>>>>>
>>>>>> -       qn->sum_avg = *agg_avg;
>>>>>> -       qn->max_peak = *agg_peak;
>>>>>> -
>>>>>>            for (i = 0; i < qn->num_bcms; i++)
>>>>>>                    qn->bcms[i]->dirty = true;
>>>>>>
>>>>>> @@ -675,7 +707,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>>>>>             * Construct the command list based on a pre ordered list of BCMs
>>>>>>             * based on VCD.
>>>>>>             */
>>>>>> -       tcs_list_gen(&commit_list, cmds, commit_idx);
>>>>>> +       tcs_list_gen(&commit_list, QCOM_ICC_BUCKET_AMC, cmds, commit_idx);
>>>>>>
>>>>>>            if (!commit_idx[0])
>>>>>>                    return ret;
>>>>>> @@ -693,6 +725,41 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>>>>>                    return ret;
>>>>>>            }
>>>>>>
>>>>>> +       INIT_LIST_HEAD(&commit_list);
>>>>>> +
>>>>>> +       for (i = 0; i < qp->num_bcms; i++) {
>>>>>> +               /*
>>>>>> +                * Only generate WAKE and SLEEP commands if a resource's
>>>>>> +                * requirements change as the execution environment transitions
>>>>>> +                * between different power states.
>>>>>> +                */
>>>>>> +               if (qp->bcms[i]->vote_x[QCOM_ICC_BUCKET_WAKE] !=
>>>>>> +                   qp->bcms[i]->vote_x[QCOM_ICC_BUCKET_SLEEP] ||
>>>>>> +                   qp->bcms[i]->vote_y[QCOM_ICC_BUCKET_WAKE] !=
>>>>>> +                   qp->bcms[i]->vote_y[QCOM_ICC_BUCKET_SLEEP]) {
>>>>>> +                       list_add_tail(&qp->bcms[i]->list, &commit_list);
>>>>>> +               }
>>>>>> +       }
>>>>>> +
>>>>>> +       if (list_empty(&commit_list))
>>>>>> +               return ret;
>>>>>> +
>>>>>> +       tcs_list_gen(&commit_list, QCOM_ICC_BUCKET_WAKE, cmds, commit_idx);
>>>>>> +
>>>>>> +       ret = rpmh_write_batch(qp->dev, RPMH_WAKE_ONLY_STATE, cmds, commit_idx);
>>>>>> +       if (ret) {
>>>>>> +               pr_err("Error sending WAKE RPMH requests (%d)\n", ret);
>>>>>> +               return ret;
>>>>>> +       }
>>>>>> +
>>>>>> +       tcs_list_gen(&commit_list, QCOM_ICC_BUCKET_SLEEP, cmds, commit_idx);
>>>>>> +
>>>>>> +       ret = rpmh_write_batch(qp->dev, RPMH_SLEEP_STATE, cmds, commit_idx);
>>>>>> +       if (ret) {
>>>>>> +               pr_err("Error sending SLEEP RPMH requests (%d)\n", ret);
>>>>>> +               return ret;
>>>>>> +       }
>>>>>> +
>>>>>>            return ret;
>>>>>>     }
>>>>>>
>>>> --
>>>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>>>> a Linux Foundation Collaborative Project
>>>>
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

