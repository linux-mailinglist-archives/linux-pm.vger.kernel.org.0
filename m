Return-Path: <linux-pm+bounces-34434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97163B529FF
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 09:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430AD17A922
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 07:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1604426C38D;
	Thu, 11 Sep 2025 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="adqsBSUp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC32459FE
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575901; cv=none; b=C8F6HsRHMI78vazLIKHcR5N669aMroBHOoAk2lXF9OY8406pSETG4mvLYxzVzSm3CdWaiyvVMZIY+RcPbNpQ9UBq6GTwNfu1Pz2qTeoOsilw71Y82qNXMfcMNRDEYMi1XMoW+b1GYCA5JI84CGpYUGQ1v8os0mLXsP74bE4oQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575901; c=relaxed/simple;
	bh=c+nVyHTw/l6GxLPdoRzM9y7sJkc0rvjpFG99z5bhefQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apUVKRY4AseU2WeeQ4PUtdyRGLAqM3kh04wnM7BcCZ5aA5jeOiclzddIYRKwIxb8x0KArbnNWICd2/kgtSywe3EWeiecyL8mJUL8ZL0K+Fd8zUbON3KS/0uWQGO+wXBjoIdc3grf+sCJMAF0gN8qNM5fyNbZhQ9tiSpBd2cEu3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=adqsBSUp; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b079c13240eso60263366b.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 00:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757575897; x=1758180697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=degBKJVuyHnw33MrOSllu60lAvi3EP4JK10gQgtYi20=;
        b=adqsBSUpM2ab9unILSXWwdj7Eh+q20g8xTMckcFX6ao4Q4FS3Gul0BUg4AIAZXlZ3y
         l5Nmpu1bZBUqJ1EUGc1b3AEM7yH3QtBteXFH0aMmm4/dSXpOI5YhN8dnIQQsehbrcFrz
         TdDf1sj5y/qObrIAzem4u6gtreUyJCqBQ2sFsCYGnw2EYw70dTuoZfI2qxT2+WvqRbN+
         FTn5zPnKjfiRXIq5KvmEl0t4rj1WufU4McPI2n7l36aL274Y8Fgkv8mJNxSzZi6gZj1j
         VEWBw4XkKZXkHYT2JCVSEosNUbNNLbI98bRefbJoswTNdw7d5CSNoEC+Ptcv4fLQRAUk
         nRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757575897; x=1758180697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=degBKJVuyHnw33MrOSllu60lAvi3EP4JK10gQgtYi20=;
        b=TB0cE2hgTx9AXqHTVYtAmYWFGmGnykbRFQuh1DHSDCtOKW2zyuSrabF3e+CeajWjBO
         PAcfeDokjNTvhpuhb6CRaBndtJxazK6/ld8+Kf+Hhplsdd6gqnSBjQxrrWjecjTCuXVa
         kIo5g6MQmvkqVYP8aLzXFiVkVQFS7DAqVaT6tzFS7m448HLhu/Szt9r4vp4dMvEFJusC
         2/PBmLlNMSl7sy2Zye22FCBLtwEo9KYdDLIf+ypnz2Y28meZThwUrGY1CrlVEbdiRHW4
         str3xBuI9YdZnttccnVxns35tRlWWlmtbJtwOXYAy4rwVH0MPFmBqQG4lbt2NsiCCiiM
         Z3cA==
X-Forwarded-Encrypted: i=1; AJvYcCUrTQsIgZw/kjhESd1NJQSDyNiL4/7dnbOflao3mL2ER7124Di2MeFlVDjLM44nGq0qQmi1Mf02Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2cTv+C+amcIN40B41FjkUO/w3XlfYOdqRLIaNY7y2xSQZl/lz
	m7yOPbWc9Lb8qo4F/xiEZUp4qZJd/EbuIbw4m4SpG0Yrd8n8ZUmIsHqjmCXFkcmZrMw=
X-Gm-Gg: ASbGncs+pipqo6ulGt3ZfFdTR+ulULtlh00WjlTrMKDyfWg4UHMG+Fg5InMSDJIEuKN
	PBjTHnXnfB7TnbfyzFDJeCn33nbdAoxtzPv7v6WmHNs56gYwluSqxu4zUCd0QWrydfkZc8U9boo
	tLGGd8EoSRsGB6Jc2dog5xmd6PUP/mi/CdwX5aSfS7MdrzLg5aJF5ENq8uI7oInsyWU+7lmwkiW
	IsMYuxcZqw/LU/hwO6+YF1Adj0DsC1KFcqxrlCbRUmVGwt5XSlRyJh++T83swpy3c7wHCOZb6H3
	NCy8Jj5VugebiJ3pF4weTOs1yiEQFaaPQ+D8yGRn/6+rykYmvU5rpiOOC+LkzPupAKYeaoUWBXh
	I2nf3HHMg06VuWfu8kRqRuvyRz9vPjTSlt36f97NnAN9S
X-Google-Smtp-Source: AGHT+IHdIz45ITHlnfk3Z9/vpjn8WUwHHtdftIGSPN/xekCYOQYFtBTJQ0MkrZ7ISSCBXqS7+DLEbQ==
X-Received: by 2002:a17:906:507:b0:b04:b446:355 with SMTP id a640c23a62f3a-b04b446113bmr1484877266b.59.1757575897066;
        Thu, 11 Sep 2025 00:31:37 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33b4d63sm613614a12.23.2025.09.11.00.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 00:31:36 -0700 (PDT)
