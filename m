Return-Path: <linux-pm+bounces-23496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 581F8A506B8
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 18:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D8E3A6C93
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 17:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56ED1A317A;
	Wed,  5 Mar 2025 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="j8KN+BTp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NuN8zo+t"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BDB198A0D;
	Wed,  5 Mar 2025 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196842; cv=none; b=pMpWlU7gYauviyS4lGtyJN3dCVEv3ov1Kw/hWjlCsn9D9b0PciUfj/4hzvsxTn++r12gDqJpryy5Oo6R4hq7Iv+ON4geYeN3O1uqCst+ns5K4LNs/NHs4FMxkQ4MhA9eWZOq7oU8KkHAS4Yv+7ty8gzPzSYAusnjRaAiDC3eXNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196842; c=relaxed/simple;
	bh=f1+UTpKlC4PMUklAk1R1vw95QbZFxwtMDnEjaAJmvr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=it1ufEZN3oIxACPSJx5NvSJcukwBpFBc7KcsimCAgSDuNQlpqvI7qsTptxjPxOtpyS71F729RwL9DnvQfT9MuB1w8g1EffvPPiOS2lHi1yta7eZRxhlRzFa/itiyd5/pb/IwjONKTtPQBC4iqG014PWnhI/qLkR9ueMZIiEVvsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=j8KN+BTp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NuN8zo+t; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 99B39114015F;
	Wed,  5 Mar 2025 12:47:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 05 Mar 2025 12:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1741196839; x=1741283239; bh=aO
	QgaZQNUVttMX55uk46kNymM0NpV6zoAj52SI7QW/M=; b=j8KN+BTpfSwSYyovUp
	0fuQOyvTtxywr7n/gmPR0vroEPo/SV4+FrceqG4Awidulm8mK+5yx2BjKkuu7uXd
	BtrRmsW5DMXuLJtEG0dOO3gCOy6w1y9UhqPVwx8cvtp8dgp7xbYH5/m1EZcdVYuz
	fvMpbyfyLGOvvaT/NoLoBnwopD3zGFzN4YUw+ZtCftQpf+aeS01dU9Fe4wkLVEs3
	ag6P0izI4iJjbVMxp+gunqGaqvTTUl/j48HTyGnQXLVVX/EA2unIj0R+hQy9GgIz
	ZSVde4wxW4GSk9nDzmT2ChYiYvsmQ6ANdtTfB/fL4v/Z+YDdQMuSs5ghTfZlIvHA
	1kJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741196839; x=1741283239; bh=aOQgaZQNUVttMX55uk46kNymM0Np
	V6zoAj52SI7QW/M=; b=NuN8zo+tI64uyV35Jzck7bTrh07CmC/lS2bJwSfKgG1m
	1Iw5AFoPleSGZG0frrGU96RAfY7ifxvbIY5y8dIkwbnoPO7J80ab9MTF9SAJgY9G
	jBNDaFUj8JvLNri01CqKHFN1XvIXR0Ke6pez9ss/cTGDgip7QFzmeVXPY8X7GEAh
	HRsrEigYmPEtNyQI+31U7DGZuuG0IKbu18LNY1EFfyCOsWkGL/lJhoHJctClt1X+
	dR3Vh6YMsQcSD5Lrz3Ccf1MJy5ao2/sOiXsnTQtgHga6eDOC+XfQQ9CwC4/+5rRB
	E55xzLdkyElSZCCBF696LjPxS+GQyhnLSHhOxg8Byw==
X-ME-Sender: <xms:J47IZ6fFkv4vIU_kxYqAVQDsX1pANmUgYHPC0yoPKVrld8Aew1MgLQ>
    <xme:J47IZ0NO_JFv5tWPeSuREJrHoExLtiN4iTxKWzaVie8OGsVcHZxXSB9e1_wzS8v4a
    IJJhCeA4jtef5KSYcs>
X-ME-Received: <xmr:J47IZ7jc4Q3Dq5sgSq1sdZlabcjMhYBKvWOJJIFHCxMiwr9CNwskumrH0lhzd31BnbE_dedXf2rXnx99DWWhrUI49w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdej
    necuhfhrohhmpefpihhklhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhoug
    gvrhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrght
    thgvrhhnpeehudelteetkefgffefudefuedvjeeivdekhfevieefgeffheeltddvvefhfe
    etgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehn
    ihhklhgrshdrshhouggvrhhluhhnugesrhgrghhnrghtvggthhdrshgvpdhnsggprhgtph
    htthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghfrggvlheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrg
    hrohdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhr
    tghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehgvg
    gvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrvghn
    vghsrghsqdhsohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhikhhlrghs
    rdhsohguvghrlhhunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvg
X-ME-Proxy: <xmx:J47IZ3-2-yNLxRcb1AtEzQ5wM342iJ3Rv7iAgYCOSxUAC7-K22huIw>
    <xmx:J47IZ2uSehMHGsreXFdavhZvwIt6DMJ96PTeGSliLAC5xeJlxPqCrg>
    <xmx:J47IZ-EVR7CvIEYQwOyijfpf9VToxfrvjnTlAS1y_9av3yA-7iAeiw>
    <xmx:J47IZ1MI9qcwCGF-kTgMAwHqbag86WDC8YSwN5-Rgr1zWPfxCiyjjA>
    <xmx:J47IZ0BjIYXrqzDSD_k8IZSufmtcM_1Y9EeFNV_K4RYB_S4Nd_O2cVYx>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 12:47:18 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v4 0/2] thermal: rcar_gen3: Improve reading calibration fuses
Date: Wed,  5 Mar 2025 18:46:29 +0100
Message-ID: <20250305174631.4119374-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This small series aims to remove the code duplication that was added
when adding support for Gen4 devices. The logic to read the calibration
fuses are identical for Gen3 and Gen4, but the registers are at
different offsets.

Patch 1/2 is a small drive-by patch which fixes a style issue of the
constants found when working on the fuses code. While patch 2/2 is the
real work removing the code duplication.

It is tested on both Gen3 and Gen4 boards, but as not all boards have
the fused calibration values and the driver fallback to hard coded 
values only Gen4 have really been tested as I don't have access to a 
Gen3 board with fused calibration values.

See individual patches for changelog.

Niklas Söderlund (2):
  thermal: rcar_gen3: Use lowercase hex constants
  thermal: rcar_gen3: Reuse logic to read fuses on Gen3 and Gen4

 drivers/thermal/renesas/rcar_gen3_thermal.c | 105 +++++++++-----------
 1 file changed, 48 insertions(+), 57 deletions(-)

-- 
2.48.1


