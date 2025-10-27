Return-Path: <linux-pm+bounces-36925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88406C0FD6C
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 19:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7A564FB0EA
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A23931B83D;
	Mon, 27 Oct 2025 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx5moz92"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774B431B829
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588107; cv=none; b=TTZZMZdc2rtDivmr6dLZRkZUtVvWCkyI4m9wvQkzGX7EapHF/rhKxmfiFMzx5piNPTHHGD0fUw8nnZuiwuIzNU6wJt8j0ygiAnD7Vyo/7HrqojTDUs03A1gqzkmyW0XyZo9sm1Jcq3dzL7CZ996z2P/3L8yBYTNurHQUsc0IfA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588107; c=relaxed/simple;
	bh=LmXKYxgq5l0W1tOnLSE425z4xENAzicgJcfmXTzUxfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6rOAMWS6wF+bI+pa+GHMXjV7ERJFuWz+HE7r89sVPNFXOioa9u9S0eUzXsOkj62nDUikKKSiJACHCvs1nm9Hsja+vzgHpC/Cx9+XVbcwbpHAYIebrnb5TvaxTjcgMhaOR4fNsHGqilEQkoFscoc9Y4jSXD48Rp+V718B8ZQ42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tx5moz92; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42966ce6dbdso3614885f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588103; x=1762192903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aYSYqxdTQx1adiba7waOFSEBjrwgCAPGP21S/4z0WQ=;
        b=Tx5moz92OOoFHoRRXwIYJebf6dF5m3mqO4VQjP59hFXZImi51pdi3e0QbL1AweBYiS
         VXXooAHpLDwaZSy2zCJ4Rc+gdqDEJcuARq22s/gzusWQRZD8rr3N3xZl3aXg35f84628
         VMfqlI9elpdll9HXGvsAXFKSK94dJjVYuplDslwbc3VAVkJurlIBZPSEeJ13vgRrZXY/
         5SA83jgDGcZLzdk0ObBPIUC2yDRKb+rSa4ieKq1KRqj16FFKK5D5o98NICeY2+kN6eDu
         F53XSetxkp0+s7yZvVgh1SfySBPv0PI+JIUbkG9EwFCLxshx4fwWRQMOvL0l1aUtBbiU
         1XEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588103; x=1762192903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aYSYqxdTQx1adiba7waOFSEBjrwgCAPGP21S/4z0WQ=;
        b=pTTXY8TVWUFDAbJ33bqy3nBMuTZPqOGgYw9cgp9WU9Mc8m40dedjake/4G/rsASRCY
         tVAZgjgMUHKQhobTJONGJ/JX8zhGYX9aWYUS/0iZW7KnB0bV6GZ3jg9LZWA4CNJFhr0A
         LGssY6QwMcla0ZiaquOc5hR4oFqGU+5wZ8Mu1iu9ouRFBzBFU1oEJys5AJzWG9N7yVRK
         US3Vzt/ZSHi4jKoD6hw1/6yYpfl/SzyR3DA1ao9JiAAF17dixbjL8v0n5iBV0kfbNZr9
         P+td2x+BLucydmQIQTvEu6rirYNlrhA49/vCrUeuyz2Hv+NsSdyG6LAXgi69GlHTV5yB
         HiIA==
X-Forwarded-Encrypted: i=1; AJvYcCUbOXxCZWgOeVHmkqf/BNF/O3VvWNxuq/DLyNRJiSbXvweFDDp9GPYdO7y4WMdumcGvj1Chnu222g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYq8rmE8FKA62XS0EKsB93nrZrn9esIInEQcey5U6xzq9Qu5GP
	505qQRnx+W29ezRdq9q4kf7Yq4uUL3ZuF5YliKwpUnt12l1pKvcWtaks
