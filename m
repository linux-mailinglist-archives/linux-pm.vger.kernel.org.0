Return-Path: <linux-pm+bounces-30382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FCEAFCF5F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 17:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3011BC59E3
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AD82DFA5B;
	Tue,  8 Jul 2025 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D2p9VBcU"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050F2DCF48;
	Tue,  8 Jul 2025 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988988; cv=none; b=cTGDhLrN9w00jcB2te+Ds3C2t9aUYw/jTYc1HHzyT4mZ+o6n3QjNVLZVOF/AYZJG0dE0v+J1gI73Q8YFr+RYyHrJSs80gcXAUMNrUy5IkJwPKN7pDGD10Nt8oTF/bCjdgFFgu4n3p89K301zJTay8owyt4Oydy/HN16xYB+zsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988988; c=relaxed/simple;
	bh=YCcB0eOcs8Ym8eklazzhwUp0NxAzpDPzxY6ELYSSA58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqUg0Cp3SrzzBnGZjqFspZzoIMThGb4mjM+P16KMc1RJc7numac26Y53tYhFwmVHbLqlpO8c4ccXbVzxYDmKsXuUyQqTZ20JRV/c9kBPl9wmnSgD+tPPKNUdWO/8AU15eSww7PIB4mrNgDO+HBZNW/fKqSRvWaL81b98opPSmlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D2p9VBcU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=j9nq5mviM1whzkx/ElCUbS+70aAtza0OP9bmhf8o5og=; b=D2p9VBcUVeQXpkpGoxvFLoNQur
	sbtFxTo3fBbwN6kCCm+bZ2jn2DdDFgFX3sQVX54WviMkB0LxDBXCTwDNYnEbV3It1I7W4hR59wV7s
	wUPfbP1BNp1OYvndt0rFJeYpKpn9B6hbeza4wBqU7mMF3nXGiIyf+lHwzMzuL1tFJ371T0jJVVvKX
	TQGJoR8/foDCrQpH+1zCIyeNGZdyV+FZlNrZAtbmlkbj+/ozV/NhtUus5H2Fw1hIFxcPsmTv1Di3j
	LTdllYzSauYNhhY6fSiBxKtJMoxEp+TmLeu7YjMVblKZ1RLewE8Xe1i4JtvVn0qX2KC/qGP0hBSy1
	X7g1Syzg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZAMn-00000000DrS-1P5O;
	Tue, 08 Jul 2025 15:36:21 +0000
Message-ID: <18c12f92-2194-4244-8793-5d916edfd4e8@infradead.org>
Date: Tue, 8 Jul 2025 08:36:14 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: add kernel parameter to disable asynchronous
 suspend/resume
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Jonathan Corbet
 <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com
References: <20250708-pm-async-off-v2-1-7fada54f01c0@linaro.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250708-pm-async-off-v2-1-7fada54f01c0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/8/25 8:16 AM, Tudor Ambarus wrote:

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
>  kernel/power/main.c                             |  9 +++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f1f2c0874da9ddfc95058c464fdf5dabaf0de713..33ca6b881b1d77bdeea765b19291a90b2a82e8a3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5000,6 +5000,17 @@
>  			that number, otherwise (e.g., 'pmu_override=on'), MMCR1
>  			remains 0.
>  

This should be more like:


	pm_async=off	[PM]

or

> +	pm_async	[PM]

	pm_async=	[PM]
			Format: off


> +			If set to "off", disables asynchronous suspend and
> +			resume of devices during system-wide power transitions.
> +			This parameter sets the initial value of the
> +			/sys/power/pm_async sysfs knob at boot time.
> +			This can be useful on platforms where device
> +			dependencies are not well-defined, or for debugging
> +			power management issues. Defaults to "on" (asynchronous
> +			operations enabled).
> +
> +
>  	pm_debug_messages	[SUSPEND,KNL]
>  			Enable suspend/resume debug messages during boot up.


-- 
~Randy


