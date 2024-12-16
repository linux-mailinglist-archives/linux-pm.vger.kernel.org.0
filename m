Return-Path: <linux-pm+bounces-19356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 155309F3DCF
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 23:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586F116AFC5
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 22:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B20D1D89F7;
	Mon, 16 Dec 2024 22:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M7K7dG9h"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C6B1D88AC;
	Mon, 16 Dec 2024 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734389705; cv=none; b=W4MbYzExeZaZZSSGg5YH+x0ZAuvejjIdmBTxOoD4HOqcEQkrq0PjFd3nhZxPV9JbnKj7RLdMCYJ2mKWV25wC/TnPo/O6zDgEoBvVgaVBV5qdN67aegBDEtl6ALUNqtNy2vIgYRnbQS23jkmYO0J3QqOru7IJXRyrBcR+cMygutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734389705; c=relaxed/simple;
	bh=k9NUczgE5afoW2R/ObI/FDGVpPK8DosAmvDcl+FS5OA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jher/dRFffq1xs5wZ/PVo4ud3B68Uc89ZxU/rfBz9zVvQaZzv3Z0iwFgpxIrCofhRyY4An5GZizq63+Xnin3+LqpxFb5JkAEjyJQV5BGH/CDc9Czw/HE8bhNlPhJ1kwnVI4kq3aTNGyE1jlX2yLe40jOZXMYKvV7rRcQYNbcWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M7K7dG9h; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06679C0003;
	Mon, 16 Dec 2024 22:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734389699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fV5e/unfpOyTP78WuJI+lL4T0kp1x8P3iyxboyk8CI=;
	b=M7K7dG9hNs144lbC4tFE4v5qP0Sk04SievkUEmEhp01weoUA2bmkioucoEY5RUlSvM5QFN
	+ASgHev+xFPZZlCCnUXzK7cKR5nO0ugim6AR3b2Yzj2qnZjrfsKUW6y2rWqhA1eIwthBQS
	oXJTxJr/I1QKeAo7lNP0KXBLoQX3n4ndPvL7MBzxrV7uLTztX62wMrkQAP3O+UdutINxP7
	XlLoDTgDB0m/o/Sv5dpMX61MxymAICC9XTD1Qj4OsmLKI/DpVLnWiYRXti8ovnb3ksQsn4
	rGGH62V4k5s4+PSQDfqiYWF50+cKZldlS6nAZKYmQ1ofvMlJLw//6p9VutNzUA==
Date: Mon, 16 Dec 2024 23:54:56 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, Ulf Hansson
 <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Marek
 Vasut <marex@denx.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>, Jindong
 Yue <jindong.yue@nxp.com>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Paul Elder
 <paul.elder@ideasonboard.com>, =?UTF-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>
Subject: Re: imx8m-blk-ctrl: WARNING, no release() function
Message-ID: <20241216235456.3a6b07a2@booty>
In-Reply-To: <20241212141003.GA44219@francesco-nb>
References: <20241212141003.GA44219@francesco-nb>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Francesco,

+Cc: Jindong, Benjamin, Paul (recent committers, in lack of an
imx8m-blk-ctrl.c maintainer)
+Cc: Herv=C3=A9 (stumbled on this issue too)

On Thu, 12 Dec 2024 15:10:03 +0100
Francesco Dolcini <francesco@dolcini.it> wrote:

> Hello,
> on v6.13-rc2 (PREEMPT_RT, if it matters), I have the following warning
>=20
> [    4.615793] ------------[ cut here ]------------
> [    4.615814] Device 'mediablk-mipi-csi2-1' does not have a release() fu=
nction, it is broken and must be fixed. See Documentation/core-api/kobject.=
rst.

Thanks for the report. It is happening also here after upgrading from
6.13-rc1 to 6.13-rc3.

This originates from drivers/pmdomain/imx/imx8m-blk-ctrl.c

I bisected and the initial commit exposing this warning is:

  commit b8f7bbd1f4ecff6d6277b8c454f62bb0a1c6dbe4
  Author: Ulf Hansson <ulf.hansson@linaro.org>
  Date:   Fri Nov 22 14:42:02 2024 +0100

    pmdomain: core: Add missing put_device()
   =20
    When removing a genpd we don't clean up the genpd->dev correctly. Let's=
 add
    the missing put_device() in genpd_free_data() to fix this.
   =20
    Fixes: 401ea1572de9 ("PM / Domain: Add struct device to genpd")
    Cc: stable@vger.kernel.org
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
    Message-ID: <20241122134207.157283-2-ulf.hansson@linaro.org>

Superficially, it looks to me like a legitimate commit which exposes a
pre-existing flaw in drivers/pmdomain/imx/imx8m-blk-ctrl.c.

I have no more info at the moment.

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

