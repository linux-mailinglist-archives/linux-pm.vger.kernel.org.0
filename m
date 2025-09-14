Return-Path: <linux-pm+bounces-34609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B01B56AEB
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 19:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D913BB2B5
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 17:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3987D2DCF50;
	Sun, 14 Sep 2025 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="j8pabMHE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3104E275B12
	for <linux-pm@vger.kernel.org>; Sun, 14 Sep 2025 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757871812; cv=none; b=XVnYPVoVapnGqU2ir0YaJ4r90EFh+gs7TAkW7tZRGskHBgDo5aHfcgjvVDj026iYdvAjilWyUUjI2VXu9WD+DCpySUWRBNFjGOoTldKTFnKs+m2iFLjMuGMhYgD02pnn+U9gjFgOKs0it5BS3YWNk6mCWm4sWpHWelpNluc1kxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757871812; c=relaxed/simple;
	bh=Ryys8VUIqN5H+IVOdF/nLFXxb8kDNnVht7qZSDjh9pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIEmpkkTy7edVOKJTSBjt1+tW6OGjWSu7JzJNEchWytaQwe0y1ridF7wiO/Jy3Usu54/AB2Dn6tJrGIsxx5rZuKNfPythX5JEN96LBOCB9KfLzEx28dtzW6/H2wCq8d+VQnotJFRueKAnaUL4qvCGddv9CSkTOxuu5uhx/Uqvyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=j8pabMHE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso24408465e9.2
        for <linux-pm@vger.kernel.org>; Sun, 14 Sep 2025 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1757871808; x=1758476608; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8jDXbU3SpN0Xo+axU4p7nE5zZEp9R21umV9iSQ59EdE=;
        b=j8pabMHERj8gkPl6XVwMdj6egSNRRgakjqaFh7CQY8ZfVIKfRrCeNLXq+ADzQZpYNp
         YihdfjGuzlFZB1Hgt1y6kW8HSVuvbPOP4G112w8LEamzRfUkn03zCKVDbeniKlCNzzLI
         hAA/cUg6n9Lf9K6Dx8/VEeMr25ubNxCwB6hWm0MNORAFY7I4kf3PXkYW8JUpLHB6b6WN
         0Gl51Jrp8LIyIIOGhMe+0YKWFoD8jzo9bJRf7Eclv0s6l/cBoKtzfVhHeQ4GTe/XUEDh
         wKclXxKNliKfw8TqPtyuCJ3vQEIEuCicp/BxrmgJm5i7Per4/kM0OUBlwghkkvrXXS4V
         WjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757871808; x=1758476608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jDXbU3SpN0Xo+axU4p7nE5zZEp9R21umV9iSQ59EdE=;
        b=AqGZGIjBU0xY5rrMuUtyMsPodpHHGWx+qJP4xyp7JtmQzriDREq1u4Dd4WDdmvs1V2
         KVOvAaXmXDuAbrl6cZUAc/0OvEMAk9v5IfLRH7QFOqawheGLU7KurE66qjX4l7Btxo5v
         TyztUIhp1JY6/xjavUVgkWaGVlHn48qIwHBzZj5igWdpIWMKHZezFfxAfGs+mdBwJF8D
         KW1XbMMHm0C9sUWBRmoqGDXCk7i5EmLX9JbGUUMugp2pPoYbo2qn1BXQpS8v48cO4PCw
         DH0rbWpek2EwE9RX8tmLQBTGmEB96V8aV1JRTv12N4akUGhZbE34BgVW4Llb5GLop6Ml
         h32A==
X-Forwarded-Encrypted: i=1; AJvYcCWYEMrgQM9VlY5peq1qaEi9nBzH/0/G7WRBXghnUTfrbHX9vmT5hAWUAHcvOi3pV2d5DgKCeZzxZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Al/+T6+tOeKiWA7AJJoxcscTU1OIb5ND96DBPB5/0/8N/p/8
	SeXbPh0u2pACmneRQVWsUsZk34jg15XUMXvS34YF78FS+dLkuCJsT9Ma0fQDaAR6PTg=
