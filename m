Return-Path: <linux-pm+bounces-34742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA425B59F0C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 19:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2E37ACE89
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F0B242D94;
	Tue, 16 Sep 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avYs+ih1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63F23D7E6
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758043013; cv=none; b=A2ZtHZLsiVs7zyhG03UMVTt5j6niZH8fyrErE0IuH78NChYt+RQfWQlP875QTPkZC780yWcPmMlUVSFfEffLUG33Ncg6OjHxT5g+YNRFc/7zOiWFyx414zEyYhEeT1hEiPiut+yaAW7SiqAaC7AUNJEazRvi3thHqRT7SXlji6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758043013; c=relaxed/simple;
	bh=UrB+H0yILRakp4kBxbK9yn5m03BlYcSRjFf4srWf0mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTRwmB8ecqXUabeCbe/zaEDtfL/oBivPnJJ3AnYoUGkIn8bWVmJvP/1iG4J15RVXL4S/mEXe4Cc7+/ISQNKU5SNryUeltA8wY9hFeDVu0YJ5HyrRKru2l3sJedLU1sG34ryFFfS/OPv6gwWcv3gSn+iVhGa43ZcsudofFG+k/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avYs+ih1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso3935096f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758043010; x=1758647810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXunugfsP8zuDyXjSm9YGg4hKUE4YJh9L2VZnuLOhL0=;
        b=avYs+ih1kw1O+o0Pp/LNRbyQ1xf9INErFqfnbTjqTl/U9vMp7X9FjgCd7EW4WJoJiE
         yyP7gENxZOcKOY8nxkgV9PqgJndmtVKVUCxkp0SYYC/j9T7I/odlumPcpYyVFH61pQSw
         g+cy2c6duksGkXeJvoAbetfTAFI6iZrcfFLXrbgK6Hzsiv2cQMb0/42fgMKQXOHubc38
         Ejpe38hlLF55Z6YY6AEJ5sELzSCJiZ1mFasJUfS8osHmUsWFst/mT+8QYtxLnF+WVy6K
         HY2GBcXeC1AWOa5Ayxmz3Oow/GGc36nl8AJCIjbk1sUs4VGZxSd5Uv9ggU1eHsRuaTgb
         yVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758043010; x=1758647810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXunugfsP8zuDyXjSm9YGg4hKUE4YJh9L2VZnuLOhL0=;
        b=JU3S4i32QTLhOtfaiqW/fAGycz91NWfPCINc411X/U+Wn0th2/390wc5tkLG9MCegr
         6IPiW+icWPWLvcUwN6HjFR4A07dFpMNgfsrLqcK6ZwSuoj36um8tqDx56ow/tlBBaGb6
         iDFZTQ3SSe9iq5UPvICaSfamywspcmMMdaYWmj9PBcDktaYiDtBphC7rEJLsBIdS69ip
         +F8It/kkiS9bBR4Ev56dbkBVQf8vt5U4mRRCWz6TlpIANqZ5xAY8LK76v0IJ76YNU4tP
         sjfJLR0OIIXztFRF6n9UhlrFxH59bUzeJQAGmEThQTT665BBg/rip6c9uT2j3TwEuU5g
         HylA==
X-Forwarded-Encrypted: i=1; AJvYcCVOzKih/w5JhwVcAmVhuS4NXachKfekFjc+qgW+UVuVhB457T+C5M+AHCJtNpm2TaTzvXZ89zSoSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMyIL9Ln4U9Dhwzr/GnvfMZXOczutFRHCd7XHqs7GYSlQLrFRz
	1ClfNGItiXKK6wjr8jNIw2utXMnLbd1ysbmVs7I/1k6LNhAMMWKkuySzeQ4CK+isOH2+8RP2vPs
	EkkGl76OFEnQBlbRwBBDFwW9BqlPM9C8=
X-Gm-Gg: ASbGnctZ3JDrvcp+W7vLpV+b/GAnShJXJMYTsI7aTxTAVIW1v6LVcjfjiKEGHjToTQH
	ier2MWT8jq32Hf9MuVwjRhLsFV4IbVbTNkphBhpIPXerqwM5dywGG7mpDbE8IRhTEy0g8v5O8qa
	bH4yHI7B9hToMNc3/EhYXCUpsiDbM+SO7gLWSxOFI7YYjp5xgRCljgX1kdmvLWDwdoob4SgCQkh
	4GI0p1C
X-Google-Smtp-Source: AGHT+IFqtKbkdbMvc8sfBF7NAGkQWbnxp9HrEDPJ04COedo+lOLyWWYScVsHNbKPb0qvFTIJ+DkHeUqPkHZxzlthVWI=
X-Received: by 2002:a05:6000:1789:b0:3ec:db8b:cbf1 with SMTP id
 ffacd0b85a97d-3ecdb8bcc30mr2101171f8f.24.1758043009793; Tue, 16 Sep 2025
 10:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912065146.28059-1-clamor95@gmail.com> <km7thoeguhkdp23gatn3w4kibgazzxi7s3cbkhueuokychqcbq@nabzlmfg3dmi>
In-Reply-To: <km7thoeguhkdp23gatn3w4kibgazzxi7s3cbkhueuokychqcbq@nabzlmfg3dmi>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 16 Sep 2025 20:16:38 +0300
X-Gm-Features: AS18NWD97oKjyygDrh6IMRSKq_qvj7eHt051Sltk5_HLhw06CzvSFGSnKXDHzEg
Message-ID: <CAPVz0n16NWiLgz9XT-_NF8gvwBMj+6+L_0Ua2gCDE0WK482QBw@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] dt-bindings: power: supply: bq24190: document
 charge enable pin
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 16 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 19:59 Seba=
stian Reichel
<sebastian.reichel@collabora.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi,
>
> On Fri, Sep 12, 2025 at 09:51:45AM +0300, Svyatoslav Ryhel wrote:
> > Document active low Charge Enable pin. Battery charging is enabled when
> > REG01[5:4] =3D 01 and CE pin =3D Low. CE pin must be pulled high or low=
.
> >
> > Svyatoslav Ryhel (1):
> >   dt-bindings: power: supply: bq24190: document charge enable pin
> >
> >  Documentation/devicetree/bindings/power/supply/bq24190.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
>
> No driver change?
>

That is correct, both my patches for bq24190 charger and bq27xxx fuel
gauge adjust only schema to reflect the hardware configuration of
chips, drivers for these devices do not need any adjustments at least
for now.

> Greetings,
>
> -- Sebastian

