Return-Path: <linux-pm+bounces-8084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C238CD812
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 18:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C01BB237F0
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CB529413;
	Thu, 23 May 2024 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="mu7f6z0s"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16B7179A3;
	Thu, 23 May 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480323; cv=none; b=mZlfigaylgKes2aTkqo9G5ZswqrooOBgoTemZsESkYng7OHh7Hsul3PxGmHOOkFIXejvqJu4PrYnZ+tjcGI6T2JBGbfBnD9OxrTFlylZuUYBiojq9hDoF0uHSsuO7aW1mJlIgCm19VptW7e+IGhdXzzSL1xgyL1NpLTYdXLM1aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480323; c=relaxed/simple;
	bh=Kb0DuLDamlDaFw4AvIQDkDhVVzINyrkO6rekMCxb7FY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S6Ce0EIEYe1eS3kpW4zzJbymrP2Fc/j0mEiMBPdFuUsNr+BPnsF4KHtJH/aSWBtI0Mf6268olnL7dADI848ey8QEUms5mPwhiBQQUdzUt4v7QOq7Si/eagM88Vxpz9Te5aOOf1vq6g+Qmp/mbOgC154PyVeLddkfT17NOZb+XZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=mu7f6z0s reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 5abe6376e46beec5; Thu, 23 May 2024 18:05:13 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 59F126A4927;
	Thu, 23 May 2024 18:05:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716480313;
	bh=Kb0DuLDamlDaFw4AvIQDkDhVVzINyrkO6rekMCxb7FY=;
	h=From:To:Cc:Subject:Date;
	b=mu7f6z0sLyPot64BXCTsHne7LnpzEFZfG+NXuoNLjUqT1YgJnc9buD26UjcnHF98a
	 lRseL26bp2fm8TeCYRJqiuzlKOEcj50wFddstEPLmXCx3DJ6hgy5m0I1bPWPCaYYLZ
	 P5uAEc7jVm5kj9FL34WduQGTydkz8S4QI6sGW2o2HhxlzTwaxjkhy55l1+VHU52bPF
	 VvAaVqCT/vX9L5xDokYnaSMYrISTFM3G5Zk0dqDvybcnLSdqNhSYRbONPfzS2bbPVd
	 tvuu71JEZhgVMIa8haN0mToQCghLC2+Dg2xa6QcpBDtvzGr1qWe1H9Z27F7muF8TSb
	 +nmsQCnJZOZtA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 0/4] thermal: core: Fixes related to trip points that get changed
Date: Thu, 23 May 2024 17:55:13 +0200
Message-ID: <12438941.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghn
 oheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

Hi Everyone,

These are fixes (for 6.10-rc) related to the handling of trip points that
change during mitigation episodes involving them.

The first two address the handling of such trips by the thermal debug code, the
third one is a cleanup prerequisite for the next one, and the last one amends
a recent fix.

Please refer to the individual patch changelogs for details.

Thanks!




