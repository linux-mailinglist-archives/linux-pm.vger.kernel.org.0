Return-Path: <linux-pm+bounces-15775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5629A0CEB
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 16:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498BD283BF9
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 14:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DAD20C008;
	Wed, 16 Oct 2024 14:39:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE426156225;
	Wed, 16 Oct 2024 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089593; cv=none; b=nvym71o0dMy2WsfUf19HGf7hGK6Bcrzbg7zxqn7UzSsxTib8FqQx6CzGmiWCi/Qg+D71mqV7GvXcSYI7lKPdMKGvM7LH0O2bnKegQBDIxw5Dl71cM/yVHW8Mlp56xXy94u3lE2MsV3pOY/mIKfKB0a4QPLbVUbypyWZgo8quIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089593; c=relaxed/simple;
	bh=L582LjD+0pZ8yV200KKoH79nl/ZsEIKpXDIERyP81dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ssmhOts9KzxHXRfECEvN349l9VK7/UpNXOcFjScwtvHgi0iDp4ZgUUDuShuO4MGCgv8Sy5Rb/Nr4d3MHWKKTFdI/VbLsuDsV8yj59RJPYnuKWvStU1hZe6+VE3oChTOUsesdXesrqu5UorwU+dWmat1W/3tp1FXSieJVmh87VJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9F6AFEC;
	Wed, 16 Oct 2024 07:40:20 -0700 (PDT)
