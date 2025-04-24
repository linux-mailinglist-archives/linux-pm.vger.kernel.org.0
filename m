Return-Path: <linux-pm+bounces-26144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214B2A9B584
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 19:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9E4927F9A
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 17:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95321290086;
	Thu, 24 Apr 2025 17:38:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08CE28E60A;
	Thu, 24 Apr 2025 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516282; cv=none; b=O1mNDEEiIlwcc022kCTHHbsq+2+lRjNOCOQyscUp91qv/n7+3Pb6gGKwPSHidAozu1ee2TdRdOBElVYAzEOStTqgqmYhoy/Co5YGExNm9uqYq/Ffe18SA7cmOYpr4IR4QS3lQZiyoiwlTTIb9DOlxsqS7K0w1X1ZJmylOW4wGw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516282; c=relaxed/simple;
	bh=l9GwqA6moC5o44LoO/P/z4Eal0AfURGG0Z3kI4uyrIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSWjojDZJPgfaQx0oivfajKivAUymO+nxwWGOBHsocaTuQN1PPTLXchG29bw2ct98/U8bzg8eAdKMkQlzGaOUBXdM586JmIsUBZgI1BUiSGrPrQEn54yeUgoch0YTaxnqUc5oREKYNcdwMxgrn1FhAG6qXZhX8tTmHT48iA8Ly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30beedb99c9so12587341fa.3;
        Thu, 24 Apr 2025 10:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745516275; x=1746121075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CiowPURGN4de6Iry0e1Jc5BJ/71dYd20vAslI7Guwu8=;
        b=EIDYuBd1VmUyvYVtK4NniGQcIm0bQCTQxM+wN0PaZZ7ng85RzIYPvjJhVlYHWxdQDN
         9zi1TGzZGx1o9NswGycHKzFbS45rYU7f6T57dOgzsyABoDhCgvmg83KEdAM8ieqXXARL
         mVBRKMulvyxxKtk+5SyM03MGbQ5MX/ULcnY92lbnudCbE3crzbelFvMHjcvQ76v9C/Ss
         tKjqSlRpw9QQdWnirFmiDM3bpn3VhVJjXQXvHmqTv3PrkhK2maDsxodhF9uSmhvNbTXL
         f+XJPjuvUIXuP0MNGamJgOa+L9u82IkYwS2ln1Tnu3swwUQa531oVsUeC4QAdzXso14k
         cO7w==
X-Forwarded-Encrypted: i=1; AJvYcCUgzoQZY4fjuAdOcnHrZuWk5U5kspa0jyPdmTwJOnF3zcKW9ZXEoVdFuyQu+4xsUtUU2eJWTxxl2VyL@vger.kernel.org, AJvYcCWvy0TkWtjQj0q8uCQiTNWlBahUdfdO2dH3W1KtM6caW+ol7mw3hJWY+c2024oT1mCMb6lZNktBYiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJvduhBNUOp30ivRKK7MY+5PeduZKkpp5xqAnCSDbQQ1NaSW2M
	/Lhs12Q/stgdhTFCCYdc3/FES+z+Z9mZ6RHyk251scGer9y3c2C32ofjV4r5
X-Gm-Gg: ASbGnctJQIacmf5EmvCUi1fhTIyw1huWC7tyxlJfYuR/J5A0/sKxEAPZCgCx6lA32cD
	yfLEWXR6KMgAk6RBHhV2OaGVR9fE5mKPVpHoDDq00ivnmWyR1f36IIgIfREvzLDL8ggqPBdkndu
	+SshwT6rwpIj8qEZxfbS3z2uGSdAIhbFj9BnHa1nQAa6TOkbAyLvc+YQ12eSxYn+b6PPXUa4Rbz
	91YHAw6EWm1nv4HUVbwNIIcyN3YdnA8C2dn820fgdYh9I7X1h64XhCB7IK+Tdu+agVjZadG9IyU
	ZqvjvsL5XQJJInKZdVUvaBM8kByGhwmykxOisj7Y3Pwp9Fb3FLtXaGtyr2t85z7ODSgD5O7TCA=
	=
