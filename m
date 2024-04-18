Return-Path: <linux-pm+bounces-6645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7428A962D
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 11:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62EF283BF5
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92F215ADBB;
	Thu, 18 Apr 2024 09:27:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3349E1CA92;
	Thu, 18 Apr 2024 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432436; cv=none; b=DvqPVgaP2k01Adz9ES5JWVz6vpiczxQ8yMD3YScflnf/xF8cF2A6wpJKf8nYGFdQRuI6Z/Rq0ftO5ELwIp8ECJ2VneekPkJjI3GRyEVexsz/iNDEjVssGeh7nvoI3W0lety+7X27DnUu8QqQl3LQq8Pg6cU5CfEvaF8MbTOV5oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432436; c=relaxed/simple;
	bh=hqxluRsi3qaCAmHk6Qx6Senn1Pgk/ulJLCDIeSKH/Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVSm3Szt/W6AcPLPA7BuQ4x7JDwjxxiu9oLtxVFAmuWGSkXJ8+qixHiIrqdDxcLS2ttGp69I0gv93bQwTIkYV+kAu/7XrdzyhaVpyGR1NW7zZcXA/u2zYsaGUauDmzMy0rZ/DNBoYEWgxwkZAm3Q8Kn77b8VymMcsen9nbw6KL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de466c64161so474064276.3;
        Thu, 18 Apr 2024 02:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713432434; x=1714037234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CP6t4OVSGkEimMqG3qVA2gUXQRTEs1wglu72p8zwBo=;
        b=evP5o4UnVmJ+ATIFgQR1S5zwekNo6+t0Oz02GgUN7qjloWzMeKViWiSnKTqVn63rOS
         3wYhpOqo/78NP7MVgcuNnyOmMyTG05sXeLmkyR2uYLORaFV/zD00/hOMeurWqZVZY2w5
         VxjRNfoSc2AKouzf8m0v3+9eQWh+COU7lTBq7CudsAdyY9v3Tl2ZrEB6Kg/k0dLHSRCz
         dDqMOkj2dD1+OwdU7E72VKFjpDfLZFrpFH/Rs/OrHXOaaHGaDiC8i65ulv5OJFOIgPqg
         pNVOo/h0uew7JL79qe8tJDfKSKtp04m9IOnrGxtmTiWkGc1PvLxn0O7ySoiOImBoY7Rv
         KGUg==
X-Forwarded-Encrypted: i=1; AJvYcCVsPAGes8Nlfkp8lwFd8Sy9LBRoi9Vn6synm4f3SHexWoGjf489Sdb6D1kvG+G1IqWB3XwU0YcfFTIpTDpJgqD9AYJty4e77sNnifhHTOsT3sXz0YCJdNIn27KHwyMzhNdMELhm8tq7EzBzOQ==
X-Gm-Message-State: AOJu0YyaFpCjKVi7O4UVtvDhMEZglrz1OafsA/u1ezF8SlayX7q4MRXl
	rqKH7sdnfPBYBWShhUGeymGHvqIqjMcke6fD2g0XhlYoBIT0RwJZ4k2mchVdViY=
X-Google-Smtp-Source: AGHT+IGLuKOUttzZ/G/LKyb7veKXegKYBbCLNdNmzAg4urDzc7/bd4VCR4cLp1/10th+j3Kmi1Uvvg==
X-Received: by 2002:a25:c70e:0:b0:dcc:76a0:503b with SMTP id w14-20020a25c70e000000b00dcc76a0503bmr2240532ybe.13.1713432433776;
        Thu, 18 Apr 2024 02:27:13 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id cj15-20020a056902188f00b00de3cb766aecsm272302ybb.54.2024.04.18.02.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:27:13 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de466c64161so474051276.3;
        Thu, 18 Apr 2024 02:27:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCOxa/RX0TdM9w9gom3Z8akVO/ank8hzHKU383becOA1xPKImJkY1UDKomco7ffsrPdTY31J+gbmrf2IDMdlbpKZdY2klf2q2v3uskkmDG9qBvCKpeInsatPy1o05/3As8gBFEGsf8Pi5SyQ==
X-Received: by 2002:a25:8e0b:0:b0:dcd:59e4:620c with SMTP id
 p11-20020a258e0b000000b00dcd59e4620cmr2203016ybl.49.1713432433247; Thu, 18
 Apr 2024 02:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327133013.3982199-1-niklas.soderlund+renesas@ragnatech.se> <20240327133013.3982199-2-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20240327133013.3982199-2-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Apr 2024 11:27:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVW1a2OUs8At3549QvK1LOGstSd_EjzXbjW+4qQwq8YQA@mail.gmail.com>
Message-ID: <CAMuHMdVW1a2OUs8At3549QvK1LOGstSd_EjzXbjW+4qQwq8YQA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal: rcar_gen3: Move Tj_T storage to shared
 private data
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 2:30=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The calculated Tj_T constant is calculated from the PTAT data either
> read from the first TSC zone on the device if calibration data is fused,
> or from fallback values in the driver itself. The value calculated is
> shared among all TSC zones.
>
> Move the Tj_T constant to the shared private data structure instead of
> duplicating it in each TSC private data. This requires adding a pointer
> to the shared data to the TSC private data structure. This back pointer
> make it easier to further rework the temperature conversion logic.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
> * Changes since v1
> - Insert tj_t member in struct rcar_gen3_thermal_priv in reverse
>   Christmas-tree ordering.
> - Only calculate Tj_T once, instead of once for each TSC zone.
> - Fix misspelling in commit message.

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

