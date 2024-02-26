Return-Path: <linux-pm+bounces-4393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664C6866E0B
	for <lists+linux-pm@lfdr.de>; Mon, 26 Feb 2024 10:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0B9284A2C
	for <lists+linux-pm@lfdr.de>; Mon, 26 Feb 2024 09:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D528750A77;
	Mon, 26 Feb 2024 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFO/XG/O"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1456C50277
	for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936634; cv=none; b=YaMJiHtUKqkiLtPqNeeJiIyZ4lu9vbY78BJiUfzG0Z8Z8lWcsuiwv8v9N/f2lFIs3GuIJ4wA1GUZJI788ypJvkBhB+CSeBzQd/WTuIeZ2UchmIBs00o0h+wF0j7anbn4xM1rTJezZgQ2pwzLS13IQC8U+Yo+GoOmKXdQ5Z/v4jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936634; c=relaxed/simple;
	bh=Wpyv7cwfAh+/8axnwuNHvynIMAy4pwR4p2tH3OEB1pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlfiK3Ei+ScSqxChuy9W3skmZtcQ0S25rnTkgVnakeY3OjRSYfibuRDt5sB56hTBycVuJZnsmbiHY2hlLsK+s2TuNNRsh3sFLagDqGNqzqEUC3NvS+1rg+3g/T36x1/M6UiGRpkfLBiJRBoHeO9moup8lYVfQfXh3apIU+aF+SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFO/XG/O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708936631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tEsGHyKmhHFaggiU/p+Qf67ugl62p05Uk9RKbVQZhjk=;
	b=OFO/XG/O1iIVjPoO++P649T/DzS9iRQ6WORbzDVceNaL+B3FristcgfK1aGNYgHgq9ImhU
	rYayv2tk+lWluvgB54r467Y+WU5tPHm1+fDKyRebso5PV8TqoSzXfbWV45WlxwV5q7afWl
	YsxfjRjBx4ZjzHwYoGdaTShf/fkpytc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-Mj2IfTTYM7aPAFDWbt8xvg-1; Mon, 26 Feb 2024 03:37:10 -0500
X-MC-Unique: Mj2IfTTYM7aPAFDWbt8xvg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d240155a45so20752501fa.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 00:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708936628; x=1709541428;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEsGHyKmhHFaggiU/p+Qf67ugl62p05Uk9RKbVQZhjk=;
        b=lvilB9EeBswEjEQKg1WahlMPQIR8KM5BRlVAc835Qwp7+zQ+RXZK+F985u5CrjI8sD
         6fLPiR+3yBv6ubnqUgMQLr9XEdTje/yEDXt+38Rq4sXAy8oPjiAER2VBHJU7pIlMgOqj
         YTawhWfYR59NnQiba3F805sLVCFdoNNEpDoJABmibfgB2WN8lsKvrPyVGRYM227DfOZu
         dvjlcwEZrZS0+G4H70KUuoWHviITcLscS5Mavt4GD2+7oyTu8ysKOzAzaDmGTMErzPif
         hiJXDJVJh01O1eAQAg8IA4dW6honUSSmmrk9HmwNAMEiYqaDo81UC1nDJT7QZN/c0ovo
         s6eA==
X-Gm-Message-State: AOJu0YxD1LqIOxL53KIcHE30OJD/eM15K5Y/T22+vkO7AvjWrunAxYrx
	zwQv7/jAPcn+j0ZPH0Bn0oJochx2bierheJQ2EWvggPnUymnVGnOpuhAk9juhk0malDTLl5ITzh
	hUqanY21jBHKkzJspNXLE+tTY4mAyZKjenqXwCqT9awnrZosBB7rPsr35
X-Received: by 2002:a2e:bea0:0:b0:2d2:86c4:c8a7 with SMTP id a32-20020a2ebea0000000b002d286c4c8a7mr2448200ljr.34.1708936628672;
        Mon, 26 Feb 2024 00:37:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqZtNVcAgG0XLU1mqokLPY5YlcLtZdA3CUKhIij4yRc415t+fg4oJkJsPWsk6ORBAGzfr9Bg==
X-Received: by 2002:a2e:bea0:0:b0:2d2:86c4:c8a7 with SMTP id a32-20020a2ebea0000000b002d286c4c8a7mr2448168ljr.34.1708936628238;
        Mon, 26 Feb 2024 00:37:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:f700:104b:9184:1b45:1898? (p200300cbc72ff700104b91841b451898.dip0.t-ipconnect.de. [2003:cb:c72f:f700:104b:9184:1b45:1898])
        by smtp.gmail.com with ESMTPSA id bv20-20020a0560001f1400b0033d73e1505bsm7571209wrb.18.2024.02.26.00.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 00:37:07 -0800 (PST)
Message-ID: <8d70939f-ca14-4167-9647-b8f44ddcbb98@redhat.com>
Date: Mon, 26 Feb 2024 09:37:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: hibernate: Fix level3 translation fault in
 swsusp_save()
Content-Language: en-US
To: Yaxiong Tian <13327272236@163.com>, rafael@kernel.org, pavel@ucw.cz,
 len.brown@intel.com, keescook@chromium.org, tony.luck@intel.com,
 gpiccoli@igalia.com, akpm@linux-foundation.org, ardb@kernel.org,
 rppt@kernel.org, wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
 will@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Yaxiong Tian <tianyaxiong@kylinos.cn>,
 xiongxin <xiongxin@kylinos.cn>
