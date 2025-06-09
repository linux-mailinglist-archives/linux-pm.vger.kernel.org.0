Return-Path: <linux-pm+bounces-28331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1D6AD288B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 23:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACF01890074
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 21:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF11C202F70;
	Mon,  9 Jun 2025 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="md06AXeF"
X-Original-To: linux-pm@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE931A5BB2;
	Mon,  9 Jun 2025 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749503751; cv=none; b=oCjQbmrNY6BE7Rq5oJATISgjB6D3NrZerx1Yu2Qdl+GfyCmjdgR37rEDGGupFNOewWaIebhiobRWsC1PDq5FGH1rJ44dOtQLyYjww5cR76EpV4a6oVv3o+Jc3csAHF0tqesJbblAOwqBo2LJ6DQzt/MADvxDPGWNGduPLWouLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749503751; c=relaxed/simple;
	bh=PiSqi6dFxwzHY28QnZyhs9fDjjWyaMbcZYtrghdN060=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z8pMcsJjKl9Jwv1sGM6so8X5HKCYum3xWNFtvcA8Z44Kbd4bzm/kO7n5vTTGdQFjqFjrW/aG+uJ1YMg4Zyh3PJ9BgE5G4h32Acu59fEVduEBGniGZw/k8sG2sAzYG8qf5GkgjqTYKpXarW5zJWivV1cqeOev5L84mvYLKbPd0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=md06AXeF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B080C41AA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1749503749; bh=xc2d2PmxfL/lZ9yj4rZgQ0pZfllt+P0rddqlvP+41Vo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=md06AXeFX8WtPEvxvb55tAk1TOPicy+mWIi3j39i4jXg65FC4ybe3Q2HW3fuc+tNv
	 2wEipGsQUUrEDaVdrtoWpZ0vuOSVzBOwoyUtV6fYClaGcUng2JnLqvy4nArAZFQI8f
	 MO9crRTno70Np+io4nyXhzYikHoMPMoU+E8bf9fLy7ZW3+Fvf7i6kKjYLsvgAhhBcd
	 JAQoH5d4odXPcUG4ugm0O8UX9MuHNXRR90/2Qbo6qd/9n3XvCQsQCdm3qC+B/Vv+0o
	 m088oK6z3TKihQApl3kbkaSiHKjXmwmahlv0hET7OmCNZHRkMevd8PDITIrFwpYiiY
	 Lg/emVVTjJuKg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B080C41AA1;
	Mon,  9 Jun 2025 21:15:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: shouyeliu <shouyeliu@gmail.com>, ray.huang@amd.com,
 gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shouye Liu <shouyeliu@tencent.com>
Subject: Re: [PATCH] Documentation: amd-pstate:fix minimum performance state
 label error
In-Reply-To: <20250522070140.17557-1-shouyeliu@gmail.com>
References: <20250522070140.17557-1-shouyeliu@gmail.com>
Date: Mon, 09 Jun 2025 15:15:48 -0600
Message-ID: <87zfeg8vln.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shouyeliu <shouyeliu@gmail.com> writes:

> In the AMD P-States Performance Scale diagram, the labels for "Max Perf"
> and "Lowest Perf" were incorrectly used to define the range for
> "Desired Perf".The "Desired performance target" should be bounded by the
> "Maximum requested performance" and the "Minimum requested performance",
> which corresponds to "Max Perf" and "Min Perf", respectively.
>
> Signed-off-by: Shouye Liu <shouyeliu@tencent.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

jon

