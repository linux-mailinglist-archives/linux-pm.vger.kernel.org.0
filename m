Return-Path: <linux-pm+bounces-16227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701BF9AB18D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 17:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D8F284D78
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1350E1A257A;
	Tue, 22 Oct 2024 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYZJZqMX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8197A13A865;
	Tue, 22 Oct 2024 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609265; cv=none; b=F2GR4HU2gsiuFXEMzDtXCHnSQUSw4FIr+ZwBJuuBybB/7j3f1ZF08N2bgApH6R2xSaSO5eznRlgCp5kypd2X8xYjYkqACwP0S2KkXtq7tFIDl89MYofV+xEpQfZtVjzy1wVIf77aZVVn+1mTktZUBU1cvxxsocskt/0esPWcou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609265; c=relaxed/simple;
	bh=bm58zMeK6d0PMqj87NIHPoN7oaHDMA679yeWU0dMt7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/JSWMgPANIlqOpoJWQXnzr8LRYHi0O6EbaWtLtuVN7qbWHIV6CHMIgxVhfYN/l45AvrY7hDKFZsirI8wrjUNHe0TjgqV7bj8ZN4QrriYBqRtBFmvRQvyv+7UkEZkSQ/L6JxOAraQcX7x9Rgwx1G3Afd2Hbs9NlElqQGn95TRFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYZJZqMX; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a39cabb9faso19704585ab.3;
        Tue, 22 Oct 2024 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729609262; x=1730214062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IP69QrjKIvgdLN3I+u548pC2BXnb7qD0PJFFBg5pzfc=;
        b=OYZJZqMX08HnyULiwaZxKTfDjxAws1tYT1GHdJcA204FTfklaWdrc3nuX3SyBesjBa
         DujILnvE2NATqmTvxqdSLPEXscD3FwJxFy7avvcSU/Eis1k55Sm4i8hBlpDot2GCoE59
         WVQUJt+8AKnJIh9lTD18WlgfERJfeXA86XHkO8I3R2Q5wGwyhA1pmfEiqSblSlok8aFh
         KVlRPMzqeKpzhxFTHCzVrbFdJyPBKoO7qTCs3oTTyt/cBUph2Q24St8uCPKSSAm6gWoi
         UQ7r90r132/xUAEO4rSeGlNIH1mgeIYk381raM31ouygV3+6K1kL2YSf/jhhIblVbI56
         UPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729609262; x=1730214062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IP69QrjKIvgdLN3I+u548pC2BXnb7qD0PJFFBg5pzfc=;
        b=XYP5LbONpcvdmSHe0B30xM3CA4/kVvz+gYzoqsOgxq+p6xgZqPwA8JKd4uX6cQzOw9
         a2rTi78+WlbpHi4WvYaiLuJJ0OluXJvgBPK7XpsXaoNhfW3R+SFONqfaI6kiG7xtIR/C
         ehTjdEtNcqlHiUl+trrSxd/wggTUR3RLIMoPJcC9DcJ9Ffmq8XJWydiJ1HJo5r/d5sgm
         goVALS5z3h3GUoDjryzdbfrEJ/HUvSbQ0bkEnPw7iecTekiOV79W2QxmgUZUqKRVqEiD
         EZifEJuK6cXpJm/BW3SWvb5R0lZ4qbBTgf85dJvCw4XmC7uNwQd9l0f/rtsI0Lr4LtGS
         v7vA==
X-Forwarded-Encrypted: i=1; AJvYcCV8+mUKd0247flwXgbrUXEMfsHTYORWvMi6xUcKocHEZXIDabp8YKoRjv5Q/Rg+FUCq4dWE57B7iCjlfpsD@vger.kernel.org, AJvYcCWAX1dtx03mVqB8UrniGSaoV8sBjEZ9N09SSvJa7A7ZUy5XI+NdoeTpkVuZRJ/GdNc695G2BeMa/Ldy@vger.kernel.org, AJvYcCWQ+F1RoUhPpqnM45p6pGi/CDZBMnt/gbBKTBgozmBnloFh4MxAXrjiDZS8bDJpwf3dZz/XXw2jvDzgrA==@vger.kernel.org, AJvYcCWk1MqgWxFItr7kzuE63ONUe2GFZM4VkxwXec9TKRuNQDbw5/5XdFB10r0T3M8usCQV4R8a+cmKTRNsSK0=@vger.kernel.org, AJvYcCXHC8pRsLuuoVehduDiVKYdzfN1WWTD2t7y4whhiU70ZAJsCVuSf+QVq/9hxUbZIG/p5xj3viM9z60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKfK2BFi/Dpmny+ykM+gQWvUWdvjMDdnLbSJGY6D0vHNMugXku
	PSeb0U/SU3PluYus/G3hWO+22JTq9ac23NTkKVTdcs4bshPRyED5uYunQXvBsmIY242SA199pID
	itE2iF523GZH/ai1ut9XbqHbIsy1Z4yTd6tM=
X-Google-Smtp-Source: AGHT+IEeuB3yHQ+efDPfikQckQ3B8TFoP4EuLV4GrGAYD8B2BtElQVwkA7TIw+O2jGhd0Ao/mhTvjxwYg9t7GrlgIDc=
X-Received: by 2002:a05:6102:3e8f:b0:4a5:ba70:1c6e with SMTP id
 ada2fe7eead31-4a742e72fd9mr3282746137.29.1729609251362; Tue, 22 Oct 2024
 08:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
 <20241007-starqltechn_integration_upstream-v6-7-0d38b5090c57@gmail.com> <20241015143329.GJ8348@google.com>
In-Reply-To: <20241015143329.GJ8348@google.com>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 22 Oct 2024 18:00:40 +0300
Message-ID: <CABTCjFCtFbFht2ZyBADuxhOfHZqiUmNKnAu4rwAS=kNgdqeS+w@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] leds: max77705: Add LEDs support
To: Lee Jones <lee@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

(...)
> >  drivers/leds/leds-max77705.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>
> Lol!  How big is your terminal? :)
>

Dunno actually, this was generated by b4

(...)


> No C++ comments please.
>

This conflicts with https://patchwork.kernel.org/comment/25898728/

> > +             ret = regmap_update_bits(led->regmap,
> > +                                     MAX77705_RGBLED_REG_LEDEN,
> > +                                     MAX77705_LED_EN_MASK << led->en_shift, 0);
> > +             max77705_rgb_blink(cdev, &blink_default, &blink_default);
> > +     } else {
> > +             // Set current
> > +             ret = regmap_write(led->regmap,
> > +                                led->reg_brightness, brightness);
>
> Line wrap at 100-chars.
>

From coding-style.rst:
`The preferred limit on the length of a single line is 80 columns.`
I only exceed 80 chars, when there's no good wrapping.


-- 

Best regards,
Dzmitry

