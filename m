Return-Path: <linux-pm+bounces-22407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F73A3BB0A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 11:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018923A8F57
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 09:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E991CB518;
	Wed, 19 Feb 2025 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bezaBjmQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A051C5D7A;
	Wed, 19 Feb 2025 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958884; cv=none; b=E46lKenQiRN1OidC0P8ndAoJArPCx6e6+EE/Kj7NoGtOjGPlLUwAKHxo86OXwB6QZ5BpLjE1TXGn3ykWFlggKcVaWoqS9GwejWr803qRgw9Io5KX5IwhZe8yl0byENWql57vlzJzy8gxr31stzPG/gx9Jb3R6ns75/53OrkTZwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958884; c=relaxed/simple;
	bh=Ud5ArEVeWEhgplooqFyTa9NH4iriGbo3oERuVmwEI0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdfkdWuT7CEx8sxsWGLe9nIQhJKNZAAKeaC42nwidK1ad2hucEPLpR0FYKga+WfjNcIwGNsJzaHfF/+4NO4fpegmqxoORkD2jUl64SIUz3ohLDAGDE64JHaeqkEiOGu/m4NpoEU4GEKqu1mXPa+yuZzX2oOiEFYZ/M1wyVgUHXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bezaBjmQ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e589c258663so6989124276.1;
        Wed, 19 Feb 2025 01:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739958882; x=1740563682; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BCav4SHfE7EQJCkWf7DvjjeXn6VgMu12EYuLJnvgv48=;
        b=bezaBjmQuHqLkl2r9GZKdoI/l0jvZLj+Xs6mPtAjdhUrH4+j1Y5GTkQWggPTmMHyap
         RC7yvV5vMdfjYvAezAAKWaqed6VKllGvsR52kIs+TzIoxU+uwin0lfBQ/Dy5L6rmWV1j
         t8R+TgKdmvpIFfjk56aSbNmXP5egia9BzrEequkobXNhoSoE9MmUdqFD/AKhXjrH8Gwn
         lNPY6WdE+XNPkyqoMteJuNZSqVHG4lyU2EEpEb384re1iUCWAoQJRiCRr80Cf+3LEUgH
         Y1F1/7BEbSvGqYg1hiPlkkU9iwixTlqhlUfH1THt4Iv1jCkQHgeZwcTj2Ackk7/GE5WX
         3b9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739958882; x=1740563682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCav4SHfE7EQJCkWf7DvjjeXn6VgMu12EYuLJnvgv48=;
        b=Pbe6klFz+7tfeezWIIoBQuNEPsDgO2xjKdPT0AVFMU4RWrTwzu939pTqST3oypjRBg
         EQ6E6S/L02NA33SBGXuWosLyATcybvtP1bFgZfvQdR/vIdvqdxtpNvNqlBiwdkrWJhhH
         uZW9hzvQ7hzaEt/fLkbwdQZ2sxqd2itYmxRsaOtfdYrzxDCCuS11lxE5aWWxQjlxY5tD
         sQ0qQsKpGYTjj0A8nNKup8jAB8/D9m469YZYpji4HQuU21y1z76iOfIr5dolbVAIT0L5
         r6AhUNMYc4jJwQPoTtGrrMVy5HVmEcUOsWZKaMxzsHEq5D4lMKXU7q1/n/QdIl4Q6kno
         z1pA==
X-Forwarded-Encrypted: i=1; AJvYcCUIj7gSyWXcxfpZg7wLEW1iL78qi26C7p8+/1a7TeWRCnlryg81Jl0uAON17SVyIVAJ9pO8GPc9+Yo3@vger.kernel.org, AJvYcCVf9jzkQjwM9E2unozylp3p318WDUBbsDwheT8HqMSsx09r6DY0tAZhWL23Tia/D1ENN2J8IznQTT8TGXw=@vger.kernel.org, AJvYcCXSLP/kS/A+tLbkadf0jW7tvCg/rRPTgaNikLsqnU0is+kTIVOufpp/TXhluYbTQbSR5clc6O5mbupI6SZi@vger.kernel.org, AJvYcCXYcM+1UP++2NkvQBgHOnnM4lxuZ9a2JzIZ2f4IR6tYPNClmcXenEa0YA7DBer1pjfwSIlnWrQLhNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl0/JKhFwNPzEDVTp4V9Hwddc4hDAoONBYiu3hw/exBlHiLynv
	NicPuO7+vY3F5a7dd2AS/FZAnLIKB3XE+T+5b5dhQheslr0MO4qizjbISOGPa75BTMdD5ODp7Sn
	ja1/6ZDxyHG01kTt7FxmB8IRwKvU=
X-Gm-Gg: ASbGncvAOXEyybLYy3CEPCN62okyK1VnUqGiWZXHMHTc1ZwJkMoj3+VS5PuuCem6OQ2
	Uvwix36LiBr9NahvsB3ZRrnjTcqxCGh81vmNJrlezE97W+CJp7Ukrtm5fLbnTCrzHGf2uBZ19Gg
	==
X-Google-Smtp-Source: AGHT+IFAsRovKqEPyfeA7p4gUvXbV4eJrMlwT7pqKN/+12P/FiSevR15M7Mr7rEzXhQloaQvHIzmg0pHyi/KhmeP6Fs=
X-Received: by 2002:a05:6902:108e:b0:e5d:d6b8:2317 with SMTP id
 3f1490d57ef6-e5e0a1400admr2490172276.44.1739958882412; Wed, 19 Feb 2025
 01:54:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-isp-v1-0-6d3e89b67c31@gmail.com> <20250219-isp-v1-3-6d3e89b67c31@gmail.com>
 <16f6d4a2-2102-48b9-a0ae-b8c6595975b8@kernel.org>
In-Reply-To: <16f6d4a2-2102-48b9-a0ae-b8c6595975b8@kernel.org>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Wed, 19 Feb 2025 10:54:31 +0100
X-Gm-Features: AWEUYZmesv9PAJrRnsNQHdoWoBNxlIk4Jp5agMR2Ng1Yo83bsxbQ8IUxBouljGI
Message-ID: <CAMT+MTR7dhtt3SOMg0K3UakJQftqnc2S-rV41HdHtA+o9aSPug@mail.gmail.com>
Subject: Re: [PATCH 3/5] media: dt-bindings: Add Apple ISP
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-media@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 10:37, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > +
> > +  apple,platform-id:
> > +    description: Platform id for firmware
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
>
> No, use firmware-name.

Not sure how is firmware-name an appropriate field, fw-name is a string
that references a firmware file, while this field is an id that is sent to the
coprocessor firmware in order to identify the platform.

> > +  apple,temporal-filter:
> > +    description: Whether temporal filter should be enabled in firmware
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> And why is this not enabled always? Why this is board specific?

Not every board has support for this feature.

> You miss here ports or port. ISP usually gets signal from some camera or
> other block.

For complex cameras - yes, but this is closer to a UVC camera connected
via a bespoke protocol. We do not need to deal with the sensor access,
all of it is managed by the coprocessor firmware.

> > +        properties:
> > +          apple,config-index:
> > +            description: Firmware config index
> > +            $ref: /schemas/types.yaml#/definitions/uint32
>
>
> No duplicated indices. You have reg for this, assuming this is index.

There are duplicated indices, see isp-imx248.dtsi in patch 5 for an example.

> All these do not look like hardware properties but rather configuration
> of sensor which should be done runtime by OS, not by DT.

Those are board-specific and not discoverable via the ISP protocol.

