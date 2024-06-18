Return-Path: <linux-pm+bounces-9469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B1790D596
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 16:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6AB28296D
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A571891C4;
	Tue, 18 Jun 2024 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkkkRR7x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F1E16D320
	for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720648; cv=none; b=dydB73FT2bKLTtHYfzaaoKsPz+Hjvt4m1ZLbcXlBltgcW9i8YbnQ6eKg32lYWz1546OWMDR6KwxKu27+kSUdRFKqpDpjW0kZ5pNKxKyqGrWHJXoRe5yfe3dGC8Od4nNxohv917gxdX2KSaWVtLDON7WJMR9j5ZUG5yJxQ7nQTOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720648; c=relaxed/simple;
	bh=EKwts7PirqeXv8GCmsKD14CTWAvJ5DcMwJMZ4Q/8iFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdOqp/T99i5wUlopGbyf+tPukjZiaifxmCMibdw0hyPkVQ++Qb1QWKShdFnhXXSVfLm1gIIj6zwzHSu0frJLhTKhaMPTATPB4boV6jRrXt4yJu45T4I5MHAZQ9ESOdcFfRwk3A268YVsx9AjGj6ypzmPdaH1py+Bz9zHaqqFtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dkkkRR7x; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so97059541fa.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 07:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718720645; x=1719325445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9L4PU16nfN2XQvEI7canBzFWJ5IZWFKBrB7QE7CDcc=;
        b=dkkkRR7xzTTNmR8H1BsizA+7zIa4y+TpjDbozsqQ4xLCSI6kkYBvGdBV4W96BO8GQO
         o/kpxQEKaK/G00YbhxQeWMlDxurcoSVyXt7aO9CGs/pLi6n2enj95vPVcjtDvL8mwQhU
         7GSQEXIZy5WqR+DsiEWE8/MjyIQS97NNFHHjvreki35Ggw0Qb/lErW+6fVQTjY+ML7Ol
         xdnQOfDlaspBRpwapK17MGujCAZWjGjuissVGQj/ovEAFFhzaE2bN8Uledl82qjTO97h
         gXaSJsv2mOVWDUR0loqPYceamnXO/9hAo+b3SXa4CZTeymHkFkcFvDLqZTMDhVzrhr7u
         LmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718720645; x=1719325445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9L4PU16nfN2XQvEI7canBzFWJ5IZWFKBrB7QE7CDcc=;
        b=ZriYOCaZMjHFo44dP6OPygRcvSYePO59wPmHVubvWX/Ke5bgysV0VH9H0VqtrQ19ng
         NLdqpyOoG20zeHr57hS1P2zZ6U3gZXkdN+QMQWjzyMqw/vzL8NeMTdhujfEYzloh0GbK
         gSvY5jiWTrIOXRmKJw9ejuiWC9O1WpWLNvdDVauQIvbqgUX5E2Jo8+oyde4Qtbt3kQbP
         b1WhxTq8vLmmwxTMSX5Q9OK2D62UqXhL3FX1DYCf0je48WQwWGq1ai7+MuNSQBbuv/CL
         +jt5NsajkWKe5enZXC3zOVTmAgc6cKsZMdhhyfY9pJpm0ID6zm0vWx1AcKxW0kjXwpFB
         c2xA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ/lPgm4pdPd46zDrgRH2Ph6VUYvl+b9PdYH/4isR7rvcSKm1538UZa+ru8dX0cMRtokal8KnQLh1aZMliHibYw4qreSsJ2+M=
X-Gm-Message-State: AOJu0Yx1pH4HFMETBK48wtRVr7z9bIZUF8DbTTD+9qhvu2cOPXnpXGuX
	ewpk0Wi0HPSkrS0zXgVSUXzMxAxOAHvQPeG+FEPzlFAoCTg8u3v9EiNQu6cA2qE=
X-Google-Smtp-Source: AGHT+IGtvNk8n9VRov10JBLuOpddIlR0ZD+NTpYkW/xoyHqQ3CBv06dPLM664Q2AuPsGRorl4CI30A==
X-Received: by 2002:a19:4317:0:b0:52b:e7ff:32b with SMTP id 2adb3069b0e04-52ca6e67557mr8965479e87.23.1718720645462;
        Tue, 18 Jun 2024 07:24:05 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287b34csm1510198e87.199.2024.06.18.07.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:24:05 -0700 (PDT)
Message-ID: <2dc3d7f4-1d7b-4aae-90c9-508cbe277a35@linaro.org>
Date: Tue, 18 Jun 2024 16:23:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: Add PSCI SYSTEM_RESET2 types for
 qcm6490-idp
To: Elliot Berman <quic_eberman@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Andy Yan <andy.yan@rock-chips.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
 Melody Olvera <quic_molvera@quicinc.com>,
 Shivendra Pratap <quic_spratap@quicinc.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Florian Fainelli <florian.fainelli@broadcom.com>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-4-086950f650c8@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240617-arm-psci-system_reset2-vendor-reboots-v5-4-086950f650c8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/17/24 19:18, Elliot Berman wrote:
> Add nodes for the vendor-defined system resets. "bootloader" will cause
> device to reboot and stop in the bootloader's fastboot mode. "edl" will
> cause device to reboot into "emergency download mode", which permits
> loading images via the Firehose protocol.
> 
> Co-developed-by: Shivendra Pratap <quic_spratap@quicinc.com>
> Signed-off-by: Shivendra Pratap <quic_spratap@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

