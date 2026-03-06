Return-Path: <linux-pm+bounces-43807-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGNJJ+XLqmnUXAEAu9opvQ
	(envelope-from <linux-pm+bounces-43807-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:43:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC692220D95
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71334319AF34
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 12:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F43C2701D9;
	Fri,  6 Mar 2026 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sLaiao33"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8322B8A6
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800562; cv=none; b=G8A/wgIhcfOC31vuiR1KUUos3FBLaYNI+cZTAfy010w8AagEFOMQrRsaLJUCJQZW+/g7AXKRGfVdd9A8+930eQ9FK71i2+xixmJDhbLynulypF37XT9F42c51nP1adDyd39p7cmsp7oZd1mbR4a23qPJNThVGjFURWd0o039fkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800562; c=relaxed/simple;
	bh=gegZ9SG2L3nOQJJmvEQTFjDNAgWMFAacpiJJTUXKdvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=KchusDsy/21JbTz4HOGw331WNxx5BMbt4wLPQq+yut738B5hD9WwS75n2VUwQ9zgMFVmj28cxLk0flqgpXQ/EC86X1AhmQpNtzlMiM7IZ0aWsYlyF2m6o/wlU+bMn2d+wRaBR9qwtL152eMzRV4lQodZf7lii7rDkIpF9RIvA+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sLaiao33; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260306123558euoutp01043958ceda0ce69119176bd8660e2cf7~aQLcL7Vou2376823768euoutp01L
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 12:35:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260306123558euoutp01043958ceda0ce69119176bd8660e2cf7~aQLcL7Vou2376823768euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772800558;
	bh=gegZ9SG2L3nOQJJmvEQTFjDNAgWMFAacpiJJTUXKdvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLaiao33xhUOgGnDGBAnaOEIpORJl6kQOkBg+H5o1IQDzTP99ueXcBg9Zjn6EykTP
	 JtxxU5K9H82tphiwb+ji+BnS9OjIZH0WKHAeZvNdy6CqNa3PgHtwRaS8D3gLDCAax3
	 IqiB9WMz02wupUBKdm7p46fppFApRj2wvPTAWs3w=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260306123557eucas1p1f4157568a9856c4fbe0b08e6c1a11548~aQLbsktHx1284812848eucas1p11;
	Fri,  6 Mar 2026 12:35:57 +0000 (GMT)
Received: from AMDC4515.digital.local (unknown [106.120.51.28]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260306123556eusmtip1874801b0bb1d934e665cc7522deb78ed~aQLazW1zx1557315573eusmtip11;
	Fri,  6 Mar 2026 12:35:56 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>,
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz
	<bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
	Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, Anand
	Moon <linux.amoon@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v4 0/7] Add initial Exynos850 support to the thermal
 driver
Date: Fri,  6 Mar 2026 13:35:42 +0100
Message-ID: <20260306123543.1748910-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260303090211.673143-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260306123557eucas1p1f4157568a9856c4fbe0b08e6c1a11548
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240911121149eucas1p29b9ccf99a545cfaa924b122cd8dd3183
X-EPHeader: CA
X-CMS-RootMailID: 20240911121149eucas1p29b9ccf99a545cfaa924b122cd8dd3183
References: <CGME20240911121149eucas1p29b9ccf99a545cfaa924b122cd8dd3183@eucas1p2.samsung.com>
	<20240911121136.1120026-1-m.majewski2@samsung.com>
	<DGIAUIFPUHN8.35B5MNEUK1JW5@linaro.org>
	<20260303090211.673143-1-m.majewski2@samsung.com>
X-Rspamd-Queue-Id: AC692220D95
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[samsung.com,vger.kernel.org,lists.infradead.org,gmail.com,kernel.org,linaro.org,intel.com,arm.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43807-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.majewski2@samsung.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,samsung.com:dkim,samsung.com:mid]
X-Rspamd-Action: no action

> Honestly not sure. If any other patches are merged that conflict with
> this series, I definitely can resolve the commits (for now it applies
> just fine to next-20260227, though I haven't compiled the result yet).
> Correct me if I am wrong, but I don't recall anything to be done in this
> series otherwise. If there is interest in this series, I can retest this
> on the other boards and re-submit this later this week.

I see that others are working on different SoCs actively and that my
series conflict with theirs. Probably would make more sense to
re-submit/rebase when the dust settles, unless somebody wants to use
these patches now (I am assuming that you are just cleaning up the
review queue for now).

(Also, I somehow managed to break threading by sending my previous
message with only In-Reply-To: and without References:. Sorry about
that...)

Kind regards,
Mateusz Majewski

