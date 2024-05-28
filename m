Return-Path: <linux-pm+bounces-8258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC38C8D1FF9
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 17:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA721C2310B
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 15:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6801917083B;
	Tue, 28 May 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guyhY8ja"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8D170855
	for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909192; cv=none; b=GMyltLvQIj5E35UEWaif/DAtnjoRoUFZZeXjrtcyg6wJIq8pRd/x9dwn9TxprNW1saRzDNz4svohdM3L69rXsr+wZPqMp+1SPL39EQd0y+KkjhD9R7Gs0Ipa2YPm/CYh9/lXrrxq7JwW0o7uZb0OXQwjnVHVRSdlS3wlNGwNM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909192; c=relaxed/simple;
	bh=bc1gaU0jimcHP4nmj8y1nOebfgtpG/F80UBv3S6uv88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUMfkAgtAyb335b8iPZI9F7u5brYK9yhUMByWQYV+DeFSwx8Qq9AxBV8q4XxVrBQVjJAEvxvZ/8OpzIfFu4j39uxfgFaLPsRxp6IwP1kPd9NHJ+AlsN38AW6OSHlVZrjCvuvF5TVdCYkb9mcglAKvnFkuhOiagRPJu16Khtxc3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=guyhY8ja; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-df4f05f4cc8so989950276.0
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716909190; x=1717513990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wEXZwKJdgLQqBqHcP2FuvqESxVIGZJvO/O2KfZWi54M=;
        b=guyhY8jaDbhwKdFQWHj2SQ6J6OO1fdzKdJ8RwyFisqHbbSxAkSxxAqyeJQumLy9rVv
         PKop0kO+XfU0l6ZHxeSBBBQKaBwzZwFJDJWMyucb/7aPWJYrhA54f6WxMBiJLjAgY0W8
         7/kAyXLYBZgIsm47KELOW3HWHaRBUwWnM77sHZx9FmLArqeqWwMlrf39Wn3kRR6ys7/R
         UWzvyV46nD78wqregA2qdAu3WNKODYeBtL9KiS+51DRWU9X2HHrIsUlXDfvUwRMRsMQF
         iOZVyYshBAuD+EuxlDdBOkdGz5KcVfVA4WtzuaQ9XdeciYiGADoOtUNb9ZDrCy18hjZC
         yFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909190; x=1717513990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEXZwKJdgLQqBqHcP2FuvqESxVIGZJvO/O2KfZWi54M=;
        b=fq+HituWu6mHh7gMG6JCTIGe5W8NzmwZVCDh/uU0jzhuLX3I17IW5sxEamf1tL6WW5
         YX8WSEg4N7Go6by1UMRFNwfOA77HGOP651h/1cD8Efw9GnkjbYDK36S0vcpSeBKhAVIJ
         +HtVSl4P7K4nUpbVNe3QuWdUdB64D0oftUIpNzk9k2zSH9xheE8CZ6ItDgCxk3QQk+Sn
         gc/oPrxi2sV19DX6lT1pbkLEdgQt92kGZIRKnKoCJPgel3HIlQA4n2y3e2snHe6QVZ6E
         I0Rt/g+FemS5abcmMHjlpyh21l9fMa6e+VJv5v/eAtKpyUumqwSzTePVfyLx04zCYb83
         aT1g==
X-Forwarded-Encrypted: i=1; AJvYcCWVzJC2qAZ4/TqJ1g4wTiZoAmj2cZpdeYtvtVn/dX6ofH9I7oBstkshLsx+B6AixfKFMvuhLqPI23mIyHa+CMpK1IgofyM0nHU=
X-Gm-Message-State: AOJu0Yyo/YUxyoo3YTEC4s0eZ4C//Oh374GX/g1Nb0ewogy3eUyN94WU
	3VWxYsem9Ec6zQckF//CzEh+ygc7038y0L3EXZBcJQ7vcVmrcTMviErzfIEfBV6PxIW2pdp6uJs
	PNJlBOOPAfYgGdka420U4h7+AWd3Hl2y0uvxutQ==
X-Google-Smtp-Source: AGHT+IELm1omO1wuTcw0Q2vGtaouTh8qJh+L8tegQHzARNG0l5mU2Cg7HCqEbHJH9QdriZCLJhqdzvjc38hiHJMqFkw=
X-Received: by 2002:a25:800e:0:b0:df7:9242:281f with SMTP id
 3f1490d57ef6-df79242931emr8456060276.49.1716909189568; Tue, 28 May 2024
 08:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527-yoga-ec-driver-v3-0-327a9851dad5@linaro.org>
 <20240527-yoga-ec-driver-v3-6-327a9851dad5@linaro.org> <bbsdvqjo2ikljnuvupolpdfstsaegfqyg2ct7bt24evcorcfjt@3fw5eicxxuik>
In-Reply-To: <bbsdvqjo2ikljnuvupolpdfstsaegfqyg2ct7bt24evcorcfjt@3fw5eicxxuik>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 28 May 2024 18:12:58 +0300
Message-ID: <CAA8EJpr9i=+uJGqxeeVYKwJeMqzQFg6FvqnChKNQqXLLVcB66w@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] arm64: dts: qcom: c630: Add Embedded Controller node
To: Bjorn Andersson <andersson@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 18:06, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Mon, May 27, 2024 at 01:03:51PM GMT, Dmitry Baryshkov wrote:
> > From: Bjorn Andersson <andersson@kernel.org>
>
> Please align this with the S-o-b - feel free to use either form.

Ack. I'll check what went wrong.

>
> >
> > The Embedded Controller in the Lenovo Yoga C630 is accessible on &i2c1
> > and provides battery and adapter status, as well as altmode
> > notifications for the second USB Type-C port.
> >
> > Add a definition for the EC.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      | 76 ++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> > index 47dc42f6e936..d975f78eb3ab 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> > @@ -370,6 +370,66 @@ zap-shader {
> >  &i2c1 {
> >       status = "okay";
> >       clock-frequency = <400000>;
> > +
> > +     embedded-controller@70 {
> > +             compatible = "lenovo,yoga-c630-ec";
> > +             reg = <0x70>;
> > +
> > +             interrupts-extended = <&tlmm 20 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&ec_int_state>;
> > +
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             connector@0 {
> > +                     compatible = "usb-c-connector";
> > +                     reg = <0>;
> > +                     power-role = "dual";
> > +                     data-role = "host";
>
> I was under the impression that this port is wired directly to the SoC
> and as such this would support data role switching as well.
>
> No concern with that, but just out of curiosity, is this not the case?

It is wired through the external Type-C port controller RTS5437, which
also controls the vbus pins, etc. The UCSI firmware reports both ports
as host-only and doesn't implement data role switching. So, having it
as "host" is a safe bet.

I must admit, I also hoped to be able to use this port in gadget mode,
but it seems to be nearly impossible.


-- 
With best wishes
Dmitry

