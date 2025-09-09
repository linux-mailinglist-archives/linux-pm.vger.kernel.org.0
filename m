Return-Path: <linux-pm+bounces-34289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17996B502FA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF991360A9D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 16:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50469352FE8;
	Tue,  9 Sep 2025 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b1zVAztl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4524035337F
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436290; cv=none; b=cUceSC2vuki/UibmqfM33HjrX4WlDxFyVMWfcXmXDy/KdMbkk2lTpGf3Sq2SJx1TRTBH8h1Y6B+e/UGalnOuNkzNTqM/O8o2EzoaBl43jFeY8ZBsSVJFL48uoOXkCpidZwXIKN3uEXQ9r7/vBE1adyKaQCROSC6KHRfj+01A1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436290; c=relaxed/simple;
	bh=crjz8IuTMvnuAst3XpK5ykzknRWc+hiwRiocj24vF8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQYR9g+H5D2nHuB3ssBVvV/jO1Qws3LluttSsPvqBJiBvjzrjH4cDLwegepfSSvM+/hm/MsdKnq6DqCzN9hhwzppr1PLr+wJ1IBXKBZ0pym8EwJW6w/FQ/rcdbsLBRKwu8X0x0x5cRreK38M6APTzODuV7oGMzbUd2iiJRj/UnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b1zVAztl; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b042cc39551so1049394766b.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757436287; x=1758041087; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wCW/MpT2vQ9C50MIPfrp6np6huywdbRHgHAuQqK4bT4=;
        b=b1zVAztlhyyaWl8F9e0FNzrx16OLgTOgCu9e3Voc5z6KYj07qQhRIS/ZqdDd9uYgQt
         hnZxwjGtQtccpcgpKU4Jeg7mZ0k7+3/WVV+Wf5C+qTn3/opsZJQ8YI1EVsc/YTaX4h6F
         xWJVZYNA6g3FPbDSTpTIxXioSrzTieD/PGlUdSnkSUHplwxdKBYRo+6l0LzSx43Vu0HG
         8vWU/pXpjgWJv2dhZ5+5hpJ74yJ6DKJ1Pan4S3F05LM7xFdAyz3Ue+YnkoHSgWVG6WBl
         FSzwFLtjDDJUsD/6Ve3mQ9ew0FG3LXcxIdUheVxCDBf+6FyrHaYTc5oBN144YCxqXdBo
         6ZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436287; x=1758041087;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCW/MpT2vQ9C50MIPfrp6np6huywdbRHgHAuQqK4bT4=;
        b=tCGgMS3qBYWcv8eEoEfiCzsg5j+BtSOPi19Cpn17djvlqfGCWfPRPIEqqSyiaKA3X8
         PHkfc8IEICQ2VFIloZChKvd6RtHw55Z4WNWSdYJu37ut1s8EuJsF67Ig65SyjVSkS7uR
         o84LHxn8/wMe9CHyZwYr7O5VzFHpFpreQRjdsT//pp/B0csdcfBXarXcTGfrLvUsDQXP
         tOB+XBsP/2InPPnBZ7QeayjNhr9ru1uyJW55FaDI4Z2/WwYj3wpULR+gyppP7QKHIwE0
         eb7HnqpflANUA2zmqCh6+btvP8by8Um1Nf1XVJJXPsNt7him1Mz//ljmZVEOjbfSVbt+
         KsDg==
X-Forwarded-Encrypted: i=1; AJvYcCWzG2UXHINAFfH4iXQUA7sug5F6XTJ8U0dgJgeQNsGM71aRp2zOD3tR/7BsZhmGsNHNvh+g6dzGrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrYFZkSuPXHrdYYTyGDhSJrgyWJVn+RlyR5kC7V42xZ28nyGd2
	FBPd6OKl7c7gT/bB9X86ORE+Nj9UkbKwqRdZ/IHmCnPJ1Yo6JzEv2z03mYau4lmDTqA=
