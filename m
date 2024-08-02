Return-Path: <linux-pm+bounces-11843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8991D9462BD
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 19:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B846B23090
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E51E1537CB;
	Fri,  2 Aug 2024 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpbNzMkY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454031AE029;
	Fri,  2 Aug 2024 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722621045; cv=none; b=iagvYryIz6BH3uzWB4VD+jm/GRqtJy0o/NP4Hs/1+6/nuIGxiaylTCDFxU2+XvgX7WI9D1jT/xjQH1hH1GtRb5BR14BCpFZ0bu1ZdOsFIuwHNHwwpzsr+VYN1t6TWbxOf1Nu3ZTlj7NhhO1ELP2T+cehkxhb1Zh9wbVShR4RuFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722621045; c=relaxed/simple;
	bh=MkLvIJJ+g3q/ivBXqQlyPJ2bb82dxl4XlK2D5MQTLd8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rI8edmJIi2APt/4N+A3PHGSkjig01/jPASxyPCc5rkbK2qlwcyB4YdeSeoFHcpkmVu/5MameKQCEayC/USHVjv4ifmdzvA9K3bUgrvsmlLnrwPQ7lgUZ669eN+wSwrYmqzkmu68j6PTMb4Ir9eDOZcYR6+wrHDBqkSVeo3np78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpbNzMkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80A2C4AF09;
	Fri,  2 Aug 2024 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722621044;
	bh=MkLvIJJ+g3q/ivBXqQlyPJ2bb82dxl4XlK2D5MQTLd8=;
	h=From:Date:Subject:To:Cc:From;
	b=TpbNzMkYSr6KLYS6BdzlNIEL5NKk6WGeye5AgEuhmO5T1ZskFmiyew5aYPPkt7a+5
	 gD6ZKWcPP7dY7pfYuvZkoImw5nmSapM6MEgIkuKmt90qPHP5ONIBg6d+qgm1D5Zrlb
	 5j6rHQJM5NVKzgHsDBwq8u6qa5YJzQnV17JicrXlP5GAa5OsM+y/0V57iHzeuF9WGQ
	 JPRrpifntPgaDxWCXADidf0uiaYUoaBSqpv71QfUxZ9hWjT4GepGP/rLxvmmV65gsv
	 +OuLgvjDnuUqqnGhS6L2bAZlxcYYPy1BKJiXvTh88vyRKXP8HzozPyjjzRYcKp2Ot6
	 b05auZ5vLut2A==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2635abdc742so1220238fac.2;
        Fri, 02 Aug 2024 10:50:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVn6sxNjbxPdyRJ+JysKiL9dUiz8FONPgc/orxLbWbE4U5trjr/bnlJoVU5b3QPOlmbq6x01pouIXO0Q10=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZjAHxQ6fXd+f5hNZrtxtwcwljoG/DjQdUg5zG7e9GzT2UUslu
	Vi+q5IA5EpSznpaiTKJ2EGHts5WkvKzbCTtFD6Bvt7qe6i/wclnQiKcfDz2CAEC4GiE46ccpX32
	0G4LE6v8CKKrvRr73W6X3yMlACNw=
X-Google-Smtp-Source: AGHT+IFFLRwH7Tu/YsF9NCc6lJWKKzrQqiKbjFO7ZFPDIVWtGcML9FaHSaL085J3qdpnyCCTpv6tUXb/mHANbu2oNhk=
X-Received: by 2002:a05:6871:5226:b0:260:df6a:28ca with SMTP id
 586e51a60fabf-26891e9f618mr2918407fac.5.1722621044202; Fri, 02 Aug 2024
 10:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Aug 2024 19:50:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0izLX1aQNBjAU20O5ZmxU7DnyVHJXf1=teyy5UDoZHmOg@mail.gmail.com>
Message-ID: <CAJZ5v0izLX1aQNBjAU20O5ZmxU7DnyVHJXf1=teyy5UDoZHmOg@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.11-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.11-rc2

with top-most commit a09074228977c24c677c10282f506fa11f88eb93

 thermal: core: Update thermal zone registration documentation

on top of commit 8400291e289ee6b2bf9779ff1c83a291501f017b

 Linux 6.11-rc1

to receive thermal control fixes for 6.11-rc2.

These fix a few issues related to the MSI IRQs management in the
int340x thermal driver, fix a thermal core issue that may lead to
missing trip point crossing events and update the thermal core
documentation.

Specifics:

 - Fix MSI error path cleanup in int340x, allow it to work with a subset
   of thermal MSI IRQs if some of them are not working and make it free
   all MSI IRQs on module exit (Srinivas Pandruvada).

 - Fix a thermal core issue that may lead to missing trip point crossing
   events in some cases when thermal_zone_set_trips() is used and update
   the thermal core documentation (Rafael Wysocki).

Thanks!


---------------

Rafael J. Wysocki (2):
      thermal: trip: Avoid skipping trips in thermal_zone_set_trips()
      thermal: core: Update thermal zone registration documentation

Srinivas Pandruvada (3):
      thermal: intel: int340x: Fix kernel warning during MSI cleanup
      thermal: intel: int340x: Allow limited thermal MSI support
      thermal: intel: int340x: Free MSI IRQ vectors on module exit

---------------

 Documentation/driver-api/thermal/sysfs-api.rst     | 65 ++++++++++------------
 .../int340x_thermal/processor_thermal_device_pci.c | 29 +++++++---
 drivers/thermal/thermal_trip.c                     |  4 +-
 3 files changed, 54 insertions(+), 44 deletions(-)

