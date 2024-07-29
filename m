Return-Path: <linux-pm+bounces-11555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFFC93FA5C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 18:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C755B227CD
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 16:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E505615A87C;
	Mon, 29 Jul 2024 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Us/RCRCE"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EABE156676;
	Mon, 29 Jul 2024 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269586; cv=none; b=alP/xSfIayKw/WBaMVvi3mqpIWXen+d5QlfR6rlZyXhQunjUyuboK4EYvHNYf3071nKhxy/detOrgOfOsjI+XK7Rb2580AbNBPjuvEgKQG0B1rTdWk1dEU7bqwT/9Uv779+L/X7ZJAIrijb0m5x9mXZMU7LWQs4F17lF1+k721U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269586; c=relaxed/simple;
	bh=tQvnktlYNtV73GLPQxba0oBknnBfSrU0fQY2mTF/++A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W0AMxiRPrZsU8ALLE+f+KGqJHINhULKZPJ5HRAup9gUC8WCWYqI5vkNWwH7DzV8Ih7oGXm9gQBgyy4Ho2Q8R+xSyYXoOldW2d8deRVe7L6lkbb1rIXoVVQMYbeG0ppjispzF1nsIEyF4tFB14XPqlHLitKicIUawZ82LNdvUxk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Us/RCRCE reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 3d3f70d0e1cfbe22; Mon, 29 Jul 2024 18:13:02 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 05CD777357F;
	Mon, 29 Jul 2024 18:13:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722269582;
	bh=tQvnktlYNtV73GLPQxba0oBknnBfSrU0fQY2mTF/++A=;
	h=From:To:Cc:Subject:Date;
	b=Us/RCRCEMq9GwvtUg1LN5CydiLDCOd6q6urhgF0hg8PfG/ynkAvdQCkcEFgM/3me1
	 b14SJfYbHmo/QE18wd3bY7cJT7ywwYhoyVQNmbGnlqw4rah1KmCgwFUdoNAB5rBmH6
	 NnYpWDMF6MldCCQs+nGTcrr66kz7Ea2GrGeFCLEanV0UxYj0kmSpsgvT4uiM5cxCgd
	 YMWDT7T4DZea5OO+HQ2kw687lnAHa6AverwM7yYc0tVBNwzPvxxad8KyowCVPAiyu8
	 4W6hCfab7Ofx4EcPxv2WdeLAvXFmW95J8x1EgxmPKI1Qde8rJ7G0wvz16bF3TjbIuM
	 ro8Sl2BTy77Xg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [RESEND][PATCH v1 0/8] thermal: Use trip pointers in thermal driver interface
Date: Mon, 29 Jul 2024 17:50:44 +0200
Message-ID: <2211925.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghr
 mhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

Hi Everyone,

This material has been sent already:

https://lore.kernel.org/linux-pm/8409966.T7Z3S40VBb@kreacher/

but it has not got any traction, so resending it and I will assume no concerns
if there is still no response.

This series modifies a few drivers to stop using trip IDs in its
interactions with the core, which requires making assumptions
regarding trip ordering that may not be met in the future, and
there are other ways to do so that are preferred.

Having done that, it removes a few core functions that have no more users.

Thanks!






