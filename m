Return-Path: <linux-pm+bounces-21066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5369BA213FC
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 23:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5671888EDC
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 22:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF701B21BF;
	Tue, 28 Jan 2025 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DwQq7QS3"
X-Original-To: linux-pm@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BEF1DDA09;
	Tue, 28 Jan 2025 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102241; cv=none; b=khPK+i4RlOPoaMrjc0y6aQT+mqH2euvOjiQtowyi1WPqg0tgZfUpG90tow5UzO9AdUDW1DygXnruOw1n5Hbz0MSashvrobtHdsdU4YWD/S9BBYfK0ee9mzPaGaQWUwvXryHjtXXgXMOnDLk+sVLh3wAPkTx1LggqAGOPfnU7KP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102241; c=relaxed/simple;
	bh=t8sA4eSNk6whAxKufIdYeni7vg491zRcU6ZG6oIK0Tw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hNv9U6uv0HQKtLxdCsIKbWewgHpa9jXjK5UMbW9eUMbuz9PZKYV/XzybjbCdl5AFfKr8OnD0NpsqPWCcG+01ulohNdeknVs+kxErfix+fGh2llfIwgAhYNO5c8DfRfp8Hexefk4jV5pYwNxVUTWwQkCDUvCO/lKftws7UV8iKEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DwQq7QS3; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1985B403FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1738102239; bh=uhn+EMDUpiZzCwU1r3iwxCgqS64FgAMEFlS/jK6JAPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DwQq7QS3na4DFyOvFPdmQzGIRk6rIQY6Zf9vtwB63vKED3f34OJULgCu2Likynn6N
	 2Db7oEIJx/zPM19TTkRm9W40NfwbzvU70aBrF8jnHAzzFgOrKdCiO6699Ww4m+lzwJ
	 e6C5ATAl+YFVPAryqfRUwE1j3yFmiwn67Sq1Rum7N86XTo+l0aMwglX+ERRfNE9bCP
	 Q/EVSq4dzopeANze3ZJtsK3pWnF04adjPmHZu1ixn4/uXExdm7PZgtMKjtr62popHY
	 S6FvJfy4p9tZHSuKJYfE6m4Sed2mNaxLwGwRt/mfyNVWFV1AbL8UVmcdzKBwR0s3mZ
	 osqyzEnzi0GYQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1985B403FA;
	Tue, 28 Jan 2025 22:10:39 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, "Rafael J. Wysocki"
 <mchehab+huawei@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
 <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [RFC v2 01/38] docs: power: video.rst: fix a footnote reference
In-Reply-To: <fd7d13339882999a2c53f0e85024c23ee955e0c6.1738020236.git.mchehab+huawei@kernel.org>
References: <cover.1738020236.git.mchehab+huawei@kernel.org>
 <fd7d13339882999a2c53f0e85024c23ee955e0c6.1738020236.git.mchehab+huawei@kernel.org>
Date: Tue, 28 Jan 2025 15:10:38 -0700
Message-ID: <87plk67foh.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Footnotes require an space (or a "\ ") before them, as otherwise
> Sphinx/Docutils won't understand it.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/power/video.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/power/video.rst b/Documentation/power/video.rst
> index 337a2ba9f32f..8ab2458d1304 100644
> --- a/Documentation/power/video.rst
> +++ b/Documentation/power/video.rst
> @@ -190,7 +190,7 @@ Toshiba Portege 3020CT		s3_mode (3)
>  Toshiba Satellite 4030CDT	s3_mode (3) (S1 also works OK)
>  Toshiba Satellite 4080XCDT      s3_mode (3) (S1 also works OK)
>  Toshiba Satellite 4090XCDT      ??? [#f1]_
> -Toshiba Satellite P10-554       s3_bios,s3_mode (4)[#f3]_
> +Toshiba Satellite P10-554       s3_bios,s3_mode (4) [#f3]_
>  Toshiba M30                     (2) xor X with nvidia driver using internal AGP

This one is already fixed in docs-next (will go to mainline shortly), so
you can drop this patch.

Thanks,

jon

