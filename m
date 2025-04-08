Return-Path: <linux-pm+bounces-24941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D091A80F35
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 17:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED2A4213E2
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 15:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0677822171B;
	Tue,  8 Apr 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="JLcedITb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F21DD526
	for <linux-pm@vger.kernel.org>; Tue,  8 Apr 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124438; cv=none; b=nu1faHqOl907wnqZVhvZZ/Q2U30dMCMPYX6HWZLAUOJOtwECaRf3nO5GrFlxmPK0p0jQZKsr5ksJgmJLZTtVCjPnsSoU21LzjjlCh2MpOg1RMxe/ewbLtMaLo1NxHYMXXID4mBqHcUolO1tV5UGu87eom7idLdDtjPpQW8HBd6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124438; c=relaxed/simple;
	bh=p/PzL0lY97r0zZWWojJbCACzIyLA8XnwuAilw+dmSfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBZY5uE3nVE3kg0COp2x6UzmBDKvdE3gv/F1BXC1KZyUx4NcuyVsRkugVuDkrZHGSiURrC6S4MkxXikILPi1iSs4a308ZX8inW6lzGv6m5Fjr8D6xr2f3PkESFvwd7C/McMtRc16zb9MhZnqltpk/vmLlF+AiwD2pdfhXrjhvHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=JLcedITb; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d5e2606a1bso46559955ab.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Apr 2025 08:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744124436; x=1744729236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQd2HuYVMB2uA19lAP4G3r1tUf16qS+73yi0Zu+QUgU=;
        b=JLcedITbMrH2BMWGg9RWNNL2Txu38Md3g9r5e3Nhf74zXz69BuRBuM568KFiL9SHgY
         iiv59TxDYOd4YKYUJ7QP5t1KphGeTlPmmJPr8B9aY4QDhBGAiORdO4/71txHHgorDO8A
         MEfAbiZnaW2y4CTgjix8Y/D/5lzpLNEiPM/YjVNieuOLSdWaAVoJareWDS4FrgKEW4SG
         LWiJcifnzDaOtCW5AG+9hrbvYyVMQinwkk9QczDH8eUq8CMSr1W+AHMv4EV/YIpf6rEe
         kHu6ck3sHpKqd8Qc7EOR3lModWDBK7wE5R0D5wCgoKL32ahMBw0T2e7umaSTmPWov3el
         m0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744124436; x=1744729236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQd2HuYVMB2uA19lAP4G3r1tUf16qS+73yi0Zu+QUgU=;
        b=B2hbHHtCh1xePFzm4ExbTWWzSJmnCtgHeFJ4jiiaFciq/EiXNMa1ZWFifElRNThaXr
         Tm+BgXyjfXVf2j4YV+CZJwwHMyQYZIm/69jBhn05IcuIzx6SXKpRY+j9vnL4JhnQ60ug
         bP4Z1VXpPnDiefTzEHWmqKmOLS6Izqz3BDPVF6jm8BddZun/SbBPxkenp1L6fPNrVcDC
         ixoyNPrb/sjIdIt4WpO4436tAm9sQ8daP39Ao2+ap+Hd2t9ExApwc1Y1J6BvKT6lbgb+
         Vg7IaaioEiqlZwYZHX6GaFHZlxdJm0Aw9Ea7MG712NO/RXfue4v1HNoRP9hd4gTh1ww7
         oMtg==
X-Forwarded-Encrypted: i=1; AJvYcCXI3xFYOdC7SnA0pkB6S0Em/FVTt0UFxl5GNaus/0FKyg4CV0ssEwdBxnh5rxeAVV3R5C1cTc4Cdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1zuY4+auLz+7DTkiCez5B1En+56L7WxD1OflGeSPsd/8NX2qC
	4eZ82qYoqCB/b++llQ2UuiZPXAuHjsthmxO+imInWvDy5UE4FuEvuS6JQ58YGORD9WC+WLd33IO
	Y
X-Gm-Gg: ASbGnctMtNET8+udbqrgS6b0riZBbTfQB2UamYOtlkYOZwx3dCnHQ+UeIVn9mI+uFew
	mllDE6HF5c8I6OmpQoLL9Pk4A09lrqW4qsxOZlcMcILQ8cZ+qXwQJI82uvKjDSbYvhFN6hwZmqD
	J1ll0bdEmDFBhszevzEOslFC6QVpcrC+EjUTTRkCCnC49FM18epri/PrtR+usAYAMETBXoPCfNn
	cpsvxSjEKKqW1RDBhvTbJqvvUOwQGCcgW1IlHKgIdb2HArQL/xO4rVf8Lb1gNuQFtX6MjrVznoH
	hDj3mAODN4DDIqv0gzfpr7OyaFWdjg266j6/ht9pQXM=
X-Google-Smtp-Source: AGHT+IHoaiiimay/jkn42/i4mLcJ/qG34wLV5JJdRiDmu8nloHtzgfEmtFoYsMdVM1i1HbahBBGarQ==
X-Received: by 2002:a05:620a:d8c:b0:7c5:5d9b:b617 with SMTP id af79cd13be357-7c774d531e4mr2153900785a.23.1744124424489;
        Tue, 08 Apr 2025 08:00:24 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c76e7354a3sm770574985a.10.2025.04.08.08.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:00:23 -0700 (PDT)
