Return-Path: <linux-pm+bounces-6939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86C48AF2EC
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 17:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA68C1C2300E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 15:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCFE13C9DD;
	Tue, 23 Apr 2024 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pcM7NGPg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8041313C9C5
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887678; cv=none; b=mOujxNnIYTJkeuI+5sn3y3Et9uYNNCvlWBJiyiXgcb9ogEyEoCNTu9B7Z2N4zSVNF94uKjDa5AwpKq1F+biaM9R3TWMOPN8yD89abN5UcTIsZ/lff0HtPrr0s59rHLojE+0IsrdxGYjV4kIrdUEh5CGPVRFlsd3STtzO8fOm8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887678; c=relaxed/simple;
	bh=zOrR4N6W5yEjumIJlaR4j9bXUXeISdNMznsMzpCn11U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZteC2e5kigcEh+/TpZc6hdEUHRXrtAnKikQGdT+T0xwYZu5w7vcw/Vwdc8ZCZMRBwdHzdYPBftrLynbBmHLvDDyZ6PHhN2yMUzkOelbRx+x81SEc6iGpGrKRPd2wivCFieQedoKujHGF9YAcAf32XZacQtZh3sqkKqa6rmAr1Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pcM7NGPg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a4f291f60so18640185e9.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 08:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713887675; x=1714492475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CEYkFgPQbfSpwnnDo2x7Wyyhx+vsMBr1IYLJirdNPw=;
        b=pcM7NGPgl6t3heodR31q4C67+0MXaF0krE/sfT/wnzAj20Dr5tcdWLlvJMkDdiWVLM
         8PbxuXYUxaBMQCePfN7u+KFuy9MDtEXSQQ4rtrqzbmb7K4P1oN44alh/Ez/vEbFz9DwN
         B5g3fL4gpcMZv28MMtq27hYQnrwn0VyvOsdiGCDsrmEvhmlxE2a5lxiZtiYDPoVTYYv8
         yh+g+NnfM/TEM52XAeU2F7amgdxRmqfE4MDCu6zHqcJUtP2tGQAVa128+BGGhuLUj62o
         McmhZwcz4NQ09eoNSX7jW+A8NOePdPJbCop8VFbgFFXYZYE25MOXsCVZK3nIEe5kICY3
         Ys0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713887675; x=1714492475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CEYkFgPQbfSpwnnDo2x7Wyyhx+vsMBr1IYLJirdNPw=;
        b=w83Mm1Ajsy6SDKWoO8n5vTfySPplr3owv1v87y5UrwimuvCEkCg9IddKVInhzcPXbu
         gZYeznjUsDmZusw3TX/1BlKEDpxJoaYCRFoUyg0JAJvIOZriPQufho33iJT40Fd/7FUI
         6dRpKvNek4OHzjChdMCyRwKoDwDZu+TKzVvf8aaJ1IK7eFwKMomxZcbQIQ+gU4nwkXIT
         0KqfaWd6lGwas9R+yJ1eU/bFd0TWXO4IOotU8M1kX230Z8cEYpVzgCCZCMuPBkgkx4gY
         6DAlyIeDyM2kJQod4FPLLK480z+a5h/gasY8qhn4QUiQam/9oEeCN0XN1bCffnUo0jyN
         ckEg==
X-Forwarded-Encrypted: i=1; AJvYcCWvX4yQReG75mXMPoY5H8fKZev2xO4KmsN2s5GezboH4XF5YAMV+XPVlVT4HmUgEL6WfK+OFyAYTLeI75ROeWdFcmzHE+4OeNc=
X-Gm-Message-State: AOJu0YxxoZYZYaLFo17JzT9RUMBPb/YaDuZOc+uy/Zmv+2sl/wJprUmX
	e+NuVKMsL1QpbCRMUnJCG8k5AeInFa1/8aV1khI02zj956NFyOn0k7PXB/22bs0=
X-Google-Smtp-Source: AGHT+IE0M1tVNbSGH6P4H6A7BokfgioaPGrg79dTjBg1s3qdqWoF9FuBSbISRUuyZlebNkOM8fxysw==
X-Received: by 2002:a05:6000:e81:b0:346:c0f6:8b6 with SMTP id dz1-20020a0560000e8100b00346c0f608b6mr9421964wrb.32.1713887674930;
        Tue, 23 Apr 2024 08:54:34 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id y5-20020adfe6c5000000b003436cb45f7esm14854289wrm.90.2024.04.23.08.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:54:33 -0700 (PDT)
Message-ID: <d1bf86bc-b561-47c6-999d-fb5e3c99663e@linaro.org>
Date: Tue, 23 Apr 2024 17:54:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] thermal: loongson2: Add Loongson-2K0500 and
 Loongson-2K2000 thermal support
Content-Language: en-US
To: Binbin Zhou <zhoubinbin@loongson.cn>, Binbin Zhou
 <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Amit Kucheria <amitk@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongson-kernel@lists.loongnix.cn,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 Yinbo Zhu <zhuyinbo@loongson.cn>, WANG Xuerui <git@xen0n.name>,
 loongarch@lists.linux.dev
References: <cover.1713837379.git.zhoubinbin@loongson.cn>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <cover.1713837379.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/04/2024 03:58, Binbin Zhou wrote:
> Hi all:
> 
> This patchset introduce the Loongson-2K0500 and Loongson-2K2000
> temperature sensors.
> 
> The temperature sensors of Loongson-2K series CPUs are similar, except
> that the temperature reading method of the Loongson-2K2000 is
> different.
> 
> Specifically, the temperature output register of the Loongson-2K2000 is
> defined in the chip configuration domain. We need to define it in dts
> and calculate it using different calculation methods.
> 
> Thanks.
> 
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


