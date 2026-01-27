Return-Path: <linux-pm+bounces-41576-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODwkKyIXeWmyvAEAu9opvQ
	(envelope-from <linux-pm+bounces-41576-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 20:50:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 911BE9A217
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 20:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C7DF302A2C8
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 19:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5F36CDFB;
	Tue, 27 Jan 2026 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="HIAQ+L2l"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A22EB5B8
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769543445; cv=none; b=Yg4TAR70mC6B6lh+X4AgDs1vwLbOgyXYLjpMdT0AXGPFeArmA05tWs6gm7xy+xMw7tAkJfnHrtFMMgM7JYPXN9SDWJXhkr3vnhcX0Z2QcOP9ENrcX74qvw/g46Kt/4ZQ1e9dI7XvtwUyWk3LHZE0+Hl8bHcMRmnPvXh+Yu8ybyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769543445; c=relaxed/simple;
	bh=drkhLIzMez2S2IZ5JOqRlOli8JocjJC+pUdFJauGA1o=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=nOShQ5Ey6J9NqusDMqGQ3S60OvBp9AyQrLrqgQzpcqXYd0HQd4P31DZ2IRazrLfBEH9u8b9fKJm7Woo6uyI46TkzBlkXgnBxRhNF+ZzX5rDH6nkQkBU6cORM3ElEeux7DlEQdhbeHeOqjGHNshqKlhFR9g1PIiCEwEmHyI8IF1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=HIAQ+L2l; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1769543440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIWz0cFC3kNnEI7/yXdApj0ciiRcwdKXj/WVen8D0bA=;
	b=HIAQ+L2lkvYC5AwtPv7bhliGR3xmGTYTdFvJyZIfXOSgLayBWK2vOJzdCSBX/buFplVgHj
	QAJqrnq4X8KxZgSSojNdbyOzVNVXfPfUuwmfI9Yjibfs8YZVL8H3etQ2TQiGCzs2bDav40
	T2qPTGBdHBgdaP38vRLdtXgQLPu2gqM89K4uI5ILVFDrXLiMjYxnBZOwX/pLYJMIVb+da9
	zWWJLevNNC/Vc/i1vfvIvGl4SVPs07m1euIEc0zUP9MSZwQ8W1pfHBEwwc0D6+7Q9t89Tl
	+fF3FEGw/icDBAdU4r/yDuU3cm4cKSCl35DNn5FjrHL5i2tr90LCf8PCGKo/cQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 20:50:37 +0100
Message-Id: <DFZMSOLXYNIO.16HKO1E3C0Z2Y@cknow-tech.com>
To: "Chris Morgan" <macroalpha82@gmail.com>,
 <linux-rockchip@lists.infradead.org>
Cc: <linux-pm@vger.kernel.org>, <jonas@kwiboo.se>, <pgwipeout@gmail.com>,
 <finley.xiao@rock-chips.com>, <kever.yang@rock-chips.com>,
 <shawn.lin@rock-chips.com>, <sebastian.reichel@collabora.com>,
 <heiko@sntech.de>, <ulf.hansson@linaro.org>, "Chris Morgan"
 <macromorgan@hotmail.com>
Subject: Re: [PATCH] pmdomain: rockchip: quiet regulator error on
 -EPROBE_DEFER
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
References: <20251119161250.60885-1-macroalpha82@gmail.com>
In-Reply-To: <20251119161250.60885-1-macroalpha82@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cknow-tech.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cknow-tech.com:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41576-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kwiboo.se,gmail.com,rock-chips.com,collabora.com,sntech.de,linaro.org,hotmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[diederik@cknow-tech.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[cknow-tech.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 911BE9A217
X-Rspamd-Action: no action

On Wed Nov 19, 2025 at 5:12 PM CET, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Change the dev_err() to dev_err_probe() under rockchip_pd_power_on()
> to prevent errors early in the boot process when the requested
> regulator is not yet available. This converts errors like the following
> to debug messages:
>
> rockchip-pm-domain fd8d8000.power-management:power-controller: Failed to =
enable supply: -517

I noticed I had a LOT (33 to be exact) of these errors on my Rock 5B.
After building a kernel with just this patch added, those were all gone.
So feel free to add:

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # Rock 5B

I don't know if it's a logical consequence or just luck, but I'm no
longer getting the following error either:

  rockchip-pm-domain fd8d8000.power-management:power-controller:=20
    Failed to create device link (0x180) with supplier spi2.0 for
    /power-management@fd8d8000/power-controller/power-domain@12

I'm still getting the following error though:

  rockchip-pm-domain fd8d8000.power-management:power-controller:
    Failed to create device link (0x180) with supplier 1-0042 for
    /power-management@fd8d8000/power-controller/power-domain@8

Those error msgs are broken up for readability, but they are on one line
in dmesg.

Thanks!
  Diederik

> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 1955c6d453e4..3c84a65de1a5 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -688,7 +688,8 @@ static int rockchip_pd_power_on(struct generic_pm_dom=
ain *domain)
> =20
>  	ret =3D rockchip_pd_regulator_enable(pd);
>  	if (ret) {
> -		dev_err(pd->pmu->dev, "Failed to enable supply: %d\n", ret);
> +		dev_err_probe(pd->pmu->dev, ret,
> +			      "Failed to enable supply: %d\n", ret);
>  		return ret;
>  	}
> =20


