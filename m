Return-Path: <linux-pm+bounces-12372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2811295501A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 19:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93FB2866F2
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C101BE241;
	Fri, 16 Aug 2024 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3gNOFih"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52128FF;
	Fri, 16 Aug 2024 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829843; cv=none; b=UmIxXgMBifXnRMEH1RGJl0jjX/AQGGMNI1W1As8JpcdfMhm4ULd0q+iXFMy/SLkHIiaCVM3CaZmT4mnucw4kzA+yaMv/i5GmK6snpKykCfKlnDuZeNlfcfA4kg6LYaP9vcKYiKrfHlYJnrXeLdVuOkFsBa+dZPUiWlMF/idOtB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829843; c=relaxed/simple;
	bh=HtEPyj9BR/iyMemPIhgtHXXdoJdeNgXidgN96OZDBi4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DyjA7ws180T1tByxwWhadtub1jpKIVhwSSGUC/QGCbtjMbCMLFwCV2WAloXZ208O2OZhPdPlo0L0JnttSAwq9tno2MfzNj/BvfikxW95ULUEYhN0vZuL3RaHadMYz+Q5mSS+GcB5xEVbBVwHaZ3vPXZ4FXIznrxgnYZko0ofUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3gNOFih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CE1C4AF0E;
	Fri, 16 Aug 2024 17:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723829842;
	bh=HtEPyj9BR/iyMemPIhgtHXXdoJdeNgXidgN96OZDBi4=;
	h=From:Date:Subject:To:Cc:From;
	b=o3gNOFihkrJxJIktwoWKfgbv5lPQP8RPwxW2d99sNczLqpwqG36ArnHqb6f+cFrLE
	 7dO3CESxvPvS2SYx6huqr5g7mhPObej305Vsp1e1t6+3Ein84uoqvRK6i7Q8vw/iFL
	 R21H9OkXatznzN8bEukpwwc/SB6WeRbbNxh3vbsuAaOAyKxUdU8SbfrTv/JIcAgu1R
	 dEe6XGb9HECtN4gSlN1COGA+YssewI9aOM4aDtc8TaYO+14v9SeVIZch2IsN1Vi0dQ
	 Funo+lA9R5rKced3OKs/GQv5F70f9JcysjXyHejiA0eNmncjYRl/LltdgPokX+LT1s
	 ms5SvsNgWtleQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-26123e59c8aso301370fac.1;
        Fri, 16 Aug 2024 10:37:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSz/SN67JycyVY6PNM69QW24Y6lefFVojd/kVI0gUAHfqy2KnqsGcbLYArBRKWBZiAAL+Xs/4Bt7q+nmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUG6OBoF+zALS7r5F0UsyeK6PX9tYKlglMz0e4yoGPZJ5AM5kt
	XI3My8w8HeYFaftSMc+QB+tkhk7xo+4U2vQUoF0Rac8eT3U1RE3WcKY4P24WLPxDVEiuVht6VlT
	jcnMYYd42kG42ctn38saM5QejbjQ=
X-Google-Smtp-Source: AGHT+IHtMHoNz2nkl9Bi7GqqqFjTEmakWUK9dIHp9LFa6KejVrGWfpU1x0wvnFw/fRxBd5UthdwIDq4aLqsobhDpkMk=
X-Received: by 2002:a05:6871:153:b0:270:eb9:e17d with SMTP id
 586e51a60fabf-2701c5880femr2236534fac.8.1723829842010; Fri, 16 Aug 2024
 10:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Aug 2024 19:37:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gVtyuMaB=XafJy8dUtaMvDD=5aQkaUgPsF0B7KtQQa7Q@mail.gmail.com>
Message-ID: <CAJZ5v0gVtyuMaB=XafJy8dUtaMvDD=5aQkaUgPsF0B7KtQQa7Q@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v6.11-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.11-rc4

with top-most commit 6e6f58a170ea98e44075b761f2da42a5aec47dfb

 thermal: gov_bang_bang: Use governor_data to reduce overhead

on top of commit 7c626ce4bae1ac14f60076d00eafe71af30450ba

 Linux 6.11-rc3

to receive a thermal control fix for 6.11-rc4.

This fixes a Bang-bang thermal governor issue causing it to fail to
reset the state of cooling devices if they are "on" to start with, but
the thermal zone temperature is always below the corresponding trip
point.

Thanks!


---------------

Rafael J. Wysocki (4):
      thermal: gov_bang_bang: Call __thermal_cdev_update() directly
      thermal: gov_bang_bang: Split bang_bang_control()
      thermal: gov_bang_bang: Add .manage() callback
      thermal: gov_bang_bang: Use governor_data to reduce overhead

---------------

 drivers/thermal/gov_bang_bang.c | 83 ++++++++++++++++++++++++++++++++---------
 drivers/thermal/thermal_core.c  |  3 +-
 include/linux/thermal.h         |  1 +
 3 files changed, 69 insertions(+), 18 deletions(-)

