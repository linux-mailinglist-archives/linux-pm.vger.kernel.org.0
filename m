Return-Path: <linux-pm+bounces-18705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A7A9E741A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 16:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808A228565C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C791EC01B;
	Fri,  6 Dec 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="QLXS/s4t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O/Bc9Old"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00D284A3E;
	Fri,  6 Dec 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499080; cv=none; b=dk4H/Xr5cLgLBDNj2xcPNeLkFXeHZqUAbQwBpoKjkOu20zOwHXJfN7vfjpeNWmcGJFYBrzGElSM0IfxXw+OIzBXv5O69M34LRkxk7D29brU/lAg96OzNt685Y5H1c4cxI7uPnebYRp3YcdIx0/VJcgabZLwECyEJtujeliySUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499080; c=relaxed/simple;
	bh=bIrc8n6NPURZVpfhknwNXPh0GcBa2SBTzYexyp7sTOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m45zcyCegg+H3gzUoomKGS45tHnCxeW3lASCqrgyvFX8A28bKbc14H0YThdVL3v7kwgOV27QAsNszr7qKjBEfKl6rfgmMUFD+S4pf4OS1yj8TKAl0wZRu8kT2/4XIHlJpCkZypPX4k0/YvIpxhA47+sGxYoG1GtqqxfA0dDuxec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=QLXS/s4t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O/Bc9Old; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F59825400A0;
	Fri,  6 Dec 2024 10:31:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 06 Dec 2024 10:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1733499075; x=1733585475; bh=aG
	hM9zqMGkoabBP/K3PqpxcVTLLQvvaKCw1Br/V6jFY=; b=QLXS/s4teOC/LbElC5
	yWyZy7bBHyfmy+MxI2ONJ1AIkvBjQmDa+6AjW4iQWiFg1DHK69S1X3fbhpdeHAH3
	mIVmlD/LrXOKDuOLx6sZBexlgxmw/IpXD2XP7m6lREkXKKQdAgGEQ0uym08LDf9j
	/Zs4dJYCVyZOckY0cZIhK5K1ZYKjszFrQZl+luWFTq8BAiZaueUOAy55JuQiiJRn
	r81TPgZurXbVrfrWO8CopkYqOLdzdKcUUZzoB8s/92QgqAHYRwPGVs7R48//Cveu
	nRIk3mlF/j0sSnSyRPL9mqermkhUVQLtN/YBkseeG2PZXfyP160qGCxZHHSw174G
	Ldeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1733499075; x=1733585475; bh=aGhM9zqMGkoabBP/K3PqpxcVTLLQ
	vvaKCw1Br/V6jFY=; b=O/Bc9OldqgpzJNi9hPg9ONM96R5692eogaoY99iyVWLw
	rMDXirgfMWnYcnzhlHrCcD/kYRw49vWNh/1GDOT+rM7dHrFfjC7RaBzqLYZyQPel
	15Jft+4A/hE2N1GV6PKlNPVCNGb6H2xUV19pbudijhrVUyOb2k3LXREs06kK0Zzf
	ag46ehDH9/3mBxIeHdxbdNcnhdy5uFBBq7SUc8Cd5c15iN4kYB/uMLzLZ5/+kEcM
	7kza1tN5Z2m3JSCrmER0UW9mDbcfXeLXemdeCTvN8Q2MRV89OKLUfcBF1EXZm2uB
	OI3dqbQ6egkTazuCLRFAoyHFJbko+XTh99fnw1A4Jw==
X-ME-Sender: <xms:whhTZ2g9UHBdOvstcZ9aMp7K71CckEJ6VJcwRwLuJ-Bvw5kdrRlSkA>
    <xme:whhTZ3CxK_3_I4FVRk17zAMShUQ7V4ZjO0e2sYYOJ5iZTQC_-ajJ8QpqU51-sd08u
    TFg8zyWWb-27bK61Qo>
X-ME-Received: <xmr:whhTZ-GEpbeFbNoyi1XVPM7CGQBtuaWcrFqTzuC2FlJr18WClBew2K_QTmJG367FH4G0mEtSEcxV5gma_GpES9ZrEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfh
    rhhomheppfhikhhlrghsucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlh
    hunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgrthhtvghr
    nhepheduleetteekgffffedufeeuvdejiedvkefhveeifeegffehledtvdevhfefteegne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhikhhl
    rghsrdhsohguvghrlhhunhgusehrrghgnhgrthgvtghhrdhsvgdpnhgspghrtghpthhtoh
    epkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhord
    horhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphht
    thhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepghgvvghrth
    eslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgvnhgvshgr
    shdqshhotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihhklhgrshdrshho
    uggvrhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:whhTZ_QlK8nIvtQhO2fxuHCpUBh5dEb8qPvvOrgJ_nMakVDItyI9rQ>
    <xmx:whhTZzwlrDzcicXj9-Fdu-IzPCA1E-Qgv5joHIkb1Aiae-uZ1jZ-7Q>
    <xmx:whhTZ95e9lrOuumVIegMsuwfwGCPbGp6bNgHF2cn4LSLW5lWUytcbA>
    <xmx:whhTZwxqZ3-4tcFT57Gtd8dXzKMUglqgHd1yc0dHhHeam69Eiohslw>
    <xmx:wxhTZ6lns7nBVLMUgQD2Edm0BHUuM54CDUeHe5_QM67NpbJzYaqjeycl>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 10:31:13 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v3 0/2] thermal: rcar_gen3: Improve reading calibration fuses
Date: Fri,  6 Dec 2024 16:30:48 +0100
Message-ID: <20241206153050.3693454-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.47.1
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

 drivers/thermal/renesas/rcar_gen3_thermal.c | 105 +++++++++-----------
 1 file changed, 48 insertions(+), 57 deletions(-)

-- 
2.47.1


