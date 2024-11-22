Return-Path: <linux-pm+bounces-17966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E58F39D6343
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 18:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82B3BB26FD0
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290AA1DEFC6;
	Fri, 22 Nov 2024 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="gCg1Jfy+"
X-Original-To: linux-pm@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953C81DF250;
	Fri, 22 Nov 2024 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297034; cv=none; b=GTLV5kz1pd7oNjBz3J6QaVsmuhXNqUKco0GuxV0YYsu9tkSh59VDPqx/tsgMgWo/2c4hs2i09EE/vxK+qK5TUGQZDmtwKmGTupW9JRe5nlvvCEZv5Ge5pUOIJte3IAM6NcZosHF3a44vXNd00mI8JXPS2lbg6ZzDuWf9PvBiZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297034; c=relaxed/simple;
	bh=Q1YnYcM8loX9qqAfgjT2l9gRvOlv8b4zcm1FtFvDxyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iLdUACPF/7fDtPHMTwzj4rQzSYzVTIqmggVfSnGIjr1Wj55j5gIOk+VoJj3+TBP6nLbSyelDh6OKgJD3inDN0ya8hZv5rB9pFgHo4zaU876HzHl1hXYzduHc8Xih04o/YNKueAdOo+Jtji750snKqPmgVxT656czPLoCttAG5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=gCg1Jfy+; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BDEE3403E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1732297031; bh=+9dG1RLUPPes0X3wuWZjFH472Bkwm1K2mxlu8XAabek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gCg1Jfy+VxYxEiEeK5ovYvkvHnq+BUHL1tZayu1kFtl4EaOUB5CiisHIPKBtht2Wx
	 E6SSALm1bd3SFNglkC6iV/y79C4QxCEkmCxtL54iOv/vzVAMHVqiIDJ2yymohVcMHn
	 Q9Wf/TyQuiKVOlL0s0EolHnmCwMGT1PWbRz3bA4OrDtVWHf468GYpbY6kdSE7JKCc/
	 coa64lt4vxNCghN2aBnebMmYA/txMGuVw2INz5un0KBqPB/PwLaVXX6zCWLBrAk2aJ
	 /C/xam30UJlgN8OSS0OevMh70JYs+VpFcHjdy8tEGs591Wfl7ovz9G9ZETo/s+MfZK
	 d6RBEoleGSULA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BDEE3403E9;
	Fri, 22 Nov 2024 17:37:11 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Bartosz Golaszewski
 <brgl@bgdev.pl>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH] Documentation: pwrseq: Fix trivial misspellings
In-Reply-To: <20241120-pwrseq-doc-trivial-fixes-v1-1-19a70f4dd156@gmail.com>
References: <20241120-pwrseq-doc-trivial-fixes-v1-1-19a70f4dd156@gmail.com>
Date: Fri, 22 Nov 2024 10:37:10 -0700
Message-ID: <87zflr2mrd.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Javier Carrasco <javier.carrasco.cruz@gmail.com> writes:

> Use proper spelling for 'discrete'. When at it, capitalize 'Linux',
> which is common practice in the documentation.
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  Documentation/driver-api/pwrseq.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

jon

