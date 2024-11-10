Return-Path: <linux-pm+bounces-17285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F8B9C3219
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 14:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3599028144A
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E941552EB;
	Sun, 10 Nov 2024 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="sM1HCtHv"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F014B950;
	Sun, 10 Nov 2024 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731244072; cv=none; b=i9B1CXxix1z6DszSEjuqw9khwTJuq5qo67QN/aSF4vig06GRHliDgMxBk+gTF1dmWSdypUVMjnOtoYx+o8xiHylI/uHEWgsujrTalZvh7X8W/xXfJmQoLLLdMOYZBlm0UVAfjkebtyWm0dacDNDhFhKmU3qQqsQUv/3vuwY3JRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731244072; c=relaxed/simple;
	bh=Y5HGD4sZg4RtpDrdU4CDWoMpapAddvXYYpPEX8LFcdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cVL/zRhth1CNwJ+CmfKKYIJ4xOZg1zYYjRhKuO81WVlk9x6KoSJ60F8aU0iz2+vR9sZ7YDdNydtGF8sX6zcYThZxDyQcjmDJcgbXMT2AViPV1sruUNKBZEZ1IBvv+jIlkwF7qhUrR60OOq80zwYmS8l4nP5rdqMLjBfF8v7eU2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=sM1HCtHv reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 6ad21690b2e26daf; Sun, 10 Nov 2024 14:07:48 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7B733838538;
	Sun, 10 Nov 2024 14:07:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1731244068;
	bh=Y5HGD4sZg4RtpDrdU4CDWoMpapAddvXYYpPEX8LFcdQ=;
	h=From:Subject:Date;
	b=sM1HCtHvV3ZlDxu+x0H6rf3QSU91fVB51+GLx9UbbBhoFpIq1256v0eo2kne8GcUZ
	 jzqHb1CGN0DeXsHqVado9uH8tUijL9Me1Qwdwze85gqwAIKQYBdt8r+AMcJVS0yZF/
	 zNKzowNKjj1PCcT5prYmshbk1gRr1h+RUU9OyeDpKVzH9rgdQXk4+Gc4QaCGMFzyC2
	 2UfzC16kUPTiuMXJ/u1fzbgeyT9EJ+gf9AMmPIYG3dUrer3sKBIhjJoJ8hQ+EKU0UC
	 YfXpWtPTBp1oIqgfewIEYn/gr7eMms+0bNq1mEc5n6W7voW9+LN42eVrUw07q1ki6z
	 Me6t5aVHkqmaA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 0/2] thermal: testing: Simplifications related to thermal zone
 template reference counting
Date: Sun, 10 Nov 2024 14:03:33 +0100
Message-ID: <12569620.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddruddtgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhh
X-DCC--Metrics: v370.home.net.pl 0; Body=4 Fuz1=4 Fuz2=4

Hi Everyone,

These simplify the thermal zone template reference counting implementation
a bit.

Thanks!




