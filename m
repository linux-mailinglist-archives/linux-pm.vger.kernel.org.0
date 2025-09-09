Return-Path: <linux-pm+bounces-34217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1117B4A525
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 10:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CD81897A8C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BD423AB90;
	Tue,  9 Sep 2025 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MaYx0+cm"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CE7227563;
	Tue,  9 Sep 2025 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406103; cv=none; b=l6P02G2RxQ7Bi+Si+QCQeH+pX/Da8ix1qerLpzMkMGr0ljdcJVhIJFklPAbdo6TyTlurxeOc90n2EB6zgWS30S+Q1xllaFuzILKy2aXBMyhK4uEUaPJ6+15AkLTUCTs8oGzZv9te/Lds/4gC8Zua7yYndWMxNomdO2zHuWseYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406103; c=relaxed/simple;
	bh=7AQEL1juqiawy45ZAxf91ih8HpQwBQAic9ZRFlIoxl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbP5+nlwwuJ3dj/H5QwFbbZrGqEhbFtwh6PHf/0kMSo2Tpve+sJtqA52etDfYlcFpKRNzZGKvqw6sCUbRdFUUsgq2U2Xn2iBBnEetTmDYSTvCaDlbjktaFB8KCK3rgO2MTwux7Jf9KFdqKKs8DMflYMfqa77o6k3J/a7pHgD97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MaYx0+cm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757406099;
	bh=7AQEL1juqiawy45ZAxf91ih8HpQwBQAic9ZRFlIoxl4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MaYx0+cmECTn5E5dKoUWkeKcNUYqqPiKDQfu24dcvZsPCZ1UcssOmUmT/QAZ1YRwV
	 jrzScuI8kkfbjieeJzOQGslqETCfZyZCvSQ1caBYYpFnMoi8hmdG9s9FUorXSaUa5v
	 Iun5swZ4xNJyyeXHjL65RwnF3ShNEKZmhgvmMlI7jd3iCKOcxGrAvHObgvbSm7+7OL
	 2VuDMIURF0/2Sq9YPgJAs6G/QVZkJiAiHZY3l1hFifMpjrs51FjrA1Lk1HDvXnKkih
	 7HhGsL40vhR7F+zlAfOyDBhh5iStpF4XLhSbeBXvx1IyUwjnAzuv7eX3JfO02GyI1g
	 1oUERFUeyXsvQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 53A7117E0100;
	Tue,  9 Sep 2025 10:21:39 +0200 (CEST)
Message-ID: <32d498e7-0774-48d5-80c4-35ede039692e@collabora.com>
Date: Tue, 9 Sep 2025 10:21:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: Use devm_mutex_init()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <2280ca741ef36fe9ed26b8079b91a8e5dfd669fc.1757360105.git.christophe.jaillet@wanadoo.fr>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <2280ca741ef36fe9ed26b8079b91a8e5dfd669fc.1757360105.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/09/25 21:35, Christophe JAILLET ha scritto:
> Use devm_mutex_init() instead of hand-writing it.
> 
> This saves some LoC, improves readability and saves some space in the
> generated .o file.
> 
> As an example:
> Before:
> ======
>     text	   data	    bss	    dec	    hex	filename
>    35803	   9352	    384	  45539	   b1e3	drivers/power/supply/rt9467-charger.o
> 
> After:
> =====
>     text	   data	    bss	    dec	    hex	filename
>    34792	   9008	    384	  44184	   ac98	drivers/power/supply/rt9467-charger.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



