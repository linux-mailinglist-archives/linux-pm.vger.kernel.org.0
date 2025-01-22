Return-Path: <linux-pm+bounces-20818-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 619BDA197A4
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 18:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46BF116D25E
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493AA2153F9;
	Wed, 22 Jan 2025 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RMKSIZEB"
X-Original-To: linux-pm@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C8B215186;
	Wed, 22 Jan 2025 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566773; cv=none; b=WDi2cw7iAYwOFvQ2VUmyYSeKyHTtFD+H/FFGXsyrjCk9ISKNQ6BL29cKfhVLmyPQTEF5Td3wXDlOW+gf962qEXaEXc6S3TsQugWgyCSfOZORrOR8ikkFuU2v/QpQOsKKHVnQfHMdjXa4+0FCLaCtbxElClgXd9RpdKKFYvDphO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566773; c=relaxed/simple;
	bh=4+IGskPBvauLeJEYWorDMqDLbQHHtg+oFp+ZTNuOKmc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BLopxdAG1l9s5ZLNxaaJgIj7h4sZrl+u9Ypb/1XgYY4/UQjV3PNSN/3u+rrIOrETid0O/lJx73VR0gy0TfI50IpGzA6bdGjMd2Qfpp5XySy/Wm4MtObc9F2CAgvwZX3sE4s7VrbQV+n9TmOdJB1udMeOZP0IR7n0VswuEXC4A1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=RMKSIZEB; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 76D55404F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1737566770; bh=VPKub2rkuUOTEdgOVnC0xVagEs1PHG/VOXHKsywdzTw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RMKSIZEB3hYxEQTZUcVba0FBAFrH2n3kBY7Q29pnG8x00e2IhYVIte0aKD4J9hgFi
	 BYSNMCllD5YEXK6DOtrQX+ijfQheMJn6q2PmhbHq+mF+8PFqZATL7879VM5vXqbv6d
	 nR/vUy22YOWG2zscAl3EYtWubNQU7akB8uh+KQL7FXn9qwYK8IVLhs4GCLae0xeD6o
	 CRmMoNbUniE+ZgQfwxYaAnocykYRJx9sRBLK8L8susWWKH8/gpX+GIfl0fkA4wJm6k
	 ysx+t8zAVdSWYRPRYlsu5AgQllPCtCdTgqQ8SRxNwiXxlWXH/jDGOJYYUSWGKhnvgH
	 vY3APNmPvbfnQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 76D55404F5;
	Wed, 22 Jan 2025 17:26:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Media
 <linux-media@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Block Devices
 <linux-block@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Power Management
 <linux-pm@vger.kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao
 <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Ming Lei <ming.lei@redhat.com>, Jens
 Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Bagas Sanjaya
 <bagasdotme@gmail.com>
Subject: Re: [PATCH 0/3] Tree-wide nreferenced footnotes fixes
In-Reply-To: <20250122143456.68867-1-bagasdotme@gmail.com>
References: <20250122143456.68867-1-bagasdotme@gmail.com>
Date: Wed, 22 Jan 2025 10:26:09 -0700
Message-ID: <87msfidaku.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Sphinx 8.1 introduces improved unrefenced footnotes detector. The changelog
> [1] reads:
>
>     - #12730: The UnreferencedFootnotesDetector transform has been improved
>       to more consistently detect unreferenced footnotes. Note, the priority
>       of the transform has been changed from 200 to 622, so that it now runs
>       after the docutils Footnotes resolution transform. Patch by Chris Sewell.

Something they don't advertise so much, but should: this release also
cuts the docs-build time almost in half for me.  Very nice.

> As a result, a few new warnings are smoked out in the whole tree, that
> are previously unnoticed in earlier Sphinx versions. Let's squash these
> warnings.
>
> [1]: https://lore.kernel.org/linux-next/07507296-a37b-4543-97cb-0560ef7fb7b8@gmail.com/
>
> Bagas Sanjaya (3):
>   media: ipu3.rst: Prune unreferenced footnotes
>   Documentation: ublk: Drop Stefan Hajnoczi's message footnote
>   docs: power: Fix footnote reference for Toshiba Satellite P10-554
>
>  Documentation/admin-guide/media/ipu3.rst | 7 ++-----
>  Documentation/block/ublk.rst             | 2 --
>  Documentation/power/video.rst            | 2 +-
>  3 files changed, 3 insertions(+), 8 deletions(-)

I'll apply these and ship them on up before the end of the merge window,
thanks.

jon

