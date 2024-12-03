Return-Path: <linux-pm+bounces-18442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA809E1996
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 11:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50388282ED2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D401E3DE7;
	Tue,  3 Dec 2024 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OxOWo3F7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA571E2822
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222461; cv=none; b=mJmFn9LRpVN59HyU77sAlg6xHy6uJpSb0II82H2wZC2RzVG1xDmdBpLBk2B7iYbKNyWfzrVbY4WXxfbwN3fTO1Bs+LmfNrW5tczoUxkyZ/b6u9Puz5t8+taa1WNjvkdPMVDOZmppHhs4YTpqOkryPfOOY2fe/T+zXXmlf8s5EHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222461; c=relaxed/simple;
	bh=QjRZn9m36UpoMU1YfOpgfL0cMt4DBCuwE5rzTlpXXfM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E0iIOaNZsFsT36QIE7aFOcw4Yu/FhXuRD/U1D5D0fVt9MJWij6/Z+O0wCJSa5JXlelxGnbVnDibt0G4EwkMBlwgCj/weU6iknsvKArUBye6O8EW4A7XL05JvX49KS4atgWW+tSYRP4gGoTnB/ir6Ge8bSdcjV2o6gmeDwXOfzbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OxOWo3F7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385e35912f1so2473336f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2024 02:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733222458; x=1733827258; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QjRZn9m36UpoMU1YfOpgfL0cMt4DBCuwE5rzTlpXXfM=;
        b=OxOWo3F7jP7TGyd4NJQyFqKsdjhHMVHiVJe4N/fNBnM843i6AEfAwCGHY+G3p6CoOe
         m7GvaXOyAyDl2t0XJzBdJ1q0Ac5mz+2cqbgLM9i68lB3TaE/Xxse5Z7vWTzIEx3vElzw
         tlGIajOtu4cbHyPl2ush28cvbrmPQlgPdlQHaz7nidZmvFkxhNCRK8zCBfNNhbZMaWmG
         5P3Jpt98ipr4v0gIONCb5fGBZAU5vy2JnXpzNk44tX0oyoTl+/lUI/rn1gESaO/7QDiu
         zaD4SWlunESeZOL54L42ayk2rec4OWMwFAQAls0EcNA/Eu4kyiO8I5wfpcrhGFTXkVWZ
         P2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222458; x=1733827258;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjRZn9m36UpoMU1YfOpgfL0cMt4DBCuwE5rzTlpXXfM=;
        b=aEy8F98WOEq4gCE/VfUxiMJZILfMoXgyZEYNxf0KHmjxs7rHkqWYHYyaSOPMbFYtER
         +UZRCW9sykqM9LyIbiNcv4vwwvNOEZ83UuMTyXHc4tGazREwFZJC8hmPIX/4hQXPrrFw
         wo9K6Pzcwu/kQ7Thh5rfakfejqD3ZNMRQ2J6DOMfhB0rtgCzheNz9BrO9hY8u2YXn/nM
         DbwZfO/P0Xaq/GGwfwvtBUvofCk0CcBR6HLRNt2tcrSozgnlwBoSrHKisW1n3IIfl517
         yTJGzJX0eDVhvNxx1AyYQbMUkXDmmKpwH7SgrEwT392erbr1Z10fcWXyg+fF25LIL/De
         7phw==
X-Gm-Message-State: AOJu0YxLrhFL2enUz40sRDvbrOJcHUr3OMB0Cpn2/VdUtfFfuLxaT2tE
	Jb0yM80DQJPQRlytdzNhoi+HyE08wvppLJVmCwXN5AOA39KXOaOSFaRNrkIy9UI=
