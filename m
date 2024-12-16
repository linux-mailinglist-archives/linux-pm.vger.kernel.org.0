Return-Path: <linux-pm+bounces-19291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F209F2CEB
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 10:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB3F161707
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 09:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC0020101F;
	Mon, 16 Dec 2024 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+wi8k04"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812ED201011;
	Mon, 16 Dec 2024 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341196; cv=none; b=He7Q8zcARMsjwm4DcjYEl+FplPN01UPow/3zUd/VoMf+doCcC35IUXy/7UBHe/oLAcfIABasyY7f5vWzvoGt3gxtqskXWkKY4Rq1CG0qtLsu6JVARhhEWkaxvcLu3XeuehZ0VBvb3ymSlM5B49hIVo1ktV7htZFbviHfRSr31mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341196; c=relaxed/simple;
	bh=AH8G7X2hBjteL80emlIx2HkMUhq8o72V7loxAGG14fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOH0NKa2mXxxUgs9/myM8mMlbuGjH+oakfzNmthpw4zySiwk2VynX23C45DCs8fwZTItBymF2vQVXHLQ3V71qIlzsxR0H9lQrQPVPfTqEooGSG8EvVTG4NfNrih5gQ9Jl9zJYwRrUnb4RPj/wwOMNMrxQght3jCs1CvF9Tr68XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+wi8k04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A707DC4CED0;
	Mon, 16 Dec 2024 09:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734341196;
	bh=AH8G7X2hBjteL80emlIx2HkMUhq8o72V7loxAGG14fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+wi8k04KRi2PiKyun7RzEs0cgkcKZA3C/60OlT3C8fYH++hljJ1pkaYgs37vFhfo
	 uDmimYXhcGc3KC7WQ5ZhrkKI3Dm4eeNaQxWk3GUoxmWNOsrxYVNyF/Y6iC+KAhdttW
	 OooNVw/VRRiTbp42FKRdN1FPNmAYYqCSd/6u9miMbDR5+fa97n+uKN3Zsx/i4YPPhz
	 RvNggu4qu+7PPC0R/XR/u14v+WmBGqfVJsFRZ1sIzvFuJShN2KGPVojdFG+j9J100P
	 GAq8DlA7Ehl0Sa1j1Hh1yTpWF5orr8TOQXfbctqzZ0M9zhOX4KiW4RQyJDKAyn+Fja
	 A+BmJ3Rpcc3Ag==
Date: Mon, 16 Dec 2024 10:26:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shimrra Shai <shimrrashai@gmail.com>
Cc: linux-kernel@vger.kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, heiko@sntech.de, krzk+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	robh@kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: pinctrl: add header for PCA9555 GPIO
 extender bindings on some Rockchip-based devices
Message-ID: <upc5ctukw3vyxjda7fmpjsqttu4w6vj7hm7vpuezzwytotpi5w@eahfui4kc3nj>
References: <20241215032507.4739-1-shimrrashai@gmail.com>
 <20241215032507.4739-3-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241215032507.4739-3-shimrrashai@gmail.com>

On Sat, Dec 14, 2024 at 09:24:54PM -0600, Shimrra Shai wrote:
> It seemed a bit disputed whether this was actually necessary, but I am
> including it nonetheless. It makes it slightly clearer how the pins on the
> PCA9555 GPIO extender used on the board are actuated than would be evident
> from the numbers alone, since according to the spec sheets for it by NXP:
>=20
> https://www.nxp.com/docs/en/data-sheet/PCA9555.pdf
>=20
> there are two banks of controllable pins, IO0 and IO1, which are labeled
> equivalently to the labels provided below.
>=20
> Also sorry @Heiko St=C3=BCbner for adding your name on it; I had cut this=
 off a
> BSP source file that was longer. Since this file contains only this
> isolated section, which was written by someone else, I put their authorsh=
ip
> on it instead. Unfortunately I do not know who "daijh" is, only that they
> used that handle on GitLab to submit this code piece and I got the
> indicated email address.
>=20
> Signed-off-by: Shimrra Shai <shimrrashai@gmail.com>
> ---
>  .../dt-bindings/pinctrl/rockchip-pca9555.h    | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/rockchip-pca9555.h
>=20
> diff --git a/include/dt-bindings/pinctrl/rockchip-pca9555.h b/include/dt-=
bindings/pinctrl/rockchip-pca9555.h
> new file mode 100644
> index 000000000..21ca99488
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/rockchip-pca9555.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> +/*
> + * Bindings for the PCA9555 GPIO extender used on some Rockchip devices,=
 e.g.
> + * Firefly.
> + *
> + * Copyright (C) 2022 Zhongshan Tianqi Intelligent Technology Co., Ltd.
> + * Authors: daijh <djh@t-chip.com.cn>
> + *          Shimrra Shai <shimrrashai@gmail.com>
> + */
> +
> +#ifndef __ROCKCHIP_PCA9555_H__
> +#define __ROCKCHIP_PCA9555_H__
> +
> +#define PCA_IO0_0          0

1. There is no user of these bindings.
2. It's meaningless to map 0 to 0...

Drop entire patch.

Best regards,
Krzysztof


