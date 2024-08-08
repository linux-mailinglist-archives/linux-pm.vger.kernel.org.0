Return-Path: <linux-pm+bounces-11986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BC794B6F5
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 08:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77AEBB21C3C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 06:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B32185E7A;
	Thu,  8 Aug 2024 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IaTeITjV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJu69KUW"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024FF5228;
	Thu,  8 Aug 2024 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723100040; cv=none; b=eliywxH2Wq1VDw1Fj/99TtfiUVsMa/JnoQQcbItv297vL4EbxV1+ZRJ9SJQzhZ4LRPrUIXqETcEG7FJPV0cyMfrXdenIlUvF6IV62AwfWp3f19/74IGw/oI6YC1888zbVd81o51LyKH+K23ciTEUomS4mO48pD+XY0Q4mdjtNQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723100040; c=relaxed/simple;
	bh=tciyC43LBPP6ReuR8JiV299C77gEYtlCSfoeVbeoRFU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bqmU7rgFJXdPU0pNQWpFZuJZD+vnfl5s7zvemlDSRiszwwHC23zpjgkrVuFqpzlxwyEBth+9EqUT8rro8ZulvIibQJgme9oq8F2qB8UTbIfXc3onZ1cK1m7ufikjmf+g2VdkOZJuSR5LWO9mkTMTTteIcVzUdNcCgJNOWRakmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IaTeITjV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bJu69KUW; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 14AF81151BBE;
	Thu,  8 Aug 2024 02:53:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 02:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723100037;
	 x=1723186437; bh=/FT6YYLHJ8Rtqq3tE6sAPdg9+du2pO5FFAdLqh/r+OM=; b=
	IaTeITjVZ921QuAZEF+s1PYOzQ1zGlIu1R0JdMG1xAzqZ00bzRMBsKhR4Ktxn1Q8
	UzXe4ugUHBoDtMlgmUZkc79v3SehUTk2cOt4y5kGttCGG6OI4A+xTiEqF7pw7xPh
	dndDXKAS8gnY9t6t/pq/RqyIDwzP7ohHTvenoIunMbUdLENPWIjt7Adx1wSaExX8
	yuThMtbs8ty+PFR6HmV51EQST2bJJz8ra8/7CVdNXlS57ynmNuXWp86cbN5RT1+q
	TV738KTZRB/N/OgaOLECspJJ9yZKVLBWek3Iwu6i2Zrm9NLl7NHX7jcLaMyrkcKQ
	Xv7D8LYK6cQJZEV2xXHoyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723100037; x=
	1723186437; bh=/FT6YYLHJ8Rtqq3tE6sAPdg9+du2pO5FFAdLqh/r+OM=; b=b
	Ju69KUWZWfseoEuZCvTltgQXAxi/THXdDPVvxWpq9ZLWiLXfAXNMmZYt11lZwq6q
	u9QFALVyl81oqXV9vyxzlbcuH6x/mvoCgoa1w9WaZUwsKfBxObxm4groFhm3rsTd
	ixjBU42nuDXtev6rd2ThkOccpDAGrZmC88XAgnJh3YEZ2/kxXMtucuZdKe4rd2yL
	LPUb/8I/FcrxYZieesN9kjjqa6K5z8QWfWqNk3h5heyxSO6/OsNqbZD8UmFRX58j
	Qmv/ufVr6rxV1uUB7l71nYfa/MhEEXTlDGrR8+qeRirLZ2N+6S58pRymG9YsfNgw
	I+3iU3T/JW9c9jlMvmH+g==
