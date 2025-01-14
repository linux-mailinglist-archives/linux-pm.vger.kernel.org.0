Return-Path: <linux-pm+bounces-20409-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A9FA10794
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 14:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A77B3A5D75
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 13:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2C62361F2;
	Tue, 14 Jan 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="GG4uwl0r"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5FA224B1A
	for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860776; cv=none; b=aBHl8lGlAgw7YIQ+47z7V0oRvCs/GrfJNgPY9n4kbzYyfnCqZ9ARkkWVa9ANHzNxeTtwiJd18BquenmPJwWpZQHQ9zjfXIhr/qvNBBM8hDeOBSSz2bCEsN8uOYui0BQKSS9e4jwtdRz9hTl0kHoLARNb1Nwnd3OmCknh6JegFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860776; c=relaxed/simple;
	bh=332KVkL1C0x+3D8CEeDizwoiBpCDUCrbktmpvFuRRXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS6f6hwL0oIs899W7WVXHtaItwhM7dCXEs0eKjt0NwB4VvlpmgROc2bmT2BUsNwiAoz6CdF1yQfcRqnkQ4JqBrRDbpgjM4Q+1pVw4Unl2O9nrWhwGRC1j7a0FnIpLu5Q6fUQuIgAwduwW0aglpG4se1X5rzGnQS8ZrG2LMnhWgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=GG4uwl0r; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Date: Tue, 14 Jan 2025 14:19:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1736860762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=flEd8z2hdXUk/KymUNdSJ4lzjp1l0nO7/efuuvNahLE=;
	b=GG4uwl0rwAgNdmsDR1mVIO6bFTRdvrm0k6C/ix7j7Nms85OlahEJ0SMakXx2tAAIEVaOic
	vE/yuZlFDDqBxq/zVnfmI1aUqcOdTmT65xGHe/T5B//evRkKZ6q9dccdqsMWTFolOIq8uA
	9m8clwtdLeoQrmio1kHWbC5hZTTf5SvLyH3u9eMv4xLon0WZKoPlbcqqsr7FWn5yNXlfNu
	s+PYP+w4KadFrVTQqlI1D4f572mGYD6rXt0baFZz+TnzwKDvHou9KLD//rYTmgkp4I2Y1h
	JBP8U7UwJfGLsW/KPckHN/kUf+KRbjPgeDmBL0PnfT6i/mZY3t0o7WLB/FFUTQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z4ZkU81xJwEUiCbV@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <20250113151749.b687c35e9f4c6d596449f433@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113151749.b687c35e9f4c6d596449f433@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On 2025-01-13 Mon 15:17:49 -0800, Andrew Morton wrote:
> Thanks.  Are you able to confirm that reverting 18d565ea95fe fixes things?

Actually no, reverting 18d565ea95fe553f442c5bbc5050415bab3c3fa4
("kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()")
on top of v6.13-rc7 does not fix the issue.
So this might not be the real culprit.
But I verified that 18d565ea95fe553f442c5bbc5050415bab3c3fa4 is affected
while 18d565ea95fe553f442c5bbc5050415bab3c3fa4~1 is not.

