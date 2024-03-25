Return-Path: <linux-pm+bounces-5325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33D388A894
	for <lists+linux-pm@lfdr.de>; Mon, 25 Mar 2024 17:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF3D4BA458F
	for <lists+linux-pm@lfdr.de>; Mon, 25 Mar 2024 16:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A21E12D205;
	Mon, 25 Mar 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="JJ3hPJMo"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3138712C7F9
	for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374089; cv=none; b=XKNkH9d0hfCmcg8c8+KXWefoZLnxQcjwMYMRZZTbTT4Pw1jbsdCKB8Bfrit1I8SAFKtFcE98PpP4OUGJhYSrghEeL19Yo5IF5iNVG9pfFwJKbeOYDInnP78rRdDmorhII+AwWpRq64S1mgcMOQBHuzUbpquqPvk+p64LyV3kv74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374089; c=relaxed/simple;
	bh=Rh/0V0Re0AlKg1SRNSIIQFYBQLLc8Sw+ef0xo16ynXA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hqWC+3s8g8AIHpryZuzINss3W5RuySj6yU7+QTx9nVMwcHsHXSCDfuRcfM+0CnykaZlxH3Xy/19r4j0Xm56HxCPwNjbf9niH0hjdDFirUxdlHj23SY6ud5N6RJazSKKqOFJcs6qY3oZxjcxKNOZh1fuBDrfKQc/qgAYVC8oTRe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=JJ3hPJMo; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 06833220b7904a2a; Mon, 25 Mar 2024 14:41:25 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C595F66BCD6
	for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2024 14:41:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711374085;
	bh=Rh/0V0Re0AlKg1SRNSIIQFYBQLLc8Sw+ef0xo16ynXA=;
	h=From:To:Subject:Date;
	b=JJ3hPJMoZINCb1huGRrRs7+5f6f838O5LWi7KWeMymSS9Z2h1eBC3Z/dGq5TZv+62
	 73xqEBVDMpf7LGIAUgNagCmxHbkO848yeoql7SSzEZXd2S4dT7vaakcdkPfJhJwRA5
	 l2OTRVCTunVUIefoeAAium0GXEJfeXHgXYOcV9gXj8VDS3B0TApTXamomFnL8lfKGq
	 0oolFyzbWRebpoCnqz2F8zx1BWZ235Epmsic8fIFt9bvJkB7v4OngGdkZmibUsk9Ec
	 Q8b4QpbznKJbGi48W+6hozrKjJtiy2IwfsVB2yWaBC29nVlWOyiflMnokHhMBeqpZI
	 BSUWWYpece34Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Subject: [CfP] Power Management and Thermal Control MC (LPC 2024)
Date: Mon, 25 Mar 2024 14:41:24 +0100
Message-ID: <1974187.PYKUYFuaPT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledruddutddgfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=1 Fuz1=1 Fuz2=1

Hi Everyone,

My original attempt to send this CfP to linux-pm apparently has been
blocked as "suspected spam", which was not very helpful, so below is a
summary of it.  Everyone who has been on the CC list of the original
message has received (I think), so I'm just sending this to the list.

I'm looking for topics to be discussed in the Power Management and
Thermal Control micro-conference at the LPC 2024, so if you have any,
please let me know (the conference is taking place in Vienna, Austria
in September).

Please note that LPC topics need to be about work in progress or
future developments, work that has been completed already is not
suitable.

Thanks!




