Return-Path: <linux-pm+bounces-6448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ADD8A5B72
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 21:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2373B1C21089
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 19:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBDF15696C;
	Mon, 15 Apr 2024 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HHcm5IRa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16E5156984
	for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2024 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210169; cv=none; b=Va8AQMy9bnnSI2iLehdnstHNPcm9bJgbq6GJUYIoCinRjuZM4BxBh+CnBO9IkaRMhYGlgSkHXuotWm7a/E4fnIDK/W7/V7653amNlCPlMA+kGR0sUrDBamWmAzH1Kqchkud7vUR6TthAJrDik1c/mjBXhe+l2WH2ZTja3tX1tQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210169; c=relaxed/simple;
	bh=axLQ6Vb2y+fBkXSAxVnB3Ffwdojty5NQbps9GG6vRfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRqMSQVRCsaQPkIGElbTMmVpBNagwIAxq4XxI1WXEi8BiJJupfcoDlD0onLg2NDGhhCTQE0qw7Op2jHqaL5zXPhxF2d8+DJnKo6Z0DnZGjjGkRCQJcXkTfOaXeutPyV/TVI7HMXC9Z8M6cFj1pT6wBzuiZTcR2QDUkSmOzfl8P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HHcm5IRa; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d1c8dc79so4617811e87.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2024 12:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713210166; x=1713814966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pel4IuSMXhoiMO3e3jJODv6FFXqtNPQdDIe5/vhiNjE=;
        b=HHcm5IRaaK/ftAilAH5XGNzsTAs9K6vsr2r8g4ukWrRTNo6PdmBFDRL2WL8OGQv1+u
         bozQe6mWyYF+ZooTPKGUrCZuEx9e5/wXBv9K8kXasdQzYO28RFvmxOl95CYNycd3hetq
         lTlQBffZZffu7SCBQo8qGJfv4Q4BQkt7LTGS8rOjX0qzIZc0aPKPMXd97SvaOzxpNba+
         jC0/icpYTyeWhBYzjwa52sSn9V+6deI3F15Psz+6Zf58VpfNIy8ogMB9yLzx3Hbp/lNL
         lcTYdrFvnj36Bp6Fi4L76U1ghJMiQl5G/THy3/NDVT3/vhp0zUXTu4iu9OIm8UaG77No
         MGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713210166; x=1713814966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pel4IuSMXhoiMO3e3jJODv6FFXqtNPQdDIe5/vhiNjE=;
        b=ksYq8+tqlzsee4A4MGOiO4SCx65+6q0taJR/TSEZKY7HK7Jvx2uNUsRM5dg+EKY37W
         vXmiqV+w/SyIQfL2lGbqLtPx3NkciYJw14xhrtuxwPuii1kuD+J/JL86bzrr2hJU8HEN
         u6xPBpW6b2TFiTgx54r1uMqoIYBJVtACwJ05fMGHn/ZEKtzP3X8FH0DFfsEu4ywnoNYs
         8VOTzyI5nj9MsLiAOG6iFLe3wBkUr8GAyV+rnJZoj09o2JkCRo4aYaXsSF7SkVEM+vLz
         HwqtZLKAr9O1aVF1OQc0tg8KXF/y37ZtGZXYWq3a/DGh+DDmiciH0OtDnuOt4Uw0gJAe
         sEbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb65tR5hq5UXmfmCdMbC4bEfc9FD58tqrDpn0GhQNlfU6bXdxoG8GQ5AlKUn5EcF63JAKWCVJuRylN49We/ZsFwkMwmeRa3P8=
X-Gm-Message-State: AOJu0YwZdPPeudZFM+ra3JUk/rhsUwNVd13MXKmu4wTPp1nfdTikYlFE
	XL+jWTxB0FN9V3LDUZTtZffpvxtf1HbYqtTzqO6q3lnBHjxxINBg7BFWDplO8Bo=
X-Google-Smtp-Source: AGHT+IGjEnRycaBaSeP36Mt4IjxeEF3ElKi4vzIgUYlEGvDUqVdK0yPDppZzA2T8o+u/CJIaTfH0/g==
X-Received: by 2002:ac2:4144:0:b0:519:231:e4c0 with SMTP id c4-20020ac24144000000b005190231e4c0mr1585142lfi.43.1713210165791;
        Mon, 15 Apr 2024 12:42:45 -0700 (PDT)
Received: from [172.30.205.18] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id o21-20020ac24355000000b00516cba5b4cesm1334507lfl.46.2024.04.15.12.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 12:42:45 -0700 (PDT)
Message-ID: <be5bd196-a782-41a7-a1a8-8aea6b4b2365@linaro.org>
Date: Mon, 15 Apr 2024 21:42:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: Add PSCI SYSTEM_RESET2 types for
 qcm6490-idp
To: Elliot Berman <quic_eberman@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Andy Yan <andy.yan@rock-chips.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
 Melody Olvera <quic_molvera@quicinc.com>,
 Shivendra Pratap <quic_spratap@quicinc.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Florian Fainelli <florian.fainelli@broadcom.com>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
 <20240414-arm-psci-system_reset2-vendor-reboots-v2-4-da9a055a648f@quicinc.com>
 <CAA8EJpoXrbdD5xVmuo-2b4-WwpSachcJ-abDtu4BS_qa-2A+OA@mail.gmail.com>
 <20240414173158942-0700.eberman@hu-eberman-lv.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240414173158942-0700.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/15/24 02:32, Elliot Berman wrote:
> On Mon, Apr 15, 2024 at 02:13:29AM +0300, Dmitry Baryshkov wrote:
>> On Sun, 14 Apr 2024 at 22:32, Elliot Berman <quic_eberman@quicinc.com> wrote:
>>>
>>> Add nodes for the vendor-defined system resets. "bootloader" will cause
>>> device to reboot and stop in the bootloader's fastboot mode. "edl" will
>>> cause device to reboot into "emergency download mode", which permits
>>> loading images via the Firehose protocol.
>>>
>>> Co-developed-by: Shivendra Pratap <quic_spratap@quicinc.com>
>>> Signed-off-by: Shivendra Pratap <quic_spratap@quicinc.com>
>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>> index e4bfad50a669..a966f6c8dd7c 100644
>>> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>> @@ -126,6 +126,11 @@ debug_vm_mem: debug-vm@d0600000 {
>>>                  };
>>>          };
>>>
>>> +       psci {
>>
>> Please use a label instead. Otherwise it looks as if you are adding
>> new device node.
>>
> 
> Right. Fixed for the next revision.

Are you guys planning to make this sorta ABI-like?

If so (which would be greatly appreciated by the way..), perhaps you
could stick these magic values in dt-bindings and give them cool names

FWIW DEN0022 (my second-favorite book) suggests these values are almost
totally vendor-defined, so if I were Qualcomm, I'd take the creative
liberty to come up with a set of numbers and never ever ever change
them

Konrad

