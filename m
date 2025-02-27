Return-Path: <linux-pm+bounces-23061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A47EA47C92
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094C13AB633
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363BA22CBDC;
	Thu, 27 Feb 2025 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="HdHx+4l1"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E284374F1;
	Thu, 27 Feb 2025 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656966; cv=none; b=uhhtfNprcI6c+e+HYJh2Vpex9Tnb8781pPiKW4+h67+6XCuiz8HC8xB5LHYFLG1IrrA2Wg3M5b+zNMj4HzpoUaM6wHMoxV2F83oiwWstlLltHMTsVmBO2/XQhKS/0Igy1Z5VwOllcwsTH02IPxcDft8DwOCjbExrqsqGQpCY+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656966; c=relaxed/simple;
	bh=85lMz2M0QYHYQ6bvLv6GGi/2p5ZaXpYYj4wUS4wT9Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M9EYz7FyKDmxFpvqSN0snHINnWT0PUJCHtnzod0PS2hPZwk+gV8q9nFGfaYoSRScQ1A2g1jQF1no2IGvovDVFQTher7SONn0wa2yBh9D+GBW/KTYBk/wFaMm+/4Nu0d44P1x2UMEOR3OGLEH2E/uVauhIuVDRyGvhdgM6j0/ixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=HdHx+4l1; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 33343677ed09fce7; Thu, 27 Feb 2025 11:49:22 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id F35B4D50215;
	Thu, 27 Feb 2025 11:49:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1740653362;
	bh=85lMz2M0QYHYQ6bvLv6GGi/2p5ZaXpYYj4wUS4wT9Xs=;
	h=From:Subject:Date;
	b=HdHx+4l1Rmr42SpTQWfOXg1asn+wghFLaF4mSt0+Kqjs23AFOjempx6GMeaoVOR6T
	 qS+k8cHb669tn6b6GY+AdbahUHdynjMExc/XWg3GCELcuW+6al+U1jCUAN6KLuIWTh
	 yGcjbNN/gx339RMTD2JemWbUbVh+IRwz4pJJSyopjiyZqTL33JBiCu0FEq/HutKJVF
	 268ZBDhOg18t6m2N/u+YBPEg2qICp7CfOMoFhQsWgszrTUfWkvUaM1rfGcaYcr/DyJ
	 cL0Cm5imXf+k/nyF6XRh7zOc1ES7upuTTgtRbowcX8rx9R48k4w+hnXtMiMeg8sgPo
	 nPjWH1misj/Hw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v1 0/3] PM: Tweaks on top of "smart suspend" handling changes
Date: Thu, 27 Feb 2025 11:44:23 +0100
Message-ID: <5000287.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjedviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepjhhohhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

Hi Everyone,

These are some tweaks based on

https://lore.kernel.org/linux-pm/12612706.O9o76ZdvQC@rjwysocki.net/

which in the meantime has been applied to linux-pm.git/linux-next (as 6.15
material).

None of them is essential, so if you have objections, please let me know,
but IMV they generally will make the code work better.

Please refer to the individual patch changelogs for details.

Thanks!




