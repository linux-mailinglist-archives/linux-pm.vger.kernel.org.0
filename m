Return-Path: <linux-pm+bounces-20548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A219AA13C92
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 15:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5843A2471
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 14:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA141DE3DE;
	Thu, 16 Jan 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oc0JrXfI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28FC49652;
	Thu, 16 Jan 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038781; cv=none; b=eluthbVH5yFdNmOuvWCfg3x5hd8XaZ87PllvTiIFr3Dyg6QX2eWsi1j2dFU4S1NaWcGrVDZKWSXF1Em9m8XOpCH5/ZPOkL6Z6HWb9PviPApH9mU76KZg1UxlPVoPZnoLW7AtHsOQCsN0bZ5+GGuTwvbFEklKnqBWdeLBWN6iX7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038781; c=relaxed/simple;
	bh=DCG7y53kMDGoAPsLEalBaZKjP2LAcYDi2yX1V7ikLnE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Bqqw2oldJQQVyRpFwChvqBsDXP7vZb4l7XVX2TMlq1cYrYRFbbiJllGKQVqB5ZAWD7pOVC+AAG9+s3gY3O/380dIoePQjOwzyoKIOaG0+pZoOFWV+rdpMxn7A0uvfXiW6TRKHvTpZzVPiPsJ9fMI0W9FGcoenp51QOpoqjIew2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oc0JrXfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C565C4CEE3;
	Thu, 16 Jan 2025 14:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737038781;
	bh=DCG7y53kMDGoAPsLEalBaZKjP2LAcYDi2yX1V7ikLnE=;
	h=From:Date:Subject:To:Cc:From;
	b=oc0JrXfIos/TY6XetdIJTL4mc5VEACwBwyRpZAS2zAR13sohZKwYjgdfTtdNt6WD4
	 o9IuouH6+PKC9KkbT34TlGmKhbkB4bW+RNwEe8vHu1Pl0SKefIgJHvKY6+tliSKYrr
	 gIGN+iPDf8RgAFYw1v5qtss/O15KtBp4iiakpbyMGmZr4yNOvT8/A+Ja7ppbyibbP5
	 pVqnDAwyETuK1x7+i88YJzgl4UjkSrSuwIt07VFyM15FwFLH32+E2u61ltEFpcyxtG
	 rHtz/ppFENBU+DJ0aND/uLJuPTlHyJfYJYAoY2qjIoU4q7CksnaWOAN7SzUEd1kdgi
	 bWGXZxoEuKWLw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f340d6db09so580588eaf.1;
        Thu, 16 Jan 2025 06:46:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfX0dMlsl+13RpWAueZgUeuL5rej9Z5WJrySKy7yr4BxcHj8cF2vQw24OI5ulkficx+rtsp/Zci1WI2ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNHfCFjSP+1jYDJnMKXwnPRczcbFvMus3Wl7nfDHOC91WGF0Ti
	WG/wB3S+fYT8BqM1Nlm/oFbKebkvfW9ilYuKGsP1WQwcgQcyvDDxvENzL7I1WLtNot0FVkzA3yr
	Qlb844FBqDIwAwSpXNHKgV2R5pz8=
X-Google-Smtp-Source: AGHT+IHbZCJVbP2h1TQvzWlFvv6FB/0I9WSpecYyykrELHIMiBz4E00SnqcICBZke55c0L8quHrgLW/pDE+skQ4L4yc=
X-Received: by 2002:a05:6870:6f14:b0:29e:5897:e9ed with SMTP id
 586e51a60fabf-2aa06982ebcmr21988683fac.35.1737038780534; Thu, 16 Jan 2025
 06:46:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Jan 2025 15:46:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hdgZ3KpZhtdF5hDn4KwUcT4=nfjtG=mythTyzrNJLpCw@mail.gmail.com>
X-Gm-Features: AbW1kvZ1-rN29lEQozsncjkSItok6-hY2f9cl0dAlDhTlzv50RFe2cNSwvMQ0Io
Message-ID: <CAJZ5v0hdgZ3KpZhtdF5hDn4KwUcT4=nfjtG=mythTyzrNJLpCw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for final v6.13
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.13-rc8

with top-most commit 3744b08449c27bfa085aa218c4830f3996a51626

 Merge branch 'pm-cpufreq'

on top of commit 5bc55a333a2f7316b58edc7573e8e893f7acb532

 Linux 6.13-rc7

to receive power management fixes for final 6.13.

These update the documentation of cpuidle governors that does not match
the code any more after previous functional changes (Rafael Wysocki) and
fix up the cpufreq Kconfig file broken inadvertently by a previous
update (Viresh Kumar).

Thanks!


---------------

Rafael J. Wysocki (2):
      cpuidle: menu: Update documentation after previous changes
      cpuidle: teo: Update documentation after previous changes

Viresh Kumar (1):
      cpufreq: Move endif to the end of Kconfig file

---------------

 Documentation/admin-guide/pm/cpuidle.rst | 72 +++++++++++--------------
 drivers/cpufreq/Kconfig                  |  4 +-
 drivers/cpuidle/governors/teo.c          | 91 +++++++++++++++++---------------
 3 files changed, 81 insertions(+), 86 deletions(-)

