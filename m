Return-Path: <linux-pm+bounces-40568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDB0D0BC6C
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 19:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC6513011ED5
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12D53451C1;
	Fri,  9 Jan 2026 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vuDVT8Hd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0014135BDD9;
	Fri,  9 Jan 2026 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767981685; cv=none; b=LYWcUhxgn901nNOr64E5lngRAwfXrKnx8QD3tgWz255DKwz3XB8VmJByU4OstxFp6MsDMN3QtnLnjE+NFkmwLEWzhooYsg6ftsBLAf8OK3r3LXWhlaJCYC9IjxdZQcVlxOaWmEIKCd+5g1nOWt6RUnJI49OneISILovSggDBhnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767981685; c=relaxed/simple;
	bh=KyVdf2rUiJO0BoVZREBSwU88o4bT6M0mkBVgk4VtH08=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NVcTsM2Oyb1U586NKak2nIVzKWkCP+x1qz2ERE1xD9nc/w4I2Wh9elbwy42X0+feg34J+dRoR9WmoYVmR18OTm0Ocgnbc1OK6bZRlFOjrrZFps75VygFIlBtOT6K0gdUYU4Zz3xcKO/wqYeiLZeoCAVsmUl+zFVIY6oORCkWLko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vuDVT8Hd; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767981670; x=1768586470; i=markus.elfring@web.de;
	bh=KyVdf2rUiJO0BoVZREBSwU88o4bT6M0mkBVgk4VtH08=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vuDVT8HdTRDP8TVNGMVgvq/5lpe6pLMBVrt9JMbjMR01haGdUwRezvUKjppsA6pF
	 umydYiifsJmXE5zQTbjHPfIlGGFh1P9HBPy0VhLwewYJW5CaEBdSxtcBvp7BZGJQS
	 JZblE304INAXApf0l7V7o0OdcNFuVtu8RSiRkMK15p1Rvht1bs6yeOzzUMAVkPQM5
	 1X2XPdWOX7d/WeQ+G3XJAqOmeIpNPFAHxEq23qtzh0YQSOByydHCg6DphL89xEhBe
	 3VwuEhd8x62RW1zWze+Krr05SH3onMS/ad0KzgnzYvdv5mVc5ZavlQ2lP2tz5L3Uf
	 /75gfJvgQ2yjKZ+zww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.182]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUCuv-1vE6vV011X-00J8ld; Fri, 09
 Jan 2026 19:01:10 +0100
Message-ID: <9af94485-321b-4b9c-9dbb-85bc7bb41934@web.de>
Date: Fri, 9 Jan 2026 19:01:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Felix Gu <gu_0233@qq.com>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <tencent_68F699431A877005CF0887CF888B440BF808@qq.com>
Subject: Re: [PATCH v2] cpufreq: mediatek-hw: Fix resource leaks in init
 function
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_68F699431A877005CF0887CF888B440BF808@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GGyBz84I0TqOuDnmicvWGa7C0/k7ebh6o4dEmXQYYE5Ntd0CZb8
 8CVDaCunlE7IkAW3wK04FKGJt8booLcq7oIb+VgrilFScLeSPcAzzJFCEt0ieZYjTAa2wOC
 NqQZfDlKN+W/XpZAIKEY4c42dhxe1rOCg+8zaJljVg3mIQKsoud7qfI4Cik0Gg0pyT3P2tT
 3XRz5K0cl5HZ4E/Kq4NLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5Mlw1n4ak+I=;/CGAbMnLJCBz14KOwYjudPhqJoM
 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
 WZEe9DJI=

> In mtk_cpu_resources_init(), if mtk_cpu_create_freq_table() fails, the
> function returns directly without releasing the resources.
=E2=80=A6

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc4#n145

Regards,
Markus