References: <20240226034225.48689-1-13327272236@163.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240226034225.48689-1-13327272236@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.24 04:42, Yaxiong Tian wrote:
> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
> 
> On ARM64 machines using UEFI, if the linear map is not set (can_set_direct_map()
> return false), swsusp_save() will fail due to can't finding the map table
> under the nomap memory.such as:
> 
> [   48.532162] Unable to handle kernel paging request at virtual address ffffff8000000000
> [   48.532162] Mem abort info:
> [   48.532162]   ESR = 0x0000000096000007
> [   48.532162]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   48.532162]   SET = 0, FnV = 0
> [   48.532162]   EA = 0, S1PTW = 0
> [   48.532162]   FSC = 0x07: level 3 translation fault
> [   48.532162] Data abort info:
> [   48.532162]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
> [   48.532162]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [   48.532162]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [   48.532162] swapper pgtable: 4k pages, 39-bit VAs, pgdp=00000000eeb0b000
> [   48.532162] [ffffff8000000000] pgd=180000217fff9803, p4d=180000217fff9803, pud=180000217fff9803, pmd=180000217fff8803, pte=0000000000000000
> [   48.532162] Internal error: Oops: 0000000096000007 [#1] SMP
> [   48.532162] Internal error: Oops: 0000000096000007 [#1] SMP
> [   48.532162] Modules linked in: xt_multiport ipt_REJECT nf_reject_ipv4 xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter bpfilter rfkill at803x snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg dwmac_generic stmmac_platform snd_hda_codec stmmac joydev pcs_xpcs snd_hda_core phylink ppdev lp parport ramoops reed_solomon ip_tables x_tables nls_iso8859_1 vfat multipath linear amdgpu amdxcp drm_exec gpu_sched drm_buddy hid_generic usbhid hid radeon video drm_suballoc_helper drm_ttm_helper ttm i2c_algo_bit drm_display_helper cec drm_kms_helper drm
> [   48.532162] CPU: 0 PID: 3663 Comm: systemd-sleep Not tainted 6.6.2+ #76
> [   48.532162] Source Version: 4e22ed63a0a48e7a7cff9b98b7806d8d4add7dc0
> [   48.532162] Hardware name: Greatwall GW-XXXXXX-XXX/GW-XXXXXX-XXX, BIOS KunLun BIOS V4.0 01/19/2021
> [   48.532162] pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   48.532162] pc : swsusp_save+0x280/0x538
> [   48.532162] lr : swsusp_save+0x280/0x538
> [   48.532162] sp : ffffffa034a3fa40
> [   48.532162] x29: ffffffa034a3fa40 x28: ffffff8000001000 x27: 0000000000000000
> [   48.532162] x26: ffffff8001400000 x25: ffffffc08113e248 x24: 0000000000000000
> [   48.532162] x23: 0000000000080000 x22: ffffffc08113e280 x21: 00000000000c69f2
> [   48.532162] x20: ffffff8000000000 x19: ffffffc081ae2500 x18: 0000000000000000
> [   48.532162] x17: 6666662074736420 x16: 3030303030303030 x15: 3038666666666666
> [   48.532162] x14: 0000000000000b69 x13: ffffff9f89088530 x12: 00000000ffffffea
> [   48.532162] x11: 00000000ffff7fff x10: 00000000ffff7fff x9 : ffffffc08193f0d0
> [   48.532162] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 0000000000000001
> [   48.532162] x5 : ffffffa0fff09dc8 x4 : 0000000000000000 x3 : 0000000000000027
> [   48.532162] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000000000000004e
> [   48.532162] Call trace:
> [   48.532162]  swsusp_save+0x280/0x538
> [   48.532162]  swsusp_arch_suspend+0x148/0x190
> [   48.532162]  hibernation_snapshot+0x240/0x39c
> [   48.532162]  hibernate+0xc4/0x378
> [   48.532162]  state_store+0xf0/0x10c
> [   48.532162]  kobj_attr_store+0x14/0x24
> 
> QEMU ARM64 using UEFI also has the problem by setting can_set_direct_map()
> return false.
> 
> Since the NOMAP regions are now marked as PageReserved(), pfn walkers
> and the rest of core mm will treat them as unusable memory. So this
> regions should not saved in hibernation.
> 
> This problem may cause by changes to pfn_valid() logic in commit
> a7d9f306ba70 ("arm64: drop pfn_valid_within() and simplify pfn_valid()").
> 
> So to fix it, we add pfn_is_map_memory() check in saveable_page(). It
> make such regisons don't save in hibernation.
> 
> Fixes: a7d9f306ba70 ("arm64: drop pfn_valid_within() and simplify pfn_valid()")
> Co-developed-by: xiongxin <xiongxin@kylinos.cn>
> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>   kernel/power/snapshot.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 0f12e0a97e43..a06e3b1869d2 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1400,7 +1400,7 @@ static struct page *saveable_page(struct zone *zone, unsigned long pfn)
>   		return NULL;
>   
>   	if (PageReserved(page)
> -	    && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
> +	    && (!kernel_page_present(page) || pfn_is_nosave(pfn) || !pfn_is_map_memory(pfn)))
>   		return NULL;
>   
>   	if (page_is_guard(page))

On top of which tree does this apply?

All occurrences of pfn_is_map_memory() are in arch/arm64, how does this 
compile on other architectures?

-- 
Cheers,

David / dhildenb


