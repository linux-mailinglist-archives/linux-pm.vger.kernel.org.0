Return-Path: <linux-pm+bounces-7540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB018BD1A5
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 17:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140351C221CB
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 15:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A445155341;
	Mon,  6 May 2024 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="FRuUZrqm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RLTIY8EU"
X-Original-To: linux-pm@vger.kernel.org
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3293B2F2C;
	Mon,  6 May 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010071; cv=none; b=oTCyfIRkBRg5phaC9ECLA4C9GnghgiRyGmsVtHn5r+Sh1MXVCPMfYCPrkLjsOvR/Inz+xcT7zqROZlMnhH93Zq2BIzGXDujRKwf3rAeMI65AzmKrC9Dok37TMG/FETkW4/GYEfJQ/RlDZOyVkGrgp2/Lp0Bg7qirrcM6IegsTPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010071; c=relaxed/simple;
	bh=83WT5D2gRksqNAm9KT17B/kHJOrhrALmJONHZ3yW5xM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XzT+XyuvONQlvIQR9JTCmLDSQuJB7tLB60tytxJSQLxNUrFTCvibRO172kTQrf6KGj8FOIeAKA3W08I8prezijIiVdQnkJlFf+PXhCs87a2QUxducRvXP39pRqmMZXZZXCDNX9k0iEk5xfx+5OID7Ac5ZxHIDCML6HNPTpRL3YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=FRuUZrqm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RLTIY8EU; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 7729A1C0017F;
	Mon,  6 May 2024 11:41:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 May 2024 11:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1715010066; x=1715096466; bh=/D
	C5uI1k86+qbt+4zZuP/1OwGfSJ48DnaIQlQ4lYyYo=; b=FRuUZrqmGA2C54Pi9Z
	5pSv+G69p2DyTB2pBj3qR23Bug0L3oQimeZ2WoYpNKQFR0mzfd6dqnX8wrwHvgbk
	qKagbOa4kpla1MDXR3G1ezhDlBFPdHp6alshsWmERjJySnAteeIXyTXy5RkVGkOu
	paU5jvh/m7U6yxigcIAoIXQPeMF0iB3HlVgx9qZWBgi0R0BMjC6edH1oKGyf7/Fn
	Q/L4+ClDHMQImhOLuc9QuPgTI2MQ3hL7vl9UAwuUjwThkLAPju2Dbpi34xyfHBX4
	vk2gWn1BwkdOvVWbONyAeNrBwQkrXcAeC+hsBSHXNHV6l1VOdi54h+StdWBOTh6L
	ktXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1715010066; x=1715096466; bh=/DC5uI1k86+qb
	t+4zZuP/1OwGfSJ48DnaIQlQ4lYyYo=; b=RLTIY8EUjoCpzAqHWCoK6bSblXAk3
	mjGEquRMGwruBbyI07usrFSX3VYsE5ShwzQJJ0szpAtwKzYodLCJ9Bs7GIR4mnyf
	dpGBhAArK5i88I2W4anThXQAxO95SW3pGFI8g7MAdbik9+SlZNSsO1D7Idim92iv
	trJZUmTOybygvy+HbgINsNjyFAeCa05h5LhJhqnoEPHnqiUkav1YJJ+TbEXg2erF
	KQUc4+Xvh3oHfQXoI3c76kGS7TFtisYOtPObBCGYOD5E2O+SYG3g1wWY6vavzbJ6
	JxV15VU7xXr7KYSa3amVY6XxralEWXhb87U14n5IUXZP09Ckg/8YDkDAw==
X-ME-Sender: <xms:Efo4Zst5y19-2mj7NfaVhFghtP8oK2M2fkl4H1KPnx4OoFRhil6yTg>
    <xme:Efo4ZpdZKTJ0fHQXsN_RngTiRgYrgvZg8srLSmlFgP6AqEvIDi78_-X7-wB-5SnEf
    dtWVQMXGnOvjuJfmH0>
X-ME-Received: <xmr:Efo4ZnwnrQJVOtgiakIj1PYIuYco06gGC0Cq-SvPfWzg_yvGpI7drDTKp2hD_GQnhqi3TKmu85v3B-YZ-pfrR-Ax3pqdNtQQOPuy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefpihhklhgr
    shcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnhgvsh
    grshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeehudelteetkefg
    ffefudefuedvjeeivdekhfevieefgeffheeltddvvefhfeetgeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggvrhhl
    uhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:Efo4ZvOjZuiqT-zVT9GT-fRAjBuqafMwiG_8mT9vKTWdizrvyA6wcQ>
    <xmx:Efo4Zs_kR0X8fE7_LHmdK9iC9DWNyb5TzRpNyIDm7aQJnvTl6BSMkw>
    <xmx:Efo4ZnUC6QiJYM-NyG_diNFYISBoULts6bYb_SGwHuZ_NaLahYgmnA>
    <xmx:Efo4Zle75E_JcQv5UROMiCdvOSGp4MuuifXabRO9w2CPG2fsR-jceg>
    <xmx:Evo4ZgTnJKTXGZbL4J8KnLNlPE1Yawvgy6DulG3h55hSfBYZPLk0sFSN>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 11:41:03 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 0/2] thermal: renesas: Group drivers and update dependencies
Date: Mon,  6 May 2024 17:40:09 +0200
Message-ID: <20240506154011.344324-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This small series moves and groups all renesas thermal drivers in a 
vendor directory as done by some other vendors. The idea is to make it 
easier to spot issues they are worked on by the same set of people.

Patch 2/2 fix such an issue where one dependency was missed for one the 
drivers.

@Biju: There is no entry for rzg2l_thermal in MAINTAINERS. Should we 
update that with an entry for you?

Niklas Söderlund (2):
  thermal: renesas: Group all renesas thermal drivers together
  thermal: renesas: rcar: Add dependency on OF

 MAINTAINERS                                   |  4 +--
 drivers/thermal/Kconfig                       | 28 ++-----------------
 drivers/thermal/Makefile                      |  4 +--
 drivers/thermal/renesas/Kconfig               | 28 +++++++++++++++++++
 drivers/thermal/renesas/Makefile              |  5 ++++
 .../thermal/{ => renesas}/rcar_gen3_thermal.c |  2 +-
 drivers/thermal/{ => renesas}/rcar_thermal.c  |  2 +-
 drivers/thermal/{ => renesas}/rzg2l_thermal.c |  2 +-
 8 files changed, 41 insertions(+), 34 deletions(-)
 create mode 100644 drivers/thermal/renesas/Kconfig
 create mode 100644 drivers/thermal/renesas/Makefile
 rename drivers/thermal/{ => renesas}/rcar_gen3_thermal.c (99%)
 rename drivers/thermal/{ => renesas}/rcar_thermal.c (99%)
 rename drivers/thermal/{ => renesas}/rzg2l_thermal.c (99%)

-- 
2.45.0


