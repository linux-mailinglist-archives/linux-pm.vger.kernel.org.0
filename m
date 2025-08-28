Return-Path: <linux-pm+bounces-33210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57629B39236
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 05:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EBE5E53EE
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 03:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3490D25784A;
	Thu, 28 Aug 2025 03:30:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B213957E;
	Thu, 28 Aug 2025 03:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756351802; cv=none; b=Nr6iu0f6a2G0pvmk2rPGmG2EUnblhouRYfjThX+Gd72lccaoFB6U9HV9DoeiqR2VTZg81cH0dRXZHkH2siuxyJZALEhG6hg6RR6+CUZJKSVTLQDty33bNKew6TLPhgJEMiQoelK267SNmORXbbQsQR7zq/EViA8qxRmA64/dLxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756351802; c=relaxed/simple;
	bh=lHFaAvpZr7nH8kSO24sSlS9OjnuV0iwDlY15ybNYjYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXZNeDCH1/cItZK8/x1GEvGr1TWvsLIzaMiZiGxUrQN3foWVDeWakbreJwMbKONXOE/910FV+E9Mj62e/1RXPQPvr77eWWJzWKQwDwF1R3n/jCBIK48vkQUS5zx2UAy4Qn+TaJ9Y3Q99XFcg8XWAl/5Q6cJUrmAm7iZv9NVgBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 42c32e8283bf11f0b29709d653e92f7d-20250828
X-CID-CACHE: Type:Local,Time:202508281128+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:03166cd5-4468-410d-8f87-8eef5ce37c8e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:14674371d732fcd9e1ba0c3b28f4ca8a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 42c32e8283bf11f0b29709d653e92f7d-20250828
X-User: luoxueqin@kylinos.cn
Received: from [10.42.13.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoxueqin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 865172055; Thu, 28 Aug 2025 11:29:53 +0800
Message-ID: <e0968be3-e33a-4e94-ab8f-215cdaa2be17@kylinos.cn>
Date: Thu, 28 Aug 2025 11:29:52 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: hibernate: make compression threads configurable via
 kernel parameter
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@kernel.org, lenb@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250826091937.991667-1-luoxueqin@kylinos.cn>
 <CAJZ5v0gD8RkKG8+6MneaDkxndS-oAm8a1AswEDP1w8HVCGZDdw@mail.gmail.com>
From: luoxueqin <luoxueqin@kylinos.cn>
In-Reply-To: <CAJZ5v0gD8RkKG8+6MneaDkxndS-oAm8a1AswEDP1w8HVCGZDdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/8/26 19:43, Rafael J. Wysocki 写道:
> On Tue, Aug 26, 2025 at 11:19 AM Xueqin Luo <luoxueqin@kylinos.cn> wrote:
>> A new kernel parameter 'cmp_threads=' is introduced to
>> allow tuning the number of compression/decompression threads at boot.
> And why is it useful/needed?
The number of compression/decompression threads directly impacts 
hibernate and resume time.
In our tests(averaged over 10 runs):
     cmp_threads   hibernate(s)   resume(s)
             3                           12.14          18.86
             4                           12.28          17.48
             5                           11.09          16.77
             6                           11.08          16.44
With 5–6 threads, resume latency improves by ~12% compared to 3 threads. 
But on low-core systems,
more threads may cause contention. Making it configurable allows 
integrators to balance performance
  and CPU usage across different hardware without recompiling the kernel.
>> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
>> ---
>>   kernel/power/swap.c | 22 +++++++++++++++++-----
>>   1 file changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
>> index ad13c461b657..43280e08a4ad 100644
>> --- a/kernel/power/swap.c
>> +++ b/kernel/power/swap.c
>> @@ -520,7 +520,8 @@ static int swap_writer_finish(struct swap_map_handle *handle,
>>   #define CMP_SIZE       (CMP_PAGES * PAGE_SIZE)
>>
>>   /* Maximum number of threads for compression/decompression. */
>> -#define CMP_THREADS    3
>> +#define CMP_MAX_THREADS        12
>> +static int cmp_threads = 3
>>
>>   /* Minimum/maximum number of pages for read buffering. */
>>   #define CMP_MIN_RD_PAGES       1024
>> @@ -585,8 +586,8 @@ struct crc_data {
>>          wait_queue_head_t go;                     /* start crc update */
>>          wait_queue_head_t done;                   /* crc update done */
>>          u32 *crc32;                               /* points to handle's crc32 */
>> -       size_t *unc_len[CMP_THREADS];             /* uncompressed lengths */
>> -       unsigned char *unc[CMP_THREADS];          /* uncompressed data */
>> +       size_t *unc_len[CMP_MAX_THREADS];             /* uncompressed lengths */
>> +       unsigned char *unc[CMP_MAX_THREADS];          /* uncompressed data */
>>   };
>>
>>   /*
>> @@ -703,7 +704,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
>>           * footprint.
>>           */
>>          nr_threads = num_online_cpus() - 1;
>> -       nr_threads = clamp_val(nr_threads, 1, CMP_THREADS);
>> +       nr_threads = clamp_val(nr_threads, 1, cmp_threads);
>>
>>          page = (void *)__get_free_page(GFP_NOIO | __GFP_HIGH);
>>          if (!page) {
>> @@ -1223,7 +1224,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
>>           * footprint.
>>           */
>>          nr_threads = num_online_cpus() - 1;
>> -       nr_threads = clamp_val(nr_threads, 1, CMP_THREADS);
>> +       nr_threads = clamp_val(nr_threads, 1, cmp_threads);
>>
>>          page = vmalloc(array_size(CMP_MAX_RD_PAGES, sizeof(*page)));
>>          if (!page) {
>> @@ -1667,3 +1668,14 @@ static int __init swsusp_header_init(void)
>>   }
>>
>>   core_initcall(swsusp_header_init);
>> +
>> +static int __init cmp_threads_setup(char *str)
>> +{
>> +       int rc = kstrtouint(str, 0, &cmp_threads);
>> +       if (rc)
>> +               return rc;
>> +       return 1;
>> +
>> +}
>> +
>> +__setup("cmp_threads=", cmp_threads_setup);
>> --
>> 2.43.0
>>

