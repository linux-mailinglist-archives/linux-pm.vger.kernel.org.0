Return-Path: <linux-pm+bounces-29637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8A1AEAFD8
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 09:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B162189D774
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 07:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E975921ABDC;
	Fri, 27 Jun 2025 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2HOle7I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2BD219E8F;
	Fri, 27 Jun 2025 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751008319; cv=none; b=WSjDsJZ0LpHKMCcW2Of8OQjhdm1Y1Z+pUhcY4IVheLwQ3BvDydfY1ssJCGvEYjFSFWKNe0oJnnRoavRBFhuyj1jTl+xGDqpPUbtFk2NPFqRXUqQuvNNK9pjS0aTn5Bt1+tWAAO4K5Z63itOVJp157XtkSIt1gvfJQTDtcVRwORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751008319; c=relaxed/simple;
	bh=sV7YYEfR40UNrQWFtPcqeuT8brwWEa5QI904RkqIdC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCwJn+2xXGnxIB7ge8QWhMZoJ0FRVONVZ7845Y138i6yhfu5cuofTSCnKgaWxB091LpBifFhDHtacu6fgsngFGcftnNRZF1Gab+T1h51QROpj7IHwFPl+Vt/QMAFRyupNVkJufpYYH6WcfGxU5Jqh6L5L+wNCotcAX+4z7d023U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2HOle7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A77C4CEE3;
	Fri, 27 Jun 2025 07:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751008319;
	bh=sV7YYEfR40UNrQWFtPcqeuT8brwWEa5QI904RkqIdC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2HOle7IWs5k5iIB3ZuECVmDVyebf/BrkNyRjpER+MhpAl/tlD7FVOdIo6fVycmaH
	 aSfmvAMjvJwofFh9ehsxefrBBHB0vNVHD5v0EppwnvP9Zexgmklthc4Kkz6WXESKWC
	 M4saEZH++OhFeUMgeY3+wUJuhl48kIgbq7Og7hqHnpJL2zQeqtKSS55wrwF3JFSml6
	 Qz/vDYM6XR29dRK5C5AP5FQS27WlkEKhwpiPiPxJoxMoQAsLty1nOBOiaeEpgTnIX4
	 qnsVuwNZhAACP/oTl8ctfbx2HmcoDbAZ1g25Pro7FokO90ijykB4JeRkejgafrj/eT
	 kRAtK/cEt8QeQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uV3Fe-0000000030t-3dkE;
	Fri, 27 Jun 2025 09:11:59 +0200
Date: Fri, 27 Jun 2025 09:11:58 +0200
From: Johan Hovold <johan@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Georgi Djakov <djakov@kernel.org>,
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] interconnect: avoid memory allocation when
 'icc_bw_lock' is held
Message-ID: <aF5EPhd5smrmB38Q@hovoldconsulting.com>
References: <20250625-icc-bw-lockdep-v3-1-2b8f8b8987c4@gmail.com>
 <aFvr1zSkf4KmIcMT@hovoldconsulting.com>
 <aFvuiVX0kMIqXQtZ@hovoldconsulting.com>
 <84b94649-a248-46b0-a401-772aeb8777a2@gmail.com>
 <aFwBYRF0wJwVDdeX@hovoldconsulting.com>
 <ac5ba192-b538-457e-acc4-c2d358b1fd0e@gmail.com>
 <aF0TIWfDI4M1azzc@hovoldconsulting.com>
 <3b90caec-b4c0-47d8-bdd7-1a7abd5e69d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b90caec-b4c0-47d8-bdd7-1a7abd5e69d9@gmail.com>

On Thu, Jun 26, 2025 at 05:00:42PM +0200, Gabor Juhos wrote:
> 2025. 06. 26. 11:30 keltezéssel, Johan Hovold írta:

> > Note that this could be extended with a
> > name-allocated flag and an appropriate warning somewhere later if anyone
> > is worried about drivers failing to use the helper.
> > 
> > Note that we can't use kfree_const() unconditionally as I initially
> > intended as apparently some interconnect providers already allocate
> > names for non-dynamic nodes.
> 
> Not that I want to worry about anything, but for the sake of completeness I have
> to note something. Theoretically, freeing the name in icc_node_destroy() could
> cause the following on IPQ9574 under some circumstances:
> 
>   [    4.003692] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffffff80047e4180 pfn:0x447e4
>   [    4.008439] flags: 0x0(zone=0)
>   [    4.017545] raw: 0000000000000000 fffffffec0000448 ffffff803fdbb518 0000000000000000
>   [    4.020480] raw: ffffff80047e4180 0000000000150000 00000000ffffffff 0000000000000000
>   [    4.028413] page dumped because: Not a kmalloc allocation
> 
> It is not a problem of your patch though. The root cause of this is the same
> as why I saw the lockdep warning on the platform originally. The reason is
> that the static node ids used by the 'nsscc-ipq9574' driver are within the
> range of dynamic ids. Nevertheless, I have sent a patch [1] to fix that
> already.

Yeah, I saw that patch of yours the other day. Good that you tracked
that down. I'll probably amend the commit message with a comment about
why this triggered on IPQ in the first place too.

> Despite the note above, your proposal looks good to me. Would you like to
> send it as a formal patch, or shall I do it?

I can post it in a bit.

Johan

