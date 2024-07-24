Return-Path: <linux-pm+bounces-11359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 858A193ABFE
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 06:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51C11C228E4
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 04:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E2C45016;
	Wed, 24 Jul 2024 04:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k87EGMps"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880651C69D
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 04:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721795988; cv=none; b=I0IsAzc5DkRPK4N1fo3atEP90dS92lFhcF1/gcEa27brSOsPKoGWMTtMlcVMv485/E27V0EqCezxNBSVA4AtWhUIxMptVXn4tR6iG4XfgOMs/yKDS8izSZ9i3STlorx2Pr4ekxhqyEeRXpZbsTepPnjzGxPtEuL+6txZhqAHZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721795988; c=relaxed/simple;
	bh=X2B2h7YCmnQxgWrjlRimRYu68yfNkuWjdFuHQ3lVJP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAfpH7Z2I7575NnzJKoonc17ggD3ed1CPLfQ9y1nUpT5SYt/OLvBHxv+rRBuA1wGa3ZNA5TBGf+/OqBsS5qKt2nGEKZC26gRRNkB5TdPEH4uYysEk8/uH+eppPEtuJhpiV8psZAJF3005lr0zORt9qsHNJUWm3VG++eerW0OeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k87EGMps; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d9c4887533so3392563b6e.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 21:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721795984; x=1722400784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ydzy8AybJJkkCvZrEtKcB+LO2UJxL/0lB3QK0FrhXAo=;
        b=k87EGMpsEIVMh+8VzScAcxlXNGLnnQKqmPsbhR58r3jazUdV699Ge+ox7xzIUFvBwR
         Ob79R3G4j5i+ohtbBuKjpPm21HbZFANSRNMFv5bV0MBaIEBZncuVTwGAeiDj3scsLtb6
         UXVG3p3oG/aOndRkvJ8BNd+5TBF7ysUAMzR/rmlEKv7Hes9zf2tn0UJ82pLOCXU3PPEc
         iTazR39aH3O6e46ZI58Kz2quJzwUPqjQadE4yGFludwpI6wgXV5AImXAMmftc14khZ+c
         NTf4mXS9abqDziWWo80i0mCZ54tXr1AruvUCiZEukcko1RxGlusxp2SpqNBSNNDnJOO2
         SH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721795984; x=1722400784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ydzy8AybJJkkCvZrEtKcB+LO2UJxL/0lB3QK0FrhXAo=;
        b=HDqrospqQlJ636FU8DoiRNeSpKwQtnIjkfs7uMeGG4ORv1nMkQw1TUBPWI7QQWseha
         MQpMMa8EY8JUWtT77XeYaB8L+f2MEXWbBNWUXpXuFal2mDy1x1SQDvLRWj8exnGfqa79
         aV5srdJW55D0qSJbgSuTZKE5seSAKvtxNnqBELbV+TBmDe9nTojsrNmaHu7inA23bMak
         uyT43ei9TkpFENG5s7EEDPsUcHH2K+WtgtK6vYIhQiDUmqJewdvbzfzn7cXIZHNVXQX0
         sjm8v7+tB5h8moYTwyY3yHOO8y3yhJOPRrzSmlQtWWznZVkbT1KYWY+MsthihfuK8pnN
         s9Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXRczZVUAVPXlS3QGv4mhqQ9AjyF7bfr7C9JX4p4dclopza2I24sMvXx4Bv8fYAn+hX0ilwVjXmCmHdw2Pd5NOnsrHqap5cC3A=
X-Gm-Message-State: AOJu0YxVLB4y0fP2dV2IUfaD5MHHnhn2MCZRe72Pf2UkiG/Qi9WinJKk
	ssmkIdvDKpzQapHyjdHdR3YkvGX7w2YXkuRantb8+3zfzKWfxtEgplQ2CqADUMA=
X-Google-Smtp-Source: AGHT+IFawSrYkpJ5B3GaqjAq4r8y+m8JJXA6riU411Tpew/uqsG/DaM7j/6beI731Cy6xC6aPZPTvg==
X-Received: by 2002:a05:6870:1682:b0:260:ea0c:acc with SMTP id 586e51a60fabf-2648ccc2102mr942284fac.49.1721795984585;
        Tue, 23 Jul 2024 21:39:44 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff5527e9sm7734870b3a.138.2024.07.23.21.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 21:39:43 -0700 (PDT)
Date: Wed, 24 Jul 2024 10:09:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: powerpc: add missing MODULE_DESCRIPTION()
 macros
Message-ID: <20240724043941.5wpa5di7ta4fjyl5@vireshk-i7>
References: <20240722-md-powerpc-drivers-cpufreq-v2-1-bb84d715eb3d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722-md-powerpc-drivers-cpufreq-v2-1-bb84d715eb3d@quicinc.com>

On 22-07-24, 10:14, Jeff Johnson wrote:
> With ARCH=powerpc, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/ppc-cbe-cpufreq.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/powernv-cpufreq.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro to all
> files which have a MODULE_LICENSE().
> 
> This includes three additional files which, although they did not
> produce a warning with the powerpc allmodconfig configuration, may
> cause this warning with specific options enabled in the kernel
> configuration.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Changes in v2:
> - Per Michael Ellerman updated maple-cpufreq.c and powernv-cpufreq.c
>   descriptions
> - Did not carry forward Viresh Kumar's Acked-by due to this change
> - Link to v1: https://lore.kernel.org/r/20240614-md-powerpc-drivers-cpufreq-v1-1-de4034d87fd2@quicinc.com

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

