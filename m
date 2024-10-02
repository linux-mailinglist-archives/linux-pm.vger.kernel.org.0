Return-Path: <linux-pm+bounces-15069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 437F498DE9C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 17:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46BB2B2B219
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB5719CD16;
	Wed,  2 Oct 2024 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="I9t430To"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A42198A1A;
	Wed,  2 Oct 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881182; cv=none; b=igRGsq6tB3fOo4vBDbToDE0t1EFCynvkkkR7a8xB7xjXThSfPl/pli8lctN9Ohgz/hmF5n7K+2N4cGzdKcBqElFZHXUInivSVzsBu+Vg2ymBbli2D6GIRPykwoNi75PQYpv0pFiq3P5bCTAoj1s4QO6AVUiFI9ZHd59/vSZHPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881182; c=relaxed/simple;
	bh=1WsnBfCy13pQWfVFi5UfPBzeJ+ETI+B5ITCwL0hQe2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tFmWl86VuNev25F6W1zB3vBve61caLeosuvb5ilUPFz0h9mYxMcWZ3rFVOk83WJ14dt0JCYy7jk9FLvp1OBbkMfiGEiiTIzyPzd6pUMUpIomze/EGwTD72lIqzLH0y5lF6OUZb9/2L4RpidYp+Ryi4zJYfset0bIpgN4Fv1dO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=I9t430To; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 0a227049cb5da60b; Wed, 2 Oct 2024 16:59:36 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7DCA17F587A;
	Wed,  2 Oct 2024 16:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1727881176;
	bh=1WsnBfCy13pQWfVFi5UfPBzeJ+ETI+B5ITCwL0hQe2o=;
	h=From:Subject:Date;
	b=I9t430To1wvd5ufjVhD/3/vkid8RVP4Wm14JULFKaL/bIDDowoKkxujyB1a2c746p
	 6+0nUAt7sVfc1evChQSDQYFFrq6r6vLUWhdi4fwLsJwijvLkLo8nQD4MMyl+9Z6R2l
	 hPg1z+n/IpoQ2eMCjRX3OvEilfYOKFQfd2ZG9wdCQhHhjpwJxaZyXGaLK+O6ROExN8
	 1Msj/Q1iQig7S635diPXP2QKzOqs8SWFP1tZQaTOu7GORW2KgPoXwsMaXKIST8zc8o
	 RmkxLdhGUjwRWMkwANiaaxq4uAf4d76n+rFBIFxcQ3CLO9KOo2cyrxPLfszq3gqEy8
	 3kLdiQZ+cagEw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 0/2] thermal: core: Fix potential use-after-free issues
Date: Wed, 02 Oct 2024 16:56:06 +0200
Message-ID: <12541117.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohe
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

Hi Everyone,

These fix potential use-after-free issues in the thermal netlink code
and in the thermal core (during thermal zone unregistration).

They have been found by code inspection, but nevertheless they should be
addressed ASAP IMV.

Thanks!




