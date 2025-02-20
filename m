Return-Path: <linux-pm+bounces-22576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E2EA3E541
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1398A702CEF
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 19:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4171E231E;
	Thu, 20 Feb 2025 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTwJA5k0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A8B1B423B;
	Thu, 20 Feb 2025 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080713; cv=none; b=TxpMlSbR20bhmmpmiujOjVJkuSA6kkOYTVcgPzEPPEhvtj7lqHdu22HLlxvIxA/SBXq8vWmYcW3jAcgLzPX1kBsM3p73/zsVH1DTfXB7HHeHK421hQwZX3W1JUDgU8rbssgTma3iBydBQ5msS400p5FmyunMZPXuhmNje0QYKP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080713; c=relaxed/simple;
	bh=5w9ZPfM7baicd38+GAndxIdm7j14N21q7eKUF1uXANM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Img/2BeG2DQhzdmZwKRQZSJifuoVsQ5lowclPO9Rujh5u45kJ1onfNwGAdRCaTbr5AMBBVX56RyVBta0p1Eo7hT16lmIFg8cvjhsRpLEXeF/t4o2EhTNpVzW749BgVjmp4zDzMNvU36Q3mAGDW7YowgauucsrlZ3bS878GuvFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTwJA5k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AF9C4CEE3;
	Thu, 20 Feb 2025 19:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080713;
	bh=5w9ZPfM7baicd38+GAndxIdm7j14N21q7eKUF1uXANM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YTwJA5k0w+cLrj0HNpfOs1JUTvA6SauT6M1ZkqUw2YyMj8F0OpGnwiXyDj+qfEIl0
	 1DOUf8cvAAYsXKCUgst5gAimkaYaYbpX65uXA8bc/sLmVPzl/cXjgzy/eVXXm9TXSg
	 2iimhWmiIMe7XNyk2GAMTilu5u7KfWz9vSB+Rv0yhkQgKyMG81jH0uBp4D0dh9yJYP
	 cAcUW030Ng1dsBFzT4C+hXni5rCEORTVMvwrrj/qNwzirisvWTreoZW1NL60e941Vt
	 Zr17K8djWkCLm29wUPMVU0Y63PhggQMQwJxzRf8W+pvOyBxT7BF39Krd/zfNs7MeRL
	 dN73SgYBPYsvw==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2b8e2606a58so612045fac.0;
        Thu, 20 Feb 2025 11:45:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqwhjjf7EEmL8m7kszVY6x+yDBUVwgLPqBNmQ5LqQOmn5uO/2i8xTLixQKFSq5AnbUOtLApvWTZfsKXBk=@vger.kernel.org, AJvYcCV/VWnv0Mnfl7Lr93mu3tabW/pqpG6viSP5UravfFc3SaqZ9NxTEYcL5GPk0OgIzRBR6tlyMQ6/VMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Z1WBCH8TDJcIgJLSkQt9nTyxJNmnImo8lQParXlCFm8KIZ+i
	RW+O9m70h/6nw4jTiwUYivvMBzK4PkN/l/sj1KKYqFMVwSLeHDLP50lr1RXsx/akkJ8w+O1lsDk
	QN2y0N8Ah0rOiKNb425Zjye7OQw0=
X-Google-Smtp-Source: AGHT+IHeqxjwEu4AYptwD1++tf45lAZPuUZ54xSnYQv4HKcOnC+YKtRBjCgH7ba7P+4afva5Zse6yfqkJrz40QNGIrg=
X-Received: by 2002:a05:6870:8e16:b0:2ba:9b62:330d with SMTP id
 586e51a60fabf-2bd50fb8fcbmr229165fac.38.1740080712814; Thu, 20 Feb 2025
 11:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-fix-power-allocator-calc-v1-1-48b860291919@chromium.org>
In-Reply-To: <20250219-fix-power-allocator-calc-v1-1-48b860291919@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Feb 2025 20:45:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jSh=aOfP7BKTCSxnPGy-XKJKcHNw8bN5PXPH0LA0tAGg@mail.gmail.com>
X-Gm-Features: AWEUYZlPuKs8Aa3z6321uqgilvggm5XCrIPDQvEqYIr24lZnfObcveBkaIicNsI
Message-ID: <CAJZ5v0jSh=aOfP7BKTCSxnPGy-XKJKcHNw8bN5PXPH0LA0tAGg@mail.gmail.com>
Subject: Re: [PATCH] thermal: gov_power_allocator: Fix incorrect calculation
 in divvy_up_power
To: Yu-Che Cheng <giver@chromium.org>, Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 8:07=E2=80=AFAM Yu-Che Cheng <giver@chromium.org> w=
rote:
>
> divvy_up_power should use weighted_req_power instead of req_power to
> calculate the granted_power. Otherwise, the granted_power may be
> unexpected as the denominator total_req_power is weighted sum.

Yes, this is what's happening, to my eyes.

> This is a mistake during the previous refactor.
>
> Replace the req_power with weighted_req_power in divvy_up_power
> calculation.
>
> Fixes: 912e97c67cc3 ("thermal: gov_power_allocator: Move memory allocatio=
n out of throttle()")
> Signed-off-by: Yu-Che Cheng <giver@chromium.org>
> ---
>  drivers/thermal/gov_power_allocator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 3b644de3292e..3b626db55b2b 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -370,7 +370,7 @@ static void divvy_up_power(struct power_actor *power,=
 int num_actors,
>
>         for (i =3D 0; i < num_actors; i++) {
>                 struct power_actor *pa =3D &power[i];
> -               u64 req_range =3D (u64)pa->req_power * power_range;
> +               u64 req_range =3D (u64)pa->weighted_req_power * power_ran=
ge;
>
>                 pa->granted_power =3D DIV_ROUND_CLOSEST_ULL(req_range,
>                                                           total_req_power=
);
>
> ---

And the fix looks good to me.

Lukasz, any concerns?

