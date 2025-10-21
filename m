Return-Path: <linux-pm+bounces-36536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5CDBF486F
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 05:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC9534E4BF7
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 03:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAA821C9E5;
	Tue, 21 Oct 2025 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HXf6AR6S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB51EB193
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 03:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018199; cv=none; b=H6GqGRtPvh/DIUZru2n/nIQ0oAzvjzjApl81+GQFLQDL8eRbg2bC4pVQkfGvfvP5qMZnb97h0TYg16a9JG1yEaXgZiTHF5GzZPe+RILd4cG82h/f3WFRkMrMJzPbyE5mvpv4bXfY6Tf9xGijy76LAfG2/Z9kGuqJoO23df+9Kgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018199; c=relaxed/simple;
	bh=nbBzwttth1UnlFkWL+G5/MGyW0tHPQmic+LV4iQ4s90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJ25IdXLyKN0e8gBYpvYjZ4twlaK8J6SZGMyzdSV/4pi+jYDUhu4Q83NSS22oHtxBUO9BUoNHAHw3Rj/qDph19gnhpVv9B1aTqUp1uJDGpmFEKhjMmjXbc4bbMiMnPd/lL/HqyvyFHfuuilgizo5tbeBGiIbAkV29RqOm7K+udc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HXf6AR6S; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7811fa91774so4499461b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 20:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761018197; x=1761622997; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xr7US09S8qqydwr4G/9BHixKcLW/nGB742179WdAweo=;
        b=HXf6AR6S+thw4MAjkMLm3My+5naBeeWdrHooFR786WFOdWzYwXdLu7YKLRGOWpzhtS
         zQNs46MB2gM8YobUSjTFHYDnr6MORGSC9UrRraNZ/Lakixeag28veIXGh36BeagIfzzl
         ehkOawJwLLY2SFaUH8k/NE1QcxqBfC/UZ85zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761018197; x=1761622997;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr7US09S8qqydwr4G/9BHixKcLW/nGB742179WdAweo=;
        b=NZ6VVNn9LjyhLvZfAspBCFv29KLeMZUyVOhc20DyJac6GV3T/5dyC6tFZaYeOEVD0w
         hCFz9goUXBJZqs8TdbtEcrBpjpFgGi0pLIKTrP1m7niXRIFj20x6aQzuRebECnphMXc1
         OD/vNqV8zLO/UgjHKOZdQxmJHXwdGdlS58zdBu4oaEvk/92Gjr8hmnNrSxKwVNdzOpgW
         OLjoyyyEVKr0evh6ezKE1AkZf4UQl8A6FNvYkLUPC9bKC3qimNH1VCXhkKybh11T/bsY
         9MvA22dHzHAE4j99uydE2oku6GM/LecbZ+UnpNPExbJM0jJK/WGyjWyIl/FCR38IZFEu
         OozA==
X-Forwarded-Encrypted: i=1; AJvYcCXA12cbnhRkgEXTSHzq1At01g62/ooAz4oMiBawurM7t4+Sn/TK1oO40MblR560aeiswOyhbZ/tvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwOuKQtB4HCKn9WXMG8LlMB+9Mc1qKsINCS2pp5mkTo4KMgX3Y
	Yx1nz2j9DJKk5RJ2aAZubNSdHAo9AoyiNYvGNGkJeAOrwxEDYx1Ga8pohHc7M2RQ4Q==
X-Gm-Gg: ASbGnctpdv9g2N/06TjLC3pPzd3an5AcSYhVgvrPVDZ6BImu7+0ddO+wXJHExfaU7rZ
	Y+auWfEzcstR6WUqmtj+nWMx3rD2ZEawb86FPy7sPW5lx/cnZcudP4tS8KCG/T9QNKkrCQsiLgD
	AklKreNC7ih0NcJ+EGqs+YUimaBUNR5CYCrqnPUU9V75FBlGiI/r28Z/3FHWMpMTsjRWBYvjTpX
	02p/5rDhekzVYPVFNf1SaSO76xKaHRThoY51DnDwyq1HiB2fYk6g0a3LeolPtcLJUgpiGjcjJEf
	HAe2ITcv3G12qLWv/TWa41uv2hXmYTG8N2q70Bbg+biRBrPXwSoKpMoSmcYWk3Vv55kZs51fkht
	jximvJ1KIOQhiDEpmTNfudAeKo3J+halQZCwdq0vXTAf/gdC1KdDc0IqOTwgQCJE6mZMiqrLlMG
	tE9aCOrhoy3JBQbA==
