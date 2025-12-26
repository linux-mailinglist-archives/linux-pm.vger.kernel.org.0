Return-Path: <linux-pm+bounces-39942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E22F0CDE856
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 10:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACA3C300A34C
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 09:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FDB1D619F;
	Fri, 26 Dec 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oqA+woMd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3621DA23;
	Fri, 26 Dec 2025 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766740194; cv=none; b=MnMEBEbdbXDj5BD/ILnVUQXoEgWFOYX6e8Oe2ej03ZuFbAqAdJi1v0JtOI+5zPx7KCI7SwvRr0YHh4Dp1/OdEUbKLKqOkYftX16SGSZaymsozX4QXI6pfUoWB/dYLoEC/zga09pCjuXgoIsGMnOD0ao7mOOBNPrz7U/Xc7Gevng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766740194; c=relaxed/simple;
	bh=NDc9Td1nIi1SPp0y679l4SNFtqpbhHKfC+A7ZuRR6Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWMeKNPVQ8uzLiFXZbmic1NmjIVdGvSJ1LRRL9jBoIu6J3mZxP24bwZgxdQM26XfyfF/H6Ym4FfkjGRjVpBo9dxQApn8k2ZwCEcr9Whov8iXQm+Oacup/OLDPPikApJ1sCWXlVMNkRsXCd5oRTQ1IHHv/UUPSB5lE3mzePZcl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oqA+woMd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6332F1A2441;
	Fri, 26 Dec 2025 09:09:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 26EEF606E4;
	Fri, 26 Dec 2025 09:09:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 65601103C8C77;
	Fri, 26 Dec 2025 10:09:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766740189; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5gLacqsJOxfGdZGsocf6XrtXneY4RT9chgPcLr5hdSw=;
	b=oqA+woMdRGfOGBL0KWvBoZPQ6OJ0gUI1QKcKXRmO6aNQI8fuCX8uiVJDQ4EFarhIiMjjhl
	ZHdjJkw21yBxWiw7hTqYvZpnYg+m0nJ3Kwh//gkJO8ahUFf6ASeHc6S3YlRZwzT3LA0GsC
	TZ19L/R2tTwn022oLUc6wpABL64LYWlXMB84VPBRCamQ/CXtVPQca3vAmlXpcLdb/8XC+k
	/bi4HheSvC9roeqSwoqLfedCy+c53vOx9C7B/hrL3+ixMypC/aMOImpUjDDVLT/cwZyh27
	r6I5t89z1JiEV/lE0eA1DuHC1lD8idSEnDTTBHk+26C8eDcAhdqzMh5PJU/PxA==
Date: Fri, 26 Dec 2025 10:09:46 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: lib: thermal: Correct CFLAGS and LDFLAGS in
 pkg-config template
Message-ID: <20251226100946.14ad75d1@windsurf>
In-Reply-To: <20251226-libthermal-pkgconfig-v1-1-3406de5ca8ea@bootlin.com>
References: <20251226-libthermal-pkgconfig-v1-1-3406de5ca8ea@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Romain,

On Fri, 26 Dec 2025 08:54:32 +0100
Romain Gantois <romain.gantois@bootlin.com> wrote:

> diff --git a/tools/lib/thermal/libthermal.pc.template b/tools/lib/thermal=
/libthermal.pc.template
> index ac24d0ab17f5..3b8a24d0a8b8 100644
> --- a/tools/lib/thermal/libthermal.pc.template
> +++ b/tools/lib/thermal/libthermal.pc.template
> @@ -8,5 +8,5 @@ Name: libthermal
>  Description: thermal library
>  Requires: libnl-3.0 libnl-genl-3.0
>  Version: @VERSION@
> -Libs: -L${libdir} -lnl-genl-3 -lnl-3
> -Cflags: -I${includedir} -I${include}/libnl3
> +Libs: -L${libdir} -lnl-genl-3 -lnl-3 -lthermal
> +Cflags: -I${includedir} -I${includedir}/libnl3

Actually -lnl-genl-3 -lnl-3 in Libs and -I${includedir}/libnl3 in
Cflags can be removed as well, because the Requires: field contains
libnl-3.0 and libnl-genl-3.0, which will cause pkg-config to
recursively query the libs/cflags for libnl-3.0 and libnl-genl-3.0.

=46rom https://people.freedesktop.org/~dbn/pkg-config-guide.html:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Cflags: The compiler flags specific to this package and any required
libraries that don't support pkg-config. If the required libraries
support pkg-config, they should be added to Requires or
Requires.private.

Libs: The link flags specific to this package and any required
libraries that don't support pkg-config. The same rule as Cflags
applies here.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Since libnl-3.0 and libnl-genl-3.0 support pkg-config (otherwise they
wouldn't be listed in Requires:), then those flags should be dropped
from Libs: and Cflags:.

Also, since this is a fix, probably this commit requires a Fixes: tag.

Best regards,

Thomas
--=20
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com

