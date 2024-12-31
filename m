Return-Path: <linux-pm+bounces-19870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1B59FEF04
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 12:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2743A28BD
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 11:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C431993BD;
	Tue, 31 Dec 2024 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s5tqCrWt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9069A190678
	for <linux-pm@vger.kernel.org>; Tue, 31 Dec 2024 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735643386; cv=none; b=gMzPzLABJZq18bE2CxoQXhAxNED0vq0Bdbz19TaNXptmzEYsgjrjfspvLw+SeF4vp345kcidv93Y9H77nzdAWcmBCz9C5hgUAJPjbLxJQZK0U/RWqxai14f8+MHOCwYynm8pKpiMuriNeMhWV0NkG+Eke1vt4lzm5L7ZZHyGKZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735643386; c=relaxed/simple;
	bh=CZQrp3ljcPGAGgTKtH6TnT0akhIhaKad5XpyBTsLY9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOCGaSl7mzwpaUFkhwg55xEGGe7wMWh9GA2EqV/t+oZFMt5FRZd1cYWprgm0RLTww/fWKAUBbFU/MBhPJdrT8PdREy4GySUWXdohoKSxnC+QzXXqHyMSgDusZ/5RkeSXZqqBJmVaI1P4ynUL/9IMTQwKcGLon1jOVVf1l41Mcu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s5tqCrWt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso7715617f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Dec 2024 03:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735643383; x=1736248183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mh8UYWaZc8WrVxKRwykbsoh7O86a7wx9Ng47k23FtHw=;
        b=s5tqCrWtKraouzU9+pCS0X4ejOyWYzCvtoiYHShK8elgI41wEu895sywAI5xnJS1Ma
         +osiZ16wodiyTf8eR67X2dAJjFWQNWtK9v7EaqeARwjBqXP4sBixd09XlF9UCTY+jKyq
         obL/z3PCD7/3dbjzsDHQx2Pj+KGYgISlZ/5XgSb1cdzNIccDyud4zVyIyJ6/q/9Zfrpu
         y8rtuNoTRYGbZdJWmtf6Bj/WVeJe6yJr5JamZGwW25t/qQNSM76BjobqMkG5rj6P3vf/
         xUt7pIgHwoc0hZTrCYM2eDVq/XTWZTv3NGhG7AiNjsw8Sl3aTl2GhK6q4R0AKAfmexfp
         yD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735643383; x=1736248183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mh8UYWaZc8WrVxKRwykbsoh7O86a7wx9Ng47k23FtHw=;
        b=KOHQ8ApD3Zn9XiQHTYYH+Z/NFRyjD8UKNcD78vfvYg/YW7qvE8LnLVK64bb4R5hCMn
         da73X2Z9EBW/iLUmUbqKWGJ/IWFKTTO7GIUmfxvECyKCP6QICrSOtmoO+E1+k8HIMjm7
         WNec2/7G63J0lQIfdghkIFmHuvTdhfaTzXZbi4omQUpkyx2zfOrpM2ViN+k7/kG0pZTJ
         eIHINuSSTixwObmVryyhebQTxwz1xHTvMI5fs/IW1uEB2K/x+90E5nDOyB3noS6XBZhC
         99b0emCtp0vecoLZBPBeQB2Am61AjfgbcwEd47yxLwLAjJ4a4omUswzwE40vdubaUpW5
         sIXg==
X-Forwarded-Encrypted: i=1; AJvYcCXyMwh8HBxu7zTJz+y5gqYe19J7Bn8nOzKsgDJ2OG1RveQe5DP1pX7dXvCwyrdLi8YWqM+HEKcuEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR3Ui5QTfdKHSYZR7sg6SLQGUCtT1Y/KOBqYKYhIsGE5Jp3gpg
	ZaF29WL2T+AVBhiYIGYZxMVelmfDL9p04ZYyqjfdXGwR7+IB3BDxe6p1O+1x/dI=
X-Gm-Gg: ASbGncuUkprYswqqVeiXxccVu7dqvMjzVCMLZfn2Ft6G46uMONUA39eyhN68aCblzMC
	4VnTuaGi2ZNAWOxnxXG66FyoPYhihylHQOVgDEk9CkTt5tD43gHA2HP47MZQ9i/fEugCmbNK4Au
	qiNkgbJzYx1NBajFSnQTXOHNEWgKcpRzaLHC/w468SdFXeHcgyrosbVx9OxAuD0/0UiS2ixKM7S
	iBiRs+gDoY+DEIuBcp8UKYzDlKc+Q1onGw2reaMQ1rCxIKlPuMi+W5Wiw/kErzrXPxKBg==
X-Google-Smtp-Source: AGHT+IFaNhrfsnfvBxSp1tViYSz7o2qMK2dzhldDNDYiuudm1kNGgf7qZsGXiU9LTOK5Js6Pse/c7w==
X-Received: by 2002:a05:6000:1568:b0:385:dc45:ea22 with SMTP id ffacd0b85a97d-38a223f835dmr31212643f8f.39.1735643382887;
        Tue, 31 Dec 2024 03:09:42 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c829120sm33379893f8f.6.2024.12.31.03.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2024 03:09:42 -0800 (PST)
Message-ID: <583ec206-e670-4aa0-9490-4ee6397800e5@linaro.org>
Date: Tue, 31 Dec 2024 11:09:40 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] platform: arm64: add Huawei Matebook E Go (sc8280xp)
 EC driver
To: Pengyu Luo <mitltlatltl@gmail.com>, quic_aiquny@quicinc.com
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dmitry.baryshkov@linaro.org, gregkh@linuxfoundation.org,
 hdegoede@redhat.com, heikki.krogerus@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, konradybcio@kernel.org, krzk+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, nikita@trvn.ru,
 platform-driver-x86@vger.kernel.org, robh@kernel.org, sre@kernel.org
References: <1dff7a78-1693-45d7-8ee3-357b33848595@quicinc.com>
 <20241231074437.239979-1-mitltlatltl@gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241231074437.239979-1-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/12/2024 07:44, Pengyu Luo wrote:
> Please search
> 'device name + acpi table' on the internet, someone dumped it and uploaded
> it, in SSDT, check ECCD. I am not sure if huawei allows users to dump it.
> So I don't provide it here.

There's a repository of ACPI dumps here:

https://github.com/aarch64-laptops/build/tree/master/misc

including the Huawei Matebook E - not sure if that should include the 
"Matebook E Go"

https://github.com/aarch64-laptops/build/tree/master/misc/huawei-matebooke-2019

You could provide it there.

---
bod