X-ME-Sender: <xms:hGu0ZpQp4Xkw26iJWp9zgJRTwcy_-WkJGY4tC5RL-oNDycnZlaT2Qw>
    <xme:hGu0ZizInySN6l-eD8VA_uIvQI12pbAj6zxDJX-ESYZ4vLgOLq4Jz1FWOXHBc9Uwe
    Kw8nueAp1bK40ReNB0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnjhgrmhhinhdrghgrihhgnh
    grrhgusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepmhgrrhgvgiesuggvnhig
    rdguvgdprhgtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhiuggvrhdrsggvpd
    hrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgr
    khgvvdegsehishgtrghsrdgrtgdrtghnpdhrtghpthhtohepshhhrgifnhhguhhosehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrih
    hnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhig
    rdguvghv
X-ME-Proxy: <xmx:hGu0Zu0a0M0qb-BPXikGrAVD0SHfsz9kcGVblxSL9MWJ8JL6GQ0T8g>
    <xmx:hGu0ZhDRKzd5zBaKK1-X7b_-ImWfJYklm8Nzl9SEyX_AtS9LE5MCKg>
    <xmx:hGu0ZigogLKKqK1AtfuTlbZtqo3Oja_d5TAZjKiibEjxfDH8HNuqgQ>
    <xmx:hGu0Zlqla1oZzi-Zi8sczt26ZrMJ-qiWjZzsLoP6zoLzoPvd_E2wjA>
    <xmx:hWu0ZpSEuk8TKyoNXpowJM-vV9D5nvQ19SyhwlxSEfEUKqha79J5QjwJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B8C25B6008D; Thu,  8 Aug 2024 02:53:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Aug 2024 08:53:35 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Marco Felsch" <m.felsch@pengutronix.de>, "Ma Ke" <make24@iscas.ac.cn>
Cc: "Ulf Hansson" <ulf.hansson@linaro.org>, "Shawn Guo" <shawnguo@kernel.org>,
 "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Fabio Estevam" <festevam@gmail.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Peng Fan" <peng.fan@nxp.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Marek Vasut" <marex@denx.de>,
 "Benjamin Gaignard" <benjamin.gaignard@collabora.com>, imx@lists.linux.dev,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Message-Id: <1b04b8b3-44ca-427f-a5c9-d765ec30ec33@app.fastmail.com>
In-Reply-To: <20240808061245.szz5lq6hx2qwi2ja@pengutronix.de>
References: <20240808042858.2768309-1-make24@iscas.ac.cn>
 <20240808061245.szz5lq6hx2qwi2ja@pengutronix.de>
Subject: Re: [PATCH] soc: imx: imx8m-blk-ctrl: Fix NULL pointer dereference
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 8, 2024, at 08:12, Marco Felsch wrote:
>
> On 24-08-08, Ma Ke wrote:
>> Check bc->bus_power_dev = dev_pm_domain_attach_by_name() return value using
>> IS_ERR_OR_NULL() instead of plain IS_ERR(), and fail if bc->bus_power_dev 
>> is either error or NULL.
>> 
>> In case a power domain attached by dev_pm_domain_attach_by_name() is not
>> described in DT, dev_pm_domain_attach_by_name() returns NULL, which is
>> then used, which leads to NULL pointer dereference.
>
> Argh.. there are other users of this API getting this wrong too. This
> make me wonder why dev_pm_domain_attach_by_name() return NULL instead of
> the error code returned by of_property_match_string().
>
> IMHO to fix once and for all users we should fix the return code of
> dev_pm_domain_attach_by_name().

Agreed, in general any use of IS_ERR_OR_NULL() indicates that there
is a bad API that should be fixed instead, and this is probably the
case for genpd_dev_pm_attach_by_id().

One common use that is widely accepted is returning NULL when
a subsystem is completely disabled. In this case an IS_ERR()
check returns false on a NULL pointer and the returned structure
should be opaque so callers are unable to dereference that
NULL pointer.

genpd_dev_pm_attach_by_{id,name}() is documented to also return
a NULL pointer when no PM domain is needed, but they return
a normal 'struct device' that can easily be used in an unsafe
way after checking for IS_ERR().

Fortunately it seems that there are only a few callers at the
moment, so coming up with a safer interface is still possible.

       Arnd

