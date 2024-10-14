Return-Path: <linux-pm+bounces-15600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD3699C283
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 10:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734371F23790
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 08:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B38F147C98;
	Mon, 14 Oct 2024 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jGAGlW9q"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72AD9474;
	Mon, 14 Oct 2024 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893201; cv=none; b=pN3wJFIZV4jsOScOjW7+pwcyYoDG0ZOCU/QsQKvn7QWvQsBKlD52c+yV+ABc7J8256kC96Rh1Tt/qNJ6Kq68yZC+hwVXwXpj3pr8QT+AXqHAuXKSWGI5r92alBHPvRogEne6Xu9YhW3XBnlEinbNdCdbBb0Fdk4y40fGSGmNcB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893201; c=relaxed/simple;
	bh=sSQ/JLtfOylYmetmA4x1PJlINm2mWwdgTelJNw1+qv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kx7p0J2lh8OkBMqKEZlelU5zdC1jrqmNVI4BOL59Iml47bLkQVaMx6AQRDnD2azMunK/x1w0Ls0JYCjONcD5J1viBc8qW8OgY+IQFV6bkjDy9iF+RJeoQc1yAhW5R8UsA0JenjCjJn3Nq1vcaFVCRCxi6sIK+1qzpUPg50ZciEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jGAGlW9q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728893198;
	bh=sSQ/JLtfOylYmetmA4x1PJlINm2mWwdgTelJNw1+qv8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jGAGlW9qACfI26EUDUV9ViwMCdDvwOhgDdmF4wXFH4qKTONWDsWczOgCX4imvaOmH
	 RcTOLerC2LWpfDhNXVQVpqUrA3eph8tCQiy0N29Vv2JLTv2HvR+lvSzkwUsL29oYPW
	 9HgsBum46bSbUbojdRFc3n5OQOR8FiKBO/Xjzi2/yzhc87WdFFFv3cBjiTm3h0taW6
	 mIn/VBWwLEpExGXCoPSXPm7SdaiuDZoJRsE2+t3QCxwcOt7mnY7Nbqmcss56oEsHbz
	 HyqhcxIjjTTSgMxoVHsCrioltl/OgvtX3naJY5Oawcx5ntQ2bycFqv4gBdqFkMCUNE
	 FbpmQOqJqH7Ag==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5405217E10C7;
	Mon, 14 Oct 2024 10:06:37 +0200 (CEST)
Message-ID: <863458cb-cac7-40c0-856d-edc0fa6ee6a6@collabora.com>
Date: Mon, 14 Oct 2024 10:06:36 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] MediaTek DVFSRC Bus Bandwidth and Regulator knobs
To: Rob Herring <robh@kernel.org>
Cc: djakov@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, keescook@chromium.org, gustavoars@kernel.org,
 henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com, wenst@chromium.org, amergnat@baylibre.com
References: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
 <CAL_Jsq+F_pwhVLD1HF7=sYLp2w5kpc53UmzzffxyKzwh8WZthw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAL_Jsq+F_pwhVLD1HF7=sYLp2w5kpc53UmzzffxyKzwh8WZthw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 12/10/24 00:15, Rob Herring ha scritto:
