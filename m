Return-Path: <linux-pm+bounces-17814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787589D3A2D
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 13:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5515282DB8
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 12:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D173B19F116;
	Wed, 20 Nov 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="A4iSzali";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YLsoikh7"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFCE15CD41;
	Wed, 20 Nov 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104246; cv=none; b=XHnhqLtHl87kMpksaKN3UdBQY4LsOviFBXHiw5b3GSXTaex+ok766pEJpiecZZT7oSu2qsN48ZeLqDDW40i8m4mXG973XcZ99nxHVzy3X/NdLpOsEGMpLlGDuUApB17rc3QNLDdmBNSnmh2XiE1nyB9Y5IpbPESZ7FGyyKI4Lic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104246; c=relaxed/simple;
	bh=A/uzbKJFBRgJE2ZNVlRRZtvMMz+uzLzfhYTOZ82jqdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bR7CWD9m4j0AK8Kohd+puhuz2QlR+4n7SONA2PMZfNNsCrkEqY+CkdjdrIQ6r3ko6xYtApS+7RWOc6kXqklbB1eoBSq5cyl81gIchMGAeq77DHod3TjDaZjRs1spr6fnKNVVwBpkoKpmQRIw4lI3Oxhsh+fBqPxbs8OxBuDUaeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=A4iSzali; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YLsoikh7; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 95C591380092;
	Wed, 20 Nov 2024 07:04:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 20 Nov 2024 07:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1732104243; x=1732190643; bh=c7
	qXe0UTcQteZArnBIGzuADDt5cjD4JOTvgbSmJQcFc=; b=A4iSzaliYotfUucBl0
	HWWE/TkwCqn69FnjXnsfTOApqXZP8Vh9CQszzq4JEMA4TuyM1tjK+FIXprqeOcZB
	Ax043L2Op+Fo1WfDNsVSkvl5W492HYTP4BfrTwFVJhFyJELaSt3EK25Hymwcy9Md
	SWKKKfsr95Piq1FqK+8xjOX7pJjpeCsIB01pFlcTzTH3Z4MXGxnDCyEchv732b6P
	qPCIRUyh0cAelmLECjFydpGQUzVATYMHGpHAMjpdJ9QxkIMvcG4KVPDNX1TO57nR
	sJIDOy/HjmY/YQAfFvmnfdlVVOSUi4tD7DpPws/2pDEcHErNy5dqaJYYpSPj04iq
	IrwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1732104243; x=1732190643; bh=c7qXe0UTcQteZArnBIGzuADDt5cj
	D4JOTvgbSmJQcFc=; b=YLsoikh7lvPAdLy7L0VICGxmFWlPyefAvBkXhDr7cuiU
	2DIwfqPpeJcXprwmyuj+GOhOCxu03/SfhZvmqARBwgycsooGwJcyRk9ezF/QfU5i
	Y4siZguQqdzTHeTVtv1Sqc9pzEO+gg2lWInk0czC6gL0sRdAqwZ/vmTTIhzcDEVu
	ythiuxksi+RKBYrf7C22e0eAH/T8PUg+U8KNXVgEkmRfszTlHpYu7UrleMs5myih
	7YwbXw8ocQ/6O3NsTts59oqAj4w/Erjbq5phe7t0AbC6wpoDDIvA9WCRiLkb9tdI
	iYT82iWc3ghEfCS3S+IqygjAEmk+mzKYbEXu47nszw==
X-ME-Sender: <xms:M9A9Z3GoimZ6dBJhODH-E_kyvuZGEB5hJBYj1Csap5LFXb2SxmY2zA>
    <xme:M9A9Z0VagcpLZ-ck8csH0TofIAJkXdCmx5dBR3X94VccmxSo7pUE-5XWBBmpVSBbH
    79PEW8iH57CplrVVXc>
X-ME-Received: <xmr:M9A9Z5LFKXXuTxDjL0iTN2_QC3bdI63_uomEbiWc1zgid-aL8raVInB87jgpa7DF6t3F239WOSlMgY-fwaJIzl0XFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfh
    rhhomheppfhikhhlrghsucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlh
    hunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgrthhtvghr
    nhepheduleetteekgffffedufeeuvdejiedvkefhveeifeegffehledtvdevhfefteegne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhikhhl
    rghsrdhsohguvghrlhhunhgusehrrghgnhgrthgvtghhrdhsvgdpnhgspghrtghpthhtoh
    epjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhord
    horhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphht
    thhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqrhgvnhgvshgrshdqshhotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnih
    hklhgrshdrshhouggvrhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:M9A9Z1G3xW39FnplPiSHlBLt-EC5Y5qcP1AohKL5wILUC4T9cUf26Q>
    <xmx:M9A9Z9WX0dh1hnFtup6sXN4jtwAWQMu--PcjrUtq0aNc3gsnyJ9-7A>
    <xmx:M9A9ZwOg6c7b1T5odH6O6UKMlVhmRCGHpMSoxnmFrnTELM61tQ4tWw>
    <xmx:M9A9Z81knY7jQugxvfFBS_8jdoQ7gPXshVQz-L3i8D7bzKTu5gWnRg>
    <xmx:M9A9Z8H_OSfOctCq2aQmhuysKutqdqE1E6v1VBPa_vWyB6l5_oX39Ova>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 07:04:02 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 0/2] thermal: rcar_gen3: Improve reading calibration fuses
Date: Wed, 20 Nov 2024 13:03:34 +0100
Message-ID: <20241120120336.1063979-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.47.0
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
the fused calibration values and the driver fallback to hardcoded values
only Gen4 have really been tested as I don't have access to a Gen3 board
with fused calibration values.

See individual patches for changelog.

Niklas Söderlund (2):
  thermal: rcar_gen3: Use lowercase hex constants
  thermal: rcar_gen3: Reuse logic to read fuses on Gen3 and Gen4

 drivers/thermal/renesas/rcar_gen3_thermal.c | 95 +++++++++------------
 1 file changed, 39 insertions(+), 56 deletions(-)

-- 
2.47.0


