Return-Path: <linux-pm+bounces-18619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FD19E5421
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 12:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F3C16406B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F6C207DF9;
	Thu,  5 Dec 2024 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Z+xezRXa"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7BD20767B;
	Thu,  5 Dec 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398832; cv=none; b=SfbW5Bg57c/tGTU5CfZGZ/RDlLRqg9dinjxt/UWVrmejaO/MjQaiMwrZZsDFGJc+ThhECujNmq3uxGEAxuQAJXizMZzlEWxGZdUICIpWOxkzwIO69+i7NrYaifho7RZxr2QR1/IU564WTnuxbyWHAwHgpREUQ+m6HjTi6mMba7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398832; c=relaxed/simple;
	bh=5JydV/bnosY4BSOdc5Cfnwg9FtxCCJbcp5PGe2X5C34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fHspNAmkosM9xmBlLLT5JPFCiUUZ8ANH3CMQQbGGnMem/7vJn5GuzyluPqFujknL5gAVhe1ouRTYJUJTlsaXsmJZV7BuULJZ+lCxvzMDW63wjxldeK+Nzk9a/0vbEWAfDWBHpfZT5CaEMZKpTYBog+lDyth1WKqt/GflMkEd6GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Z+xezRXa; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id caa99672e0bd4faf; Thu, 5 Dec 2024 12:40:27 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6BA4415F0421;
	Thu,  5 Dec 2024 12:40:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1733398827;
	bh=5JydV/bnosY4BSOdc5Cfnwg9FtxCCJbcp5PGe2X5C34=;
	h=From:Subject:Date;
	b=Z+xezRXav50EXAm0sBu/MGD897xK6OVfRr5QBklqksYCIwFrcezjXWQJ5wr1grAn1
	 0GgHN0D5qqwqQbxJi79pY07QplOD1V1siwUtHLPkHCv+JpNFuVYKXU3dFYTy6D3OAa
	 2EXbvQcQsIMowa2o/iIveVG3Ug43fd2MqdSbEma2O/ecVME+ocsQp4hIe1IPIpFoBv
	 dyDUg1Pm7bGvn2DF2j7ZahN97w+pcFMd/j41xDT7FVuNbBx+rUchtBdUuIvou/F+FN
	 PGoOJROT9J62FS9Eq98diQUeOl6d3CU2CS4x9sQCp+hczzy7g/9ufK02ysu1wQaDzg
	 18muxzBjUK6Ug==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 0/2] intel_pstate: Use information from CPPC to compute hybrid
 scaling factors
Date: Thu, 05 Dec 2024 12:30:09 +0100
Message-ID: <1923452.tdWV9SEqCh@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

Hi Everyone,

The first patch in this series modifies intel_pstate to use nformation from
CPPC for computing perf-to-frequency scaling factors on hybrid systems as
per the subject.

The second patch removes Arrow Lake from the list of platforms for which
the scaling factor is known because in fact the Meteor Lake scaling factor
will not be suitable for it in all configurations.

These patches have been sent already which the following RFC series:

https://lore.kernel.org/linux-pm/5861970.DvuYhMxLoT@rjwysocki.net/

but as stated there, they are really 6.14 material independent of the
other patches in it.

Thanks!




