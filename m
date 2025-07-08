Return-Path: <linux-pm+bounces-30351-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3A9AFC650
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 10:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4436F3BF79E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 08:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EEF2BF015;
	Tue,  8 Jul 2025 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bs06Ann6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B00E1A5BB7;
	Tue,  8 Jul 2025 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964926; cv=none; b=tXzscDR2JX8JwSAp10HtCRgsk9pwd33G05sTFrPhLs1JWj0cDouHWEImvcTrUkdVU+gsZ97CCT+irh75xeLFMscBadk6AjlvkIhN750OCMpvcWqnGnKtaDcJs4aa8Me/iT+qiRXuHzW/TM9/2Pmkv7c2I1d5GItM2BGujGgk7Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964926; c=relaxed/simple;
	bh=kpstOjw4lLF9eP2jFzFpACQzhk54uwH0eGlIjnY6txU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSqeC8pp65sK2lZrMUfyEKWK6db3p2KIGTeIusVXN/97NDwhDXqhmyYPJuzlIIKT4vApHu/sJ989l4VVZPibljC7gM6KqjByVk9YeQs/jrThzDgjvQE+ufuNe0NrLd0Y9EXopO/pqGafxP7vz9USNek3L1FD7Kre09BcYo+PgvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bs06Ann6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A20C4CEF8;
	Tue,  8 Jul 2025 08:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751964926;
	bh=kpstOjw4lLF9eP2jFzFpACQzhk54uwH0eGlIjnY6txU=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Bs06Ann6YziWgddfpvw/M9gC3KlX127POufp+uJpfiasKEYtMoUHWfuj0RYCH1ger
	 XYNiGAd6ndxVo0yNppVjsM3dwAJsJ4F1wYEzYCG75X11ynyFpM/P9KES8funbIjNwY
	 nKUPw5xR3Q+Vo90JEk6M9KmVIGyZkm46/+iQOaWnMXbZ9qLv7SQMoXQo2ZBWlZUB60
	 B2KBA82o/0JqdSSjzasdUI41EMFDMzzp+41sl3i5IXUocdQS9S1uPORoZYD7hyfrd2
	 st/BVBgi+/HfF9hkEc814aDmhbAFCqfn3K9v+XhoLDuWeXS2jZHcpIWmwDZWlnDvs2
	 nnaPCYzZWU4nQ==
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-879502274cfso6807639f.0;
        Tue, 08 Jul 2025 01:55:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxMh3zQlCg3AcOf3hNM1ZaDBNiPeXG/5wETTdhqjJcJHUKRkdmN4CA4hH/Gc6bJvgVfbVkw/SUnIAz@vger.kernel.org, AJvYcCVfrwCJcxM81syVWYSJcbuk+SKTz6bAczW0+ataKgh5MxcQdE/uF3yTnVqNPbTQb/MaOMks/4z6Oa1NzFBR@vger.kernel.org, AJvYcCVuNqkTw8UL65tsEEFhYKifcn5BTHfzi1O5fAjc8n24YylvtYE0Tczehlr7G6bjzG68sYpLzVS1JMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzakw+4V0HmtBtpN2FCzmGIvhYOwlc7RnhVQM4gJdrNeUl/NKX4
	5aMO3BpJcS3DQEDPbwU4zu6XI7EfFwqICo4S7j81wr1keEa2RwvdnxBHSg5G0+Hx7/ytUeRXuSP
	pJqBixF5Hu1qhOffVmJ7Kfz+K14Q8OYo=
X-Google-Smtp-Source: AGHT+IF8+rXljY0T3bGeUJ9XXKLa71g9blAF0Fp8stGo0h3DgAP8zTEF2uLbmLy1XQvXT3W/Bs/Wr47ANAVaNz9utYc=
X-Received: by 2002:a05:6602:148c:b0:864:a2e4:5fff with SMTP id
 ca18e2360f4ac-876e158bb24mr1892894139f.4.1751964925465; Tue, 08 Jul 2025
 01:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627152918.2606728-1-wens@kernel.org> <20250627152918.2606728-2-wens@kernel.org>
 <20250708-capable-caiman-of-feminism-9dfef2@krzk-bin>
In-Reply-To: <20250708-capable-caiman-of-feminism-9dfef2@krzk-bin>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 8 Jul 2025 16:55:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v66SvNmWGYSfVdDfBdRjSz0mQ=f0HHFnQ9eSXSe7fVMEVg@mail.gmail.com>
X-Gm-Features: Ac12FXzLrfMehixQaVjm6pOEjtJAPHoo0j9_l4de3O9Fupbjy73Y0-TvdN1ohlY
Message-ID: <CAGb2v66SvNmWGYSfVdDfBdRjSz0mQ=f0HHFnQ9eSXSe7fVMEVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: power: Add A523 PPU and PCK600 power controllers
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 4:47=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Fri, Jun 27, 2025 at 11:29:15PM +0800, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The A523 PPU is likely the same kind of hardware seen on previous SoCs.
> >
> > The A523 PCK600, as the name suggests, is likely a customized version
> > of ARM's PCK-600 power controller. Comparing the BSP driver against
> > ARM's PPU datasheet shows that the basic registers line up, but
> > Allwinner's hardware has some additional delay controls in the reserved
> > register range. As such it is likely not fully compatible with the
> > standard ARM version.
> >
> > Document A523 PPU and PCK600 compatibles.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  .../bindings/power/allwinner,sun20i-d1-ppu.yaml   |  2 ++
> >  .../power/allwinner,sun55i-a523-pck600.h          | 15 +++++++++++++++
> >  .../dt-bindings/power/allwinner,sun55i-a523-ppu.h | 12 ++++++++++++
> >  3 files changed, 29 insertions(+)
> >  create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-pck=
600.h
> >  create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-ppu=
.h
> >
> > diff --git a/Documentation/devicetree/bindings/power/allwinner,sun20i-d=
1-ppu.yaml b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-pp=
u.yaml
> > index f578be6a3bc8..b9f550994512 100644
> > --- a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.y=
aml
> > +++ b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.y=
aml
> > @@ -18,6 +18,8 @@ properties:
> >      enum:
> >        - allwinner,sun20i-d1-ppu
> >        - allwinner,sun8i-v853-ppu
> > +      - allwinner,sun55i-a523-ppu
> > +      - allwinner,sun55i-a523-pck-600
>
> Don't add items at the end, but placed in alphabetical order. Could be
> natural sort if you insist, but binding does not use it.

In our other bindings [1][2] we have them sorted by family (sunXYi)
then by SoC name. I can move sun20i-d1-ppu after sun8i-v853-ppu to get
that ordering. Obviously "-pck-600" would come before "-ppu".

Would that work for you?

[1] Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-contr=
ol.yaml
[2] Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml

(There are some out of order entries regardless.)

> >    reg:
> >      maxItems: 1
> > diff --git a/include/dt-bindings/power/allwinner,sun55i-a523-pck600.h b=
/include/dt-bindings/power/allwinner,sun55i-a523-pck600.h
> > new file mode 100644
> > index 000000000000..6b3d8ea7bb69
> > --- /dev/null
> > +++ b/include/dt-bindings/power/allwinner,sun55i-a523-pck600.h
>
> Filename matching compatible (which ever one is correct).

Ack. Will change to "allwinner,sun55i-a523-pck-600.h".

Thanks
ChenYu

