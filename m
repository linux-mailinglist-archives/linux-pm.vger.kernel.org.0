Return-Path: <linux-pm+bounces-28110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5FBACDFDB
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 16:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C51318871F1
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 14:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D137D2900BA;
	Wed,  4 Jun 2025 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="wqKmuQgJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1F290098;
	Wed,  4 Jun 2025 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046120; cv=none; b=LXLlCt2UWCCfj/qQEUG0VpTH9QKXAO6aO/hIUlAY0qANIZPoH7kE4y6dZmXGter68scmseDdvpayTWnL4tUrb3C9ERBCAZQugXAqiOdn5M9IP8XIqSL52azKV5+/v1GdTSlZhSe4WGb+HDp5VdXyDe/+FyKOk+IThgdtPUwIFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046120; c=relaxed/simple;
	bh=qygzon9ZGomXvOHxs2jcZe0II7jq7w4SYlKKQPP37i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WL7ulKBGewQDT/xb6zIev5s+2sfxaNfqELCezR2dR46GJbFx62QHNsg6O3V3bJZvlPDUDQaXDJQBPcAkaRwHnNSS384jhKyAAbVig5xM0flmZevgEqJD1cV/56Xo3m1EwuclunxYEKNi7+w2MGEwy9Ba2OEPDii51dqB5f+JL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=wqKmuQgJ; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2BA983D8579B;
	Wed,  4 Jun 2025 10:08:38 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id AShOL6JctYpF; Wed,  4 Jun 2025 10:08:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 989CC3D85879;
	Wed,  4 Jun 2025 10:08:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 989CC3D85879
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1749046117; bh=Pz5WKHMCeRqhtLXzRHEnNCYyKPN9r9VGYTPK+PEEo5E=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=wqKmuQgJtqMpRVLk0y+HRjAInmpa1C6fUgTK7DBGROL1WhiM6zfTqo86wrT9vAcBi
	 zSu00H04YFM3E8x40iuLR6KhYZsC7ggS5WbgUt9lyw3cCkA3reCs7vVbd+SQrQMxCn
	 oZ1zAOhdP1jEHzt05ov1O/HcAyxRGdy/e3ASKGrumKFgJVg7yLpC1DCig6VK0T27rX
	 VwSbVNc9io+F0Xts6K3N6IaV86zo6t3YJumigmcYY1wT6xUKJ6gn7Q9G0U/IaQN5xq
	 oCUW3Gny3duN42F19tr9mUILfbZnIc6Vk5lyNiTzVP6R4OjDC/pzHq6bbRaCTSt64O
	 QCk562L05HIkw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id kOFfdEsvz-Sa; Wed,  4 Jun 2025 10:08:37 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 3FF763D8579B;
	Wed,  4 Jun 2025 10:08:37 -0400 (EDT)
Date: Wed, 4 Jun 2025 10:08:36 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>
Subject: Re: [PATCH v3 5/6] power: supply: pf1550: add battery charger support
Message-ID: <aEBTZD1WmS14qoNc@fedora>
References: <20250527-pf1550-v3-5-45f69453cd51@savoirfairelinux.com>
 <f5942d82-a7ce-46e1-ba13-ec2beef3403f@web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5942d82-a7ce-46e1-ba13-ec2beef3403f@web.de>
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2025 at 08:44:04PM +0200, Markus Elfring wrote:
> =E2=80=A6
> > +++ b/drivers/power/supply/pf1550-charger.c
> > @@ -0,0 +1,639 @@
> =E2=80=A6
> > +static void pf1550_charger_irq_work(struct work_struct *work)
> > +{
> =E2=80=A6
> > +	mutex_lock(&chg->mutex);
> > +
> > +	for (i =3D 0; i < PF1550_CHARGER_IRQ_NR; i++) {
> =E2=80=A6
> > +	mutex_unlock(&chg->mutex);
> > +}
> =E2=80=A6
>=20
> Under which circumstances would you become interested to apply a statem=
ent
> like =E2=80=9Cguard(mutex)(&chg->mutex);=E2=80=9D?
> https://elixir.bootlin.com/linux/v6.15/source/include/linux/mutex.h#L20=
1
>
I think it can be applied to v4 of this patch. I'll try it out and tag yo=
u on
the next version.

Thanks,
Sam

