Return-Path: <linux-pm+bounces-5511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5381F88E6CA
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 15:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A301C2DE67
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 14:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A546112FF8B;
	Wed, 27 Mar 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="oiCi1rHS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BUj7tqJL"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow3-smtp.messagingengine.com (flow3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4137AE541;
	Wed, 27 Mar 2024 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546243; cv=none; b=eo33NfJOHjn4IEY0byCtZHIO5hn9pkY+fJ7iGP9xJZmtA6HrLXNI2LwHc/N3KqxKb/PonQLIK7yCYMDu+wVseQc9drRhuSqdHlJ3/3qR8eOcE0C08Tx7ZZnbtw0ym3TkNgBETcYvZstPliVxqMqgx+RzUn27ES8zf/5vsVv+a/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546243; c=relaxed/simple;
	bh=BY4/vtZK3LCqDKwLcxu72esODdQEavH43eahGm3T92A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QBqTIBbQz1wDYh6CxEWC0aAqdROoT5kAsdR6985u3S15tlHpLQnUrLzou+UNRJkX4v0hc9F8Okh9RFiMYVAXMFHVz9rsvuXjElyNkD8+kGjMihh7yrGswK8i4wNEVODWP7uCB4YLoZvJs6GPx4ahWgyiyChxQrINAEmsbh1NBLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=oiCi1rHS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BUj7tqJL; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailflow.nyi.internal (Postfix) with ESMTP id E992920045A;
	Wed, 27 Mar 2024 09:30:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 27 Mar 2024 09:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1711546238; x=1711549838; bh=Av
	rN8vzInwuou1Yn+WkfazvX6KbksJ8KKKruaCxebd8=; b=oiCi1rHSjn0nUPkn0d
	Q/0jHs/QEaCM6BlaBDdTcyJrTgAEkESp3GzdT6byywIkXLtECDQq47xTIUIqdHEd
	pcvsCWWQFT5vRI0MYg+9TyfJfG4Vijw5O+VXZIbGO6xwaAkTpi8SAPN7P4Ut5qRk
	1N9GttqnaQToAikDdkAmJ2mRVeZIFLv9BvpJ/yDrtrDMV8C8gw9ZavCY6Sp7kWrW
	SYIFUG9FwbYS5LtoDjwBnaEag/BRZ5/HBSjZa3duEOWDT939wTGTOl+bTCLaWCC1
	9CttTV99u+FaTDtKrMLSamWTpekqNuOYZCa4pOjciJKpu/oo5xEcw/G2KuXOkaN3
	meqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1711546238; x=1711549838; bh=AvrN8vzInwuou
	1Yn+WkfazvX6KbksJ8KKKruaCxebd8=; b=BUj7tqJLSx70lmFSD/M+mTQl0vbWX
	AMmcspOy4PLo4Qu2/QzqtsN6/ScH9rLYvwu2SSn10AXu+ogIAvdFkoqBFZs+U/eo
	r5uWwDtVWzp880OUoqc2YMB5FXIksDHD9K39sKWmoKVK0f8ZR2xwAMd0hreh6uOE
	/+HiUIVsfwh9WoelTjDYyKGDRL28rlGhPy1nGxOKNX1vSEJFeb1V8eUquICPUVRU
	yqBkWiMvli1vg1g+mnuLhSANZZUCGZUABAUfs/vpQVUUQqNrlwkjP1k8njeF1iDa
	l4b7R23ooxEHNKczUxp3guLDXEF6oiixVQV8ER4e+F1VI0aX8id2rqUNQ==
X-ME-Sender: <xms:fh8EZt7AVOXJ7lVxt9UUuyjcWJqEBAe0BGq9X04ro-cAYVzPCdr1mg>
    <xme:fh8EZq6u-2LZ_9mzgbCnC1QnFKvTnfj_nzTtzSMdqdbFR-WN8sXt_54FVaTa7x3al
    3amqfi7YJA2AIjEG6E>
X-ME-Received: <xmr:fh8EZkcM4idubRJF5zTbP696JRgbLPq9ei1ZZ3vFMAF0ZdbG1e0dh7jNEtCpyrjJjX9wf9TVeISKvve2mLn65tsnzPCFrvFLzAr0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefpihhklhgr
    shcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnhgvsh
    grshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeehudelteetkefg
    ffefudefuedvjeeivdekhfevieefgeffheeltddvvefhfeetgeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggvrhhl
    uhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:fh8EZmJwnjq8XjyqQXhp5o6brTppBwuSBgBirTM_quXe0QF2g4150Q>
    <xmx:fh8EZhKqCSFwQRNrfjP3exNHwU5dn1IHl5vHlnF3S64L9wHiDwQevg>
    <xmx:fh8EZvwxaKXQwtwbKx3g9EPCzEjRIJ0oFmpstBaEEyUVrf_SBzmPiw>
    <xmx:fh8EZtJBMxmMZ65YSYH5x7vzh1jrPoWrZ3XFVrubRTkIMkXpvAKy8w>
    <xmx:fh8EZo-UWExgxYR91e7RImJ0MCDjFTCRzv6J-dozlM_wSipqzSWHqHIqQLE>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 09:30:36 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 0/2] thermal: rcar_gen3: Use temperature approximation from datasheet
Date: Wed, 27 Mar 2024 14:30:11 +0100
Message-ID: <20240327133013.3982199-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

When the driver was first added the temperature approximation was
reversed engineered from an out-of-tree driver as the datasheets of the
time did not contain this information. Recent datasheets, both Gen3 and
Gen4, now contains this information.

This series changes the temperature approximation formula to match
what's described in the datasheets. It has been tested on both Gen3 and
Gen4 with minimal changes in temperatures reported.

Patch 1 is a cleanup making the scope of a constant more clear. Patch 
2 is the real work changing the approximation formula.

Compared to v1 patch 3/3 have been squashed intro v2 patch 2/2. This is 
due to a suggestion from Geert where the precision in approximation 
could be increased while removing the need for the changed done in v1 
3/3, thanks Geert!

See individual patches for detailed changelog.

Niklas Söderlund (2):
  thermal: rcar_gen3: Move Tj_T storage to shared private data
  thermal: rcar_gen3: Update temperature approximation calculation

 drivers/thermal/rcar_gen3_thermal.c | 165 +++++++++++++++-------------
 1 file changed, 88 insertions(+), 77 deletions(-)

-- 
2.44.0


