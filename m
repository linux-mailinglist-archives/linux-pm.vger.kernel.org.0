Return-Path: <linux-pm+bounces-12652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BE295A50C
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 21:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DB91C224E4
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 19:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC4A15C12B;
	Wed, 21 Aug 2024 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3jihrZ1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1816DEB5
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267229; cv=none; b=IrHbVx4tFVvTM3veRvdNB0FyW9+68INakW6p80fC5CShEyPj6NsPT+H7vHOzbMh/zomE0IEKpm3nKTOlmQO84z8XXbKQ9tB/zbic2R3GJHt+VpMX4vvUbKmn0E4SSBhwrUQB5NzJiC07RrVjT5IRn5uhG+BD6cg1gtSylxZDO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267229; c=relaxed/simple;
	bh=LdRcg5wd6A0aunU43GxYGYIfen+s/tQuENycbZhHv2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qH3sg7C8kPBqsLtBHUod18PwDqb1C/oTgy3pACzrBh3AI9GKoiOwKeEzpC77VtA3KjRAqN8eVerO8Fj1cRCFV2HdTUT4ot1q5TaUEoNbMEysZqUIpJijFEODakIWVvUSlD2UGh+PJl2q15thLLxPQnsrVlBYk5D8dj6pRJEa1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3jihrZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CD1C4AF10
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 19:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724267228;
	bh=LdRcg5wd6A0aunU43GxYGYIfen+s/tQuENycbZhHv2g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G3jihrZ1CghxZk3oO5nsKihkBVs01oB08g1NQz6PBZVShdaOx/dLO5VvWadOgboU1
	 hSEAqs+YqcuZt6sZnNhUmpuoItxndLIjhDF6EgjAT0BwqIA6gKUkwf+7Hfvz1yvq7t
	 KJNCPU/Sun5BOaQ/a+pEItRDyZdWPBnCkgmV3hMgE9ufkRQtWm980ejyb0xhgUK7js
	 jctgrwQqhHfEiKMlkfy6gzfdVcstOcerNIC7h8eRLw2n0Iv6ym2pL7JcRqJWzgPVmQ
	 /ObdhLCEMkh68uyp9NKlKQoI0e7jIgWgm/47uhi+go6rTqJ/8oXGy1cwWJ7V9GXRsr
	 SMe2TSaTryKRw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-26ff21d8382so4730fac.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 12:07:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFQP+/1ephUfREHDqmk3U98Y3B0pbOJjiCh7GD7ZutmqL+d+D5mdh8YalJtnBOCNvyIijIo4yJZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfsj8WjXFIZcB7kLzf6KXk+JmbPtIlWyl/S1OgQdHEG0U0OYSg
	m2vdU2x44cQXIyogi7k/TQpcQeaVT8IzWZcuiWktZdSrF4WZZhREaPDEL8QydhWjYDYZNoEADxP
	ol2w+SrKUNzOD+ID2XTzJGG9ZcjE=
X-Google-Smtp-Source: AGHT+IFFZRqL8idndy+eKSyQpynG/fwcFWVV8IYR0HfzggyzTnO2cl8KxzN2CVgOkhjl0nklcNTf+gTudsxVNFJPjSo=
X-Received: by 2002:a05:6871:894:b0:268:a074:39cf with SMTP id
 586e51a60fabf-2737eeac73emr3565615fac.8.1724267228043; Wed, 21 Aug 2024
 12:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
In-Reply-To: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Aug 2024 21:06:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jt6m9GLLpDhFd7e1mnbbDxcA0FC1Mm3x85ASRQkAwS_A@mail.gmail.com>
Message-ID: <CAJZ5v0jt6m9GLLpDhFd7e1mnbbDxcA0FC1Mm3x85ASRQkAwS_A@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add thermal thresholds support
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 10:12=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The trip points are a firmware description of the temperature limits
> of a specific thermal zone where we associate an action which is done
> by the kernel. The time resolution is low.
>
> The userspace has to deal with a more complex thermal management based
> on heuristics from different information coming from different
> places. The logic is much more complex but based on a bigger time
> resolution, usually one second based.
>
> The purpose of the userspace is to monitor the temperatures from
> different places and take actions. However, it can not be constantly
> reading the temperature to detect when a temperature threshold has
> been reached. This is especially bad for mobile or embedded system as
> that will lead to an unacceptable number of wakeup to check the
> temperature with nothing to do.
>
> On the other side, the sensors are now most of the time interrupt
> driven. That means the thermal framework will use the temperature trip
> points to program the sensor to trigger an interrupt when a
> temperature limit is crossed.
>
> Unfortunately, the userspace can not benefit this feature and current
> solutions found here and there, iow out-of-tree, are to add fake trip
> points in the firmware and enable the writable trip points.
>
> This is bad for different reasons, the trip points are for in-kernel
> actions, the semantic of their types is used by the thermal framework
> and by adding trip points in the device tree is a way to overcome the
> current limitation but tampering with how the thermal framework is
> supposed to work. The writable trip points is a way to adjust a
> temperature limit given a specific platform if the firmware is not
> accurate enough and TBH it is more a debug feature from my POV.
>
> The thresholds mechanism is a way to have the userspace to tell
> thermal framework to send a notification when a temperature limit is
> crossed. There is no id, no hysteresis, just the temperature and the
> direction of the limit crossing. That means we can be notified when a
> threshold is crossed the way up only, or the way down only or both
> ways. That allows to create hysteresis values if it is needed.

First off, I'd prefer these things to be referred to as "user
thresholds" to avoid confusion with trip thresholds.

> A threshold can be added, deleted or flushed. The latter means all
> thresholds belonging to a thermal zone will be deleted.
>
> When a threshold is added:
>
>  - if the same threshold (temperature and direction) exists, an error
>    is returned

Why is it useful to return an error in this case?  It appears that the
existing threshold could be used just fine.

>  - if a threshold is specified with the same temperature but a
>    different direction, the specified direction is added
>
>  - if there is no threshold with the same temperature then it is
>    created
>
> When a threshold is deleted:
>
>  - if the same threshold (temperature and direction) exists, it is
>    deleted
>
>  - if a threshold is specified with the same temperature but a
>    different direction, the specified direction is removed
>
>  - if there is no threshold with the same temperature, then an error
>    is returned
>
> When the threshold are flushed:
>
>  - All thresholds related to a thermal zone are deleted
>
> When a threshold is crossed:
>
>  - the userspace does not need to know which threshold(s) have been
>    crossed, it will be notified with the thermal zone identifier, the
>    current temperature and the previous temperature

This has a bit of a warm-up issue when the zone temperature is above a
threshold to start with.

Or is it not a problem because thresholds can only be added when the
zone temperature is known?

>  - if multiple thresholds have been crossed between two updates only
>    one notification will be send to the userspace, it is pointless to
>    send a notification per thresholds crossed as the userspace can
>    handle that easily when it has the temperature delta information

That's clever.

> All aforementioned actions and events lead to a notification to the
> userspace. A threshold change (add, delete and flush) is notified to
> the userspace with the process id responsible of the action.
>
> Along with the kernel changes, the thermal library has been extended
> to provide the different API to deal with the new threshold netlink
> events and commands.
>
> In addition, the thermal-engine skeleton uses these new API by
> flushing and adding thresholds as well as getting the notification
> about these actions.
>
> Overall the series has been tested with the thermal-engine skeleton
> and some selftests which are not part of this series.

