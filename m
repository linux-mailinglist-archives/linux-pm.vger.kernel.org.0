Return-Path: <linux-pm+bounces-8697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4898FE341
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 11:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DB11C25B38
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 09:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BFC1527BA;
	Thu,  6 Jun 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="AnqJWWac"
X-Original-To: linux-pm@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFAC152190;
	Thu,  6 Jun 2024 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666996; cv=none; b=Jit7LapfhdfuD51oJmRpMfXDPXaDuziTIm6GzfLTA0+KQGZ22YSNQZ7WHHWLjPNcDnxK9IqGZzkXzEzr28Oo06qShm2VRkIGAasvqjn5d0Xf/pyUgHKrWb7oVb4gu+77lN4qYTg8rvep5cGnQle2aRDs54C8+d4LxbZgyeO1XTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666996; c=relaxed/simple;
	bh=WtTZSw6o7QEZSnR1qQILwf1Zth+4B8umIuBjR4kuBpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKhtsc7dLvUyeEDI3xSL1gfZT6d19EFPVt+5r/CUcFvhPLBGRYEEa6lZsnCIz0HGDDemc8icmV4zosYfwDcQgV43JF3N1g34XZB49vDwVn6IIEpbtwjC+l+cB1ERDNg1mJ96jrNpniHJP+EfW1T/2XnyaMC2b1urdXEYAV5ElI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=AnqJWWac; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TgGEgyUVmHUDzUOi3z1nNiQyiJsY5J6O2RDDS20xA9s=; b=AnqJWWacRCXWds/85xXwzG74xo
	czzU3YqcWm4nfly8wuOSVJQtVL8BLnHumexytxj53CNId8miHCeXpjD8QKNCS55b/AmKzzcmjIW6Q
	n8KrRgsf+OU+pA5itVgu/+YqXf4lGHDmo22NTLHIo9LIGY0cg2vc3qjNAawdZv7IMRCfhX+w5ht2f
	XI811XNpgPElAHg9d2C8fCP8f5THnchUlFjcbpc7AgwFW4tGm6+0Xj0doTAz9KqJZKYDxSZ+5cTr2
	nplTI8LM70gXikhRuRMHTwmTtyh4V1/8260i4idVdPqM8AzgOX7mWl0jpUShTjyBseMJIqfSj1hdb
	34AGzHsg==;
Received: from [89.212.21.243] (port=41906 helo=[192.168.69.116])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1sF9eL-00BrXZ-0L;
	Thu, 06 Jun 2024 11:43:12 +0200
Message-ID: <ed06bac9-6396-426a-b0ea-4932bc5fa7ed@norik.com>
Date: Thu, 6 Jun 2024 11:43:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] OPP: ti: Fix ti_opp_supply_probe wrong return values
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@lists.phytec.de
References: <20240606070127.3506240-1-primoz.fiser@norik.com>
 <20240606085956.wsp3ecyfqck5tltt@vireshk-i7>
From: Primoz Fiser <primoz.fiser@norik.com>
Content-Language: en-US
Organization: Norik systems d.o.o.
In-Reply-To: <20240606085956.wsp3ecyfqck5tltt@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Viresh,

On 6. 06. 24 10:59, Viresh Kumar wrote:
> On 06-06-24, 09:01, Primoz Fiser wrote:
>> Function ti_opp_supply_probe() since commit 6baee034cb55 ("OPP: ti:
>> Migrate to dev_pm_opp_set_config_regulators()") returns wrong values
>> when all goes well and hence driver probing eventually fails.
>>
>> Fixes: 6baee034cb55 ("OPP: ti: Migrate to dev_pm_opp_set_config_regulators()")
>> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
>> ---
>>  drivers/opp/ti-opp-supply.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
>> index e3b97cd1fbbf..ec0056a4bb13 100644
>> --- a/drivers/opp/ti-opp-supply.c
>> +++ b/drivers/opp/ti-opp-supply.c
>> @@ -393,10 +393,12 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	ret = dev_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
>> -	if (ret < 0)
>> +	if (ret < 0) {
>>  		_free_optimized_voltages(dev, &opp_data);
>> +		return ret;
>> +	}
>>  
>> -	return ret;
>> +	return 0;
>>  }
>>  
>>  static struct platform_driver ti_opp_supply_driver = {
> 
> Not sure I understand the problem here. Can you please explain with an
> example ?

ti_opp_supply_probe
 -> dev_pm_opp_set_config_regulators
  -> dev_pm_opp_set_config (returns negative if error, otherwise >= 1)

Lets assume dev_pm_opp_set_config returns 1 (SUCCESS):

so now, without my patch:
ti_opp_supply_probe returns 1 -> FAILURE and hence error:

ti_opp_supply 4a003b20.opp-supply: probe with driver ti_opp_supply
failed with error 1

with my patch:
ti_opp_supply_probe returns 0 -> SUCCESS

BR,
Primoz


