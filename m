Return-Path: <linux-pm+bounces-21000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22780A205D0
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 09:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6938C18886DA
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 08:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455BB1DC994;
	Tue, 28 Jan 2025 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrFiKzBO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9735166F1A
	for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052308; cv=none; b=Dh1RoUjEx4QRlu435CkAh0z7qrpCz9XPZ/LkP6moivoHHLYPcI+NGHZJ1FIDU8nBU7sJE+9AtQ2EwrnhqmW6cWCxMQMPZPlVuN4qiyVm891bT3pKgERt5gaWJvYLx2rqP2AyfhfXsdLJlN7OfWz4UHMoecMIE/rucPFxko4c+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052308; c=relaxed/simple;
	bh=mH3TeXRXeNIlRo1TrcetDq4meEAgHdCVaEYb6938LpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VB2TlL7V+jXMI1hNNl0B1Jm/id91GwSVNtYMbMvnC7Egy0maetL51e8POuyaiC1dUhiXLm120srFTWjUzq6A6uXWSqcTDDH/1M4k6jWoKpgZapTGDC37IYVeeiCTIzjJJsBSaGK8mqY83Dli1P8ggoR1/gHJuTvIHBGY66n71+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qrFiKzBO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2164b1f05caso91015495ad.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 00:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738052306; x=1738657106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yaGWsF28qt5Jmz9b8bZehMWnKFK742c5atFbL/t08ns=;
        b=qrFiKzBOnFqbKaCMfXhkGEFXuCotK2YWVGVL34NyGVQhPlssBSWbzox2BNKk7SnVnD
         1I48R6EWkAwE8gzyGL1K5ACd4TqIclgpGJSWfZ8DakAtTwXohlUIHqaLUwpMYCjpKijo
         l9Su8Socg2WEkrfuzX2NJY/mxWsNkkyePsKkXY4xKuwMIlEkvU+XNYD0m/Yk0WAgBabi
         rVN+97ExPCRcnsv51tclmhZpoygFafZIaiGAXhhfFNDwSXTgfB0tDROXcp5EbkAkVD3S
         xVtFnFbxasC2ibnL+rVGoC3Fn5Bcp2jlTAUt+/lcZfk8KSZva0pcQHllYIBpqYZMPHzB
         vKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738052306; x=1738657106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaGWsF28qt5Jmz9b8bZehMWnKFK742c5atFbL/t08ns=;
        b=N8PJFZrRpOBeJaRFtDRon1uNgQ5TEosnuNWMHw/66K6zUMBXt8QkNvy7g4p2hNBUL7
         OtqYx9ETnbd7QfW6BS3QE/2yeNCWK8gkkNRK8h4QGFlJuSqORT+Hp9wUV16kdlqId4sE
         CZqZa9LuaVGJy8oWs4pSfMkK9YUJc6IfSeYl6vlamAPjOgZVcY9eTYyTRYOJ6UfJDxU2
         2Cxb3JaERlCc3pU9xR4ynyxKyXWMm/ZzJYMY3pPb4tOJHfzJ4/eQC32SjZF9oUfNOZ/p
         rYISOMlNO0y2c3KMc0AbXu7LeNPi5bGS7NEJlb4WEzKCEsL90/zjEODiQvhiQ3TAP5wK
         B/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmd8JC490Ck4RWn/2ZnfV53t40oMzFRlRgGqU4PIRKZMbW0wplJkHg5vUg/LXOLqXrS5e7naXfSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1/dsuz978moMRw+ehs6m0upl20yEaAhPBaQ/jL221GtAe05F
	K7lmcqq4N9M2JhtN6mpEZNcLQt52H3NdcEimQDkRxqJ0qkIo+h1sEFGvZDWOqGvOlM8GAYl/U7G
	/
X-Gm-Gg: ASbGncvktKng13RGBYsdwE8sk7aZvuYyl4dE3MDIA/WLBCARQcNHPSJiuyDGFD8jqVN
	FIwyQDfFLpJFQQwPukEoRZlDli+DMvh3WAImoMCrZg6JwHwASeeYfNL8cJS8WVnwodAdfqXPAPy
	4mYRFLJkIvMO6aJLpPzedcXwqx0GkVvRhPVvj5gwQGtxOMf1Uxcr5gwdr2GOYE4jyjxU043y9qk
	DV/vEJy928oT7EDZm/vh8P01q/IIbY2HR9V2aZvCOq1T7TwzNprnPPP/bgiyiCepZma8oUVw4cf
	fwCrHlrcuSqYDn6dvg==
X-Google-Smtp-Source: AGHT+IGj3rys8L7y0l7miRYjcb7aG2QGL5B/s2BFTMx0JDHVuuzvFof9j5Q6SVAnylyyKwg07DUgog==
X-Received: by 2002:a17:902:d583:b0:215:4d90:4caf with SMTP id d9443c01a7336-21c353e700fmr725778565ad.14.1738052306076;
        Tue, 28 Jan 2025 00:18:26 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9c55dsm76592135ad.10.2025.01.28.00.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:18:25 -0800 (PST)
Date: Tue, 28 Jan 2025 13:48:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com
Subject: Re: [PATCH v9 1/5] cpufreq: Allow arch_freq_get_on_cpu to return an
 error
Message-ID: <20250128081823.o3q6gjcjca5ju3u6@vireshk-i7>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-2-beata.michalska@arm.com>
 <20250121104706.2gcegucb6hcuksrd@vireshk-i7>
 <Z4-52JUmR7A-7NJP@arm.com>
 <20250122061250.kxdpkkvce4g5nar2@vireshk-i7>
 <Z5K4aDaZIbhRCbOP@arm.com>
 <20250124033333.jrqbhuyd6qtogn2c@vireshk-i7>
 <Z5iQ02AIDalsUXe-@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5iQ02AIDalsUXe-@arm.com>

On 28-01-25, 09:09, Beata Michalska wrote:
> On Fri, Jan 24, 2025 at 09:03:33AM +0530, Viresh Kumar wrote:
> > On 23-01-25, 22:45, Beata Michalska wrote:
> > > That would mean we are opting for presenting '0' value (whatever that means)
> > > instead of trying alternative ways of getting 'current' frequency ?
> > > This is still the scaling_cur_freq.
> > 
> > A return value of 0 should typically mean something went wrong
> > somewhere and didn't return the right value to us.
> If smth goes wrong, an error should be returned, shoulnd't it?

Right, but what if no error is detected and still a value of 0 is
returned somehow ? That's what I was talking about.

> > - For the print message, I think we should just print the value
> >   instead of UNKNOWN. Let the user / developer decide what to do with
> >   it.
> Are you refering to the x86 show_cpuinfo behaviour altered by this patch ?

Yes

> > - As for trying other mechanism to find the frequency now, maybe you
> >   are right and looking for an alternate way is the right way to go.
> >   And that would be consistent with existing behavior too.
> > 
> That would mean that changes to show_scaling_cur_freq are fine ?

Yes.

-- 
viresh

