Return-Path: <linux-pm+bounces-16439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508099AFD5B
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 10:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1544928363B
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED951D318F;
	Fri, 25 Oct 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbqwVnO+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2004171E43;
	Fri, 25 Oct 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846678; cv=none; b=awUExLJW/eTNgF3JrDv4tkH8S6pfSUwun2D7JxXFanK1KIp4gx+iaL2hsFyK8sWd32YtY8rwDORJySCLmYh/KmwrvAxCAS1XsbVaKYDoywwPjtW4r0aXXP22rV9r8MOKpT8h5Q7qYG/RmaR71S+3Ny4zo+fQoGHL+jV2MBVAY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846678; c=relaxed/simple;
	bh=Y/XIwrUUcIZ6gH1/w/6aJvG+nfnvrMmFH2qM6DZcppc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vu7LxhOivDtMBBejHMhsETL5Z7CzJZMYptr4P6BbxLhzozzn566qKE7lBPVwKeBx/dIZv5FJN52MREBblUXF5nfdrCP91eKKlLI8Oz1vu7ARJgs4NeHLl7TBioUgk2n6FCc2NHdE7TY2EPl2a6T1F/0r5k4SOG/K2fUMywmtZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbqwVnO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABB0C4CEC3;
	Fri, 25 Oct 2024 08:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729846678;
	bh=Y/XIwrUUcIZ6gH1/w/6aJvG+nfnvrMmFH2qM6DZcppc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbqwVnO+5w95yjLROHnMXt4mjq4MFLyNjWvbMq1A2twdVnKld/MjsBXu2cs/EpNza
	 PCVwtEr8xe0Lq0ODRA2KdhaIpvrPGsmq98mFp100Zl1GszNfdZpF5dR6azKbtejDip
	 ypuPBCr2ZZNiR1QVsfNhWeJMpKjqY/XND4Ob0nYuI5i+vBelcs4MR8EbP1aEqPNA1i
	 Lo+UF1QxP6gVnvtYtYa0x4XrLgQSmoJUHVf10miYX/zMbhetjF45BEQBaur61b9jeS
	 6phfGWae7h1gNP1jvBYsujV4H36d5TbCLF2PFRj7y9jOM75JzFiWkD+wFU53TddlHK
	 +cHyh8ahR7Y0Q==
Date: Fri, 25 Oct 2024 09:57:52 +0100
From: Lee Jones <lee@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 3/7] mfd: Add new driver for MAX77705 PMIC
Message-ID: <20241025085752.GD10824@google.com>
References: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
 <20241007-starqltechn_integration_upstream-v6-3-0d38b5090c57@gmail.com>
 <20241015140224.GI8348@google.com>
 <CABTCjFBpdMv6Qi3CLYNukMn+J1FwhbAg0hMy075Dt0H-g_hrUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABTCjFBpdMv6Qi3CLYNukMn+J1FwhbAg0hMy075Dt0H-g_hrUw@mail.gmail.com>

On Mon, 21 Oct 2024, Dzmitry Sankouski wrote:

> > > diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
> > > new file mode 100644
> > > index 000000000000..553f20a6cdd5
> > > --- /dev/null
> > > +++ b/drivers/mfd/max77705.c
> > > @@ -0,0 +1,248 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +//
> > > +// max77705.c - mfd core driver for the MAX77705
> >
> (...)
> > > +// Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
> >
> > Only the SPDX in C++ comments please.
> >
> This conflicts with https://patchwork.kernel.org/comment/25898728/

a) Mark is only talking about the file header

> > > +
> (...)
> 
> > > +++ b/include/linux/mfd/max77705-private.h
> > > @@ -0,0 +1,180 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +//
> > > +// Maxim MAX77705 definitions.
> > > +//
> > > +// Copyright (C) 2015 Samsung Electronics, Inc.
> > > +// Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
> >
> > No C++ please.
> 
> This conflicts with https://patchwork.kernel.org/comment/25898728/

a) Mark is only talking about the file header
b) Different subsystem, different rules.

> 
> >
> > > +
> > > +#ifndef __LINUX_MFD_MAX77705_PRIV_H
> > > +#define __LINUX_MFD_MAX77705_PRIV_H
> > > +
> > > +#include <linux/pm.h>
> > > +
> > > +#define MAX77705_SRC_IRQ_CHG BIT(0)
> > > +#define MAX77705_SRC_IRQ_TOP BIT(1)
> > > +#define MAX77705_SRC_IRQ_FG  BIT(2)
> > > +#define MAX77705_SRC_IRQ_USBC        BIT(3)
> > > +#define MAX77705_SRC_IRQ_ALL (MAX77705_SRC_IRQ_CHG | MAX77705_SRC_IRQ_TOP | \
> > > +                             MAX77705_SRC_IRQ_FG | MAX77705_SRC_IRQ_USBC)
> > > +
> > > +// MAX77705_PMIC_REG_PMICREV register
> >
> > No C++ please.
> 
> This conflicts with https://patchwork.kernel.org/comment/25898728/

a) Mark is only talking about the file header
b) Different subsystem, different rules.

> 
> -- 
> 
> Best regards,
> Dzmitry
> 

-- 
Lee Jones [李琼斯]

