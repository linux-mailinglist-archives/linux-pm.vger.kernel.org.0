Return-Path: <linux-pm+bounces-23372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB30DA4E1A6
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4649117D5F3
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 14:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5336E25DD0E;
	Tue,  4 Mar 2025 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ff+UHP0a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDEA25E836;
	Tue,  4 Mar 2025 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099155; cv=none; b=icOabWna6DWdzI/g8ae8dKMCn/9aTgZav+6caHwMoX2VOGKps6GrtXIaihm0sp6hbqp0N2hZIQpAVegdla3gjVizyxQU+gGzEhwtHd/o5pTSMt16/OBmcgzNEFKBADo+6u/sAPZ2FhOEDdMP9GDaIU4edaqX9RYHlUltz4nVqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099155; c=relaxed/simple;
	bh=uzDyhg36aKQtXD63rS8FtBbFftRpnHV4ry+5FYiWjAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXlSzlMI9VDLL/9G+PgoNO7x8gRnxHSEONkTbIRAnUGzPXRqDvsiVarhmd72eo9VB+Ludn4qx4YjkSx46ed4OMbxVsZO5zq32gj70qMliQZsnpMyMTAcvKF7sq1fGt4DUundCEYnr+CqlmfDgugG6RfcpfAzPiiO6vDv17SgJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ff+UHP0a; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so2949035f8f.2;
        Tue, 04 Mar 2025 06:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741099152; x=1741703952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Npvu48cu8TTRTz8ZFkqiXyWbVjLDOCxYiH4u8pc5l24=;
        b=ff+UHP0aNPhZZWY4t6VUamPhLbSRqf9WEY/N4oKj59QRoHG+vuAEEk4mrUIhX0KESB
         2O0QiN/t0D7AkMZkPkviEobz/42RoXpjcLCBm2eAYZ3U8gkOE9v83SzrCYoS+kYDYsdg
         ytUegaVotYPEGRR1nEfXzfgkXOAD78EuAOw7DaBKirHOb4ItXrjmQ/d5vh3ClahMoCo2
         o31AhFX2Xx2H1RzeLf4rLizjj5TsPHZzxZq6Ki26cxPHZUGs+i+P/WueLt/HjIY1ZrRE
         mqh/73GfwaEhveo1fr9Pf4W+0oSbacqgY336Y7We6aZQGkacTf2tzGrlfxiMh38In4mg
         b1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741099152; x=1741703952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Npvu48cu8TTRTz8ZFkqiXyWbVjLDOCxYiH4u8pc5l24=;
        b=nvfpxBZfWFgyfoZ5aG729mYTB7G+LmswjfixEb6CFXvztuS1xVjIlocgsQnk/GyDL/
         JYsKc8HCg3Tvx803lh0j/1F5LRACtXZdwKB53ZooOQAfvOpEzmn3wCM8PJZuxExfecdl
         9MALbFBkp1h5QCHU45U9uVzFAEEUWAAZEoEPiZ3+wX0oO2O1fqF68eZBOPyiSa3q9iEP
         vs8LU5RcKa33rgA2GvBZpfEQsUetNHdAiuOCGu8ESOcmgtC/EpRbwRY/4c8wxGXnGU/T
         gC45UBDjZ9Dq+hRQv5VH9oVAUa4DliHpUGxE5FHNmOhQwb6BqLdQuwlCyY6rsdNCSbRV
         ljfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm4aW28j/2IjIQksnVFZUcSSW7ToOezlxSb1a/odhyFBWgQvJF268g2MkFRemEgxoCb2xDgxQQaQsr@vger.kernel.org, AJvYcCVrK3oE0q2Pc0NIjmQmh1TP8poBlFORIJSEGzfRMJteuCKb0QDzSVrymxk6GYZcN4hY/O86a0VDuHFMgVLa@vger.kernel.org, AJvYcCWDqXydxcnV/NaUS3bHQW/nhYylZsud6iiaen60oeD0fuaLHN75H8Zt9mojscFyphHsCq2LORvi1Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgEEc4zDfFk8Q8H7e609ZQ/Ve3v78s1AygcgSa44XRpw6bjYDX
	vSzsqAKGQSeFbVLYG6wkJTo5sxK3cSoPPNGnRjmFDFvSNBybfvDPgcrhw0SUWtBppTa9Tm+3Zkw
	yet/r3wJVos25+yMWLzWPlbpfdpvo2w==
X-Gm-Gg: ASbGncvFlYw1sx2jRhe48DQ1jxX954Zz+jRUoGGx7hSSpx81INxdSVShWsPgd1xSPPb
	+zGy38xkUvKOiMcTjvf6+0yimeUVNwxqnx7wPIXcfE4s2l26FJzJT6pa9jt4it0uy3RG5O4GFNu
	5hXixocHp2UN2rpgwEZivPSuN01Go=
X-Google-Smtp-Source: AGHT+IG0UxYU+N5iqHGOMOY8APYCMkNgkojpgu6RARUbeEpAB7tfoOd9OOtUsw2ENkYoGjdUzmZx1Iq+/lOy+wqxbcs=
X-Received: by 2002:a05:6000:18a7:b0:391:136c:1346 with SMTP id
 ffacd0b85a97d-391136c141amr4097678f8f.19.1741099151431; Tue, 04 Mar 2025
 06:39:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303115502.89457-1-clamor95@gmail.com> <20250303115502.89457-2-clamor95@gmail.com>
 <20250304135806.GA2503334-robh@kernel.org>
In-Reply-To: <20250304135806.GA2503334-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 4 Mar 2025 16:38:58 +0200
X-Gm-Features: AQ5f1JpqrYtkOrzf2CVWZdo1DH3FPGrm0F4fbufI2O5K2mZdFEO6-VEvpN_YR5Y
Message-ID: <CAPVz0n3WZOUb41AzNPqMLx8wtPiBJ1jfww7h5xyJaZgu+=RdkA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
To: Rob Herring <robh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 4 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 15:58 Rob H=
erring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Mar 03, 2025 at 01:55:01PM +0200, Svyatoslav Ryhel wrote:
> > Add bindings for Maxim MAX8971 charger.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/power/supply/maxim,max8971.yaml  | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/maxi=
m,max8971.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max89=
71.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> > new file mode 100644
> > index 000000000000..2244cc3d45a6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/supply/maxim,max8971.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim MAX8971 IC charger
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description:
> > +  The MAX8971 is a compact, high-frequency, high-efficiency switch-mod=
e charger
> > +  for a one-cell lithium-ion (Li+) battery.
> > +
> > +allOf:
> > +  - $ref: power-supply.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: maxim,max8971
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  monitored-battery: true
> > +
> > +  port:
> > +    description:
> > +      An optional port node to link the extcon device to detect type o=
f plug.
> > +    $ref: /schemas/graph.yaml#/properties/port
>
> extcon as a binding is pretty much deprecated in favor of connector
> bindings.
>
> The OF graph is an overkill here too. You should just need a phandle to
> the connector node.
>

Actually, I am fine with using connector phandle if this will lead to
acceptance of schema.
I will add this in v4 once time comes. Thanks.

> Rob

