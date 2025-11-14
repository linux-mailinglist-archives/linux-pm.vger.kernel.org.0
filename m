Return-Path: <linux-pm+bounces-38079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B4FC5F50A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 22:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C8C3B026C
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 21:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4782F2616;
	Fri, 14 Nov 2025 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PguP5WLl"
X-Original-To: linux-pm@vger.kernel.org
Received: from sonic313-20.consmr.mail.gq1.yahoo.com (sonic313-20.consmr.mail.gq1.yahoo.com [98.137.65.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1072FB99B
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154363; cv=none; b=ke4xy1sL/FHHP65hN55MY/z/lsMFBg3j+RX0bPrbkVtvlBOG2T1W8k+931Gy1Ki/ePP7Akah8S3zGl8VnUQ92AM65uwgTezkN2ysdR4wZlL6q4OeVn3RXUSn6gGTiNQfkCN7+3zBaWGHYyYn/2IQGMaFTlUdUJ50zshG/Ep41c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154363; c=relaxed/simple;
	bh=NxQbVphzjH3kG5rqQGKeRhHbzlvSvof1OH7huy9mWiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvBTq8txX2OnxvQAW4J/yrxbWIhxEUnHcHe8O6t2Ymh9JzqsKQOttCVOB3q3+sn/ilsmh01nljLGKtF1vHApw1AvL78L8AJNutu8gzWODkR51fzyQb7Cb5N27yCK1jPXWobyU7t2YhJ9u0SKOk87LvaiXhhnJ2SlVBKvYDuu7Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PguP5WLl; arc=none smtp.client-ip=98.137.65.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763154361; bh=J5zkoAWk2fSUHFYj/nLWKfl8bydtBpoFLd5+sT3bO9k=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PguP5WLljIR7oOu2Zc+6Jpi7yxhBR4gFyr/X4g60RqJ2lzS925wQlzfwTZC5F1I73KlzW1rFZN+6YDcGM5AZNk7JK6ct7sL9YaIThbwbJfk+0ycPdN7UmpMFMCci7MFPGDbWJPJ+NGr8MmorOSHbDoq8I6VMj43YYTVDOOIQv8HFG9hvOWpbm4W9MxvTazD0e2UUR+UuIT8tgsg0TDVm1eQB5eFXdh8psgiK8u5vYVJmx6gM/7QLXNWCwOi6e+q4V3AYqg6ZrBGhIR5EPzllssdTOyf+L5F/44Xuc++pdS8ho2EOP6pl+hFUuT85mop0Dhk1n5szSTYz2jb5ch86UQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763154361; bh=tGJ9WLkuxo1YdJzmUNMJKznExemdCql40MEzam+5+cz=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=EGRhEWuTU9ImfFaVuYS/ZQeU1/eC4oQtyqWlmB1cmUTIoR9ZJcygnllqv+oFIp7lCvbfuJoMYzHwFgl66/G41wtyuRTNIs04bIBEwqEgEFRphowu0oSoE77yuEBeN7W8+T5fZcoTi3jKXMVKCRE+gj64RNmAkQLR3bZX6x6QkkbpGcb9+KoKSjgr5Y01Oz1pJ48tYuxXkGf8j66kntzWtnB6wqOkUUJzdWCniErKO6MdHFqPis2b7u4xkzQv2UqOs3ex2uj4AHMV44jt9mqRwHmbCbGqhwpVnPWNwzLBHp+XmheA8X5W5a0Xh/QAhxxRxf5lMhHfvxnt1/RD1p1d1w==
X-YMail-OSG: dIpZZQ4VM1mjpQ8uKNS.8KYI0ogzaoS1z1VsDBKg0gtVijMZhcTBEcHefmkpgbx
 mHj2XtIxlcjGg0552_IX09ysABxzOqupMvDVgi78lztLbHiSnZXfPEKaxKTw5GliOYv8NQcEXxFq
 _PTfA48P9wHhA.FMxS5uQufs2N9HjwC1QkFf6q0VQvWUhxTu5ga4OEVOWCwyfWZMvm_Y6pxkwwuz
 LVzmZ2i_LtzhSHx1tCY.GwDfh3fITAqfk2JhVLet0W9iEoQl8gi_0DZOy3bTZpPIKdBofRafVAH5
 .5RKn2E2097eo09JA_Jv5775AYa4_BKzZktsIvOQx98pLr1nONc9WeVn5M.pynchNhXqmVN5Dwf_
 mOrKQ8DZsYdciXSK41RBSfDY4ATwxR0zboi28QIawesqucKs1hHKL6pX3ZC7GBQ3GPVCt_tGaxEe
 zpBzVjkJe2KsKb0kCQ4X6nOMAfwU82ffYATI4a3PcamxjgRbRvHaCd_hWqPoHcIX8Xm4gxodkzY.
 p7ZDGsw.YwHMRpqgvI5Bh6GKgSbpdse0xOdUJS4OUWefAy1cXIrffRURDeq34BGJOKdkn_bTM0B6
 z4mLjW5SPg.UDRgqtj6cAGuPv1Sr6fO1IhPv8MxQ5oG5pFQiwc9RSk8iJRM7C.y69e4DsAoLA4xC
 FJE1YmxNDwdiEaE689qmey1C6JXhnXPFaFvSCxvxeL3EuY0tuVeJw9NwHne9zmtHri0khhez51NB
 uA.Uvxzfyoo.6.d4_1QVpDZSOeiStPnOqSF0D1iYPPqCjhAZRNEw5KMNR8sM6xsPWe79lsWbrvHH
 Sl4RTIGu4.q_KlpdP7ESJy_tq8AznxujOyTKe.8eC4HFnXuH940IiJcjcMtzsgWkCVT1dH4LU579
 SGAhsC_ZcDNyiYL7Ntj1Zd9X37EGeTL1ZMnKfoRlg8YB5sWeizubnSU07MJcMXClkpr5kOI_A.xg
 Lf7CG_1W7Accv2wqBa6bXbYespy26mSXCV1Q01lo3fvgmQmvpAiuHZNXyBYfkeHAgSIONkEym7h2
 mViyG0.Tj0AZuxJqYd3vK5ZsPsFNrt7zHZzSe7vTUz5oAtsXQ0yTUhX7Tw83evHTGi9cWvPK2QY6
 knpvYsDRuNLjrRcTkJEw64_e5_iMzX8b7WxUXO4qX9AHTG2tDPVAfzAbfg_Qwj887lwE1sxPCJl_
 qNbUFV4HioJsA1xvVa4O6Ww43pMDcb2jTXkcD4uebWmBxNKCsKJb4ocCu_cbtXNNWDjnF7DrXNDt
 CgY4fWjzbfZ2QnwnGKrPvwizGRrA2fDuwIjNgTHElBwaZ1.D4dvNduS0ZwpVDwlVrkZIkFDHNcfl
 Lke3fBLDiugRZgekKCLWCxajiRaHOxqqSY_1aVqxAuK2G2Bggt338ftPOZn7WIwNWs0BQjo9uGk5
 XpdL2WbCWwS8rU5H5rpX.yP6tyMEHBPBfSGg6YhrMoSYoCJc9AroEN0skJzmfXYN6qLdz8ncA.k0
 Ham7pWeEGO5BgAMiqrK5yH0vMzyfhFRbX_gMlYsGO4.NCessBkzP.LwH7Cnu8h1wisOsIGabYvV9
 cIJ9ac_lVC5MIhpQYRV4WEoG7q8ot5P2SBbqzCMm33kKuJYWxN8KN3HegQSb5dJ2YhbH.P90n6un
 4LpGGTYUG0.RwiGMPX8oGarSXmtVK9EkcNydmVHqV1XtMT7RlfYWaXyBwYHtcydDXmUgPTQFwWEZ
 tRG4EmB4ZVxgsLlMhMv5dZLjjrc4ZEC_SiHYGvtEALv_jqEV079vZAS3svAzz3yDHJz.F9XHEsEd
 ZrP0UPV_ripb2Y9cHb2yPsIQFk1afACbIFZWF6x5RVMxUdO13pCwJVY90XquDJ35y3y7VIxJn8Mj
 8hl2NxWvjHDp8i3tg9fNaNRjOEg2ftWCoQN1_._NopsjndCOqy4jvNsFE26yk_w1KZDCzocNnc28
 4baFavorbEi05W0pF4jrIpbCawvmpzFQra1I8aW1t62VrL4aZ4W2LW0frx.P5HqwjZwhp5O9VpEW
 THzOHzCYGZdETyH3IQFdgIPK6SizlaronDreBMT9_pyaGwq5IP3dbFoRiMYdm.w_dzGMlXTK6LAz
 caDvRCVUVO0m0ViVw3ZKmfjXVVmzGohUy0vZQQKnVm80EWN6ZXVpHwSU.u4Z4IyUXMwycJ_RuYXS
 j_CxOEcX.Mqoqae5Zu_VB6jFAnawLXmLh1qX1uiC8ofr02Yu5EEv5XWaZjzPiaIOT8y8IgrtxNIp
 q9hVG5YwnjJ1FUfaytRb1DpZsw.JuPDkXePfPluNLS0z2IGuQGWvZU_b8r3w_RxLbnEclnf5.muH
 uSIXC.jcVzAH5WEKYM8nWvg--
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: ab96452b-2dad-4489-8923-e0027a5836e0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Fri, 14 Nov 2025 21:06:01 +0000
Received: by hermes--production-bf1-58477f5468-88dvg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a3ae0dcf8900a3d607578bf8cf31e95d;
          Fri, 14 Nov 2025 20:55:52 +0000 (UTC)
Message-ID: <cbe274c1-c462-4fce-80af-828e98a91e7b@yahoo.com>
Date: Fri, 14 Nov 2025 21:54:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] power: swap: Convert kernel-doc comments to regular
 block comments
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@kernel.org, lenb@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org
References: <20251113110914.44223-1-adelodunolaoluwa.ref@yahoo.com>
 <20251113110914.44223-1-adelodunolaoluwa@yahoo.com>
 <CAJZ5v0jEqNPPNE-5FuAm3Hd8YH1BecoOACoa6Sdr+VjHwBk9PA@mail.gmail.com>
Content-Language: en-US
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
In-Reply-To: <CAJZ5v0jEqNPPNE-5FuAm3Hd8YH1BecoOACoa6Sdr+VjHwBk9PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/14/25 17:37, Rafael J. Wysocki wrote:
> On Thu, Nov 13, 2025 at 12:31 PM Sunday Adelodun
> <adelodunolaoluwa@yahoo.com> wrote:
>> Several static functions in kernel/power/swap.c were using the kernel-doc
>> comment style (/** ... */) even though they are not exported or referenced
>> in generated documentation. This triggers documentation warnings and makes
>> the comments inconsistent with kernel style for local functions.
>>
>> Convert these comment blocks to regular C-style comments (/* ... */) and
>> update a few function headers to include proper "Return:" descriptions
>> where applicable.
>>
>> No functional changes.
>>
>> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
>> ---
>> changelog:
>>
>> changes from v1 to v2:
>> - Converted function comment blocks from /** */ to /* */ style for
>>    static functions
>> - Minor reformatting of comment indentation and spacing
>>
>> v1 patch link:
>> https://lore.kernel.org/all/20251106113938.34693-2-adelodunolaoluwa@yahoo.com/
>>
>>   kernel/power/swap.c | 54 ++++++++++++++++++++-------------------------
>>   1 file changed, 24 insertions(+), 30 deletions(-)
>>
>> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
>> index 0beff7eeaaba..076ed590e8c9 100644
>> --- a/kernel/power/swap.c
>> +++ b/kernel/power/swap.c
>> @@ -336,10 +336,8 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
>>    */
>>   unsigned int swsusp_header_flags;
>>
>> -/**
>> - *     swsusp_swap_check - check if the resume device is a swap device
>> - *     and get its index (if so)
>> - *
>> +/*
>> + *     check if the resume device is a swap device and get its index (if so).
>>    *     This is called before saving image
>>    */
> I'd move this comment (after the change above) into the function body
> (before the first statement) because the function does more than what
> is says.
>
>>   static int swsusp_swap_check(void)
>> @@ -362,11 +360,8 @@ static int swsusp_swap_check(void)
>>          return 0;
>>   }
>>
>> -/**
>> - *     write_page - Write one page to given swap location.
>> - *     @buf:           Address we're writing.
>> - *     @offset:        Offset of the swap page we're writing to.
>> - *     @hb:            bio completion batch
>> +/*
>> + *     Write one page to given swap location.
>>    */
> There is not much value in the comment after the change, please drop
> it altogether.
>
>>   static int write_page(void *buf, sector_t offset, struct hib_bio_batch *hb)
>> @@ -526,8 +521,8 @@ static int swap_writer_finish(struct swap_map_handle *handle,
>>   #define CMP_MIN_RD_PAGES       1024
>>   #define CMP_MAX_RD_PAGES       8192
>>
>> -/**
>> - *     save_image - save the suspend image data
>> +/*
>> + *     save the suspend image data
>>    */
> Same here.
>
>>   static int save_image(struct swap_map_handle *handle,
>> @@ -671,11 +666,8 @@ static int compress_threadfn(void *data)
>>          return 0;
>>   }
>>
>> -/**
>> - * save_compressed_image - Save the suspend image data after compression.
>> - * @handle: Swap map handle to use for saving the image.
>> - * @snapshot: Image to read data from.
>> - * @nr_to_write: Number of pages to save.
>> +/*
>> + * Save the suspend image data after compression.
>>    */
> Same here.
>
>>   static int save_compressed_image(struct swap_map_handle *handle,
>>                                   struct snapshot_handle *snapshot,
>> @@ -904,11 +896,8 @@ static int save_compressed_image(struct swap_map_handle *handle,
>>          return ret;
>>   }
>>
>> -/**
>> - *     enough_swap - Make sure we have enough swap to save the image.
>> - *
>> - *     Returns TRUE or FALSE after checking the total amount of swap
>> - *     space available from the resume partition.
>> +/*
>> + *     Make sure we have enough swap to save the image.
>>    */
> Same here.
>
>>   static int enough_swap(unsigned int nr_pages)
>> @@ -930,6 +919,8 @@ static int enough_swap(unsigned int nr_pages)
>>    *     them synced (in case something goes wrong) but we DO not want to mark
>>    *     filesystem clean: it is not. (And it does not matter, if we resume
>>    *     correctly, we'll mark system clean, anyway.)
>> + *
>> + *     Return: 0 on success, negative error code on failure.
>>    */
>>
> Please remove the empty line between the comment and the function definition.
>
>>   int swsusp_write(unsigned int flags)
>> @@ -1077,10 +1068,8 @@ static int swap_reader_finish(struct swap_map_handle *handle)
>>          return 0;
>>   }
>>
>> -/**
>> - *     load_image - load the image using the swap map handle
>> - *     @handle and the snapshot handle @snapshot
>> - *     (assume there are @nr_pages pages to load)
>> +/*
>> + *     load the image using the swap map handle
>>    */
>>
>>   static int load_image(struct swap_map_handle *handle,
>> @@ -1190,11 +1179,8 @@ static int decompress_threadfn(void *data)
>>          return 0;
>>   }
>>
>> -/**
>> - * load_compressed_image - Load compressed image data and decompress it.
>> - * @handle: Swap map handle to use for loading data.
>> - * @snapshot: Image to copy uncompressed data into.
>> - * @nr_to_read: Number of pages to load.
>> +/*
>> + * Load compressed image data and decompress it.
>>    */
> This comment is not too useful any more, please drop it.
>
>>   static int load_compressed_image(struct swap_map_handle *handle,
>>                                   struct snapshot_handle *snapshot,
>> @@ -1529,6 +1515,8 @@ static int load_compressed_image(struct swap_map_handle *handle,
>>    *     swsusp_read - read the hibernation image.
>>    *     @flags_p: flags passed by the "frozen" kernel in the image header should
>>    *               be written into this memory location
>> + *
>> + *     Return: 0 on success, negative error code on failure.
>>    */
>>
> Please remove the empty line between the comment and the function definition.
>
>>   int swsusp_read(unsigned int *flags_p)
>> @@ -1567,6 +1555,10 @@ static void *swsusp_holder;
>>   /**
>>    * swsusp_check - Open the resume device and check for the swsusp signature.
>>    * @exclusive: Open the resume device exclusively.
>> + *
>> + * Return:
>> + *     0 if a valid hibernation image is found,
>> + *     negative error code on failure.
> I think that the above can be one line, can't it?

Possibly. I will try compress it into a line.

>
>>    */
> Please remove the empty line between the comment and the function definition.
>
>>   int swsusp_check(bool exclusive)
>> @@ -1631,6 +1623,8 @@ void swsusp_close(void)
>>
>>   /**
>>    *      swsusp_unmark - Unmark swsusp signature in the resume device
>> + *
>> + *      Return: 0 on success, negative error code on failure.
>>    */
> Same here.
>
>>   #ifdef CONFIG_SUSPEND
>> --
> Thanks!
>
Thank you so much for the review and comments.
I will do accordingly and send v3.