X-Gm-Gg: ASbGncu5UNmw4J4NYyYT0fVBzchUMeSq2aS7tVeZeDa8RzkNNl35u+J2eeLdpDQTSQV
	kcPZAP7MdJRfogKSlphcXlaKxLt8KSaTr8PUgIumnI0Y5WyH5tC0KsY13wwI8DFZ3GC1ltTUZfh
	9Ag6MqJvH421qpXhFy2Y3xLyvpJNqhyfdork/oPfnH+sUuYPcFdXkw0yS0fheRfu0RfHN7/rxKe
	nxzpKNWqQCLa3J3GxoIGee5r/SL+b51LX5VZOqowKcNUaaYHI90ezLBlNxDMHHsY/F4vQaWG8hY
	Aweene7FehwgjzEw1QIsVWF/dq3bKUenDYAjVgKv4naMgf6WSEHipw1MLKnVJ6CsC5K+UKqPtcG
	2bB5q2nGOg8Xd3PIpClENOzzzmFRLak08VAOEC3mlniCvjjNCvheS98ALOUmW/jzApyr/yIU9Hb
	HAZ9Xj1cPx+F0/orVfotGZZsE0YgSaHaHg+G3/zA0N/rhzkRSP1AE2SJwvaWyGm1Qb6aer
X-Google-Smtp-Source: AGHT+IEqakiIVgvkmH1mzvZg1woizmOdLx0SAbkLPTVvCw4c/LMFkRt84r69g+UhZ/bheKm0gmAdSA==
X-Received: by 2002:a05:6000:25f4:b0:429:a7f1:bdda with SMTP id ffacd0b85a97d-429a7f1bf31mr546028f8f.47.1761588102726;
        Mon, 27 Oct 2025 11:01:42 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b6fsm15648567f8f.1.2025.10.27.11.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:01:42 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: iuncuim <iuncuim@gmail.com>, Rob Herring <robh@kernel.org>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>,
 Yangtao Li <tiny.windzz@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Andre Przywara <andre.przywara@arm.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 1/6] dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
Date: Mon, 27 Oct 2025 19:01:40 +0100
Message-ID: <1935223.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20251026210905.GA2941518-robh@kernel.org>
References:
 <20251025043129.160454-1-iuncuim@gmail.com>
 <20251025043129.160454-2-iuncuim@gmail.com>
 <20251026210905.GA2941518-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Dne nedelja, 26. oktober 2025 ob 22:09:05 Srednjeevropski standardni =C4=8D=
as je Rob Herring napisal(a):
> On Sat, Oct 25, 2025 at 12:31:24PM +0800, iuncuim wrote:
> > From: Mikhail Kalashnikov <iuncuim@gmail.com>
> >=20
> > Add a binding for D1/T113s thermal sensor controller. Add dt-bindings
> > description of the thermal sensors in the A523 processor.
> > The controllers require activation of the additional frequency of the
> > associated gpadc controller, so a new clock property has been added.
> >=20
> > The calibration data is split into two cells that are in different areas
> > of nvmem. Both controllers require access to both memory cell, so a new
> > property nvmem-cells has been added. To maintain backward compatibility,
> > the name of the old cell remains the same and the new nvmem-cell-names =
is
> > called calibration-second-part
> >=20
> > Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> > ---
> >  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 56 ++++++++++++++++++-
> >  1 file changed, 53 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-=
a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a=
83t-ths.yaml
> > index 3e61689f6..b2f750ef2 100644
> > --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-th=
s.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-th=
s.yaml
> > @@ -24,18 +24,23 @@ properties:
> >        - allwinner,sun50i-h5-ths
> >        - allwinner,sun50i-h6-ths
> >        - allwinner,sun50i-h616-ths
> > +      - allwinner,sun55i-a523-ths0
> > +      - allwinner,sun55i-a523-ths1
> > =20
> >    clocks:
> >      minItems: 1
> >      items:
> >        - description: Bus Clock
> >        - description: Module Clock
> > +      - description: GPADC Clock
> > =20
> >    clock-names:
> >      minItems: 1
> > +    maxItems: 2
>=20
> How can the max be both 2 and...
>=20
> >      items:
> >        - const: bus
> >        - const: mod
> > +      - const: gpadc
>=20
> ...3 entries?
>=20

Because old variant uses "bus" and "mod" and new variant uses "bus" and
"gpadc" and none of them uses all 3 entries.

Although, I guess we can simplify and just use "mod" in both cases.

Best regards,
Jernej




