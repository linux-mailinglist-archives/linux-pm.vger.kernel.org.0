Return-Path: <linux-pm+bounces-33330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799AFB3AB1C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 21:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B0C7B15C3
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 19:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4144327B4E8;
	Thu, 28 Aug 2025 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwYD5Jv+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178E82356D2;
	Thu, 28 Aug 2025 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411003; cv=none; b=Wq3hLhev2VlUTH4I+Zoj6XN0dsL3z3oSo1qmPjOrKZvGzFLyQGeUzBt/s1PJw//DgOTUfPBeSTrfQFS2qlwtlrCsHtWaGdN1XOhaagJrrhwFMLKiT0owoLsd+emIEb1gHbo6Y9yGtCF4BC0mfrhYrCGaPhB+HcUpsaoMnTYI2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411003; c=relaxed/simple;
	bh=jZLDYkrwDKsVdAImEhREQM4BnFPCcFh7iYu2y1RSPUo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nS96Ug64YAWlQBKc4tLEx68PpUa2UA0FKX6oyQdX3XO3pLMjDjYjPvtZMb+7X4hEPBlAmj13hbUf7mlkOum/bKXlmWBkuaClhHrI6d+gdpqLJt+3kWIB+dmTZdNDPd6gbL6+YNu+vPywdeQi8amNybuQpHh0dfKjllNRSGt2/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwYD5Jv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8688EC4CEEB;
	Thu, 28 Aug 2025 19:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756411002;
	bh=jZLDYkrwDKsVdAImEhREQM4BnFPCcFh7iYu2y1RSPUo=;
	h=From:Date:Subject:To:Cc:From;
	b=NwYD5Jv+POWCmmQ4yLoFuk+6+90khAmq496wB0MVGNaNcSv8hCo8W0WpyEL4416d7
	 hefFq+/VHNIk5Rfkvu/A96xQVV2PskfIpo/fqOK6uDiEOSS8MfKWg7zpFhSC6nvrBX
	 QcacnIgKd8i/J2UFA2BFcgUi5cWWp/eFJu4OZjUGuHzaWY91AEEEr1o0rEcogOWw9j
	 ggv2j5qs75SCH8uQZ8l2TY0YJjGtu1lDZAMIRzshr1KsYd8x3oLQx3faHho1ftPtIP
	 o27ujLKdcLVG32K5TDng9AWKyecgCo4aSj+N8zmTBBu4l4YjYe5hmRIS3Cj19NttSJ
	 CqMDkEcYHOLjw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30ccebcc7e4so571725fac.3;
        Thu, 28 Aug 2025 12:56:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVP2lKNo3EFxkJ3oe9EIPiTonsWX217VT14eRJyn4nhqD3q5yFRDfHGeagjDohH2OIbfiyX7EnjjebUamM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/td5/cPtLuOrMIkd5scoCpvfcwL0wpvLMrHpfsCJNi6yPMfnj
	zU+Vf8iiuFkxUU/I9BJbaYh1jMgdtTxx/WYSoQ7IsP3swJxWUqe9jeg2ECnJ7YlqBQuU6xJFl7k
	PoLwgYTP1J/AmmW/3AXPPNwtBqhRXYCo=
X-Google-Smtp-Source: AGHT+IGHC0+gOP0QuFr17bNBCpnewHs7q7ed1TYwBzQhcnl4fFhC38rdnd/Z+7RhlL3A7fzZ3TDf8JYdxvqgiBMlbHY=
X-Received: by 2002:a05:6870:c98f:b0:30b:d2f7:5dca with SMTP id
 586e51a60fabf-314dcda20d9mr14609705fac.35.1756411001785; Thu, 28 Aug 2025
 12:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Aug 2025 21:56:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i8kCoBSOd8=-SO2WR-b1=zCC0jGHgDOq-LrnHixGjudQ@mail.gmail.com>
X-Gm-Features: Ac12FXxY8RrlwxbIY96QIL-Gl1T6C4AgvVMqOCSAg82mWvl-SACxRbdUkG1tTjo
Message-ID: <CAJZ5v0i8kCoBSOd8=-SO2WR-b1=zCC0jGHgDOq-LrnHixGjudQ@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.17-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.17-rc4

with top-most commit e246518aa24f1460902725e97d0abf574aec6ade

 PM: sleep: annotate RCU list iterations

on top of commit 1b237f190eb3d36f52dffe07a40b5eb210280e00

 Linux 6.17-rc3

to receive a power management fix for 6.17-rc4.

This adds missing locking annotations to two recently introduced
list_for_each_entry_rcu() loops in the core device suspend/resume
code (Johannes Berg).

Thanks!


---------------

Johannes Berg (1):
      PM: sleep: annotate RCU list iterations

---------------

 drivers/base/power/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

