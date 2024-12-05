Return-Path: <linux-pm+bounces-18617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B339E541E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 12:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3875218826BE
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FDB20767C;
	Thu,  5 Dec 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="OsEkz/Rq"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C9207672;
	Thu,  5 Dec 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398831; cv=none; b=KPMICkjCXjsx9qw1SJ7EYhNh0+Oxw7TVROI8ta4Z/6ln4OBXy37OeUz/vqZ1tqWrT1FepKUuH8J+Pm4B+vo9cw8vPQIXE176+hoAJ6KsuC5P/fBOqS9y2SCv+5kZj6n3kI1KqBDaYPa+yzVIIEcD6+MuP7EY/ZqPeKFNomBFnWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398831; c=relaxed/simple;
	bh=EI/lxQaw3hKAdW8VAbz7As50feekjFVKCkI2lsa47OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGAmgQ1h9c+Q7H9Guuk7WMnXy3itl/qCPCjCax+cINpHiFK0JiFxZ0eOyBBMxyowq1X1WLe2k0lanRMYMCBgy1zd39XsiO30/k0F2n+UK+UP2AFzIOtmY98kvZ/6pPa2R6fkq5OjRea2mComt9esO5ofqSAJ7H7tLPXu6NvROSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=OsEkz/Rq; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id d08b6202bb9225f0; Thu, 5 Dec 2024 12:40:26 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8723B15F0421;
	Thu,  5 Dec 2024 12:40:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1733398826;
	bh=EI/lxQaw3hKAdW8VAbz7As50feekjFVKCkI2lsa47OM=;
	h=From:Subject:Date;
	b=OsEkz/Rq7XA477UC0KewWchzJAeHGMPXeWFyrON3cBNdsVuPBcvtbJTJecUpoBH4j
	 5/OS0zUXj6c7gDkuP5NVuRExpAmmn3olPoh7kkk9fm5pFs0hopSUod+Uj43ym4GrEI
	 jI/Fjc860pL9HYTEFXIoxBGialI3DjcGQ/jE+R5C+aKMNM2Dn4ay9WdnaueVdUNVcg
	 +dSFR7czx/75PSZX0lcXIxmYdVvc02hj9PJmIJMWya9hX6qkGuCffLRhDWfgLRQofl
	 BVr6A3osSM86ZBTdKW6nUU0Sp+1wPoRMmAjEFjRMD+KM3AQAVNz+7Wp64CCRUeKrJX
	 hVb2HYmLzGlQg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 2/2] cpufreq: intel_pstate: Drop Arrow Lake from "scaling factor"
 list
Date: Thu, 05 Dec 2024 12:40:19 +0100
Message-ID: <2307515.iZASKD2KPV@rjwysocki.net>
In-Reply-To: <1923452.tdWV9SEqCh@rjwysocki.net>
References: <1923452.tdWV9SEqCh@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since HYBRID_SCALING_FACTOR_MTL is not going to be suitable for Arrow
Lake in general, drop it from the "known hybrid scaling factors" list of
platforms, so the scaling factor for it will be determined with the
help of information provided by the platform firmware via CPPC.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -3675,7 +3675,6 @@ static const struct x86_cpu_id intel_hyb
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, HYBRID_SCALING_FACTOR_ADL),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, HYBRID_SCALING_FACTOR_ADL),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
-	X86_MATCH_VFM(INTEL_ARROWLAKE, HYBRID_SCALING_FACTOR_MTL),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M, HYBRID_SCALING_FACTOR_LNL),
 	{}
 };




