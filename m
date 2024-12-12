Return-Path: <linux-pm+bounces-19154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EE39EFDB1
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 21:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4002288783
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 20:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58CD1ABECA;
	Thu, 12 Dec 2024 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG/vn8Wa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF1D174EF0
	for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734036974; cv=none; b=cZ7UD1JlK37jdLzKCYQ1hOH1nFQLo9A4IPEU7VN2JxbIa8P7CV9ZiAVSACcZVfd2YUJZNtPKRBWu+TsBmoV3RAOI7DF/3/vxbqG4MGOvA4jboZa+od0MKTEzWyEbzCjs3UW4yKoRhb1Bk9Y5KWnHJOEyBEweiIMp8Ls0ox3qNJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734036974; c=relaxed/simple;
	bh=0f9bYrPeHiMFLpwARl63aQ9zfM/CVO/GXDZBgngxNUI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=By9xS1gDmKC/RIySQU/0D/tM82ynKGkkWyPmBYed1kIgAHMWRDFDFpNGm7w5w/OsJa0a7SW0QlVfOL/qZaJvYG3BiJ8br5PlWNmGRlo4V4rIOYVdOJ8nOvAvxPQ8mARwnRU0jDIebZTQ+2+6ghTaHXoOmy6HjkSfUnpUz3qOeJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG/vn8Wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17648C4CECE;
	Thu, 12 Dec 2024 20:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734036974;
	bh=0f9bYrPeHiMFLpwARl63aQ9zfM/CVO/GXDZBgngxNUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TG/vn8WaaKTwyq6PA6X6pCzo+UdPguEipuWNX+kkwZHORBudps9qfMj9YN42rXJFD
	 st/p+ljRUAl7HtR/5rsK7TPChtRI57EhnvulFB3g1GDeoWZswm271r9GNQS6d2f8++
	 7cB399zAr71co8qOfoDoMtHibZzQ1qH8rqx4bVpi4dlOSvCpPCxjZv9F6B7AxS0znH
	 xos1NOTaPMbCJARpg2dbTjD10/v7cCGVzT6wC96QssEhPw/WSyYWodYyvX/6kiOoBK
	 2X/WA4x0DTZLBI/GE7u5ezPBPrH0vKx1xnsmap2YplGPG9gLfpO/A9sEgKpW/VN/AF
	 ufLWt6qBfeIjQ==
Date: Thu, 12 Dec 2024 14:56:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kenneth Crudup <kenny@panix.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, vidyas@nvidia.com,
	bhelgaas@google.com, andrea.righi@canonical.com,
	vicamo.yang@canonical.com, linux-pm@vger.kernel.org
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
Message-ID: <20241212205612.GA3368300@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b720f20b-ff2f-4646-b263-8597fb3b342f@panix.com>

On Wed, Dec 11, 2024 at 03:26:37PM -0800, Kenneth Crudup wrote:
> 
> So we're on 6.13-rc2 and the patches are getting closer and closer, but they
> still need to be manually added.
> 
> The good news is now only (variants of) "PCI/ASPM: Enable LTR for endpoints
> behind VMD" and "PCI/ASPM: Enable ASPM for links under VMD domain" are
> needed.

Do you have lore links for these handy?  I'm not sure exactly what to
look at.

https://lore.kernel.org/linux-pci/?q=s%3A%22Enable+LTR+for+endpoints+behind+VMD%22
didn't find anything.

https://lore.kernel.org/linux-pci/?q=s%3A%22Enable+ASPM+for+links+under+VMD+domain%22
found
https://lore.kernel.org/linux-pci/20200821123222.32093-1-kai.heng.feng@canonical.com/t/#u,
but it's four years old.

