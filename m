Return-Path: <linux-pm+bounces-42397-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jYv9DNzQimluOAAAu9opvQ
	(envelope-from <linux-pm+bounces-42397-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 07:31:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D28B1175F5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 07:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E343F301466D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 06:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04E93126C1;
	Tue, 10 Feb 2026 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U7N2G8Uw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7009D28314E
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770705112; cv=none; b=A3JsbDURinkVqtb8sLk/HjlBIT1WetN9EFy/bQkI6Zxt3WWgJIBDkKA6rvhCP5EeW8FVTeIWFA46yGAiqZEFf9/zknFfLVsfImbnFu0hLyt5SGeWypRvdMkizhIUrSJSMkCT8IkLUNFowIY5CWUmV8a48K/1E0WgTfbYyZeJikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770705112; c=relaxed/simple;
	bh=+dY5A7nwRVBRBd7BJ1hDL2J+oBIHOmLAIhWPxMtTN4o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kpZZ6AnYfoI2oPftvffkj/nGULtgIXwW4IK5lmhqL8uzoxmr7wEU+b3V9zqHsOA7ka5q/BxAD32410q/KCn+Tbw3Nt1F0LaNjkc4M+uY60JzbWVAcpYBydU7G1VCQVJFoCmEuE/bnEpQVX6nOKSYcNEJsFLhLJvGTCVY+2bJKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U7N2G8Uw; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47ee0291921so35829055e9.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 22:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770705110; x=1771309910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PuIvHjahYrqUwfgodntxdfFSIIlE9ggIgaeNW8+YxZc=;
        b=U7N2G8UwMwtnwPmbDdvrXVal6o2WZS+jJKtOpyf6nSz7PeirStusIC/NsW3quXzBoc
         vij7WcD9hovtkXX2KNlfJmPgdHRmpXQR/4nyu3+OuYaLulj1pWdvNLSgQCkqTUdxhUqx
         yrBDt93abC13ieuEMefe+LGue4Xw94xxdtyG8cCS3lZhMtxg3hOGFG4z+1W2JolhGdT/
         F5w4aP5VbYQwhDEnXFUwLGYxCjqelQMMqp6+xBfdOaoeZfiu+r7++Q+GQxNoCrx1alzI
         UI7RYfl1nOWafRxgjidgCFF0FUfb2ng69fvy16uGN1QBEUlCHwL0cz06E9+t3yPGMUfu
         sM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770705110; x=1771309910;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuIvHjahYrqUwfgodntxdfFSIIlE9ggIgaeNW8+YxZc=;
        b=BCkjbxCZx0e5G9EExKUGUWBFw/Dc2wgDOMrBgbofha2Hi2wrNQDo/NpsP1ppKFNjjM
         xsjVsY7dmjXobbnijY+kaxlBaThvdvNgY2hkfLaoVvPdWnf3xSgPUmoDP2CoVi/iFkCH
         pWGpp6/+utIBz/bl4HVeXMlScZuTf/jxa6aHWeLcOyCThMAYqKLIRhNhFhgs84ah3wUF
         x21xmDBDKBvzV7PWovFXKxHIwtdz4W954nK4qGu5x7G+8RB1XMZtljsXB2cFYO4Wit9b
         i6wYUkkNVZuP2yHil4lFO1F4erpUCQfiC9KxMI5t8kWEx+RRMMpT/hg82AQ9oOMlasyZ
         0nfA==
X-Forwarded-Encrypted: i=1; AJvYcCVj4XIRDQWsYLE1sG+EexV+pkq9E52UwE1qkyYTKPE+t3Q/sMg88J3hmSD6NYx/gzUxF2SsKTTHxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJNw7CZaSDpX+v9iWsZHgy/KnM/o+1WZTKw3ralbcQRJTqjbqb
	ngjdV1lzpm+ELrkiXCRlBuOYlxqtiZx3e68qG68UsJPFxVSkDLcdC4JA1RECN7RQvpo=
X-Gm-Gg: AZuq6aISSPDlxHpyCLiCIh/pLj6dfu7KjtOGZXj7W8LrgTlSUj2itYdNGnTJRn+xzfE
	uKOuvfoZSC3zgtzQLR50zYgxTsdQE+HGrJuGbs09BmUB3TRgE3wkafcN6RAqpIGQU2Y/scDwJcz
	theqMmzoT7MDOgTmV2AjY/FKe6aKOkF37C/vr11AXNHkSnpoPhoW02HwO6YWIdCypKkdzwYq2Ds
	M3V6uECgTWJRArC2WAf2J3s2auVcgZJP8Mj7cO8vRMAv+WNCtlwxP2LDw8o/StxUT/YJfHhL486
	s6wItyGuV3Qah3e99FuFaokkUFq3KQiffr/BtvMKZW3lhcXNjaCfzvIuiZNblPpfT6DE52h4+Er
	WeSNgjC8n9FTs22SLFrfjHkusR2sx0vuBPzWyOA9Vbas+GsO6SY7xeXGWsSVTlWh4Db2svui3YT
	pDUwcezOTW90HEjrsQcAOzK/+P3NUL
X-Received: by 2002:a05:600c:4f8a:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-483201e3aaemr189459165e9.14.1770705109669;
        Mon, 09 Feb 2026 22:31:49 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320961505sm215017735e9.4.2026.02.09.22.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 22:31:49 -0800 (PST)
Date: Tue, 10 Feb 2026 09:31:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Nhat Pham <nphamcs@gmail.com>,
	linux-mm@kvack.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
	hannes@cmpxchg.org, hughd@google.com, yosry.ahmed@linux.dev,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	shikemeng@huaweicloud.com, viro@zeniv.linux.org.uk,
	baohua@kernel.org, bhe@redhat.com, osalvador@suse.de,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu,
	pavel@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com,
	joshua.hahnjy@gmail.com
Subject: Re: [PATCH v3 14/20] mm: swap: decouple virtual swap slot from
 backing store
Message-ID: <202602092300.lZO4Ee4N-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208215839.87595-15-nphamcs@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42397-lists,linux-pm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lists.linux.dev,gmail.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,lists.linux.dev,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim]
X-Rspamd-Queue-Id: 6D28B1175F5
X-Rspamd-Action: no action

