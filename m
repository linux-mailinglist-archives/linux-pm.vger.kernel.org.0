Return-Path: <linux-pm+bounces-11161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4310493299B
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 16:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CF06B21C97
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 14:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C0A19B3C8;
	Tue, 16 Jul 2024 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aRJwY2S8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A0D2A1AA
	for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721141266; cv=none; b=EYlkeiShJ9VoQezR9yVlWirHpMkLAHvjFgccjH9JBzTgnTH7fkUcxUhsVBBxVVvirJ5JmGsPnFrB2tZncE8O+XIFk+6suBSemK9G2Y0hmBkwgtbB+wcxPR9bqlI+/aVcr3jSBst5qqwVVC6q4BjqPf3oTB1N4KN6wT4Ucm2/y3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721141266; c=relaxed/simple;
	bh=OLYU/zcE0HnlwiLapO7NYHmW4tXIDwLirTbJShxq8YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jqk0xJm2CRNECCVK4alWIs0MGFvhk9LpWYEfG0Bvl1SmDpO1ATEldrS3pNR+As55scujquYnZuNIXIE73zu+qGHfmR7opsCxTfwPv52IHmIbg3EQ6rTuXda85kEIynVbE6FK3ryoAa9sQilv0L4itzvGenx5+/MEozzigJpRH7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aRJwY2S8; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e05a2949284so2894691276.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721141264; x=1721746064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lIUxRhCihkw5AdQD7a+Ru8B7j3Weiy/apMCIZLKG2WQ=;
        b=aRJwY2S8wfldWFfJLjRRimTIUWyi9//rJ+i22G5mNPF+12UJ0xJniYkLZoSdIyCqPT
         e3uefvqwqRuKevIs+u/CsTuGhXuuaWjhCMi9+pkbV4gq9Vao7GdVPGYSlqYNpsDyPO2e
         RtrVyVuklHKw9cX9RinubRh2rpWEWcYP9pCmjMAdRCRNn7CMrivVmeAfGoWqaKpjYhpV
         Thbnx6W4TjzejlFlJP8s7jXBE0aItCEY9KR8lC58bXdsNCHauMMeG/Jng7Zo7L0/0ynm
         /1TofQCvFuGWoz3oDbdazCjkEsXxjkVYjWtehfpIEUrFmFz3sSriCLyfu25RgfigswKq
         L3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721141264; x=1721746064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIUxRhCihkw5AdQD7a+Ru8B7j3Weiy/apMCIZLKG2WQ=;
        b=RN/nuviIRcu84s5d1jLmIvHE4FaayIKDgdQgadqqeSndKlOwwlQkNnHiXzimIqOoYW
         0hibq2yEun4Iqp5x57Nbb8UFC4/JWUbVXoQf566EAg3/3Obxt2ek7xDCXqLVhOpWpNgm
         Ubg8eZHYkNNKGx6O0WbcMGIUMemIA31b8mVydPvmcMmCMcRbGB2WuAEd43/xq9buRX6S
         duUoSIEmy9nMsTSAXwKONQmhpVc/+PG9hISYwlpSvYdZLzGc9fxrmrQt0sksjNPXmHqR
         Z82Z+skVB6UcmIUesYoiX7Q+1yiMkwNDc981sKgSasNdc152HpXy/qsx9eNWgboUcw+V
         n3qQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/zLiK5lGJPlVcApzRClgoXEtXVg3O88il66OEsqdYVpXlkVjmE5rnYuYeSfcgNHiEF5b2CIOBwbaqlKnBfC3tTWxk2c5qF7o=
X-Gm-Message-State: AOJu0YyH/WfKTylEwArE0JTEsVgFFtNaghFvoF9XG8rTP38XYzfNxQye
	b4F8+Y756i3tOK43aSbpRxYG9pTbERuqf33e05QPyL3DMmiGDrDyT57WCC1cRgo/3HyBPzQBrvI
	7YHbEDGBgt9FttNXWSwGcO1+6BuSuEM+qJQk1Fg==
