Return-Path: <linux-pm+bounces-33870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B67B44476
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 19:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191525A5BA7
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4264C31A548;
	Thu,  4 Sep 2025 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0U/RKLg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7033130DEB9;
	Thu,  4 Sep 2025 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007255; cv=none; b=QokNynjqkD9hEPlQh3G2/Ld5DDLOxV6n2JMia+fyEVvJ+KrmSfOYX7UoJyzE5rwFRxBfigoPYUSiatevmP3RFdq40Xs1pn9mVUo0E2ek+AkflAMRupPHWUbICXYeV24RJUY3sAynHDFsOWL1MoAxAkdiMV5ge7tUoghjNB8SkyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007255; c=relaxed/simple;
	bh=vg3wcZJSqg8X2qWxc+QQvGgnohKB6dM5FFkxClK79TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGaJhpmp5Zap/OeU3eLPTUx/IKcA4uK8Sjh0cBsZAv/lxmwP04lPPvhkrzj/9UzwfB1O5wOAVVVoOyQy9gCmZ8mR1sbroZgpn8tX5vBD7qYYMInpjC3fOViNKuODjHwknnJhOi7WNH/4dtgoa2aZU8yo5oDs2YBXRFdeAsLlscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0U/RKLg; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-336bbcebca9so10114011fa.1;
        Thu, 04 Sep 2025 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757007251; x=1757612051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uA9ux8UKonoPKigO5MQWrXEczFOUCm7WnSMHi2V7kOs=;
        b=G0U/RKLgxWuLTjvLEeCD5AHetL1Cac8tU0xcqpwpQ9NCzV6c1Ow1SF0v1fY32c7Zk+
         ze8SbaPVgPVQIfBVvhC4Tbp9bCZm/tz7enc5VvVecGhjTbATL2zeUo7tLa9V57L+axPn
         +O/Gq/ChSxH0Ddl562wmIZuH4A7GvVJyKQlVn4mfHWSuh9yKyh7nmlAdcLjAyfbyJpMO
         KlUo+SLcp6aRsZe2MSHx9udJfjYf7aM7LWSP2kqKyyUVRH5QoWm3Ya9zQKt/qd+WB8FG
         lLqvHq4ZQfJEnmGTbFAbotltFUnamR3151cV2x3gwc8HUu7+UGzN192TJjyMyzzXsM6y
         Uuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757007251; x=1757612051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uA9ux8UKonoPKigO5MQWrXEczFOUCm7WnSMHi2V7kOs=;
        b=ehalLz9JaxO4K7/n3jiRAzfcjg8VEMvjfKouQWuJr55FtDmheuGZpAbxOmDgoBtV1q
         goWnUcJfd04J6CXJO7MJyHcOJe2u0H9H+eSM2u+JNa/NO7i5zJG2MYIbCiZS3LK5ZIrU
         3iPkIwFJC1Z+tfIup3UEzF4vkPwdxz3rgQzI2jGHt57bxE0wxa+fesbSVqAixb7F8ZKN
         nH7PMimntheOwoFIWoz6F8BJMyPxfVf+K7KllkyPKEuBxw+HPO77EhRl4ISV8P07uYkb
         W+J802snSzZVz2L1vmiFHoTeqxz55i44NnMpAia4Ic3rEw8bRMKIud3vaxe+Hc51ytnh
         w8lg==
