Return-Path: <linux-pm+bounces-12584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D1F958EA9
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 21:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE1B284C22
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 19:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC44514B96B;
	Tue, 20 Aug 2024 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="bL2EsQIm"
X-Original-To: linux-pm@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA018E344;
	Tue, 20 Aug 2024 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724182615; cv=none; b=ebw0UH8yaOH1bTHgIIyqzrXwjKJiYu3wh371MhHWOw0VC6ZNIffdKtH+Mk8+/Vr5H4oo7uRLQ8oheqzJPua0pH1TclM9u7ztZkM5lntDLTP2PvXEYa7esIE2hnUnNFbkoM+DkMMMlNKCkWsbTdGCyL4Pf/h1JklJJWOkaCzK1uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724182615; c=relaxed/simple;
	bh=4N9r4JudbAz/rnrIXPFZRceEdMGQwEOC3Mm1VftOAzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=khfRMgRWPFZ8Ig2vAB9Mb+O8Ta9WeDJArRSWHqu+LrN162+t3vnyyV9l2MBV/j9xw91hm62DIlFPGTW6+rvE+bhy4SXgZcee4FRBrslzl2Js4y91Lx0nPZ9vOlJX4b4PTmmyJh3tCrW5HvjuLbs03GbqE8MGG+4h0egH1e2IukI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=bL2EsQIm; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0A56641A31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1724182611; bh=4N9r4JudbAz/rnrIXPFZRceEdMGQwEOC3Mm1VftOAzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bL2EsQIm9tiX2zqPO8UhI8HtPuZtFVrs4ar4ZIve0LXR342tj2woR2N4q/leWsau4
	 4JoFRo9VKk2Y/EnOtybNAfClaSAMYMvWbACjOjeF6dJvpGsg1MS6tZsAUzSxP9EvML
	 /4B1t8nbgWhn/R2yGZAFNV8ptyewCUm6LFmvTuu6KRJsddhJow4FTXW3zl2zx86UTi
	 e1KQUVJXTzrpA1lPQ1RaIwQbQ9jRqnOFzVED/7o0Er4JbrsmnsTNgCgBxiGbb2CYaQ
	 PPNSbVEV3MfqNiI8RQIWTAcZharb8ecVm56bL3QE+o+OO1QB1Bi3KgNsWr0Y5yEtRX
	 RONmr7C04dJCA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0A56641A31;
	Tue, 20 Aug 2024 19:36:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] Documentation: add a driver API doc for the power
 sequencing subsystem
In-Reply-To: <CAMRc=MeGew-iHFmeKuKqDfDPZtjCfdNXzOzj56=qxssGP90SzQ@mail.gmail.com>
References: <20240820153855.75412-1-brgl@bgdev.pl>
 <87cym3f447.fsf@trenco.lwn.net>
 <CAMRc=MeGew-iHFmeKuKqDfDPZtjCfdNXzOzj56=qxssGP90SzQ@mail.gmail.com>
Date: Tue, 20 Aug 2024 13:36:50 -0600
Message-ID: <874j7ff0kt.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> Am I getting that right, are all these :c:func: directives useless in
> this file or only in this paragraph?

Throughout - it is really just not needed for kernel docs.

Thanks,

jon

