Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD867279202
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 22:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIYUVt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 16:21:49 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:63553 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgIYUTq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 16:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601065185; x=1632601185;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=GHHDInrwsavPs8gmYpvoKhvNpX26ELB7NaKPCnphfu0=;
  b=XJv80MM1TutIWCcWsLrvBiW44khhJXzN1u2CJL4jNDq4kf0G4OfKsCwc
   Qp8CxMUeo/zf7O7cUfiyWrrGFYVhsPwDCD2y5+Hj9l8+V1bnhVN6PlcTW
   oX6AKYRM0x5YmNysEqpTMhZncMtObD3cY1KDnlbzL00rJCdXzMS4oF0vs
   g=;
X-IronPort-AV: E=Sophos;i="5.77,303,1596499200"; 
   d="scan'208";a="71193806"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 25 Sep 2020 19:26:15 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 00B42A209D;
        Fri, 25 Sep 2020 19:26:13 +0000 (UTC)
Received: from EX13D12UWA002.ant.amazon.com (10.43.160.88) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 25 Sep 2020 19:26:13 +0000
Received: from uba0035656cf856.ant.amazon.com (10.43.161.146) by
 EX13D12UWA002.ant.amazon.com (10.43.160.88) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 25 Sep 2020 19:26:13 +0000
From:   "Chen, Xiaoyi" <cxiaoyi@amazon.com>
Subject: Re: [PATCH] PM: Batch hibernate and resume IO requests
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Pavel Machek <pavel@ucw.cz>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Agarwal, Anchal" <anchalag@amazon.com>,
        "Duncan, David" <davdunc@amazon.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>
References: <cc09f36e506145399fe470c71ad34c7c@EX13D12UWA002.ant.amazon.com>
 <CAJZ5v0h-qmKcwis9GSa=ceBUMgkvq1s3XqchPotM_DH2=in6qA@mail.gmail.com>
Message-ID: <667ded38-06a6-d058-ca22-a53eed384fd4@amazon.com>
Date:   Fri, 25 Sep 2020 20:26:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h-qmKcwis9GSa=ceBUMgkvq1s3XqchPotM_DH2=in6qA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.146]
X-ClientProxiedBy: EX13D23UWA001.ant.amazon.com (10.43.160.68) To
 EX13D12UWA002.ant.amazon.com (10.43.160.88)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/25/20 4:27 PM, Rafael J. Wysocki wrote:
> 
> 
> On Tue, Sep 22, 2020 at 6:19 PM Chen, Xiaoyi <cxiaoyi@amazon.com> wrote:
>>
>>
>> Hibernate and resume process submits individual IO requests for each page
>> of the data. With this patch, we use blk_plug to improve the batching of
>> these requests.
>>
>> Tested this patch with hibernate and resumes, and consistently observed the
>> merging of the IO requests. We see more than an order of magnitude
>> improvement in hibernate and resume speed.
>>
>> One hibernate and resume cycle for 16GB used RAM out of 32GB takes around
>> 21 minutes before the change, and 1 minutes after the change on systems
>> with limited storage IOPS.
>>
>> Signed-off-by: Xiaoyi Chen <cxiaoyi@amazon.com>
>> Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
>> ---
>>   kernel/power/swap.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
>> index 01e2858b5fe3..961615365b5c 100644
>> --- a/kernel/power/swap.c
>> +++ b/kernel/power/swap.c
>> @@ -226,6 +226,7 @@ struct hib_bio_batch {
>>          atomic_t                count;
>>          wait_queue_head_t       wait;
>>          blk_status_t            error;
>> +       struct blk_plug         plug;
>>   };
>>
>>   static void hib_init_batch(struct hib_bio_batch *hb)
>> @@ -233,6 +234,12 @@ static void hib_init_batch(struct hib_bio_batch *hb)
>>          atomic_set(&hb->count, 0);
>>          init_waitqueue_head(&hb->wait);
>>          hb->error = BLK_STS_OK;
>> +       blk_start_plug(&hb->plug);
>> +}
>> +
>> +static void hib_finish_batch(struct hib_bio_batch *hb)
>> +{
>> +       blk_finish_plug(&hb->plug);
>>   }
>>
>>   static void hib_end_io(struct bio *bio)
>> @@ -294,6 +301,10 @@ static int hib_submit_io(int op, int op_flags, pgoff_t page_off, void *addr,
>>
>>   static blk_status_t hib_wait_io(struct hib_bio_batch *hb)
>>   {
>> +       /*
>> +        * We are relying on the behavior of blk_plug that a thread with
>> +        * a plug will flush the plug list before sleeping.
>> +        */
>>          wait_event(hb->wait, atomic_read(&hb->count) == 0);
>>          return blk_status_to_errno(hb->error);
>>   }
>> @@ -561,6 +572,7 @@ static int save_image(struct swap_map_handle *handle,
>>                  nr_pages++;
>>          }
>>          err2 = hib_wait_io(&hb);
>> +       hib_finish_batch(&hb);
>>          stop = ktime_get();
>>          if (!ret)
>>                  ret = err2;
>> @@ -854,6 +866,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
>>                  pr_info("Image saving done\n");
>>          swsusp_show_speed(start, stop, nr_to_write, "Wrote");
>>   out_clean:
>> +       hib_finish_batch(&hb);
>>          if (crc) {
>>                  if (crc->thr)
>>                          kthread_stop(crc->thr);
>> @@ -1084,6 +1097,7 @@ static int load_image(struct swap_map_handle *handle,
>>                  nr_pages++;
>>          }
>>          err2 = hib_wait_io(&hb);
>> +       hib_finish_batch(&hb);
>>          stop = ktime_get();
>>          if (!ret)
>>                  ret = err2;
>> @@ -1447,6 +1461,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
>>          }
>>          swsusp_show_speed(start, stop, nr_to_read, "Read");
>>   out_clean:
>> +       hib_finish_batch(&hb);
>>          for (i = 0; i < ring_size; i++)
>>                  free_page((unsigned long)page[i]);
>>          if (crc) {
>> --
> 
> Applied as 5.10 material with some subject and changelog edits, but:
> 1. The patch is white-space-damaged and I needed to fix that up
> manually which was not fun.
> 2. I dropped the second S-o-b, because it was not clear to me whether
> a Co-developed-by tag was missing or Reviewed-by should have been used
> instead.
> 
> Thanks!
> 

Thanks for the prompt review. Apologies for the white-space and tags
issues, will do better next time.

Would you mind adding following tags if not too late?
Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Co-Developed-by: Anchal Agarwal <anchalag@amazon.com>
