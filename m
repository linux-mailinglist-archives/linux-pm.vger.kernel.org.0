Return-Path: <linux-pm+bounces-19017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E76749ECCA5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 13:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068A5166E54
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428CC23FD1D;
	Wed, 11 Dec 2024 12:58:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF623FD20;
	Wed, 11 Dec 2024 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733921916; cv=none; b=fkFmL/TAsP1hA7N6hALnmf6cOi6cJ5qZZ5XJ6zZeS5DV79Vphc7GstpnekggrsM88p1cq4w6EwjSDI4BPt1fM9aKJKSbJzqVCQdjOtKcS6GEfsmq0EdYQUJczal79+480LWSEeEib/fMomQnDlgtU2X1IY1q1naCFch8+1CTg2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733921916; c=relaxed/simple;
	bh=CHvhYUrplQYCjCqh12LwDPbDEDEw7TRaZWWH2Cf2eTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4Up+9RqVDnrG27jctR+rWzX18Av8ae36MUjugmDlOwgUpV9/asS6c+Pm8fTUimcRpwE2bFOnz2DV1Ikoglb3L7RNRxO4dvFn5lfUQpvDE+kMF5pPt8Bc8LpJ2vS/lHU09YP69qhr7C2HZz3tbSNPBCtY5gJ52r1bwsBM11E2u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4afdf300d07so2413719137.3;
        Wed, 11 Dec 2024 04:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733921913; x=1734526713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0kebOaxINW2+VKaV8OUUSUgWCHZIAvgPcTYb8Tmx38=;
        b=uITi31w9kkY7iQvMEXfhMOwbH6yHvWW3lS1Vd1JGoe+2wTfal9K08aIc0ED1vqGers
         Y3cWF6cno+gxqFv/aJFk0L6S8LmK5jdhdFJ1fsmCJmkPhyeX/G/PwrNxVEN2+Au3ga/a
         IW9kz27oR5vU4LX8haMdmlK6sWQc7B8Ij60HzUTfC1AH2lqEQzK41sGko/KRulo4fF8p
         qh2CEHmQZ50xV50T5jXejexIZ0yGidwzUxmyQv0sMV7URmNkNINCoxAiFqqOeaExOO8s
         CSTvvYBLzI8n82J1hy6NXoLwv9x7vSa1xY20sJzxm+85k1tFH4nvpuyZK5jsFDyNFUSz
         EACQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNIzaFFDrPux8yn4oLtBVBNXGkFYdrlCCn67nJsjmoYnXezjekv8kpm7uJHYgh3ZknDsGhhJ7MXQ==@vger.kernel.org, AJvYcCWoRKcOmSQc9My8IAulz239phuRlZBQOTE5V4GiDSW7SQFcH+iZXYtw9LY1vDsNoS42kCydYl/6/8j4labWnnYtPpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcGvGE4v2O5gg/KPktDV+60uo/Z2lCpmH8fY9mYyuOJcd/tCOu
	e64UUCLyJf0Bedy2wnb8ZUve8JiNyFJ+AX951WCVFyYfg8x9P9bTs8Qnbqo9
X-Gm-Gg: ASbGncsZSxObRg4AD4n+OEp1DYylIfM7DRb6FLQY2t22Sr+KzXtnKiHRHqBNk19hp61
	9hkhAOr+VKt1GlDX0eDlG8xfSce/gL2xkn5TgrozaA+bWuKIEyRhOihtRqpaXW526HAOhRvLPai
	91y6lq/6K8DNaNQfVW0R2zyO4N59pNzs90vQSn3UfLiudQCOUVb3GjIOc2wBNqjwF9y85Al7fP2
	jIq764g0Y0TBTvbhl+/59TMNddLu3bWxBKg2c4dVecflA+lwKrMoy+DVN9lQW5zK0NX+Lj2gITo
	GlzXAsdjoCe+Oq/b
X-Google-Smtp-Source: AGHT+IGiK7d1ZGf7LHwK6VLa/eWLHxUDyMl2Rmyu6sNyDK6+Sl7B/4y/oJxBDqg6AoiUo1tDnb2Q3A==
X-Received: by 2002:a05:6102:5122:b0:4af:d66e:2fc7 with SMTP id ada2fe7eead31-4b128f485f4mr2588201137.6.1733921913247;
        Wed, 11 Dec 2024 04:58:33 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2b9669a5sm1689072241.3.2024.12.11.04.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 04:58:33 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4afed12283eso2240791137.1;
        Wed, 11 Dec 2024 04:58:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJSi4n85S/9oHRTFexVQTM0vqWeDPyc3yFjymll7AwSk/CKHx658L2YBKYfs/ABVTi3SsRMV52JM14JKgCDXKdHBI=@vger.kernel.org, AJvYcCWFINePSFvCaXBYg7eCfdbzK40ITLpU9iAahCkysvioBMfT3AnWXsqslG2zaKh4FdQNcGpn0r6UgA==@vger.kernel.org
X-Received: by 2002:a05:6102:3714:b0:4b1:1a9e:a0f1 with SMTP id
 ada2fe7eead31-4b1290e2880mr2202761137.22.1733921912852; Wed, 11 Dec 2024
 04:58:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206153050.3693454-1-niklas.soderlund+renesas@ragnatech.se> <20241206153050.3693454-3-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20241206153050.3693454-3-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Dec 2024 13:58:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVf5UK1GabnWe5pj_pVXyeX4U7JLEbvrm1yy4z1QhKk9Q@mail.gmail.com>
Message-ID: <CAMuHMdVf5UK1GabnWe5pj_pVXyeX4U7JLEbvrm1yy4z1QhKk9Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] thermal: rcar_gen3: Reuse logic to read fuses on
 Gen3 and Gen4
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 4:31=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The hardware calibration is fused on some, but not all, Gen3 and Gen4
> boards. The calibrations values are the same on both generations but
> located at different register offsets.
>
> Instead of having duplicated logic to read the and store the values
> create structure to hold the register parameters and have a common
> function do the reading.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
> * Changes since v2
> - Use a structure instead of two helper functions to store the
>   parameters.

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

