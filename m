Return-Path: <linux-pm+bounces-35046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FE7B8A5BA
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 17:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70C3189A957
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10031C589;
	Fri, 19 Sep 2025 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPHAfUDd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DF631AF23
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296410; cv=none; b=cnqzOB/0REtxlN0utP9RZU1usAdk7Yo37LUyTKZSKUoOnfvu3wGb4y/O7aet6fJ+9M+84ljxwjNVU2V6zwozijDENis1hd3yXGRu0juUIcqo5FvA7Px0Y9B40FkE/GjmCpsyOmr8M6LZdZYBN4KWIrT4haIJJS9INBYz47FWvto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296410; c=relaxed/simple;
	bh=xlyfj68UTIz6kURnqgzznzyubwaDnjAFQK2Dyp3Ar98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9T6jyeVC7XKkCezHFWfknbyNpxbq9O3rifAksm7QWUy8TF0IhXg2LLjY9mv1+FsgHjGyO06foEuiZYVj7b2uxJ7GVz7TnfEKxzSJ3veJmK6epWELKOpPMCAWzcbs6DcPEISfyU8MxVfLC4/xOku9KVrFk4SEv5Zzr206y6HuEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zPHAfUDd; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57b35e176dbso46949e87.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 08:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758296406; x=1758901206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ny4YeOUQ6SJeOcdkVzBU+J+zALLv/bmY7hQjTyaoqpE=;
        b=zPHAfUDddoexEw3n4O0q61SKuroVrsmPpckv6MAXSeln4a4FYRNRVvd8bWJFGpWeeo
         uLqYJOYQrEwbIpk3cAyh0LqQJ6ZdEUHmgw6nyHsidNLLTBttL/YJarTGVosjmzlLF6rn
         TdwEowabHAbiJkifVqbQbgsRGC+7LnlMSGk8zd/9wmuEXeHWt+JJgh49dICNywuds9u2
         uyIMIm4PFR38DXWP3rg68DT4+a0dqQ4MyverEqMYkH/mEsT9KjkjXzFJMU9yAt3mGoHp
         bqnBV06kDW6Vy6pTX3UgN49ulpRhzMrZMMtQe8/j1g87iSMCycWxg0PR/HN1ghhm/H4u
         qYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296406; x=1758901206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ny4YeOUQ6SJeOcdkVzBU+J+zALLv/bmY7hQjTyaoqpE=;
        b=GghMIZWiPC+U8qHSBxSi00EO/ILIb9Hnzszg+T8HgIlKglhJc7NfxywwT16fI1Ivh5
         lv+Lo3eMYskTX6euguz6ZWWubygEBKqQFXJ4kSbQqJBjCvS0J8HCSu3nMV9i1paoDGH9
         EbT4PdJ94iD8+sq4F4QsQGOWGR05m1jD6An1+BTmMqVTAzQ40kqED91N52KkSPfysjFF
         IQncmLJA+Yh1Tkwppdi5A2NCpxGT7+gDhVqfoxtISWDVIzhZZlorUr8aOfTT4zyLmwSW
         mlmmiDar3aZqHPcb19dbrZh5qam+9hmTU3Nf9iojnlRx4lLb9XP1Zlm0vW1teofsToz3
         TEvw==
X-Gm-Message-State: AOJu0Yxo8Gp5RjPMRgsb89Fb4rNf1IsWfKDOT3TG/xmQIiddsx58HAsu
	mdK4T59La500ksz4s1gfqlRoyoDnEL13294n4+MAqdEPn+jQkFBvjgpGnM2FrEn6/Ro=
X-Gm-Gg: ASbGncsI64oH9e56FaDoalQmJUX3p4hyU+GWNJn4nn0p5h5X4B2u1hERLKdzRbxrUfG
	17rktmoO02emtgFGR5xW5MnG4x8YNSUtGThlcKC10X40GlnLT3Cf7wTqLhY9sra4TBtUluDZFk9
	+Z+MRg21xjKKu+vYHs728I7nGJ0ULgWjq+L2NqJE+yp9+RZRdsxGTndlNecvqIAaOeaHcO5wS8s
	zaTwfjXD5KFOFH3CdG/pcEESk9IyElUXp8vU6xesvXIA95gx66Gd8pAqXI7PoFUFrS5s6j9WO1Q
	nBAz5bu6SCxqlBzxAzJm5nPjxvAkEf31FwEWONv5aEmIcDsWyPy6Zz4jUm7mgWUatLK1nfgpwFL
	/LigbE1o5iEgZKpXcJLMZsBqQ32qameEpBzzdg5UhYLjIzbeG7uMJl6wZX2dyavInJC24BnmUP0
	SSKA==
X-Google-Smtp-Source: AGHT+IGqJck6LcstS4NmmCegoanyc2XQaxhlYv4R/aMb3C7/Q4mLfE5SNfvUL59aj72O8yd3QXIqkg==
X-Received: by 2002:a05:6512:2356:b0:571:eaf:aa64 with SMTP id 2adb3069b0e04-579e05c65ffmr1339653e87.20.1758296404201;
        Fri, 19 Sep 2025 08:40:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8ffd:205a:6719:49c1? ([2a05:6e02:1041:c10:8ffd:205a:6719:49c1])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-578a68e87fesm1480557e87.60.2025.09.19.08.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 08:40:02 -0700 (PDT)
Message-ID: <8ca1cd7e-e7c2-4a25-9b5f-d04c94d7915a@linaro.org>
Date: Fri, 19 Sep 2025 17:40:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: k3_j72xx_bandgap: register sensors with hwmon
To: Michael Walle <mwalle@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250828124042.1680853-1-mwalle@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250828124042.1680853-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/08/2025 14:40, Michael Walle wrote:
> Make the sensors available in the hwmon subsystem (if
> CONFIG_THERMAL_HWMON is enabled).
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

