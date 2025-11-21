Return-Path: <linux-pm+bounces-38338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2146C77A2F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 08:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB02F35F4F5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 07:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0D6335BA6;
	Fri, 21 Nov 2025 07:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fp/D/Nes"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9E13358BF
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708585; cv=none; b=AcXrQ/YBgFH5nt130uA6pvw7nJGXT5tmFaaa3duSXZvsGFByoYK2F8HvvAFgBYeS5NwF4voUwjYQ+xcqY6KUV8EHZ8cxG078ZGfZzx8XvDxcXHBb3pNjM0enZAEZXdNVfo5xQe2TfC3HYJGn5fEn966/8kEuJg9M+9ibtQ9IvH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708585; c=relaxed/simple;
	bh=JU2fVJACbNZeuoKvJYHqmGJRlLq2Weomkzck+OYLO0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl2m939VtOLCai/6cbyNkUqcIpeUOSbGXBeG8QBk8Vrate0Se3cayHkeEYl8tdb+OABzQXKOyDxAc1QHpd22XhMNBmRWBxGlOHrspuZQ0zvjSG+YlpxAcIL1Gv387RmY9I50lNq0Lcq6oVDH3Jul/OK3PVxZwL3X0O5K+eC9yBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fp/D/Nes; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29516a36affso24216815ad.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 23:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763708583; x=1764313383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iUqmuYJP8913m5lYq21HT+nfUHsJaJp0XrmlhlH6Dv4=;
        b=fp/D/NesBK8veGwWatUWkhzTKli1c1ymiN6GYKr8M3pPwQaAH8vkg3L6+DeQW/kUVA
         3AyUApN3lnMDl/yG/YIMZwvwt9ROOjz1N3MwkNvSUfd66sdOkcws6tE53JX85ES+GoHn
         KSbFXJqZzes8IhRCUgsHj7oZS+SRs/MBf58Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763708583; x=1764313383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUqmuYJP8913m5lYq21HT+nfUHsJaJp0XrmlhlH6Dv4=;
        b=B8tRT3ExV+XvDR13TFGgL6sEHRKV5OI4/AKXfc+aMMN3woQ/uJFqcaP4i9Dh+JWkM3
         LwR5TTBIVZq8+KNmA3J9QPSwioNYNS11//zGP8HUnTMYb228EpK/g4oX4c2bvlKJxfwH
         5sfQMxqtbXq9R6EA+IOUp914j8Ul/Qcd6UuTP1mdcNbWKTMtRetjcRquB+yhAm0VTMLh
         bxW9i5zUzAXTTDnUUqFPBqJbHU0IvQn8fXpViV6781VUmyqTXZV8GV/PoVSjOuo1vKcx
         8k5AvA613nqpnI+m3aKk1xx5lEA83vFjFhf4qqjYEGTYa+m9SGLXlufSFKXQFi4K3qXD
         Lq9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnUKg1BcuIlxdh1pCgOdIEePyfCGJ9RNmfIS2YIrPtAai6s4zTAa8a1q2oi7frGut/EsOA7b0nKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYolnMAnk762H7/g7pfgDXckjd+w0JFxZnTea7FJ6IAzDwhvTm
	bw2eEp1Pl5BbxjaVvl2ibknh7xbGG9iyVr6mVXjBuwzS/kYsZIDw0jc5fZubZOryCA==
X-Gm-Gg: ASbGncv9otRBIbvJ9DgDM3y7PKIUkoKGGqmG2jc2wrcubWFLFtOTT2erunmtvwJKLKS
	yFkM+FuuxMqfB+EdkPJByYKqERQnI0Prc3z4pA6wIXvbY7dSZrS2CgQaQoPKYqID8BpzR3IpdTZ
	a5PKl7qFD99JsfGT47ISPwm1uujfioYzD7ji77O0CoJmATJRGeT/vojcSB0RiF7EMpcVwQD0mNU
	p7nT2gxOZpbQNRGKUQOBfdUmLQLNIA8CMv41qncIcx6kIgcITRz5P0xLKqR5H0wlRqPx+t91bNN
	49jlLnHDUoxlTfZLbvDDsYMjTbZ4/5CFRJyK3T4PoUlwpdii/yuVo9z1frFo/V7Amm19Xf52wxA
	PK/i00wx1kW1/dgWjNcCahKxw5Op8zbAXe8kc8UX9iWbwelNIkPSirHX3f06J8wupt3X46GU/U0
	fMKxBL+MRgoIF3Zg==
X-Google-Smtp-Source: AGHT+IEywaNCQBrtiWz1bn/eb5EPn9UR031f2xuv/3gnOuEstH3DE7HyY9UXL86t/eUO66P2uxwn1A==
X-Received: by 2002:a17:902:ef4c:b0:297:d741:d28a with SMTP id d9443c01a7336-29b6c574f8amr17827885ad.31.1763708582512;
        Thu, 20 Nov 2025 23:03:02 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b321:53f:aff8:76e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b27509dsm46060775ad.78.2025.11.20.23.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 23:03:02 -0800 (PST)
Date: Fri, 21 Nov 2025 16:02:56 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christian Loehle <christian.loehle@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yu-Che Cheng <giver@google.com>, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
Message-ID: <s3lyjszylckzg7mfefmysve2tsm53kmorgxly3nln4r6xha264@rct3fyk3d52a>
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com>
 <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>

On (25/11/21 12:55), Sergey Senozhatsky wrote:
> Hi Christian,
> 
> On (25/11/20 10:15), Christian Loehle wrote:
> > On 11/20/25 04:45, Sergey Senozhatsky wrote:
> > > Hi,
> > > 
> > > We are observing a performance regression on one of our arm64 boards.
> > > We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/cpufreq:
> > > Rework schedutil governor performance estimation").
> > > 
> > > UI speedometer benchmark:
> > > w/commit:	395  +/-38
> > > w/o commit:	439  +/-14
> > > 
> > 
> > Hi Sergey,
> > Would be nice to get some details. What board?
> 
> It's an MT8196 chromebook.
> 
> > What do the OPPs look like?
> 
> How do I find that out?
> 
> > Does this system use uclamp during the benchmark? How?
> 
> How do I find that out?
> 
> > Given how large the stddev given by speedometer (version 3?) itself is, can we get the
> > stats of a few runs?
> 
> v2.1
> 
> w/o patch     w/ patch
> 440 +/-30     406 +/-11
> 440 +/-14     413 +/-16
> 444 +/-12     403 +/-14
> 442 +/-12     412 +/-15
> 
> > Maybe traces of cpu_frequency for both w/ and w/o?
> 
> trace-cmd record -e power:cpu_frequency attached.
> 
> "base" is with ada8d7fa0ad4
> "revert" is ada8d7fa0ad4 reverted.

Am getting failed delivery notifications.  I guess attaching those as
text files wasn't a good idea after all.  Vincent, Christian, did you
receive that email?

