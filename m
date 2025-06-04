Return-Path: <linux-pm+bounces-28109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6013ACDFCC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 16:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF423A6D22
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 14:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A03C290098;
	Wed,  4 Jun 2025 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="jrVdRHgc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CE728F53F;
	Wed,  4 Jun 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749045844; cv=none; b=mzSAKPYDAt4XZQXv5CnR7O0rdzilZDCB82X6ZKxiz5b2jN2rqVAbM2DQp42LWIbUXbHmu0xUoNtz36ZleMejzejmup2g+n57kKEB3GzGQSa9+vIz140Eup+ooBh/6y7Oovo0AQRqOGdMhiaJV4Ox4qklQ9fsI9JtehvB4st93ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749045844; c=relaxed/simple;
	bh=/vwiZTWzmPgsj0KUENqU6UhJJnC2/Rz+pMduVn1+OWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By6iZe7GSowrlYjM8cgruLo9hg2qMcvtUq9b755e/2YqYVi02/l977A6Qm1LoU7Iu+4qR7txWmXdbdABHXdmxv2I6QNBDx/ADYvTlxTMr2ech4PhXQ1M5+g3N5sN4PD7jSSo5kcGnrZ7Wys4l9oOGJH2wv0oCu/cbUGy1zPWU1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=jrVdRHgc; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8127D3D85613;
	Wed,  4 Jun 2025 10:03:54 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id PCGfP4LjU-ST; Wed,  4 Jun 2025 10:03:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F2EEA3D88020;
	Wed,  4 Jun 2025 10:03:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com F2EEA3D88020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1749045834; bh=kkcJ9urY/imVZiy9fJFRtQMpM50BrSYPIVeR4sQD1Hw=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=jrVdRHgcehZn4jD9LQREdvY2QkR2bdcP5AxpqN/c/xDLQ67GvSyoGJBnMEn87WYAh
	 6Kv/xomV1Sc2vQp3WHGPkFMs7S97ehE+XhNEG06x6NVoM5v/fdomWUOlyVPLkjHaeQ
	 giyyieJvU4bQuvgS8ZFgcAVhc6nLp3LDRBBX4ioNhFvV8EpgS3AdRBCDy178FDKowf
	 r4xCy6i6JBDJf3wxi97P/ptbK6+pbSPBK4O+WDuBimC5URjJdiy9qJnTSVrwU/qeaT
	 R+plU7E/MazZBGksAJgdKCDlUtqNVHE49Z5A3mI95nYHnIBxwzq4RjWvvOhX/Dd/kI
	 xfHXe859l7t9g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id vay_oKC6Iaut; Wed,  4 Jun 2025 10:03:53 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id AAD153D85613;
	Wed,  4 Jun 2025 10:03:53 -0400 (EDT)
Date: Wed, 4 Jun 2025 10:03:52 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Mark Brown <broonie@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v4 3/6] regulator: pf1550: add support for regulator
Message-ID: <aEBSSHA8bxw2igAW@fedora>
References: <20250603-pf1550-v4-0-bfdf51ee59cc@savoirfairelinux.com>
 <20250603-pf1550-v4-3-bfdf51ee59cc@savoirfairelinux.com>
 <eb1fb4e2-42aa-4795-bc6c-dbcf1fa04f11@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb1fb4e2-42aa-4795-bc6c-dbcf1fa04f11@sirena.org.uk>

On Wed, Jun 04, 2025 at 12:35:21PM +0100, Mark Brown wrote:
> On Tue, Jun 03, 2025 at 02:27:47PM -0400, Samuel Kayode via B4 Relay wrote:
> 
> > +static int pf1550_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
> > +{
> > +	int id = rdev_get_id(rdev);
> > +	unsigned int ramp_bits = 0;
> > +	int ret;
> > +
> > +	if (id > PF1550_VREFDDR)
> > +		return -EACCES;
> > +
> > +	if (ramp_delay > 0) {
> > +		ramp_delay = 6250 / ramp_delay;
> > +		ramp_bits = ramp_delay >> 1;
> > +	}
> 
> I'm not seeing validation of the maximum ramp_delay value here?
>
Thanks, that would be addressed in the next version.
> > +	switch (irq_type) {
> > +	case PF1550_PMIC_IRQ_SW1_LS:
> > +		event = REGULATOR_EVENT_OVER_CURRENT;
> > +	case PF1550_PMIC_IRQ_SW1_HS:
> > +		event = REGULATOR_EVENT_OVER_CURRENT;
> > +	case PF1550_PMIC_IRQ_LDO1_FAULT:
> > +		event = REGULATOR_EVENT_OVER_CURRENT;
> 
> You appear to be flagging all these events as over current events which
> doesn't seem entirely plausible.
It does seem like it but the manual describes these interrupts as "current limit
interrupt". The interrupts ending in _LS are "low-side current limit interrupt",
_HS are "high-side current limit interrupt" and _FAULT are "current limit fault
interrupt".

Thanks,
Sam

