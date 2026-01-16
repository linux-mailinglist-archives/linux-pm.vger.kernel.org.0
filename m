Return-Path: <linux-pm+bounces-41006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4C0D321CA
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95E0D300E003
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 13:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FC227AC54;
	Fri, 16 Jan 2026 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ILDQ70hg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED4145348;
	Fri, 16 Jan 2026 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768571369; cv=none; b=vCygtX0f78vpWQLm3r31x9p2g5Rcj3xzLffpPf0RCzw3W/QouhaTtqagitWRHpEntcKMMI/vxLc1LVr3Oh0fQ5wlWKAEvlYpQID1msbaDghqi9/P7BhE+TMI1UVt+L0E/rq/haY5Usj9Seida75i7XEu8ZgKTNvreBHGiZLc1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768571369; c=relaxed/simple;
	bh=4yNBP3vB9RH16PoRgyRCzWlrJO3OolfPfVR2l0mr07E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=s1HO2bVW0U8BLscTY6VojQgM8wDF/mF+hwz6uASsRNatMN03ZF60Kt87PAUAWSupODKLnfI4E3LG4iayioOKkRHt8WkrYdtyh2HT7Wn3h0MNH84lLfFnhUkMN9Lk7O+p3I5UlpROWPDfMvYbCige9Vst1XdF7Eg8r0uMoiYFp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ILDQ70hg; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768571335; x=1769176135; i=markus.elfring@web.de;
	bh=4yNBP3vB9RH16PoRgyRCzWlrJO3OolfPfVR2l0mr07E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ILDQ70hg28DaEALb0i0ss6K//wBVe8sdCXT2pJA2uRgVFwLS/ds+1m7HNulUngtg
	 2cNqH4sZSKoKDsyTb0o59/5MGWHBBb92UJpuAV+QNeIILqM8IaMuDoRAmNt+GlKXb
	 LezpSBXMUOFDmYmKHhL8+efGqwuArlKNHt1neys8rUEOeMQnjiXEmNlccVE6gHodY
	 aQ/8meETtkAAdMmo/kqcj19sp21UqC0+L90KsC18/cmbobDvpRBYzVf5lTqkn/GRP
	 LG5nMP4/+VBqsez57TORh/pepucqfV1rN4MjVxWMjJXPWzJeZ2/4BVetewDqtgPL8
	 1x046If1Bmlgr6Bz0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.218]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRk0W-1vDZXR3QPC-00THLH; Fri, 16
 Jan 2026 14:48:55 +0100
Message-ID: <4d5d819b-6c3d-4228-a4bb-f7afc71af023@web.de>
Date: Fri, 16 Jan 2026 14:48:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Felix Gu <gu_0233@qq.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <tencent_E20B88FB4461F8F299301AE67009CF1E8708@qq.com>
Subject: Re: [PATCH] pmdomain: ti: omap_prm: Fix a reference leak on device
 node
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_E20B88FB4461F8F299301AE67009CF1E8708@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XyXtaedlbPvmqgjUdtgSK7cHvRUebZgIwknA7+hXjmsWdwHkIFj
 t6QAEjAuCKJbvEV4gP0HNY/cIQTtX8x31iOIGI+aOGf30f6wq/WE2DBwLt3CE9OFVWeX01V
 kr0beOZzQWCweiZt3Oylaak/3SvmblCL+6+X8AJmy+QdVz/g3tiyLH0Ykbq5EkL1h401o+x
 7znmV9x34+wwVDD6W/B2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n1dQtBO19Uc=;3wZtXq61YU0ELBQ0a7d1EeKmuku
 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

=E2=80=A6
> In omap_prm_domain_attach_dev, it does not release the reference.

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc5#n94

Regards,
Markus

