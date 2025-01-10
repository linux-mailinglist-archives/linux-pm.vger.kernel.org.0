Return-Path: <linux-pm+bounces-20260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED03A09CE2
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 22:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98721188E5D4
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 21:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED912080DA;
	Fri, 10 Jan 2025 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hlln43os"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9663205E2E;
	Fri, 10 Jan 2025 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736543736; cv=none; b=JnytyxQT4am/xIXUnnGJ8lipuV0AKNF5cH0BzYNmAVE8B7TxfJM5A2w+PwzaVzmsKGKKpkcZ+2JmPG744z3nwY3MOOJqWa7LScR/K4oYdrQ+li5Nw18MGlKm/4qSqpfOxdQ2U4GEDkC9F7X3JFHMr4yB22NQdLoPRl0rAhWyam0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736543736; c=relaxed/simple;
	bh=PXMoAWbJChMPj6AOaoK9CHHBSKQrE2OBU9sjT2JI6dc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oM/jdTwxd/4ad7Zb00RcpXLGIcF4pC8OWbC61+k0VrtWylVl5jaVNRmE3xHws/JPmswDgEbKB0OMcoR3TBwIKQNDkSeVWyHyZQ2q8OixosFq/We1SIFg9EyUJT+pUg9PKy9q2EcIHpxPN9doLxzgRGf01HYfUvg5tDThEawkseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hlln43os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A883C4CEDF;
	Fri, 10 Jan 2025 21:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736543735;
	bh=PXMoAWbJChMPj6AOaoK9CHHBSKQrE2OBU9sjT2JI6dc=;
	h=From:Date:Subject:To:Cc:From;
	b=Hlln43osoVnPXsr3QIFczzuFuA/jU8UPGxKdc2XwZCpjy1py58DQOPubp+PIN37rZ
	 9w/pw3vwbl+y92JxIpz4GtEpQeNjEHlnkU1uM6XatEOv5Jo9qtImixInvVo3kwHKR7
	 GSc1lQTKiXnU/iYnvo8Aod/auZuT+UpE+CoseJ6TSC7XFYYiX3/+yCh72MgfugKd/G
	 psy2eLxIR4OZnC5598j8Wv9+YOGCs83ZzLzVL1QZgNvRB1fse6fnVCv1gtM4OS7AS6
	 /X+SNKaPvVCgNexDOVG9PqXKdCaE3cKaNxI8ti0lLXN9GoEpf76ler/aRk6BRFA8CR
	 T+PUeo+Y+2zRw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29ff5c75c21so1773801fac.0;
        Fri, 10 Jan 2025 13:15:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUu12A9PCBVZh6UZdmCqsqGu59XXOa6RxpkM+3CImRnDvmLGltoz8121KlutK+jWNBSqRnm9Qm6cUZWMeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3zr9UFy8vLVmOYmkNNT5w/yMlDKiW/S0cjevYjI/9/lD9cuJw
	3phgzZvi1eHzYGwSdDa21DELZF7B4TxazbxXxVGDWgPEEuIw2K3iAipho18kFx3Mzl+SPbOXo1A
	Vdyd4GvOxTg1g5rj4ppN9hJ5GVVs=
X-Google-Smtp-Source: AGHT+IF3WXbWrFuh5mqyvsCKWlHIQMjuD6ckm5lAc3HF+lKMvXN9lRQyOVSqXQCQqRmyxJ88uqxIecy8ZtGYXfZmCVo=
X-Received: by 2002:a05:6870:9c8d:b0:29e:7629:1466 with SMTP id
 586e51a60fabf-2aacdbc936amr4985946fac.7.1736543734847; Fri, 10 Jan 2025
 13:15:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 Jan 2025 22:15:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jyAYdA9mJTftkVcDH1OKNEky82s4UAA4A7ODWHHQ3K9Q@mail.gmail.com>
X-Gm-Features: AbW1kvbxFflLjHoOZhV-jhGVJpmPouWMuMWHXOzTiMhQwBzx0HZynTMsdHzY0po
Message-ID: <CAJZ5v0jyAYdA9mJTftkVcDH1OKNEky82s4UAA4A7ODWHHQ3K9Q@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v6.13-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.13-rc7

with top-most commit 9164e0912af206a72ddac4915f7784e470a04ace

 thermal: of: fix OF node leak in of_thermal_zone_find()

on top of commit 9d89551994a430b50c4fffcb1e617a057fa76e20

 Linux 6.13-rc6

to receive a thermal control fix for 6.13-rc7.

This fixes an OF node leak in the code parsing thermal zone DT
properties (Joe Hattori).

Thanks!


---------------

Joe Hattori (1):
      thermal: of: fix OF node leak in of_thermal_zone_find()

---------------

 drivers/thermal/thermal_of.c | 1 +
 1 file changed, 1 insertion(+)

