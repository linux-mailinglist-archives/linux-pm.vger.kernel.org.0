Return-Path: <linux-pm+bounces-40519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9F3D075EE
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 07:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46CD0304AE45
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 06:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2B6259CB2;
	Fri,  9 Jan 2026 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xa8IwATj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B75A264609
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 06:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767939479; cv=none; b=TBFE86JKVX8M65cRNpZRbI21Q9+rQ7lNn1ekI3CNh9ix+cwVBSNXAal6tgsiRJ4i39HTuxIfv60KhSlQzigRovMB5HquEf30VtTlTv2zAviliLE1wGEwXasYV8K3oedfSSNorO0tr/MH7tzyyDT0MKmIpq9tfz6WdPAPmQxuChE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767939479; c=relaxed/simple;
	bh=CGip36cfTFvK3Lv6opdxPaeDlGHUGzEci/WJdcaiFYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU3vE2xKuENZSSx8oaLoGWzRCs4dM9hADXlgqmfuBjqKx9NEI/K2AnHIW5Nb2+NH+qHJxu+LF9XJa+7947YuRqLnsF4q+skMvwGiAUXn5XSIutD3NKlRFrh2Q6GjUjLRDStTHrvdiTBeKasK8f5zND6c9WgrWmEhatAvcu4j/fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xa8IwATj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0d67f1877so32916775ad.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 22:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767939477; x=1768544277; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B52PeAVE9EHKJJWWUizpCaS9qNQYPh2fiLhyiMX0ipI=;
        b=Xa8IwATjwIl/J2ypIxriAvcNO8SBvDQmMOk8qn/vKttzls6hRL6GmFW58npMpkerY4
         +n3K/cuCWfMEKnvf1xEdkCj9rHhBTzx1MEpMUQUCt/wpwsnipFvRiG3IfcmHE59J4H5v
         Bld1dp36mH3BcCj/ppX+PLSPlIsObk1f1KjXSlpwDjWv6Ir8auFLbU+C+3DGUrcWQj99
         xyhTnDTmzq5aCni0W0SfUqh68KwKSgNmdfcshs9uoLW5IF6jgZyQUHCf8FQSWnNidQ40
         vuQOJS96PrmOvh2uib2QCIY7qHnIPGJdw8E3t996JwH+wc0/W+LYcelb58yg3p3KeGSh
         0r+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767939477; x=1768544277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B52PeAVE9EHKJJWWUizpCaS9qNQYPh2fiLhyiMX0ipI=;
        b=G/oDA5lpPyR6kROimYgPFwcSmz+gAaGU3xR5oefdbEv88iUiR/DBJUm11zD3IqriPh
         mG7R4ktmRTfBJSO4ABAe7uJ4NA8R+cl9AMjgILl5c+uj9HPOErS8aOpKBSYFklRATkx8
         +HCp/O5tf205Ne3Of0L4+TihNYnfLupVt/b1h94Vsp2ka/YXE0/Uu9rntm3rGghitd+R
         zxlIbTyp5IIndzJba7ExW3Ha+aB+QyyPj+KZHXpJ1pX8Ur1PqUrHQzV+SSRedEfYC9Rs
         KO4yUToMabBWs5D1eBwfd9aYPYJLQTo3xoIM8r+I/imlxcL0stmRv5MIlb0bEnoHf3u1
         lNXg==
X-Forwarded-Encrypted: i=1; AJvYcCXbZ8V2n4LYAB6pdsjOTjOAlNKEIZEFCvG+1XiWjrOgl+9neFQDQcD7AI88ukJ0pEbnpSaH9IHV9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+oAXZI+PYSRVZxWZhJb5a1y8keGFZy4gEx7/oQOIoFs3ErCYl
	fU/fVtsXJRw4+lymqznRYy4s/R+0Kd/m077xrmr0KE33bOkgjdisuPVnJBkmqWxxr3g=
X-Gm-Gg: AY/fxX5dBcvGJj9jhPpoIQpF4hcXpnU5DLz53EKYUgoaYH3RN2rrTWWv0jyllhoGQ84
	tjVipcclpTkS7K5wBF/PLOXwYrGMbl0IBn0evN1VPIvJMO2tEgsjn4DDmchTre9jEUScbkrYdb5
	5I8SlBUw24XW2jNtd3ZSXBbiOvf/nplrjqFDmBVLankgxcE+LmkjRLcHw/vwRhDBIa08kEU7vQj
	OsQ//plw09XX0ZJRtmjeq3cab3UbqA2zdbWT/GO3/cZcix5jwJpgegUzsl364WvsjMs8pqdYJEm
	EN4X30fFtNlFd1eho9+3QrB+mriomaR7AmV1+wfoCahkSLx5GGcGvzyYzNdcTk+Iw4NM5s98FeS
	rkeylW7qFoFjWQbki5amtaalo/7ZPlIJHq3Zx7Ev6bmYVtNyJs9+B5eDKEMfG9g2d/ua0beqqvz
	So9DH8HPnmeg8=
X-Google-Smtp-Source: AGHT+IF1PUIM3YJ5c1HvljBDLvp2Yx+KSeiQZ8I5VnVq7w99w4gGuEPnNAUPEIdLuCn2hfk0/VLznQ==
X-Received: by 2002:a17:902:da82:b0:298:55c8:eb8d with SMTP id d9443c01a7336-2a3ee4b5deamr81552665ad.35.1767939477109;
        Thu, 08 Jan 2026 22:17:57 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc8d76sm94621785ad.84.2026.01.08.22.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 22:17:56 -0800 (PST)
Date: Fri, 9 Jan 2026 11:47:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, 
	Andreas Kemnade <andreas@kemnade.info>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/2] cpufreq: omap: remove driver
Message-ID: <7nujuxlfep47666olk4fvd3qyitg7hkwso2oigqy3nkcrvpryg@wo7zfgczegfl>
References: <20260108-omap-cpufreq-removal-v1-0-8fe42f130f48@kemnade.info>
 <7hcy3j6ete.fsf@baylibre.com>
 <CAJZ5v0jePerpMJR8CbiMKOKmSV6f7BLc0ZO6wTQztLvw9Sj3PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jePerpMJR8CbiMKOKmSV6f7BLc0ZO6wTQztLvw9Sj3PQ@mail.gmail.com>

On 08-01-26, 21:28, Rafael J. Wysocki wrote:
> On Thu, Jan 8, 2026 at 9:16 PM Kevin Hilman <khilman@baylibre.com> wrote:
> >
> > Andreas Kemnade <andreas@kemnade.info> writes:
> >
> > > The driver is not useable since 10 years, and the affected
> > > platforms have alternative drivers, so remove it.
> > >
> > > To: Rafael J. Wysocki <rafael@kernel.org>
> > > To: Viresh Kumar <viresh.kumar@linaro.org>
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > > Cc: Andreas Kemnade <andreas@kemnade.info>
> > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > Cc: Roger Quadros <rogerq@kernel.org>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > > Cc: linux-omap@vger.kernel.org
> > >
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> >
> > Acked-by: Kevin Hilman <khilman@baylibre.com>
> >
> > Viresh, this is/was technically maintained by me, but feel free to take
> > this via your tree, or let me know if you want me to queue it up.
> 
> No need to bother Viresh with this, I've just applied it as 6.20 material.

Thanks Rafael.

-- 
viresh

