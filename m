Return-Path: <linux-pm+bounces-11425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA99593D1B3
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 13:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F73D1F221DD
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D87C178CCF;
	Fri, 26 Jul 2024 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZjR8cld"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D847F8;
	Fri, 26 Jul 2024 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992103; cv=none; b=h5Bb2qvezQz8e+dlO17l9Hmy51SnpycH6v+0RgcCRT1ptphoO60vRqBHrEbGzz8Z/y9yZud3b69rBYs6YCw5NQfOflNuEVf48wxdKBJ0mZH4k+7PdwGo0EZezhSbUnRBsApquNLeSr8fMLsyntvoAA0a00PrUvulCNiH83qsEYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992103; c=relaxed/simple;
	bh=vMJ14xFBCcqSpscks60IZ8UYhA6jmeLEwJ/aE36u/4I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WMRVP2ayTuq66yWTh0WnkXW6tHGKla2Qw6Uj716eu5uP3toOpBkCIJsh+td2jMRJKd80fFwwhrSn9yVM2hL8wc9Pc4Lwk/1hrU2We4TardzPeqCCaTvvV/4IS6ihMidy7djVpuTxzFYOP6tAluiwG86NyP/TOL1PItY80YRdrfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZjR8cld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8689CC4AF09;
	Fri, 26 Jul 2024 11:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721992102;
	bh=vMJ14xFBCcqSpscks60IZ8UYhA6jmeLEwJ/aE36u/4I=;
	h=From:Date:Subject:To:Cc:From;
	b=YZjR8cldZJUrPd57PBEJezZev+zc51L6fwaHkqb3gxqpFcQySCrfV/4BJa4NswTxh
	 +5seacYYit5oikrnvn8lqiR7koFQROxKixwxSNbwPNScj4IHJjtgQAnCNLj1E4rQTk
	 oZha68h/VcOc+OqewwfUjnX2owASqwFluh5EzW+VT40oy4UIj3kQrB5iJ02tGPJEwu
	 UkUUMMqogvg6UoOkfAY4gJxHxt1p2SVmStE6PCraDoQrvDP0P+fpwv2V+bO75sYon7
	 9l59wVfamNl8KmLF5IP1IkS+ypAQDmOWao+glnxiMcNHeu3qG5aVe8k3+c2YYJ4mrS
	 My3xxf6pIfD2A==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db1643534bso101206b6e.3;
        Fri, 26 Jul 2024 04:08:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBJ9HztZzFmgiyETwsW382lSBRqJx2yD9s3lpFq+ZsmvAQsUhG6Pr+bHMfwcf8FRlHsLlFA6oR/x9o1R6XQ0nlIwETQ2iuZ9n6fOnX
X-Gm-Message-State: AOJu0YzBzBbudJZ955C0+gvIi7+7+l4DOwqAuPuTRQVk/aIVrXKPnHaV
	GASGBmT39ylLRvtsUzphih5Pd6jpYpTQbw0WhBpqlNYdMzlWiOypNV5RC8Jxp5LDQMCJDGeVRTu
	nqHxe5VC828x4GuK0a5oDn/vTL8Q=
X-Google-Smtp-Source: AGHT+IG3CT1fO75qYRn/v8atCbj2qlL9aE0Pa09blj04Tv55C3mHM3ykn0Z4UBFE6ediyHbMmEVFdbeTJXKcMMIcz5U=
X-Received: by 2002:a05:6808:1807:b0:3d6:2de0:84ef with SMTP id
 5614622812f47-3db11f809d3mr3913732b6e.0.1721992101742; Fri, 26 Jul 2024
 04:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Jul 2024 13:08:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j+Dvk43LpnPiLbVELAXCLBRJgKhOAvWzmOJC4QAcFY3A@mail.gmail.com>
Message-ID: <CAJZ5v0j+Dvk43LpnPiLbVELAXCLBRJgKhOAvWzmOJC4QAcFY3A@mail.gmail.com>
Subject: [GIT PULL] One more thermal control fix for v6.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.11-rc1-3

with top-most commit f7c1b0e4ae47e67c6f9af84568a5f4a80638ccd8

 thermal: core: Back off when polling thermal zones on errors

on top of commit 539fbb912321ab6361ccc08b72f5f83e8a25c24b

 Merge tag 'thermal-6.11-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive one more thermal control fix for 6.11-rc1.

This prevents the thermal core from flooding the kernel log with useless
messages if thermal zone temperature can never be determined (or its
sensor has failed permanently) and makes it finally give up and disable
defective thermal zones.

Thanks!


---------------

Rafael J. Wysocki (2):
      thermal: trip: Split thermal_zone_device_set_mode()
      thermal: core: Back off when polling thermal zones on errors

---------------

 drivers/thermal/thermal_core.c | 89 ++++++++++++++++++++++++++++++++++++------
 drivers/thermal/thermal_core.h | 10 +++--
 2 files changed, 85 insertions(+), 14 deletions(-)

