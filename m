Return-Path: <linux-pm+bounces-9477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E445090D783
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 17:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C33C1B2CE9C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 14:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F32F13F441;
	Tue, 18 Jun 2024 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7bGY1TZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C962139C1
	for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722076; cv=none; b=sqIaFIjbEJe2KktMjbIi4q+wIcjOdRydfYVKaJnrEAsCo4JPkpV1oD5K3G2UFLjL9Xom+FxwNyM11CaGlk5fJyXzpa5OKar7ONFyWhkUlVL8a0J0XU1jvxNNZgyVC+bKLnFO/++qRlSuRo/mocK/yZe56+BoKvNPH71EbUTscrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722076; c=relaxed/simple;
	bh=9+QYKsnxwciPPkF5LJewp9ve91BAy8qGJgnDlZZqgZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKXbJ0SUCW1YMs4Urdad+O6JAi4eBSnH+6ARZD7QocTuLfBl+k6PGRLzlMi1glBhGvffLmG0Yoqz430n1cCrKMcEOc04aSZlAO9J1vHzwjz5cZWITZ6ftA29dAj/6zireq5xjeuwlAISxYvspQrxBL/hhphCMQco6nIUgThg6mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z7bGY1TZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso57856885e9.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718722073; x=1719326873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+cbw6Bx2xA/wA1wsLz+oR6E+oVt4SHwS049oMAcuOIY=;
        b=Z7bGY1TZGDTiDLjdhkTBum7NCYhdBbkLzPs4wsWTd3EOkoRC95fqSvHN54S13HmNsO
         xngDaAWv2OH7nkm6jCZmJcj4cv0RcdwXq7+dnT/ewToKIJX4PkU52ANvPG2movi3vkaQ
         oL2IAYh6dgmkDNz47rVL74ohq+obQzgVHFV+Tj5ZBGfFiytWGmYx8qQEI9coaAeNIi0+
         qAOxBQPspcCciap2GYsNdHSnLZtezwyfE2gGu1UTQEcI+ANPO05pXONgjlufmUP3z44o
         JhOIaftgv52xtTenGKbxcP+MYmwmWdYF+bEKIQOEbSbQknAHMuQnI9wQZUxvjhJTGiUc
         j4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718722073; x=1719326873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cbw6Bx2xA/wA1wsLz+oR6E+oVt4SHwS049oMAcuOIY=;
        b=KTGfVtM6aa3YZsT/wnjqFhyXqs0+b0FFKN8JdQle7plpoBCwPyZEtU97vBu2Yv7Of2
         Xv0gsBPvf0+RejL5mkmh4SHVtS1Q9i/I2ppLUAM5fjMGMRSMnoHkgygRfAqy5IzT7VAw
         +DrKmcweWyGvyqnGOd9kgrg86Dr1hI970VXUG9bKnjn9KS29Wb7JPWbwzL2NPayoZyR7
         +wl+BRMFwxwDKUxbcPFv2AE1vEmgxB0zt0UQbtE5vFzW+EL9qAmSGQ4/C58S+f6GmeE5
         5dFsgfBOdRbiqrNI9ISSnt8XisbfGGx9JDtvPeShpV6/UFvZbbZ+0ioQge2bCa9MOkEw
         E/jw==
X-Forwarded-Encrypted: i=1; AJvYcCVMvJ7xUMNUhw6hSOlvrJ73iq+E5XBZgud8EcOd5y3UQzp069XqmvlJz/vVHaLaCMN6G3UbYK1NSNFa2Ga36oLjSOAL69hLoqQ=
X-Gm-Message-State: AOJu0YyWfQ0R0DU2aaH1V1idYQa/3UwWlGFPo4446BZbj+skfQdTAT7o
	WnNfnR0kLulGbs02RfWPnK6FUT7eRlqEkcMLXabbf9fj83JKcXAiC2ADO5Vy+AY=
X-Google-Smtp-Source: AGHT+IF9eWD+iBGTTbMd7s7/ZxukSrBvSi6su/3uP4mI5cG6RCpXNcaANJ63gsUAM54GxX0XWDZuVQ==
X-Received: by 2002:a05:600c:5118:b0:422:2044:a0dd with SMTP id 5b1f17b1804b1-42304825795mr110428695e9.18.1718722073231;
        Tue, 18 Jun 2024 07:47:53 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de63asm229867065e9.30.2024.06.18.07.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:47:52 -0700 (PDT)
Message-ID: <1e10252a-c759-4767-beb2-12bf79c26315@linaro.org>
Date: Tue, 18 Jun 2024 16:47:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: sc7280: Add clocks for QOS
 configuration
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
 <20240607173927.26321-5-quic_okukatla@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240607173927.26321-5-quic_okukatla@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/7/24 19:39, Odelu Kukatla wrote:
> Add clocks which need to be enbaled for configuring
> QoS on sc7280.
> 
> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

