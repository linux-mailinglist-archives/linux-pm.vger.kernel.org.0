Return-Path: <linux-pm+bounces-34216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E07B4A46D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 10:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE57B16E01B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 08:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF3B24167B;
	Tue,  9 Sep 2025 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="al3PABxv"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B4323ABB3;
	Tue,  9 Sep 2025 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404891; cv=none; b=j68Sq/tTk3qdXbJDBhyiHPcfMsmaj+ahK1i5PT5nVsBkkQHlGZNy1bP/pPDQbZwgZna1AMJnlw2Hwal3oCdOOucSDQQgGJzOhfUz1T9mUQF7TXx68l9Ue+RYaptn+IDyRA08jhTTERtUw2lYR0jotwhZM7M5CfHyMHoDJEuEQtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404891; c=relaxed/simple;
	bh=4UxeFMW9X07zobckfuhD8yCpJ07mc4o6RlRFftvs/mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1sCHZMj7G6oArv4vZaLK/9gZcql9JkgwUm94/RDXVlFAywU8NGaQy9p3xLYGLuHAiJ+7E617uZquJkMIhhczRhaUhff4GOkEG+Q7vT3gtIEPCB/BcwfxG4zCus8RT3Hwfzm85RL6uFe+AGSQIOEGX0opN72mBHdIHnCeDWWJqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=al3PABxv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757404887;
	bh=4UxeFMW9X07zobckfuhD8yCpJ07mc4o6RlRFftvs/mg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=al3PABxvx6VzQYkvXTpkYbj8oloeiWbc0xXNzEF9qgBClQY81V2zJ2EjMI5Bu7/kW
	 XZSL9e+1i49fI5xfZJHE8e6rxSrQcaD3/HjZJFtxrWc2nVtpmuWuzBC1MOu7lTwqMM
	 6819Mq8RBEmsYmOCezPhaNjB/JdeDkM/Y9uRDrpvQiFhLoUPHhYGwWmYRVUu8TtH/9
	 SdlZLN6DLc4wM+nz3F12zAK/IN3/u5H04IJ2HQKo9yNDt6zRq4YzGT46jv055GE5LB
	 s2rpjALLuM6L3uHbWDvNpWvqvjd+PGAUTbtqdKaZ+sszpcfrZnprbYQR4Zk4zCxfoR
	 INFnFGPFpJsTg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1680517E0C96;
	Tue,  9 Sep 2025 10:01:27 +0200 (CEST)
Message-ID: <26a2316f-d084-431f-a158-8eea66c335d6@collabora.com>
Date: Tue, 9 Sep 2025 10:01:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: mediatek: fix device leak on probe failure
To: Johan Hovold <johan@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jia-Wei Chang <jia-wei.chang@mediatek.com>,
 Rex-BC Chen <rex-bc.chen@mediatek.com>
References: <20250909073819.25295-1-johan@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250909073819.25295-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/09/25 09:38, Johan Hovold ha scritto:
> Make sure to drop the reference to the cci device taken by
> of_find_device_by_node() on probe failure (e.g. probe deferral).
> 
> Fixes: 0daa47325bae ("cpufreq: mediatek: Link CCI device to CPU")
> Cc: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Cc: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



