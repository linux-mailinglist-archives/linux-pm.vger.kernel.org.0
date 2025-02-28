Return-Path: <linux-pm+bounces-23201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9482A4A4D0
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 22:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044D117198A
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 21:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DCE23F38A;
	Fri, 28 Feb 2025 21:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Omu0JuHe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD0023F365;
	Fri, 28 Feb 2025 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777354; cv=none; b=WuzYWfLOMlLtelETSaAAoMSfPvQnqwss7OrEXImw1fVAbo5VbRI8j3P3h+wctZtNtMW8bQNU6godPzFfv9+KqFgOwL5zq8L+wlM52sIVccnJVCQEnIRXSCoffotLgoUvKS4L6l7fIPHJnQNQA3rIz76ozJmyj1rZK1gWNhogU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777354; c=relaxed/simple;
	bh=9An8uJgchYYhEzoiHFV0EjIDHwjWdFHfultlJe36yn8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gnnneYGTqlX7ksBLlb0Txrk3LzYMNOPsB6wF9ll8otqiQr0ENmcIUdUvnJusbVvdj7PNpvsH5qq4R6GshgX9z03nCaC3WOTTG25zwmUqeCvbIwaskp6y5oPhnYpAxff6zhoVPnWvBdarEw+JjQkAXhHsxDHk4nwfsq1ND77XQSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Omu0JuHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAA6C4CEE2;
	Fri, 28 Feb 2025 21:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777353;
	bh=9An8uJgchYYhEzoiHFV0EjIDHwjWdFHfultlJe36yn8=;
	h=From:Date:Subject:To:Cc:From;
	b=Omu0JuHevXfsvZOsLoGr1io0zmiaMdwcNQOnUdQnDhobgfXqF/vBC0TO6Tj6C7c4F
	 dSuoO7XUXPcH06ILqkBv3/G9s2P8V3TlpL1Btc+Hcxy6kX30Vacm41TvlnsTr4mQdu
	 VL9qPEja4wFdt0Sbqb/FbfRzMymuYHj4Gjjn8PxN5l/guhFermxPLaOGLDZqSGfDzW
	 tMOcGGPQFbVTdXEcmcraB8Lvrr6mDDzbYj9KhfX/666Fq7brSRrrEeUOdqmP+AkldI
	 /d/nyKy9YMkeMiIhU4/NvsJmgH9Py4TpVosuZT5cRsTui8P6RHCRxesMjlT121Ou3B
	 NbamX2TZMuMPQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5febd389342so163906eaf.1;
        Fri, 28 Feb 2025 13:15:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/1qAv89+6zF0gkmN+H3my2NrNvg5RLU6HuE8m3OZaHXLKdwwYCRyeNJkDK43R5N8YAPISmxK6i4uNkdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydpKPn/Ts+6EHtwXVpAUTQhevO3eF3xcQsd13K+30hn+VO3MPb
	7goPrgdu1R3UVk25QG1WJCiijWFhS76m/XBJqzLgVAIRB/AHwjmymxqdDEifkLULB9A0RZqzf0+
	X8cMLyb/ZfphS9QtXB8+0KJlwPnM=
X-Google-Smtp-Source: AGHT+IGxtC9aJyfwF1PM1dSj9GdNLyMqQPKIrIbdTMpZxyXPqlxNgubvJBdpYCG7QU73/LVgpB6kn2rEhL1q8iF4Hzo=
X-Received: by 2002:a05:6820:1690:b0:5fe:a901:c2a1 with SMTP id
 006d021491bc7-5feb35eefb9mr3344470eaf.3.1740777352491; Fri, 28 Feb 2025
 13:15:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Feb 2025 22:15:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i5aHWRWPsvWvmqjgNZ5TXiECs47WH3X45+P-nJpLKwcw@mail.gmail.com>
X-Gm-Features: AQ5f1JqBmufWkU--ERmrcLY6ixfe1_r7RJHVGA_wtvn2tcMRhoVqIFhKlYQWSJQ
Message-ID: <CAJZ5v0i5aHWRWPsvWvmqjgNZ5TXiECs47WH3X45+P-nJpLKwcw@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.14-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.14-rc5

with top-most commit c157d351460bcf202970e97e611cb6b54a3dd4a4

 intel_idle: Handle older CPUs, which stop the TSC in deeper C states, correctly

on top of commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6

 Linux 6.14-rc4

to receive a power management fix for 6.14-rc5.

This fixes the handling of processors that stop the TSC in deeper
C-states in the intel_idle driver (Thomas Gleixner).

Thanks!


---------------

Thomas Gleixner (1):
      intel_idle: Handle older CPUs, which stop the TSC in deeper C
states, correctly

---------------

 drivers/idle/intel_idle.c | 4 ++++
 1 file changed, 4 insertions(+)

