Return-Path: <linux-pm+bounces-41303-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDr3DI48cmnTfAAAu9opvQ
	(envelope-from <linux-pm+bounces-41303-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 16:04:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7EA6853B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 16:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D046530177BC
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 15:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629B634F47C;
	Thu, 22 Jan 2026 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LDgSjIzp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF4339B3C;
	Thu, 22 Jan 2026 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094079; cv=none; b=DMxtutgv/9vTsYVT7XQzl7QhgCi7ImsoeAvNv703xTdxj6zzK+65nMYmd7tHwzkCpdGYVOAfYw3cOIgjnOa+XLMSknTqBGYJkKcCZsevfW4Gip7ecAnjXiQW8xDYBAcxyK5/I3nbyXF7WCy0GggIXFPw2vhto0BCcaqghLxOQfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094079; c=relaxed/simple;
	bh=0LC2JUV8CUJ2J1XRF5YZfCktBg9LAbLRSIFc8a3lxPA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GeMrwrS3H36b8yb6ZZEGc/7QKRFRGVdd1Ju3sX+2ZF+p/28D+KRqM/VwiOSiXrhdvdymm4e4MTlzacBE+/7nHRaIdJXlGX8vCvGV1xi3sPlbyhJDiZfxTyE+vZlLIHJz2Bq4RDMiQVZp0Y5MJWmsW9LlEiUI51Gb9rWP5yoe1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LDgSjIzp; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769094069; x=1769698869; i=markus.elfring@web.de;
	bh=0LC2JUV8CUJ2J1XRF5YZfCktBg9LAbLRSIFc8a3lxPA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LDgSjIzpu5pPGPM0NY9ZQrk94d87rbNAee5i8spe/P2E8YEXf1QzP/mmHBuqPoJt
	 lOZbRJGGCrKZKOJQ6uIc1CDj++RMjZdFtGyy28Gab7RYFS9hovG3GezQ2KghVCe/v
	 L+PBuV3K22Q+r9MMw0s1YJcd2LFvzTm/U+25ABqporJJ2I0AomggC9mj2shM+Gt/5
	 qrhjEzABpYuWhYV8tWv+dqN8bYEVOrLD29I/4nzU07Z64jHbgZw+h7/5sW/s0qIIa
	 Y+9kMEbaNQ9zcR7VJHgATCb0qSS1Trd7rzczPklqaWsPwLpzHpCuiVxljqa39Bulb
	 R1a9gr6XWOYW4nRyXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.239]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECGX-1vbTv61lxd-00AEfw; Thu, 22
 Jan 2026 16:01:09 +0100
Message-ID: <a69e08ea-c4b6-43a5-95ca-eba9263e8211@web.de>
Date: Thu, 22 Jan 2026 16:01:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Felix Gu <ustc.gu@gmail.com>, imx@lists.linux.dev, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20260121-b4-scu-pd-v1-1-f993e4082089@gmail.com>
Subject: Re: [PATCH] firmware: imx: scu-pd: Fix device_node reference leak in
 imx_sc_pd_get_console_rsrc()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260121-b4-scu-pd-v1-1-f993e4082089@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+H6pZaKyymJWYd84hJBe78XHubU65IuQq4W/oAJCt2DHb+OJ4kS
 CFhYbrMFxabwIGt9Co6NhWSfcOJGJUzZjki4pWXLU7WZHng9St0qLcMt9pcS6jmuQCOI1g+
 WcNhVuHLbZybqbTyMmupbaT8DqbGm45ARgG7sN+qw7vYJ+rbKzYKXG741z+PtgeG/GDzkD2
 z/89F3VUqiFEEB9wzls6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2pLqjF6h4A0=;ylnJFJCx+YvnX2kdFqnx2MUK9kt
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41303-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,lists.linux.dev,pengutronix.de,lists.infradead.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,gmail.com,pengutronix.de,kernel.org,linaro.org];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF7EA6853B
X-Rspamd-Action: no action

=E2=80=A6
> In imx_sc_pd_get_console_rsrc(), it does not release the reference.

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc6#n94

Regards,
Markus

