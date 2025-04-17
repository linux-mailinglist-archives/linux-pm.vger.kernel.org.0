Return-Path: <linux-pm+bounces-25590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49A3A911F3
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 05:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1AAE1711C3
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 03:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A981B393D;
	Thu, 17 Apr 2025 03:14:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B6155C82;
	Thu, 17 Apr 2025 03:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859680; cv=none; b=uNnBGsjQxAWg/nkmae1bL5pWnxv0etWbOjH87pU1gHcwq6WY3qey8fpMOHGs8A3UvVq8DzmoqyEkqw798suzjI3QiKgi8LzFjVpbm/Ql7//MuSe321R8iqs/bK8qCxJi+YNMOIhkDI4xy+5CcUJ6odOdII19mOlq35kqjiNw0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859680; c=relaxed/simple;
	bh=RR+y52SUTPzi+E8u5B+AgHaBLqVXGgwSNZgKMma1sBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uw3j01ouZ4w9y8fIOzUBTYt63E5CLLCWcxZiv4LyJW/5PlrkvjzspIBrbFGeOnleSxYRXcGzvrEttz74koo2Kjvat7W5pewXWnI0qQOwQvWbsGwl1SMzHZBF8Kz/h5GAHZT57a5qOSGun/14wmZt9TNYnDNLloK8h8+2CkcD7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30db1bd3bddso2841151fa.3;
        Wed, 16 Apr 2025 20:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744859674; x=1745464474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lEAcyQxjxEddEf75aHlB/SZ9GV/mTO73qRXKgW1f4Hc=;
        b=Q+hsQbguMkjhnHrUgFG9XaH2T86NOgkDlPrR/e+XMEn42gCk1Q83oBiJ8HwEMHaiQj
         8/NlurMvYtzRD2R9RHeXwjPkada4heAnNWx2Ajj57wi5sPwrKvHZJ5RVqdVh5W2UIDob
         n2tM2SgQ6L/+lN0P0w01wKDdRQHpoQdCDHB7O1nATXh4RfNswPeaZyZrTcAjSKDIw1Zp
         B/CMY44s35DtoHnXlyRuydtUgcqqz7NcxnyOEX1XiqKRaNxqN6eVsQf1X8bbyGJoly0Z
         U+Q4wNlYtg5lBOZ/MtO2pq8+WJKh19fQOzsgqI4EvX62xl+0+4e6ktBs2nXYcCyNUD8K
         j90Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBbdoCU8Q2x9nBXh854fTOm0QBVHcImkpWVAD9v6eNxCRCBAN5CDIUdLEDiDCAio+qLQSf5kEl0jI=@vger.kernel.org, AJvYcCWIzUdCeaxkOiGoURLFB5TTgdbn6Rk4uGJe/2bm8HpC29/X/4w89TRnCt0ADAKHjxXEx8gwFA6toMHC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxio2Gf/9K+1azjGwoWv1GFDasx5naUFlZeJAlyddy9m0nYPdDy
	fr1iMehw5lqxVoBNPyHBL/cqYheuTmt2R2ZzF5VI3NFAntjkLtCSsBFnRoNq
X-Gm-Gg: ASbGncuaviA1zKL1HM/DfFAwH3mcN/u4QVDUo9W9FkKfuKqBVgE0k9HO9+z0+9DMagY
	jSRB0Obp6nVTQrWc1NqPmVI4gfewMA6LPIs4rFczQVRG1K5mN9M+a1svuoiinO9RFg/lGhg4ibQ
	eSw617QNNAx9Sz9vgodRCqsmA3TtDIfKfjdSkLdANMKDx0YP/MC9Ht+e14XcjUAn0ZV7MZ34WyE
	QsqAvMK9Sk4T6IIWKsdFF3sXZlCrlRTUjUpdQeXniMWfBuid9KCgBnGV+J5KpAM84Farsp9fP/T
	X6sL1JKU4NVAbTv0yM0Zqqevx2uo4QcE0jWTyxdD+aBN2V/l1yso7EPNwZwiTP6FMlEpMTV/hy/
	KXI5EVGyb
