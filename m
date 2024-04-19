Return-Path: <linux-pm+bounces-6697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE4C8AA7AE
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 06:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87052287215
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 04:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DDA2F29;
	Fri, 19 Apr 2024 04:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcj/RZ87"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0BC5256;
	Fri, 19 Apr 2024 04:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713501448; cv=none; b=Kxv7a+tYPYxGBb6Ixn6C8+lvu1mGWwHuWVk19fhst77GLrA0xhwZjskIE7Nd7jgixcyyctuMa8qWDP/f3OWmSt2AV1qe893hjdPRc+lh/D2vC63hejJMQwh21EW8451eZ/Lbwcyw8+qUr8IggvRwu1mA6rWdgmG5afxvLet1KkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713501448; c=relaxed/simple;
	bh=aA0eWf4lTjyJXrzsPGUfl9MnnAc/P4pB9uRI/dobEws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TimKwRoYE9qYz9Ps4TQsJ5Lv5lhJRL5pUVkmkY4L75TaSeM0Q/mR+0NOmpeTu9c1VAPygsI2RQYnot68eltSAezKBHmnSq54dTZw0wXQJBb5uHf5bIQGg2cYgGNzpvuLi8A8b2FBwwx6c5MZ8vsrMjX/B+GTLuRRhk+2+TrBrtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcj/RZ87; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbed0710c74so1632242276.1;
        Thu, 18 Apr 2024 21:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713501446; x=1714106246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFpAdFUlK6c+FuOE2UkmdUUly6ellBWMJzLFthxSKp4=;
        b=fcj/RZ8770N/1WpzjpIYwzVZ3xS3i+AJPoaJ4n7R9Gb2ua1QlI1QG8vRHkncjVC7eW
         UcfudVd+FPLxRnTZ8NTFCWTG1P8Xv+GSL8jwAMjlwNdIWCJj9SFRCZB4DqdhKCyal6xq
         BvlYVS8WbzKnC64anlA2H20bgFWOAI9e0BExbCvkZ1z7YxdpleIsMRFfayCtNHbWGxVy
         G2D01SoF4pCOrUgKMdGWyIgFhSE9w+0FRBHuUxLZsxyGYW3/qvUNHCkUNIausBXFxGrK
         2owr4SjBJIiLbrzIlzPUaFqzQob5W1A4jLCFDMxjjnjarfcvkao58c1HldgU7jF4jHIU
         QuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713501446; x=1714106246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFpAdFUlK6c+FuOE2UkmdUUly6ellBWMJzLFthxSKp4=;
        b=GOvj40z2vCTHQsicSmnUpoRjkap23FEYD8W2CKO7qx7AK0RwlrRwav/8Z4hJql0t58
         6R1mJEcWlhAImsPLWICtAJdFidT0c455Y9lIpkDOaZWRhXL34j8VPVIENPZab64HMtZX
         /W2pXqIee+WCGpUJI8NJJblyeijrSN5QGiYzbK7vpv8Kr0BhRpf/oNdIrwEhirBDKH0a
         KvJAXOAefP5uGIrPpTv7n1jvpRlvQpXAGvKZfV0RoMRpeuDxjRkIeeT/5J1eCQVA6QyI
         Qf9HudQh2+835/BV1KOaFRRvaT/kre36wYpXlE0pmvtIwexOiJRuouw5KmdeCszLxxYm
         +lBg==
X-Forwarded-Encrypted: i=1; AJvYcCXhL5e+EydUKIaXHa7HaostJCQEf5qgR+i8i3yJrFCm3e7GMpANQuZhO+Pbgfd9X0d6fgtjpYa+JVwDd96f6MlCkumKi4XQDC1SiNLkdphlHyrXifUQ0xBe4Z2MTL8h2g1P8lj0
X-Gm-Message-State: AOJu0YzoQueUXRyAfVD4cvRoE8cxgEYNzq9kU+0Exi2ionf07kdnW4Ft
	ybV+O+7xQ9l8okBcXm7fsu5lAFvJAUcjoy7utVM7eGJon+mqXtln+xi60Qim3uVPLHe2dZvtM0q
	cPsrZPREqwyNIAPuUa9esgWJSLBNCBSdpWrhgPw==
X-Google-Smtp-Source: AGHT+IGTBPvZEpv98oIQFH2424OjkFzeVum4zf0vfYLvtPIGm4i4ccBnGSIz8ZL6mTZ/+r66PKpvcXJU8KZMx2xCLfg=
X-Received: by 2002:a25:8046:0:b0:dc7:4c21:fbd5 with SMTP id
 a6-20020a258046000000b00dc74c21fbd5mr716876ybn.0.1713501446407; Thu, 18 Apr
 2024 21:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713147645.git.zhoubinbin@loongson.cn> <9d2132d4713321a83cdeef3cdc8887b7d39340e6.1713147645.git.zhoubinbin@loongson.cn>
 <7396c6d4-878f-4b07-9b7f-bc793bebe4bd@linaro.org>
In-Reply-To: <7396c6d4-878f-4b07-9b7f-bc793bebe4bd@linaro.org>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Fri, 19 Apr 2024 10:37:14 +0600
Message-ID: <CAMpQs4JDWd3=ne3KisBXi3pYZWtRuu=3VsMv1+Gj0zHxL0TBRA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: thermal: loongson,ls2k-thermal: Fix
 incorrect compatible definition
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongson-kernel@lists.loongnix.cn, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 2:04=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/04/2024 04:31, Binbin Zhou wrote:
> > The temperature output register of the Loongson-2K2000 is defined in th=
e
> > chip configuration domain, which is different from the Loongson-2K1000,
> > so it can't be fallbacked.
> >
> > We need to use two groups of registers to describe it: the first group
> > is the high and low temperature threshold setting register; the second
> > group is the temperature output register.
> >
> > It is true that this fix will cause ABI corruption, but it is necessary
> > otherwise the Loongson-2K2000 temperature sensor will not work properly=
.
> >
> > Fixes: 72684d99a854 ("thermal: dt-bindings: add loongson-2 thermal")
> > Cc: Yinbo Zhu <zhuyinbo@loongson.cn>
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  .../thermal/loongson,ls2k-thermal.yaml        | 23 +++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-th=
ermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-therma=
l.yaml
> > index 9748a479dcd4..fac6f64d6c67 100644
> > --- a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.y=
aml
> > +++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.y=
aml
> > @@ -18,14 +18,15 @@ properties:
> >      oneOf:
> >        - enum:
> >            - loongson,ls2k1000-thermal
> > +          - loongson,ls2k2000-thermal
> >        - items:
> >            - enum:
> >                - loongson,ls2k0500-thermal
> > -              - loongson,ls2k2000-thermal
> >            - const: loongson,ls2k1000-thermal
> >
> >    reg:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> >
> >    interrupts:
> >      maxItems: 1
> > @@ -41,6 +42,24 @@ required:
> >
> >  unevaluatedProperties: false
> >
> > +if:
>
> This goes before unevaluatedProperties, just like in example schema.
>
Hi Krzysztof:

Thanks for your reply.
I will adjust the position of this part in the next version.

Thanks.
Binbin
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Best regards,
> Krzysztof
>

