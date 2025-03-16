Return-Path: <linux-pm+bounces-24119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B145EA6356D
	for <lists+linux-pm@lfdr.de>; Sun, 16 Mar 2025 12:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2D43AB75F
	for <lists+linux-pm@lfdr.de>; Sun, 16 Mar 2025 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A4D1A0BFA;
	Sun, 16 Mar 2025 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="TX46hhwm"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314F320311;
	Sun, 16 Mar 2025 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742125257; cv=none; b=HOnIQIS0jJE0G2y1zBiL1kW1eMSacLjVbxSa23aKVw1XdiEyD2ti9c72Dc7pexzkcJlU9XHytyKW9lQ39X6gQ0F6S8SmJix+7+iGNGP7D1m+L+fXSp6QBGLKOzjmz8Ermw+VYUHA+NIWgQmsPNJc4trXT6+C0GC3Br/dHhBPIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742125257; c=relaxed/simple;
	bh=i+6HoquRiLWr0sO3yfdjpo1aNrtmauC4Zz6XOb47INY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVcIdmiJYpYNnygScqbeci3bWqj3EPEgnfroGDaD2DZJsIWAVdYtljIV9F9q5Xd3m+ezaaEca4czVK7rpjD7GB8GoyCDQcYD6Mv9quKlR+QDc26180gPCoc4xYqhBnTjvMlqrhBh6qLrce7f/tEuesoQH+XuYJELT8Hfzk94iD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=TX46hhwm; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 68F922E08C68;
	Sun, 16 Mar 2025 13:40:43 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742125244;
	bh=BGHr1/4aATDr1mD8uyz2Fhbm5tPYXu0tVOldrpJ8cWo=;
	h=Received:From:Subject:To;
	b=TX46hhwm7BtnUe2JJ552LFxyjP37qpfUqG4JbYIzX4yntZvAceCOu+YLiPE5CZtmC
	 wOWg1iuTea0K2EuVSi74KxgfHpLUk0THPEVNTS8dUX2RCEPbL1Vm0pebCafqPfVF6x
	 J2xbSEvSqa2WRLBSduGVc3OwjQ+Fzu92b1xWJgJk=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.177) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f177.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-30bf3f3539dso35670681fa.1;
        Sun, 16 Mar 2025 04:40:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU4dmNdftnq9kSRlUjJVBHW5wy1/afrJwOGL9U9UTuwaK0ek38mpZELiirgpG4pFZXCTTq3nQTor9E=@vger.kernel.org,
 AJvYcCWNenx2CMvQIuVWvw+S+9YruumgIm79JFbwmPlQMqZxpJspVpJC4iZSQKvWaoFZItFStldW7J5db74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvdb0nyqthFuhhfyi41cevdDu6RadXovYpc16hoz3rxUIAdBS
	wtJvdH0Wr2urVV4I2YXzisk66ZUcDcmBeJ7c6+PNKtAlpv1Nfj9aSYLBduU7JtK9kszztUJEBJJ
	BrLyIxvc92Uzzd+T5wK6KbqE0PhA=
X-Google-Smtp-Source: 
 AGHT+IHl5GkEAYqN3zNvvmgbMMk4DsiUwZxs+6BARkR8jqA/ebo/rfPt4v14pRse6wK+wD6yfRh5DRehzizRymAyk98=
X-Received: by 2002:a2e:bea3:0:b0:30c:799:8418 with SMTP id
 38308e7fff4ca-30c4aa76ee8mr37400751fa.4.1742125242611; Sun, 16 Mar 2025
 04:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311165406.331046-1-lkml@antheas.dev>
 <20250311165406.331046-6-lkml@antheas.dev>
In-Reply-To: <20250311165406.331046-6-lkml@antheas.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 16 Mar 2025 12:40:31 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwELmp7v_46wmo_bbORWMEeA-NWRjXeRML4Jd=p=huLNaw@mail.gmail.com>
X-Gm-Features: AQ5f1JrufAoSFAcwKpp0MKevZu5L5NV33r0LZSt3sZsJsqHAdj8y0B-Mf1--Ka8
Message-ID: 
 <CAGwozwELmp7v_46wmo_bbORWMEeA-NWRjXeRML4Jd=p=huLNaw@mail.gmail.com>
Subject: Re: [PATCH v4 05/13] power: supply: add inhibit-charge-s0 to
 charge_behaviour
To: platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174212524391.3504.18369951178983920859@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 11 Mar 2025 at 17:54, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> OneXPlayer devices have a charge bypass feature
> that allows the user to select between it being
> active always or only when the device is on.
>
> Therefore, add attribute inhibit-charge-s0 to
> charge_behaviour to allow the user to select
> that bypass should only be on when the device is
> in the s0 state.
>
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 11 ++++++-----
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  drivers/power/supply/test_power.c           |  1 +
>  include/linux/power_supply.h                |  1 +
>  4 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 2a5c1a09a28f..4a187ca11f92 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -508,11 +508,12 @@ Description:
>                 Access: Read, Write
>
>                 Valid values:
> -                       ================ ====================================
> -                       auto:            Charge normally, respect thresholds
> -                       inhibit-charge:  Do not charge while AC is attached
> -                       force-discharge: Force discharge while AC is attached
> -                       ================ ====================================
> +                       ================== =====================================
> +                       auto:              Charge normally, respect thresholds
> +                       inhibit-charge:    Do not charge while AC is attached
> +                       inhibit-charge-s0: same as inhibit-charge but only in S0
> +                       force-discharge:   Force discharge while AC is attached
> +                       ================== =====================================
>
>  What:          /sys/class/power_supply/<supply_name>/technology
>  Date:          May 2007
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index edb058c19c9c..1a98fc26ce96 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -140,6 +140,7 @@ static const char * const POWER_SUPPLY_SCOPE_TEXT[] = {
>  static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] = {
>         [POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO]            = "auto",
>         [POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE]  = "inhibit-charge",
> +       [POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0]       = "inhibit-charge-s0",
>         [POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE] = "force-discharge",
>  };
>
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
> index 2a975a110f48..4bc5ab84a9d6 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -214,6 +214,7 @@ static const struct power_supply_desc test_power_desc[] = {
>                 .property_is_writeable = test_power_battery_property_is_writeable,
>                 .charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
>                                    | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)
> +                                  | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0)
>                                    | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE),
>         },
>         [TEST_USB] = {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 6ed53b292162..b1ca5e148759 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -212,6 +212,7 @@ enum power_supply_usb_type {
>  enum power_supply_charge_behaviour {
>         POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO = 0,
>         POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE,
> +       POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0,
>         POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE,
>  };
>
> --
> 2.48.1
>

Hi Guenter,
I think I need an ack here, and then someone from platform-x86 to
triage the series.

Do I need to cc anyone extra?

Thanks,
Antheas

