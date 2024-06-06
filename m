Return-Path: <linux-pm+bounces-8727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5614F8FF112
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 17:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F0A1F276B7
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C083197552;
	Thu,  6 Jun 2024 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5Ct1XvM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB0719752E
	for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688790; cv=none; b=JVtyCHuZ6V4Ub3o5VNdV112rcm2E1q4C1Zh5N24sQefJEMlqVPJY/kvTWnSKOjrxinPVOhnUPMP7PXcoHjGI2KgqfES0aZgLyhOgOX8PMYqJLeT4x032jAE23eUQIjKNzZxK7MizeO1K4lRscoHj0Dw8u3DWm5YEtZz6ORmyIqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688790; c=relaxed/simple;
	bh=1iRA7zO8aKW7XL2XJgg+W5/y8qAK8Pw9ucLgJU3LjAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMh8dh/3vuGNjMDyACBryd/oNcIERC9xWIkkFVEE9hPwD6kDcNdt/HbagyLBrq128soqZwPZrkbNsQx5DrpOLtao9ayqhJzzx1eIkrjTyBFAFXZv4DSjSQET+Z4If5JYN+UutH4wV9tpOvUmL+VFbzwYm5Jmk2vhuZ4G4Jbtj08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v5Ct1XvM; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so22212971fa.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Jun 2024 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717688787; x=1718293587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jZaZJv5zlvCixCJOj9oO9rxv5ZgEpgWsT6U+ox/0gg=;
        b=v5Ct1XvMTXDuhBMQGBK9XFcLDVgVQYjLNpXmYIzsamIWgIaAtaZ248t5ebZ009ho5i
         5pbx/FuZprwH7mcIQt+4nAL+yq14aetBqkJng6h7bcSSGoq6kExVpyvoEVlxd3PtEArO
         4L1BZRWUhZEA28On4SoQ4EV8BEVcpD4KBG4cHRQhLR0h8sCTZIkK8RYQ2QFpjASxaQwP
         ccZ4jlCo8hnOaxO8ESTafczECW6qlanHHYrOSsZr9EYt6s3OeAf3YVve1fQbjLdzKYu7
         qMHbQSyENBSc/yHyG+Ue0wIRjC0TSDQb7btOZc6qJTzCZhTuKhO/Di3hhhFXd1cFcFcZ
         Yggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688787; x=1718293587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jZaZJv5zlvCixCJOj9oO9rxv5ZgEpgWsT6U+ox/0gg=;
        b=hW0F615kOAKPnmnDb2bH3Vcle7rqAU3U5jcHjJj2wAOfcwMmQ5sTCh+vUafMI0SgJ1
         dj39/oTq6HVfEoxLX1QqNDm6r4j2t9qJ2hyFK8xeat8zV+y3EVhoVXPCBPTUeV/yP+MD
         ckKDI86Zjpgxlc2kmuT8+blrVvcPE14ADC4UpKMEeklHB6oLr6mH0f3uFngs8tgrg8Su
         McETp2l9t508ENh2740QFtfe73dBRUVfk9v/VhBRv9JTrCF1GDFwWw7VchhHcqPhDSmu
         rKYyUmO6iNFqTrV8sM7Yz3D/b9irTc3bf4TvazQmsYjNXJ6wGkPq9LbVeZx2B1YnDrkL
         Bp5A==
X-Forwarded-Encrypted: i=1; AJvYcCU5+G6LS5lf3PDalgjz5j2cm1mhjY/HIWVJokiMq8seUDfxdKkCQ+t9eM8/fShqFtBkZFHRaYc9tupYbkX15GelXor5KEy5D9E=
X-Gm-Message-State: AOJu0YzeD8LReupHrGsHHU1N/EMx6DvUbEuzuc67rkw4UTa9B1VMvywt
	GR6YTCtqeU5V+FzAX7HcHw5ZOiCYjJRPCj5Sd0fyUr/zY19tARErwKRe5PDeRvM=
X-Google-Smtp-Source: AGHT+IF3Olj2yADWsiyPudNQTNLEdRBwLQ++SjfMUpeeG8B4vbwLAJXJod0AwM3jfQjB1/evd0dAEA==
X-Received: by 2002:a2e:bc1f:0:b0:2e0:5d7:a3a6 with SMTP id 38308e7fff4ca-2eadce281bbmr969981fa.9.1717688786585;
        Thu, 06 Jun 2024 08:46:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:f9a9:3740:b905:9995? ([2a05:6e02:1041:c10:f9a9:3740:b905:9995])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-421581020d2sm59821695e9.11.2024.06.06.08.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 08:46:26 -0700 (PDT)
Message-ID: <3ab5357f-9577-4985-b09e-b686e66b7b5e@linaro.org>
Date: Thu, 6 Jun 2024 17:46:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: core: Do not fail cdev registration because
 of invalid initial state
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, Linux ACPI
 <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Laura Nao <laura.nao@collabora.com>
References: <4569763.LvFx2qVVIh@kreacher>
 <5f93f034-f781-47e0-b8ce-3c8407a709f7@linaro.org>
 <CAJZ5v0hkOvYL66D+tCRJxbp=XqV59yeZ0dA1Kxoczkcpe5X9sA@mail.gmail.com>
 <CAJZ5v0joTyOcRU0FyaHEEYEbiPbbNSFzW3P7eJJ4MM5QdhQR2w@mail.gmail.com>
 <90a9df3e-153f-4972-8086-13c21a574763@linaro.org>
 <CAJZ5v0jurx=TfT2GHCeMt7xhTFRQwpS_H6-fDss=bt+HodvBoQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jurx=TfT2GHCeMt7xhTFRQwpS_H6-fDss=bt+HodvBoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/06/2024 17:15, Rafael J. Wysocki wrote:

[ ... ]

> OK, so arguably the driver could set the initial state of the cooling
> device to 0.  That may or may not be the right thing to do depending
> on the thermal state of the system at the moment.  Then it would need
> to wait for the governor to pick up a more suitable state for it or
> leave it at 0.  This could address the particular case at hand.
> 
> However, should the core fail the cooling device registration if it
> gets an error from .get_cur_state() to start with?  It didn't do that
> before.  Indeed, it didn't even call .get_cur_state() then in the
> first place.  Moreover, the current state of the cooling device is not
> even needed to register it except for the initialization of the debug
> code for that cooling device, so why fail the registration of it?

Indeed, the simpler way would be to not register the debugfs if we can't 
get the initial cooling device state, with a message, so the driver 
responsible of that will appear and hopefully encourage someone to fix it.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


