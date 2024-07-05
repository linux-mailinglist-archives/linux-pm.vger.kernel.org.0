Return-Path: <linux-pm+bounces-10699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F01329289DA
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 15:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A16A28A656
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 13:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEC914C5BD;
	Fri,  5 Jul 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DBwN7dch"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5571A14659D
	for <linux-pm@vger.kernel.org>; Fri,  5 Jul 2024 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186474; cv=none; b=jEhE+YzRgqkvsJoWUk6GmWsJoJyzCyLljZzFdVd+7NDcVaUfTdUzMCjkm0/xP0zXFX6rN4st76LqdKbSjHPanoKV00IS6DvdJ1OKO1H+VxRNt2RDWxqy8DQ8bZrN53v7HOvzD705JXK3ucdRr5B+sdLm3/rASg9Gxd/W8Chsxyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186474; c=relaxed/simple;
	bh=/WWUk8xgbMeoX+XMjmJKMzm4jVM0QnM4PPaAAtS6ETg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdGjnT4WuG0BUgDT6RWmwkRWd37IOJLwRV4KRmUPlOcpLY6USdZ072xrxIsOMkF4Xd7KaUdqPrzyWm+6EFU86/J9XBYDmHErP7kO4obDpDyphy4lS6XBaW+57rwR5X7igl/vOUablJ5+lTRvuSxVUFrWXlNfGViWFiu47E10o+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DBwN7dch; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e9a550e9fso2436144e87.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2024 06:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720186469; x=1720791269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7lziJDkz8ksR4dmlddeHMdYw7zMgC8DIyGzxNLyJTo=;
        b=DBwN7dchrM3Uhg+n02ERwvcj+HPkIr+eeN3Y0hVvZU+poqph18SqrUpsRb5dSvPXLP
         Bl8bNTdNMs/SuoDAoRBr34bDHcresooRAlZ+WI4Z6SF3N6br9Jwyie3873hslJPTC8it
         XI8TC8TvKqf0slKrVdh1Glb9oUi7fSWUcEaM52pS7/jP7I7Bs11b5DxPaxGn2xXcaH/p
         D5LTJcH+d1K8VHnMEzisIELFthjn/kqnKQs1eEABc/BEZ8iafqaKpFnsUULTDsuErzoj
         W9uYmuXDn4S8V82szriUbBspjQ3g5iX133Lc9WTmfo9usHFeIdvyjfV7sL3110MaU3y5
         JHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720186469; x=1720791269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7lziJDkz8ksR4dmlddeHMdYw7zMgC8DIyGzxNLyJTo=;
        b=f67zC4MYTjPbfK3AXi1m7Fvtppsyb4zLUn3ZLQr/Hffvhe38TT3R5645kL4Wmi2LE1
         HbM3jlEFDf5rc34tX8y62oRee0BX6/gzy+yrUBRzZdqeOXe3Cj1atLrv9M6OG0ia2hNn
         79zMsHj64ynBuNKB1j2qez/JjEGZn6KkY4ptk9FDOy2WTX/VE7/KAHKYilKWSu9EjQyu
         zH/ohcPd0nMRgqLfkTN+4yI4Pi3vbghb760x4mjRv+tYTKb2eVIMy78+weubq4Gj0i7I
         X93d03oz9rsHdfyH6jnB+NgSSshTRb7PCZcbKY0P8zfHWcUzEXd84KozKfJHaqsW7WM4
         QA6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHouT+eaUNPGWjsR/PyaJwB8jc2wX2UEXQBfEzJkdL6OKe/4GCQi1xM9HYItGrjCm8iJnyt8db8pXl1wV0ttjWvuIPl0+94zc=
X-Gm-Message-State: AOJu0Yzlf2ZK8ZrQzmCWo+PeXWKtjw4kF3YJm5F5/Vek0WhDhoOPsLRv
	5UoaxmvbRuaqcrM/O6pE3YxBzMFKy7WZ5GsuzThT0RjIm5y6vwnrKSezmdSGasg4zNauJjeJu3S
	Ck/AmjHDiXlmEaraH05Yb2SgsWWD3hY6vNzuLtw==
X-Google-Smtp-Source: AGHT+IH002bET0sLDg515bzQ4elXCWBoy5idHfanq8GGKi/meSChCtgNax2EBm7zNVr+Mq15wxISI8Af7tGceGvs1Lk=
X-Received: by 2002:a05:6512:3694:b0:52c:ebf6:9a87 with SMTP id
 2adb3069b0e04-52ea0e00c5emr1457812e87.26.1720186469286; Fri, 05 Jul 2024
 06:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com> <20240705-pwrseq-v1-1-31829b47fc72@amlogic.com>
In-Reply-To: <20240705-pwrseq-v1-1-31829b47fc72@amlogic.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 5 Jul 2024 15:34:18 +0200
Message-ID: <CAMRc=Me+Fd_Kjgm0u0JhUatVEp=XS71xys82snAimpw2U5MQTw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: power: Add power sequence for Amloigc
 WCN chips
To: yang.li@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 1:13=E2=80=AFPM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> Add binding document to introduce power sequence of
> Amlogic WCN chips.
>

Hi! Thanks for the interest in this new subsystem.

> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  .../bindings/power/amlogic,w155s2-pwrseq.yaml      | 62 ++++++++++++++++=
++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/amlogic,w155s2-pwrse=
q.yaml b/Documentation/devicetree/bindings/power/amlogic,w155s2-pwrseq.yaml
> new file mode 100644
> index 000000000000..f99a775fcf9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/amlogic,w155s2-pwrseq.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/amlogic,w155s2-pwrseq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic power sequence for WCN chips
> +
> +maintainers:
> +  - Yang Li <yang.li@amlogic.com>
> +
> +description:
> +  The Amlogic WCN chip contains discrete modules for WLAN and Bluetooth.=
 Power on
> +  Bluetooth and Wi-Fi respectively, including chip_en pull-up and bt_en =
pull-up,
> +  and generation of the 32.768KHz clock.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: amlogic,w155s2-pwrseq
> +      - items:
> +          - enum:
> +              - amlogic,w265s1-pwrseq
> +              - amlogic,w265p1-pwrseq
> +              - amlogic,w265s2-pwrseq
> +          - const: amlogic,w155s2-pwrseq

The name is wrong. There's no such device as 'pwrseq'. There's most
likely some kind of a Power Management Unit and the compatible string
must reflect this.

> +
> +  clocks:
> +    maxItems: 1
> +    description: clock provided to the controller (32.768KHz)
> +
> +  clock-names:
> +    items:
> +      - const: ext_clock
> +
> +  amlogic,chip-enable-gpios:
> +    maxItems: 1
> +    description: gpio specifier used to enable chipset

Why not simply: chip-enable-gpios or even enable-gpios?

> +
> +  amlogic,bt-enable-gpios:
> +    maxItems: 1
> +    description: gpio specifier used to enable BT
> +

Same here: should be simply bt-enable-gpios.

Bart

> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - amlogic,chip-enable-gpios
> +  - amlogic,bt-enable-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    wcn_pwrseq {
> +        compatible =3D "amlogic,w155s2-pwrseq";
> +        clocks =3D <&extclk>;
> +        clock-names =3D "ext_clock";
> +        amlogic,chip-enable-gpios =3D <&gpio 7 GPIO_ACTIVE_HIGH>;
> +        amlogic,bt-enable-gpios =3D <&gpio 17 GPIO_ACTIVE_HIGH>;
> +    };
>
> --
> 2.42.0
>
>

