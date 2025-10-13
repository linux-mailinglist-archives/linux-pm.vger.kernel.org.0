Return-Path: <linux-pm+bounces-35964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 605F6BD2F95
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 14:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 712574F0033
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 12:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B0F2367B5;
	Mon, 13 Oct 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xBMizyL0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F622690E7
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358685; cv=none; b=ItcfxBWXj7Fb0xU8Ao1X6UmgRHU2XtoGNd4xc5z8Q0WmBtjj22yODyL+WatCV3LcVU9OeodIIW/IiQKNdNqsX4Mli31hif2nWpAKzg531sCxwQL7CWO6hrB0e8q+1z9sv5/H4PwPXIaa7L3haSvpQVOWrIxTKdgbo7T8d4lWs/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358685; c=relaxed/simple;
	bh=2ym5gY9xA9byPvmYe/LAnl2zuqmEeBpK22V+iVpRSl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRq54lEAhhaNn4tkNQ2dHoospFyRByxJxIXZEtqWGRsnR3JzZ+kGW/aZ2dlh2CC6WiA4QuiLAiyJBmEanJZ0P1Q/figKSPJm8AqtSKo/0X/N3igQXOQWY1FOV9pxC3wMNcD3c32N8f7jF+y3ZaYYY2yWvv1MNekel5+jx87bHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xBMizyL0; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37634d352dfso28582461fa.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 05:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760358682; x=1760963482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ym5gY9xA9byPvmYe/LAnl2zuqmEeBpK22V+iVpRSl8=;
        b=xBMizyL0Yx4d+8V+t9wiLgRPf4qBDuLUoSk7nAy7nMVbSgvUM5u6sVw6tdW+UOA0uK
         WTIaGuK/YSQkX5xE1xkspf5Xa8gbM1P603nTohLUMWTaU0PMp/DgUZhus22CfaPt2+cq
         MaKmkZjnlRhLwtqsnNMi4HYh65DKMhL2kdvMkZWR5+8nM2R43uU4zYwwP7QDgPtgaCZt
         V4c37OkRydHs1F+K5HSRt+HJ1Vy+0DzwIHxwv52ibtuVYlnQYN/npAviapyFAIy9L5fO
         UUOcOoLkdBzTFAHTy41/cG6VBDJzAkrOAI3lAnyueZY64p90rNQa/8q80sH8i4GYdrWa
         CB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358682; x=1760963482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ym5gY9xA9byPvmYe/LAnl2zuqmEeBpK22V+iVpRSl8=;
        b=geBvUy804dlSF32zCf+Omi63+mGWlGkWALldYWH0gdmX7/umtZScoCFp4PMVCB6YU/
         XQ6ub1rT1YIUeizAxgfnWNfbuCWhB+rvdCLf9gLaoT10WjoA3JaN9wthORNRcB0ANP7c
         hFHn5ySq+a69o2PU4Mba7VJMLX35ZGWSAt/U8DYjNy32FSdTw1R9sbv4e+Hf2Szm5RAc
         9BXDZUdtOeS82xlqSlKgTIpGjJ33BvyYxk0ZfAdsxxnOT4jUAaw8LqXuyXF1/5jw4Ulg
         wql8mJESGfab9uhZKVxYnJwlgJuCyu4F95GrpSzFhMFJrPvd2WyOak7G1Gro4yHP3IWR
         /9tw==
X-Forwarded-Encrypted: i=1; AJvYcCWSUhKbBRBr0be8cgg/xOiCuCRIbhtObMY9Pc03iMTB7UYgC0NqYke3Jn6KJLc/iQGLVWw0o5KUDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOpFSRDtKMKE8Iu4wT4MbPlKXjUuY3ibnLFJIvZRzem8+18vx9
	hpMIp+XZc2+GfLH7Ba1SFZ8d98PIztGX5p6WjLeJCO7/8gcB/GWlMZTa5H1/hU71gXPA5zWRLIP
	talvc0N/Fv17UJTBrlSK5QMRMgwipi9sJMzv0pWEO4w==
X-Gm-Gg: ASbGncv5LNqpjGPP1p1GCnIWl5t0P2rAT1pY//6sToIJ/BqMtwnUB+efl6rioRPcxEj
	O5IpamX5HW0zUKJg2NJyTwut232QNQnzt9tVikNqVpFeehaogEj365b4TKhZ1yPmTx8/gqoSj5K
	d3/pFCndIBQxhYtHeTKek6pKn2zt1cYwXSzX6p5JRiMRQAfJRjceePL5LK7s1YmMFsPrZVrKpxz
	F7rkK9dOBEBJf7A0m2GSQ1GbjXvYg==
X-Google-Smtp-Source: AGHT+IFhwWUPdXGLE0UdPh1E3Z3kooNDTKBbQ5Xa5NjbLWLHkeWPvOb7Esb2TwKqbW3L7KgA6OggyzZuCUYLfacZ1yE=
X-Received: by 2002:a05:651c:4394:20b0:376:45a3:27c4 with SMTP id
 38308e7fff4ca-37645a32d2dmr19358931fa.5.1760358681978; Mon, 13 Oct 2025
 05:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759824376.git.mazziesaccount@gmail.com> <072180743039027b8476525bfb3d04b3dd044be1.1759824376.git.mazziesaccount@gmail.com>
In-Reply-To: <072180743039027b8476525bfb3d04b3dd044be1.1759824376.git.mazziesaccount@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 14:31:10 +0200
X-Gm-Features: AS18NWDff60qRd91QHkSir_vcs0VB7YoMwPxzCmgcXZWdg7IkB5T6vF1_imU3OI
Message-ID: <CACRpkdYZ_jdKZWEBbb5muJZkUfd=nh=j4ffQQEoDJuEjoGzLgw@mail.gmail.com>
Subject: Re: [RFC PATCH 02/13] dt-bindings: Add trickle-charge upper limit
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

On Tue, Oct 7, 2025 at 10:33=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> Some of the chargers for lithium-ion batteries use a trickle-charging as
> a first charging phase for very empty batteries, to "wake-up" the battery=
.
> Trickle-charging is a low current, constant current phase. After the
> voltage of the very empty battery has reached an upper limit for
> trickle charging, the pre-charge phase is started with a higher current.
>
> Allow defining the upper limit for trickle charging voltage, after which
> the charging should be changed to the pre-charging.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

This is good stuff.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