Date: Thu, 11 Sep 2025 09:31:35 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: akpm@linux-foundation.org, feng.han@honor.com, lenb@kernel.org,
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pm@vger.kernel.org, liulu.liu@honor.com,
	lorenzo.stoakes@oracle.com, pavel@kernel.org, rafael@kernel.org,
	rientjes@google.com, shakeel.butt@linux.dev, surenb@google.com,
	tglx@linutronix.de
Subject: Re: [PATCH v9 2/2] mm/oom_kill: The OOM reaper traverses the VMA
 maple tree in reverse order
Message-ID: <aMJ619kjFm00c4OP@tiehlicka>
References: <aMGXsenuvA682-Dc@tiehlicka>
 <20250911040609.6126-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911040609.6126-1-zhongjinji@honor.com>

On Thu 11-09-25 12:06:09, zhongjinji wrote:
> > On Wed 10-09-25 22:37:26, zhongjinji wrote:
> > > Although the oom_reaper is delayed and it gives the oom victim chance to
> > > clean up its address space this might take a while especially for
> > > processes with a large address space footprint. In those cases
> > > oom_reaper might start racing with the dying task and compete for shared
> > > resources - e.g. page table lock contention has been observed.
> > > 
> > > Reduce those races by reaping the oom victim from the other end of the
> > > address space.
> > > 
> > > It is also a significant improvement for process_mrelease(). When a process
> > > is killed, process_mrelease is used to reap the killed process and often
> > > runs concurrently with the dying task. The test data shows that after
> > > applying the patch, lock contention is greatly reduced during the procedure
> > > of reaping the killed process.
> > > 
> > > The test is based on arm64.
> > > 
> > > Without the patch:
> > > |--99.57%-- oom_reaper
> > > |    |--0.28%-- [hit in function]
> > > |    |--73.58%-- unmap_page_range
> > > |    |    |--8.67%-- [hit in function]
> > > |    |    |--41.59%-- __pte_offset_map_lock
> > > |    |    |--29.47%-- folio_remove_rmap_ptes
> > > |    |    |--16.11%-- tlb_flush_mmu
> > > |    |    |--1.66%-- folio_mark_accessed
> > > |    |    |--0.74%-- free_swap_and_cache_nr
> > > |    |    |--0.69%-- __tlb_remove_folio_pages
> > > |    |--19.94%-- tlb_finish_mmu
> > > |    |--3.21%-- folio_remove_rmap_ptes
> > > |    |--1.16%-- __tlb_remove_folio_pages
> > > |    |--1.16%-- folio_mark_accessed
> > > |    |--0.36%-- __pte_offset_map_lock
> > > 
> > > With the patch:
> > > |--99.53%-- oom_reaper
> > > |    |--55.77%-- unmap_page_range
> > > |    |    |--20.49%-- [hit in function]
> > > |    |    |--58.30%-- folio_remove_rmap_ptes
> > > |    |    |--11.48%-- tlb_flush_mmu
> > > |    |    |--3.33%-- folio_mark_accessed
> > > |    |    |--2.65%-- __tlb_remove_folio_pages
> > > |    |    |--1.37%-- _raw_spin_lock
> > > |    |    |--0.68%-- __mod_lruvec_page_state
> > > |    |    |--0.51%-- __pte_offset_map_lock
> > > |    |--32.21%-- tlb_finish_mmu
> > > |    |--6.93%-- folio_remove_rmap_ptes
> > > |    |--1.90%-- __tlb_remove_folio_pages
> > > |    |--1.55%-- folio_mark_accessed
> > > |    |--0.69%-- __pte_offset_map_lock
> > 
> > I do not object to the patch but this profile is not telling much really
> > as already pointed out in prior versions as we do not know the base
> > those percentages are from. It would be really much more helpful to
> > measure the elapse time for the oom_repaer and exit_mmap to see those
> > gains.
> 
> I got it. I will reference the perf report like this [1] in the changelog.
> link : https://lore.kernel.org/all/20250908121503.20960-1-zhongjinji@honor.com/ [1]

Yes, this is much more informative. I do not think we need the full
report in the changelog though. I would just add your summary
Summary of measurements (ms):
+---------------------------------------------------------------+
| Category                      | Applying patch | Without patch|
+-------------------------------+---------------+--------------+
| Total running time            |    132.6      |    167.1      |
|   (exit_mmap + reaper work)   |  72.4 + 60.2  |  90.7 + 76.4  |
+-------------------------------+---------------+--------------+
| Time waiting for pte spinlock |     1.0       |    33.1      |
|   (exit_mmap + reaper work)   |   0.4 + 0.6   |  10.0 + 23.1 |
+-------------------------------+---------------+--------------+
| folio_remove_rmap_ptes time   |    42.0       |    41.3      |
|   (exit_mmap + reaper work)   |  18.4 + 23.6  |  22.4 + 18.9 |
+---------------------------------------------------------------+

and referenced the full report by the link.

Thanks!

-- 
Michal Hocko
SUSE Labs

