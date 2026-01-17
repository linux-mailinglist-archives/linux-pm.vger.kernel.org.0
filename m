Return-Path: <linux-pm+bounces-41050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31417D38FBD
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jan 2026 17:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1484D30268E4
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jan 2026 16:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7A6242D67;
	Sat, 17 Jan 2026 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HzZa4rpU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E752B218592;
	Sat, 17 Jan 2026 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768666865; cv=none; b=MOwRnNR1QGGo+pKNT10QjvQitzATeRmcp4vuCEqxlYBCoIjRCecVWpBp8exhB7XKKZFoBS3uDeqoc2EqD3nsoUk+eB9fBwnWSU0v6XYJkGb58FTSe2VSkpMEd8NjTfJnL4C2p7Ke2Q9ZWEaZVlwDqas4dVPm2NkPD9cpwfmFkgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768666865; c=relaxed/simple;
	bh=ouEQkjqPczZKXwouqV3O5hgXS/gsy4InUNihJzswGzo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Q4E0UQ86x3KQ1v8+m0ReCpFcsUQQvTlqK+eDXMX/FW1MZe9V9x4+O51rbd6XW9Ce5S344E8RyVikb3YeSt88rG2m4j5vtCfS6zWiLePz9xyMb4B+X6ZRV1ukyd2C7sBWwnu3MIxyQbzSZMLpyEVC0JZ+EeNRqo+MyXjtur4nIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HzZa4rpU; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768666843; x=1769271643; i=markus.elfring@web.de;
	bh=ouEQkjqPczZKXwouqV3O5hgXS/gsy4InUNihJzswGzo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HzZa4rpUrLk+/AmSdcMCLT2Pu/JnO28QnVKtHiPso+4hvTuCzNT+Za8IlYFzhDwn
	 ZeLocIPL/19EoNlKqcbnzHDQkcgaY4Pkew86d19nhGvQG5uQ5Fn1zH0TDLEhqfz4N
	 XNGfw8nwhDKn5/Z9AcWQQFVA+IJ025fcstWTFwRPGNQ+nCMzmBPbwlaayON7iQKH4
	 zvQT5tqEuRnVcZRJENf1ZWwrBHTwo53XJIed1K7rZTNXJ0Vv57Hc7s4osE3Fh+9kw
	 62D1osiVauCpB3C65qMv55p/mFRJR964AV02EojQ7QT8XPRGH51iFhMIQqbTPs5JD
	 aVZJAeLFxir75QKoSQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.177]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTvw0-1vGEEj2bek-00PoLB; Sat, 17
 Jan 2026 17:20:43 +0100
Message-ID: <eaf05847-b5c0-44b7-a619-7119d569df17@web.de>
Date: Sat, 17 Jan 2026 17:20:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Weigang He <geoffreyhe2@gmail.com>, linux-pm@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>
References: <20260116073002.86597-1-geoffreyhe2@gmail.com>
Subject: Re: [PATCH] thermal/of: fix device node refcount leak in
 thermal_of_cm_lookup()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260116073002.86597-1-geoffreyhe2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2fJRb+LH/AaFcBS3d3aSavPqsEuC25tXErp0PhhovNJ0dv0RH2N
 2+6fuHQ8VWYxm6PeN3LNp9PQd9ShshvrzHE0UIKTqZ6jE6JgJvzJfxnsBrF1CbGenYHXWe3
 MvPulsGo1Kj4/LWd4Y/4t4u3r7E9Oczx5cWLyFXxTVpJa1i0B2BKSv0FOtsyz7hycJPI32r
 7kndmif8PqGO6CDH/e+QA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2Hi1Nclc40E=;IVZGln+lmTEQFpoMPdffJUAUGwC
 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

=E2=80=A6
> Add the missing of_node_put() calls on all paths to prevent the

How do you think about to use an attribute like =E2=80=9C__free(device_nod=
e)=E2=80=9D instead?
https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/of.h#L138
https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/thermal/thermal_=
of.c#L277-L303


Was such an improvable implementation detail detected by any known source =
code
analysis approaches?


> reference count leak.

Would you like to use this term also in the summary phrase?

Regards,
Markus

