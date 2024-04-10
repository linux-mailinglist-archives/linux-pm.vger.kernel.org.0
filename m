Return-Path: <linux-pm+bounces-6179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B31589F171
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 13:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A7128638F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 11:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470D215B120;
	Wed, 10 Apr 2024 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATm898CJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C9815B10D;
	Wed, 10 Apr 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749866; cv=none; b=XGrzKpqWDfSy9qKttZiGDwo+Kh93ojaf4r9BZgZnmgbmtIQYd8ZjW/95FyzTrvNyqPWT1+55XxN7OS2EM4pODWyaMWfLWjK6cHtSLaRBQFPxrm88JAnTtkYHHWhmrY2nk2JdHKxgbixPY4pX8xtHAHou0eUTmH3Jz2vqp9OJO8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749866; c=relaxed/simple;
	bh=hawNKPqy/fSDPubMAcYwReqXvoa96fubMIudJNnky40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXqtw+2nr3QvXNBq4fCikXAn5J57D7hkIurvtz/dRZAfAppmrebf94MHGu7zqOgcCqUaKZc5vhszK9mhYElCYSfscAFPA43sbbJgkmUCgVOL6MYeI47hHVIIGWjwtfLKJA1DR483l12XczOVtTY0D7P4/9VhUr4PFD3RfIHGcnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATm898CJ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6153d85053aso57733367b3.0;
        Wed, 10 Apr 2024 04:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712749863; x=1713354663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGFqD2H8A4IC39eJXBGYkefpyZOqcgp427WuDNRfz3I=;
        b=ATm898CJ3YSPkVg1rfmaktmd0J24wZHMoQl8orpQF0aoKng4Sb6Q0OX6ifNZhebpBR
         0ydKwz6sncc1XjthkKCEuT6IdHMHeMGb9XHoJNo+mVc6Gy6U6jI3S/FwtokH4FU30qic
         eCQGSQtUiY+PNCWLpiaKxla4+/0q2a6RMPCpkcxS/2pPLElesEYIVzFoJgYlqhKlKCc/
         CxS70csPNB+AVf+wFY5iEwC/EGYgsGhcWeFXjppYNcyGwvkkmOx/iJZAm7jC9N/h5DTw
         dHTKAd7kMP2HiyVhdXt9U9B7ASgW5pv5qgkwwYzu1ltKYKDLzpfpef2pC2Y8CmaZn8IP
         wUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712749863; x=1713354663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGFqD2H8A4IC39eJXBGYkefpyZOqcgp427WuDNRfz3I=;
        b=hIh4nJKJ9vI1xli9xwRdzyY12nQChz3vocYeEJBixLin+1q2/Jyvs85+2SEiXFfRsr
         oRgyMTeGg3y9ZcP0JEdyFd+1vh5APj14I4OczbTXF7IgUcbPf5kEASUGVESP36SQi3QZ
         wDYENxynKDgCNCU4eobVuMxMtzWEgZVvZ4p4ArEIg6guP+oZkkwAZk6lhJH4UIwtdzrX
         kRhqT0kh5+QbSKBHNi9nwCWAnxzrZ+0yG3qXf8tB2PsNAvmzgYW6/pA5K05jPu++8TRl
         dQ/Cc3754waTf2UCbA/enqYHUCADxsRttDg58IX8LsAl2SbD6qsMH+UFOL336BevKmfh
         68QA==
X-Forwarded-Encrypted: i=1; AJvYcCWBpxkh6GmSoMUhIwqnfyHv7tYdsA7FPK70vz0oZ6LVmQ/0kN2YjvdDckZpGY4WNsdRUnmD04XWOgecBZ+Zv1I7uHarYlz8OyC1HybtaETyFLNp55J7zv4EJ8YjjEdkCCYIgAKc
X-Gm-Message-State: AOJu0YxeuT+610xn6LG4z8YBsef0XKLlFSA+5eQtMgSYAlVFIHpwcNI7
	YE0n8CFjg8ArtjbaDv3oCdf8n8hCy7smzcQVk2G5wf92CC/cIC0dyeUwVaBPTL8n2Nryq2+FsUQ
	/sHS8MvpcYCbOpNOQRsJrCpWmhgoACFBz8JlOfA==
X-Google-Smtp-Source: AGHT+IEsPgbEvEI3iNDVlGUf1oUGjPIue/N/ftTR/UIOXIGrffHXCAqtPUghlz24jBdTp6dOSLPDroMYdDmNBXtMXGo=
X-Received: by 2002:a81:5210:0:b0:617:ca11:c7e7 with SMTP id
 g16-20020a815210000000b00617ca11c7e7mr2539289ywb.40.1712749863399; Wed, 10
 Apr 2024 04:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712733065.git.zhoubinbin@loongson.cn> <217ce2745a8787c504bbda1d085daba7e9cb2f70.1712733065.git.zhoubinbin@loongson.cn>
 <20240410-wrecker-procreate-11e0915f7bbd@spud>
In-Reply-To: <20240410-wrecker-procreate-11e0915f7bbd@spud>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 10 Apr 2024 19:50:52 +0800
Message-ID: <CAMpQs4KSJB3wksDO2TJA1HSMuEW2=r13UtXbvZPFkKAPhvBdvg@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: thermal: loongson,ls2k-thermal: Fix
 incorrect compatible definition
To: Conor Dooley <conor@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongson-kernel@lists.loongnix.cn, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 6:00=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, Apr 10, 2024 at 05:49:02PM +0800, Binbin Zhou wrote:
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
> >  .../thermal/loongson,ls2k-thermal.yaml        | 22 +++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-th=
ermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-therma=
l.yaml
> > index 9748a479dcd4..a25b42702788 100644
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
> > @@ -41,6 +42,23 @@ required:
> >
> >  unevaluatedProperties: false
> >
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - loongson,ls2k2000-thermal
> > +
> > +then:
> > +  properties:
> > +    reg:
> > +      maxItems: 2
>
> You need a minItems: 2 here also, so that providing only the original
> reg is not allowed anymore.

Hi Conor:

Indeed, it is necessary that the whole description is more rigorous.
I'll fix it in the next version.

Thanks.
Binbin
>
> Cheers,
> Conor.
>
> > +
> > +else:
> > +  properties:
> > +    reg:
> > +      maxItems: 1
> > +
> >  examples:
> >    - |
> >      #include <dt-bindings/interrupt-controller/irq.h>
> > --
> > 2.43.0
> >

