Return-Path: <linux-pm+bounces-42461-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE1JOLFZi2ljUAAAu9opvQ
	(envelope-from <linux-pm+bounces-42461-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 17:15:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AFB11CFFC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 17:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32A3B3031326
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E66389DF0;
	Tue, 10 Feb 2026 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jq81/DkT"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1203EBF2E;
	Tue, 10 Feb 2026 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740113; cv=none; b=Tp8Kbz4YDghvMFuKKlWGtOT8Q2jJKH3R2ifUyRyocShClSdSeH6LLixPbr+XShAfRez//zxQwZ58V0QN9pQQMx8LKNcqKHEUjrK6blXNCyJ1GSWLBoo/4CN3WuEk5+NLw6+A7Of8vacgysavRQ+IlBLkE9tpW5edNZI9gNiCcnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740113; c=relaxed/simple;
	bh=ESssw3AcJ/djN6ROZdEIy2RGCShV5/2AG674QUn3s1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DpbVNLWj+NxEB79USaGsBobYhDXsw6xGsj309U8fUhq9z4I7UHMlO1PeeiB8psC8J8qbh2+dbUUJlTFhbi5FskdiEGqCWyMCqdLu/XYV5RerWrM5/5Shnx7kwuz/ZBqq4k6aI/UWRnsmebYOA14/wSWe0ISSa9x6zm0uX4inarU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jq81/DkT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770740110;
	bh=ESssw3AcJ/djN6ROZdEIy2RGCShV5/2AG674QUn3s1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jq81/DkTQ50k6Du5aMe0jYXrIYsIr/tvNvYgUjxFVCpxwVzet94JC+4xhx/51iUFy
	 u12/nuIG0maHLuTKHDy1FHtFRA1IvYUsa0anxLnyGfW4IsqA0rkYNqjFhA8ESQq3yy
	 QJoT9vjvz6kUc5WJU3MpeJ2WBAQglUq67AhX2wWJ2MtTL4B+rvRG6mXXnTcE+4V8Xn
	 zLSjWVDKybK49QUm0xvmkuZtDysk+8sPa5C+JC0L2gLtPgizqjeF3onvlHtA0IoNw9
	 czQ8UYDkErtlZh44Wdj9eKm8AjQPssLcSR+EN0jICAnRzDOjhpDCWErvxSV0p6ei+g
	 Bj6fBpva8gLpg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:7872:ec71:6d40:b8ea])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A360417E0C21;
	Tue, 10 Feb 2026 17:15:09 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: aford173@gmail.com
Cc: angelogioacchino.delregno@collabora.com,
	broonie@kernel.org,
	laura.nao@collabora.com,
	lgirdwood@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org,
	matthias.bgg@gmail.com,
	mturquette@baylibre.com,
	nfraprado@collabora.com,
	sboyd@kernel.org,
	ulf.hansson@linaro.org
Subject: Re: [PATCH 5/5] drivers: clk: mediatek: Fix error finding regmap
Date: Tue, 10 Feb 2026 17:14:57 +0100
Message-Id: <20260210161457.43020-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260210053708.17239-5-aford173@gmail.com>
References: <20260210053708.17239-5-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[collabora.com,kernel.org,gmail.com,lists.infradead.org,vger.kernel.org,baylibre.com,linaro.org];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42461-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laura.nao@collabora.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:mid,collabora.com:dkim]
X-Rspamd-Queue-Id: 88AFB11CFFC
X-Rspamd-Action: no action

Hi,

On 2/10/26 06:37, Adam Ford wrote:
> The clock driver for clk-mt8196-vdisp-ao doesn't use the same common clk
> functions that other clocks use.  As such, this clock returns an error:
>
>   Cannot find regmap for /soc: -ENOMEM
>   clk-mt8196-vdisp-ao 3e800000.syscon: probe with driver clk-mt8196-vdisp-ao failed with error -12
>
> Fix this by using the common clock calls.  With this patch, the following
> new clocks properly enumerate:
>
>   mm_v_disp_vdisp_ao_config
>   mm_v_disp_dpc
>   mm_v_smi_sub_somm0
>
> Fixes: d4fb7e15a520 ("clk: mediatek: Add MT8196 disp-ao clock support")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  drivers/clk/mediatek/clk-mt8196-vdisp_ao.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8196-vdisp_ao.c b/drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
> index fddb69d1c3eb..070c60f40b64 100644
> --- a/drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
> +++ b/drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
> @@ -67,8 +67,8 @@ static const struct of_device_id of_match_clk_mt8196_vdisp_ao[] = {
>  MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_vdisp_ao);
>  
>  static struct platform_driver clk_mt8196_vdisp_ao_drv = {
> -	.probe = mtk_clk_pdev_probe,
> -	.remove = mtk_clk_pdev_remove,
> +	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  	.driver = {
>  		.name = "clk-mt8196-vdisp-ao",
>  		.of_match_table = of_match_clk_mt8196_vdisp_ao,

This driver is actually expected to be registered by the mtk-mmsys 
driver via platform_device_register_data() (related changes are in a 
pending series [1]), which is why it is probed via mtk_clk_pdev_probe.

[1] https://lore.kernel.org/all/20250828080855.3502514-8-paul-pl.chen@mediatek.com/

Best,

Laura


