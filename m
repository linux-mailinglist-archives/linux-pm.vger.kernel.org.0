Return-Path: <linux-pm+bounces-12128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D3894FD05
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 07:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25EDAB21C8E
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 05:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7931F94A;
	Tue, 13 Aug 2024 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jqO1fkN/"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712491EB2F
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 05:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723525534; cv=none; b=kfeILrDsFpyjd6suMsw3MDjBcjOxhfeX+uJp+KjSPPmbD4eLZSsoGs33mYH8D+Xv0dqDmUVkoUSdwKELQ0DUt5I2lHDPVltNV6JZoCtaC6NXFY9dYaRZbJE0LR4kHNhmvc4UBWhuEuPpnGe8SF7xkh5OACKeCbUUHGbEHLK3k0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723525534; c=relaxed/simple;
	bh=LXcUZW8o5cGzuyFG1TNOiXigsF393zQf2HcV/l8HWOw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2BXCYiKfCKIJ39kgZ2CYAiTGqs/vDr/xf5jS5cJbJYQ55L6gHNeK+wPKliQGq+d2sdGO745HDLtNbMrVIk84A1OeX4ybl5wFcOqffXLI5FQhoZHcqtd4sDnqygBee1jFVvtEgnyecJxf0BOuixfxxNRxfW5pB+7wEhwwe0cjU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jqO1fkN/; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47D50F3A083674;
	Tue, 13 Aug 2024 00:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723525215;
	bh=hv1DmxiMUaEqRG1nC0yA/plDeoE7CoA3Kc6ylHPzEnw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jqO1fkN/A4NKNBz/zg7w5H4KxKW3G6QbldQT+dB7o3wROh4bgRhXNAq5Mx2XKu5Po
	 1hiBWGBQZkWI6iI5Ep8k6xzHIb6tk40iZESrlb2ZgL/G5c0tOZdllR/qMVTm9iq2rt
	 8yyqwxlDhDU93fSui8ZWi8D2kiM5sWw3fF2x/f8M=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47D50F4n078506
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Aug 2024 00:00:15 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 00:00:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 00:00:15 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47D50Erf008964;
	Tue, 13 Aug 2024 00:00:15 -0500
Date: Tue, 13 Aug 2024 10:30:14 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Zhang Zekun <zhangzekun11@huawei.com>
CC: <edubezval@gmail.com>, <j-keerthy@ti.com>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] thermal: ti-soc-thermal: Remove unused declarations
Message-ID: <20240813050014.igo6lnlgio5au6dq@lcpd911>
References: <20240812125210.94280-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240812125210.94280-1-zhangzekun11@huawei.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Aug 12, 2024 at 20:52:10 +0800, Zhang Zekun wrote:
> The functions definition of ti_bandgap_read_thot(),
> ti_bandgap_write_thot(), ti_bandgap_read_tcold() and
> ti_bandgap_write_tcold() has been removed since commit 9bebf3485c6a
> ("thermal: ti-soc-thermal: remove dead code"), remain the declarations
> untouched in the header files. So, clean up this unused declarations.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>  drivers/thermal/ti-soc-thermal/ti-bandgap.h | 4 ----
>  1 file changed, 4 deletions(-)
> 

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva

