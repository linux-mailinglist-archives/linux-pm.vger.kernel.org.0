Return-Path: <linux-pm+bounces-20302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDA5A0B4EC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75A37A309B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 10:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4454A22F14F;
	Mon, 13 Jan 2025 10:57:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D660E21ADDB;
	Mon, 13 Jan 2025 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736765877; cv=none; b=Mncu0hsnVjdW2IFJYN4v4ZV5V7yKBA4JTq0wFR2Xk7zf+F+9Fa1cjPCjQM6EHujTiCArjo3cbtJ4buFJkBv1Qlty6qUX7hqfTQD6/oFNfTaGKSNOtf4UMcfsVW8jKhRwNAIjMZzITNfKt7kc0+UAvTbDmm0H7Dz9lzNyepD8i+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736765877; c=relaxed/simple;
	bh=BATHPOH1ZF+4sDXVwdaVfLqUINhlCzVJAIGqneFqunk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t83s0PUzLlKNmAdlMeD6nRfqx/OdO7w5AAYnVBiGxDK3QBCVl+r4B5oAN7yvMtHLvOphwdsssDnh6l9NcJYHP9EmsnduRyReqicwOQmOpX8/Zv1sXYih5dYEUIYBNvRbj7Ow54M+KS2Wg9VLkF3a2pu5+XkbQsMtump9BCjik/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 840A31424;
	Mon, 13 Jan 2025 02:58:22 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FFBB3F66E;
	Mon, 13 Jan 2025 02:57:49 -0800 (PST)
Date: Mon, 13 Jan 2025 10:57:44 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Andras Szemzo
 <szemzo.andras@gmail.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Linus Walleij <linus.walleij@linaro.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Ulf Hansson
 <ulf.hansson@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-phy@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 06/12] dt-bindings: clk: sunxi-ng: add V853 CCU
 clock/reset
Message-ID: <20250113105744.6f7a47b9@donnerap.manchester.arm.com>
In-Reply-To: <CAGb2v67_yMB_4SCjFOR5S6nDxX9=zbX-mDM6YjjL_NRxrEMUFg@mail.gmail.com>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
	<20250110123923.270626-7-szemzo.andras@gmail.com>
	<de280eed-bcc8-4802-9734-5e95ad1f6611@kernel.org>
	<CAGb2v65arvBMg+reReVqK-Y6dL+CSrSx4618msiRKcNf=Vk1=A@mail.gmail.com>
	<fef71e03-489f-4503-9d1b-d61051d45dde@kernel.org>
	<CAGb2v67_yMB_4SCjFOR5S6nDxX9=zbX-mDM6YjjL_NRxrEMUFg@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jan 2025 16:45:10 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Mon, Jan 13, 2025 at 4:21=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> >
> > On 13/01/2025 09:06, Chen-Yu Tsai wrote: =20
> > > On Fri, Jan 10, 2025 at 9:56=E2=80=AFPM Krzysztof Kozlowski <krzk@ker=
nel.org> wrote: =20
> > >>
> > >> On 10/01/2025 13:39, Andras Szemzo wrote: =20
> > >>> As the device tree needs the clock/reset indices, add them to DT bi=
nding
> > >>> headers.
> > >>>
> > >>> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com> =20
> > >>
> > >> That's never a separate commit from the binding.
> > >>
> > >>
> > >> ...
> > >> =20
> > >>> --- /dev/null
> > >>> +++ b/include/dt-bindings/clock/sun8i-v853-r-ccu.h
> > >>> @@ -0,0 +1,16 @@
> > >>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> > >>> +/* Copyright(c) 2020 - 2023 Allwinner Technology Co.,Ltd. All righ=
ts reserved.
> > >>> + *
> > >>> + * Copyright (C) 2023 rengaomin@allwinnertech.com
> > >>> + */
> > >>> +#ifndef _DT_BINDINGS_CLK_SUN8I_V85X_R_CCU_H_
> > >>> +#define _DT_BINDINGS_CLK_SUN8I_V85X_R_CCU_H_
> > >>> +
> > >>> +#define CLK_R_TWD            0
> > >>> +#define CLK_R_PPU            1
> > >>> +#define CLK_R_RTC            2
> > >>> +#define CLK_R_CPUCFG         3
> > >>> +
> > >>> +#define CLK_R_MAX_NO         (CLK_R_CPUCFG + 1) =20
> > >>
> > >> Nope, drop. Not a binding.
> > >> =20
> > >>> +
> > >>> +#endif
> > >>> diff --git a/include/dt-bindings/reset/sun8i-v853-ccu.h b/include/d=
t-bindings/reset/sun8i-v853-ccu.h
> > >>> new file mode 100644
> > >>> index 000000000000..89d94fcbdb55
> > >>> --- /dev/null
> > >>> +++ b/include/dt-bindings/reset/sun8i-v853-ccu.h
> > >>> @@ -0,0 +1,62 @@
> > >>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */ =20
> > >>
> > >> Odd license. Did you copy the file with such license from the downst=
ream? =20
> > >
> > > AFAIK all the existing sunxi clock / reset binding header files are
> > > dual licensed. OOTH all the YAML files are GPL 2.0 only.
> > >
> > > IIRC we started out GPL 2.0 only, but then figured that the header fi=
les
> > > couldn't be shared with non-GPL projects, so we changed those to dual
> > > license.
> > >
> > > Hope that explains the current situation. Relicensing the whole lot
> > > to just MIT or BSD is probably doable. =20
> > That's not what the comment is about. Dual license, as expressed by
> > submitting bindings/patches and enforced by checkpatch are expected. But
> > not GPLv3, GPLv4 and GPLv10. =20
>=20
> I take back my statement. It seems we have a lot of GPLv2 or later going =
on.
>=20
> include/dt-bindings/clock/sun20i-d1-ccu.h:/* SPDX-License-Identifier:
> (GPL-2.0+ OR MIT) */
> include/dt-bindings/clock/sun20i-d1-r-ccu.h:/*
> SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> include/dt-bindings/clock/sun50i-a100-ccu.h:/*
> SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> include/dt-bindings/clock/sun50i-a100-r-ccu.h:/*
> SPDX-License-Identifier: GPL-2.0 */
> include/dt-bindings/clock/sun50i-h6-ccu.h:/* SPDX-License-Identifier:
> (GPL-2.0+ OR MIT) */
> include/dt-bindings/clock/sun50i-h6-r-ccu.h:/*
> SPDX-License-Identifier: GPL-2.0 */
> include/dt-bindings/clock/sun50i-h616-ccu.h:/*
> SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> include/dt-bindings/clock/sun5i-ccu.h:/* SPDX-License-Identifier:
> GPL-2.0-or-later */
> include/dt-bindings/clock/sun6i-rtc.h:/* SPDX-License-Identifier:
> (GPL-2.0+ OR MIT) */
> include/dt-bindings/clock/sun8i-de2.h: * SPDX-License-Identifier:
> (GPL-2.0+ OR MIT)
> include/dt-bindings/clock/sun8i-tcon-top.h:/* SPDX-License-Identifier:
> (GPL-2.0+ OR MIT) */
> include/dt-bindings/clock/suniv-ccu-f1c100s.h:/*
> SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> include/dt-bindings/reset/sun20i-d1-ccu.h:/* SPDX-License-Identifier:
> (GPL-2.0+ OR MIT) */
> include/dt-bindings/reset/sun20i-d1-r-ccu.h:/*
> SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> include/dt-bindings/reset/sun50i-a100-ccu.h:/*
> SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> include/dt-bindings/reset/sun50i-a100-r-ccu.h:/*
> SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> include/dt-bindings/reset/sun50i-h6-ccu.h:/* SPDX-License-Identifier:
> (GPL-2.0+ OR MIT) */
> include/dt-bindings/reset/sun50i-h6-r-ccu.h:/*
> SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> include/dt-bindings/reset/sun50i-h616-ccu.h:/*
> SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> include/dt-bindings/reset/sun5i-ccu.h:/* SPDX-License-Identifier:
> GPL-2.0-or-later */
> include/dt-bindings/reset/sun8i-de2.h: * SPDX-License-Identifier:
> (GPL-2.0+ OR MIT)
> include/dt-bindings/reset/suniv-ccu-f1c100s.h:/*
> SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>=20
> Is there a requirement that new files have to be GPL 2.0 only, not
> GPL 2.0 or later?
>=20
> Documentation/process/license-rules.rst says:
> The license described in the COPYING file applies to the kernel source
> as a whole, though individual source files can have a different license
> which is required to be compatible with the GPL-2.0::
>=20
>     GPL-1.0+  :  GNU General Public License v1.0 or later
>     GPL-2.0+  :  GNU General Public License v2.0 or later
>     ...
>=20
> Aside from that, individual files can be provided under a dual license,
> e.g. one of the compatible GPL variants and alternatively under a
> permissive license like BSD, MIT etc.

Documentation/devicetree/bindings/submitting-patches.rst overrides the
general rule, for binding files, and it says (GPL-2.0-only OR BSD-2-Clause)
is preferred. Also when I checked checkpatch indeed warned about this. As
for the existing files: yes, many of them are not compliant atm:
$ git grep -h SPDX include/dt-bindings | sort | uniq -c | sort -n | tail -13
     10 /* SPDX-License-Identifier: GPL-2.0 OR MIT */
     13 /* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
     13 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
     14 /* SPDX-License-Identifier: GPL-2.0+
     19 /* SPDX-License-Identifier: GPL-2.0
     27 /* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
     31 /* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
     31 /* SPDX-License-Identifier: GPL-2.0-or-later */
     33 /* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
     36 /* SPDX-License-Identifier: GPL-2.0+ */
    176 /* SPDX-License-Identifier: GPL-2.0-only */
    192 /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
    281 /* SPDX-License-Identifier: GPL-2.0 */

But for new patches we should definitely aim to be correct. Differing
license requirements are one price we pay for not having a separate DT
repository.

Cheers,
Andre

