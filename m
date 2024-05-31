Return-Path: <linux-pm+bounces-8480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8188D63E9
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 16:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AB72885ED
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8758B823C3;
	Fri, 31 May 2024 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4fVDNEdQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4O8P8LK4"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0916A1E492
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164105; cv=none; b=HuqjKkaPkiWLe4mS46CPlHfju+c4K/T356yhJXQshrit6A4yixO4vk94HfiqhVxIzRk7Z81IaH+58SVobTmed/Y4g1PBLruA01SDcoJpd6jUCX0xZGeTBbPpvyc+vujURkVO8zFTcCZgy63YnxbaBKliYhmVUHqxt4I7p9Y2ZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164105; c=relaxed/simple;
	bh=lK/0nMMJ/TDipJSVBi64yBgAD33xFjkZEPEaZ6gUwsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf/BKzCjKVfQD3Ug6Q7kFC2GEZ5XCZNgKul1DaRfAn3At3aKDe8VLdvZcYhhrVZmCOvJt2TNfJJyzDGJKuhx1ULBUiQDmnrGt6ryHZf3z/rPMMTy59+UjeE+m4aemgtNT7kIt8dwpvYm0FsvGpYqEHXW74+d0H9ZXbOb01gvr+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4fVDNEdQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4O8P8LK4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 May 2024 16:01:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717164102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lK/0nMMJ/TDipJSVBi64yBgAD33xFjkZEPEaZ6gUwsA=;
	b=4fVDNEdQUVUlt3cfIGjlfC67Ld6JmFNrBueFKP+cjeybNk9Wp4aumEGNxBieQwFdbBRFGi
	s/+k3zHGA7Cdnj1cGaH2xt1/xRvq8VNZ1c7S7Iocsv+1tsMm0sIDBJ8znqDQgfG5AsAQUH
	EVEQUIwLClOu6cVHDkbyKxMMRQfZ5S80RfYjBVbewgPubItslSH4pBWPvTtE5z8Hg7SJj6
	AZ8DuDrX8RyV1uGu2V3ZYJdleRJU71cUodZ0tiddrPN/aXKohKKWc73yojoygEn/ofKuco
	PopTDALjQ2e3KQtlrEFQA5cqXmFgdEkIaQAlULObfzfHwH2vQOUHMhtL6tNPgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717164102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lK/0nMMJ/TDipJSVBi64yBgAD33xFjkZEPEaZ6gUwsA=;
	b=4O8P8LK4Ckj4JlDsfwIWswQF6TR4UY9knEmC7np/T/HffUEGrnlcGyeRcEQv/vjuTfz8p7
	s0VRlSAJkxDWBdBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: intel_pstate_get_hwp_cap on wrong CPU
Message-ID: <20240531140140.pfKOWdB-@linutronix.de>
References: <20240529155740.Hq2Hw7be@linutronix.de>
 <ca47b6f812175ea60f6ad615274223aa7fee295d.camel@linux.intel.com>
 <20240531110200.CtBSN_p4@linutronix.de>
 <3eaf90b63edccb3317968101040510c91b5b2f4e.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3eaf90b63edccb3317968101040510c91b5b2f4e.camel@linux.intel.com>

On 2024-05-31 04:56:04 [-0700], srinivas pandruvada wrote:
> > Would you mind letting
> > =C2=A0 /sys/devices/system/cpu/intel_pstate/num_pstates
> >=20
> > reporting something sane? Not 4294967285 but 0 for instance? Would
> > that
> > make sense?
> >=20
> It should be some good value, usually less than 50. Do you see this
> high number without even triggering condition, which caused warning?

Nope, without the error I see 22. I think this went "-EIO + -EIO -1"
which ended up as what I reported by chance. Never mind then.

> In your system, firmware changed performance notifying via ACPI. That
> method is deprecated for a while. You are using Haswell, which has this
> support. But deprecated from Skylake.

Okay. Anything I should change?

> > Did Sebastian _Reichel_ report it, too?
> My mistake. I picked up wrong Sebastian. Sorry.

Ah okay. Then
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

because it does not do read the MSR in the code path I reported.

> Thanks,
> Srinivas
Sebastian

