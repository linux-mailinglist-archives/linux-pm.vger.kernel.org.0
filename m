Return-Path: <linux-pm+bounces-41362-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDdMOOtWc2kDuwAAu9opvQ
	(envelope-from <linux-pm+bounces-41362-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 12:09:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0E974D04
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 12:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C738F3001187
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 11:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894403242AD;
	Fri, 23 Jan 2026 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="0uSEDq/7"
X-Original-To: linux-pm@vger.kernel.org
Received: from box.trvn.ru (box.trvn.ru [45.141.101.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6922D78A;
	Fri, 23 Jan 2026 11:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.141.101.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166565; cv=none; b=rJvQJhDnsi5Ph/eU0h38olP01wNfoJjSaAZwkEHUT+fkkk4ImBEGP+Lei9UcvSipgNWgUqsvKKpbFYKZBlccTk62qUXAF3nxyi9nRkxBPwsGje3lTDFLFwJhZtFBho2NT4uoPAB5wOlEVeIPzZvOSMieNvA2APdHnmcByXtEsuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166565; c=relaxed/simple;
	bh=/LZNc30g3t4Cjfm+QmOsx9EY/eY3QG6PbxIOoVMaxwQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Ws6yV6+xMBAUpXRQISoiK2AKGiLX23PoNG3ep+OfPSMBLI9H0O4qJE7BQ7wMwVM/1Zl+0rihcciShypy1TWTWygwYmEdtiW/Rz4T9Ci1MUlR5uAT08EzX1yIWqnfoiDTkINPBnumS7O6cIb1a93PJ5tHdTc9cfcwbRdpnElXyoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=0uSEDq/7; arc=none smtp.client-ip=45.141.101.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1769166551; bh=/LZNc30g3t4Cjfm+QmOsx9EY/eY3QG6PbxIOoVMaxwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0uSEDq/7xsj/cMSWXEEwvCebRHR8tljunhbxIHoVjRmf3MsInzBMtE8U+5aLpPOQz
	 Sh4c8lGbY41sOKhNHbQBQScQM85bDi2SvGrdJM8yRuROgeqzQqk2i9OqJ1ZzUoHQII
	 aNveL7ed501S4UIJH6Ho7Lz+OazHsilfMokXUsBb9Tsn2A0etAGu4wdV2idzjmoZOl
	 9mO54i365gBygjefBgu+pl+IaxUKs1YBwrw0uzjTT8/ORrq0MVEXmhs5D6TRpAb+4r
	 vGfRxODH3g3c0zbUDzMu+nYO2gaDl42xTxxWlgLcH6zn0iqxpgl3+QxSor5dIwjmwp
	 m9r7/rhdo5sYQ==
Received: from authenticated-user (box.trvn.ru [45.141.101.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 283FE698FC;
	Fri, 23 Jan 2026 16:09:11 +0500 (+05)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 23 Jan 2026 16:09:11 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, kernel@axis.com, Sebastian Reichel
 <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: pm8916_lbc: Fix use-after-free for extcon
 in IRQ handler
In-Reply-To: <e2a4cd2fcd42b6cd97d856c17c097289a2aed393.1769163273.git.waqar.hameed@axis.com>
References: <e2a4cd2fcd42b6cd97d856c17c097289a2aed393.1769163273.git.waqar.hameed@axis.com>
Message-ID: <79e7cfe8c324d580ad0189cbdd583184@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[trvn.ru,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[trvn.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41362-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[trvn.ru:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikita@trvn.ru,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF0E974D04
X-Rspamd-Action: no action

Waqar Hameed писал(а) 23.01.2026 15:24:
> Using the `devm_` variant for requesting IRQ _before_ the `devm_`
> variant for allocating/registering the `extcon` handle, means that the
> `extcon` handle will be deallocated/unregistered _before_ the interrupt
> handler (since `devm_` naturally deallocates in reverse allocation
> order). This means that during removal, there is a race condition where
> an interrupt can fire just _after_ the `extcon` handle has been
> freed, *but* just _before_ the corresponding unregistration of the IRQ
> handler has run.
> 
> This will lead to the IRQ handler calling `extcon_set_state_sync()` with
> a freed `extcon` handle. Which usually crashes the system or otherwise
> silently corrupts the memory...
> 
> Fix this racy use-after-free by making sure the IRQ is requested _after_
> the registration of the `extcon` handle.
> 
> Fixes: f8d7a3d21160 ("power: supply: Add driver for pm8916 lbc")
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
> Note that this patch is based on `for-next` branch in Sebastian
> Reichel's tree [1]. See the discussion in a previous patch series [2]
> for reason and background.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/?h=for-next
> [2] https://lore.kernel.org/lkml/64d8dd3675a4e59fa32c3e0ef451f12d1f7ed18f.1766268280.git.waqar.hameed@axis.com/
> 

Reviewed-by: Nikita Travkin <nikita@trvn.ru>

Thanks!
Nikita

>  drivers/power/supply/pm8916_lbc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/pm8916_lbc.c b/drivers/power/supply/pm8916_lbc.c
> index 3ca717d84aade..6b631012a7959 100644
> --- a/drivers/power/supply/pm8916_lbc.c
> +++ b/drivers/power/supply/pm8916_lbc.c
> @@ -327,11 +327,6 @@ static int pm8916_lbc_charger_probe(struct platform_device *pdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_lbc_charger_state_changed_irq,
> -					IRQF_ONESHOT, "pm8916_lbc", chg);
> -	if (ret)
> -		return ret;
> -
>  	chg->edev = devm_extcon_dev_allocate(dev, pm8916_lbc_charger_cable);
>  	if (IS_ERR(chg->edev))
>  		return PTR_ERR(chg->edev);
> @@ -340,6 +335,11 @@ static int pm8916_lbc_charger_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "failed to register extcon device\n");
>  
> +	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_lbc_charger_state_changed_irq,
> +					IRQF_ONESHOT, "pm8916_lbc", chg);
> +	if (ret)
> +		return ret;
> +
>  	ret = regmap_read(chg->regmap, chg->reg[LBC_USB] + PM8916_INT_RT_STS, &tmp);
>  	if (ret)
>  		goto comm_error;
> 
> base-commit: 432b119ab8d8bf1f550c247f7fbe960e87ba6c92

