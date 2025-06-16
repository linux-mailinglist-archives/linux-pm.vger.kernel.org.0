Return-Path: <linux-pm+bounces-28816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DE2ADAD99
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 12:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2894616F6A0
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C582951D9;
	Mon, 16 Jun 2025 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSKCP//v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F25A2882D1;
	Mon, 16 Jun 2025 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750070552; cv=none; b=ltMUobAUSbKp+oea08+qGUxGeW/BBOTnFgmvBewxPiZc7zLhPLzqQuqox4Gih29opJxBpYcKnyMBhnPEwJPAPtGpW7Ir0ycM+6x7LdlecI3Q6CieBB7926JcZqU8Pr0Vovg8Z7iAkGR2yUktPe6PFJpVOJBFoMJ9S+5tF9uE/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750070552; c=relaxed/simple;
	bh=Fhsd6q/hRQwGHerpb6eGxJc9LhHttkXql2QisPijFJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRYZlj0H+O7RKkkwlPqhzbBt1KKgFF/2vStgWKnis8m30bQGpnWi7FLZJ7GxnPuvMlcZ2TrF/tOmWoc+J+aZgSL82jYsgcW9SGmp3zxUR65LXw2xdIiElcASL2MJMLj51d5aX/COW4AMhr7AVP2nLeaYIBWZn2/WNQOQGQwiBy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSKCP//v; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313154270bbso4761166a91.2;
        Mon, 16 Jun 2025 03:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750070551; x=1750675351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTabLOpgCLwYv8rCyGl7CwHdWBc3RbnKBwJmaj/inH4=;
        b=aSKCP//vWWy0YD8hp+qyF6BLWe/Q/GrrXqTGhG+m/P5rd4rbuxQcT5UxkPPydnlhoI
         /Dt6bJVGOq1wsZ2YjKke80N92Jl5Ng3rLB4R3IrC8X6YVT6NGOJeYcMWSnPaUKolFeKj
         dhg+ey2f5s/6317NO668N2HSgujmHfICAqmSXfTa0+oyCn8TrNK3Solwmcnazjp0rrsa
         1lGh5kM/GncY8AHhueB/joyLaaK5BRvpkqxG27uCCJaYxs7L2Y/MvP6RlxL+4tDpC8fi
         ThR/crcV2QAWtk0msCpmuxEsTaRa5/xoAxLEBMJ0HA1ONJMkIfz6owMzyyd72/AvljCp
         LIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750070551; x=1750675351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTabLOpgCLwYv8rCyGl7CwHdWBc3RbnKBwJmaj/inH4=;
        b=PmNoVLXXWsmaP3U6PS6bDCLxLJon/sI2aNtq9FCmCvSwLXN8KwgY9rpMESS3pmCVsY
         gbXPg1pCibdiFfdrDKNzrD+T/R9N9RjMo3hr/XkP5Kr3QDvmbYdkfLZ9HgSnHXNj04GV
         JB/OGRNPt5sWULIxDDAO66ho/UytixcH3Y4ehSXWgUjMCM2/reuBUe8rhOS5yXgH0FIJ
         jBOhAKjhNkg977hoendaTyc0F57phXswBg0PUUhUV7u/yaY024hLGy8KQMkvMlED1w3u
         ZnDb+2YxDIHgHVH+uTyEK82EebT9u1/AzJDLIg1ZMOZ5dPm6Y1lCvi0x1ANy3gmlofR6
         to4A==
X-Forwarded-Encrypted: i=1; AJvYcCUCHiROmXg4Wbj+lEayKrSNj3Rr+XvTwaed1Nff9exmEklWJgVf/qHtw/b4ifP/Qp4GCBcw0Rt6MIPvmiGW@vger.kernel.org, AJvYcCVrW9vCDF4gF0KwheaWqe1SvdPFvyUVveVEFZofQubNVqzPYbfNJ95+1b9gk4OY3YVbn8ewMmzszrs=@vger.kernel.org, AJvYcCW/+LVksse1U09VZvjRzKSfZVCwNdYYfg+ZNGq2xXRovymcUz3xJVlc8vgSNkcwZgb24U+6XmuL44Nh@vger.kernel.org, AJvYcCXoseujehnXre7adIKylkcqdgvYDKlJXrt9L731y+JkcyZhv/iDJlpRUxnGCpsxy52WfDZXewIR@vger.kernel.org
X-Gm-Message-State: AOJu0YzzknPGGYKnsoD38FY6RKwXNIEJzv94LiJaTBFQLn88IGDMTTHs
	Ny4jZYS0DcGQNEkifRlSljW128D4Y49v0MiEQ8IH4lMOl1bm5CQGbOA+W1fucWmZLZ+Cil8rhlC
	bZM1XrDQIMoiWRamFZ/GfwSyEDphjZY0=
X-Gm-Gg: ASbGncu61VsoK3flVucSS8ycECdvfuELtR4z95tlVlzjMbXUox3YbnXNNzwezzcLMbl
	aYKvvODmVjybdjYnfEZQ4dSFgU/HZOdPegAKanJnQ2oWJD0Fs6LF78LKvN99tl9VsmRSUDj/g/b
	Gh+OLIE3mJ8/xSsDf/vxORiJABoLMtTJJTz6NNEf0n
X-Google-Smtp-Source: AGHT+IGdvq4Jz7wCl7O5nLF8AdUqsnNZK/jUgiSEfeGbfX1YCA4ekJ6+LuyEXZu02NW4N5RvWGmagNrrauMC8JexM5M=
X-Received: by 2002:a17:90b:274d:b0:311:9e59:7aba with SMTP id
 98e67ed59e1d1-313f1be899bmr14937709a91.2.1750070550782; Mon, 16 Jun 2025
 03:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613100255.2131800-1-joy.zou@nxp.com> <20250613100255.2131800-5-joy.zou@nxp.com>
In-Reply-To: <20250613100255.2131800-5-joy.zou@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 16 Jun 2025 13:44:31 +0300
X-Gm-Features: AX0GCFu6L7Akim9BySCPjWCa7aS9JinLbW1qVZSuSXFVwqMzcBMNsyM6unHsnmE
Message-ID: <CAEnQRZAp8TX84AygSjWGx-cNiLyZXZwUx5C-DLDuyB6hO3gXMw@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] arm64: dts: imx93: move i.MX93 specific part from
 imx91_93_common.dtsi to imx93.dtsi
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, catalin.marinas@arm.com, 
	will@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	ulf.hansson@linaro.org, richardcochran@gmail.com, kernel@pengutronix.de, 
	festevam@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-pm@vger.kernel.org, frank.li@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, 
	peng.fan@nxp.com, aisheng.dong@nxp.com, xiaoning.wang@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 1:08=E2=80=AFPM Joy Zou <joy.zou@nxp.com> wrote:
>
> Move i.MX93 specific part from imx91_93_common.dtsi to imx93.dtsi.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
>  .../boot/dts/freescale/imx91_93_common.dtsi   | 140 +---------------
>  arch/arm64/boot/dts/freescale/imx93.dtsi      | 155 ++++++++++++++++++
>  2 files changed, 157 insertions(+), 138 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi b/arch/ar=
m64/boot/dts/freescale/imx91_93_common.dtsi
> index 64cd0776b43d..da4c1c0699b3 100644
> --- a/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
> - * Copyright 2022 NXP
> + * Copyright 2025 NXP

This should  be Copyright 2022,2025 NXP,  as per NXP internal guidelines.

Am I missing something?

thanks,
Daniel.