Received: from [10.1.28.177] (XHFQ2J9959.cambridge.arm.com [10.1.28.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFFEE3F71E;
	Wed, 16 Oct 2024 07:39:47 -0700 (PDT)
Message-ID: <dd7b7268-7e75-4ec9-9a17-f5fdb325dd2e@arm.com>
Date: Wed, 16 Oct 2024 15:39:46 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 14/57] pm/hibernate: Remove PAGE_SIZE compile-time
 constant assumption
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-14-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241014105912.3207374-14-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Rafael J. Wysocki, Len Brown, Pavel Machek

This was a rather tricky series to get the recipients correct for and my script
did not realize that "supporter" was a pseudonym for "maintainer" so you were
missed off the original post. Appologies!

More context in cover letter:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/


On 14/10/2024 11:58, Ryan Roberts wrote:
> To prepare for supporting boot-time page size selection, refactor code
> to remove assumptions about PAGE_SIZE being compile-time constant. Code
> intended to be equivalent when compile-time page size is active.
> 
> "struct linked_page", "struct swap_map_page" and "struct swsusp_header"
> were all previously sized to be exactly PAGE_SIZE. Refactor those
> structures to remove the padding, then superimpose them on a page at
> runtime.
> 
> "struct cmp_data" and "struct dec_data" previously contained embedded
> "unc" and "cmp" arrays, who's sizes were derived from PAGE_SIZE. We
> can't use flexible array approach here since there are 2 arrays in the
> structure, so convert to pointers and define an allocator and
> deallocator for each struct.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>  kernel/power/power.h    |   2 +-
>  kernel/power/snapshot.c |   2 +-
>  kernel/power/swap.c     | 129 +++++++++++++++++++++++++++++++++-------
>  3 files changed, 108 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index de0e6b1077f23..74af2eb8d48a4 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -16,7 +16,7 @@ struct swsusp_info {
>  	unsigned long		image_pages;
>  	unsigned long		pages;
>  	unsigned long		size;
> -} __aligned(PAGE_SIZE);
> +} __aligned(PAGE_SIZE_MAX);
>  
>  #ifdef CONFIG_HIBERNATION
>  /* kernel/power/snapshot.c */
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 405eddbda4fc5..144e92f786e35 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -155,7 +155,7 @@ struct pbe *restore_pblist;
>  
>  struct linked_page {
>  	struct linked_page *next;
> -	char data[LINKED_PAGE_DATA_SIZE];
> +	char data[];
>  } __packed;
>  
>  /*
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 82b884b67152f..ffd4c864acfa2 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -59,6 +59,7 @@ static bool clean_pages_on_decompress;
>   */
>  
>  #define MAP_PAGE_ENTRIES	(PAGE_SIZE / sizeof(sector_t) - 1)
> +#define NEXT_SWAP_INDEX		MAP_PAGE_ENTRIES
>  
>  /*
>   * Number of free pages that are not high.
> @@ -78,8 +79,11 @@ static inline unsigned long reqd_free_pages(void)
>  }
>  
>  struct swap_map_page {
> -	sector_t entries[MAP_PAGE_ENTRIES];
> -	sector_t next_swap;
> +	/*
> +	 * A PAGE_SIZE structure with (PAGE_SIZE / sizeof(sector_t)) entries.
> +	 * The last entry, [NEXT_SWAP_INDEX], is `.next_swap`.
> +	 */
> +	sector_t entries[1];
>  };
>  
>  struct swap_map_page_list {
> @@ -103,8 +107,6 @@ struct swap_map_handle {
>  };
>  
>  struct swsusp_header {
> -	char reserved[PAGE_SIZE - 20 - sizeof(sector_t) - sizeof(int) -
> -	              sizeof(u32) - sizeof(u32)];
>  	u32	hw_sig;
>  	u32	crc32;
>  	sector_t image;
> @@ -113,6 +115,7 @@ struct swsusp_header {
>  	char	sig[10];
>  } __packed;
>  
> +static char *swsusp_header_pg;
>  static struct swsusp_header *swsusp_header;
>  
>  /*
> @@ -315,7 +318,7 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
>  {
>  	int error;
>  
> -	hib_submit_io(REQ_OP_READ, swsusp_resume_block, swsusp_header, NULL);
> +	hib_submit_io(REQ_OP_READ, swsusp_resume_block, swsusp_header_pg, NULL);
>  	if (!memcmp("SWAP-SPACE",swsusp_header->sig, 10) ||
>  	    !memcmp("SWAPSPACE2",swsusp_header->sig, 10)) {
>  		memcpy(swsusp_header->orig_sig,swsusp_header->sig, 10);
> @@ -329,7 +332,7 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
>  		if (flags & SF_CRC32_MODE)
>  			swsusp_header->crc32 = handle->crc32;
>  		error = hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
> -				      swsusp_resume_block, swsusp_header, NULL);
> +				      swsusp_resume_block, swsusp_header_pg, NULL);
>  	} else {
>  		pr_err("Swap header not found!\n");
>  		error = -ENODEV;
> @@ -466,7 +469,7 @@ static int swap_write_page(struct swap_map_handle *handle, void *buf,
>  		offset = alloc_swapdev_block(root_swap);
>  		if (!offset)
>  			return -ENOSPC;
> -		handle->cur->next_swap = offset;
> +		handle->cur->entries[NEXT_SWAP_INDEX] = offset;
>  		error = write_page(handle->cur, handle->cur_swap, hb);
>  		if (error)
>  			goto out;
> @@ -643,8 +646,8 @@ struct cmp_data {
>  	wait_queue_head_t done;                   /* compression done */
>  	size_t unc_len;                           /* uncompressed length */
>  	size_t cmp_len;                           /* compressed length */
> -	unsigned char unc[UNC_SIZE];              /* uncompressed buffer */
> -	unsigned char cmp[CMP_SIZE];              /* compressed buffer */
> +	unsigned char *unc;                       /* uncompressed buffer */
> +	unsigned char *cmp;                       /* compressed buffer */
>  };
>  
>  /* Indicates the image size after compression */
> @@ -683,6 +686,45 @@ static int compress_threadfn(void *data)
>  	return 0;
>  }
>  
> +static void free_cmp_data(struct cmp_data *data, unsigned nr_threads)
> +{
> +	int i;
> +
> +	if (!data)
> +		return;
> +
> +	for (i = 0; i < nr_threads; i++) {
> +		vfree(data[i].unc);
> +		vfree(data[i].cmp);
> +	}
> +
> +	vfree(data);
> +}
> +
> +static struct cmp_data *alloc_cmp_data(unsigned nr_threads)
> +{
> +	struct cmp_data *data = NULL;
> +	int i = -1;
> +
> +	data = vzalloc(array_size(nr_threads, sizeof(*data)));
> +	if (!data)
> +		goto fail;
> +
> +	for (i = 0; i < nr_threads; i++) {
> +		data[i].unc = vzalloc(UNC_SIZE);
> +		if (!data[i].unc)
> +			goto fail;
> +		data[i].cmp = vzalloc(CMP_SIZE);
> +		if (!data[i].cmp)
> +			goto fail;
> +	}
> +
> +	return data;
> +fail:
> +	free_cmp_data(data, nr_threads);
> +	return NULL;
> +}
> +
>  /**
>   * save_compressed_image - Save the suspend image data after compression.
>   * @handle: Swap map handle to use for saving the image.
> @@ -724,7 +766,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
>  		goto out_clean;
>  	}
>  
> -	data = vzalloc(array_size(nr_threads, sizeof(*data)));
> +	data = alloc_cmp_data(nr_threads);
>  	if (!data) {
>  		pr_err("Failed to allocate %s data\n", hib_comp_algo);
>  		ret = -ENOMEM;
> @@ -902,7 +944,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
>  			if (data[thr].cc)
>  				crypto_free_comp(data[thr].cc);
>  		}
> -		vfree(data);
> +		free_cmp_data(data, nr_threads);
>  	}
>  	if (page) free_page((unsigned long)page);
>  
> @@ -1036,7 +1078,7 @@ static int get_swap_reader(struct swap_map_handle *handle,
>  			release_swap_reader(handle);
>  			return error;
>  		}
> -		offset = tmp->map->next_swap;
> +		offset = tmp->map->entries[NEXT_SWAP_INDEX];
>  	}
>  	handle->k = 0;
>  	handle->cur = handle->maps->map;
> @@ -1150,8 +1192,8 @@ struct dec_data {
>  	wait_queue_head_t done;                   /* decompression done */
>  	size_t unc_len;                           /* uncompressed length */
>  	size_t cmp_len;                           /* compressed length */
> -	unsigned char unc[UNC_SIZE];              /* uncompressed buffer */
> -	unsigned char cmp[CMP_SIZE];              /* compressed buffer */
> +	unsigned char *unc;                       /* uncompressed buffer */
> +	unsigned char *cmp;                       /* compressed buffer */
>  };
>  
>  /*
> @@ -1189,6 +1231,45 @@ static int decompress_threadfn(void *data)
>  	return 0;
>  }
>  
> +static void free_dec_data(struct dec_data *data, unsigned nr_threads)
> +{
> +	int i;
> +
> +	if (!data)
> +		return;
> +
> +	for (i = 0; i < nr_threads; i++) {
> +		vfree(data[i].unc);
> +		vfree(data[i].cmp);
> +	}
> +
> +	vfree(data);
> +}
> +
> +static struct dec_data *alloc_dec_data(unsigned nr_threads)
> +{
> +	struct dec_data *data = NULL;
> +	int i = -1;
> +
> +	data = vzalloc(array_size(nr_threads, sizeof(*data)));
> +	if (!data)
> +		goto fail;
> +
> +	for (i = 0; i < nr_threads; i++) {
> +		data[i].unc = vzalloc(UNC_SIZE);
> +		if (!data[i].unc)
> +			goto fail;
> +		data[i].cmp = vzalloc(CMP_SIZE);
> +		if (!data[i].cmp)
> +			goto fail;
> +	}
> +
> +	return data;
> +fail:
> +	free_dec_data(data, nr_threads);
> +	return NULL;
> +}
> +
>  /**
>   * load_compressed_image - Load compressed image data and decompress it.
>   * @handle: Swap map handle to use for loading data.
> @@ -1231,7 +1312,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
>  		goto out_clean;
>  	}
>  
> -	data = vzalloc(array_size(nr_threads, sizeof(*data)));
> +	data = alloc_dec_data(nr_threads);
>  	if (!data) {
>  		pr_err("Failed to allocate %s data\n", hib_comp_algo);
>  		ret = -ENOMEM;
> @@ -1510,7 +1591,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
>  			if (data[thr].cc)
>  				crypto_free_comp(data[thr].cc);
>  		}
> -		vfree(data);
> +		free_dec_data(data, nr_threads);
>  	}
>  	vfree(page);
>  
> @@ -1569,9 +1650,9 @@ int swsusp_check(bool exclusive)
>  	hib_resume_bdev_file = bdev_file_open_by_dev(swsusp_resume_device,
>  				BLK_OPEN_READ, holder, NULL);
>  	if (!IS_ERR(hib_resume_bdev_file)) {
> -		clear_page(swsusp_header);
> +		clear_page(swsusp_header_pg);
>  		error = hib_submit_io(REQ_OP_READ, swsusp_resume_block,
> -					swsusp_header, NULL);
> +					swsusp_header_pg, NULL);
>  		if (error)
>  			goto put;
>  
> @@ -1581,7 +1662,7 @@ int swsusp_check(bool exclusive)
>  			/* Reset swap signature now */
>  			error = hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
>  						swsusp_resume_block,
> -						swsusp_header, NULL);
> +						swsusp_header_pg, NULL);
>  		} else {
>  			error = -EINVAL;
>  		}
> @@ -1631,12 +1712,12 @@ int swsusp_unmark(void)
>  	int error;
>  
>  	hib_submit_io(REQ_OP_READ, swsusp_resume_block,
> -			swsusp_header, NULL);
> +			swsusp_header_pg, NULL);
>  	if (!memcmp(HIBERNATE_SIG,swsusp_header->sig, 10)) {
>  		memcpy(swsusp_header->sig,swsusp_header->orig_sig, 10);
>  		error = hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
>  					swsusp_resume_block,
> -					swsusp_header, NULL);
> +					swsusp_header_pg, NULL);
>  	} else {
>  		pr_err("Cannot find swsusp signature!\n");
>  		error = -ENODEV;
> @@ -1653,9 +1734,11 @@ int swsusp_unmark(void)
>  
>  static int __init swsusp_header_init(void)
>  {
> -	swsusp_header = (struct swsusp_header*) __get_free_page(GFP_KERNEL);
> -	if (!swsusp_header)
> +	swsusp_header_pg = (char *)__get_free_page(GFP_KERNEL);
> +	if (!swsusp_header_pg)
>  		panic("Could not allocate memory for swsusp_header\n");
> +	swsusp_header = (struct swsusp_header *)(swsusp_header_pg +
> +				PAGE_SIZE - sizeof(struct swsusp_header));
>  	return 0;
>  }
>  


