Return-Path: <linux-pm+bounces-10710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AC4928D77
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 20:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A131C21CD9
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DCC13CA99;
	Fri,  5 Jul 2024 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIfDj5cF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719B14A62F;
	Fri,  5 Jul 2024 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203773; cv=none; b=pWR7ZIvc3LpgQqu6HB8RY0DXD/aLVaYu1lYNm0VVZy7R3HO/GY6gFaoV2kuhQzPtL7NsQJX0Y47fJl9i+TQtLvZwW3xCAyFlHFueZuw49CIqNGTo/bpRhOoSWRk0c5tdVpTypTHcqUZnc/GigkncVHJu4NyznQVP86KOZQWQde0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203773; c=relaxed/simple;
	bh=uCQ7H11nNqfC8AYM0D5E/LFmOCFRBjGOFn16ElapECo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8BeAmpB3T8VC76ALmPFUvRWfOQ8AALaoHYHiBGqWREaB96daZNpQHSIP0wxvoBvRckUPCgLNmXI+o6N73kIBNv7GPuyIAFsDKPZ4pCXTU2Yu6S5txh1yKiXqXEMfZu7GC1g2JYJ1Lks8znbpNbguvuu5/OOKqs2tlB6A1CLUgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIfDj5cF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b0bc1ef81so829838b3a.1;
        Fri, 05 Jul 2024 11:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720203771; x=1720808571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0j11n+CcTdAeJUFS1vTUV5jjLmDD37YVKPcWUq6ni4=;
        b=EIfDj5cFQVeoE3acSYkzvV5DFGOOw+IBFuH1d/JMw9hPjttGyFeE0UNCUwqE39+7gH
         brB6JyzAHSB+8Oo35WkBKLC9+2G8xv8oXCuTnxfANzliB3uI64YkcU8b6aO9F0US7N5e
         P8s1NJKRIJnrhqymN0zlSW3ApOGZk6PvwrZ7NJzww8++3PfooUd1W+0OypVm8OogRFRQ
         zSK4ONR2sEXf7SUEtaZyGRA2ffXRZlxy+E+bSiOOSXlV9iGqcPTxUyqcEuyGJyW5HBXW
         /+Jwz5wovzhlapb/3zGryfnMzKAsw+pOWzgPglRYHWwFRY/c1e7gDunCSDzVRDTqz1yl
         4sqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720203771; x=1720808571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0j11n+CcTdAeJUFS1vTUV5jjLmDD37YVKPcWUq6ni4=;
        b=gO1gmxr/ZRAry6zM7U4VBg3xg2J6YoRq6Zbvkdgybudy4UUZV4FvJPlzIyq3Rrkx8A
         yiS2ETVDqJWs4vcBaz2eHQzK5nagL9elKBubK0v0eBbEHhXRV7wgzpD0V8BxHOj7khd0
         BzrfnFus8vaeoBfEfUepv5rvDhnj2BzO9473OzUsP7C8Q8fV5EQ2vApXz5KcFevFoBCk
         EXkM+57nqTsvY/PZQ/Gdh6FvjByP7rbAiMRwM7Wlgu+2mOuw+dl8i4FlzIsdvgAwu5VO
         eYJRrOOGA42C8x6RQeNj+J1G0opjzB849599H4CzKaeugFExcti1kJCYZLnvVjBlVV+F
         y+zg==
X-Forwarded-Encrypted: i=1; AJvYcCVZwCpofPX8ztNsWGYFmhCka4MXrJnqyVxrUXSSHQJpPyRykLwn1XAA/feBQTDBiB5VI32DgkaY/RdZvgwJ2OIwEVef1D2GEsu3G5lZYhrqv/Zq4Xx3RMwJVUWRvePSVKsdUy+TtmM=
X-Gm-Message-State: AOJu0Yz71IS8463H8v3PpbmR4gDRybl4iGZ2QRUU3FrQGlR07q02K+Wk
	1O46GITD3fag+M3hM3bwDr6pTlT3Fm39DVMgCi/Uh3kHhPjBVkj4
X-Google-Smtp-Source: AGHT+IHW6JA9cBxSsDuny5JYRpYsclQwKrmB8fmhNOFf5p6LmuSt7ouxGs5wCFzuBvACzOq69QH6qQ==
X-Received: by 2002:a05:6a20:431e:b0:1be:c559:5e82 with SMTP id adf61e73a8af0-1c0cc8d7de4mr6224646637.58.1720203771319;
        Fri, 05 Jul 2024 11:22:51 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb52941a24sm14220945ad.249.2024.07.05.11.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 11:22:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 5 Jul 2024 08:22:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Add cpuperf support
Message-ID: <Zog5-Yd5wV0-Y76y@slm.duckdns.org>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-3-tj@kernel.org>
 <ZnM2ywDVRZbrN6OC@slm.duckdns.org>
 <CAKfTPtBPObGdcaQF5nKqr4042f-+5obTMm_S6S+=3_Ct33ZMyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBPObGdcaQF5nKqr4042f-+5obTMm_S6S+=3_Ct33ZMyw@mail.gmail.com>

Hello, Vincent.

On Fri, Jul 05, 2024 at 02:41:41PM +0200, Vincent Guittot wrote:
> >  static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
> >  {
> > -       unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
> > +       unsigned long min, max, util = scx_cpuperf_target(sg_cpu->cpu);
> >
> > +       if (!scx_switched_all())
> > +               util += cpu_util_cfs_boost(sg_cpu->cpu);
> 
> I don't see the need for this. If fair is not used, this returns zero

There's scx_enabled() and scx_switched_all(). The former is set when some
tasks may be on sched_ext. The latter when all tasks are on sched_ext. When
some tasks may be on sched_ext but other tasks may be on fair, the condition
is scx_enabled() && !scx_switched_all(). So, the above if statement
condition is true for all cases that tasks may be on CFS (sched_ext is
disabled or is enabled in partial mode).

Thanks.

-- 
tejun