Hi Nhat,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/mm-swap-decouple-swap-cache-from-physical-swap-infrastructure/20260209-120606
base:   05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
patch link:    https://lore.kernel.org/r/20260208215839.87595-15-nphamcs%40gmail.com
patch subject: [PATCH v3 14/20] mm: swap: decouple virtual swap slot from backing store
config: powerpc-randconfig-r073-20260209 (https://download.01.org/0day-ci/archive/20260209/202602092300.lZO4Ee4N-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 15.2.0
smatch version: v0.5.0-8994-gd50c5a4c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202602092300.lZO4Ee4N-lkp@intel.com/

smatch warnings:
mm/vswap.c:733 vswap_alloc_swap_slot() warn: variable dereferenced before check 'folio' (see line 701)

vim +/folio +733 mm/vswap.c

19a5fe94e9aae4 Nhat Pham 2026-02-08  694  bool vswap_alloc_swap_slot(struct folio *folio)
19a5fe94e9aae4 Nhat Pham 2026-02-08  695  {
19a5fe94e9aae4 Nhat Pham 2026-02-08  696  	int i, nr = folio_nr_pages(folio);
19a5fe94e9aae4 Nhat Pham 2026-02-08  697  	struct vswap_cluster *cluster = NULL;
19a5fe94e9aae4 Nhat Pham 2026-02-08  698  	struct swap_info_struct *si;
19a5fe94e9aae4 Nhat Pham 2026-02-08  699  	struct swap_cluster_info *ci;
19a5fe94e9aae4 Nhat Pham 2026-02-08  700  	swp_slot_t slot = { .val = 0 };
19a5fe94e9aae4 Nhat Pham 2026-02-08 @701  	swp_entry_t entry = folio->swap;

folio dereference here

19a5fe94e9aae4 Nhat Pham 2026-02-08  702  	struct swp_desc *desc;
19a5fe94e9aae4 Nhat Pham 2026-02-08  703  	bool fallback = false;
19a5fe94e9aae4 Nhat Pham 2026-02-08  704  
19a5fe94e9aae4 Nhat Pham 2026-02-08  705  	/*
19a5fe94e9aae4 Nhat Pham 2026-02-08  706  	 * We might have already allocated a backing physical swap slot in past
19a5fe94e9aae4 Nhat Pham 2026-02-08  707  	 * attempts (for instance, when we disable zswap). If the entire range is
19a5fe94e9aae4 Nhat Pham 2026-02-08  708  	 * already swapfile-backed we can skip swapfile case.
19a5fe94e9aae4 Nhat Pham 2026-02-08  709  	 */
19a5fe94e9aae4 Nhat Pham 2026-02-08  710  	if (vswap_swapfile_backed(entry, nr))
19a5fe94e9aae4 Nhat Pham 2026-02-08  711  		return true;
19a5fe94e9aae4 Nhat Pham 2026-02-08  712  
19a5fe94e9aae4 Nhat Pham 2026-02-08  713  	if (swap_slot_alloc(&slot, folio_order(folio)))

and here

19a5fe94e9aae4 Nhat Pham 2026-02-08  714  		return false;
19a5fe94e9aae4 Nhat Pham 2026-02-08  715  
19a5fe94e9aae4 Nhat Pham 2026-02-08  716  	if (!slot.val)
19a5fe94e9aae4 Nhat Pham 2026-02-08  717  		return false;
19a5fe94e9aae4 Nhat Pham 2026-02-08  718  
7f88e3ea20f231 Nhat Pham 2026-02-08  719  	/* establish the vrtual <-> physical swap slots linkages. */
7f88e3ea20f231 Nhat Pham 2026-02-08  720  	si = __swap_slot_to_info(slot);
7f88e3ea20f231 Nhat Pham 2026-02-08  721  	ci = swap_cluster_lock(si, swp_slot_offset(slot));
7f88e3ea20f231 Nhat Pham 2026-02-08  722  	vswap_rmap_set(ci, slot, entry.val, nr);
7f88e3ea20f231 Nhat Pham 2026-02-08  723  	swap_cluster_unlock(ci);
7f88e3ea20f231 Nhat Pham 2026-02-08  724  
7f88e3ea20f231 Nhat Pham 2026-02-08  725  	rcu_read_lock();
7f88e3ea20f231 Nhat Pham 2026-02-08  726  	for (i = 0; i < nr; i++) {
7f88e3ea20f231 Nhat Pham 2026-02-08  727  		desc = vswap_iter(&cluster, entry.val + i);
7f88e3ea20f231 Nhat Pham 2026-02-08  728  		VM_WARN_ON(!desc);
7f88e3ea20f231 Nhat Pham 2026-02-08  729  
19a5fe94e9aae4 Nhat Pham 2026-02-08  730  		if (desc->type == VSWAP_FOLIO) {
19a5fe94e9aae4 Nhat Pham 2026-02-08  731  			/* case 1: fallback from zswap store failure */
19a5fe94e9aae4 Nhat Pham 2026-02-08  732  			fallback = true;
19a5fe94e9aae4 Nhat Pham 2026-02-08 @733  			if (!folio)

So it can't be NULL here.

19a5fe94e9aae4 Nhat Pham 2026-02-08  734  				folio = desc->swap_cache;

So we'll never do this assignment and it will never become NULL.

19a5fe94e9aae4 Nhat Pham 2026-02-08  735  			else
19a5fe94e9aae4 Nhat Pham 2026-02-08  736  				VM_WARN_ON(folio != desc->swap_cache);
19a5fe94e9aae4 Nhat Pham 2026-02-08  737  		} else {
19a5fe94e9aae4 Nhat Pham 2026-02-08  738  			/*
19a5fe94e9aae4 Nhat Pham 2026-02-08  739  			 * Case 2: zswap writeback.
19a5fe94e9aae4 Nhat Pham 2026-02-08  740  			 *
19a5fe94e9aae4 Nhat Pham 2026-02-08  741  			 * No need to free zswap entry here - it will be freed once zswap
19a5fe94e9aae4 Nhat Pham 2026-02-08  742  			 * writeback suceeds.
19a5fe94e9aae4 Nhat Pham 2026-02-08  743  			 */
19a5fe94e9aae4 Nhat Pham 2026-02-08  744  			VM_WARN_ON(desc->type != VSWAP_ZSWAP);
19a5fe94e9aae4 Nhat Pham 2026-02-08  745  			VM_WARN_ON(fallback);
19a5fe94e9aae4 Nhat Pham 2026-02-08  746  		}
19a5fe94e9aae4 Nhat Pham 2026-02-08  747  		desc->type = VSWAP_SWAPFILE;
7f88e3ea20f231 Nhat Pham 2026-02-08  748  		desc->slot.val = slot.val + i;
7f88e3ea20f231 Nhat Pham 2026-02-08  749  	}
7f88e3ea20f231 Nhat Pham 2026-02-08  750  	spin_unlock(&cluster->lock);
7f88e3ea20f231 Nhat Pham 2026-02-08  751  	rcu_read_unlock();
19a5fe94e9aae4 Nhat Pham 2026-02-08  752  	return true;
7f88e3ea20f231 Nhat Pham 2026-02-08  753  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


