Return-Path: <linux-pm+bounces-8659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918E18FD49B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 20:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2808128AAE1
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 18:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B457A19538F;
	Wed,  5 Jun 2024 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev+J06Sc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0A419D8B8;
	Wed,  5 Jun 2024 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610401; cv=none; b=oJN2b15H6pXyD5DY731PAfCHJkynrbxyGu0OdDH4WMg4mLFzVj6Q/iEcWNMevxKByXt6dtnmiw7yGZVpcqmxlhcKnaLoz1cuBrv1vFzxfzleySezeT6S1noTr8MbazpJZo3IUs/1aHd6X+OrY08OmOS44xAiESXBlYmJAE7lUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610401; c=relaxed/simple;
	bh=ZmEl4JWAj2FG1oQ1+kuvRgAe6HgB+Cyw6yp68j9Li64=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GwdV62LkeFMlF2utbW+V9KBlLsfdDm1jkA4LfHyOVR5sE3mw4QqtjxiavPGoXpq5undVWaS8LFtkrLpkv0eM0GpeS1YxlK5X2W+Y8Ad0RACagIpziWxc+eJ3g5pU8t8P1xwV8s+VNdf+7ojYTjMFcXpIBfGp467DmkzsWEiZGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev+J06Sc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1123CC32781;
	Wed,  5 Jun 2024 18:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717610401;
	bh=ZmEl4JWAj2FG1oQ1+kuvRgAe6HgB+Cyw6yp68j9Li64=;
	h=From:Date:Subject:To:Cc:From;
	b=Ev+J06ScNqvBKONyjyxrUTTaoxb9g4GoVIG0CCsvQjwveFn6HbdM7YEJtoe6175cF
	 h+ktGTjDwpokr7wZjOT62pjFtn+sr3mqcRPyl5Id6ekBD5/YhIjp/K0Z9CmC8e/+1E
	 mtEv1dFFQjfD2Ob6cF164jgOMNYmhz0owUAg7MYuyVGvGL1mYATB4vFu3AsTWSpd3o
	 jCMer9H5YQyZ289Iuox9GBzlP2yScg0EvneCF//i0d6hsqXBQyDBOj6GFpwS0BeCqN
	 85lAE4phafSN7dHshFz3Dy5qMyDcj8NDg7yl9pV6NrOZkzlYgeEBTez9BSAB1KvpfC
	 fWYLXZhfhCtHw==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f93fe6d11aso959a34.2;
        Wed, 05 Jun 2024 11:00:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVO2vXt1ctFgcSTKEm895nvC+xqqlVDAM5lFHyM6B3+dpLg82dOpKUt3CXOAEaZXe7YRoIYoey0EiArjWChjy8hnklHHiqB3GtZsmcQ
X-Gm-Message-State: AOJu0YycQ1FMnCpapkR1/3FywgwWpn/O+2m3udSyxbgzjX9+ODBprGHt
	Sp6aSI4Hb43bNReYfI+q4uU+eI6VDH0H9lK7vWrIiLoy9YrHJuAgkNF/rk0+ijIVBQzUi9mm0Df
	YCXXpH765Byk1zNtxoLCiL8+mUMk=
X-Google-Smtp-Source: AGHT+IF2Pdi8fFZ2KKDRvw90LKYizodqyqQ5AFX2NWSjiEUg1yQhAuiF+e3Tx6x1KY7dDEtKpWd28Dd+wAtf7FD42H4=
X-Received: by 2002:a05:6870:502:b0:24f:c164:2cd7 with SMTP id
 586e51a60fabf-25122313e24mr3275078fac.4.1717610400331; Wed, 05 Jun 2024
 11:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 5 Jun 2024 19:59:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jzcHmN-B3z1pajYi-NhD=igUi=RYrU9dkvBgoy6ZRdiQ@mail.gmail.com>
Message-ID: <CAJZ5v0jzcHmN-B3z1pajYi-NhD=igUi=RYrU9dkvBgoy6ZRdiQ@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.10-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.10-rc3

with top-most commit ae2170d6ea96e652c7fb5689f1980986bf48b7b8

 thermal: trip: Trigger trip down notifications when trips involved in
mitigation become invalid

on top of commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0

 Linux 6.10-rc1

to receive thermal control fixes for 6.10-rc3.

These fix issues related to the handling of invalid trip points in the
thermal core and in the thermal debug code that have been overlooked by
some recent thermal control core changes.

Thanks!


---------------

Rafael J. Wysocki (4):
      thermal/debugfs: Print initial trip temperature and hysteresis
in tze_seq_show()
      thermal/debugfs: Allow tze_seq_show() to print statistics for
invalid trips
      thermal: core: Introduce thermal_trip_crossed()
      thermal: trip: Trigger trip down notifications when trips
involved in mitigation become invalid

---------------

 drivers/thermal/thermal_core.c    | 35 +++++++++++++++++++++++++----------
 drivers/thermal/thermal_core.h    |  2 ++
 drivers/thermal/thermal_debugfs.c | 18 +++++++++++-------
 drivers/thermal/thermal_trip.c    | 20 ++++++++++++--------
 4 files changed, 50 insertions(+), 25 deletions(-)

