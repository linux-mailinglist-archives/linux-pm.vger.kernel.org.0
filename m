Return-Path: <linux-pm+bounces-9476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC3990D62B
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 16:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1446A28C447
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 14:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938F113DB8C;
	Tue, 18 Jun 2024 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnRwdUwZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D612E13C675
	for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722071; cv=none; b=PTYX3SJNkJhqWL9yf27vnu2+VPlKP/Ya8QsxOamYGsnVNTlKLaxWnYssHn1eQHhOFh2c4Q9edibvR5cxVpaLdSxuKzrPqNWhea718Ah7Zt48BCFe6noVxGJG6vTxkGadVmdx0Y2XrtE3E39gt36V4hQggrYKVKqYwx6uowGGHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722071; c=relaxed/simple;
	bh=IZZnds0VRHrm2Ii8hE6YeOS6qZ0PTeuu48RLJyyIyXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekTsJ5c3IY8Xh21nhiWk2QT2sIgbCXvf3cGDYXpCMWyLN50KcQoRm3b1PzhBOHTpGxZEVLSmsZFGTGDoX4DjdiZaZ3uAAxLV7zU77H8BCjaMrozWviEPskIch6xSXu8TRNgBf148N5kFkxmQhBlDDqOWHwVZ0WZTTbEXMqATtjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BnRwdUwZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42165f6645fso44802915e9.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718722067; x=1719326867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJ3dYX4GpJ/TRHjWJ/CxptBXzc0wGdknCikvdomgmWg=;
        b=BnRwdUwZXP15wxEg20PWKAHy7YAHMEC79MGx1WtVO+EaUbqNxDsSISxVmj3b+tuY9t
         Zgx2suuLRXNgi6tGDp6yohZYXYET2of0ZI8qS+rBoCBm92DtNIG0mO7nMQv9SR196lrK
         2oiGVVDMdXvYZ/uFZzRAwcf50xSYZxW0db2qoDcDeJDti46NlaW+4CnNG6zzUKhfIB/A
         2lzlNrq18ztrQwzFtdYQhwL/QCqYY01IPCbkkDev8gmaX5RMWzq3uQ47/A/AyMt86xMe
         82ibvnyD3pYEMaDzXXssJ8rFDVftyUTp/g+9RrhG9nX8cnatIGAPnACUGalaCrd7HJ2f
         cquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718722067; x=1719326867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJ3dYX4GpJ/TRHjWJ/CxptBXzc0wGdknCikvdomgmWg=;
        b=uzDNraa9zNr8rmnTCyUM4g05dSuq8fWLcj7efFEWWBFR0kJNGbIr4nFaJ58O5Wz3RR
         aqsGlKewoQTKnx8TgaqslXhMlYVNqsccMytABkq8rIj61PC3s5a2HvZ70oOW/obTvXLM
         27NHlMb+LlhVzwA+uYQRe92YY0C1/F6ND89wuXMLo+H0ez4A9om8I0AXrNPOay5kwfJv
         KB0sIU+2Tlnv39j6TNDSh04jAONImXc7Ag69WgF1dUHQcCCXkXSe4wypIgOufBMGCmhL
         FurCQav/MQDg62cUm626pW7RaryE8zFlDOtqPF4RZdFQCXUaRjt1nG2LxwmctEYhYgT0
         fa4w==
X-Forwarded-Encrypted: i=1; AJvYcCVsAiCMy3/gyDWqMCrRA0NnRK3PiGwl6rcjNpSAi5ciQFf5txfgux6h7MR2Tf9yGKoQTOw+A7bgt53TG+HXFmxv8pKVDGXro7E=
X-Gm-Message-State: AOJu0YwR20lfcc/CNhXnktfuY+RTQIPjS5STJbrmPA0ex0y1Sw9Kl2/f
	tbQDbEoyCFvn7Lb4+PW5zjzuPgCrfDgKxKa7lPofn4d2jgexearmFBuPGBDs7Hc=
X-Google-Smtp-Source: AGHT+IH7I/dhyj73BogJTxO5E8ag28pj1oQQCYT3fMmsc47p/80bkTRhwGBL+ram+v9dMFIqbI5/7g==
X-Received: by 2002:a05:600c:1d8e:b0:422:5443:96aa with SMTP id 5b1f17b1804b1-42304827573mr106149055e9.15.1718722067337;
        Tue, 18 Jun 2024 07:47:47 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de63asm229867065e9.30.2024.06.18.07.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:47:47 -0700 (PDT)
Message-ID: <36687425-0be6-4616-a3b0-9870bb187e34@linaro.org>
Date: Tue, 18 Jun 2024 16:47:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] interconnect: qcom: icc-rpmh: Add QoS
 configuration support
To: Odelu Kukatla <quic_okukatla@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, cros-qcom-dts-watchers@chromium.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, quic_rlaggysh@quicinc.com,
 quic_mdtipton@quicinc.com
References: <20240607173927.26321-1-quic_okukatla@quicinc.com>
 <20240607173927.26321-2-quic_okukatla@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240607173927.26321-2-quic_okukatla@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/7/24 19:39, Odelu Kukatla wrote:
> Add QoS support for QNOC device for configuring priority,
> priority forward disable and urgency forwarding. QoS is required
> to prioritize the traffic originating from different interconnect
> masters at NoC (Network On Chip).
> 
> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

