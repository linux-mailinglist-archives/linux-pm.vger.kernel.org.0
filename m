Return-Path: <linux-pm+bounces-20446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF25A11234
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 21:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF82A3A4515
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 20:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100FC20B80A;
	Tue, 14 Jan 2025 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNStDm26"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76296146590
	for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 20:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736887172; cv=none; b=Zc8qVGitP4XVINcT30cmrIYMWzgccmGocwzwytUAygOEz++faiyRxXZ2LI7r97OxR5UZyXgj2pj6hNxqxcIdCZkPVayBelwEGOeZUYCphlWgYoynwHaPe9WfG09V8OyjM8VDALIfwnkWqYPWY+CaB1mpjKgJIwSE2rIdrdZaI5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736887172; c=relaxed/simple;
	bh=7S87F8bLh/++B5Ek/t9oF21Sl0yDEu2m3Cn3XzZoFNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyHLlBiLHcYDljCWaG4N/eFhJkqnYm6UzE5NRpn+T0aPG8cfFqrCNfmXIUMwR23iN03s1OMBxX4Zk1VFNlMnG4K+460QLhnS4hLSJm4+NBGWdN7aCSMM5PeQ84E4Cy3caksYqtIQP+mVaW3AbUuUu6LqRJA2HVOdE/IlLVIuct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNStDm26; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736887169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SWJSCrgaLK67vBW7t7G3KMTfbi2TnhrA3mKegVxocUM=;
	b=MNStDm26Cg8R1Wxo7ZNzP7ccHYmLjdScLa7uuRQD7+ERrA/bbAQPCUNIVbl3oMMFErepcI
	ygdx356Y3+YJdhLMp1XkgZTxtqmDjuNoD5jtHlRaKRz3lvw6mK7V3UnwvtMoKAk2LRKWRc
	HGBVA7dF707J1pfl8pU91Av5kuxUVDk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-RyDIInIkP8Sr6hOVOC2n3Q-1; Tue, 14 Jan 2025 15:39:26 -0500
X-MC-Unique: RyDIInIkP8Sr6hOVOC2n3Q-1
X-Mimecast-MFC-AGG-ID: RyDIInIkP8Sr6hOVOC2n3Q
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-467ae19e34bso182466171cf.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 12:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736887166; x=1737491966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWJSCrgaLK67vBW7t7G3KMTfbi2TnhrA3mKegVxocUM=;
        b=BfiNuBHR/w68S9UuYcezBmA8+g8/aZD8PLnqubbhAx+8NKMQHD9J5xJPWImLPPcJB6
         UetclrqiWK4JmKg6Bx4lZXw/1hYBOSNFPQMUlYjfkxyraidUzJ4D1SdL/iV1K/OAPnle
         oSTQY0ib8LKgqTB8M4lUS1s3mlYcJZmG6Q78kMNFEDjqZQF/evgJ7ziH29GnNZRkn2+t
         TL2IUv8gylQPsEIpVh7xJQt0JXczgrimwOAS49DOjrE8MyMuuR8UurT1PVuYmIm9l5DO
         H7b7/f81zsvMm7GoaGs3N61Hc8DdDnrrwg5pftN0K0pYArS/7KaEUkZKmOSHJ9IjOS22
         d0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVjVy6KjGCtIDvF1DwrJxDK9byq/f/rTMkDJCIvw7Lf3SuXzMlSGYbyn3vXZVFyPIkbYK6geeXljQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwX3xvVeVz2yeUv7IA67NaYxKdNkLa1aRooStKVb1OOGoehgiHJ
	ZhvSaIj3ni7PEXUmGnN7cgpA8lTrnizIDhxvDP2DKlcCOLG3LGcrk79YRpK9W3e0VLOXS6nrHi2
	gYdfoS2MD/Y3UEiQ4eIBgLCsNvcdo9PWgcSeGv/EPPH3sm1m+d3zX7Iwm
X-Gm-Gg: ASbGncsisnwT1t0+ORx9tvVBPQHFbRfr92dN/jgF/Obe3y6dEu4nuvfWK9GL25qSIoA
	MlLCkPecWHxKZu+/b3g2vtKM/dUL/lgkHswssTjNgNJxaOvvQ+XKaW6qKnax8JwKdSZ+xpjfa0Z
	4J1JVFBk9+nZroAeizOqvBw5QsdzkyyZfpxTfMnZVZs9BFrtc+K1IAaA635Nt3HEtotQXbY8oee
	SpCg5ew1HXROA+RDgjNXdkh00Xo7/8xXwJRTfIWhQ/QKGq4B6Prtg==
X-Received: by 2002:a05:622a:1a8d:b0:467:8765:51bb with SMTP id d75a77b69052e-46c7107e0a9mr478654831cf.37.1736887166133;
        Tue, 14 Jan 2025 12:39:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1VQXMj393+NSNp6pT98xnavABEJu58M+PjEbdaB3kFAkam0UN/cLp0TSCDGkqct29umQ+iw==
X-Received: by 2002:a05:622a:1a8d:b0:467:8765:51bb with SMTP id d75a77b69052e-46c7107e0a9mr478654491cf.37.1736887165855;
        Tue, 14 Jan 2025 12:39:25 -0800 (PST)
Received: from thinkpad2024 ([71.217.66.209])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873304cdsm57177741cf.29.2025.01.14.12.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 12:39:25 -0800 (PST)
Date: Tue, 14 Jan 2025 15:39:23 -0500
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH] pm: cpupower: Add missing residency header changes in
 cpuidle.h to SWIG
Message-ID: <Z4bLe1TZ6G_5yePa@thinkpad2024>
References: <20250108221852.30771-1-jwyatt@redhat.com>
 <Z4UdWpRie1ZsJ4tk@thinkpad2024>
 <4f4ad06c-b2e4-4e3b-8ec9-85cb81e61ae0@linuxfoundation.org>
 <03f5eb31-32b3-4dee-934e-05bc0bb0eb06@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f5eb31-32b3-4dee-934e-05bc0bb0eb06@linuxfoundation.org>

On Mon, Jan 13, 2025 at 04:17:32PM -0700, Shuah Khan wrote:
> On 1/13/25 09:36, Shuah Khan wrote:
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower
> 
> Will send another pr to Rafael later this week.
> 
> thanks,
> -- Shuah
> 

Thank you; I appreciate it.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


