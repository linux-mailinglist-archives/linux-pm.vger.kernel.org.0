Return-Path: <linux-pm+bounces-43086-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id izRDCyEanWl+MwQAu9opvQ
	(envelope-from <linux-pm+bounces-43086-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 04:25:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2BB1815F8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 04:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 028143029AE7
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 03:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A797329B20D;
	Tue, 24 Feb 2026 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="IbyZhgA0"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7326A24A07C;
	Tue, 24 Feb 2026 03:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771903516; cv=none; b=EpefZ4DwlFnPADwEjUfSXSR9gQotmBcXxWY5EixJH8X+WmqEdu7P2XYZY7tYqeXkQ5tL9hYcqmVXBRnnYAVVh3t8vd0wO6vjtSb61nw+meS4zx0MasAnFDmlV1Wa/AlsC+RKVbh/s7dIlCaCGmiSmvBoEMhS5eW0h1OxRGtwAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771903516; c=relaxed/simple;
	bh=XQ+MENZPFBnUpKFwZsqLUOQ5MEiPTVYTmCawlkccpqg=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=sbbH3xk3Y3npkDxY2A5uRtLYGZbkoJva3PoKtncvJ8T80z5kX8WgJAHY23q/kk5G/JUQxz9J5O/R8EwuFN8R5R29T1h3kJRAwvkXA5elGvnSmr6K/8N0JDUQAbyAx75zu9iNlMvX/n1fD0iUzFKUIkrWx6yQ7Jr4uwnEKlXqvus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=IbyZhgA0; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qf1/mKoC1s8Fc94UEdncis0HVKJnlD+Ck8WtaZOF8N4=;
	b=IbyZhgA0gBkCZkOyxkrghfAo/all4uaZb0lMzwj/kdETulNpMb2DY5bUxSrhuFuQhb8nVl8A0
	2r584Mv5qdAcqDyQgCc3AZ3biCtqLt1fXPQoWPOUavmbTu7dzXZAVb1He0PWob3v3euJ8YFhRoq
	fGA393GbK1cBJ4SWKEjA9U0=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fKjdt25scz1cyQx;
	Tue, 24 Feb 2026 11:20:18 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 220C240562;
	Tue, 24 Feb 2026 11:25:04 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Feb
 2026 11:25:03 +0800
Message-ID: <f0cfd62f-9dcc-41e6-9193-2f32ec4b96e2@huawei.com>
Date: Tue, 24 Feb 2026 11:25:02 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <lenb@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Zhanjie
	<zhanjie9@hisilicon.com>, Zhenglifeng <zhenglifeng1@huawei.com>, "lihuisong
 (C)" <lihuisong@h-partners.com>, "yubowen (H)" <yubowen8@huawei.com>,
	linhongye <linhongye@h-partners.com>, Linuxarm <linuxarm@huawei.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, "zhangpengjie (A)"
	<zhangpengjie2@huawei.com>, "Wangzhi (ksana)" <wangzhi12@huawei.com>
From: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
Subject: turbostat: Incorrect physical unit for PL4
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr200004.china.huawei.com (7.202.195.241)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-43086-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangpengjie2@huawei.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim,huawei.com:email]
X-Rspamd-Queue-Id: 5E2BB1815F8
X-Rspamd-Action: no action

Hi Len and linux-pm community, I was reviewing the PL4 output in turbostat
and noticed a confusing behavior regarding its physical unit.

According to Intel's hardware specifications, there is a contradiction in
the documentation itself:The overview describes it as: "Package-level
maximum power limit (in Watts). It is a proactive, instantaneous limit."
However, the actual bitfield definition states: "The PL4 value in bits
[12:0] is specified in strict 0.125 A increments."

Currently, in tools/power/x86/turbostat/turbostat.c, the code parses it 
as follows:

fprintf(outf, "cpu%d: PKG Limit #4: %f Watts (%slocked)\n", cpu, ((msr 
 >> 0) & 0x1FFF) * rapl_power_units, (msr >> 31) & 1 ? "" : "UN");

There is a significant issue here:
Because the manual broadly labels PL4 in "Watts", turbostat incorrectly
multiplies the raw Ampere value by rapl_power_units and displays the result
as "Watts". As a result, the tool outputs a PL4 value that is often 
absurdly
lower than the PL1 and PL2 values. Since PL4 is supposed to be the absolute
maximum instantaneous limit, displaying it as a value smaller than PL1/PL2
causes significant confusion for users monitoring system power.

Could you please take a look at this and consider clarifying the output
to reflect the actual Amps?

Best regards,

Pengjie Zhang <zhangpengjie2@huawei.com>


