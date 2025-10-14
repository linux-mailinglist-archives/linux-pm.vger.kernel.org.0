Return-Path: <linux-pm+bounces-36059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C3EBD8C48
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 12:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAC3E4F9B29
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 10:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840682F619B;
	Tue, 14 Oct 2025 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdfYgz7Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F02D248E
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437768; cv=none; b=MJ4wXVu6hjuoABYvRF4mBCYcw9NoUqxJDwshVKa9jVxO1PluUI1XTL9w1Q29mQLwJEWcZTa7v+ccl76ogfh7bMbZnNu4Qu0eJ8UJfoJRlcJOH70SfwQL6yyPTrtEzNfkFkkw1dUgI1kHTBQAzqNVBLFldZhMdl6mamMt/paX424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437768; c=relaxed/simple;
	bh=hYbEH8aG5/g2lPpfG/EurG4fthUUtSOeRcTH4W6yxtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOGDtBSPufa5bOmyB+XC9QfqXAIQBUpdHxEhNNnRO8ECwwQOr+VYYVLLnvfymSKNzliN4QvgQJFaTz0k/GFY9ERZuxAoBgUpdR97l21QVQuu90GygHPjlVDZ/D0JSWKE6ApJNo5x+xINAwko4gQ0RjTmeJg1PsK6v4xzLvol0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DdfYgz7Y; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-781421f5be8so17087277b3.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 03:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760437766; x=1761042566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNwslOTb5JOWqs8U+YdiNL7KIGdnAR5sXRre+K3C3ks=;
        b=DdfYgz7Y5rKyJFlUITSxKyldlwkvFkFQZTgk6UA/p2LEY5CQpKFBwncD4udabSboBD
         rrm7E9bZUvkucLxDDq/dee2j3ql/kyuWvNF76DVstATfP4FCeHsXikyQTr70j8gEegzH
         6KBn9Q62DDmtvc6VOh/nVPMqXKRqIMZliBdzMUV3/nvoWOleqspYJuCmx7ThPZhyNaPu
         PpNDgzBbY0qGjQohu1bTNSwB90F1Bg/jp0WGIuOPXch/joPJYuGRP/IgXNu6GZoB3NgZ
         IFXuHOl2RqiBiFiPM7Wc7tPFXEMkBmvdiCn+FmB8KXnMe5/9jHXnh19NqyYjGuwKuthi
         EhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437766; x=1761042566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNwslOTb5JOWqs8U+YdiNL7KIGdnAR5sXRre+K3C3ks=;
        b=NTYCNhyawLNMq8eNzH3fBLXa8Ft8zQOnjfs5AQDWHYZAW6Lv1yw+d2o+wXeugvrio5
         +ZIrvORkA9yojruyh6PlKKx/Ml6TjJZXr9bhxvmYp/9zbDpYJdt2km4wwdjmeN1H2OCQ
         G00QWnMBUvyDaq/1UB2DJKohygzv/cXxUIS+NSgKr3k4aMt21j8Xt1gyLteQBH1JYMSs
         oQppPpVIQ/fZcnOFr+FDLTjHlp80/9EiFTgXbIM+HsVOHFbYzmhe9uTnNdlT0NqRUXda
         yQ+OInENOybgOzMErkGzooIxae2hhdV2eDfMlYLLnGLgxm9JlzhiOdn0FsiWSeizWUp6
         ywqw==
X-Forwarded-Encrypted: i=1; AJvYcCVUK27Ob1VsoTZ/iJDZvb7rVb37hn30bzTsJOOFuEe/ntPEOJkQZNIgUXtK/FllzyG9R88Wnp51Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu6IrWxU/TS3Em7TOltj1xzvem5CTRKck4PF+d3fJ6hygcz6XA
	tCLUtXDquY0YJ7Nf4ItkMQdiGVfJ8uwllqAcxunwKEfgAaHIxckK+x/927PcowSA8aWMdHPyr78
	9xrt1BkmLj0fR9Xc5VTH8hoBi+kWB6DFn1w3zvB9VTw==
X-Gm-Gg: ASbGncstOD2Q5xLO2ybg2rtvn25aMoozOw+lpvfvRWPUyyUABFXmTSTezF255g3HOEl
	1oNMlKkBzuSx+Etb0WOkTSWo0Hp/z0BTpIeAWi+Mzp2VxXzfPxzrERsxUPAmJDrvothH/st7XqG
	N+YM1GuuBSfb1yGkO/SgDo7NUTIoLYLh/TqxNfgpWUpshNJn2KjByOWuaA6EsjBIeuM1IEp3Z/T
	VslGsIGngHN5uc27U71oAVCvRLcRC8XwFwphbvv
X-Google-Smtp-Source: AGHT+IFDFh6iWuOmPmvWilDaFBE5YfW3xBkJ2+8+m1/8Q1QTZSI3MhsChmCnpdF1r4INYGcDiNPz/lr8Vbf/DOouGeY=
X-Received: by 2002:a53:ce8c:0:b0:636:19c8:278e with SMTP id
 956f58d0204a3-63ccb84414bmr14226319d50.14.1760437765773; Tue, 14 Oct 2025
 03:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759824376.git.mazziesaccount@gmail.com>
 <19d537f9920cae5fa849b649e5bc42ba0b8e52f8.1759824376.git.mazziesaccount@gmail.com>
 <CACRpkdbHBQQnnTUrUzOrYxzQKCzDyy8aNK7w8OEFz-ic8ic1FQ@mail.gmail.com> <f2e6f0eb-b412-4cf6-8615-d669b8066393@gmail.com>
In-Reply-To: <f2e6f0eb-b412-4cf6-8615-d669b8066393@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Oct 2025 12:29:10 +0200
X-Gm-Features: AS18NWDIhtpPAtiexOECYnDlN0ABGxByFw8_QgkDjMMcng7GLnSDiPGnwdY3LaY
Message-ID: <CACRpkdb-Oz4RXWjLEH2ffKhe3jRxVTSN1u5g=tTTfQHpXW1=8w@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] dt-bindings: power: supply: BD72720 managed battery
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:00=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> >> +  rohm,volt-drop-very-low-temp-microvolt:
> >> +    description: VDR table for very low temperature
> >
> > Doesn't the four last properties require to be defined as uint32-array?
>
> I have been under impression that the "-microvolt" ending suffices, but
> I may be wrong. At last the 'make dt_binding_check' didn't give me a shou=
t.

Ah you're right, I tend to forget about all the magic Rob has put into
dtsschema.

> >> +        rohm,voltage-vdr-thresh-microvolt =3D <4150000>;
> >
> > This property seems to be missing from the bindings?
>
> I think it is the first binding in the file :)

Ugh I missed it.

Yours,
Linus Walleij

