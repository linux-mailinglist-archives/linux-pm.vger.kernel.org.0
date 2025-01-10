Return-Path: <linux-pm+bounces-20253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8446FA09691
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 17:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FFC165AB3
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612F1212B1A;
	Fri, 10 Jan 2025 16:00:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0EE212B0F;
	Fri, 10 Jan 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524818; cv=none; b=GICaSAmV6KsZOFLaNE8CIdUnSUchQR/KRzKbmLLq0flvsSizht6wyag5WG5iqYXG9nRC1BH/UuMTA3t6Q1RFy2/9TsAV/pa8mrLC+tDK0z/vUrqt64yf1/+wPmavoHaFntmQrnyjC5/VAYYIIwNCV74I0jVrXg3XGxPlBoxGIeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524818; c=relaxed/simple;
	bh=iVnoh5XxXBNvRf9VFz2lCK25OBZOXAulTqGhLM/TeG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnA2AqRBuKQQrbMhRqEuG7fIlF+s95EFvs6HCN1P7wEf6cIKkVHGT48jCZ6sv9RH/d0a5UCBaj3EsZQrml7ACdJY4eVjVOar4W6ndD+Iszrf7vrGGSO7Ibd2KTmnMiUJ8U0LSfrq8fxBWiaMcfjr5d1QGB0ENKJ/YLp+HCDU4+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-540201cfedbso2004241e87.3;
        Fri, 10 Jan 2025 08:00:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736524813; x=1737129613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xier1H0iRZQUKFRWlNiMydYcr5ZwkdaYGgLJSuP7jbw=;
        b=SP7f0e+2D/vDrqYwcrSGLA+174IMfo0K6K2/DG70OhYPe+JQKFV2c8t9SjX02LEBUP
         cq076FnnuBiCSHdyY3PpzTYJopsgZcSrqP1a5M/ybDDpDpsOXnbgKDQkvWfiwkeQNXKX
         fJd8D4z86F6vf/IMuOmaU+M6rrfIIierzeimSrhhcy2xPCSUZpbxeOZVuSjMtdapyKZp
         aHwabADH1ihlx1lVa5jbBuzt1WIEKbZwIoRWlVnb9lpuOnWGzxAQVae13p5HTw0KuXtT
         2fIBUQGaGe8DCfHY/1FotAGCnuFkHbaxhg90/Ph2kb79z6f9gzWGNJLATNWov+ke0bBt
         Di8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1i19vTnXEyfRATMWZ73iE8zoyXiRKndEW9SnsxKvZFk5LD0JuRgP63MmJLpcT5cKdM1+XP5I0NBCidnLY@vger.kernel.org, AJvYcCWyM4tFh0VlBYXIWCvLW5tSBviJKIQmhvYy8sxpAB8ZNRb3iC6ERQ9GrQSJO/TVYta65o11B0IEfPg=@vger.kernel.org, AJvYcCXcGnpJdKD4kP8a4gcv8qMIVm1i4x2Q+qt4Mqe+6l7QYB4dOYr8bvJYyrGMt5R3Yv97eGiOeOVrmpxW@vger.kernel.org
X-Gm-Message-State: AOJu0YwLtgGEgNmPGjg3w0dx3R6+xntlGEwvGDtxKFxvgu+2f4JGIA/Z
	kQqHL99m3nwKHTLm0HU1yF1AXQwD+IWz+4V1ZBEQ35HtMhsY5lFCtf+WBCR/
X-Gm-Gg: ASbGncsU+BhzotzFxH4iV+bA7O9liYRTK+OzMLv9qlcTvcmpZS/RN2xYa5iFcijMNSD
	KU344Ze0UA7gYCJv2cBBUXUFeIZXhllie8nHHjiJO+YT51bDxXSPgUmG07FGjR09espdT6AobTl
	Vn5Fwydl74vAyz9/8JntcNQg0cfWOLdP9mXYuWfKcgYeq7lHIhc0z3Cv8IrhyNzjEIlsDpzC/p7
	Sx9cj9Zbs974wWtV4zXpPYWQkrG5vUiF27F92oAnvkMBNGoRPm1VcZWCzArN+sclF2+SCNHpGN8
	4NZvE7GPJKL70w==
X-Google-Smtp-Source: AGHT+IFjZPj88on5ZUCpfj08JYr6RHeVrSjVgrDO8wv1n2c8oDuQwAGq4LKqnlyG5LjO25wBVFIsFg==
X-Received: by 2002:a05:6512:6c9:b0:53e:37e4:1457 with SMTP id 2adb3069b0e04-54284559defmr3796873e87.33.1736524813038;
        Fri, 10 Jan 2025 08:00:13 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428bea77ffsm560356e87.160.2025.01.10.08.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 08:00:12 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3003e203acaso17666361fa.1;
        Fri, 10 Jan 2025 08:00:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1yEEiHsuh93ofC28rAIHacIZvlXus/obaI+G1lOYAs2EIBse1j+VYbYX/SkFIST6RnELq43lqV4hU@vger.kernel.org, AJvYcCWSSZ+iM5kfAbhzIxjQ82aIb6sKCCd6WLWe7gc2xTN4pL8SPVIJlSGkQc9WmbkW6fGEnra9AbMj+OOJ5hhg@vger.kernel.org, AJvYcCXP0uJLZGa0dqWZG47kniGLEwowYmRtYAqma28CGBEBwKB4d8vbZeM6GpTezB1mamjGazD7Z+WF67A=@vger.kernel.org
X-Received: by 2002:a05:651c:19ac:b0:2ff:cfbb:c893 with SMTP id
 38308e7fff4ca-305f459ab20mr34723811fa.6.1736524810623; Fri, 10 Jan 2025
 08:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107131027.246608-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250107131027.246608-1-krzysztof.kozlowski@linaro.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 10 Jan 2025 23:59:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v64p9S+o7+97GqTHak1PuVR2AUo2H8BQmmcFgA7CSiFKtQ@mail.gmail.com>
X-Gm-Features: AbW1kvZjBbLkmy_SyJ-PR0LLBGaZFrw-ONgajjMHJLqhUh37HElpVRr_LdJUQeI
Message-ID: <CAGb2v64p9S+o7+97GqTHak1PuVR2AUo2H8BQmmcFgA7CSiFKtQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: Correct indentation and style in
 DTS example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 9:10=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
>
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 48 +++++++++----------

Acked-by: Chen-Yu Tsai <wens@csie.org>

