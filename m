Return-Path: <linux-pm+bounces-31020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A976B091AB
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 18:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CB2163153
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 16:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11B82FC007;
	Thu, 17 Jul 2025 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aa33oKj/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B3D52F66;
	Thu, 17 Jul 2025 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769526; cv=none; b=Hhcn3JgwQDUWoKRYyi0zLYbX8p/gC5eCm5aQUPk6wqWBW6nAHJNEIZIw/tgngyH5Wo/CzDzrH0L+YQ/y35Iv76L92ajrpTyZyE3kiFLjsT/VZfxEPA9YQsO9eKhl+TDNOKi4OHpupljxhBMu9VG7mm8ddyMIy7U8wLT4R8ngGq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769526; c=relaxed/simple;
	bh=kPAbIypeW0p12aeXFIg7fnrfkrmvX8BtRsy0/upbIEs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qZJGkWJu3fHz01xxfCVlRgjOk0T4eLEyags4Kow7GH2qf3Xvod9z3OGHWyhovAOZGRtf0xyxwqOUPI08z3r4A9H1V49Q119oC6e6gBnIRSLPUA42dhk/Z2DNPgYP8euggpi6EoWq9BcbT3Wehjo/LPHAQiRnNQgvrXYRcQBkfEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aa33oKj/; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752769517; x=1753374317; i=markus.elfring@web.de;
	bh=j6OvYZuJhdff2PB4sMaRQIyVVc8AfYNwBjXi5Zj2XM8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aa33oKj/eP2rbQZO409s1+hbeZSkh4Rf+o277CYXdpKGNkY1Qe/ogfUi8JS+rpMW
	 0N42p1NlWlMOCQd2LYVqGNIzvkNG8GuNGG7AGmJecS3/llr8bl8b/wRzdcKpCWMyO
	 sfUsRRmdhSgnz3BjeIX4yIKD7roSJ6Q1WnmuWixgxoBbWo7eTt/saMVRZimgMF9R3
	 XJeYQSbI1mazMST9egS+3CjlKiXjclaO6d5obwUuPIaHzqsKtZSGGDu0+HXHVjViM
	 8pDw5k9iWyZFHXpx0NFiZLSzszEaKI8T4zRUYSwcZRTTuYYC2la5Tb5RjrjSxbLP6
	 NuF/T/hgnSXRENl1qg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6HK6-1uVrqX2CfA-00HSJT; Thu, 17
 Jul 2025 18:25:17 +0200
Message-ID: <5bf8c7da-19bb-4286-9f02-369e09ffac5e@web.de>
Date: Thu, 17 Jul 2025 18:25:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gaowei Pu <pugaowei@oppo.com>, linux-pm@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
References: <20250717085110.1468-1-pugaowei@oppo.com>
Subject: Re: [PATCH v2] cpufreq: queue policy->update work to a dedicated
 thread
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250717085110.1468-1-pugaowei@oppo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lm3Hgcq9KkfXHtmrVRZC+/pQsutHylV7VaQrIyFsPkh+E4cxpAQ
 keoBUhsY/TZnkfFEzkG+eN18u3RmjNZmnocb4B83bMQWJzdRbMZenqdst9V3sBPMCP/pie1
 6dsO4tMqI6bI6wrbMIAPrf091VxaczcrA2pva5w9k8B7fBXjhJiyaB5lptyoHVW9/oVdORn
 4Vky8fKxdMmq5EgJkyyYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C9krLeEr9d4=;WJxMRc878v9AuDtOnST/VY5OIFR
 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

> when we add a dedicated highpri workqueue to do the policy update work.

                          high-priority?


> Therefore, we keep the thread and will add a vendor hook in andorid aosp

                                                              Android OSP?


> branch lately so we can customize the thread conveniently.
>=20
> Changes in v2:
=E2=80=A6

Please move your patch version descriptions behind a marker line.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16-rc6#n784

Regards,
Markus

