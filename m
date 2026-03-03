Return-Path: <linux-pm+bounces-43471-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAVOLfIwpmkrLwAAu9opvQ
	(envelope-from <linux-pm+bounces-43471-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 01:53:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2451E7684
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 01:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA6A63088600
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 00:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9C821254B;
	Tue,  3 Mar 2026 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FZRA8lxd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m3298.qiye.163.com (mail-m3298.qiye.163.com [220.197.32.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EB61F192E
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 00:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772498984; cv=none; b=te3+aJacDGJpUqmDFGN/3he+5j8WWD4EkxqAolOartnCHHWKvc21B2mbliiVhsFT67efGVZVtsbuYnqADlb2C9Aoq/Bnt23zUL1K3G+XNlfZ5SgMYYpSQnq0Tj+F/NK4sIAO6RuJQeqtzqlekv7rTYUt/WtOMyuBmPpqrcrImao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772498984; c=relaxed/simple;
	bh=jcDxGBWPgH+4px9W9zIUW9QrG9LullPjfU94SIsaDg0=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=O1Fd6aH2ryFzQYPo7gwe5XHOur+GGkmhtE824xFrv+1HlTqaYONPR3MSLlkA2EPbJwgayL4t2FwEww2B+99jkCCKwUcV9OczIkvl0h9gvztAkDnK/fSJKM81ugr+00R4k50l3R1lEsGnPELvoyM9Fu4OypF+7oHQitXcjn+cwiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FZRA8lxd; arc=none smtp.client-ip=220.197.32.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3581a66a6;
	Tue, 3 Mar 2026 08:49:30 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, linux-pm@vger.kernel.org, jonas@kwiboo.se,
 pgwipeout@gmail.com, finley.xiao@rock-chips.com, kever.yang@rock-chips.com,
 sebastian.reichel@collabora.com, heiko@sntech.de, ulf.hansson@linaro.org,
 Chris Morgan <macromorgan@hotmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH V2] pmdomain: rockchip: quiet regulator error on
 -EPROBE_DEFER
To: Chris Morgan <macroalpha82@gmail.com>
References: <20260130163102.51757-1-macroalpha82@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <a1e98f19-2c68-d59e-07bd-57bbcbc742c6@rock-chips.com>
Date: Tue, 3 Mar 2026 08:49:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260130163102.51757-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cb12be8a409cckunm83dbe4c510455dd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpOQ1YYSUMfGk1CTxkaTxlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FZRA8lxdP09fxkkMLLfh54R6dP08hfZSKemdHFTpAj0YO8h5Rtj3Ov2Yvu7aQA2BkFzQy3Udf8pEUsuiSZOoxpQgLCqyS9YB2NEibtl1V2BbM6nom598xRQIbpNbj4uG4sF1uptiWTUkdRTK2zw7ibJ7N8bKmxeNL6a3PPmm9nA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=qgc2EI+SrAhln7tyy6J5i4dEecxK8IQ9XGIqONjIZWo=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Queue-Id: 0F2451E7684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43471-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[rock-chips.com,vger.kernel.org,kwiboo.se,gmail.com,collabora.com,sntech.de,linaro.org,hotmail.com,cknow-tech.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

ÔÚ 2026/01/31 ÐÇÆÚÁù 0:31, Chris Morgan Ð´µÀ:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Change the dev_err() to dev_err_probe() under rockchip_pd_power_on()
> to prevent errors early in the boot process when the requested
> regulator is not yet available. This converts errors like the following
> to debug messages:
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> rockchip-pm-domain fd8d8000.power-management:power-controller: Failed to enable supply: -517
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>
> ---
> Changes since v1:
>   - Simplified return to single line
> ---
>   drivers/pmdomain/rockchip/pm-domains.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 997e93c12951..6d3fb18f4ab3 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -705,10 +705,9 @@ static int rockchip_pd_power_on(struct generic_pm_domain *domain)
>   	int ret;
>   
>   	ret = rockchip_pd_regulator_enable(pd);
> -	if (ret) {
> -		dev_err(pd->pmu->dev, "Failed to enable supply: %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(pd->pmu->dev, ret,
> +				     "Failed to enable supply: %d\n", ret);
>   
>   	ret = rockchip_pd_power(pd, true);
>   	if (ret)
> 