X-Gm-Gg: ASbGncsaNTBcE3fDeqsHCuPMRZ/b7SxGBOM8ud60O6s77AJGxh6fINzaSimd1N984At
	YL7DX5DboqbBmL3FHCQQNhyQ8xFStc2dPdv9Z+sY+WUCm8/tBa9jrbG1vh75P9ONDK7RsPA8L/r
	Sfqb4rpvFUzK3a5i54qc+eovvqofxy0xIQcElTivbBbMXXjIqruZ/HZ7hVDUvYCiyxRGT/13ST5
	02m651QzBLcsIbc/jLATp830UqdF9FxDYOUR+NOzCo2+u94Ap3wF0spO0OAigV6JiIERz3UGQWB
	atu04NECrVxcYNmGs9O2IihiI8Nh6/R7ZlCc18ukMleSerhUN8ohplgxUUGe2vvw80KfQIGJX7d
	PMkO3DJvmSVLjKC/WuDFZeYCWp0uRx0qaigSHlzU4P9ia
X-Google-Smtp-Source: AGHT+IHEqPGu01fBLkHalrq5g2/LgoDfcb+GW1hxVNwE/Xt1vQY2NUkE1HZsTFp64+X7RC6+sFL+Pw==
X-Received: by 2002:a17:907:3f9d:b0:aff:16eb:8b09 with SMTP id a640c23a62f3a-b04b13cf9c8mr1203677366b.5.1757436286539;
        Tue, 09 Sep 2025 09:44:46 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07830ac12asm18292866b.38.2025.09.09.09.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:44:46 -0700 (PDT)
Date: Tue, 9 Sep 2025 18:44:45 +0200
From: Michal Hocko <mhocko@suse.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: zhongjinji <zhongjinji@honor.com>, rientjes@google.com,
	shakeel.butt@linux.dev, akpm@linux-foundation.org,
	tglx@linutronix.de, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, lenb@kernel.org, rafael@kernel.org,
	pavel@kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, liulu.liu@honor.com,
	feng.han@honor.com
Subject: Re: [PATCH v8 1/3] mm/oom_kill: Introduce thaw_oom_process() for
 thawing OOM victims
Message-ID: <aMBZfYUN9qtcXXtL@tiehlicka>
References: <20250909090659.26400-1-zhongjinji@honor.com>
 <20250909090659.26400-2-zhongjinji@honor.com>
 <aL_wLqsy7nzP_bRF@tiehlicka>
 <CAJuCfpFCARoMJ8eniYdZ3hSaM_E3GvfRBV1VD1OohOfJpP87Hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFCARoMJ8eniYdZ3hSaM_E3GvfRBV1VD1OohOfJpP87Hg@mail.gmail.com>

On Tue 09-09-25 09:27:54, Suren Baghdasaryan wrote:
> On Tue, Sep 9, 2025 at 2:15 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 09-09-25 17:06:57, zhongjinji wrote:
> > > OOM killer is a mechanism that selects and kills processes when the system
> > > runs out of memory to reclaim resources and keep the system stable.
> > > However, the oom victim cannot terminate on its own when it is frozen,
> > > because __thaw_task() only thaws one thread of the victim, while
> > > the other threads remain in the frozen state.
> > >
> > > Since __thaw_task did not fully thaw the OOM victim for self-termination,
> > > introduce thaw_oom_process() to properly thaw OOM victims.
> >
> > You will need s@thaw_oom_process@thaw_processes@
> 
> Do you suggest renaming thaw_oom_process() into thaw_processes()
> (s/thaw_oom_process/thaw_processes)? If so, I don't think that's a
> better name considering the function sets TIF_MEMDIE flag. From that
> perspective less generic thaw_oom_process() seems appropriate, no?

Please see the discussion for the patch 2.
TL;DR yes rename and drop TIF_MEMDIE part and update freezer to check
tsk_is_oom_victim rather than TIF_MEMDIE.

-- 
Michal Hocko
SUSE Labs

