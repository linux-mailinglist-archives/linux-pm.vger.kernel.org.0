Return-Path: <linux-pm+bounces-41027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B13D33404
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 16:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C18B43001BFA
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 15:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9248D33A9E4;
	Fri, 16 Jan 2026 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+yOwYjT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7005721ABB9
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578006; cv=none; b=OclngDKvqUZPpOMak56xN+I2SHNCudJ/FPfprT8x7HnHWhbK5A4V4Xv8OD9IsH3tLIBqPiHeo7/7TfpUf9bqGxKNvOPvD3N8TRQs4123DlxDXaUfetT/CyZEJNJ7zl+cEdlU5MeFpZrAsABZGavbS8jCgv0/N6NNDvEbcGaln8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578006; c=relaxed/simple;
	bh=04X7+MRBfDwk4A96W7qSrgEak+qKX7jmTHQhdHsY0xg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LAVyuko3UWF6wtCsPCyko2oTb5oP4YjOQQ+MgHeceFxPaqI70Fg1BdubGfZteHdFN5t5IJGsJP8cMisFHOGhbDkfuj1YU032y29I8yTQ/nMT0AUim1HBnwLTgshebgT9sLuFPhat+BIcvheIn+bEY09f64LG2OBgiC6rBD0h190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+yOwYjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EACDC16AAE
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768578006;
	bh=04X7+MRBfDwk4A96W7qSrgEak+qKX7jmTHQhdHsY0xg=;
	h=From:Date:Subject:To:Cc:From;
	b=f+yOwYjT2eChcK9gLgewDOyKHiz/yUtHZzSMopu+ME8vnluFuKWbkyRbHR1cXd7tw
	 ijDgJTRXDUew6vTKom72AjX/kBj4Cfsq7D4Xrur/89Rv4oD+fb9dBBsWq03WDydMrC
	 6TKwhjRyZH4J8x+5iJ+l7EAG0sXEuVfrbkcIih788G00+bnHyqXCZuUxm/wG+v3Cqd
	 rL3qkFNy/EInW5T2gou1ZBNs1B8opxd5j07x74zv5J6p71HXUpXph2oH0/jH0fapde
	 1WzLkVcJxaM5EKWfwqoS1fUe5T/iHmC22i8+YVYIE2fJyZNi83bA3HHPt3Cl7XyyRs
	 xsLclBXpygdkA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-404254ffe8aso1636954fac.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 07:40:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/19ZLCtM4BygiDQXRvg96OKJAbEKCZg1qnxaMJiZ2FSMC8/6WTqsN4j0xkT203+xRCmOu2z8Vqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbwXu9e59En2BddElOFoSRU1LGb9dt78nVILsA0az4nc5djRxK
	GXqYaOF/8YxPh8Xx+bzf5bU5y02BfwBio5voI7sRuy5y04qzDK0cUeHAErlvE369RrqUXlaDhXE
	YumFPK3pw+Lp7HWS8BKw2mxZVyJMgNps=
X-Received: by 2002:a05:6870:f018:b0:404:38fb:5434 with SMTP id
 586e51a60fabf-40438fb68damr2310719fac.29.1768578005266; Fri, 16 Jan 2026
 07:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Jan 2026 16:39:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jppKw_SCf+wia8HKwc0YkxHewfZXSjqiQf-C5AFozR3w@mail.gmail.com>
X-Gm-Features: AZwV_QgZMIOS9PWrE9GZ3ButhTsY5JRiVAEBzMpaZabjTVzPpY5xafPqbE6P3yc
Message-ID: <CAJZ5v0jppKw_SCf+wia8HKwc0YkxHewfZXSjqiQf-C5AFozR3w@mail.gmail.com>
Subject: [GIT PULL] ACPI support fixes for v6.19-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.19-rc6

with top-most commit 7edf6f7ef5345e1b4202912ca98aaa7c73e1e82c

 ACPI: PM: s2idle: Add module parameter for LPS0 constraints checking

on top of commit 0f61b1860cc3f52aef9036d7235ed1f017632193

 Linux 6.19-rc5

to receive ACPI support fixes for 6.19-rc6.

These add checks missed by a previous recent update to the ACPI
suspend-to-idle code and add a debug module parameter to it to work
around a platform firmware issue exposed by that update.

Thanks!


---------------

Rafael J. Wysocki (2):
      ACPI: PM: s2idle: Add missing checks to acpi_s2idle_begin_lps0()
      ACPI: PM: s2idle: Add module parameter for LPS0 constraints checking

---------------

 drivers/acpi/x86/s2idle.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

