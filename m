Return-Path: <linux-pm+bounces-37649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3BEC4185A
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 21:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB40188E2E0
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 20:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E1C2F90CA;
	Fri,  7 Nov 2025 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lmkTtg7m"
X-Original-To: linux-pm@vger.kernel.org
Received: from sonic305-21.consmr.mail.gq1.yahoo.com (sonic305-21.consmr.mail.gq1.yahoo.com [98.137.64.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE712D5950
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546158; cv=none; b=ZEISmZZbkXT5REpFcqY9B6X0znzJQhVs6/gVa/y7zw8RjdZKzSrKgxvNMTX7xx3SPrRxdEI2pQFNJ30UutsCyXSW2tdVuhXxFNNs5MCSlCG6fC6nes+LqpjOAzaQ/a6g7zjyhGdmRC5foxCPm4B0xyYwBVrVjySuT8zfYSDvTMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546158; c=relaxed/simple;
	bh=UWfx/7BwQNH3j8cPP0S11614a4qK0dCjHdYzShAxzVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NC25/NjeQE1K37z1miSyIYZZJ0GZ9kgTwL05RfhQ8JO0+y98wkutjvwiT1Yv971DpYehZ2TVNe4dUvYx7J2Nv+SzbGf8U/wQz0biLC2GGhapLEnM1r71J04cSDMckimN6wkHzzs52lPInfDfzXx31UDtO3EKZ1ZsiFiOmuqv4Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=lmkTtg7m; arc=none smtp.client-ip=98.137.64.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762546150; bh=vhFGOofW87ZnM1elYSd0ouJbxgcTWuL9R6Zcr8pTcNU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=lmkTtg7m88gejR3VL968pnVfsZvMNm1Lf/Eght/Jq0bjX0Z98Jm5h/0hnBh29uPWsH2ulH4+W2WDDCcUjvbaox81WUB2qyqVYVehyEoRCiJbAbHpD5xBODio8qg+IYPp25erQNrXmxuxrFeKdm6h1PoEZ/sMkr+Ggi+doaSRQ05k7/yxyudtu/8imWJW0DUIV46q9E3NZYmMtnkwxMCStvNJQVDF+gxqxWZJYJGnU37e28YBulAvvPMwxsv4UFE5EuyekT1c28Vr7fJcbcMm5DPjLQmj4IM3Vo+q9H73bRz1gK9Vg3oMcYtAsnxbA4EsIvWK2R3hdX4BnOGw/5jLsw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762546150; bh=0VgasgcCb0CBnbJsJLmLiRrB8tGYt/dNYnde8fjHB7c=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Nic+v1aWSzYjuxA4WitRXEezvnfbEGSMP0VoaDDY8egiTtMNQW2bUDK2wwXm3mhcFaoC7KLTIFjSH4nkGeXik53YnB3U6wEX/SSTNlhuenCwXE2GCmivOZDj4EtjijtZys1VFSWh76gtf8govjUBTqDssr/c3GkrQUHfJtTlsVabMoqQ0R4pqxOXBBQmE07NpiffSJODZSRUV0zR35OsdUyxTJ//dG7iGcbZuLeEMfS4beUXMbdf2uf242HsNE4FCaUMm0mWKySqwdujBEuZo5BNjYRbPmLVzXoV3v9nWBAfclPeflQjmfesuvWyEf4i1F7BD3WWWEcXAW8u3xaSgQ==
X-YMail-OSG: vzWaKKEVM1mL_Aq2OC54LQtnn3f4i31BXCsGf8T433MHEkpu.s7yLgI6h0A3QyY
 03kJzn0GbZtLfM6AmEgugnzJoIFFRQ.Xtya_eKkglhwuALPdswc59FSypd9MOozUIhW0w4S._eGZ
 rnPqCprDgJGFUuO6Op4G6mTSjeI.W28QBTBYUvrDXDSEU79btAS5xI3Sk.jgBMlKUXEcntBG8Y3X
 UjVK8UiaFvf8IxvI58B8o0iuZOwMhh_4f4mKWXDAC0GxCoWW25Wfv5MnAeQeYt.OMa2RwXRlkSCo
 k.u_owz4KkOLw5VrPZdcc4UD5pffwH9k6Nj1PZzMeQjsUJhig6UjP.1Ut4ZBq3gcPhRhP1k2tIle
 IoA4poH5PEvnyLDlcmx_WLnJYgP7M8uxgin1I6Kp3VJXXKqUJ1dRRAsGrfUWPe5GwadC5QN9BCs6
 qT3fO2TozJS8AqOfJQ9xLniarrJD0OrLyGZ9ZIsdTjYPH6wRUtaQVB.AAqWdXDSYrZp8nwts_F1Y
 fK98BRKa0JPNozGaNiSjeqydGQYkG.sD_RT4Mp8VGusxpZ9hmoP2S8BkloR7mZrxPXEWhmT4BCME
 6LOKkhs8GGbDuczY33uKrvFCRxEwjBvqjWCiLAF7yPhFnf6LFl7QmSWRAhbSN_Tomy5x0EEdYj_Y
 fqK._uNDKACvgtgpZMjdp3OuiQfbdbW7lE5bOpwDOguEAO39ioGs.HZmhONWKr7X4qCotGz6LN0_
 IF.k5BRG_j0k6x7vWFpxuC.2.FsNlfVh3_alQ2qr1zrafUq8L.J7Y9ZDPfo8PI.R0Vwfmk4UGbBI
 0568Wai9KDs2KH4MD1LnyTeu1H2UMxODjHFZkX6psgJXxhiwHFkHUuQMnnOEv7QA9guQfnv8HLZs
 gW2VXvdwR_nEsKWrRVQrf5LPxiclw1ZjqsBVf_KdUWW4Pg.I8D.Y8d_XvM.hRAGCH609SHXCNZNt
 kF5CLw6tDL1vzNuUyVtOYET3Ju4N2HX2lsDvaw7Fjd7KzYghlUGkKusGoJb39Z2WoQ5JMx.Wzumo
 6sTfkCnQx.sZp0ZboQ9yXV5F7rNz_okANBiwMF9rgx8pXdUF_UPDfN2Xs1Du.gWozfDBEcoHs8TF
 135sdpk5Y6jVlyV3r5wJixw65d_K0RbZXelDtRxO3v0.fZ694G6vBqHBseeyUbFqiujBFfQxmzqC
 t.dSOIvpLgBcfNtKDXv25VIom9vlHQ.UEMomkpTBSs6XBjwLRv.dju.1k.NwF4yZPRViAxY0Yswq
 VWLiEhxz4NM3WVcRMzjWjkc8qoNvgeN_6HRMBD45E80rApof6oRJvGs9vCVGunPdqA_tjHFU7anU
 MPpyPR_glvmAGnG9as.lBsD.W9Saki05irEVWOVvuKh3TzcRkYFHx8eYbj3G6ZqIlo44pQpuqqYs
 g8we7FJKb2maN9SO_JquTxIQpdq__S6jIsx5Sicyet0r2ie1ZH7SdlaDtRF9gZVecAmyyGyMIQ0c
 iAa8xeYkg8_TrBt22HcUx_Cf1gGeusNKYPSDj_01C56FtQbIeCuZoB4cF7.gbCAL81dbNYCYjTWk
 yF_KJDkczzQZM5fk2z4I.b01XGlCRAdCyihY931s3jd496yyUsNGtRMKLc8PDQPt0Ds3EajOQ7rY
 ULsjsVGGXLRXmWRerrjQ5GjeiAMqr80UIxAW1pBtX3ATT0IBoCOHQ7xGNPinyeF8VAwznozuqYbD
 uSI.DMFp5CzSzpV8WAIKXY.izqm9QahZvdI47CtLlrsUe.k1Y7jt59hS2Qrm.HJfTaMZoGss0idE
 mrBi7Im8.fsXla1HgvEwVSUErzA0p8wRnag0Qmlu9DpcGirlEHxUjhD6o8YM1DqZCfTa4TK5HL.i
 uPRRS7E.7OrxeW9UCg9cWHnroIXgP89eQ96yR_JPSe67r_DD40pXqvcnzlNw4V8KycbeEulFFHnY
 VezlKs3GE8yeWqTfFo__MFSLBHjsASHmbSNj5Mhe4PEazt6NQNIizkvp_.rrO.uLTNFoZZjVmXUI
 etBHUrDIPyr9CgnNTikX1cjjcpaHidl_48VC5g2UrfK_nF2niSs_GYZL.7o908cBp_rQJYVx.0zK
 6tBGi9bWauI7pL3RNf23Q9xbGmf_IEnEHHtgiRGZtLFRvk6JBHO_h6yZFcaGQhkfmQvdQrqzEK1E
 lDD9XS.eq49_wZzFD_XasD3cZHRGhYXBEz8Lqe8OzkWMo2tZ3EsOCbrJFF3YyjYc_Mcqi4JtNf3Z
 Ib4uMS.L3ZXq1FL20pXLCmHFd_mGI.gF.idSdCFqWbWEdN6E56FkqKPDvGsi8yR9_7X4y9K46ghA
 zUWKVF17j3ZQz3Ps-
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 4eb599a7-f5c0-4528-ae08-e7fc4dbdd1c9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Fri, 7 Nov 2025 20:09:10 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-42rnm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID db3fe26fa3c9abe474c66d44c7cb4962;
          Fri, 07 Nov 2025 19:59:01 +0000 (UTC)
Message-ID: <b6f467c5-4a70-46a2-8497-1c351b3bfea9@yahoo.com>
Date: Fri, 7 Nov 2025 20:58:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] power/swap: add missing params and Return:
 descriptions to kernel-doc comments
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, pavel@kernel.org, anna-maria@linutronix.de,
 frederic@kernel.org, mingo@kernel.org, tglx@linutronix.de,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251106113938.34693-1-adelodunolaoluwa@yahoo.com>
 <20251106113938.34693-2-adelodunolaoluwa@yahoo.com>
 <CAJZ5v0gG3C4r-d+v2xGPqcF1Hn927NR7yBA7kLx4t6TjEo0rGA@mail.gmail.com>
Content-Language: en-US
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
In-Reply-To: <CAJZ5v0gG3C4r-d+v2xGPqcF1Hn927NR7yBA7kLx4t6TjEo0rGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/25 16:36, Rafael J. Wysocki wrote:
> On Thu, Nov 6, 2025 at 12:40 PM Sunday Adelodun
> <adelodunolaoluwa@yahoo.com> wrote:
>> Kernel-doc checks (scripts/kernel-doc) reported a number of warnings
>> for missing parameters and `Return:` descriptions in kernel/power/swap.c.
>> These missing return descriptions make the generated documentation
>> noisy and break doc-build when -Werror is used.
>>
>> Update the kernel-doc comment blocks to add explicit
>> Return: lines (and a few parameter tags where helpful) for the functions
>> that were triggering warnings. No functional code changes are made.
>>
>> Example warnings that motivated this change:
>>   - Warning: kernel/power/swap.c:535 No description found for return value
>>     of 'save_image'
>>   - Warning: kernel/power/swap.c:687 No description found for return value
>>    of 'save_compressed_image'
>>   - Warning: kernel/power/swap.c:941 No description found for return value
>>     of 'swsusp_write'
>>
>> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
> These comments need more changes to become proper kerneldocs and in
> some cases it is not even necessary because the functions in question
> are static.
>
> If the goal is to avoid warnings, why don't you change them all to
> non-kerneldoc regular comments?

Thank you very much for the feedback.

For the functions that are not static, could you please suggest the 
appropriate changes

needed to make their comments proper? I would like to improve them 
accordingly.

My initial goal was to address the warnings, but if converting them to 
regular comments

is the preferred approach, I will go ahead and update them that way in v2.

Thanks again for your guidance.

Best,
Sunday Adelodun

>
>> ---
>>   kernel/power/swap.c | 35 +++++++++++++++++++++++++++++++----
>>   1 file changed, 31 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
>> index 0beff7eeaaba..3f0df7a26bc3 100644
>> --- a/kernel/power/swap.c
>> +++ b/kernel/power/swap.c
>> @@ -341,6 +341,8 @@ unsigned int swsusp_header_flags;
>>    *     and get its index (if so)
>>    *
>>    *     This is called before saving image
>> + *
>> + *     Return: 0 on success, negative error code on failure.
>>    */
>>   static int swsusp_swap_check(void)
>>   {
>> @@ -367,6 +369,8 @@ static int swsusp_swap_check(void)
>>    *     @buf:           Address we're writing.
>>    *     @offset:        Offset of the swap page we're writing to.
>>    *     @hb:            bio completion batch
>> + *
>> + *     Return: 0 on success, negative error code on failure.
>>    */
>>
>>   static int write_page(void *buf, sector_t offset, struct hib_bio_batch *hb)
>> @@ -528,6 +532,11 @@ static int swap_writer_finish(struct swap_map_handle *handle,
>>
>>   /**
>>    *     save_image - save the suspend image data
>> + *     @handle: swap map handle for writing the image
>> + *     @snapshot: snapshot handle to read pages from
>> + *     @nr_to_write: number of pages to write
>> + *
>> + *     Return: 0 on success, negative error on failure
>>    */
>>
>>   static int save_image(struct swap_map_handle *handle,
>> @@ -676,6 +685,8 @@ static int compress_threadfn(void *data)
>>    * @handle: Swap map handle to use for saving the image.
>>    * @snapshot: Image to read data from.
>>    * @nr_to_write: Number of pages to save.
>> + *
>> + * Return: 0 on success, negative error code on failure.
>>    */
>>   static int save_compressed_image(struct swap_map_handle *handle,
>>                                   struct snapshot_handle *snapshot,
>> @@ -906,8 +917,9 @@ static int save_compressed_image(struct swap_map_handle *handle,
>>
>>   /**
>>    *     enough_swap - Make sure we have enough swap to save the image.
>> + *     @nr_pages: number of pages we need to save
>>    *
>> - *     Returns TRUE or FALSE after checking the total amount of swap
>> + *     Return: TRUE or FALSE after checking the total amount of swap
>>    *     space available from the resume partition.
>>    */
>>
>> @@ -930,6 +942,8 @@ static int enough_swap(unsigned int nr_pages)
>>    *     them synced (in case something goes wrong) but we DO not want to mark
>>    *     filesystem clean: it is not. (And it does not matter, if we resume
>>    *     correctly, we'll mark system clean, anyway.)
>> + *
>> + *     Return: 0 on success, negative error code on failure.
>>    */
>>
>>   int swsusp_write(unsigned int flags)
>> @@ -1078,9 +1092,12 @@ static int swap_reader_finish(struct swap_map_handle *handle)
>>   }
>>
>>   /**
>> - *     load_image - load the image using the swap map handle
>> - *     @handle and the snapshot handle @snapshot
>> - *     (assume there are @nr_pages pages to load)
>> + *     load_image - load the image using the swap map and snapshot handles
>> + *     @handle: pointer to the swap map used for reading swap pages
>> + *     @snapshot: pointer to the snapshot handle that tracks image pages
>> + *     @nr_to_read: number of pages to read from the snapshot
>> + *
>> + *     Return: 0 on success, negative error code on failure.
>>    */
>>
>>   static int load_image(struct swap_map_handle *handle,
>> @@ -1195,6 +1212,8 @@ static int decompress_threadfn(void *data)
>>    * @handle: Swap map handle to use for loading data.
>>    * @snapshot: Image to copy uncompressed data into.
>>    * @nr_to_read: Number of pages to load.
>> + *
>> + * Return: 0 on success, negative error code on failure.
>>    */
>>   static int load_compressed_image(struct swap_map_handle *handle,
>>                                   struct snapshot_handle *snapshot,
>> @@ -1529,6 +1548,8 @@ static int load_compressed_image(struct swap_map_handle *handle,
>>    *     swsusp_read - read the hibernation image.
>>    *     @flags_p: flags passed by the "frozen" kernel in the image header should
>>    *               be written into this memory location
>> + *
>> + *     Return: 0 on success, negative error code on failure.
>>    */
>>
>>   int swsusp_read(unsigned int *flags_p)
>> @@ -1567,6 +1588,10 @@ static void *swsusp_holder;
>>   /**
>>    * swsusp_check - Open the resume device and check for the swsusp signature.
>>    * @exclusive: Open the resume device exclusively.
>> + *
>> + * Return:
>> + *        0 if a valid hibernation image is found,
>> + *        negative error code on failure.
>>    */
>>
>>   int swsusp_check(bool exclusive)
>> @@ -1631,6 +1656,8 @@ void swsusp_close(void)
>>
>>   /**
>>    *      swsusp_unmark - Unmark swsusp signature in the resume device
>> + *
>> + *      Return: 0 on success, negative error code on failure.
>>    */
>>
>>   #ifdef CONFIG_SUSPEND
>> --
>> 2.43.0
>>