X-Google-Smtp-Source: AGHT+IHNORkSni0l5QvzQhmP0tEhJ+Kq86XU+re6tw+D2AUVkYq+fj3xODGRSJLfAO32v1+P4Lt1ww==
X-Received: by 2002:a05:6512:118c:b0:549:b0f3:43a2 with SMTP id 2adb3069b0e04-54d64ae7edfmr1243897e87.40.1744859674099;
        Wed, 16 Apr 2025 20:14:34 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d6799a931sm197703e87.76.2025.04.16.20.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 20:14:33 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30dd5a93b49so2958131fa.0;
        Wed, 16 Apr 2025 20:14:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7ezg+L8C1CXE1wsNjN/JYWHu/QsUvlciv+tmyVWFT6DAGYDjSJ6eZvTT9yJllLESG637A0iLTrUQ=@vger.kernel.org, AJvYcCXWarMuUyUxMXYot3i1voc4sFLce9VNDtK/Bsj61EaRwir1rA7GqDcQCBDnF7+qJCoYSvKslE9ub1Xa@vger.kernel.org
X-Received: by 2002:a05:651c:30c2:b0:30c:3099:13d0 with SMTP id
 38308e7fff4ca-3107f6ce071mr16267491fa.21.1744859673381; Wed, 16 Apr 2025
 20:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416224839.9840-1-andre.przywara@arm.com> <20250416224839.9840-2-andre.przywara@arm.com>
In-Reply-To: <20250416224839.9840-2-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 17 Apr 2025 11:14:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v67-wqA4A1=NKee0JNEW2+SABdixN0H-HBg8aJjGZjKdJw@mail.gmail.com>
X-Gm-Features: ATxdqUHs7z3ZrbeWhMV3p3pM4JurppAfWHNtXUVUqdTkjloev5549-NL7E-N6XA
Message-ID: <CAGb2v67-wqA4A1=NKee0JNEW2+SABdixN0H-HBg8aJjGZjKdJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: Add Allwinner H6/H616 PRCM PPU
To: Andre Przywara <andre.przywara@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Philippe Simons <simons.philippe@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 6:49=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> The Allwinner H6 and some later SoCs contain some bits in the PRCM (Power
> Reset Clock Management) block that control some power domains.
> Those power domains include the one for the GPU, the PLLs and some
> analogue circuits.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../power/allwinner,sun50i-h6-prcm-ppu.yaml   | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/allwinner,sun=
50i-h6-prcm-ppu.yaml
>
> diff --git a/Documentation/devicetree/bindings/power/allwinner,sun50i-h6-=
prcm-ppu.yaml b/Documentation/devicetree/bindings/power/allwinner,sun50i-h6=
-prcm-ppu.yaml
> new file mode 100644
> index 0000000000000..7eaff9baf7268
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/allwinner,sun50i-h6-prcm-pp=
u.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/allwinner,sun50i-h6-prcm-ppu.ya=
ml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner SoCs PRCM power domain controller
> +
> +maintainers:
> +  - Andre Przywara <andre.przywara@arm.com>
> +
> +description:
> +  The Allwinner Power Reset Clock Management (PRCM) unit contains bits t=
o
> +  control a few power domains.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - allwinner,sun50i-h6-prcm-ppu
> +      - allwinner,sun50i-h616-prcm-ppu
> +      - allwinner,sun55i-a523-prcm-ppu
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#power-domain-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    prcm_ppu: power-controller@7010210 {

This doesn't match the address below.

ChenYu

> +        compatible =3D "allwinner,sun50i-h616-prcm-ppu";
> +        reg =3D <0x07010250 0x10>;
> +        #power-domain-cells =3D <1>;
> +    };
> --
> 2.46.3
>

