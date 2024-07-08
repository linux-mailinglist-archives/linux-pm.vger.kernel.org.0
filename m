Return-Path: <linux-pm+bounces-10798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F9C92AAE8
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 23:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CA31F22826
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 21:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADB114E2E3;
	Mon,  8 Jul 2024 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghKgJ6Kf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135F120DE8;
	Mon,  8 Jul 2024 21:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472965; cv=none; b=BI0JFtY+60v0+cA4GlBi+Eq9hlBiVTRkU9q7srkNAqmhyFGINHZPzL0Znz7oRAEzqA0Tx4S4Uu47OEYPNJRWRj3xOgQUg25Kx3XdoI6pY+VpR/F9l61dH99gjmlc6DspG13IEx28V2b+fAHMtHjAE1nPys4ThoUzQ1Qt4y9QSyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472965; c=relaxed/simple;
	bh=hzaPD2ryg5fZd9hDNgM8HsyiI90joEUrwDgiPS5zsxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2hiDOWGmC3aGQPZuK7zxKYBbUR6ju9YRu444v9hs0YN+CkLyuJDUpGg0BN6ILHo4MRuOSZPsKg6gubmmSn52qP4jCbShSaLmkRxZI3YjRQX49zBMSGRGLcg7eezYnbH8ZCcdvAxlLBLvYKMnSnGZIY9dktc07ZowBGCCzdp3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghKgJ6Kf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fb72eb3143so14424875ad.1;
        Mon, 08 Jul 2024 14:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720472963; x=1721077763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+IzSOi1IDFXj7pfGoo0u+aUX/5qQXD2Dpa3yDHZme4=;
        b=ghKgJ6KfjTqCFEDpxN9zGewDGShuIMt58otAnWbpkew/hjmMV2SSObjje475sQfVSQ
         LcFsRhOgk/ayJJYVC95PT2VQH+69yeQEIww/cTrSX6ZWrNQm72KZ4ryJagaDP1Fr1oDe
         HCJqeEXQBdI6M3bkO+uSy7bgh5NCpkuin7tnyrWZX78jnN1QGktDOK/zExy5OAgWnDyS
         glAVG5ryFb/b7+Tx+3E/K1wreP6kdb0z7cvQ7KmadIHm1D58bS3wioUrD1mb1lCeg+vh
         4iKdr5uD5OzxLwAymbf7Mpur9OnQzPDnLIVH1K3d4YdM1smEa3E/Yc4lJLO57v9gsRdI
         iNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720472963; x=1721077763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+IzSOi1IDFXj7pfGoo0u+aUX/5qQXD2Dpa3yDHZme4=;
        b=dJcMZjqm1IkyIeuF8fQwRS5fMTgoxgaSarMfBnloKW2y47DNU/knHXcZ4bUxrrsTpx
         BZcW3RrH4Jcot1/Q5needGRCXWknNdA35JzrU7kuqa+a+VilRRJ1UemiJgxNJH8O56rE
         VyiRJLZ3aKpG8R8BKG7qdgr31Hk2wjRr/SPGYR66XqqdKHnIWe2g1Mf87A3xSecJSS/j
         JcAoCvV9axwkfJXpY3/JRhyTDlOQDz1tcbalRI+CNUlkRTySY3q6/5MqhZpAKXbAMkaX
         Iim+ZkoFSPQ81gmdo7WZ7TurklqN+xqBO1UCGtdd0fWtdfWweCKklu2MP7qOmuz1yADh
         KaBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvHTUw/oDj4osFq+/F1MwZovpP34XHHOlC8EMvODrIhR0tlU9F7DhWwiBUOHqdxD9SPawvy5MAVYwR30wfqc224BLmxhLXDfILDUF1yS4HXrV1rUXMKervh+nWr8BXxteW6U6mxHA=
X-Gm-Message-State: AOJu0YxtWCP0TicYpOdRdZLcdjEfL9CACynS4o9zEq8eXcOH8kOCaF8T
	gI3wfs+zGpHdecsjt6h1HmE3FowscsPhTzcPz7bLhA/z3v7uOLwP
X-Google-Smtp-Source: AGHT+IFnGnzclJBm7W8am6B/Yv1ATuLozQD9Hvd5qZcpuWPFq6K3GLgqwFXOK64f8F4p1o749hWH9g==
X-Received: by 2002:a17:903:110d:b0:1f7:1d71:25aa with SMTP id d9443c01a7336-1fbb7f7a95dmr7132545ad.6.1720472933467;
        Mon, 08 Jul 2024 14:08:53 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a1296dsm3105285ad.16.2024.07.08.14.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 14:08:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Jul 2024 11:08:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Add cpuperf support
Message-ID: <ZoxVZPCrWokjfmFY@slm.duckdns.org>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-3-tj@kernel.org>
 <ZnM2ywDVRZbrN6OC@slm.duckdns.org>
 <CAKfTPtBPObGdcaQF5nKqr4042f-+5obTMm_S6S+=3_Ct33ZMyw@mail.gmail.com>
 <Zog5-Yd5wV0-Y76y@slm.duckdns.org>
 <CAKfTPtDeA4OTPJmEHd-wKToYwDVizcny-_qxEuDUA-OcaVm2Uw@mail.gmail.com>
 <ZonzAdyd6zb2Sm06@slm.duckdns.org>
 <CAKfTPtDE2rWbRouf8zRyM3UpTfK1k_xrWmvAs-zfoRZqM3zGsw@mail.gmail.com>
 <Zowt7pVWFB-Of-me@slm.duckdns.org>
 <CAKfTPtB=77c-RsJ23suNZVf7qByeGSjYQJbiEU4JpXU6DezNLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB=77c-RsJ23suNZVf7qByeGSjYQJbiEU4JpXU6DezNLQ@mail.gmail.com>

Hello, Vincent.

On Mon, Jul 08, 2024 at 09:51:08PM +0200, Vincent Guittot wrote:
> > Unless we add a WARN_ON_ONCE, if it doesn't behave as expected, the end
> > result will most likely be cpufreq sometimes picking a higher freq than
> > requested, which won't be the easiest to notice. Would you be against adding
> > WARN_ON_ONCE(scx_switched_all && !util) too?
> 
> A WARN_ON_ONCE to detect misbehavior would be ok

I tried this and it's a bit problematic. Migrating out all the tasks do
bring the numbers pretty close to zero but the math doesn't work out exactly
and it often leaves 1 in the averages. While the fair class is in use, they
would decay quickly through __update_blocked_fair(); however, when all tasks
are switched to sched_ext, that function doesn't get called and the
remaining small value never decays.

Now, the value being really low, it doesn't really matter but it's an
unnecessary complication. I can make sched_ext keep calling
__update_blocked_fair() in addition to update_other_load_avgs() to decay
fair's averages but that seems a lot more complicated than having one
scx_switched_all() test.

Thanks.

-- 
tejun