> On Mon, Jun 10, 2024 at 3:57 AM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Changes in v6:
>>   - Fixed build with clang (thanks Nathan!)
>>   - Removed unused mtk_rmw() macro in mtk-dvfsrc.c
>>   - Added MODULE_DESCRIPTION() to mtk-dvfsrc-regulator.c
>>
>> Changes in v5:
>>   - Fixed Kconfig dependencies in interconnect
>>   - Fixed module build for dvfsrc and interconnect
>>
>> Changes in v4:
>>   - Updated patch [3/7] to actually remove address/size cells
>>     as the old version got unexpectedly pushed in v3.
>>
>> Changes in v3:
>>   - Removed examples from interconnect and regulator bindings
>>     and kept example node with interconnect and regulator in
>>     the main DVFSRC binding as suggested
>>   - Removed 'reg' from interconnect and regulator, removed both
>>     address and size cells from the main DVFSRC binding as that
>>     was not really needed
>>   - Added anyOf-required entries in the regulator binding as it
>>     doesn't make sense to probe it without any regulator subnode
>>
>> Changes in v2:
>>   - Fixed issues with regulator binding about useless quotes and
>>     wrong binding path (oops)
>>   - Removed useless 'items' from DVFSRC main binding
>>   - Allowed address/size cells to DVFSRC main binding to resolve
>>     validation issues on the regulator and interconnect bindings
>>   - Changed dvfsrc node name to `system-controller`, as the DVFSRC
>>     is actually able to control multiple system components.
>>   - Added a commit to remove mtk-dvfs-regulator.c before adding the
>>     new, refactored regulator driver
>>
>>
>> This series adds support for the MediaTek Dynamic Voltage and Frequency
>> Scaling Resource Controller (DVFSRC), found on many MediaTek SoCs.
>>
>> This hardware collects requests from both software and the various remote
>> processors embededd into the SoC, and decides about a minimum operating
>> voltage and a minimum DRAM frequency to fulfill those requests, in an
>> effort to provide the best achievable performance per watt.
>>
>> Such hardware IP is capable of transparently performing direct register
>> R/W on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.
>>
>> Summarizing how the DVFSRC works for Interconnect:
>>
>>               ICC provider         ICC Nodes
>>                                ----          ----
>>               _________       |CPU |   |--- |VPU |
>>      _____   |         |-----  ----    |     ----
>>     |     |->|  DRAM   |       ----    |     ----
>>     |DRAM |->|scheduler|----- |GPU |   |--- |DISP|
>>     |     |->|  (EMI)  |       ----    |     ----
>>     |_____|->|_________|---.   -----   |     ----
>>                 /|\         `-|MMSYS|--|--- |VDEC|
>>                  |             -----   |     ----
>>                  |                     |     ----
>>                  | change DRAM freq    |--- |VENC|
>>               --------                 |     ----
>>      SMC --> | DVFSRC |                |     ----
>>               --------                 |--- |IMG |
>>                                        |     ----
>>                                        |     ----
>>                                        |--- |CAM |
>>                                              ----
>>
>> ...and for regulators, it's simply...
>>     SMC -> DVFSRC -> Regulator voltage decider -> (vreg) Registers R/W
>>
>> Please note that this series is based on an old (abandoned) series from
>> MediaTek [1], and reuses some parts of the code found in that.
>>
>> Besides, included in this series, there's also a refactoring of the
>> mtk-dvfsrc-regulator driver, which never got compiled at all, and would
>> not build anyway because of missing headers and typos: that commit did
>> not get any Fixes tag because, well, backporting makes no sense at all
>> as the DVFSRC support - which is critical for that driver to work - is
>> introduced with *this series*! :-)
>>
>> P.S.: The DVFSRC regulator is a requirement for the MediaTek UFSHCI
>>        controller's crypto boost feature, which is already upstream but
>>        lacking the actual regulator to work....... :-)
>>
>> [1]: https://lore.kernel.org/all/20210812085846.2628-1-dawei.chien@mediatek.com/
>>
>> AngeloGioacchino Del Regno (7):
>>    dt-bindings: regulator: Add bindings for MediaTek DVFSRC Regulators
>>    dt-bindings: interconnect: Add MediaTek EMI Interconnect bindings
>>    dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
>>    soc: mediatek: Add MediaTek DVFS Resource Collector (DVFSRC) driver
> 
> Looks like the driver got picked up, but not the binding.
> mediatek,mt8183-dvfsrc and mediatek,mt8195-dvfsrc show up in next as
> undocumented.
> 
Thanks for making me notice. Adding it up right now.

Cheers,
Angelo

