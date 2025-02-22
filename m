Return-Path: <linux-pm+bounces-22709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD886A40501
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 02:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6388219E3784
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 01:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2E5150980;
	Sat, 22 Feb 2025 01:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ecvcVJv9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E153973451
	for <linux-pm@vger.kernel.org>; Sat, 22 Feb 2025 01:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740189101; cv=none; b=urLw8MkAGYVtDkHsbaKXWLyyR3qNkGggUIV11wxcAozfzfauruJFzk76g4gU1Qe4g5IlrH2a/VAvx3J67vHh8eZeHgcbLvHJtQke7AFZJTC/yd5NwaCXxl8PqzR5iZcsbGYkL46HIWx1mU9y9BY3v29vBKtxyp24doycODPEZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740189101; c=relaxed/simple;
	bh=b/wCdmMliqE07gTjcVqKdmn4h1VhcVtYzWKk7Ib2gis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccEVbhW+w9z5N2/bs6l8xJlR2pPeL+Pf9NEZW1gbOTHJnGC6Ccq7DoiBsz+npKwX3CZRmw/IsCCNAPjyRMKL015LvtpylspzzyrpcByaWDgOBSWYMXK8f5zsI+v7hk1VfJ121ceu6vSgmB6bNFmvNULdkJPpjQWkUq341lNeUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ecvcVJv9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220d28c215eso43337745ad.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 17:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740189099; x=1740793899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bha+1AwEm87+wTDNDH+caF+yfplFmYnHclPIveYfWAQ=;
        b=ecvcVJv9LVPT0YklwYr6vYCC/8JRmm8gLXgmNdPv2uo/mG71uEU+DbJ0p+Stga4iXB
         tRmbZYIRuU1vIvplHdnzFeVcHIDN1IslEJfXuYgh58Me2vmHEnx87FO5H5SiYV02OdUV
         SCg6N6F07ZU2TQspJvdAUZTLwPmTOEWRbqwow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740189099; x=1740793899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bha+1AwEm87+wTDNDH+caF+yfplFmYnHclPIveYfWAQ=;
        b=g9tjHTr4JnPnsk5zcqfSkoBkJbuhJ2t2stbndfHUs+ZGdgUvG8nX4Z/zZorSYD4ITR
         Rlrzf2kC/CpfahKemTDa2RqjRaWSFSZuc4rp8HMxyJI8jNOOC/8veWIPhJWToVpmEHC8
         4eQEKF9l+d6WABgN45PnPhr+7JtgPObMO1cqSwN7gF2DSBYywJgLfGDWcIPu4AbOh++9
         4nxBa8rY3S3bfaaJvpsPEC8aRqAdObt0fPdm6HgdRUJI2K9CnsKj6O0N4gAzfd0tOfbC
         kJAv5Cj17LQcq6Z/VL0yAZpPZOh8nb0CE2lc5raTX2DGn+4DeJiwgRLPcySEv2/BLPpP
         8TGA==
X-Forwarded-Encrypted: i=1; AJvYcCXKq4p6J7OP7/TNy5gyMM873D7qyR+W7UZxKURsN/PK7e53L6L2wrJ1oBp0QMlvgbAGIb2SN+6g2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwF1oIJk/VkBB8tO1X00MEKyH/cjQ5OPC7vCG/kGk3JABohLog4
	12lCyll3nPpyZMoGqTp6rrGDW6vYD0ICzhNdYi+qfv9pPVi2E4oWU7usukxY5Kku99S3Kz40Cyw
	=
X-Gm-Gg: ASbGnctRVRtlq82FFiMqXZ92C2P22+uP/7lNyKeL9+jYRSZofpiNRSnOyXAf9/Kj7LI
	HGzv065nPiyHAXeeYnbK+itIpvhTqOLkL17/prTnyjMroHwzupslLn+2Whc3aOXlreJSOWAXlJK
	C+2993Ohq+4TDVSN7Hqnp0ng6ZA6qP1E9/HScnMKgM/lCZQZd0JgTIbE/gT4B0T4SafOcBI34U/
	aDUIh2XYfBBOig6hnMpginvka7ZHNgQTzjySarsDToKWLQff5wywN7yLBMGFWBNa8YEXDBQucwm
	sw2vVsnvSBhruJSkjVAZ1EAC61JPWdkCbSffJpAuFaVAUwgmqnGk3RoBzqETplVC
