Return-Path: <linux-pm+bounces-15542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDD499A7F5
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 17:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C2DB22CCA
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 15:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512E5197A88;
	Fri, 11 Oct 2024 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VF8WHeBc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CAD194AD7;
	Fri, 11 Oct 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661094; cv=none; b=aisA6AJ0c04xZA7TfWMsoQMm0TQbXRZJ/FsxFNwawiLCuGFI6kb1a3Xh0zP8aMnOcSxYI965XsbU+VQtKs84LUN5NdrBJrd48cCYrn2HHmKfNasTVwH6kOqjUExNZ3aZVVzkOszIQzWpHkgApeop2OfUKkytWM8vd9mwCveqFrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661094; c=relaxed/simple;
	bh=0djeDcpwnVugNVpo4k3Z1/Vfjt9Q/x4TKfHcA3y/rf4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mX1J77UXyu8OscQzlxFy6NtYiZXA4gtblfUAKVu1gz+Y6LK0yPep5KVTQ52LQNADO9Cg3yb4ojSswK16mpRIT1KpquizH9ARJ5c+ZXDcH5Wh+ghMUO1FTqRDKFoLFzRUypfjyRrv2Aqoks6Jby0F2DexknPo5Aits/nB2juYBqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VF8WHeBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC62C4CEC3;
	Fri, 11 Oct 2024 15:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728661093;
	bh=0djeDcpwnVugNVpo4k3Z1/Vfjt9Q/x4TKfHcA3y/rf4=;
	h=From:Date:Subject:To:Cc:From;
	b=VF8WHeBc2LXUDqNLTXqtq1oYCBXNALp469nHX7CouIvxpVO9f4EOYJIKPizfYJC+G
	 a48Yuf/dUHt9luxCXwNRznXnwR3wm4oKkWKW9rEZ6kKf7RPWtYECEmgZpW5p2hU2f6
	 Dffx0Wj5FuH8epgDwvb1wRlXnz2jT8t1y7shymEu3GCCJh8JbWli4Vk0Vgu73yExXZ
	 fTTNgDILi3jMyvL+DqnINtyTy0XaNRpDXDoFOtUjhhxzcz6ut9lWtlPUKc3jiQ4Oex
	 6UvfTw03ilZ4JML33K5byP7rP+z4OBpMT2o9IeXx782kc7oCwQL4WaZxNZV7iH0F6l
	 fn+qMbbhtP6Jg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2886b38873cso552525fac.0;
        Fri, 11 Oct 2024 08:38:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTaRnPjmeHMqRXIHs8YTanZzysk/yXNB0mUBIRk8gAbakXI7E6snk84RMFhwhQAuexm8ztvjzv7S167Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbkGO4AnlksHUPu/iSCzWg6jxQLYhFZ+NTaXvsFGTJB4AmyX9v
	EaaGE/myqCTk1GFeOcVU+lXvSdEmsmNgNF0y+1/SUr9RtcAYk1jjwR5cwyS6fUK646pyqyzmjOD
	OtwpU4XDuPikSXzbl6MieVKwX6oQ=
X-Google-Smtp-Source: AGHT+IEorS6Uv3LVa8EKNaWMs7bawNyQyssLMNAeCxOlyWMJt+iacXePmp+YT1UWuupJoxcRv5/OagHEvC3Luzf6ovE=
X-Received: by 2002:a05:6871:b20:b0:286:f7a3:a4d1 with SMTP id
 586e51a60fabf-2886dcee90bmr3105128fac.1.1728661093067; Fri, 11 Oct 2024
 08:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Oct 2024 17:38:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hRoN3qAgCi6sZzUxyk0oeiRAB11d6QoFXm+YvxUT79NA@mail.gmail.com>
Message-ID: <CAJZ5v0hRoN3qAgCi6sZzUxyk0oeiRAB11d6QoFXm+YvxUT79NA@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.12-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.12-rc3

with top-most commit 827a07525c099f54d3b15110408824541ec66b3c

 thermal: core: Free tzp copy along with the thermal zone

on top of commit 9852d85ec9d492ebef56dc5f229416c925758edc

 Linux 6.12-rc1

to receive thermal control fixes for 6.12-rc3.

These address possible use-after-free scenarios during the processing of
thermal netlink commands and during thermal zone removal.

Thanks!


---------------

Rafael J. Wysocki (2):
      thermal: core: Reference count the zone in thermal_zone_get_by_id()
      thermal: core: Free tzp copy along with the thermal zone

---------------

 drivers/thermal/thermal_core.c    | 5 ++---
 drivers/thermal/thermal_core.h    | 3 +++
 drivers/thermal/thermal_netlink.c | 9 +++------
 3 files changed, 8 insertions(+), 9 deletions(-)

