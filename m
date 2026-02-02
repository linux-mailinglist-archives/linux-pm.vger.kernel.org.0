Return-Path: <linux-pm+bounces-41916-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ88KrLPgGlBBwMAu9opvQ
	(envelope-from <linux-pm+bounces-41916-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 17:24:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2149BCEE99
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 17:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 626A4301571B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 16:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C62422D78A;
	Mon,  2 Feb 2026 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Nw3uOESC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664FA249E5;
	Mon,  2 Feb 2026 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048934; cv=none; b=TLU8nA347tm6kXIkg37VZJHgXeh6GzQ++XS6TQipMHLUK3zCf+hWWH2Dxif5IO/zJ2LshWGHLj2Rn0ZkUM/YFnRpJfCmq8GjtDVi+XQZyj5ngASmiVDJp/vi6Oe2k7ASiwUkmUJrXGYCwJNWyo61CFdfDE1wdeazZhZMJvsPccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048934; c=relaxed/simple;
	bh=5r8Cy0o0C9SLafn/Xg9gc+B1F6Qc02Krpqsy7QWPXjE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=cBv3clarXptZQUeLl6Sw7I/bAwxMQZSDxGVa/JBDW647L3YwAqfqJGpfnTNPIx1vrfBbUEpHZ7H78UqI0Va39v/OAeJ2YkQXQBHLMZhRiYFZE4+d7K0bUHXdV7FE94zMSYsIV1e894rHNvZufdLiKyeo6j8+28fDzqQFlXGkR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Nw3uOESC; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770048930; x=1770653730; i=markus.elfring@web.de;
	bh=5r8Cy0o0C9SLafn/Xg9gc+B1F6Qc02Krpqsy7QWPXjE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Nw3uOESCfPAwC84tl/Px14Km08vwuy51INhjdND7GoAgpCRx4KjVXtNjBVKD8fI9
	 gmczEbRhGZXuK5rW6tPIMSXv+rY9MmwrWfuqnuIBiWp0ImYwZ4WhZAH8mdh1l6I47
	 4wIK/0cQQyA2gUype/1sbbVSoWMOyRmGgjLCc2fWXsIPQk5Tz2/14BVkRxvy7BI3q
	 CfkrczRa3Rbwc/rPlvKih/LUrmJQfpCa+bSGbDmQ5aDPi68KQF/owEClVXAndZ9IU
	 V688izzowOJVxXV3QXCIXJ0gua7GPaLCwR8jNjje+PDZKRlahDNlqceb3dpyCnczk
	 qO+z7FOPeDVxx7XBwA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.223]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MS13n-1wGKEL1eWJ-00QAxh; Mon, 02
 Feb 2026 17:15:30 +0100
Message-ID: <b5f78443-0277-4366-8e01-ff9a430d5282@web.de>
Date: Mon, 2 Feb 2026 17:15:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gui-Dong Han <hanguidong02@gmail.com>, linux-pm@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown
 <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jia-Ju Bai <baijiaju1990@gmail.com>
References: <20260131101254.56423-1-hanguidong02@gmail.com>
Subject: Re: [PATCH] PM: sleep: wakeirq: harden dev_pm_clear_wake_irq()
 against races
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260131101254.56423-1-hanguidong02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:skww6durSSUTiRRxmApr8ImleCzuwgvm9FfDr9cddQCqEfFGc2j
 467buxNvLx34las/vPiAXmLtrMYMnuwDXV8yv63XguOWpp0pFqBIu4HN72kPoGhIMChCgCU
 GGxK3jA5tqmRMs96LYeAOqjOJrALX/RD5x4YejEW+zWo4kHgt+b3lVMf5UxFU+JrVrUwfkm
 Kk4xvo87FRn8yISz3MnlQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qHLXQuYzn5M=;c/VIEFuQtd5PwiquaWvhtePUXX/
 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
 1n+ePxYqK+6e+H29cVMfIFc4PdKrB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41916-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,linuxfoundation.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[web.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2149BCEE99
X-Rspamd-Action: no action

=E2=80=A6
> Address this by using double-checked locking. This retains the
> performance benefit of avoiding the lock when dev->power.wakeirq is
> NULL, consistent with the original logic, but adds a necessary re-check
> after acquiring dev->power.lock. Additionally, use READ_ONCE() and
> WRITE_ONCE() to annotate the shared variable accesses to avoid data race=
s
> as defined by the kernel documentation.
=E2=80=A6

How do you think about to apply lock guards in the affected function imple=
mentations?

Regards,
Markus