X-Google-Smtp-Source: AGHT+IFQyCCmTk5w1MoV+somoLERcOrpGo8lL2HFayqWLgHH5Imn3/GOjNna8e6kg5FpReH7HQUnQQ==
X-Received: by 2002:a17:903:2342:b0:216:6901:d588 with SMTP id d9443c01a7336-2219ff565d8mr81388185ad.15.1740189099244;
        Fri, 21 Feb 2025 17:51:39 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:cfe4:a8ae:32fb:3c84])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2213394d6c8sm89030505ad.181.2025.02.21.17.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 17:51:38 -0800 (PST)
Date: Fri, 21 Feb 2025 17:51:36 -0800
From: Brian Norris <briannorris@chromium.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Ajay Agarwal <ajayagarwal@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: PM runtime_error handling missing in many drivers?
Message-ID: <Z7ktqHxIhp90jLxi@google.com>
References: <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
 <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com>
 <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
 <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com>
 <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>
 <Z6lzWfGbpa7jN1QD@google.com>
 <Z6vNV8dDDPdWUKLS@google.com>
 <CAJZ5v0i83eJWV_kvWxZvja+Js3tKbrwZ8rVVGn7vR=0qLf1mtw@mail.gmail.com>
 <Z7ZYEp4oqPs12vsP@google.com>
 <50de9721-2dd8-448b-8c11-50b3923450f6@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50de9721-2dd8-448b-8c11-50b3923450f6@suse.com>

Hi Oliver,

On Thu, Feb 20, 2025 at 10:30:34AM +0100, Oliver Neukum wrote:
> On 19.02.25 23:15, Brian Norris wrote:
> > On Wed, Feb 12, 2025 at 08:29:34PM +0100, Rafael J. Wysocki wrote:
> > > The reason why runtime_error is there is to prevent runtime PM
> > > callbacks from being run until something is done about the error,
> > > under the assumption that running them in that case may make the
> > > problem worse.
> > 
> > What makes you think it will make the problem worse? That seems like a
> > rather large assumption to me. What kind of things do you think go
> > wrong, that it requires the framework to stop any future attempts? Just
> > spam (e.g., logging noise, if -EIO is persistent)? Or something worse?e
> 
> suspend() is three operations, potentially
> 
> a) record device state
> b) arm remote wakeup
> c) transition to a lower power state
> 
> I wouldn't trust a device to perform the first two steps
> without error handling either. It is an unnecessary risk.

I'm not sure I fully understand what you're saying. I'm not saying
drivers shouldn't handle errors. I'm just saying I don't see why the
framework should decide, "fail once and you're out."

Do you think (a) or (b) will fail silently if retried after a failed
operation? And what's the consequence?

> > But anyway, I don't think I require asymmetry; I'm just more interested
> > in unnecessary non-functionality. (Power inefficiency is less important,
> > as in the worst case, we can at least save our data, reboot, and try
> > again.)
> 
> You are calling for asymmetry ;-)

Actually, you were the one who proposed asymmetry :) My concern is
asymmetric, but the solution doesn't have to be. For example, we could
remove runtime_error entirely, or else make it some kind of
ratelimited/backoff state.

Anyway, I appreciate that Rafael has helped improve the situation a bit
([PATCH v1] PM: runtime: Unify error handling during suspend and
resume). At least it gives us a tool to achieve what we want: ensure
that retriable failures produce -EBUSY or -EAGAIN. I'll have to give it
a whirl.

But I'm still wary that there are corner cases where other errors may
appear, and yet retrying is indeed the best option. And I'm not
confident that foisting the burden back onto the driver ("just scatter
pm_runtime_set_suspended() any time you might have fixed something") is
a practical approach either.

> If you fail to resume, you will need to return an error. The functions
> are just not equal in terms of consequences. We don't resume for fun.
> We do, however, suspend just because a timer fires.

Agreed.

Brian

