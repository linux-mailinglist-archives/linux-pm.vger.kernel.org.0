Return-Path: <linux-pm+bounces-43768-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKcAD3Gjqml6UwEAu9opvQ
	(envelope-from <linux-pm+bounces-43768-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 10:50:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFCB21E3A9
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 10:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 409D3300A640
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 09:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C8134AB01;
	Fri,  6 Mar 2026 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A9deMTUM"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D9634750D;
	Fri,  6 Mar 2026 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772790635; cv=none; b=DEjW7HOuBewBUihTQdhIoKaX1XyM8lE+e7tpqzzXrwJC5s7ZzVkEkjbuouK7tbHz7l10mJcCZI/kQz+DesYfSAxDodwatEzW0nIRzShfPvLmlqPIlV/lxi1/JfgswXB4sX+2meRGTDayib/RpIPdKx8WWRCZHbRF6Kxo2fjluD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772790635; c=relaxed/simple;
	bh=eOh2DPmGNAcPMGrAcM6Rp0B3989BodaM6vMWb9GBktU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f325qRD8eJHh/PbfhSK873E7/NsPkKiiCL/EsMYeAXW6SWt3h84GGj0SuKgPUWwNQmUm8vN8syM7qdaQ71gMW7zV08qbxq4/Khm4VAsXz2rtzFdQqUUe5koddmrEVEFr8GL1qJBzJWmB+iP72K/MeOvZWnSqOigZuRrzHuiznJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A9deMTUM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1772790632;
	bh=eOh2DPmGNAcPMGrAcM6Rp0B3989BodaM6vMWb9GBktU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A9deMTUMmsKTLdIGI2+lwnuVwIRxkyPIFLGsjQiLFqzgLl3Fw+PKU/4m3zisOF1h3
	 0P3orfcOAMx2hgSnwVfkyx0MZ3XLoeJw7VpstjRYYcas37JbjtiPQOL3zdWmiOL/aV
	 TzVdE4nhrVDnPwX5KU/Kw5yiAumr+tR9U+cHNTxoHYkLdbomew0kaJ+PEeM+TZ6BQ3
	 tcMszmQfnFdIqhNvessUzqlTCctpb2afvVovJMc13f8Ku+SrJc6ENjs+vzBtS1ANkC
	 tcl1YvU/1OOuYFfRKPXlhgNFHawxbag1D8uk2kWgEnWahDlAcptyEVDKF/cn4EQnYf
	 xZoaTIZ9L8V8A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0E1C817E04DC;
	Fri,  6 Mar 2026 10:50:32 +0100 (CET)
Message-ID: <7fd891b7-b1ff-4668-ac99-8f8ac244d90c@collabora.com>
Date: Fri, 6 Mar 2026 10:50:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] pmdomain: mediatek: Fix power domain count
To: Ulf Hansson <ulf.hansson@linaro.org>, Adam Ford <aford173@gmail.com>
Cc: linux-mediatek@lists.infradead.org,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Laura Nao <laura.nao@collabora.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20260210053708.17239-1-aford173@gmail.com>
 <CAPDyKFrsMY8q+rvrbOdppYnefX6TA1-EhF+e+pGG6k49KpeTRA@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAPDyKFrsMY8q+rvrbOdppYnefX6TA1-EhF+e+pGG6k49KpeTRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3CFCB21E3A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43768-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linaro.org,gmail.com];
	FREEMAIL_CC(0.00)[lists.infradead.org,baylibre.com,kernel.org,gmail.com,collabora.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[angelogioacchino.delregno@collabora.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Il 12/02/26 12:34, Ulf Hansson ha scritto:
> On Tue, 10 Feb 2026 at 06:40, Adam Ford <aford173@gmail.com> wrote:
>>
>> The wrong value of the number of domains is wrong which leads to
>> failures when trying to enumerate nested power domains.
>>
>>   PM: genpd_xlate_onecell: invalid domain index 0
>>   PM: genpd_xlate_onecell: invalid domain index 1
>>   PM: genpd_xlate_onecell: invalid domain index 3
>>   PM: genpd_xlate_onecell: invalid domain index 4
>>   PM: genpd_xlate_onecell: invalid domain index 5
>>   PM: genpd_xlate_onecell: invalid domain index 13
>>   PM: genpd_xlate_onecell: invalid domain index 14
>>
>> Attempts to use these power domains fail, so fix this by
>> using the correct value of calculated power domains.
>>
>> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> We should have a fixes tag for this too I think:
> 
> Fixes: 88914db077b6 ("pmdomain: mediatek: Add support for Hardware
> Voter power domains")
> 
> 
>> ---
>>   drivers/pmdomain/mediatek/mtk-pm-domains.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
>> index 58648f4f689b..d2b8d0332951 100644
>> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
>> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
>> @@ -1228,7 +1228,7 @@ static int scpsys_probe(struct platform_device *pdev)
>>          scpsys->soc_data = soc;
>>
>>          scpsys->pd_data.domains = scpsys->domains;
>> -       scpsys->pd_data.num_domains = soc->num_domains;
>> +       scpsys->pd_data.num_domains = num_domains;
> 
> Not sure this is the complete fix, as scpsys_add_one_domain() seems to
> be using the wrong value of "num_domains" too, no?
> 

No, scpsys_add_one_domain() uses num_domains from the soc_data for DIRECT_CTL,
which is expected. Maybe that can be improved, but it's how it is supposed to work.

So yeah, this patch is resolving an issue, and it is a complete fix.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>>
>>          parent = dev->parent;
>>          if (!parent) {
>> --
>> 2.51.0
>>
> 
> Kind regards
> Uffe


