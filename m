Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D443561E28
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 16:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbiF3OgX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 10:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbiF3Of6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 10:35:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9086533EB7;
        Thu, 30 Jun 2022 07:26:09 -0700 (PDT)
X-UUID: 4cc7291b5aad47219af0f4938229d514-20220630
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:26cb28e9-1fbd-496c-97f6-e311198fbda3,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:87442a2,CLOUDID:44891263-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 4cc7291b5aad47219af0f4938229d514-20220630
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <peter.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1152749598; Thu, 30 Jun 2022 22:26:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 30 Jun 2022 22:26:04 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 30 Jun 2022 22:26:04 +0800
Subject: Re: [PATCH v1] PM-runtime: Check supplier_preactivated before release
 supplier
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220613120755.14306-1-peter.wang@mediatek.com>
 <b55d5691-0b2d-56bb-26ff-dcac56770611@mediatek.com>
 <CAJZ5v0gTpv2gt_Gm9rUd+8Jmp4=ij2=J20o7qO0sC-hm=w3=_A@mail.gmail.com>
 <12028598.O9o76ZdvQC@kreacher>
From:   Peter Wang <peter.wang@mediatek.com>
Message-ID: <90b5f619-2dd6-817b-fe2d-f895be0b5b98@mediatek.com>
Date:   Thu, 30 Jun 2022 22:26:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <12028598.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 6/30/22 12:01 AM, Rafael J. Wysocki wrote:
> [Add CCs to linix-pm, LKML and Greg]
>
> On Wednesday, June 29, 2022 5:32:00 PM CEST Rafael J. Wysocki wrote:
>> On Wed, Jun 29, 2022 at 4:47 PM Peter Wang <peter.wang@mediatek.com> wrote:
>>>
>>> On 6/29/22 9:22 PM, Rafael J. Wysocki wrote:
>>>> On Wed, Jun 29, 2022 at 5:02 AM Peter Wang <peter.wang@mediatek.com> wrote:
>>>>> On 6/28/22 11:54 PM, Rafael J. Wysocki wrote:
>>>>>> On Tue, Jun 28, 2022 at 3:53 AM Peter Wang <peter.wang@mediatek.com> wrote:
>>>>>>> On 6/28/22 3:00 AM, Rafael J. Wysocki wrote:
>>>>>>>> On Mon, Jun 13, 2022 at 2:08 PM <peter.wang@mediatek.com> wrote:
>>>>>>>>> From: Peter Wang <peter.wang@mediatek.com>
>>>>>>>>>
>>>>>>>>> With divice link of DL_FLAG_PM_RUNTIME, if consumer call pm_runtime_get_suppliers
>>>>>>>>> to prevent supplier enter suspend, pm_runtime_release_supplier should
>>>>>>>>> check supplier_preactivated before let supplier enter suspend.
>>>>>>>> Why?
>>>>>>> because supplier_preactivated is true means supplier cannot enter
>>>>>>> suspend, right?
>>>>>> No, it doesn't mean that.
>>>>> Hi Rafael,
>>>>>
>>>>> if supplier_preactivated is true, means someone call
>>>>> pm_runtime_get_suppliers and
>>>>> before pm_runtime_put_suppliers right? This section suppliers should not
>>>>> enter suspend.
>>>> No, this is not how this is expected to work.
>>>>
>>>> First off, the only caller of pm_runtime_get_suppliers() and
>>>> pm_runtime_put_suppliers() is __driver_probe_device().  Really nobody
>>>> else has any business that would require calling them.
>>> Hi Rafael,
>>>
>>> Yes, you are right!
>>> __driver_probe_device the only one use and just because
>>> __driver_probe_device use
>>> pm_runtime_get_suppliers cause problem.
>>>
>>>
>>>> Second, the role of pm_runtime_get_suppliers() is to "preactivate" the
>>>> suppliers before running probe for a consumer device and the role of
>>> the role of pm_runtime_get_suppliers() is to "preactivate" the suppliers,
>>> but suppliers may suspend immediately after preactivate right?
>>> Here is just this case. this is first racing point.
>>> Thread A: pm_runtime_get_suppliers                -> __driver_probe_device
>>> Thread B: pm_runtime_release_supplier
>>> Thread A: Run with supplier not preactivate      -> __driver_probe_device
>>>
>>>> pm_runtime_put_suppliers() is to do the cleanup in case the device is
>>>> left in suspend after probing.
>>>>
>>>> IOW, pm_runtime_get_suppliers() is to ensure that the suppliers will
>>>> be active until the probe callback takes over and the rest depends on
>>>> that callback.
>>> The problem of this racing will finally let consumer is active but
>>> supplier is suspended.
>> So it would be better to send a bug report regarding this.
>>
>>> The link relation is broken.
>>> I know you may curious how it happened? right?
>>> Honestly, I am not sure, but I think the second racing point
>>> is rpm_get_suppliers and pm_runtime_put_suppliers(release rpm_active).
>> I'm not sure what you mean by "the racing point".
>>
>> Yes, these functions can run concurrently.
>>
>>> So, I try to fix the first racing point and the problem is gone.
>>> It is full meet expect, and the pm runtime will work smoothly after
>>> __driver_probe_device done.
>> I'm almost sure that there is at least one scenario that would be
>> broken by this change.
> That said, the code in there may be a bit overdesigned.
>
> Does the patch below help?
>
> ---
>   drivers/base/power/runtime.c |   14 +-------------
>   1 file changed, 1 insertion(+), 13 deletions(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -1768,7 +1768,6 @@ void pm_runtime_get_suppliers(struct dev
>   		if (link->flags & DL_FLAG_PM_RUNTIME) {
>   			link->supplier_preactivated = true;
>   			pm_runtime_get_sync(link->supplier);
> -			refcount_inc(&link->rpm_active);
>   		}
>   
>   	device_links_read_unlock(idx);
> @@ -1788,19 +1787,8 @@ void pm_runtime_put_suppliers(struct dev
>   	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
>   				device_links_read_lock_held())
>   		if (link->supplier_preactivated) {
> -			bool put;
> -
>   			link->supplier_preactivated = false;
> -
> -			spin_lock_irq(&dev->power.lock);
> -
> -			put = pm_runtime_status_suspended(dev) &&
> -			      refcount_dec_not_one(&link->rpm_active);
> -
> -			spin_unlock_irq(&dev->power.lock);
> -
> -			if (put)
> -				pm_runtime_put(link->supplier);
> +			pm_runtime_put(link->supplier);
>   		}
>   
>   	device_links_read_unlock(idx);


Hi Rafael,

I think this patch solve the rpm_active racing problem.
But it still have problem that
pm_runtime_get_suppliers call pm_runtime_get_sync(link->supplier)
and supplier could suspend immediately by other thread who call
pm_runtime_release_supplier.

Thanks.
Peter


>
>
