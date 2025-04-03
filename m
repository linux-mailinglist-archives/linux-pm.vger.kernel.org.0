Return-Path: <linux-pm+bounces-24771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CE0A7B1C0
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 00:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA9B3B82A6
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 22:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D258018D65F;
	Thu,  3 Apr 2025 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="pIKlnPAD"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0102E62A2
	for <linux-pm@vger.kernel.org>; Thu,  3 Apr 2025 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743717631; cv=none; b=UoSK5XXunHReEbPZzrUgpiv8+DmlVX+V4t2hGvVp0g0eU2mx/vNHqCZMn7yd0JoGo4itgYe0eDZMaGxMrNz30wbK4RBqoOaheHq67vJK++8qvdUQeSESNK25cksguT7hvC8dpz1boSD0vc2lWrKQDegi3CHVGhK0e20qxQSE4r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743717631; c=relaxed/simple;
	bh=h7nTgTP3NXOGE1VcUlyux+afCSP2rmTQen+lpws4idg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKYIDptUmUFPWt9mOECyX+iCP1yDpTAw4mAKMdzW15GdnpC7DxwdJlKxqlT9TW5K2Z/P/BUGxs2aU/AXOUdFIX3qpYifH5WRWFcTEKb3biPoCXW4ViynITbZY7VtemPFtAtjgoijTx86uQO5WolrCZxkQerHLDqWvxyFmELCOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=pIKlnPAD; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Date: Fri, 4 Apr 2025 00:00:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1743717627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h7nTgTP3NXOGE1VcUlyux+afCSP2rmTQen+lpws4idg=;
	b=pIKlnPAD49IT9newoKNv2EugDGyKrmm3GRZWVHdONQQtFQnhhEeZHDy8ng2S54Gsq2l7kW
	S17+FPbKs+SWNcpfvCApNNXj2BzBV/E790l5A3L37pXVr1rtk5WmopP/jZvpm2ZV6T2M+7
	tONLvKp7muaBoz7VWw3UMpoGHLg6H3ikKkka2dG5v7F+elDAVs4xYJRyKh/zANFupgyOZw
	iPrm0z0mORJrP9iZrtwj4Cv3JofzVEEmgc5sh0h2yHquEgQhCnkjtLstlHuTsJDXyJIRnT
	kpT1cenc2RwUCkBFeqDq1wQoSm1OG3evlAnDV/mcRJmCd2P55lpy2qFhJwZSRA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: msizanoen <msizanoen@qtmlabs.xyz>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z-8E-LLs1dFWfn6J@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z4WGSMdF6seQm9GV@desktop0a>
 <b9f6ed5a-74b9-47c0-b073-9922dbe6119b@qtmlabs.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9f6ed5a-74b9-47c0-b073-9922dbe6119b@qtmlabs.xyz>
X-Migadu-Flow: FLOW_OUT

On 2025-04-01 19:59 +0700, msizanoen wrote:
> [snip]
> It seems like `e820__register_nosave_regions` is erroneously marking some
> kernel memory as nosave in the presence of sub-page e820 regions. In theory
> backporting
> https://lore.kernel.org/all/20250214090651.3331663-1-rppt@kernel.org/ should
> be sufficient to avoid this but a fix for the actual root cause is
> preferred.

When using kexec_file_load, this patch series fixes the issue not only
in theory but also in practice.
But the issue with kexec_load (see
https://lore.kernel.org/all/Z-hYWc9LtBU1Yhtg@desktop0a/
), which might be related, is not fixed.