X-Google-Smtp-Source: AGHT+IGLhLYhs15OnkuXXb6qctXWi3V58YENiqpNiizLQIzP3Jx59u+RYnM0FpRBItbtF/jNMz0BxWRkIf+zUjhYiBI=
X-Received: by 2002:a05:6902:1543:b0:dff:47c7:ffb8 with SMTP id
 3f1490d57ef6-e05d56670b9mr2737341276.12.1721141264185; Tue, 16 Jul 2024
 07:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
 <20240708-topic-cpr3h-v15-1-5bc8b8936489@linaro.org> <cd1c3450-1905-4d71-bcdd-5f880d743820@kernel.org>
 <94b2842b-6093-4c4d-a099-3e0a3198b753@linaro.org> <d35f5c94-7a86-4eea-bb0a-3f2785a25465@kernel.org>
 <CAPDyKFqhmNqbZ9Xkg0tWHE5LavoNaGMyE3dKmAFtHdS5=x33NA@mail.gmail.com> <d1d7b58c-b605-4adc-b329-f74ea4567982@linaro.org>
In-Reply-To: <d1d7b58c-b605-4adc-b329-f74ea4567982@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 16 Jul 2024 16:47:08 +0200
Message-ID: <CAPDyKFoViw3H8hCwLX0W=d8GM=5rai2xL5tnGGpctyqinkNpNw@mail.gmail.com>
Subject: Re: [PATCH v15 01/10] MAINTAINERS: Include new Qualcomm CPR drivers
 in the file list
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Niklas Cassel <nks@flawful.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Varadarajan Narayanan <quic_varada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 13:58, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 15.07.2024 1:34 PM, Ulf Hansson wrote:
> > On Tue, 9 Jul 2024 at 16:42, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On 09/07/2024 11:49, Konrad Dybcio wrote:
> >>> On 9.07.2024 11:04 AM, Krzysztof Kozlowski wrote:
> >>>> On 08/07/2024 14:22, Konrad Dybcio wrote:
> >>>>> Expand the Qualcomm Core Power Reduction section to include the files
> >>>>> concerning CPR3+ support.
> >>>>>
> >>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>>> ---
> >>>>>  MAINTAINERS | 5 +++--
> >>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>>>> index dcb37b635f2c..f3e013a52c16 100644
> >>>>> --- a/MAINTAINERS
> >>>>> +++ b/MAINTAINERS
> >>>>> @@ -18687,14 +18687,15 @@ F:        Documentation/accel/qaic/
> >>>>>  F: drivers/accel/qaic/
> >>>>>  F: include/uapi/drm/qaic_accel.h
> >>>>>
> >>>>> -QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER
> >>>>> +QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVERS
> >>>>>  M: Bjorn Andersson <andersson@kernel.org>
> >>>>>  M: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>>>  L: linux-pm@vger.kernel.org
> >>>>>  L: linux-arm-msm@vger.kernel.org
> >>>>>  S: Maintained
> >>>>>  F: Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
> >>>>> -F: drivers/pmdomain/qcom/cpr.c
> >>>>> +F: Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
> >>>>
> >>>> Maybe combine these two into:
> >>>> Documentation/devicetree/bindings/power/avs/qcom,cpr*
> >>>
> >>> I think avs was proposed to be a subsystem/driver directory at some point
> >>> and (adaptive voltage source? something like that) and this is the only file
> >>> in that directory in bindings..
> >>>
> >>> Should we continue with this "class" of devices, or should I move qcom,cpr.yaml
> >>> to soc?
> >>
> >> Rather cpr3 should be moved to avs or some other power directory. "soc"
> >> is fallback, junkyard for things without clear domain.
> >
> > In my opinion, I would suggest dropping the
> > "Documentation/devicetree/bindings/power/avs/" directory. We already
> > have similar bindings sprinkled across various directories, see below.
> > One less seems better to me.
> >
> > Documentation/devicetree/bindings/arm/*
> > Documentation/devicetree/bindings/firmware/*
> > Documentation/devicetree/bindings/power/*
> > Documentation/devicetree/bindings/soc/*
>
> So, should it go to bindings/power? Or should we get a new
> bindings/pmdomain dir?

No strong opinions from my side. Unless Krzysztof has better
suggestions, using bindings/power/* works for me.

Kind regards
Uffe