X-Google-Smtp-Source: AGHT+IHkXE9oO6onuat3Bn9tTQSvD7S8M9h5v/CZgM4SipzDEkABZ9gc1bOyCR/svSwOE7uSVWzfmQ==
X-Received: by 2002:a2e:a58b:0:b0:30b:d0d5:1fee with SMTP id 38308e7fff4ca-3179bc5a05dmr15050861fa.0.1745516274564;
        Thu, 24 Apr 2025 10:37:54 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-317d16a831esm3535831fa.68.2025.04.24.10.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 10:37:54 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bef9b04adso14147091fa.1;
        Thu, 24 Apr 2025 10:37:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJHhiYvBboLcExmsbPNQRsW2mN1AEPcWoLGLRmiTpLjUGLPP1pV/BOFM4hlwFRsl/9Cigu4banUgM=@vger.kernel.org, AJvYcCWcMq2r5M0b41K15mNx7cX80GEfSmFZN3K37ATqZUqHUst1EJ4PUAoDuucZ4ltwDmRpwt3Qg1H2mw2a@vger.kernel.org
X-Received: by 2002:a2e:a9a0:0:b0:30d:b49d:7fb7 with SMTP id
 38308e7fff4ca-3179e5e518fmr13777371fa.16.1745516274006; Thu, 24 Apr 2025
 10:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416224839.9840-1-andre.przywara@arm.com> <20250416224839.9840-2-andre.przywara@arm.com>
 <CAPDyKFop9gAUq3kG4-hs358y=N48rLQSvJaRveXo_ebVTf8gEg@mail.gmail.com>
In-Reply-To: <CAPDyKFop9gAUq3kG4-hs358y=N48rLQSvJaRveXo_ebVTf8gEg@mail.gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 25 Apr 2025 01:37:42 +0800
X-Gmail-Original-Message-ID: <CAGb2v66w-tD=--zwDBOG8qJbwBR=s9mJ32c65W88P1eazDKLhQ@mail.gmail.com>
X-Gm-Features: ATxdqUHvL4W44GNl5WKefwtfRdBLLoloQmPwAjVhg3bD1KPveNWGmCRztikltk4
Message-ID: <CAGb2v66w-tD=--zwDBOG8qJbwBR=s9mJ32c65W88P1eazDKLhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: Add Allwinner H6/H616 PRCM PPU
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Philippe Simons <simons.philippe@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 12:58=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Thu, 17 Apr 2025 at 00:49, Andre Przywara <andre.przywara@arm.com> wro=
te:
> >
> > The Allwinner H6 and some later SoCs contain some bits in the PRCM (Pow=
er
> > Reset Clock Management) block that control some power domains.
> > Those power domains include the one for the GPU, the PLLs and some
> > analogue circuits.
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>
> Applied for next by amending the example according to ChenYu's comment, t=
hanks!
>
> Note this patch is also available on the immutable dt branch, for SoC
> maintainers to pull.

Thanks! I don't think there's a need if it's just the YAML files though.
As long as everything comes together in linux-next, folks are happy.


ChenYu

> Kind regards
> Uffe
>
>
>
> > ---
> >  .../power/allwinner,sun50i-h6-prcm-ppu.yaml   | 42 +++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/allwinner,s=
un50i-h6-prcm-ppu.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/power/allwinner,sun50i-h=
6-prcm-ppu.yaml b/Documentation/devicetree/bindings/power/allwinner,sun50i-=
h6-prcm-ppu.yaml
> > new file mode 100644
> > index 0000000000000..7eaff9baf7268
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/allwinner,sun50i-h6-prcm-=
ppu.yaml
> > @@ -0,0 +1,42 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/allwinner,sun50i-h6-prcm-ppu.=
yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner SoCs PRCM power domain controller
> > +
> > +maintainers:
> > +  - Andre Przywara <andre.przywara@arm.com>
> > +
> > +description:
> > +  The Allwinner Power Reset Clock Management (PRCM) unit contains bits=
 to
> > +  control a few power domains.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - allwinner,sun50i-h6-prcm-ppu
> > +      - allwinner,sun50i-h616-prcm-ppu
> > +      - allwinner,sun55i-a523-prcm-ppu
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#power-domain-cells':
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#power-domain-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    prcm_ppu: power-controller@7010210 {
> > +        compatible =3D "allwinner,sun50i-h616-prcm-ppu";
> > +        reg =3D <0x07010250 0x10>;
> > +        #power-domain-cells =3D <1>;
> > +    };
> > --
> > 2.46.3
> >
>

