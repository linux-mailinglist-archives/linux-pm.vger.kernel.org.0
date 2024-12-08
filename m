Return-Path: <linux-pm+bounces-18762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 329C29E8501
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019AC1884B5D
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DA8145324;
	Sun,  8 Dec 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTd3aPuA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B4F13B7A1;
	Sun,  8 Dec 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733661434; cv=none; b=jmJ7/KT4VBVrphQKMqVNuvO1CTSrJO2YmdflvV9jZoTgafseRrEY+IRISYI313R4NJZMeaGfJf2ev0+jHSER3pDa+uE1lGpFAaCdydAmkHBzQ4oHS3QTB/eUFl0xnS6g8mp48nzQYhkAM8ASZ6q4ytJD4Ocl5tDAbKqnGBzNrdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733661434; c=relaxed/simple;
	bh=DmMoUIBrwMXZutmShh9Bgg9DdQdHmUc5FikzbPs4BQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pn+b/GGw/aXWBXGnqRiPbiWNZEPhXnoXYUlmiHYgh1djB4ReAbv/QiNYMqI66B+khODIEb3cdpEb4bzCbFwSWNxSiJOJJV7QoemFJC3/ljEgd6TzdpeI8yGQRBlTv7pNHqUv0ahjfPWh5LahYUlPFSrr+GH8+bFBg1hNnc2lzbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTd3aPuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53E1C4CEDF;
	Sun,  8 Dec 2024 12:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733661433;
	bh=DmMoUIBrwMXZutmShh9Bgg9DdQdHmUc5FikzbPs4BQo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FTd3aPuAAGDJ0M0CpvAHrUzrxiI5HSdYT6o9bn7lzks5QL7Ocw1NIVqjb40BVeRUG
	 T3/Ry9SAQtdjCXvLF0zBXUM6iJ6Fu1uxZ3BixC35ianVrg2OEcn/0UJEdcO24Z3gC6
	 E98sRBPsY0VAMi9q/69eepto/ALj9bJx4O4R2Qz69QLa/vWNr45THGf8aVdzUjPzwv
	 6wAdNgsqv+0m75sMJd+MyfytMYv0oRLhXr9b5pymcOlJn9bab2zOMcCIJynIY1clO8
	 AwkeVhde//DL7LYe5iRY28GTi+P4DOfDWjhdFHB5K86VXYjHNR6WkXmJQ72jhj3FVI
	 CXiwQTjfBJTuA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso2298163a12.3;
        Sun, 08 Dec 2024 04:37:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDhdn2SFJHiQ5Icq1K9nsSBJtQ+2oJkBq5o5P99yJlPqDuZBtoLCwPiuJft/EDw2rqIdv6FRyXm9xSIS4WMiU=@vger.kernel.org, AJvYcCXTJa1djDM9ZB4znuLVB8vhkvVPrJXtaC49VA3hknbfgob3SaWozO0R7f3WroQvbMu8pvO43buXcUFJC76H@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9gy3iw46Wg979JRQI7D3KUXvjdxQZnIlr2qhBTu83XcmxqaQ
	XwgfqEkYJ8qWkVr+qPzNjucYfunz9zme+MMhBiWv8zCGCuR9feveokYjSpUmGrnLwRteCLWZG05
	K7kn4Fh/OqqO2DMD/A5i+OHPwVIk=
X-Google-Smtp-Source: AGHT+IGZ1cfW6HylZROHWM5wryBiSSEJ8/qGwc7HNG9IdNJ6RXwiUEKdAUMu0osWRSOptwV3GKQ4WFRb3HYYYrSPze8=
X-Received: by 2002:a05:6402:1f4d:b0:5d2:723c:a57e with SMTP id
 4fb4d7f45d1cf-5d3be6b2d84mr10669410a12.16.1733661432747; Sun, 08 Dec 2024
 04:37:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f103384-376c-41f0-a35c-8ad98327d6cb@web.de>
In-Reply-To: <0f103384-376c-41f0-a35c-8ad98327d6cb@web.de>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sun, 8 Dec 2024 21:36:29 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3jRPZrepiS31GzXpr26xser9hdQmBcnXbsr1O7VoY0yA@mail.gmail.com>
Message-ID: <CAGTfZH3jRPZrepiS31GzXpr26xser9hdQmBcnXbsr1O7VoY0yA@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: event: Call of_node_put() only once in devfreq_event_get_edev_by_phandle()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Applied it. Thanks.

On Thu, Oct 3, 2024 at 6:15=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 3 Oct 2024 11:01:30 +0200
>
> An of_node_put(node) call was immediately used after a null pointer check
> for the local variable =E2=80=9Cedev=E2=80=9D at the end of this function=
 implementation.
> Thus call such a function only once instead directly before the check.
>
> This issue was transformed by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/devfreq/devfreq-event.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-ev=
ent.c
> index 3ebac2496679..70219099c604 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -244,13 +244,9 @@ struct devfreq_event_dev *devfreq_event_get_edev_by_=
phandle(struct device *dev,
>         edev =3D NULL;
>  out:
>         mutex_unlock(&devfreq_event_list_lock);
> -
> -       if (!edev) {
> -               of_node_put(node);
> -               return ERR_PTR(-ENODEV);
> -       }
> -
>         of_node_put(node);
> +       if (!edev)
> +               return ERR_PTR(-ENODEV);
>
>         return edev;
>  }
> --
> 2.46.1
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

