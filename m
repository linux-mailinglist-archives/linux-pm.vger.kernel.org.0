Return-Path: <linux-pm+bounces-1905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2DB8259E5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jan 2024 19:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA271C23779
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jan 2024 18:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DC23588E;
	Fri,  5 Jan 2024 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="rB3BJ+l/"
X-Original-To: linux-pm@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF263527E
	for <linux-pm@vger.kernel.org>; Fri,  5 Jan 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id LmtnrT66480oiLol0r88KB; Fri, 05 Jan 2024 18:17:22 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Lol0rXRSFD6lhLol0r3PWn; Fri, 05 Jan 2024 18:17:22 +0000
X-Authority-Analysis: v=2.4 cv=LNR1/ba9 c=1 sm=1 tr=0 ts=659847b2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=7YfXLusrAAAA:8 a=VwQbUJbxAAAA:8 a=_MUxwH_1hrhzMBYmUHsA:9 a=QEXdDO2ut3YA:10
 a=SLz71HocmBbuEhFRYD3r:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9I/V4bfaoYSOxFfnj8JFSrOi1wVdUSbRrkSkeRTBjnw=; b=rB3BJ+l/ZQSDA8Sk9VwkRFJRzb
	aL/dkDOCl3UtoelOYMsMkSTz99aqaeRy4nLtWrM967qj/lud31V+W0CNMQcpbqcxd3OjM4JCzGIMq
	fQnNAQrjqhqKYBclf9DkyzGkeY17MLkN2/9QpteCRMFmJ9OjyOY/tvO3VpVpz2XoAuYBdsjsgtUkm
	mSDw8GtnSYpKWV7ojECsJ/Th3BboRCRtjDJ5Q4S6UpuSHpd5L3ejHbCGE5XNMW2nihes1DfEatELx
	BufUr+kuV9tpeayqKRX9rqOkuQ5OZnWGhpB9lr7OIvmZnwjXhC4/Fwqb6yp1E5dWFE/XmGOhi+Yav
	ItP2PGzw==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:13689 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rLokz-003FGW-0q;
	Fri, 05 Jan 2024 12:17:21 -0600
Message-ID: <b12b56a9-2d20-4802-bbc8-43f4831b3113@embeddedor.com>
Date: Fri, 5 Jan 2024 12:17:18 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM / QOS: Use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240105181118.116292-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240105181118.116292-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.186
X-Source-L: No
X-Exim-ID: 1rLokz-003FGW-0q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.157.186]:13689
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLLO6g9gT0wsr249eNXqHrJEtMlLtFYteDb5GLQ60CLcQl2tp90CzJfLSNQosoAsbxONrreneKUQdUO1diMr7mN6aYsuwH5JctD79hxhTdzGZ3dS21nO
 nzyQ60kl6rfiyeMac1lCWRqotW4sFv7it0cM6fx+qZ0b1oxVyQ//eKmZxY6q0/JoG39+d0PFlrYyTtJgVv7I0r16+hVE/zSUDrs=



On 1/5/24 12:11, Erick Archer wrote:
> Use 2-factor multiplication argument form kcalloc() instead
> of kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/base/power/qos.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 8e93167f1783..bd77f6734f14 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -201,7 +201,7 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
>   	if (!qos)
>   		return -ENOMEM;
> 
> -	n = kzalloc(3 * sizeof(*n), GFP_KERNEL);
> +	n = kcalloc(3, sizeof(*n), GFP_KERNEL);
>   	if (!n) {
>   		kfree(qos);
>   		return -ENOMEM;
> --
> 2.42.0
> 
> 

