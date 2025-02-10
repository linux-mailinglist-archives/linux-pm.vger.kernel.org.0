Return-Path: <linux-pm+bounces-21650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07EDA2E533
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 08:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52C41884C43
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 07:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87361ACEAB;
	Mon, 10 Feb 2025 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY6nSKwn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C69130E58;
	Mon, 10 Feb 2025 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739171519; cv=none; b=W5H4CUXkddXNdenS/Wqn2n7irjQ6nj8GkJ+Bg3ialRpqWMU+xYVYNozs+cMe5wvv7PBSFOp5ftDIrzH8yt9vR5W8ct1UF4BxbDQbMSEL4lPkJaOYO8cAviWGHGZFrSXpvIlkBMo9upVvfiDW6iAkOC3ggjjAtB3KgCMMVxugQRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739171519; c=relaxed/simple;
	bh=H3GEoIqEgWbPMNxEhTrT/w4m5WQ5UgLYo290XO3njYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuU9bEi3/TItaI8uH2UQ/WktjC4nj48XSudo+7deu/iI/9d43c8fn993LslF/+2K0EHYei55ajRmumv7xfx4nbYhOyso7Ksmv/ASuB6Mht9EA5LD5EDLXMjDss5pVuu/ItKOjzDmQuHN/YwXFDwjFRkoWOl9k+1RVDClVXo+ATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cY6nSKwn; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4bb0e7e6cceso235901137.1;
        Sun, 09 Feb 2025 23:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739171517; x=1739776317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9v7M60N7k/hqWmhBY/iyMoBnIb4DpUfGV8sZCADpqE=;
        b=cY6nSKwnYoRfGTLq/4AzMbf6Y75LrhqKUK24p2SeXmNOgzhVj+uzOJSqNj/Isuc9ov
         RU1wRgVpPEdk9STynOkrvIArZzcrPW6HyXfKP0NF3vuqsVGS39BuXNF0WNnE/wTzItAS
         qJZA5icJlAIW3mNdF+cTwIrwCzaLaqs+IR1THzxXGTqycl1YTNsrORC6JuQWD5NFdnqX
         Z9eg4GkmTGi/ArP3Np60/MKeMDXw/jN7V33MBl2rsUYsMgdkedZp1uuxceWpGi2PTykT
         rE0XxRs5oV4Via1lxt1VjfqcFvPiY1LQrt9mYz1zBgeKpdiGl3JMLgvuCScuW2dlHkOm
         fRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739171517; x=1739776317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9v7M60N7k/hqWmhBY/iyMoBnIb4DpUfGV8sZCADpqE=;
        b=uW3LEwddByb9YbHWNk/81BJEKTmYSavAw/Cb0y8jWpY/3TBgEmOAMyZ6sew27q2Zit
         umyw8+X6UqjkpvUaAZMryJXqwD+ENaxYbFLpB7cqnRSvvjdfT4ykGX7cLokipWgFBydL
         CEMcnXCc7+Ma3fw1KtIn0MShyl2mfQGcF7flx0EMxWRpWUA3kJpeiQRE2nZ92Auw23Ro
         DbzUUXHvHWx9ekhvf5n6aTIL58MiF4iZz193jiQ21M6W00Yix61avu2xBJ7QTXyeoJgj
         g7ghCuq5eR9O2QNY3PmLtvBgW1r7wTypIeMCrCqNyIuOSDh6MGDsn24wkHDoRGfBDVSb
         EMkw==
