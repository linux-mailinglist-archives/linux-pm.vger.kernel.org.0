Return-Path: <linux-pm+bounces-30284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C824AFB1E9
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 13:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF3F3BC10A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 11:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616FB1F8723;
	Mon,  7 Jul 2025 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="DFiSm9ld";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="UUa3d3yY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E091A238F;
	Mon,  7 Jul 2025 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886216; cv=none; b=lbP9AEc2WTOoIqeHjdsJoQOwS89YGpYMRE92T2u+O1Hz/eCQ+OuK4AYw6F29cOYjB80ispzbQU4aFNtonGrBGS4OD4AGeq+4bGHbhu/Gn9A1YPyPysBY2rDSzh/hOciy3rhphEAw/edZG6Rpb7KvuRtam+F+NRzvCPN8IK3+PSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886216; c=relaxed/simple;
	bh=xCmkd4Zjm7mVsUjBd9uINjW6Ko67WGaG8Bjqp/KixJQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b+BX1bPi5YM9bv0TVdj2wBeVVLvElyt9T68Lhrl/5yu1c7VSFR6o0iL+KrFrfGjPMUsWFJI3eM3vdQjdNzF64B8MWGnxlRhaSK2Ruk7eXIe+lUz7vVEhURsTG+7wgDeXql1UE/pBl3QD9y7xKThSAWjqaH9SDASN+Yj1Xe4ouhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=DFiSm9ld; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=UUa3d3yY reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1751886212; x=1783422212;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Ug4nJXmIqp8sQ35I/seriKRiXJkMk1I4o9Igs4X0jZ0=;
  b=DFiSm9ldHepWzp4JatOuq6ognwm5A8UuqofZX+zjoOiTXksI2gkq6qKK
   WNuGUuFG1BW+tBwHHNtdx8WKb6lRy+6olutRVjhyTtdYyZsPbAiTask2J
   u+Bo4ScWVrIcUxFCMfBtQu/M3R0/sJD8b/px9m2Lg6iBYNiKIkb0e9yTP
   BbekFeWOKraOXEdmW+BCrKO6pgL9lyoz2bsJYwwLjjJj3k393nkgYVO1Y
   IGKbJ3uLRLmJC+sftoLvIiiVSJUg/kVUrrxKIH/XZouohQmQzuy50jJj+
   jaOFyn/Hv2y8BsJ/LgSReHCl9M2ecWkl1FwYo4TsHTOYqFrC4PTNFYqvl
   w==;
X-CSE-ConnectionGUID: 4odISi9TQW65FYIAN4Ajbw==
X-CSE-MsgGUID: IoiK02W8RAiajKvG+JKgaA==
X-IronPort-AV: E=Sophos;i="6.16,294,1744063200"; 
   d="scan'208";a="45060375"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Jul 2025 13:03:29 +0200
X-CheckPoint: {686BA980-51-A38CADE4-FD2ABC4A}
X-MAIL-CPID: AFDB9082BABAEE7E59D36B5735A04F59_3
X-Control-Analysis: str=0001.0A00639A.686BA995.000D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C486164A48;
	Mon,  7 Jul 2025 13:03:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1751886204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ug4nJXmIqp8sQ35I/seriKRiXJkMk1I4o9Igs4X0jZ0=;
	b=UUa3d3yYr/TkQMnRR0wmo/RXjVxl9ZzUFopgaJlxwHFPAeGg4yOBBtvRSV38nuztvyx5GA
	EeXVqxUE5KrPyfvpK5reYVcMq5A2sSKbjBCHFfyu8gV/ekIZLn8mGYf6R3H7HtDSd0MMPQ
	QcLpA6d0r22nZyg38hU7c7YJrN4WNBDBYFhQc6YkwZbIFacBVRd+o9KnpRTqIsXdGIg9sm
	qrwfpFXay8BXo56oqMSUVILO9I07L+QmbSOFpLHk48K/Nuf3PupjxJbv9f1yqXGYaqzp/J
	TOj0VxeoUsBUMx1aqW0jj7Mx/gi/U/sNf1zwDjkQtKMSBDcMYjbfP7MDGD+W+g==
Message-ID: <cad132c167e61c595add4cc43dfc0f1bc3d569d2.camel@ew.tq-group.com>
Subject: Re: [PATCH] pmdomain: ti: Select PM_GENERIC_DOMAINS
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vishalm@ti.com, 
	vigneshr@ti.com, nm@ti.com, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux@ew.tq-group.com
Date: Mon, 07 Jul 2025 13:03:23 +0200
In-Reply-To: <20250704-depspmdomain-v1-1-ef2710556e62@baylibre.com>
References: <20250704-depspmdomain-v1-1-ef2710556e62@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 2025-07-04 at 11:08 +0200, Guillaume La Roque wrote:
> Select PM_GENERIC_DOMAINS instead of depending on it to ensure
> it is always enabled when TI_SCI_PM_DOMAINS is selected. This
> simplifies the configuration process and prevents build errors
> if PM_GENERIC_DOMAINS is not explicitly enabled.
>=20
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

The commit message is a bit off - as PM_GENERIC_DOMAINS is an implicit symb=
ol,
it can only be enabled by 'select', enabling it explicitly is not possible.

A Fixes tag may also be a good idea.

Best,
Matthias



> ---
>  drivers/pmdomain/ti/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pmdomain/ti/Kconfig b/drivers/pmdomain/ti/Kconfig
> index 67c608bf7ed0..35a4c73da17a 100644
> --- a/drivers/pmdomain/ti/Kconfig
> +++ b/drivers/pmdomain/ti/Kconfig
> @@ -10,7 +10,7 @@ if SOC_TI
>  config TI_SCI_PM_DOMAINS
>  	tristate "TI SCI PM Domains Driver"
>  	depends on TI_SCI_PROTOCOL
> -	depends on PM_GENERIC_DOMAINS
> +	select PM_GENERIC_DOMAINS
>  	help
>  	  Generic power domain implementation for TI device implementing
>  	  the TI SCI protocol.
>=20
> ---
> base-commit: 8d6c58332c7a8ba025fcfa76888b6c37dbce9633
> change-id: 20250704-depspmdomain-2c584745dca8
>=20
> Best regards,

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

