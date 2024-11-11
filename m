Return-Path: <linux-pm+bounces-17321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9239C3E8A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 13:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62111F224B7
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 12:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD1119D067;
	Mon, 11 Nov 2024 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jMOJoCm2"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECD814F9E2;
	Mon, 11 Nov 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328653; cv=none; b=n9FwHEjTI6Bqhm/lIuuD944wJ42KgZ1AKd/XRoXkIJEf8Q3VbEc8p/GRIz1o8kfjVg5jmsgPuZBRZDWERcdZ/6U6ukzBvj3XgwUn60KEP7HMbFeFIQqurRt0ci4e/TuHV5jbdFjYBgDZ7D2ULj8Sv4e35cWuUYcS04kYvOMuJGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328653; c=relaxed/simple;
	bh=k1WV2pAD/8xmmFjcMJoAZqWMi8wAr3HzjyLMBii/Jo8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTvykZZb3s6x/cLvTLzB5XQKY/uvGm6IdwXEHsDfXceYTiUA+9bhDo69qvgjvsD1c0FMI4MsRcAjf4PEClGhGnwVTjLtxVdn0LvCuhPY0UyVOoFDkM705zmPlz8dn6NdWXKFgh7+zjiInWXczos5ol8rdB0gK9SkZjZX2HSwwpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jMOJoCm2; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ABCbHoM043260;
	Mon, 11 Nov 2024 06:37:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731328637;
	bh=60UcITJlpU2R+Ybt6O7o94y6gwkZ59cqwJcbrJQ7AmE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jMOJoCm20vIRQZejgBmb680tW36MSbmMSI0AVm5x1g12jgyyntAz9kOD7oO1K60kh
	 W16waXS8lVnikAJTKoWQ4IJbx1TbWEI5qEnCc/PZp3kLZG8Kk+tToni/T1wa6gIYzp
	 SBM+dM74ppd1JZUPhx2xjBv/Eta5h8qVwjdUWnpw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ABCbHlr110654
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Nov 2024 06:37:17 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Nov 2024 06:37:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Nov 2024 06:37:17 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ABCbHY5078651;
	Mon, 11 Nov 2024 06:37:17 -0600
Date: Mon, 11 Nov 2024 06:37:17 -0600
From: Nishanth Menon <nm@ti.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Vibhore Vardhan <vibhore@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Markus Schneider-Pargmann
	<msp@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pmdomain: ti_sci: add CONFIG_PM_SLEEP dependency
Message-ID: <20241111123717.yqnjp4voohi4bhbu@accurate>
References: <20241111104605.3964041-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241111104605.3964041-1-arnd@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11:46-20241111, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without CONFIG_PM_SLEEP, the pm_generic_suspend() function cannot be called
> since it is defined to NULL:
> 
> In file included from include/uapi/linux/posix_types.h:5,
> 		...
>                  from drivers/pmdomain/ti/ti_sci_pm_domains.c:10:
> drivers/pmdomain/ti/ti_sci_pm_domains.c: In function 'ti_sci_pd_suspend':
> include/linux/stddef.h:9:14: error: called object is not a function or function pointer
>     9 | #define NULL ((void *)0)
>       |              ^
> include/linux/pm.h:875:41: note: in expansion of macro 'NULL'
>   875 | #define pm_generic_suspend              NULL
>       |                                         ^~~~
> drivers/pmdomain/ti/ti_sci_pm_domains.c:134:15: note: in expansion of macro 'pm_generic_suspend'
>   134 |         ret = pm_generic_suspend(dev);
>       |               ^~~~~~~~~~~~~~~~~~
> 
> Fixes: 7c2c8d2651b5 ("pmdomain: ti_sci: add per-device latency constraint management")

Arnd, thanks, but the breakage never made it to the pull request.

lkft caught it[1] and I had dropped the series from my queue[2].
Kevin reposted a v5 of the series with the fixups[3] - hopefully with
the dependencies merged, we should see that go via Ulf's tree for the
next window.

[1] https://lore.kernel.org/all/CA+G9fYtioQ22nVr9m22+qyMqUNRsGdA=cFw_j1OUv=x8Pcs-bw@mail.gmail.com/
[2] https://lore.kernel.org/all/7h34k6olu9.fsf@baylibre.com/
[3] https://lore.kernel.org/linux-pm/20241101-lpm-v6-10-constraints-pmdomain-v5-0-3011aa04622f@baylibre.com/


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

