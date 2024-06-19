Return-Path: <linux-pm+bounces-9622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF5A90F6E0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 21:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9861C21525
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 19:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B23158DC1;
	Wed, 19 Jun 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkfjUbab"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDD0158D98;
	Wed, 19 Jun 2024 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718824766; cv=none; b=lFQ0mE2/Ow169PNx6NfSNcRNDRFaXSGpZDj9O478dwIqe353lqdv++FbfHpc+4g4NSWLa3QWZQL4a5c7moKWdkueRQhL3M4MHP7HXXxi+UePMup4ByJwiuNb26uyMZSCBnrnUvDissQ14SxCH0+2e3hq6M/HsA8PwaOqQbW4PE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718824766; c=relaxed/simple;
	bh=QUTaWxeS1VvcCc6l665bsTMRltHP0teM/mg4P7j0Ppo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZTr4uo5Yf+T/rwkyyuy8CvDqNczGd4qSzhf7ipkkD8qxUuNhPvMSeQ9L7mCsYad8vZddUunBQCS9S8YAaqQwrl5JKON8zekCqeU1ctifOtnfmqdSUMOKN924+oGuxe8SvKbpYxYtPQBN9oXuRcPjiJAThWHlG6ylUSdu/uLkK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkfjUbab; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7041053c0fdso143810b3a.3;
        Wed, 19 Jun 2024 12:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718824764; x=1719429564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjwTICzOymMe7OjhNchAsLwqDK72aNrQGnyZrMrOSLU=;
        b=dkfjUbablTT04MIz0DAK9r5jiDwi46BRvcbwz9TOnC/xycXGYgXd9tYxy0gL3OR3XT
         PMQoQQMku4EQ6e0yTqMLNmLwkNvlnnOCrbEzhuctrvpRhjeQkU3xCB8y3UIjf8leIlS9
         5Tf08wNl3h2mOoSGIh+19JkaNy8o4/sKVTW1xCIYOyV5IEZC6KXmW4SvlD6ulEXWHy7j
         d8e0HH2K2vQ0DAdEHIREreAtTjxI14o0B1dQre87jplkCJjsvtylr8x7xu7iA4YYwRnZ
         fZW5VOT/z+7tZmwC0RPDdb2yNWymaWdvyxxEeAjBZ6Hm/JnbB3nnqlIB7roRXRr0NWLv
         5kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718824764; x=1719429564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjwTICzOymMe7OjhNchAsLwqDK72aNrQGnyZrMrOSLU=;
        b=absQl1icgvoSAIVHSVx2kguTDfc9lTDs++XPW3XD/5MOUc4l5pRJ7g5BSz6zXQZqqf
         O92xfxTKYLuroUO8IOfgMLPlcgkkwWj2g8KE1qbQ0rUi1EXJbO13wNA6y69cJ/YIPouh
         27aqWMSr+dP3ELhLC5ZP4lqxI7zXD+N74zczsDLZkFUgn+Vn+c5yvLSHYlRmuQkjrGTp
         4Y6Zr3sbYgvxehBpCqRFchVT+DMvBfWH9wkYsHvP2yxxsk8v62UKgoPPH4iPXiNaGgeb
         GyrZnsPSu1i1hO6VVOgBsIlIWCbphd/dFcPzzfN07R2Hhr84O1MwGx7fNgA58p2fiYub
         /3lg==
X-Forwarded-Encrypted: i=1; AJvYcCUvYD1mCpyZuN433NgKQuCAQkyM6fFIUY2SMrouFNLiO4E+haWl1fJ7Z7nFYNr/nK0DaU9AfPdDX25/YYNJgzz59FN/X13W4t+vLeZaszpmWt2lmpZNl7/C7GhK+WeEsMRCRSLNm9I=
X-Gm-Message-State: AOJu0YzjyobC3J1ugvPYWdZIWrFzK/2YWwL1TemdnZHOnZUlW99Zu/2p
	c8dohTO7KQ8rCVV13Y5Ou0l4TvOBnV/kSAuxcYytwbRt0aANpxjO
X-Google-Smtp-Source: AGHT+IH3XwOoT/t6DwfEyJIfwL8Vxi0SRl8a3TKUh+rYsLz7iWl8Rl/7LfW7D4FPEITIV4lqLDPRvA==
X-Received: by 2002:a05:6a20:ae94:b0:1a9:4055:6dce with SMTP id adf61e73a8af0-1bcbb698666mr3407142637.58.1718824764180;
        Wed, 19 Jun 2024 12:19:24 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fede16a532sm8577338a12.20.2024.06.19.12.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 12:19:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 19 Jun 2024 09:19:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] sched_ext: Add cpuperf support
Message-ID: <ZnMvOht0usglJOzm@slm.duckdns.org>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-3-tj@kernel.org>
 <b32a658d-27fd-4f61-8f6f-58fa71af30c8@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b32a658d-27fd-4f61-8f6f-58fa71af30c8@arm.com>

Hello,

On Wed, Jun 19, 2024 at 03:07:51PM +0100, Christian Loehle wrote:
> >  static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
> >  {
> > -	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
> > +	unsigned long min, max;
> > +	unsigned long util = cpu_util_cfs_boost(sg_cpu->cpu) +
> > +		scx_cpuperf_target(sg_cpu->cpu);
> 
> What does cpu_util_cfs_boost() contain if scx is active?

Hmm... when SCX is in partial mode, cpu_util_cfs_boost() reports the util
metric from cfs side as usual, but, yeah, when scx_switched_all(), this
could be stale. I'll update.

> NIT: reverse xmas

Ah, let me just make the initial assignment a separate statement. Reverse
xmas is awkward with broken lines.

Thanks.

-- 
tejun

