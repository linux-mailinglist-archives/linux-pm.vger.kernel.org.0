Return-Path: <linux-pm+bounces-28630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAA5AD83A1
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 09:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A2D179982
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 07:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9840C23BD09;
	Fri, 13 Jun 2025 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c8W+YGyX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4CA1EE7C6
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749798319; cv=none; b=AoWaIvJ5StDkyH3RIHPWb0rDuWGAh4Cqmgb9dmCtQQx0B01rW5Lo0L22YrnjarTid+IR1IQg/7o53DuxPmIQSMrCQfGMf1FWfHwWbzDh50+7mO4QXkWgJ5VEYzsQd6tDCXu8bPE4c7wHw9J5EGVVJjN32SHr6kujxSnj0UlwNZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749798319; c=relaxed/simple;
	bh=1Ml41e/iRFBQdoQFJtk0Exdme5nWC3PBdmBfD9gfcA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIWpQjtWfoIomvuP3OIniwMZQG8vobgqxwXPOSd6MUr2GX/ZEXSsArbzDwH7EsNZuydc5Nh6dyr2W7Q2spe4mfbpBr06NAKBwlNp9jgf3MuaP+nWm4gtpyu0tbMTyuyDPpD1qA4l6kIOhokkZuX222J0w7kDQBjGUVVqIbPvcdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c8W+YGyX; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6077d0b9bbeso3162643a12.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 00:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749798315; x=1750403115; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vts8efAArosuOokj2P4hje3a/RKrGpboAfdZMgKD5Zw=;
        b=c8W+YGyXPaRhHiF9sG617lywwE4VbVEAiOP9HBb0gwTaKX4eg+X9fD9XvC7o3zwW53
         fYIe+joe+ZXatmAjseewHNPoeFDBHBNuL4fIxBkA3wrAScaXKRy2RzggprQ24nLDD/4n
         dmA0STSrgBRhaa/CZATOA0F/nuJB0a8voK3wg1PlwwyglNo839jGO9dbXzvNtJ6YVUgI
         KpATMzyPbtTqjOXK+xEfXRgxgLwrUA7kkd6mPZ4dpqgKWDBkLNbd1K12kibuCq8ptHxn
         e3XbVhWwLm+5AKo/2z0hsNIiudBbAXLgq+q0Fh1MpRCWCZNTq+dn01zc/xVm0fspnGz3
         DwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749798315; x=1750403115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vts8efAArosuOokj2P4hje3a/RKrGpboAfdZMgKD5Zw=;
        b=dIbvPpsig2ll06XdTZ6igVbKT4i9HU5DMCYiT0G+Up+CLGIAEzi2dEMuWEp3G6RbvK
         BLfQZJoCnrAKTL8efdyxIEO1bpIiwYYMARK+FESlFyfCxzArBfM0/ZhQd63D29/STTic
         VDNYFPRlANH+ueLpZcs7MWBGZHgEDCiKPLHLj2t9iXp3nxw4tSzQ0HEPSh6z0KZmJTlp
         PUEZ2XmtkkikudYNy9Wm3zMS6iLJt9jILlXO4AuxWpo199kgtZnQtnFXh/AcqtVym1h7
         ulo/njRYN/Mb6eaz95bAZoDQa5XKrccYwXHhkIA8dIQM2sVj51LaypZJDXyyEXzAF/HU
         JuSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0QDg1si/EsKlveuIZTROTEVEI3TvfnrjkCT6vByn3QwEq/g+QmImk/mp8uiRC0eMzRq2ewlm6EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc7Zegcm4W3+BgN6wPGkm0iOM01AZQ5tDDTHobd7NyQQhK3G5j
	ufWH+4FwTqqo5ddEq6Z6LjaO7o8mmhEVqz/GSHAdJvcjzrqpYO1Tpa7pEGR/ojCBO1U=
X-Gm-Gg: ASbGnct3EzR/dz8FelhmUfm9g/OZbRirl5QUhMXHTzIfMWcrhj/rAZgBk1/GdijUNJ4
	i3pmEh/J91WkAWD2eipprSwZ05/GC2UmcrZPP8hQILBkWOKYU2C5hab4OnudmibfVPv4lgLkiB0
	E5b+0B7nCtwD6iN4qc0FAWBtWg2RTagMyKC+Insw6vF1yZySkT791vfiFiS3p+zgGxXdWJC66F9
	d/HrHf10W4WQedeyIpTFYoRFkZNWnFmtL6zoy7LBrlZ3qu6MVeIhRMVZSfYdpkdTd8L27tYyvbk
	x4b0ZVYqOI9nRC4rcWDlieQhFRMUxSX7AUZqNTXJAHHdww90QfckQTTHjilf0QIUgsr15LZVJls
	=
X-Google-Smtp-Source: AGHT+IG8YEcfhRX4lkBSHSbJmFvftKfBrPCbvmRh2jp4NPPsHt14FnfRQE8a8YxmjsTAhMXqtAdJ2A==
X-Received: by 2002:a17:906:d555:b0:ad2:417b:2ab5 with SMTP id a640c23a62f3a-adec5d97debmr151980466b.60.1749798314776;
        Fri, 13 Jun 2025 00:05:14 -0700 (PDT)
Received: from localhost (109-81-85-139.rct.o2.cz. [109.81.85.139])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-adec892b90csm81370566b.142.2025.06.13.00.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 00:05:14 -0700 (PDT)
Date: Fri, 13 Jun 2025 09:05:13 +0200
From: Michal Hocko <mhocko@suse.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: David Hildenbrand <david@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, rafael@kernel.org,
	len.brown@intel.com, pavel@kernel.org, kees@kernel.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] PM: Optionally block user fork during freeze to
 improve performance
Message-ID: <aEvNqY5piB02l20T@tiehlicka>
References: <20250606062502.19607-1-zhangzihuan@kylinos.cn>
 <20250606082244.GL30486@noisy.programming.kicks-ass.net>
 <83513599-e007-4d07-ac28-386bc5c7552d@kylinos.cn>
 <cd548b13-620e-4df5-9901-1702f904d470@redhat.com>
 <a4370ebc-b1ce-46ba-b3a4-cb628125d7d0@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4370ebc-b1ce-46ba-b3a4-cb628125d7d0@kylinos.cn>

On Fri 13-06-25 10:37:42, Zihuan Zhang wrote:
> Hi David,
> Thanks for your advice!
> 
> 在 2025/6/10 18:50, David Hildenbrand 写道:
> > 　　　 　 　 　　 　 　 　 　 　 　 　 　 　 　　
> > Can't this problem be mitigated by simply not scheduling the new fork'ed
> > process while the system is frozen?
> > 
> > Or what exact scenario are you worried about?
> 
> Let me revisit the core issue for clarity. Under normal conditions, most
> processes in the system are in a sleep state, and only a few are runnable.
> So even with thousands of processes, the freezer generally works reliably
> and completes within a reasonable time

How do you define reasonable time?

> However, in our fork-based test scenario, we observed repeated freeze
> retries.

Does this represent any real life scenario that happens on your system?
In other words how often do you miss your "reasonable time" treshold
while running a regular workload. Does the freezer ever fail?

[...]

> You’re right — blocking fork() is quite intrusive, so it’s worth exploring
> alternatives. We’ll try implementing your idea of preventing the newly
> forked process from being scheduled while the system is freezing, rather
> than failing the fork() call outright.

Just curious, are you interested in global freezer only or is the cgroup
freezer involved as well?

-- 
Michal Hocko
SUSE Labs

