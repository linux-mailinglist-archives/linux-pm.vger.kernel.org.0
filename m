Return-Path: <linux-pm+bounces-16603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E709B36D8
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E2B1F228E6
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6001DF245;
	Mon, 28 Oct 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXJfc0l7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC311DEFD0
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133657; cv=none; b=YrEI+pQnrdVM489G/YxOxKknm/rIoTdhU6VhP14kRBmJF+wo182YPXzXsVS9187oikQHhZSX8WieH+uZATJTX00yEKDY0Poov/5hgvZ/kur11Q6IQX67NjjWYYr0hOYyueoeCWSQvsLLIpPp1Z7gIIb6iMDfV2b5CRng7NjFmPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133657; c=relaxed/simple;
	bh=FuzDX4w5ksbOtt62LrKHOv6t3WZNEVlMo5Jwg+lRz8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJe2x11WlEfQuYGKgrjbNcZjaEUZlf955MCrnxMV+bumvjxS9Wi6FNEODTq0QPwjLExiwZEN0gr2zvHPmZKXNnysZcqelB0n37KiGoYmFiKTr9vD+P2jUrnz559auycVtbm5udpvZJ4QEkGJgSb96IR2JXt0dI5RhgC4RRrbLUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GXJfc0l7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso46257765e9.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730133652; x=1730738452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7H7MOZKwUSVXW/SZzObgRj+x6rST0JwI+YL7Wp/UUE=;
        b=GXJfc0l7cQvGwu0u5KVA2QMyWdlIL/+5sPnDNkIEGzfJ0K/yBybzljcg+zBwCyKmeW
         3OZauka0LjvOXLAfL/IpbtsCUxEHUrTgduduxxRxCwPZ7cu9UPn27QrrY9enXjbPn9BZ
         3eNlGhLzNZ+HU4E/+Y5ZXI/MoxnBAWrqyfGVdVY8APtd5NKn5RTZe29W23/w8kzCJwvq
         FBDBQ/o+zf3vDwk8JeMX3Fcn2akpnfiZDyDgZdIMwFRSatWlvccB2vdlemROIGa9x6sA
         U0PkvWvHZiMf8YjIW7PWFPuNMhbeibGGIAiMXmGvfB+yrfvebHHtK2v616gruO8cETeA
         /GCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133652; x=1730738452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7H7MOZKwUSVXW/SZzObgRj+x6rST0JwI+YL7Wp/UUE=;
        b=U/HOGsdxEMCbsWzGvrFrPTdCIu20bucoCjqhNH6s+S0MlWvOqxu0DEJdPG8f+nI2M/
         G+cK8bOkllU5EBW8+1kT/h9fWbkscAECsLDCUH8hOHMJhDQKDR08UbX6DlOmD1SlX9i6
         eXswfIVvg0NSwu+D9SLVO5WghjUMVqnB5oDiLpd5Ukn+OtRbYllXef+upumYUJeEO3aM
         2jVSwuXVUJCpgvZFYIhsDIeNL9sDfOyZpLtNNHQDj6FSGDjAR87CWg39ZTGsIQY4/bee
         MwpShEZLfD40uFBO92710sQAaI8xR7GpujmQKn/4btwOs97PpLQp45zntPaBtGSXsFqB
         lcMw==
X-Forwarded-Encrypted: i=1; AJvYcCWK6OgB/Sgh0uxwb0VfszIABAwF1ZAdICOa6qu7fVRUotudOnNNU58hhNHtZOQ1CAmCXj7jdoEEKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw1aQptoqKoH7EvAFj1Ttz6Hb89xBRjFXG/Ow+c5KXIecKXC1X
	3yggzK1JnbE6hXepEBe3MjLXeIh9RVFyvnXbSvUGxbJ736feIg/vktdNrcNX0T9fpUhTMtJwEdq
	d
X-Google-Smtp-Source: AGHT+IHD7ecehSeRSersefttuZxWWc/yvJLPk3kslyGa7nuUur+ExAiKbF2BIlY7ADLI6KIVbs9TAw==
X-Received: by 2002:a05:600c:4fce:b0:431:54d9:da57 with SMTP id 5b1f17b1804b1-4319ad20fb6mr68256455e9.30.1730133651812;
        Mon, 28 Oct 2024 09:40:51 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4318b5433f2sm146420585e9.1.2024.10.28.09.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 09:40:50 -0700 (PDT)
Message-ID: <0f626477-7af1-4f8e-a770-39f69d9b6cbb@linaro.org>
Date: Mon, 28 Oct 2024 17:40:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] thermal/drivers/mediatek/lvts_thermal: make
 read-only arrays static const
To: Colin Ian King <colin.i.king@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Nicolas Pitre <npitre@baylibre.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20241022184622.1296044-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241022184622.1296044-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/10/2024 20:46, Colin Ian King wrote:
> Don't populate the read-only arrays on the stack at run time, instead
> make them static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