X-Google-Smtp-Source: AGHT+IE/m6Pnmm6QG1kxaMZaj2yh9jqr1scnjiIgpm7t50PZ0mb2TcvYsQ39BhAG1mhtNI+3sHgXnA==
X-Received: by 2002:a05:6a20:6a0b:b0:32b:83bf:2cdb with SMTP id adf61e73a8af0-334a8524332mr21571201637.15.1761018196691;
        Mon, 20 Oct 2025 20:43:16 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3364:b517:9129:5413])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a813d4766sm7375833a12.5.2025.10.20.20.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 20:43:16 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:43:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 
	'Christian Loehle' <christian.loehle@arm.com>, 'Sergey Senozhatsky' <senozhatsky@chromium.org>, 
	'Linux PM' <linux-pm@vger.kernel.org>, 'LKML' <linux-kernel@vger.kernel.org>, 
	'Artem Bityutskiy' <artem.bityutskiy@linux.intel.com>, 'Tomasz Figa' <tfiga@chromium.org>
Subject: Re: [PATCH v1] cpuidle: governors: menu: Predict longer idle time
 when in doubt
Message-ID: <x4qvjfwxzatm6wnrtqgue7y673oqzo74i6ysmxalvnts5olkot@ekaee62fjg5l>
References: <4687373.LvFx2qVVIh@rafael.j.wysocki>
 <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com>
 <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com>
 <28ecb23b-ecee-409a-9771-24f801081d07@arm.com>
 <CAJZ5v0jMoEVUaYYPx6EtHFxsg6TF-QtDWJGrasGK7C2C+JxOFw@mail.gmail.com>
 <001801dc4041$607c19f0$21744dd0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <001801dc4041$607c19f0$21744dd0$@telus.net>

On (25/10/18 08:10), Doug Smythies wrote:
> On 2025.10.18 04:47 Rafael wrote:
> > On Fri, Oct 17, 2025 at 8:37 PM Christian Loehle wrote:
> >> On 10/17/25 10:39, Rafael J. Wysocki wrote:
> >>> On Fri, Oct 17, 2025 at 10:22 AM Christian Loehle wrote:
> >>>> On 10/16/25 17:25, Rafael J. Wysocki wrote:
> >>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>
> >>>>> It is reported that commit 85975daeaa4d ("cpuidle: menu: Avoid discarding
> >>>>> useful information") led to a performance regression on Intel Jasper Lake
> >>>>> systems because it reduced the time spent by CPUs in idle state C7 which
> >>>>> is correlated to the maximum frequency the CPUs can get to because of an
> >>>>> average running power limit [1].
> 
> I would like to understand Sergey's benchmark test better, and even try
> to repeat the results on my test system. I would also like to try to 
> separate the variables in an attempt to isolate potential contributors.
> 
> To eliminate the PL1 effect, limit the CPU frequency to 2300 MHz and repeat
> the test. To eliminate potential CPU frequency scaling contributions, use the
> performance CPU frequency scaling governor. Both changes at once would
> be an acceptable first step.
> 
> Sergey: Would you be willing to do that test?

Apologies for the delay.

Sure, I can give it a try sometime this week, am dealing with a bunch
of other stable regressions right now (will report separately).

Can you please help me with the configuration steps?  CPU freq limiting,
etc.

> Sergey: Could you provide more details about your test?

We track regressions in a number of tests.  The one I'm running more
often than others is a Google Docs test (our tests replicate real use
cases).  The test in question creates new google docs (in chrome, of
course) and inputs some text in them (with various words-per-minute
settings - 60, 90, 120 wpm) in English, Japanese, Korean and other
languages; different font faces, different styles (bold, italic),
text highlighting/selection, windows switching, and so on.  The test
measures input latency, the number of dropped frames during scrolling,
CPU usage, power consumption, etc.

