Return-Path: <linux-pm+bounces-38840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CD2C90151
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 21:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE94335302A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 20:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD8230DD12;
	Thu, 27 Nov 2025 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8RDvLdO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0AF30CD85
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764273964; cv=none; b=KhpCHfivPENjZjF5CGeC3FSocuHFUdUqECLaJ0Vezy3v2zClN18nt6JPfNmSjhca7CR63PcxThl3RxqXE9RP7y1ZmPrsWEQMq8F+EM7BGxpC7ndRXCBWFkTcEli7XX8O77ieW4pEYCx1Fy3A2HyV3NucIVfNPxoDzrPww+oVf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764273964; c=relaxed/simple;
	bh=UaMwsBzESN4SeuSxvxkbAFQ4HHSBrSTmGs6AJlypEgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvBEJ2/Uad/XX/n7X052VeCmY+5N0lfSRs6WtDskc/W5VO/X92eNay9p7IPUTJCqX5YbzV8zqypoY9SpWveeXVDPnYfid/szP9YWI+fiVPCQrdr9gjtN5CVSRUX4m/cPyzAqnreF3ZnjVZpii0TR/t+xvlD1pGhnv7dDSZgc/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8RDvLdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3AAC113D0
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 20:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764273964;
	bh=UaMwsBzESN4SeuSxvxkbAFQ4HHSBrSTmGs6AJlypEgU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l8RDvLdOpdfH/zCE9/Gl1c62PuhnamEXspXEQMDEPJgfp0sBAT6a14UYDkLGVPMh2
	 LmTUa9JwSgtQZ4g9OrJyXGok2xO1bO/HRLBi/oHrh8kqKmuTwH/NtN4RsQDWf1+Yu6
	 rSViOIVrmY2Z7LE1N3J27k38GhvNyrBlDcARigbCpT7BkJa/BS96BWIW/zHbk/v891
	 /a6yrrEwpPI9r88m1u/UmKFtXyYgs166GR2iC1khgFIHRPLCAXQOyMDegGaqWgBS+R
	 +6KDoOlYO6vZmQFPoGss6/5ByD9Csnmr3xmiH59jz2A0Y4jLZk/VQ0202JrmmLGe6j
	 o2xJgv31wCT4g==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6571763793bso465052eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 12:06:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXD0k6O6hAU4Pe0Ckg0Bzbzh/HRxPBOXzg1W3dbH56qhIW2pPbIwutmefqnZoTiPfcgzJZTRMnURg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCVbj03kkrGBBpyK7f6rOI59ftUJQmBp/S1Ix7gNDsY29JzcdP
	ujz0bq2AH27WVJ//gDvv4l+j+GgGM1y7S0W6gBl8fIMOh1MbH05b9pwBKyjRU1uKBxKe1BcHPu0
	mFH3jcG8XyHF1JuuE0Wq0j+h3bfms0EE=
X-Google-Smtp-Source: AGHT+IGhp4fwG0crwjBMWy6bDP7eglNe6E7eN9mOVjdh/0zltBBCx/goYjjh2mRhjuaJcOzirioAuk9SkOpefOpiCTA=
X-Received: by 2002:a05:6808:d50:b0:450:c4bb:7550 with SMTP id
 5614622812f47-4514e8343e7mr4992320b6e.62.1764273963367; Thu, 27 Nov 2025
 12:06:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0g6c1HNbxxh088xh_nTgD-SE6c2qtDr81AgD1+by-jnKA@mail.gmail.com>
 <1ea445d0-0949-4a28-9f76-325861a3c57f@huawei.com> <7487e99d-421b-4ac5-bb77-e61c3131bb13@amd.com>
 <CAJZ5v0ij7XizsUkhGRMy_1pqjCAjsHfjsBCuvVarExGGMknPEA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ij7XizsUkhGRMy_1pqjCAjsHfjsBCuvVarExGGMknPEA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Nov 2025 21:05:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i1TdwXcXnv_L15kVZXJKjM8eCHwunStXssb1=J7LzLgg@mail.gmail.com>
X-Gm-Features: AWmQ_bkhF9yQN_3Na8yTphWGUw_7sBJN0rIk7j54la117meLCvDYIQlcyx9ELDQ
Message-ID: <CAJZ5v0i1TdwXcXnv_L15kVZXJKjM8eCHwunStXssb1=J7LzLgg@mail.gmail.com>
Subject: [GIT PULL] One more urgent ACPI support fix for v6.18
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>, "lihuisong (C)" <lihuisong@huawei.com>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>, dhsrivas@amd.com
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.18-rc8-2

with top-most commit fbf04215d9966da61feee3f4ec24dbf4544cfd0f

 Revert "ACPI: processor: Update cpuidle driver check in
__acpi_processor_start()"

on top of commit 43ff36c4a5a574ee83b4b0d3f3d74f09a3a8c2d3

 Revert "ACPI: processor: idle: Optimize ACPI idle driver registration"

to receive one more urgent ACPI support fix for 6.18.

There is one more commit that needs to be reverted after reverting
problematic commit 7a8c994cbb2d ("ACPI: processor: idle: Optimize
ACPI idle driver registration"), so revert it.

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "ACPI: processor: Update cpuidle driver check in
__acpi_processor_start()"

---------------

 drivers/acpi/processor_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

