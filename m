Return-Path: <linux-pm+bounces-11778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D837943854
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 23:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249FC1F22635
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 21:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C131216CD3F;
	Wed, 31 Jul 2024 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKJW7soD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD4166308
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 21:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463016; cv=none; b=CD+zJHzcj9JgXWgpQHx+fUfk8UcBhgzL1iSUW/UT8nyyueYW2YK13aYVRblL/QnBJARRDBOxyQ/ggZourz/4bsHHnr0ScaqZ+0OtNIMLQXVW4aBQv9iEbhDsEqMxpLC+jmDsaUk5Z5o4hqLlEaPqFTfAa5Jj3Uths4qGEToJsUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463016; c=relaxed/simple;
	bh=cXsPzIMnBYFbWpD0A990EW8Nt5iOKxaRg4d5AY+77yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aO7lZgvcyjMDC7CEvpZuUsVp1FuKj5N8w/hBMh9/K/5wedo46ji2nWl5YO3Hx8/s1hW0m4fb+0sy4lRwxeb6A7HPxQ6Zh8i0SktSTfn//fWXhJ6mYiq0HKFvsAd/ne6dIJ7p00bBlLiiG9Qb0NYtkpl2ko8UGUUJlQJP/LiAmo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YKJW7soD; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6634f0afe05so53519157b3.0
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 14:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722463014; x=1723067814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXsPzIMnBYFbWpD0A990EW8Nt5iOKxaRg4d5AY+77yQ=;
        b=YKJW7soDJNsaYbCt/Xd5ysFcVt+H7DfswW445aKKyw3GoMImHzJHMIjAELcutDX+Dr
         sWqu5mRkBqutcssVmyW0EeJF6i1QvcdaZ8G1cjrZNC/E9cCHsv+4fDAsUzP95ipFo2+y
         /LJmBFrH4UrneCXWVjKcqsiH6m6vpcmiPRtYbkj7e6ofXOsr114ilF0wCiHfUNUrMB4n
         3L+kgINg3kwZPMBqaJAMUMUSiMhbMOYAJH75Ppo4c8yRU4SEHaCH73pG7YcfvMibLtSI
         X3fy/KaWY3UFrV4YbHnMpCHlZ+de09l0bSJOT297uLu4B+aBljaTFMsTWmIMrP3nwa3S
         H44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722463014; x=1723067814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXsPzIMnBYFbWpD0A990EW8Nt5iOKxaRg4d5AY+77yQ=;
        b=dpZsnoCARoB8+Yvx+Ki5CTqbfTE/VVMG5T+L9fYnCd0ikoepMGaaFGcjBNzCN7MWIo
         Fk+D82hCBAprqOc4cj7qTfcbxih1ah0xrpMhnX4/qj8lERHt4p2wWbeXm8GQfINuOaie
         D1zZlRahL9pLZgwBcAuOOHUZoLgr2ISyKjeWbw9MUiDSpr6y4uyyxJ3Rrrs6y//boMiy
         0wTqwn3ZgsqX/ABFOpsbiCgPWl/Ws6MUFZHwEnbTmBvG6WdUPCZZdrYqQPtWjP+rMKCA
         K54clMHWyEID4igaDJPWY9Krdn2+c46dt2lb+CezRDBMChe/CPhQSZlUMiLwnK/trRN/
         +iVA==
X-Forwarded-Encrypted: i=1; AJvYcCXkoDqODoVVV/rdkRI8edUpPWPJl/W8wDlLFlzKJnvD+aZrIouC8LDeJeDTI0mODYtgFHgj0XcQG0IETVTG8EIm/QJ7fyOq5H8=
X-Gm-Message-State: AOJu0Yyif0TKjRSAhL33wGaiflJxsMZpM0yb8t5GDfbWTSnH6L6rRH3W
	k5PTdsI8neFXkhc+c6ecH5Q6cKMO7kxQJliZNfJBd0EkWH5DwbdgYtXGStyvyXmv/O6sl97Cxtr
	dtzjvYDvZEzzpCZ+TyjNFjKaqzv4hj0zigQYZzqrnifga2IGqgmaZdg==
X-Google-Smtp-Source: AGHT+IEhllkbb8d88rX/PNnVUAXDMYaDCfgcN1jChWefJZEk1zg4xkCycJucKr7VsSwOKCXczbmQnMZH/Oduhi8rWRk=
X-Received: by 2002:a0d:f781:0:b0:62f:37c9:77bc with SMTP id
 00721157ae682-6874658d58dmr5252057b3.0.1722463014013; Wed, 31 Jul 2024
 14:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240731211456eucas1p1b15c30b57274ef5837b57e594d061f43@eucas1p1.samsung.com>
 <CAPLW+4=WsGikZ6qOi8dWg4wFsVbhp29cv=DKP06jc4TQn=yUeQ@mail.gmail.com> <20240731211444.59315-1-m.majewski2@samsung.com>
In-Reply-To: <20240731211444.59315-1-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 31 Jul 2024 16:56:42 -0500
Message-ID: <CAPLW+4k-K8xCcHzZ77=diLGJyw2SKQMGzYAywEKwhxAtJaDZ7A@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] dt-bindings: thermal: samsung,exynos: remove
 outdated information on trip point count
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Anand Moon <linux.amoon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 4:14=E2=80=AFPM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> > Do I understand it correctly that the patch actually removes an
> > outdated description of *driver* implementation, and not outdated
> > hardware description?
>
> Correct.
>
> > If so, then maybe it makes sense to rework the
> > patch title and commit message in a way Rob suggests. I.e. rather than
> > stating that the patch removes an outdated information, instead
> > mention it removes *software* (driver) description which was
> > incorrectly added earlier. Because bindings are only meant for
> > hardware description and should be completely independent of driver's
> > side of things. Also in that case it probably doesn't make much sense
> > referencing that commit for using set_trips ops. Just my two cents.
>
> Makes sense, what do you think about this?
>
> dt-bindings: thermal: samsung,exynos: remove driver-specific information
>
> The number of supported trip points was only limited by the driver
> implementation at the time, which mapped each trip point defined in the
> devicetree source file to a hardware trip point. An implementation that
> does not have this limitation is possible; indeed, that is how the
> driver works currently. Therefore, this information should be removed
> from the bindings description, which are meant to be independent from
> the details of the driver implementation.

Looks good to me. But you already have my R-b tag :) More important if
it's ok with Rob.

