Return-Path: <linux-pm+bounces-15101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABAB98EF33
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 14:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF721C21A71
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 12:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71151741D4;
	Thu,  3 Oct 2024 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="UVtLf/rn"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB216F8E9;
	Thu,  3 Oct 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958459; cv=none; b=Ps9LbBxcXjKiYSVHqMVQo3YerMUMJVLrnWpVz/Lqc3g5JFalLVmDxptf7c8bLh84SY+MHUGuCqEVNSY7wXFl8K6lg059ldzq2dXguw5KZZSmjOtHofCkEI9jxAULKkQ2Zpkve7GStT7GeuaoFtbz5k61gP9rZUC2GohgIyq433Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958459; c=relaxed/simple;
	bh=Jar3oUfzCe0cIFm3kfMnxBFkaTZ4qn1SLJRhfyHhm+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hhd4gMYtZwRE0BCFJxLveJR8wM0UcXOzv+wVYFYTP+QVwSEX1fXuY/ZbBxC7V4KzetDyKZZfPShtEPkGiVrnP6Pst2vOmtLRohqi2RsG1GuxaqSNAShgu5g4ZyEhJlTOs/Op38uIe8mz4BRpalbISiz/p2b/JAbV6sC+qkaWyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=UVtLf/rn; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 9191f5490510dafa; Thu, 3 Oct 2024 14:27:34 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 86BB26A94E9;
	Thu,  3 Oct 2024 14:27:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1727958454;
	bh=Jar3oUfzCe0cIFm3kfMnxBFkaTZ4qn1SLJRhfyHhm+E=;
	h=From:Subject:Date;
	b=UVtLf/rnRcypoe/U3qwNdpsNq5PknKjTkjrRQlRsVLsI6VaeNzTms/evmk44skpj1
	 QSIIg/qxbx+XCb88vscSQnFV781XoO8hbX2Pgis5lpwLqjXsoYnW/sX0YUKdjAxwmO
	 WQ51GM9D4+UvQMePASqr/RB+4/Aj/d7ekZ7toGc8b+BsO7Jbfc67uj7O5KeWzRMhLF
	 8khDwSIRoTYmP/gSE05+Wtnj6mnrKBC0MXDLsn+VzN9ssDU7WgDgVpUGtZ+Pr34fG0
	 W4BfU2Bbpb/0DrySd8y+NSh7Y3vTe6OeRdkRYYjP8wHMjRz33tWEszZ1mgk+I1PGFT
	 dTtEJPZ+s9sRw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/2] thermal: core: Fix potential use-after-free issues
Date: Thu, 03 Oct 2024 14:23:52 +0200
Message-ID: <12549318.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrgh
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

Hi Everyone,

This is a second iteration of

https://lore.kernel.org/linux-pm/12541117.O9o76ZdvQC@rjwysocki.net

which updates the first patch (to make the code changes more straightforward).

The original description of the series quoted below still applies:

These fix potential use-after-free issues in the thermal netlink code
and in the thermal core (during thermal zone unregistration).

They have been found by code inspection, but nevertheless they should be
addressed ASAP IMV.

Thanks!




