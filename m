Return-Path: <linux-pm+bounces-17798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98F19D31E5
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 02:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B99B23636
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 01:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33D718035;
	Wed, 20 Nov 2024 01:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uxzJ3Uzz"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934CA920;
	Wed, 20 Nov 2024 01:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732066148; cv=none; b=XmAzLvJQFIKO5Eap7fu7J/Zw4vvQOv1clV9jFKMLBd0MrUvsb3oaOb0kUF8ibZMQGaYFwLnvsmd+5qagJriLo/4F3QDmMIQ2u4b0Pcg+k2PeIfBl2+hM78QZJQcp5uVFQiPKaW5xF8Yi+xjnhIzQrHd5RHp8a/Dt7RdR0sk01jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732066148; c=relaxed/simple;
	bh=sXpffKphaYU/PrdGBQJqh+XW7Bds0opukM76WrIT39k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rd6OkqANjtaNmyKX3bgxJ90uTbQnq3Av5PXL/A9ST9V3oCyBqOzgLVt9CgPwwEn0APsdn0Aq3YAGH9LP0dgj/LG18lAlSZkFTxEaoREARWgKrh4UTPiik7Uj7zzjfo13kW7neFf3mt+1LxsozFsMa06FTIilbxyY3sc/5YXUI8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uxzJ3Uzz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=v59Vb7JIm4gIzlWuLSdfGKzwV8mP+10Ck1kAdwSazko=; b=uxzJ3Uzzm2z2NKYnQ/LOjUTAmA
	ccxgyLv5PyIGBS00RVBHCih0Mj6nhecGarzmtA+CPArV+LamT7FCcD6pyY3VhbM93KwqQguIYYFEx
	yB/iTC8qDjIS+zjZhmpL4x+w9jUd+SmfvGHhFNdWGX4ei+ha++j9SwCdJ8/EwgF9VG/ZdjBcXtAAX
	0KXcemq5RZBwhUv8RkBrB3k+hG5lLKjKfqb8npjK0GBdmPL7IpCecuq2fFc68IiK/mVbkPU64tHsa
	qrp5sI1vQuIX5mhKx6xtpysHtfz2CNA3cSFg4/1r0xKica6lo2fRrmyW2HWFSr3JLgz8ulEMOYuZ8
	B4zehw1Q==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDZWd-00000004ivI-482S;
	Wed, 20 Nov 2024 01:29:01 +0000
Message-ID: <9750d1c0-15b5-470f-9391-3f3d535d1a52@infradead.org>
Date: Tue, 19 Nov 2024 17:28:57 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: pwrseq: Fix trivial misspellings
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241120-pwrseq-doc-trivial-fixes-v1-1-19a70f4dd156@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241120-pwrseq-doc-trivial-fixes-v1-1-19a70f4dd156@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/24 5:14 PM, Javier Carrasco wrote:
> Use proper spelling for 'discrete'. When at it, capitalize 'Linux',
> which is common practice in the documentation.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

LGTM. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/driver-api/pwrseq.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/driver-api/pwrseq.rst b/Documentation/driver-api/pwrseq.rst
> index a644084ded17..ad18b2326b68 100644
> --- a/Documentation/driver-api/pwrseq.rst
> +++ b/Documentation/driver-api/pwrseq.rst
> @@ -11,7 +11,7 @@ Introduction
>  ============
>  
>  This framework is designed to abstract complex power-up sequences that are
> -shared between multiple logical devices in the linux kernel.
> +shared between multiple logical devices in the Linux kernel.
>  
>  The intention is to allow consumers to obtain a power sequencing handle
>  exposed by the power sequence provider and delegate the actual requesting and
> @@ -25,7 +25,7 @@ The power sequencing API uses a number of terms specific to the subsystem:
>  
>  Unit
>  
> -    A unit is a discreet chunk of a power sequence. For instance one unit may
> +    A unit is a discrete chunk of a power sequence. For instance one unit may
>      enable a set of regulators, another may enable a specific GPIO. Units can
>      define dependencies in the form of other units that must be enabled before
>      it itself can be.
> @@ -62,7 +62,7 @@ Provider interface
>  The provider API is admittedly not nearly as straightforward as the one for
>  consumers but it makes up for it in flexibility.
>  
> -Each provider can logically split the power-up sequence into descrete chunks
> +Each provider can logically split the power-up sequence into discrete chunks
>  (units) and define their dependencies. They can then expose named targets that
>  consumers may use as the final point in the sequence that they wish to reach.
>  
> @@ -72,7 +72,7 @@ register with the pwrseq subsystem by calling pwrseq_device_register().
>  Dynamic consumer matching
>  -------------------------
>  
> -The main difference between pwrseq and other linux kernel providers is the
> +The main difference between pwrseq and other Linux kernel providers is the
>  mechanism for dynamic matching of consumers and providers. Every power sequence
>  provider driver must implement the `match()` callback and pass it to the pwrseq
>  core when registering with the subsystems.
> 
> ---
> base-commit: 414c97c966b69e4a6ea7b32970fa166b2f9b9ef0
> change-id: 20241120-pwrseq-doc-trivial-fixes-ee8744695d52
> 
> Best regards,

-- 
~Randy