X-Forwarded-Encrypted: i=1; AJvYcCUeabvITNpYBYGBiWiTUmGC5XRdR+S96sUIhR5HukRhpoYt/N2Zu6mOor2v6DfI9LpBAEFuqqmFqNg=@vger.kernel.org, AJvYcCUwky0kPj6aEhj9+Si8StrFbJOgsdHCF/uACsdR39qFK/2OEpO+oxJ76/BG0mn0Rrvyd3rcD9QLsHRQU3uk@vger.kernel.org, AJvYcCV07yvPngT5zj9KUB4LVUXUnuoKIUFgIHziZdV4jm9ZphtiWK7pqwjqlKtljNeA9r1AQUiUnvFPKGfY@vger.kernel.org, AJvYcCWavdpPlP98FkhtKssZGKBL/4LLaAL7JWRxJPM9m/dHXlNNbmzNzVP5RFP5u+fxTX7vZXKP9lAMpUgffrY=@vger.kernel.org, AJvYcCXPfhmqEuov6RjQLQWtoOVV0clX0ZtfNC5f0PnEBIgKAtFLYCinZ7fYRV98h3qzQF2NNnA2nlMT/1m1/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEnX/K3ZWWE6UQHURnWS7qaDZhPI0jKl9GlnT9miIaALcQBnhq
	DfT5OgSQ40TzsNfFyq9OtQwFN9E43RN0heG49TM7YV/TlE4jA7d3eX/Y4SAVOQq2fOaiePf4HWn
	/qAou6vNlnbtSmGLu8Q/KTp6wkwQ=
X-Gm-Gg: ASbGncsx57HvsOthy/SLBbdI/9rqIv+YL/HStsWPdF3WvAN3jFhSvSdBEWVsT78WSGm
	04fn7jLJ/X4+/TAsjlwxh5Dpa9vJz1cQJFey1Pyaqf20a3sSjE5RgcvS0URbOKbEJHPGIbqk=
X-Google-Smtp-Source: AGHT+IHL5q/jtji7+1Vd8bARh6p5DubUkwFmeTKo/+J2lD9ripmH8UXPhv8PlDl44fvPDSEJKmEQwMdR0u0m9ooKraQ=
X-Received: by 2002:a05:6102:304a:b0:4bb:5d61:1288 with SMTP id
 ada2fe7eead31-4bb5d611a73mr2792124137.23.1739171516931; Sun, 09 Feb 2025
 23:11:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABTCjFBx-QpCKFWs5MPCgLAjJWT6ygrvS_A0nJk2BBxmWAxF+Q@mail.gmail.com>
 <e67c0375-1024-483b-aabf-6a11339ab9af@linaro.org>
In-Reply-To: <e67c0375-1024-483b-aabf-6a11339ab9af@linaro.org>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 10 Feb 2025 10:11:45 +0300
X-Gm-Features: AWEUYZk6CIEra92QKBlWA-4eq8zR0aFX3oxFj_GszgMw82sXZR5leVvr7QeEdtw
Message-ID: <CABTCjFBvYkEG0WYhCt6tP_cO8Ct82t0=UhwBefZEJrUiFc7vAw@mail.gmail.com>
Subject: Re: Patchset status - 'Add support for Maxim Integrated MAX77705 PMIC'
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=81, 9 =D1=84=D0=B5=D0=B2=D1=80. 2025=E2=80=AF=D0=B3. =D0=B2 22:38=
, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org>:
>
> On 09/02/2025 15:13, Dzmitry Sankouski wrote:
> > For the patchset I sent 2 weeks ago, [patchwork][1] shows status
> > 'Handled Elsewhere, archived'. Is anything blocking it?
> >
> > [1]: https://patchwork.kernel.org/project/linux-pm/list/?series=3D92784=
8&archive=3Dboth&state=3D*
>
> That's PM patchwork, not necessarily power supply. But anyway, what does
> the cover letter say? Who do you expect to merge it? Above link does not
> provide cover letter, unfortunately.
>

I didn't found anything related to power supply in the list of mail lists a=
t
https://subspace.kernel.org/vger.kernel.org.html.

However I found my series in linux-input with New status.

Here is my cover letter:
https://lore.kernel.org/all/20250123-starqltechn_integration_upstream-v17-0=
-8b06685b6612@gmail.com/

I guess I would expect a person from the MAINTAINERS list to merge it?  In =
that
case it would be Chanwoo Choi <cw00.choi@samsung.com> and
Krzysztof Kozlowski <krzk@kernel.org> from
MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BOARDS entry.

--=20

Best regards,
Dzmitry

