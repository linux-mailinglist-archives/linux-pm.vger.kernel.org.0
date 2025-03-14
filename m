Return-Path: <linux-pm+bounces-24007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92537A60ABA
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 09:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E84169535
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 08:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451ED18CBEC;
	Fri, 14 Mar 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9vGGJ0Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F52912CDBE;
	Fri, 14 Mar 2025 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939553; cv=none; b=T9BohrGZ03WdoSkOktdsYk+5GTOXTcHEFmhIzKWQFjzi1iRa4hkwUm/ytNzihjWKWi+wiFDmSXlHVzAlLPrGs/RE43mWrIdq9AJe1Uj0h0jDR+bh2BPbsfOwBatf2V7popTNYK9m7R8JFC3uBb9+za4WI2Qr4kCq6IQTV9XXFAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939553; c=relaxed/simple;
	bh=521iapHwfmC+7rWHoT90eyWDbzdM7a67F9E+t6QMAsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlSKvRxTvOLBPIhaX9MWX/1KT7lOZqxJrOovZtLJnuBNgOI1exmJUhuDB4+0NGlIIieNRTQueqGK/cil6yPBIk1obRMlJ08ZFMn+HU930cwqgtlwV0dNUf/z5eVLtkagbUscAeY/ev6RwrTk3qPbMNVLXPJqk5wc1Ip2xjwhSWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9vGGJ0Y; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfe574976so11298995e9.1;
        Fri, 14 Mar 2025 01:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741939550; x=1742544350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3F5U71lWqNXOgTEfdpYjf9JDJvOldx5d/H+DiwWMEE=;
        b=S9vGGJ0Yhd1OiGvxRtkTdEF7fpVmTkBinjJEsUMmqDNvAM4iZTUjfmNWSu4bMjOW4S
         3F3tGzmeXqwh9fTse/eJtlt7OTaCElgXoKSLaRiyurwm5EbWtly8MJesN2s0jbm2XOLG
         If++OU13NMg00Z3E1PIXTrcbcyYAQQLiwMkv5nPI88H39jvkYczSP3W/zlN9/VTUhoPj
         2ChCgBlqY/E5zWWjqYAh2OFkXmUcWSUi22tPQrH22CH9rD7nU61oO2mITRudxkSpXaD1
         nC1r1rH2+WptOFq+FfnemvNoKhwllKy3GB4HQwxHuY7xMwhmlja2GLNalfKyiny85x1M
         yBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741939550; x=1742544350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3F5U71lWqNXOgTEfdpYjf9JDJvOldx5d/H+DiwWMEE=;
        b=N7hpG+xvaG9bwHV3m5Q4CuRHeGWlaWdKVfyTxsImMgbdWf+7bJIJoRqyp3YnX1QLzu
         J0gsbsH8OZGgh/vSadnPJC7lKptuFuo2yiweQkDC2kK9aLW0pNjDOJm2MlyKvPqb9c4+
         2X33S6r5fWodbxhlje7d5dsogkefAB7WacuvcWOvTKEaLeItE56czVQsVWiWZokk8lgE
         76V0uoiS2yxJiVSMUHn3FFeNE4R6nhl79Zjbop1NJm5WUpOxwCmNupvw2VE6u3/I4gDh
         Olfy/60woowmBV9cL+qHR5t5jnKz6mUjUL5kze7Q3tmyPpwalZl7nP6ywWQx9S8IDXR6
         OkpA==
X-Forwarded-Encrypted: i=1; AJvYcCVcm6UMFM6hzqgO5WoeTthWZY9AzCFnCfcpTkDlZzTwmfWuDPP19xaxN18mIHyZ9DgwxBQ2PBvTHBaw@vger.kernel.org, AJvYcCVs0zyH2mBQLP4xV2+GJVxWLZBG3KNdvZ8VHq1vuo109QUleKohGZSq3y/Q2XGyGUGRltc/sVrR4ILzExQe@vger.kernel.org, AJvYcCWaDRwDJtY0Ckm1xO1bias5uUqKNxNZaccSKjxxdq4oIkZBlUdjO2qLagN2bJY1lodYP5Kd5yNo3vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9fqEAPMZb7m9Qb+NQtZCuCqLBUQof28zG8TsphfADfOJxAHd
	Bv5Gs9LcY4cKZYap1pvlOy2LJocUg6k+alAS4i6PiiNwGaaG9x3TP1WZtmGCo2qrfYZGmZ8/bd6
	PLunrMhov+tuNDXwxihBK2YDikMUHyQ==
