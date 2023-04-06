Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B074C6D8CB4
	for <lists+linux-pm@lfdr.de>; Thu,  6 Apr 2023 03:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjDFBW5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 5 Apr 2023 21:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbjDFBW4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Apr 2023 21:22:56 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A64D7A9A
        for <linux-pm@vger.kernel.org>; Wed,  5 Apr 2023 18:22:53 -0700 (PDT)
X-UUID: 9116fc13b7744194b26ed1edca58857a-20230406
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:35e1d1e5-60b8-4c2c-bc9f-f268f544711b,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:6
X-CID-INFO: VERSION:1.1.22,REQID:35e1d1e5-60b8-4c2c-bc9f-f268f544711b,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:6
X-CID-META: VersionHash:120426c,CLOUDID:076754b5-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:2304041533111BWCQ2IZ,BulkQuantity:3,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 9116fc13b7744194b26ed1edca58857a-20230406
Received: from node4.com.cn [(39.156.73.12)] by mailgw
        (envelope-from <xiongxin@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1006449599; Thu, 06 Apr 2023 09:22:46 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
        by node4.com.cn (NSMail) with SMTP id 0D8F016002C00;
        Thu,  6 Apr 2023 09:22:46 +0800 (CST)
X-ns-mid: postfix-642E1EE5-96122835
Received: from [172.20.116.203] (unknown [172.20.116.203])
        by node4.com.cn (NSMail) with ESMTPA id 83D7B16002C00;
        Thu,  6 Apr 2023 01:22:45 +0000 (UTC)
Message-ID: <4cfb3dd3-e564-49ff-aad8-ee4d8587b689@kylinos.cn>
Date:   Thu, 6 Apr 2023 09:22:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] powercap: intel_rapl: Optimize rp->domains memory
 allocation
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org
References: <20230404083656.713825-1-xiongxin@kylinos.cn>
 <CAJZ5v0g+yrmCH0o2-ezCNmoXe24ooA4U-JAWD4xNXsjT9XBwyQ@mail.gmail.com>
From:   TGSP <xiongxin@kylinos.cn>
In-Reply-To: <CAJZ5v0g+yrmCH0o2-ezCNmoXe24ooA4U-JAWD4xNXsjT9XBwyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

在 2023/4/5 00:30, Rafael J. Wysocki 写道:
> On Tue, Apr 4, 2023 at 10:37 AM xiongxin <xiongxin@kylinos.cn> wrote:
>>
>> In the memory allocation of rp->domains in rapl_detect_domains(), there
>> is an additional memory of struct rapl_domain allocated to prevent the
>> pointer out of bounds called later.
>>
>> Optimize the code here to save sizeof(struct rapl_domain) bytes of
>> memory.
>>
>> Test in Intel NUC (i5-1135G7).
>>
>> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
>> Tested-by: xiongxin <xiongxin@kylinos.cn>
>> ---
>>   drivers/powercap/intel_rapl_common.c | 15 ++++++++-------
>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
>> index 8970c7b80884..f8971282498a 100644
>> --- a/drivers/powercap/intel_rapl_common.c
>> +++ b/drivers/powercap/intel_rapl_common.c
>> @@ -1171,13 +1171,14 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
>>   {
>>          struct rapl_domain *rd;
>>          struct powercap_zone *power_zone = NULL;
>> -       int nr_pl, ret;
>> +       int nr_pl, ret, i;
>>
>>          /* Update the domain data of the new package */
>>          rapl_update_domain_data(rp);
>>
>>          /* first we register package domain as the parent zone */
>> -       for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
>> +       for (i = 0; i < rp->nr_domains; i++) {
>> +               rd = &rp->domains[i];
>>                  if (rd->id == RAPL_DOMAIN_PACKAGE) {
>>                          nr_pl = find_nr_power_limit(rd);
>>                          pr_debug("register package domain %s\n", rp->name);
>> @@ -1201,8 +1202,9 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
>>                  return -ENODEV;
>>          }
>>          /* now register domains as children of the socket/package */
>> -       for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
>> +       for (i = 0; i < rp->nr_domains; i++) {
>>                  struct powercap_zone *parent = rp->power_zone;
>> +               rd = &rp->domains[i];
>>
>>                  if (rd->id == RAPL_DOMAIN_PACKAGE)
>>                          continue;
>> @@ -1302,7 +1304,6 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
>>    */
>>   static int rapl_detect_domains(struct rapl_package *rp, int cpu)
>>   {
>> -       struct rapl_domain *rd;
>>          int i;
>>
>>          for (i = 0; i < RAPL_DOMAIN_MAX; i++) {
>> @@ -1319,15 +1320,15 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
>>          }
>>          pr_debug("found %d domains on %s\n", rp->nr_domains, rp->name);
>>
>> -       rp->domains = kcalloc(rp->nr_domains + 1, sizeof(struct rapl_domain),
>> +       rp->domains = kcalloc(rp->nr_domains, sizeof(struct rapl_domain),
>>                                GFP_KERNEL);
> 
> Why can't you modify just the above statement alone?  What would break
> if you did that?
At the beginning, I just didn't understand what this '+1' was for, but
contacting the for loop behind, here '+1', just because the rd pointer
will not point outside the memory of 'rp->domains' before the for loop
exits.

if '+1' is to prevent the invalidation of the rd pointer, and apply for
an additional struct rapl_domains here, then my patch may not be 
completely modified.

> 
>>          if (!rp->domains)
>>                  return -ENOMEM;
>>
>>          rapl_init_domains(rp);
>>
>> -       for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++)
>> -               rapl_detect_powerlimit(rd);

If '+1' is directly removed, before the for loop exits, the rd pointer 
has already pointed to outside the memory of rp->domains.

>> +       for (i = 0; i < rp->nr_domains; i++)
>> +               rapl_detect_powerlimit(&rp->domains[i]);
>>
>>          return 0;
>>   }
>> --
>> 2.34.1
>>

