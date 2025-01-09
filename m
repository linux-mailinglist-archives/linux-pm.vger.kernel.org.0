Return-Path: <linux-pm+bounces-20159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E43A08036
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 19:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67001188AA39
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 18:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D1619995B;
	Thu,  9 Jan 2025 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKIvRaJm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6702BA2D
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448788; cv=none; b=jPPEtV/+XWjg7zYHLywSagV3/JAga0pjuuc5ydYZH/+q/1m44rqaCXiUfstjq0Z3+4HrffWRTAwoqMlt+/z5nDm8jGESlPDBpb7AtJ2/+RTrbUVdNgABgesZem/ASYfEPkcTeDssII0pB+/5yb6WD7zwv362GhcL2Bdr5g4C7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448788; c=relaxed/simple;
	bh=HEVauIBUbAHPe2xTbOddB06vXxQvUfwtd9qb3m9MPeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAPtzh5bAF9cxEIbgABbJcx4ey6CdMwx9AdUdLwdno4erRlGGwKBQ9d8sJFqpxVTo910uReHxsLhtfudvcTTuQ+/3OZGKIE700QCMNdI/BjIhSjaa7mQ6sLm6mf9d6HB+RPoGJS5OIhhC+KJrndXy2n1LRedkazIFyjWT8SnWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VKIvRaJm; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5401b7f7141so1109174e87.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 10:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736448785; x=1737053585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEVauIBUbAHPe2xTbOddB06vXxQvUfwtd9qb3m9MPeY=;
        b=VKIvRaJmYtqysv0fzIor48OQoAznFkiHIwdBh+JUfnByLWBwIkZVkmLj+IoIuYoXoI
         HEFwvzGNriA1jznXLN7oY+vS14rNyqRbYJEq/11/T55mF2t2yhvNgEcmVOqEdoAxGh/d
         gGIpspB05U+hYGnSoG6hq4BdfwQpY5z+xMT69CXRcTfhJG66DBKNmhSUJ8N4T3PeZDWG
         Pa3FzHXxJPWGHsXbBKVyrSArOuBs6smHrkWto7XAHmYOSsIhW+yVUj/2VqpLLUPhl9j/
         mMbAoKFI4V/T59I+5W8dA0lHNj8+41+We1C+itl6x30zCfvKpIg16C85TCM7/yR75ZsE
         gZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736448785; x=1737053585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEVauIBUbAHPe2xTbOddB06vXxQvUfwtd9qb3m9MPeY=;
        b=rTVrFkjJOmO3veA+odAlpVT/v18Ffv9pIWCHD9QooUOKEmysN/et2UUvh4Mp8aVgNn
         6Sabzq9Jy+hK3j2dsiIctQgzyZOp/3Pj1OVNc64KSUgcdc3CBVe/IEZ9hNSPT4J7hH/t
         lezWrTCs+o0uUjhBOMUEReSt7oYzrmvlcGFZi7stZ9gKM3pKCPq4G7KJbd9Xd4Quk2xx
         KkNaMiHgCpNn/zGPLRNx3jWQd52a7xH7r+RdEHj4xh9XvTQpPFyKZioG2ZYd94Otbk4c
         T+hbY/vLR05JvV2qxrah/4Y+rVqbZhW1RN/SQggVGWNmdwto2Cy3S3dhAJyMwQQP47mW
         v9Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXlLynoktcaWEMksOu7ZzBXe/T3iBIsnPOAXD2aMbC/+sAgPvFD9XUhFZ0erK6ya26Z5sLeUZhwPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWj6gcGwgPL8AIIH0OI7XRXGTS7e5KQrSV3e7YW5yLRU+JLC3V
	TcqmvQuMNXlBBL6oh/H7sFanEfCVHswSm4Gi0mJxk8DBDfo/qUquOKDDF0imvqX5ibUq26tVAF+
	oPv/eUoqGtxVGK9f8h+w5ZiKbpGzrDUviWtLknahVt6CJOkONYI7wGg==
X-Gm-Gg: ASbGnctag4xtEL3EuCNkCy797jACHK6CEyTBEq5zvnFwtxdmo7e9mmY/89EWV2brTSc
	hPdyvbtMoY/kq6SkV/eyUXLrZM2nb+/B64wsL
X-Google-Smtp-Source: AGHT+IE7veHQNkFPORVdkThutRDiuE2y8yym6VYMHN9Ecau3+8i90E5lHpNpB49qXiYl9dCzwMReqlWIf0Ft2OzTuVY=
X-Received: by 2002:a05:6512:4024:b0:540:3566:5760 with SMTP id
 2adb3069b0e04-542847f9ea2mr2520495e87.35.1736448784794; Thu, 09 Jan 2025
 10:53:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107113346.170612-1-hdegoede@redhat.com> <20250107113346.170612-5-hdegoede@redhat.com>
In-Reply-To: <20250107113346.170612-5-hdegoede@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 Jan 2025 19:52:53 +0100
X-Gm-Features: AbW1kvbsB9sgepDkumAnFwRKajWMNxfB0ImHrUrBJtn3-ch6U8pGnskNy283WRQ
Message-ID: <CACRpkdZnkxP5g3c35pMBBiH9No9yJCwerST_uMbg70FLe_f2TQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] power: supply: adc-battery-helper: Fix reporting
 capacity > 100%
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 12:34=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:

> The ocv_capacity_tbl[] to map the ocv voltage to capacity goes up to
> 4.3V for LiPo High Voltage (LiHV) cells.
>
> For non HV cells the code assumes that the estimated ocv value never
> comes above 4.2V, but there might be cases where it does go above
> 4.2V leading to adc_battery_helper_get_capacity() reporting a capacity
> above 100%.
>
> Do not use the table entries with a voltage above 4.2V for non HV cells
> to avoid this use.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I think if you use a struct power_supply_battery_ocv_table and the
interpolation helpers I'm pretty sure you get this bug fix for free.

Yours,
Linus Walleij

