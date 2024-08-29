Return-Path: <linux-pm+bounces-13181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05334964A49
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 17:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44711F24149
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 15:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728691B1418;
	Thu, 29 Aug 2024 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM2WsyeF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37C71B0126;
	Thu, 29 Aug 2024 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946015; cv=none; b=a+1SK7PKvwm0Ez5EeaZtslRlhq16iEStIYQi0mkqEHFEWX+mpmcJB1jWCf57+9/TY9U/0qHN6BEPHc1veH5AMwWr9KptFfoQNP98l5e0HDD1Nzf+I8WtKgcPP2c5C8SC+y6PP+FY4XLd5dnvOoV6HBMYxMvIngaPIpSLxh2XOfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946015; c=relaxed/simple;
	bh=mH2rEXcYLokvtjpXqlc/MQUGfhQnvTOEGEj2uujm/pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfyLn8CcgC/0qgZfCSw+dDNNYkpfoTnfxrKPNdXakNm88x9QWqW9Cm4Gyvhc1biG2BhWhnp0wIvJ8UNrW9XXynIe9bviF5jZnm1zRuadBpS1lK7WSDVaErg8NXBPRRSsASJg6aunBXDP4hJypq/rcuuqxpr7q+J2DemPGZm+7d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM2WsyeF; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5334c4d6829so1008456e87.2;
        Thu, 29 Aug 2024 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724946012; x=1725550812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EsA+QeBqlMd+ZMZVRwX7jVSf7mJKK5fJqXnWQ1MmfMo=;
        b=UM2WsyeFTaXEKgqpYn4PAoaGb25PthN4GLfB83SCJfuBNjxjZLrBo0feaHxFrtrJfi
         P6PNqJTb4leUVMw372O3i69ujy1U8G4UQptEe/8vXAvQMECdDhG1PkA9Pz8fNqlHdwjG
         nace7FpzXiFD1FAxmQUftL8KTttlFRk5ybromFVKo8mWPTNA1aOENS7khckqoZlvsUH/
         WQJqI1SdeEn8Te/vMRF7xbhEWZd/JpOYhQ3RlQrghE8bixI+wFui0Kj8q5sW59mbDreg
         x/+239jTMgl1ZIPB8M4giEws8v7ePOwkF6HRsB+DzkkUw7NPDVDZiFvTfjMVAOgkWlPj
         ipMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724946012; x=1725550812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EsA+QeBqlMd+ZMZVRwX7jVSf7mJKK5fJqXnWQ1MmfMo=;
        b=X4QbpJPK/9qDyjy3icafsnxhWUrldw9DtkxufFimqaQOYVmTaxHGlrctdQ6mRgbWDI
         MLvCeR9hgn5g3c6y5Z0Mb3GQs3CnmihJl+k4h7HfDNdHd2n2P8VhnbJ3pwVLI+BMjKZk
         NkIX3yd/ZcoEbLW7/dBYChKmsWoIrw5otvoNJlkTKEDwZTPQdz5GFolGCdog2JQ8b02P
         3igOULA85Zn9GxylMCb0Y+2zWzHSIlLwW8+83mGK00DuD3AeyvaJyDURwkeqB3XOmd5u
         XnddpzSx+x+Ne6yDbppZ7Q3jnuU8QnIMX8xOKz3bU45f+FR4oppBEQcKLIqLshA2F9yp
         hjWg==
X-Forwarded-Encrypted: i=1; AJvYcCUK3GHH50AxAcS+6Q2viwhhQOSwwVJC92aGiC1sa1sqgNYRqlGAgEvs9UikYKVcKPd4mA/yCzbuVw==@vger.kernel.org, AJvYcCWua3ycBBI7+SkG6nOjNfJXM6YhisD+mA3ag1RyfuZNWk+H3MZVQKB+bUI0cXdAKD/bju2Mc0LHCtbHb5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM6NeEQSD/MhTyU6hnerC/D/VqsZwVr7QaoPwOtfEtyK33XM1o
	sssJXuT/mrOCGrVt1n9wOfx6n8Qc9OjqipG0o9sC9Mmz9otHpozU
X-Google-Smtp-Source: AGHT+IEz1wYfl89c3pelxlDjUkASXHrsq6MXqhkZIECNRF4tGrNzn1Th0GrBTN6NvPNh/Y6r9QTc2A==
X-Received: by 2002:a05:6512:68c:b0:533:901:e441 with SMTP id 2adb3069b0e04-5353e540b79mr2264022e87.10.1724946010856;
        Thu, 29 Aug 2024 08:40:10 -0700 (PDT)
Received: from [192.168.2.146] (109-252-153-126.dynamic.spd-mgts.ru. [109.252.153.126])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-535407ab8adsm182721e87.63.2024.08.29.08.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 08:40:10 -0700 (PDT)
Message-ID: <408f07f6-00e4-4646-be9b-ea2402a62c82@gmail.com>
Date: Thu, 29 Aug 2024 18:40:09 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] PM / devfreq: tegra30: Add missing
 clk_disable_unprepare in devm_tegra_devfreq_init_hw
To: Thierry Reding <thierry.reding@gmail.com>,
 Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 cw00.choi@samsung.com, jonathanh@nvidia.com, linux-pm@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20240803063748.325133-1-cuigaosheng1@huawei.com>
 <5vuj7r3wxiqa2nr46tdafe3zf4ru56ja2dz742lt6yfmv7ft5d@26rhlgfleqsx>
Content-Language: en-US
From: Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <5vuj7r3wxiqa2nr46tdafe3zf4ru56ja2dz742lt6yfmv7ft5d@26rhlgfleqsx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

29.08.2024 17:54, Thierry Reding пишет:
> On Sat, Aug 03, 2024 at 02:37:48PM GMT, Gaosheng Cui wrote:
>> Add the missing clk_disable_unprepare() before return in
>> devm_tegra_devfreq_init_hw().
>>
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Acked-by: Thierry Reding <treding@nvidia.com>

devm_tegra_devfreq_deinit_hw() is invoked when
devm_add_action_or_reset() fails, disabling the clock. There is no
missing clk_disable_unprepare(). Patch is wrong :)


