Return-Path: <linux-pm+bounces-13342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C6496861B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 13:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF7BB276ED
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 11:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3242D184532;
	Mon,  2 Sep 2024 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBHNaLk6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1F1181BA8
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275700; cv=none; b=NRq1qGx/tmrRqsSZELHbwDtjFVWmVmyTCQ5BR3z2klFanjJjSL8cYK4Mi9+w78c9LAQurMNcOWmoz525jQ8JGo1pXgc90mNMElu3u0OldNt1nNHtHA7k/VG0LjN7QRgJgkYflik5qdhKcllWNXV0B62GmIFpIbOkuKZZhskLuuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275700; c=relaxed/simple;
	bh=BwB7EJqrguz3OW/W0gMuXAL7awu3Vv5nG3F/7m+Lho8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0rdXgKZXDwthUdsaO42ES3RumvqZZyBHgga0YttNn7a7gBacCRI2Np3S3ULUsGuvIzRB32DoyFheynELdhVhXqyjIw4GRypfSIXx8P7UeVhC1BqSkYBbyohUrkT7LcR6eKNAIL2zsiHn0NsU9sjknYaPoIzp/vw+F/Hl+6bc4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NBHNaLk6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-371941bbfb0so2628472f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 04:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725275697; x=1725880497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dL64J3/4J/U2Is2oHltSDzO0dbgcPsVdgpAb39i+MU=;
        b=NBHNaLk66LCXScRPlkCmORo/RHleKLywFwT+vZLcyimgEwrQzxNI1ku0dWEmogejaz
         ixaEE8cjefU8umAaMKG0gt915101Jlqc4cm9mjX1LrFe7askzXvjVsOh8eTiWVEkCmWW
         puzBG5mNXByJR7m1WidKvEVtYl13Vb1ugU5PHJ4lyhsGll+RD1YVds1zKPfNDuwvoqMg
         ofiYAI87XlDRrQ7M1tuCsdj3C/sO1xmWuwrTI8esqs56KOimS8FgUuhmYbD0UEOcf9HR
         i3od7KMQl6t8TYNn2H2mOLZS9q/EIQXItDDDD2DPXsTMSCyFMtr4CwmF9Nr9rBPKDo/o
         e99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275697; x=1725880497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dL64J3/4J/U2Is2oHltSDzO0dbgcPsVdgpAb39i+MU=;
        b=SniMjNx4RdV7ZRPnXVEYzd0FVwoATTu0LTVUz6ag3uThpeSOWwenW48sVX96cTLmQT
         EZhjcLNd7SAH8d+x/NAEP8GFPsxzy0Z6MQ1TCEv2VzJ3y5rPfKbmCpk9tEY+iUcfPjZg
         DGLXR096fHIJuIaBNFwJbglfkLonIaGe9natq91QCcMDKHIHlZFasRTrqJOpzhSpbXOe
         YhCRv3oUGXBzj/uoHMb7qhgMQIUExMOa9MJyBTkJoM25JQen3M3P0Vlny7o9F1PRqxP3
         ni3hW88GGtRd0O7OEdTtQNy4bv8nCds/hCm3Xp0clhL5bACxHIzAbZzaNbwrG+fVDnS3
         95tg==
X-Forwarded-Encrypted: i=1; AJvYcCWZdsHmAYP0iWB5O1Nq8SNasRcTE1Vyd4gNYLPD+xRRIJrvS50xASbmQy4mzYJnOjVrrfRbh4wKXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw/IE0Tb26tdkulsCPdeNlZbxPdrUPYXJ+2Tf959ogeaO/Zp8T
	/qNGMXPeiwbxULPgZoeaSRRuilRJ4zMDD1Cnr9xQK24CYJi8+7/XwoigcDgOYy0=
X-Google-Smtp-Source: AGHT+IEOw/rLbV89LRpF/tcrYR5VbN5Zxq/Z90HtFp7vG8AmUo+4reN5RoDLT34Y5rJ7B0KP4P7TNQ==
X-Received: by 2002:a05:6000:402a:b0:368:584f:9e08 with SMTP id ffacd0b85a97d-3749b5497edmr13173204f8f.22.1725275696292;
        Mon, 02 Sep 2024 04:14:56 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-374c90c6c06sm3388725f8f.84.2024.09.02.04.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 04:14:55 -0700 (PDT)
Message-ID: <c63ac4eb-14eb-40de-84f8-09768d6293b3@linaro.org>
Date: Mon, 2 Sep 2024 13:14:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: sprd: Use devm_clk_get_enabled() helpers
To: Huan Yang <link@vivo.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240820094450.101976-1-link@vivo.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240820094450.101976-1-link@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/08/2024 11:44, Huan Yang wrote:
> The devm_clk_get_enabled() helpers:
>      - call devm_clk_get()
>      - call clk_prepare_enable() and register what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the calls to clk_disable_unprepare().
> 
> Signed-off-by: Huan Yang <link@vivo.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

