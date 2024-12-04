Return-Path: <linux-pm+bounces-18585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D18269E4710
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 22:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689951880183
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 21:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB551922FD;
	Wed,  4 Dec 2024 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF4IIZNQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418F918C930;
	Wed,  4 Dec 2024 21:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733348547; cv=none; b=a2Xdry92AQFbctABX+ChtVW7fFea7i2QGUEZypnxt3bynvTRQ1R+VLB67++Pej78UyHU8w0HZr1NBk+bpI9rQehSKOKaAjOnTzLq1WsdtypjWcgGoUoBgMYCwOvOfqZLthcDR4cDH0V2ImGOZ8uJjpOyF7LTwKwERNBzdIGk3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733348547; c=relaxed/simple;
	bh=WljylZvYrPZsQ37b/hMdisXffK2FmvviroNKLZTZ6Qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcgMW1Cxg/UB8Ab4Be935pTo+roIcowIIUN6aORbLWciz7cUNi6QLnpuyVMJKUDWeN5EkYozprXs6w6VA1YXaBQrXyU36Y1QKN9MYPdcJjp1okr/xEVakuJAf1aTbMQ7KFt39boPWWjB+QtUUXZsqh6z2yqCv8QDiVPWa2HJXeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF4IIZNQ; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4af5dd908bfso40979137.2;
        Wed, 04 Dec 2024 13:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733348545; x=1733953345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PlB8MgNt8fmwPOvk1DchCxtKyzjQviw1ZTp7fhr/VI=;
        b=NF4IIZNQGN/IbKWjPl3M7TwCE5Ode+7L9kQpEUSarkv5R8lUVUPCkx0LYQI2CR66cn
         PITvA4S/uYxq/brBXEf813UjRq6SSE6LUeio30ziD/fXYPmn8phw1yQ7r5ODOpzwSY5k
         N0as7qOhzAC8uCoBvOXIJXf6BAywd3n4s3H3qq4QAeY+afiJ5vXdjBibfE6SHAkE4z5c
         j/WX6JHJhKagtW0Tajc1At9b+amtscZjDzbET/qm/tswEoK7LH8bRRMiW4Kljj68/9z5
         mwu5CZifNrT4O+Q2SnXN6bhYf191uWTSVeXJ5YfRQO3z9iyT3S6mGwYx314is7qZvPOR
         8LWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733348545; x=1733953345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PlB8MgNt8fmwPOvk1DchCxtKyzjQviw1ZTp7fhr/VI=;
        b=jUgZt4GIDb/AdynreIwUNG4S+rpYaexhu4nXhr1kUnpEW/XAK5sPGvci5earG7Xr1J
         fpWJPDaj+6ekmzsXZUbyGhFIWMhOoQH+89EJX+CBLJKGejS6KU9ce+gvU5vCTmNQd/bI
         kxQwUWcjmmdZcAEke0UamY6KL2FxC6vOODmC/rOhOyK+Xwjkd2IQwCPNsiTlPCTzjY6r
         xAdOmhvihO/GfiZhZ/GucoQ6yNLjVu+SajksDSwzW5WtlzPSrUbCZROC4+Q3otRhEmcb
         J4W4JqkfKGu6JO0wzgK+do8SLz6f/0Ok47eIY10MWxvyKqzEp96oqCRMQqmM+AGGr8A6
         VRsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6gHoEYzNnvtHVoTC5TsLzGEv4F4M5KSNS4V5t+64IH0X9efcgkoZl9zGIsEjvL9mvyqBlcg9RZj7yZEnI@vger.kernel.org, AJvYcCUBJKWQne8nXSaUodUo9vqFo5CUti0MWTTM5cTg34f0Ra1I9r2mutlrQVIVe++JZPuTTnQytG/DYmE=@vger.kernel.org, AJvYcCUBqtXZRwPY1uE6r/WrfRSZ/oD2GuMZ3mWYFgTlFsOWo7awY6BhKB4NJLWxcHeYz4Cm1sOR4afHmr3a@vger.kernel.org, AJvYcCV2C4vLysj6lHhjOqKUyET1li3ixnUDWUbG8zhCRzM8MLZl+of+fxuzD5J5k6YI8R1UVXzJsdI9Yxdo3A==@vger.kernel.org, AJvYcCXxOP/ceEiMKPkELTdPDM35qonO0ApE8e5hTwBcgctmjCnRrQpVDcjrkE3dhYKSN0mXd5UGQWw/W1ji2IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHPrhs+yDjenapgkBDylpoY7uSB4NkDdhnLeG6oS6pTgIKm1Pw
	WnXxYUknM1qW1V5iODayshzJbymkAaRNoPPTjGFLeJ98/DbZVyLgCIjsw5pmAmQ+BTGMQbwJnZi
	sXEi0sHl0tDoMvu65iOcEO+76LXI=
