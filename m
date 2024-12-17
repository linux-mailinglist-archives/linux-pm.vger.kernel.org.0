Return-Path: <linux-pm+bounces-19374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3DF9F4D3B
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 15:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF357A3F99
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F141E1F5436;
	Tue, 17 Dec 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NheA4pr5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D61F5426
	for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444519; cv=none; b=VQRuD7KwO4Z+LI5QUS198NylLXzZ9QBkZAeJlnGSw3fWhj+gv2Qx4ZuArT8LMV91ufe+3/Hbuhw65GwSxfLOGxV9eINe5OeLoIZxqhEft9JLngecqRpvyRhsJ3JOzNSQfcTHobP2TB643gI157uBvFFYCFU0lNw4s1HyIriAkDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444519; c=relaxed/simple;
	bh=jGW0026BXd1vGApqNs0btmpVNZLakv19aMfi05Mi20M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXIHKUMbrle5px7AkIxK08/aOg3ZARX1KBuJV6Sf/taJO+KI673spb7yHxFYWgqh+LsW1xGyJ3zBFIoDf/lXlV1MkUb/Ls1CsjW8pUJiQWIQ9HTpX2RpfqzMq4kaLa87H81RokxrIAVWkn1H9Z/PWDenLv7W5CUq8wEU+qrFh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NheA4pr5; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-540215984f0so6011765e87.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2024 06:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734444516; x=1735049316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGW0026BXd1vGApqNs0btmpVNZLakv19aMfi05Mi20M=;
        b=NheA4pr58mOwLlDv/vwZFyo3Ke7+LnhGcin5OQ7zENaFrT4pMsenJ9pS22ReXgHkai
         FKsVtPYDI9X9ToPc4GWYRVEmJSiGHyRv9oNZrPGyfwFF7gZsMuZ4bB883GJajvh47WA2
         JUR68YcdaXTCEE/eNrkBy+BvCswRitzf2lJNFCz9+PSWWTaxiSGbgjLMJ7tIlIRTEE29
         FYnImos5ES4L/TUH3DU36hFwbpcx7jgXiKL+xOVNY9rP6d3AkXHY68FnuaDRmtSCMY7M
         /4MglcynYQoBQhpuuQV4vjZaMV2Li+OO/pkbP6A86jT7wOn7PK3mfLEb3LzG/8DguOp4
         L8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734444516; x=1735049316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGW0026BXd1vGApqNs0btmpVNZLakv19aMfi05Mi20M=;
        b=j07HdbCoja1HqfnWvQh1vZU/lxtGc0NyaifgHSr8pnSaRxMbUsFQ5tTHwobmna/f5M
         J1TKsr+/d56c29xJux9L7OA0DlvSyjychYnkJONVOEisHlKgbAxAxWQRxZlkDrlQpR2V
         1kKZIKkw4Jy8SOPNqcQS7Q1J4jHJ3ToWoQwCsqGkMHWYJNCRAx9kHcawqvIHONqKvr3L
         hqWjNqwCbPSoYSxcZf6PaaU4tE5u9m/+nFyfHBkczt2M05KDABMb6f5P7zIEhtkHgo5+
         kc0ubbzj8cX+9PTq/KhlWLiShKZ9j3EXZKJEpaiklAPaY+8DtX8gtuJbVIvXp9XuO5ts
         YXjw==
X-Forwarded-Encrypted: i=1; AJvYcCXrikcGIAZBKspmE+rVlmyA8HPR84PkuWIUroWqdNAE5VKIzi5DFernu1XS5LEypbIynX6JhTZMfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyjushu/tJgE2lXcI+is0DOoj546SJaHPfhTmQAe5Lbkph15E2
	WHJLqUi5hcr+uMNiS1sYcxcYDeYlvD0x1kKrq0pGZZq4wJZZjwzONL2X0IWxNwhJJkyw0abOI0d
	+f1+//HOxWiYQ9sv0ylwjAomfMjh2etJUlrV4Zg==
X-Gm-Gg: ASbGncu8s7Ekj8k40dLkEP5X5LQJ7zKJpWB3wY4b4+ArnFdr93umWXQpafdlEeYwpeX
	7m2xzbW+uGs75POkrgPfq2k1+Pp3GXvu73946vQ==
X-Google-Smtp-Source: AGHT+IEDzg/1QaAryu5mZq9zNVQFdPIn9J7cRI1WtaDrnft45JXUSlTsAmYaTbg81Eind0y2KWBppD7S2SK1pxKF98I=
X-Received: by 2002:a05:6512:238b:b0:53e:350a:7294 with SMTP id
 2adb3069b0e04-54090595736mr6147916e87.37.1734444516125; Tue, 17 Dec 2024
 06:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241208-power-supply-dev_to_psy-v1-0-f95de9117558@weissschuh.net>
 <20241208-power-supply-dev_to_psy-v1-10-f95de9117558@weissschuh.net>
In-Reply-To: <20241208-power-supply-dev_to_psy-v1-10-f95de9117558@weissschuh.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Dec 2024 15:08:24 +0100
Message-ID: <CACRpkdZczWm4Fu7sNbcCCz2Ef73zAuJTJe_=0U1hZuFsyXooyw@mail.gmail.com>
Subject: Re: [PATCH 10/14] power: supply: ab8500: use dev_to_psy()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Sebastian Reichel <sre@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 2:02=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:

> Use the new, explicit accessor to go from a 'struct device' to its
> 'struct power_supply'.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

