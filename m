Return-Path: <linux-pm+bounces-25524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 530E9A8B23D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 09:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097A33B9F07
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 07:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8422D4E2;
	Wed, 16 Apr 2025 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9RTKt/u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D322D781
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 07:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788866; cv=none; b=YV51UDNjjSVhklfwn/HZNFZPHIkvBqxJTiVuiXHPLLMPpzLOVu0A+deLajN2C7D60gYoxmoXModgChcmOObsmSozqFFYs2u2NCP7Jf9kbkVIEooiVetLla2XNtqQ2EHZacFBw9XKa0C6TRcfZQSszJGzwEriCZLOBIGliV8phzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788866; c=relaxed/simple;
	bh=Osz8UwWeE7SoEkx8hhEOY9AIQrzeHRMkeYvC/KMmssg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdH4bANeO5VLroR4/z0zbbJd5Dvxbvc6UZGT2eAFlGKoVhwn9m0QWPRrQsiNw6fGjyNTAo4ZN5h5B6QDWWYM3qV2ZBSpRWAE3SnRFZ2OGVhIRqzsntTsITJrVWNotdWTO0gjIHLI/2iV0zn9p5cb8gIrGuyz8aA3DpCjfeSuE68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k9RTKt/u; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b061a06f127so3049740a12.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 00:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744788864; x=1745393664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9OojZ/Set6ofgNmoLSDBYOLQFH7SYSkSj18BSfmQvXU=;
        b=k9RTKt/uvTR1WeO25aPrI229c1HvXDZofuLiap+ruI3JkoA/nbq6fxCTIUUZe4DZQB
         Z2VrF+lzQeUmdPOGe0qYh79VHj6jnLB/CcnmG5hj1jwLJHHaA5G8pzwslRCmDORUPcMP
         mv2ncRtLlJfvz5n/1l+9NERw5IPD5RFut3RVRM5E6KfbIixxLtluGo+se7AQRY+DBv9q
         EaN2EyBVD/oXrhonMyPWkfvVX/DRkS5DE7fsqrVXMaP9R++w0rgR4z6onWJgd7LrMwYe
         LY2boD/J2CazvI0xDpDHP3XT9nPUrfGGxrsnkWcQecFqKrsg1n6T/lQV2ATfS06dne8B
         siEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744788864; x=1745393664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OojZ/Set6ofgNmoLSDBYOLQFH7SYSkSj18BSfmQvXU=;
        b=WM/gWDxwOHVnz1j32iiI+s9xTgtFuXOORKKat25G5c8O6PmELJfIFD0/pxd8QdTfc/
         hkdx++AfTAUlbvL5US0JuNc2i2lhn755D24CxMUNu4vamjFI2EPqMNSi1pBteO2tDxxv
         8WHKoUHVmxqi4+EQ3gDdO+t1syv85U4MPdv+tDQCZm2Drp5MpYTy7QqqmIYJtVJnZ56v
         KSkyoYq1CvPOyk91wi3fDZK3V1HXyaq8kBULBmiOx4yaWXNuOhcy8rHjMyPkcao5eyjZ
         UB4bgNrIAYyFthADSJGfp1r9mfLMAcUUilYEpubJTPY3JCfQjD86LM0zDeOjqkYQcVKt
         8ypw==
X-Forwarded-Encrypted: i=1; AJvYcCX6+0O0+GkHsBmMfd+yX/M7eDDUbMHuhiO1EyigOa48ZVyS0ghL0M/OBhiert/S+R8q+lGEfAQMWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yypfj+eGY5OZUQP4ACSqi0bo5wJ63oiSilKgMcZg+KMj0XHJOZ9
	rQ/OEcg2aRqp7UUA84sw57K12jvN8hN4LhJ6zhkCUgU1T+uK9hARUAPlR/zcmI8=
X-Gm-Gg: ASbGnctHE0PZwZgzEKQEgbo0EwbmIBLtE3RGX2gPnnfoxDFA/GX1nLMjkmEBiqCikFM
	0LlXX/EMYBqS3s5hK1PZ+OvAKS8yWIvSRS0rSayID/SIzGmV/a8tmggg0Nrv8SjIxnAmEIIvCw2
	NENkzGYZbr0OKYukQ9RvjJcqnQg6Jqklx2ZzQ+FNU1PdvIEfIDPy7M4bADWvq9UfjOtd3LoHbAf
	cjBKew7LojruEeENvHV/mBh3WjqPJLqyQbEaUg+2TDz8/qjCDfWjtfNOFNLlq0q8U+xwTArivyt
	CG37lOSVCvcJT6crTZi/uonBDeJHWj0J8OZUtCvkEw==
X-Google-Smtp-Source: AGHT+IF5gr7KTNmsoqWboKzNZwhfvZjvETmtD0k891OgOb0tDlIqVA7ofglJmZDsPCASVeystx4Ztg==
X-Received: by 2002:a17:90b:520a:b0:2fe:8282:cb9d with SMTP id 98e67ed59e1d1-3086415c684mr1191209a91.28.1744788863789;
        Wed, 16 Apr 2025 00:34:23 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30861212c3esm872339a91.25.2025.04.16.00.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 00:34:23 -0700 (PDT)
Date: Wed, 16 Apr 2025 13:04:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: rafael@kernel.org, Marc Zyngier <maz@kernel.org>
Cc: Chenyuan Yang <chenyuan0y@gmail.com>, sven@svenpeter.dev, j@jannau.net,
	alyssa@rosenzweig.io, neal@gompa.dev, marcan@marcan.st,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: apple-soc: Fix possible null pointer dereference
Message-ID: <20250416073420.xrhwnzy22zf6yltm@vireshk-i7>
References: <20250412160518.1824538-1-chenyuan0y@gmail.com>
 <86bjt0l6q4.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bjt0l6q4.wl-maz@kernel.org>

On 13-04-25, 11:02, Marc Zyngier wrote:
> Irrespective of this, it would be good to describe under which
> circumstances this can occur, because I can't see *how* this can
> trigger. The policy is directly provided by the core code and provide
> its association with a cpu, and is never NULL at the point of init.
> 
> And if it can trigger, why only fix this one particular case?
> Dereferences of policy are all over the map, and would be just as
> wrong.
> 
> So while this is not wrong, I don't think this serves any real
> purpose.

I have applied such patches in the past, considering the same as good
practice. But I do understand your inputs.

And so I tried to see if there is actually a way to trigger this.

- Platform with two cpufreq policies (freq domains) with one CPU in
  each of them.
- Boot the kernel, policies will initialize for both the domains.
- Hotplug out CPU1, that will remove the policy as well.
- Call cpufreq_quick_get(1), this will call the ->get() callback for
  CPU1, for which there is no policy available.

But this is the case only for drivers with `setpolicy` callback, this
shouldn't happen on apple-soc.

I am not sure now if we should just apply this patch to be safe, or
leave it as is. The cpufreq core may change in the future and call the
`get` callback for all drivers.

Rafael, what do you suggest ?

-- 
viresh

