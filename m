Return-Path: <linux-pm+bounces-36033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A79DBD77BE
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 07:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FE23BA378
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 05:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CD6280037;
	Tue, 14 Oct 2025 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dsMYimzk"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783971990D9;
	Tue, 14 Oct 2025 05:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760420982; cv=none; b=R0Zbui1Siit3cm3GX0mSsQPCUNxkY6umQ6gBwyqaVUx9hDU8E/YPfIac/u2SEPLpUyUOGu/57LcrkMOKjYlgXcR+INsTGtL8ISSDcUxaWnNP9/fOQBampTMEWpEwwerCN6nj8nxYs17YB7a21QCbL4FfOW7H5y0Q1Z23UevAKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760420982; c=relaxed/simple;
	bh=9jJGe8mIjKKf+w4XiUD0Xsuk9sLRMyV8LCUGQ3SWOI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3jE8TuBSaELWVKG/ORw1JhacHJhATrXUh0SRoAAvOzeETZUY+NUJPOvnZouy/t/tPai0b3xjXxSw01DwIVbqxfpw2u7RRz77qPKwuJ1QFOA0H4HpTUKzUgo6sqJpYBMj6PZcnpEJemRrXtnw4van1lc9EFfsFY/kWa905wUlEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dsMYimzk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3/iYvjKXG/ZA8HX1G461NeObT+RzeCLng+sueDi1iDM=; b=dsMYimzkVLJzFMMC12cA98Z/tR
	GSCFapeTfTpMd1Yv9+8dcbFstvRjT9t7fWZqp2RkTksrB6AS+Tilym5MHrImekuu3+1V/rMlxW6fI
	qNJAQ+ZxBSUKwqCJUywYlEV3pP0ZiP9irdUT/xnTXJu6GGg3vy3cEjtRWshqdFV+KxAxTb67Yw4+G
	95xmvro26ai6u4Mq+qUXlIgX4PswWjvFAb76Xf+t4AYVyjWzCP3Jd/giq2hkohxsTyS77z8fRgY0+
	/MpO/TDiEMiOMj9I5xAu6ExrL+hOIfB/Y2uHYDFfmTtHSAUfFxMWM8erImWvW6svnuct+nUCy9Zjr
	/dH2r65g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Xum-0000000FEi2-0FBq;
	Tue, 14 Oct 2025 05:49:40 +0000
Message-ID: <0e335708-d528-4277-a3c4-0b286c34b93f@infradead.org>
Date: Mon, 13 Oct 2025 22:49:39 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: power: clean up power_supply_class.rst
To: Dhruva Gole <d-gole@ti.com>
Cc: linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251014031617.764429-1-rdunlap@infradead.org>
 <20251014052743.7epupfxrymbq3eu6@lcpd911>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251014052743.7epupfxrymbq3eu6@lcpd911>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/13/25 10:27 PM, Dhruva Gole wrote:
> On Oct 13, 2025 at 20:16:15 -0700, Randy Dunlap wrote:
>> Clean up grammar, punctuation, etc., in the power supply class
>> documentation.
>>

>>  
> 
> With that, if you plan to respin feel free to include:
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> 

Hi,
Yes, I'll resend with your suggestions.

Thanks.

-- 
~Randy


