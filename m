Return-Path: <linux-pm+bounces-22108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75235A36719
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 21:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B14F171B63
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 20:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67B5198E77;
	Fri, 14 Feb 2025 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyG7L3cp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796B918EFD4;
	Fri, 14 Feb 2025 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739566331; cv=none; b=m7eYlB5e7Tng7SjseQCGT1jCbqvO+z5OeWtcDAa9fHfuItTonlv6H/FCU3HE8mN7CyhapBVEafKdsA5iEZ74imCR829pIowpKEC7rrU3RCR9ymFrefrvi3NfNNGoS4DMRsCfpdyCROtzmbPN0fTyyoLqUFGkcmUJl9Kb/1rp+2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739566331; c=relaxed/simple;
	bh=Pasz9gJodBkYKRLU+7hhjVomkiw6r4ovSyTAwl0T65I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NLbKLW0YB1Hzu7a5gi/DD2cVL9sSAHqUXLmO96FK6BtkJYFSMg6YJHgAc6wBipzf+dFo7B29FgGpBS1YqhTwSOhGxNBq+NYUNM/lAVBSz6lKKHuEpgXIjzFizcTK7IBVa03d0LdNUrH6lyb6L8JqimyH9Uf0zV3crHd6NL8y3zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyG7L3cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CE8C4CEDF;
	Fri, 14 Feb 2025 20:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739566330;
	bh=Pasz9gJodBkYKRLU+7hhjVomkiw6r4ovSyTAwl0T65I=;
	h=From:Date:Subject:To:Cc:From;
	b=YyG7L3cp/aiqGkyQJXoGvIit4mumovgS+PEMkcepTdO9bGJtJ2w+7/fSKxQQPPB06
	 GO8NONQrHkFJORtB7k5HK4Yl9KXd1lnaFQVSNtj50GtADYmWAfUHhTqnlpWaNSOPrK
	 a1BYFNgvuVFtr27ezbgO7uwlneTSO4ksYqHe+HmguUoJvojTYUJz0qdq83RH6/RtFK
	 8wagBsa9SORUdtZy5zKVpheIbwH5UYyrOEzIn69FWuufJ7Hwjl0aVaDIOE/X1H8NK+
	 4FzHC2WiUDupiDbKop9SoRF/vZmqMsoB11I8YWC1XUuSsLufziEVxsg6ALvGWqI4y9
	 YBYdDFHQWj4KQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5fcb41b6455so649359eaf.1;
        Fri, 14 Feb 2025 12:52:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0bvGShb5XXN1l6EjEae8vsmxhmwRSkIakAyAWQfrOir84TxF5xdzQ0iBsCf9vnvvwcEFT6ANLguTo0UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwslDuN7HSJUPErphrJyToVOf88LrXtwVIQdX368j+gbkVpCdHH
	6I7FdDRFpH8NUlWp5lhSztV1leV7HV3dx1Txp+Z25Dsa8e41yz2vgJMbiCjXhjDLVKA99y7qE4o
	R/iJfHCv6Bkg/QdFKpBySedYZAJU=
X-Google-Smtp-Source: AGHT+IHFLBC7rZlNpsFiPov4BUId7EKQWZc1Pk104NDKABNFsqpLD6hJH/f0cFybVWecKyyA/XTnm1FbYtARoKb55BE=
X-Received: by 2002:a05:6871:6c08:b0:29e:7603:be65 with SMTP id
 586e51a60fabf-2bc99a4bbdcmr315498fac.1.1739566330235; Fri, 14 Feb 2025
 12:52:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Feb 2025 21:51:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hZnJHLmwh9K7_auS+JeinAx0DWd1vi-bWr_qDp5ZnyGw@mail.gmail.com>
X-Gm-Features: AWEUYZlTFjJC74EjVRoWEYGVCsgyXhbThLp3IIXGFw6SlVnbBbwMmJ8upu7hN5s
Message-ID: <CAJZ5v0hZnJHLmwh9K7_auS+JeinAx0DWd1vi-bWr_qDp5ZnyGw@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.14-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.14-rc3

with top-most commit a6768c4f92e152265590371975d44c071a5279c7

 thermal/cpufreq_cooling: Remove structure member documentation

on top of commit a64dcfb451e254085a7daee5fe51bf22959d52d3

 Linux 6.14-rc2

to receive thermal control fixes for 6.14-rc3.

These fix a regression caused by an inadvertent change of the
THERMAL_GENL_ATTR_CPU_CAPABILITY value in one of the recent thermal
commits (Zhang Rui) and drop a stale piece of documentation (Daniel
Lezcano).

Thanks!


---------------

Daniel Lezcano (1):
      thermal/cpufreq_cooling: Remove structure member documentation

Zhang Rui (1):
      thermal/netlink: Prevent userspace segmentation fault by
adjusting UAPI header

---------------

 drivers/thermal/cpufreq_cooling.c | 2 --
 include/uapi/linux/thermal.h      | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

