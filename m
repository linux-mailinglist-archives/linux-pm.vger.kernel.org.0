Return-Path: <linux-pm+bounces-12653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3AD95A591
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 21:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DF51C22236
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 19:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6CC16F0E7;
	Wed, 21 Aug 2024 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XN6vb6aI"
X-Original-To: linux-pm@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193A016EC1B;
	Wed, 21 Aug 2024 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724270388; cv=none; b=UKkZwDpCWiKvbFm/Zkuc26tEYux64n666pkHHG1EGvnyC90T8/weighB+EcYoYMTyi5glsz11tjEdIShw2D2ufvuMjcwfNFXfLXda2J70XBwDEb4cIjUH0N6mY5g8UGXdzlqwhhk9kjDsQbn3C7FJUdm/uCl62Ocictbuhperb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724270388; c=relaxed/simple;
	bh=VAgoPhhviL2hhQbo1mhkLvKcPYOcpFFpHqEKx9O9XEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b0RKRDwwyOxVIxGaF1ln8r1EESBhKl1vxRz1ZR0FrnTfYQBYdU8BfYrbbwkghVh3/1UwxLfr+XDpYPy236DFBEDyYC9/4WwJdAeb/VmG1J2vk/PWmuSn5C/i8Q+F0sKhyY4xfAM2M0oQdyi3BmlJ5qWdIXDov5iEvU0/NLP44VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XN6vb6aI; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5998F41A8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1724270380; bh=6cS3h/iVQ7Aam5xefn8uF0tHbDYFp7fovRqReBIHk5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XN6vb6aIjbOA1QCy2szgGFJLcGeK5K0CXl7nCp22ecLmWx9jovVnZUrY8bJiPeWIR
	 llFA0U8d/leVgjZw2IDno3+oiI1SrpNx++eyXF5lPJBSMDSYjG85PetwbczCs3x0ZU
	 OubvinHVfF6JnbQixPAgoMuA4BnRb9xF2f2RL1ovbdaiJaz107vu/ABAKNWMCufudt
	 w6GY/2ZXfzwMqs7RWm+6y+l+cKXanZ1ISewqtZ8r1LO3ygHXnRyQrBE9v415SdeYm5
	 SKifrmi2I3IprjJ/t6VZoZ9U49motPi/sJVW4xkshHUhFX4Yr8t9tFmPUHYGCK/ViO
	 d1TPhmLQmX6qw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5998F41A8A;
	Wed, 21 Aug 2024 19:59:40 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] Documentation: add a driver API doc for the power
 sequencing subsystem
In-Reply-To: <20240821100818.13763-1-brgl@bgdev.pl>
References: <20240821100818.13763-1-brgl@bgdev.pl>
Date: Wed, 21 Aug 2024 13:59:39 -0600
Message-ID: <871q2hejf8.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Describe what the subsystem does, how the consumers and providers work
> and add API reference generated from kerneldocs.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Changes since v1:
> - drop unneeded :c:func: directives
> - don't include linux/pwrseq/consumer.h as there are no kerneldocs in it
>   which results in a sphinx warning
>
>  Documentation/driver-api/index.rst  |  1 +
>  Documentation/driver-api/pwrseq.rst | 95 +++++++++++++++++++++++++++++
>  MAINTAINERS                         |  1 +
>  3 files changed, 97 insertions(+)
>  create mode 100644 Documentation/driver-api/pwrseq.rst

Looks good to me, thanks.

Acked-by: Jonathan Corbet <corbet@lwn.net>

jon