Date: Tue, 8 Apr 2025 11:00:19 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hughd@google.com,
	yosry.ahmed@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk, baohua@kernel.org, osalvador@suse.de,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu,
	pavel@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 04/14] mm: swap: swap cache support for virtualized
 swap
Message-ID: <20250408150019.GB816@cmpxchg.org>
References: <20250407234223.1059191-1-nphamcs@gmail.com>
 <20250407234223.1059191-5-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407234223.1059191-5-nphamcs@gmail.com>

On Mon, Apr 07, 2025 at 04:42:05PM -0700, Nhat Pham wrote:
> Currently, the swap cache code assumes that the swap space is of a fixed
> size. The virtual swap space is dynamically sized, so the existing
> partitioning code cannot be easily reused.  A dynamic partitioning is
> planned, but for now keep the design simple and just use a flat
> swapcache for vswap.
> 
> Since the vswap's implementation has begun to diverge from the old
> implementation, we also introduce a new build config
> (CONFIG_VIRTUAL_SWAP). Users who do not select this config will get the
> old implementation, with no behavioral change.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/Kconfig      | 13 ++++++++++
>  mm/swap.h       | 22 ++++++++++------
>  mm/swap_state.c | 68 +++++++++++++++++++++++++++++++++++++++++--------
>  3 files changed, 85 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 1b501db06417..1a6acdb64333 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -22,6 +22,19 @@ menuconfig SWAP
>  	  used to provide more virtual memory than the actual RAM present
>  	  in your computer.  If unsure say Y.
>  
> +config VIRTUAL_SWAP
> +	bool "Swap space virtualization"
> +	depends on SWAP
> +	default n
> +	help
> +		When this is selected, the kernel is built with the new swap
> +		design. This will allow us to decouple the swap backends
> +		(zswap, on-disk swapfile, etc.), and save disk space when we
> +		use zswap (or the zero-filled swap page optimization).
> +
> +		There might be more lock contentions with heavy swap use, since
> +		the swap cache is no longer range partitioned.
> +
>  config ZSWAP
>  	bool "Compressed cache for swap pages"
>  	depends on SWAP
> diff --git a/mm/swap.h b/mm/swap.h
> index d5f8effa8015..06e20b1d79c4 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -22,22 +22,27 @@ void swap_write_unplug(struct swap_iocb *sio);
>  int swap_writepage(struct page *page, struct writeback_control *wbc);
>  void __swap_writepage(struct folio *folio, struct writeback_control *wbc);
>  
> -/* linux/mm/swap_state.c */
> -/* One swap address space for each 64M swap space */
> +/* Return the swap device position of the swap slot. */
> +static inline loff_t swap_slot_pos(swp_slot_t slot)
> +{
> +	return ((loff_t)swp_slot_offset(slot)) << PAGE_SHIFT;
> +}

In the same vein as the previous email, please avoid mixing moves,
renames and new code as much as possible. This makes it quite hard to
follow what's going on.

I think it would be better if you structure the series as follows:

1. Prep patches. Separate patches for moves, renames, new code.

3. mm: vswap
   - config VIRTUAL_SWAP
   - mm/vswap.c with skeleton data structures, init/exit, Makefile hookup

4. (temporarily) flatten existing address spaces

   IMO you can do the swapcache and zswap in one patch

5+. conversion patches

    Grow mm/vswap.c as you add discrete components like the descriptor
    allocator, swapoff locking, the swap_cgroup tracker etc.

    You're mostly doing this part already. But try to order them by
    complexity and on a "core to periphery" gradient. I.e. swapoff
    locking should probably come before cgroup stuff.

Insert move and rename patches at points where they make the most
sense. I.e. if they can be understood in the current upstream code
already, put them with step 1 prep patches. If you find a move or a
rename can only be understood in the context of one of the components,
put them in a prep patch right before that one.

> @@ -260,6 +269,28 @@ void delete_from_swap_cache(struct folio *folio)
>  	folio_ref_sub(folio, folio_nr_pages(folio));
>  }
>  
> +#ifdef CONFIG_VIRTUAL_SWAP
> +void clear_shadow_from_swap_cache(int type, unsigned long begin,
> +				unsigned long end)
> +{
> +	swp_slot_t slot = swp_slot(type, begin);
> +	swp_entry_t entry = swp_slot_to_swp_entry(slot);
> +	unsigned long index = swap_cache_index(entry);
> +	struct address_space *address_space = swap_address_space(entry);
> +	void *old;
> +	XA_STATE(xas, &address_space->i_pages, index);
> +
> +	xas_set_update(&xas, workingset_update_node);
> +
> +	xa_lock_irq(&address_space->i_pages);
> +	xas_for_each(&xas, old, entry.val + end - begin) {
> +		if (!xa_is_value(old))
> +			continue;
> +		xas_store(&xas, NULL);
> +	}
> +	xa_unlock_irq(&address_space->i_pages);

I don't think you need separate functions for this, init, exit etc. if
you tweak the macros to resolve to one tree. The current code already
works if swapfiles are smaller than SWAP_ADDRESS_SPACE_PAGES and there
is only one tree, after all.

This would save a lot of duplication and keep ifdefs more confined.

