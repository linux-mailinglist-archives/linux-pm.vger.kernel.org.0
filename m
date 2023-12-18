Return-Path: <linux-pm+bounces-1334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64F3817C7D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 22:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A87B20EE2
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 21:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1ED7346D;
	Mon, 18 Dec 2023 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNgjT2Dj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FCD5BFB0
	for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33670b90013so87331f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 13:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702934105; x=1703538905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fv24oW/gwKlTm4nSPBKnWVRVDoSmeowuplphlT2qguQ=;
        b=bNgjT2DjfvXkFQiebZ8L0UVDcZsibmL4HBaIN4UAAjbZINo6zfuUhuhwGK7xGe8WOy
         bZR3fSYafNibbwIC9VVAN3kjKEGEA+Bjy9Dk9bsDnOcpGg5C0i8+YAWNbo2DmwzR/o50
         dvxt/Az19/leg0NADR++zupjEtOMjrbHQOhEygNiMX90jCpTug01GSbHcCfkzSF/zlEb
         Ud+d77ByVRZJNOGpExG5Hf9GuD3o9uRlUTKr0z8wVcndjXQkTVCFjuGJKoUulfYwz5A9
         XAEYUvx3h7eHB4MhOvYXjSBG70MJv068CJBJn0kNjQr160bTydbfk5cqP2qO74kSc++p
         qxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702934105; x=1703538905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fv24oW/gwKlTm4nSPBKnWVRVDoSmeowuplphlT2qguQ=;
        b=xMcI9AjECF4AP+xcYAb1i6DUo4RpTjqdA9N9vPtepSfjnlOuOF+Ij3NOPosgEKZiUi
         rXiERQRdJIaMgASEp7IVj5m33Hl7e5wgInwTW9AOjJUNvnwGKQTZ+i4tbkY3qpUceJv+
         eMga+/jcoDSrFhKVOlDIRv+gZX4thdkDzZ9ymvXCOYfVRo60WPAuAgDqXH9t3ztTn5pn
         h2qleRwuBydbeJELQvmv9v7khlpSNWVELCXBXB01t+4wWMULOQDBFQu/yRHSp+4vXdia
         0jPN5bkeuKcq5MewtrvW8B4YbxBCsMxN67NsU2y+CocqwxuF0IDIwaV3HiD456DYJz/m
         ItkA==
X-Gm-Message-State: AOJu0YwW+egFWY3pNgPAH96VPCuoBHnZ58HYxGzdTIriX0bi5vKifZeR
	JJfXtzie7VVOaufoDSxNhmUWqVyFUy0T1Q==
X-Google-Smtp-Source: AGHT+IEvghUjytmbhBXnljV4EQLrT+EIoJ9XKEPZ+BLCvC/NkGpKwEVOHmRvZ/bsGYj24OiPmM0gzA==
X-Received: by 2002:adf:e40c:0:b0:336:6f8a:264a with SMTP id g12-20020adfe40c000000b003366f8a264amr2471wrm.26.1702934104812;
        Mon, 18 Dec 2023 13:15:04 -0800 (PST)
Received: from [192.168.165.171] ([37.170.230.132])
        by smtp.googlemail.com with ESMTPSA id h6-20020a5d6886000000b00336430ad57csm14648636wru.106.2023.12.18.13.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 13:15:04 -0800 (PST)
Message-ID: <3bebfe0f-1eb6-4d28-8bd8-2cc30d84a6e7@linaro.org>
Date: Mon, 18 Dec 2023 22:15:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] thermal: amlogic: Two cleanups
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-amlogic@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>,
 kernel@pengutronix.de, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org
References: <20231116112633.668826-1-u.kleine-koenig@pengutronix.de>
 <7r2dj6eggv5lb4j7twcooykvahwnyhqay3evqjclu33z47dm7c@guvng32lhvtj>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <7r2dj6eggv5lb4j7twcooykvahwnyhqay3evqjclu33z47dm7c@guvng32lhvtj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/12/2023 21:48, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Nov 16, 2023 at 12:26:34PM +0100, Uwe Kleine-König wrote:
>> while rebasing my patch stack to v6.7-rc1 I spotted these two patch
>> opportunities for the amlogic thermal driver.
>>
>> Best regards
>> Uwe
>>
>> Uwe Kleine-König (2):
>>    thermal: amlogic: Make amlogic_thermal_disable() return void
>>    thermal: amlogic: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
> 
> gentle ping! Is there a chance these patches make it into v6.8-rc1?

Yes ;)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


