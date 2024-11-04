Return-Path: <linux-pm+bounces-17006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEA89BBE46
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 20:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6DF28276F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 19:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079291CCB2D;
	Mon,  4 Nov 2024 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="LJfC5Mhi"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0F1CC165;
	Mon,  4 Nov 2024 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750066; cv=none; b=BN06Nu+QDXENhKR25LB/XtyLMIW+8zalfwgWi9UIbmJ59XfbL8wdd4B1y8CWK2gop1RPtZ1peKUxw4Ul86jw1ClW1cnAxnFIpp+suhoL9lbuf7aQiRGwFM8qbLe9jXDElIkC+ZMc1ZGXOHy2uyUqcTmeT6VkB0lgK4j8jkzRkP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750066; c=relaxed/simple;
	bh=9jIEwPXK2ds7y1zUY3VPEyiOqkJFA4itaC4tP+Cd+Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nGdNTjMAx5f/w1ylgGbNOo7OZB7UUTwFByQxbuKkSBcdXOAwMT41f2ZBFywkyE//d8h+cHR9ooLbmK1zxi7Z5vLgVfdlYvHG4azPFoQ2zMI+xuoxCXvLkTceRQMOYF33vp3oFAA+zD1vpAFGbrauHh4RVbyT/+bH4rq1BY2C/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=LJfC5Mhi reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id f15b92bcbaed4747; Mon, 4 Nov 2024 19:54:22 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 30D84950B7B;
	Mon,  4 Nov 2024 19:54:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1730746462;
	bh=9jIEwPXK2ds7y1zUY3VPEyiOqkJFA4itaC4tP+Cd+Wg=;
	h=From:Subject:Date;
	b=LJfC5MhiLrSwj3b0u4i7s9Mz1fPMjP+XjsvPuqUj6Sb47NrxV2GvPrtZ8ni5/i13X
	 +WLHAy/D0ImXZQMVt5u2j6g6gVeEhqG82KSLLxvLEBJahio1kXA07fuoSBh7nUv3jq
	 /IDaiGNlmk3TUCHk+ksOPdHDokHNyR++OkZbRLx67GhQfEPx5/MBC3v+2mRQvL33tm
	 qdJOW/KZN0i7b3K/9UMgDKLyaA5KuIR9o8U33JgV10OlE3js9aCqwR6K4+8MWoX+R3
	 3nRj1i3BYfBj3xglSsoPSGpoKMkCxtJgCSXQDCsp86n7KM+btkUF4lKAlbtugDTAK1
	 MRgVIunK/w7Zg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject:
 [PATCH v1 0/2] cpufreq: intel_pstate: Compute capacity for CPUs that are
 offline initially
Date: Mon, 04 Nov 2024 19:46:03 +0100
Message-ID: <12555220.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrihgtrghrughordhnvghrihdqtggrlhguvghrohhnsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 0; Body=4 Fuz1=4 Fuz2=4

Hi Everyone,

The asymmetric CPU scaling support added earlier in this cycle
does not cover the case when some CPUs are offline to start with
and go online after initialization.

Patch [2/2] adds this missing support and patch [1/2] is preparatory.

Please refer to the individual patch changelogs for details.

Thanks!