X-Forwarded-Encrypted: i=1; AJvYcCVHmbf4NKqvCXXVCOeguL778fvl971KnNmrLSOIivEFCnOqLkTYbszeXMfnvWD3iOx6bNOr/ch871DdIKU=@vger.kernel.org, AJvYcCVHzE1l27N9A9MXSUoCeK/xCDjJtp6hgDEyUPM7V3XpGNgM+ONBLk7Bm3R8c1hcuvrkD9EMDFKhwQ9dqQLS@vger.kernel.org, AJvYcCWBxNAE62OlFA2Za1afKrEnLM6JYdl3lg+TSD2wgXi0Kc0T0SpNBrxeBs9H8D0wFoqNKsammmK3gtU=@vger.kernel.org, AJvYcCWPWdj5+csAtEERXKThOwbNAcuK8hOmwWrTN/lf2jiB7SeT+usRjHzEUks7aF819wKdkx5xQXqLKNc2@vger.kernel.org
X-Gm-Message-State: AOJu0YxNonNcGGCYzQSyckI3F2tvZODKoUmHzwC1b0gAvUVIOBs06Mdk
	d3AYGZ5HwzvGvonRXpJcx5IjMCISqfx5dOdJs5+JoFHcGLYs+b1IgoYo8BrkbEmdamAMG1s9gYJ
	OVUBrJttJG2+FN2KbDR9VNOt6CI8gKxw=
X-Gm-Gg: ASbGncsIbrkE3RUF8dBXpJMKqtic8zU3DD0QMCz9iO4cZJeTmY0jQz6ny9+LWF/jyIv
	Hi5MMz75TpD7B7URqDxrEy82OPK+fx5SCuWvwpTQvu+cuY+7sXw4KySdsSGCnrEB5lyws/jF/w1
	Al8+VB0meUkIDr/2kymHpuwrFiliGGn8GymbxV71B4PEppis+1cPqA9kitjxcLF2KNleM5H0WQI
	UuSs4k=
X-Google-Smtp-Source: AGHT+IEVUJRpcbZwgED/QiP7FIenFSTN3uZTs7NjgqtHuy38aI9X4JtDL3vFRokSUUmmF9T4/tLnYXRgTCYRkt/EV0g=
X-Received: by 2002:a05:651c:2225:b0:338:d42:2a73 with SMTP id
 38308e7fff4ca-3380d422d6bmr16120741fa.45.1757007251199; Thu, 04 Sep 2025
 10:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
 <20250903-t210-actmon-v2-1-e0d534d4f8ea@gmail.com> <20250904-honest-accurate-bullfrog-fdeaf9@kuoka>
In-Reply-To: <20250904-honest-accurate-bullfrog-fdeaf9@kuoka>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 4 Sep 2025 12:33:59 -0500
X-Gm-Features: Ac12FXxwzZ9fRsiVjllICyBepKiyjgpVzqaz8XGelevmoho2Wvp1gIMAGVPYBqk
Message-ID: <CALHNRZ8DEYq-DOC6jV8TAqGznd8e2mzfS7Xs61Gp3R5visPFzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: memory: tegra210: Add memory client IDs
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 3:20=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Wed, Sep 03, 2025 at 02:50:07PM -0500, Aaron Kling wrote:
> > Each memory client has unique hardware ID, add these IDs.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  include/dt-bindings/memory/tegra210-mc.h | 58 ++++++++++++++++++++++++=
++++++++
> >  1 file changed, 58 insertions(+)
> >
> > diff --git a/include/dt-bindings/memory/tegra210-mc.h b/include/dt-bind=
ings/memory/tegra210-mc.h
> > index 5e082547f1794cba1f72872782e04d8747863b6d..48474942a000e049142014e=
3bcc132b88bf1a92d 100644
> > --- a/include/dt-bindings/memory/tegra210-mc.h
> > +++ b/include/dt-bindings/memory/tegra210-mc.h
> > @@ -75,4 +75,62 @@
> >  #define TEGRA210_MC_RESET_ETR                28
> >  #define TEGRA210_MC_RESET_TSECB              29
> >
> > +#define TEGRA210_MC_PTCR             0
>
> There is no driver user of this ABI, so does not look like a binding.
>
> You have entire commit msg to clarify such unusual things, like lack of
> users. Please use it.

The tegra210-mc driver has these hardcoded and should probably be
updated to use the bindings instead, but I think that's outside of the
scope of this series. I will clarify such in the updated message.

Aaron

