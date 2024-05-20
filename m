Return-Path: <linux-pm+bounces-7983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 427618C995F
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 09:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAB2280F9E
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 07:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EA21B7F4;
	Mon, 20 May 2024 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPHSzAEO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6571618EA8
	for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716190526; cv=none; b=kPrMnNuZqa8FIeQo/8psrqftBwseccnnALRikJ/SiJJ7QbDXDOkzsrDplPX0+vfrmG7gXL5h/A3rWRzV6NWrEt99wXpSw0dlsJEEPsWJ25eCrjn2A/A1/8DoJHsuWaywd/OhP0fclDsMuNZVGP2RK2GRcxIVq5RqmluUjT3IOIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716190526; c=relaxed/simple;
	bh=CreGSXMBFRDdh+HIhlg2OcR+mWGxYmJCDZEvadFcUiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tH07j8fFEhxW2OaLe6vEf/5Wme2cLVZq2+kbb8tr3kB5E62f4je0OqLbwjXGiw7Tw1+dyVgWmfT1UYjsPBE0IhZ+uoXXHV8kWSx1Ktw7SWdqCI1S3sR6KRX+Jz82Z6B5jeV872TFXSQhoWS/5kRemKuSV8VWNe9UmGsUAc0b01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GPHSzAEO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f2ecea41deso56684115ad.1
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 00:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716190525; x=1716795325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TdeskcQGCOqUgsMYL0wvQIQkx8Opxo9clxqEYF92eYc=;
        b=GPHSzAEOfrDshMyMDR1sf1Hx1I+UK5XRkpI/RG+LDkJO/JgO9YcUuvUakpaXJI3Qtc
         V4XPrGCWDT6HHXZTuzAJjJ5ts7GfpHM8wHtnCvhh8NuaQKj1j8zFFB6cu5STuEiGyDOF
         KGdWa3FOmu0Ggdl5/aRjY79jNGVDnHgIIT8DworrQOYWoFG3tRZ6JHCy9b3B0NBTpksd
         ln9V4OSmmZzj+6YGQB0YWtiAcSpXw28Y1FtbqVN6DbmMFGDReMbrApjOaX4LZwy0LcDn
         PiumhBgMJvKtvydlOeAGw4SFUMghvWvtXr8rjTDe6S0V5sNReBLjxBZBtf7how/kAftA
         CU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716190525; x=1716795325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdeskcQGCOqUgsMYL0wvQIQkx8Opxo9clxqEYF92eYc=;
        b=Qgkl840VxFQdQkowDURW8zbNgs7uCBN7BWkdzXcEUvcnoKA381yj+AGO8u6ijdSCiC
         T4GVjxfp5QZm177R0YeqowMxBr0TCfLmL15zRtcCT17hp/Cy5n4Qs4PwF9vXp9bmFipM
         n0e6e6Bibk8IIGvpG52Zbzxec7oOFrf62X2H0nLWTXSjYxNWlrrf8zLwS+d14oqVA7c6
         ox40FSH657SccQBqWobkui87UB0tZqLDU8eDMsqLynH7EY5HLjXyL+MO/9My3bXjSmQg
         mfBPr4oUizUjGAQQaiKPhWZQDPzD/udednn9mQxCLA7rraLBZDGNJ2Qv7POjPEHbSQPy
         Tq4A==
X-Forwarded-Encrypted: i=1; AJvYcCWUMstNa7U86/GXSX+CS9xXIrnj4Ia6791C7Jac6SuBgopGBxXRKFQm9Vju/vndimR3ZNmtCY30XOvCSvyyWLF2fKKeXs9aQ6c=
X-Gm-Message-State: AOJu0YwZmDNG7VVwf0bSQ74m5S3p1HCuMA2s2QTu8v3UqK9QEG4W2HEw
	CUOygchNHOsZ1wTe25cMV1s+dk7v3kt7GVGdwRrPztzcS2Ev0bZzkblzG7uDdVk=
X-Google-Smtp-Source: AGHT+IHPnUMf1hHaC0TYUlsq97fbQdCCRP95VeDkuaFDGW9CA2YAIYyeywDjHu54+bcWgGQVcpgq7w==
X-Received: by 2002:a05:6a20:c78c:b0:1af:cb89:15d7 with SMTP id adf61e73a8af0-1afde1035a8mr32774233637.27.1716190524677;
        Mon, 20 May 2024 00:35:24 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bd7f6c90f0sm1214435a91.2.2024.05.20.00.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 00:35:24 -0700 (PDT)
Date: Mon, 20 May 2024 13:05:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] OPP: Fix required_opp_tables for multiple genpds
 using same table
Message-ID: <20240520073522.3nhy4x6fnrqxay6x@vireshk-i7>
References: <2eb72832e852c80e5c11cd69e7d2f14cefd8b1cb.1712903998.git.viresh.kumar@linaro.org>
 <e6fc06eb-fe52-4cb3-b412-a602369ee875@leemhuis.info>
 <CAPDyKFoHoKK-RZsGwnZhbW9_ZRQtL1MFZBuVVLMx-MxL2cQQbw@mail.gmail.com>
 <7c6df194-fce1-401a-98c5-c903d78627c4@leemhuis.info>
 <CAPDyKFqKRy6zJdBpK3bNTvkvAjty691-Vi_HV3E5CeqgRAWGmA@mail.gmail.com>
 <CAKohpomKbhdXRgFxxbg-_hG5EFZT0LrvfQcrwjQPon6AZNbGag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKohpomKbhdXRgFxxbg-_hG5EFZT0LrvfQcrwjQPon6AZNbGag@mail.gmail.com>

On 11-05-24, 10:03, Viresh Kumar wrote:
> On Fri, 10 May 2024 at 16:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > I wasn't sure of the level of urgency in this case, as I don't think
> > we have that many DTSes upstream that could hit this case.
> >
> > But nevermind, it should be easy to revert/replace the change when we
> > have something better to take over. Viresh, feel pick this up - or let
> > me know if you prefer me to pick it.
> 
> Please apply, while I enjoy my holidays :)

Merged to Rafael's tree already now.

-- 
viresh