X-Gm-Gg: ASbGncuffMr/kVewkN+gs/e6eGKL1IqZ6lG00WuUKnJXKKlzNgVupp8ZhyyYXiT+D8b
	HeRIH6pAHb7IJmw6+BKrkQF911we8vuFB1/kalEAPYs+OrTIw1B2o+929nRnmsU/Czsrru3upH1
	yZWs4Zhmb9zXaWCvB1XVVMiu1wJ5g=
X-Google-Smtp-Source: AGHT+IHSsIY9kOWzB8AIo2vud0ffWpWSEgGT9PildP2s6lilEYAMq4bha/y00H24aF+H5NCOdU2BYpb0jAbV6/9/Tg8=
X-Received: by 2002:a5d:6d02:0:b0:391:2b04:73d9 with SMTP id
 ffacd0b85a97d-3971f511669mr1764783f8f.49.1741939549717; Fri, 14 Mar 2025
 01:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310080237.7400-1-clamor95@gmail.com> <20250310080237.7400-2-clamor95@gmail.com>
 <20250311193732.GA4183071-robh@kernel.org> <CAPVz0n09ZP1i2tasdTvnt8RvjhALvUYjv9u_EGRtnXPOYQtuqQ@mail.gmail.com>
 <4d1c3eb1-5c42-490f-83e5-60de05ffad06@kernel.org>
In-Reply-To: <4d1c3eb1-5c42-490f-83e5-60de05ffad06@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 14 Mar 2025 10:05:38 +0200
X-Gm-Features: AQ5f1JrEvItfx2OcaNPdug--EmXjf0r7KBek5RJXaO4gyKMX-UN6T1gJZXjpyME
Message-ID: <CAPVz0n1e4DXgx41A6GydapbFxEgvEfu_AAPzcz7298mt5UnxOA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 12 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 11:49 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 12/03/2025 07:02, Svyatoslav Ryhel wrote:
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 1
> >>> +
> >>> +  monitored-battery: true
> >>> +
> >>> +  maxim,usb-connector:
> >>
> >> Just 'connector', so when we have a 3rd case, we don't have a 3rd
> >> vendor.
> >>
> >
> > Please, please be explicit and specific, you could not tell me this in
>
> git grep -C 3 connector:
>
> > v3, you could but you decided to fuck up v4 as well. So wise.
>
> We got a lot to review thus we make reviews concise. I understand that
> it might lead to insufficient guidance, so more help in removing
> workload from maintainers is always appreciated.
>
> Instead of using vulgar words towards us, please put a bit more effort
> and look at other recent bindings how they do it.
>
> Review is provided in good faith and if it is by any chance incorrect,
> it is enough to disagree instead of throwing things like above. That's
> not acceptable.
>
> > Additionally, if you want a generic 'connector' which can be
> > referenced as 'connector: true' then add one, ATM this is classified
> > under your own terms as 'vendor property' and needs a vendor prefix.
>
> richtek,usb-connector is not the good example here. Your previous code he=
re:
> https://lore.kernel.org/all/20250225090014.59067-2-clamor95@gmail.com/
>
> looks correct - you have there port. So where does charger_input point?
>

Would the version from v3 with graph be acceptable?

>
> >
> >>> +    description:
> >>> +      Phandle to a USB connector according to usb-connector.yaml. Th=
e connector
> >>> +      should be a child of the extcon device.
> >>
> >> 'extcon' is a Linuxism. Is there an actual requirement here that's not
> >> *current* Linux requirements (which could change)? I assume the
> >> requirement is to have vbus or some supply?
> >>
> >
> > Pardon me, this schema is part of Linux kernel, no? I have no clue why
>
> Bindings are used by other projects as well and they live here because
> of possibility of review by skilled people and due to size of the
> community. It does not make them, in general, Linux specific.
>
> > you collectively decided to just ignore external connector detection
> > devices. Ignorance does not affect the fact that such devices exist.
>
> We didn't. They are described.
>
> >
> > And no, it does not need vbus not supply, it needs EXTCON
>
> There is no such thing as "extcon" from hardware point of view. Point us
> to any standard or even wikipedia article describing it.
>
>
> Best regards,
> Krzysztof