X-Gm-Gg: ASbGncsV7sZ40iAkGFiVW+XOy3w9HAI1bpd259YON8Qhdy5exvfArA/ucbNuQETv2vM
	jVFWyf+E85MvVq5tofZROxa+U10eNeA==
X-Google-Smtp-Source: AGHT+IHu70LYWpj6fa8sLfwZLKiur4I+k6WrPOjUKSVGLsxhae1PVK6ehP7mUleD81MziKWVusLXX7Uk2MAsiOQwXF8=
X-Received: by 2002:a05:6102:5106:b0:4af:bae7:893b with SMTP id
 ada2fe7eead31-4afbae78afemr754768137.15.1733348544953; Wed, 04 Dec 2024
 13:42:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com>
 <20241204-starqltechn_integration_upstream-v10-3-7de85e48e562@gmail.com> <173334780474.1329015.17978320703905985001.robh@kernel.org>
In-Reply-To: <173334780474.1329015.17978320703905985001.robh@kernel.org>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 5 Dec 2024 00:42:14 +0300
Message-ID: <CABTCjFCDGWe1XnUDNcHaEwFMrdyJdwBfz3dKk5pb209BCMikVg@mail.gmail.com>
Subject: Re: [PATCH v10 3/8] dt-bindings: mfd: add maxim,max77705
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	Pavel Machek <pavel@ucw.cz>, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 5 =D0=B4=D0=B5=D0=BA. 2024=E2=80=AF=D0=B3. =D0=B2 00:30, Rob =
Herring (Arm) <robh@kernel.org>:
>
>
> On Wed, 04 Dec 2024 23:09:53 +0300, Dzmitry Sankouski wrote:
> > Add maxim,max77705 binding.
> >
(...)
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/m=
fd/maxim,max77705.example.dtb: pmic@66: fuel-gauge@36:compatible:0: 'maxim,=
max77705-battery' is not one of ['maxim,max17042', 'maxim,max17047', 'maxim=
,max17050', 'maxim,max17055', 'maxim,max77849-battery']
>         from schema $id: http://devicetree.org/schemas/mfd/maxim,max77705=
.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/m=
fd/maxim,max77705.example.dtb: pmic@66: fuel-gauge@36: Unevaluated properti=
es are not allowed ('compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/mfd/maxim,max77705=
.yaml#
> Documentation/devicetree/bindings/mfd/maxim,max77705.example.dtb: /exampl=
e-0/i2c/pmic@66/fuel-gauge@36: failed to match any schema with compatible: =
['maxim,max77705-battery']
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202412=
04-starqltechn_integration_upstream-v10-3-7de85e48e562@gmail.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.

Hmm, I added 'maxim,max77705-battery' in previous patch of the series:
https://lore.kernel.org/all/20241204-starqltechn_integration_upstream-v10-2=
-7de85e48e562@gmail.com/

Does your bot run checks patch-by-patch, not the whole series?

--=20
Best regards and thanks for review,
Dzmitry

