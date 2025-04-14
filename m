Return-Path: <linux-pm+bounces-25381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCB5A8889D
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 18:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3854116B160
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 16:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646382749F6;
	Mon, 14 Apr 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="eQdk2BDP"
X-Original-To: linux-pm@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5620F1917E7;
	Mon, 14 Apr 2025 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744648212; cv=none; b=kCXJFW36xkPR8DUI3Bbs5HDR18y9V01psXHvCNKbf+IRDa+dv+LGl9hmnQk/tTo5n0PXaJFIYz12/zf1q+3kjy+s//c7GLgiyvXDGo8aecwf2VTIMmvOFbhwiKNvp1dqufLXjTlL8PFrd9YD6KsYrYLw1wriE+Fyg92a9COFraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744648212; c=relaxed/simple;
	bh=LWvI8jxc8h34vAUjjz0+jI/jT5FfMlpEJ9geMFOJFik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mu2i/wtkxgyOrsw3FxOYF24Y1verMaqKCbVoLuPrhwH6kbsjwD2Qb2uM72WsAWpN6y+VJJQvNzYckd4hDB/Oyc9KABSaStuMeBF9PDx08gLoZ4yvpAg7PxNBFhyPja2+4IPirR6ADuxy2XaWu0mYeetZmZHbbNy/H4CJubUh9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=eQdk2BDP; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 751F841A9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1744648209; bh=Zm8hSESsQbh1kU0KZ+o1NRajNdhzt07r2P5A9yhBcqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eQdk2BDPosBo3/iF2tVPzPwk6egk1ljRb+UdjD3/ha6v6KBL7dTXcc0n9S2QiwO8Z
	 gfUORSQHuFnRbprij/on4taRVD1BmP3pVYw3f0+z3sPiy7LdSgQmi6rZlpnvdXyH6N
	 nPfllr3b0aUZnlFlSj5IB/XdFciEQDIiNRoiWUTXfKTYvVCEHAXXC6uOUzYt+6J/oN
	 TrkwjU+u4ksPRj97UC0xy9Kylnso/hiBo5bWZ/3g/SXLID75mxX+9l2BcenRtaoprE
	 I15pA6Rq62d/CuNekjyMjhPlUOpag9I0IwFZHOcY3lpb15WwIeSRooisHrC6+suTY/
	 Tlij/thrTvWHg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 751F841A9B;
	Mon, 14 Apr 2025 16:30:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: editing corrections to cpufreq.rst
In-Reply-To: <20250405001447.4039463-1-rdunlap@infradead.org>
References: <20250405001447.4039463-1-rdunlap@infradead.org>
Date: Mon, 14 Apr 2025 10:30:08 -0600
Message-ID: <87o6wyaepb.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Change a few words and abbreviations/punctuation.
>
> Change one echo command to include a trailing '`'.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/admin-guide/pm/cpufreq.rst |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

jon