X-Gm-Gg: ASbGncueuZDESY2TgDaESUATTiLEQXuFkQfn/yPNSmJCsh/cUSyuTnAOJtyoQvuqY5t
	zMEzGgboiMbD/cBhVWwLPscK9WhGyO7+OPIsTfrTXzV0ikHmwBceBGUB13oEpCff12ntVlqQAUc
	uUq7GajLe/OsG57YYM2rLHhjcRX23aZcjezdqU9GD0C7Uks1B5RIX+bnLKNTE/Vx74n3et1zGsl
	tNKyxd+6nQXmwOrW1IpLWSs7qnW7UuElybMG/jyjIJ9R09nKtANUTw=
X-Google-Smtp-Source: AGHT+IEIQMRTqJYQglD4CUOE9KJIR7TrCdL2VS3fYUudSCxmJ2z/a94ILKbvxrjP3h0f3AYq8lLHfA==
X-Received: by 2002:a5d:5988:0:b0:385:dedb:a12f with SMTP id ffacd0b85a97d-385fd3c6547mr1799666f8f.6.1733222458153;
        Tue, 03 Dec 2024 02:40:58 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ee2c7559sm6885746f8f.12.2024.12.03.02.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:40:57 -0800 (PST)
Message-ID: <30b0995903fb7db3f866d1304783d878f563fe2f.camel@linaro.org>
Subject: Re: [PATCH 2/4] dt-bindings: power: supply: add max77759-fg flavor
 and don't require nvme address
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Thomas Antoine <t.antoine@uclouvain.be>, Sebastian Reichel
 <sre@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Dimitri Fedrau
 <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>,  Peter Griffin <peter.griffin@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Date: Tue, 03 Dec 2024 10:40:56 +0000
In-Reply-To: <575b3275-b2fa-4e5c-bb6b-759394b02e18@uclouvain.be>
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
	 <20241202-b4-gs101_max77759_fg-v1-2-98d2fa7bfe30@uclouvain.be>
	 <e23721ebd766f410103ddfb8705f3d7d6e5ae3e9.camel@linaro.org>
	 <575b3275-b2fa-4e5c-bb6b-759394b02e18@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-03 at 11:23 +0100, Thomas Antoine wrote:
> On 12/3/24 08:12, Andr=C3=A9 Draszik wrote:
> > On Mon, 2024-12-02 at 14:07 +0100, Thomas Antoine via B4 Relay wrote:
> > > From: Thomas Antoine <t.antoine@uclouvain.be>
> > >=20
> > > As the Maxim max77759 fuel gauge has no non-volatile memory slave add=
ress,
> > > make it non-obligatory. Except for this, the max77759 seems to behave=
 the
> > > same as the max1720x.
> >=20
> > What about the battery characterization tables? Aren't they needed for
> > correct reporting?
>=20
> I checked some other patches which added fuel gauge and other bindings an=
d I
> couldn't find such characterization table. Can you point me to an example=
 or
> explain what it should contain if there needs one?

I haven't looked in detail, but there is


https://android.googlesource.com/kernel/google-modules/raviole-device/+/ref=
s/heads/android-gs-raviole-mainline/arch/arm64/boot/dts/google/gs101-oriole=
-battery.dtsi#13
https://android.googlesource.com/kernel/google-modules/raviole-device/+/ref=
s/heads/android-gs-raviole-mainline/arch/arm64/boot/dts/google/gs101-raven-=
battery.dtsi#13

which include
https://android.googlesource.com/kernel/google-modules/raviole-device/+/ref=
s/heads/android-gs-raviole-mainline/arch/arm64/boot/dts/google/gs101-oriole=
-battery-data.dtsi
https://android.googlesource.com/kernel/google-modules/raviole-device/+/ref=
s/heads/android-gs-raviole-mainline/arch/arm64/boot/dts/google/gs101-raven-=
battery-data.dtsi
respectively

Both overlay
https://android.googlesource.com/kernel/google-modules/raviole-device/+/ref=
s/heads/android-gs-raviole-mainline/arch/arm64/boot/dts/google/gs101-raviol=
e-battery.dtsi#177


Cheers,
Andre'


