Return-Path: <linux-pm+bounces-20408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5853A10783
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 14:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985BD3A4F4D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 13:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3828722DC5D;
	Tue, 14 Jan 2025 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="Imheh64u"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB6522DC2A
	for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860588; cv=none; b=KghDz5DjE72WpwcjU79u7GQ8vEcD5dtswS/BzqIlI8FnzBPO8FCswjdfhOuBOUtQolu3ESbZeptTFIvaX8jcFlvGzDGln5ihN8HZ39FrUivqqLTddUq5XRdtdY64O73XZ8pxoZQ6F0QK+W0rB6nX5QuCtBQg7NRYx56cbPn4aQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860588; c=relaxed/simple;
	bh=yJ6+iSSlxlpXZF5d9b9jgHbAMnHYxtVOIx+qxoE1WB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE09jMBnkZ5mEcLGIGCvCqn18qHcWxbDK9VkTRzP9nxFsjtrrGHV1oV7cj/lwK34ddFB6MOLwVUXGUcf6AVFchm2UNhpAWm3PPkdnuTy28YEoANT3d/J2kIVPKnSKDUAJDojJRhVS+NNelj9DdHkrV0yrF5IggWZNNZ2jM6IMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=Imheh64u; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Date: Tue, 14 Jan 2025 14:16:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1736860573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GmRf/WPiVxAimIYsZVKC5WhgZrbd93EcpRocS2JRKMg=;
	b=Imheh64uhV65zTPsP5pL+DbNtlZOJIhz+GWVcf5nzPFNmx/tWaRo5XbKBF7mX+jOMSCxb4
	zLymQF9ATUH7J5YuJv1Zowpwh/vopW4juRzuU8VH4u3IgG0YgWJifClm2xS8jGZFBfsr1+
	a+0EG5VeFVD353yOZHrpYWSzcVs1kK7NT74Vom0rCh5hhm6FrV80GxkuA6jcBgY/iEYP1o
	oPXlB0+P3JelpTPDz30zRyDmEIXMmlTBWdBiApL5mgWtFPWQvqOKhNFpLBPrfIqdzJrlSM
	9f2qoRDFwcxUwzu7TspBcjq0of6b/QG9Gh65B2HVZ67e3EWYhut8xzzStCggUA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com
Cc: kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	akpm@linux-foundation.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z4Zjmva-pLbLjtQv@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4WFjBVHpndct7br@desktop0a>
X-Migadu-Flow: FLOW_OUT

On 2025-01-13 Mon 22:28:48 +0100, Roberto Ricci wrote:
> I can reproduce this with kernel 6.13-rc7 in a qemu x86_64 virtual machine
> running Void Linux, with the following commands:
> 
> ```
> # kexec -l /boot/vmlinuz-6.13.0-rc7 --initrd=/boot/initramfs-6.13.0-rc7 --reuse-cmdline
> # reboot
> # printf reboot >/sys/power/disk
> # printf disk >/sys/power/state
> ```

Looks like it's the kernel performing the kexec which causes the issue,
not the target one. E.g.: kexec-ing 6.7 from 6.13-rc7 makes resume from
hibernation fail; but if I kexec 6.13-rc7 from 6.7, then it works fine.

