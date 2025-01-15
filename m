Return-Path: <linux-pm+bounces-20459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9E8A11B47
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 08:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DBA8168C9C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 07:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7981FE44E;
	Wed, 15 Jan 2025 07:51:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698F54C98;
	Wed, 15 Jan 2025 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927512; cv=none; b=uzrgdlPGr2+RxlCSYaw8/nvTJCeXyk3ZfqXZhxSR/0n5jKM0OfbQ+bzqZr+vGQPOkKpbTvyfZZRVLnUB5av9u/8poD5JrfnOIYu2W96ukiQJ5QdQ+JHoQ/+mjMDP8Jv/api6lU5zF/EwUeybVntPaLTSSICoH+aRQg+QbhDg25Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927512; c=relaxed/simple;
	bh=LbKhxV0/r07qM9Vw/kqAG+A+XvKRovlRRrwm1NT4erE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9FI6nJI3xwHolSt1N1iHC8mqr5WsaYQ9S/BIuReMnBIu2VQuMntqqOd++fgK3AAKaxmA47rqRxkL154o3+xayPbWe5e48SPPbUQzzUYdL89e207yT7mkOt93XHNUM52htAWkSrXsrsHs6x6ys7AwQXCAxqm3B2bUAAZ2cSOgBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4aff5b3845eso2570121137.2;
        Tue, 14 Jan 2025 23:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736927509; x=1737532309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v19hfaaGbXr2BhC980RfNTWymFHwvdpU89uVG63T0wg=;
        b=MK+Ig8pXH9i2Kobhr1yKy/eoqmixjbshMgUpBiZqAMPcqqLXANqtqjX2pCUg0drIdf
         jj/aaOgXARtr8G9zf8a9I3HYLYOsn72sH1HC+RUzJ5du1QfYwYwc4DW4PDjH5c6D5WyO
         6c27oYSl1sNCWdNMZjemz96KCFANIRyj0QLYqK70EiGHjISCTcRV1wQ9pQbq77Si/OzP
         hxiZ10nNWZ6On7teY25CzrkML68xHnJ7OE1vHyPt/B02BU1fay4sDks59oSUouLxy9Vx
         HV0MpRFuzp3wwxRW7Xfg8+2kohwM74OBGArk9hwoLMRKjaDYgPQMT5sVxpbfhVnvM6+P
         SksA==
X-Forwarded-Encrypted: i=1; AJvYcCUW+11owdho3jn0vm9UJnDE5i+Sfow+Tqme/r0McPTp3WxFkH2ueFLCibA25zv9TOzV6672FHx7DBc=@vger.kernel.org, AJvYcCUh2qkU3scmEhqEF7+mTMp+O9hfYcesgO67wNrTgGVRfJDdGWJ+vAFmEvIiM4kxZPEs0ZAfxhmAgHzMh4wtYOoZzT0=@vger.kernel.org, AJvYcCUigjOFS7X/rDq8Q/qXpN6657FG1c0KJ7CoUAhET9OjdF+nJ//QarI54OyTziqRt7dwDzaDvIbvTQUX8qk=@vger.kernel.org, AJvYcCWcO/KKOipAM8HK+K5St40ing7jUp3TaUyAzP5VZmoPmnhDXRmaaTIoTa26djCm50G7hflnYs2N/bFI0TnUlrgYzI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE7vNpqXO3H8VYkRrimMRLhy48qRK0MFMWVHov1ezIwPBKr3fS
	tGE7SATCnqaRSdnOQ1RGHMNmb3GLiUf/0fYtXo5+sNBeKR3eqhKyJV8ADPhQ
X-Gm-Gg: ASbGncvO6bWLFsBWLSziSw2+OWZWipCHNQDks1Huoo4kxQNxdFgnEJh9v95CK4RfJTL
	WKAwgpLRhubI+Mdh+3PSHU0+2F2S6Wu7OOujqJOEAqEPLoVEsho+M/jImgLQUs42V/pi+dL0MHQ
	9T3oZGPTs76BclMmRbPlk6b0zJqnF220Z7ctDCKeHzzEhnqe1c0ktkw37BSaYXNXowljvqJPOTL
	Xk758p3Q63EaOuGQE/2VUdReA/abkOKdkC2la9sWU+Ftsac7+xKIjYDnsM7Dm8tPrRXlvwN8ULp
	t/8denPmJxEkrJXJOQFuQe4=
X-Google-Smtp-Source: AGHT+IERRrS66Au7CMHK4jc7gP9Kw5SC+UMByBeA+YrBJrOOhf/KEFG0n79T2LLpcX/E0uHCqxdMmA==
X-Received: by 2002:a05:6102:a4e:b0:4b2:4cb0:91d5 with SMTP id ada2fe7eead31-4b3d0fc4fdbmr24825576137.15.1736927508920;
        Tue, 14 Jan 2025 23:51:48 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8623138586csm5661084241.21.2025.01.14.23.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 23:51:48 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-51878cf85a7so2093792e0c.0;
        Tue, 14 Jan 2025 23:51:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0iWGK7vBtTGH0VIcFphK78+LVWJVpAVYEN1Y5VexPMkhV1Mjk98wdEXRn0QVo2kMz+683w40X7evRmrQnb0tng7M=@vger.kernel.org, AJvYcCWIo4Oi7LOiOG8dKMOEN/CIwCN/zd6PkfXojP+OuUhS42JFyT5v7RHFnU3EslOSq2u09/2Fu+Ditws=@vger.kernel.org, AJvYcCWTaIZD/kUL/m7O8MexFMlAUvjIhnSxbIAB3S9ddqb6pW8wp9cf4KJaPo4JzSRprQLccjSWA/4tc9APGeU=@vger.kernel.org, AJvYcCXiSkGWhG0Tr+eNvEMZDE8TnBrJRdVPAT6SZr+86lJfAgZ3b2eEo3L1KD8AeKNBn0kz7i5bdoIG+Prcomvo9OcpkPg=@vger.kernel.org
X-Received: by 2002:a05:6102:370f:b0:4b2:5d10:29db with SMTP id
 ada2fe7eead31-4b3d0f91911mr23485805137.7.1736927508552; Tue, 14 Jan 2025
 23:51:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114203547.1013010-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250114203547.1013010-1-krzysztof.kozlowski@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jan 2025 08:51:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJ57mATWW4AnBedn+D7TQ4PadkJ642daquFtAo=wZFrQ@mail.gmail.com>
X-Gm-Features: AbW1kvbcwUXYFrN99m6XF1ITw2HmayWy5F5ubOu4slBH-XfFluPqW85u6cmBtL8
Message-ID: <CAMuHMdXJ57mATWW4AnBedn+D7TQ4PadkJ642daquFtAo=wZFrQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: Use str_enable_disable-like helpers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Walker Chen <walker.chen@starfivetech.com>, 
	Changhuang Liang <changhuang.liang@starfivetech.com>, linux-renesas-soc@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 9:36=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