X-Gm-Gg: ASbGncswLHY8QDPn4TY2mxGbU0UKsmUpS51B7TWjnDDHk7GqIwS6O4GZ/932wzI2Rch
	8m07das/fU/VR2W4allWFInQeJSFodqanRlw+qhzoSQlgRLaIcNOiuA5MWcxx221R03to5GYW/T
	SUV8BApI0lkeNwib+SozHZhO7OugkkF4cvj8jt8NxVyqJTqGLuBbMVOv4sp8aMmAhZVR93iuIKP
	CJ4T5D7pK/12hq+M+RaAS/zpHMYtod6uPRpVZ6i+szuBETEloAyM+YKAJVMwQgfq1LNKlJ9843v
	z8TATfuplbB/m/k7LDCRSQTvN73hKsyMAvom5dP50GAClkJjFoWLK2ETCCIdtqgke0jdcKUngvq
	kDSxrmCnOSDpzKB19Ojlk5FoOUs7lyu2JIjyttqiVofU5taIfl44O4ErjAE89esD4Ck+oCdg=
X-Google-Smtp-Source: AGHT+IE+T2eeWGYqh9T07uxdNYOPCRMCR0PjTPw88lyvl1tUrpS1IRHTqFmX5MMmPi6cwIW7C435MQ==
X-Received: by 2002:a05:600c:c4a3:b0:45b:7e86:7378 with SMTP id 5b1f17b1804b1-45f21221e3amr75486365e9.34.1757871808294;
        Sun, 14 Sep 2025 10:43:28 -0700 (PDT)
Received: from airbuntu (host86-160-23-239.range86-160.btcentralplus.com. [86.160.23.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01575fadsm145376405e9.6.2025.09.14.10.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 10:43:27 -0700 (PDT)
Date: Sun, 14 Sep 2025 18:43:26 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: cap the default transition delay at 10 ms
Message-ID: <20250914174326.i7nqmrzjtjq7kpqm@airbuntu>
References: <20250910065312.176934-1-shawnguo2@yeah.net>
 <CAJZ5v0gL5s99h0eq1U4ngaUfPq_AcfgPruSD096JtBWVMjSZwQ@mail.gmail.com>
 <aMQbIu5QNvPoAsSF@dragon>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMQbIu5QNvPoAsSF@dragon>

On 09/12/25 21:07, Shawn Guo wrote:
> On Fri, Sep 12, 2025 at 12:41:14PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Sep 10, 2025 at 8:53 AM Shawn Guo <shawnguo2@yeah.net> wrote:
> > >
> > > From: Shawn Guo <shawnguo@kernel.org>
> > >
> > > A regression is seen with 6.6 -> 6.12 kernel upgrade on platforms where
> > > cpufreq-dt driver sets cpuinfo.transition_latency as CPUFREQ_ETERNAL (-1),
> > > due to that platform's DT doesn't provide the optional property
> > > 'clock-latency-ns'.  The dbs sampling_rate was 10000 us on 6.6 and
> > > suddently becomes 6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these
> > > platforms, because that the 10 ms cap for transition_delay_us was
> > > accidentally dropped by the commits below.
> > 
> > IIRC, this was not accidental.
> 
> I could be wrong, but my understanding is that the intention of Qais's
> commits is to drop 10 ms (and LATENCY_MULTIPLIER) as the *minimal* limit
> on transition_delay_us, so that it's possible to get a much less
> transition_delay_us on platforms like M1 mac mini where the transition
> latency is just tens of us.  But it breaks platforms where 10 ms used
> to be the *maximum* limit.
> 
> Even if it's intentional to remove 10 ms as both the minimal and maximum
> limits, breaking some platforms must not be intentional, I guess :)

These limits were arbitrary. The limit was reduced to 2ms initially but then
were dropped to avoid making assumptions as they are all arbitrary.

> 
> > Why do you want to address the issue in the cpufreq core instead of
> > doing that in the cpufreq-dt driver?
> 
> My intuition was to fix the regression at where the regression was
> introduced by recovering the code behavior.

Isn't the right fix here is at the driver level still? We can only give drivers
what they ask for. If they ask for something wrong and result in something
wrong, it is still their fault, no?

Alternatively maybe we can add special handling for CPUFREQ_ETERNAL value,
though I'd suggest to return 1ms (similar to the case of value being 0). Maybe
we can redefine CPUFREQ_ETERNAL to be 0, but not sure if this can have side
effects.


Thanks

--
Qais Yousef

