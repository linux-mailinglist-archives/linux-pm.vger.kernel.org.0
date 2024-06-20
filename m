Return-Path: <linux-pm+bounces-9693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388F6910AC5
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 17:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A422816AC
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BA51B012C;
	Thu, 20 Jun 2024 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s12qsjrg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2171AF6BF
	for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898921; cv=none; b=TdAEwuoKcH4pMqsjfMT0zZ09JpYzEkSACWywFE3k5kMcByBHfCyjDrt+6iR97NukQbgnt7ElXiXzbOoGTg3otub6pMhPoaBswfxAeXHy/cXuslogHWtPgWuQ28yULoT1OmA2GJRTV09DlhNnc7iDWygcVAVVVtibQSi2QiXmQ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898921; c=relaxed/simple;
	bh=Q4JBCnhSJq4oqfZIw7dzs3bChMGSgFx7uu84eklMR7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mwPHIZS2liFWjoQTHFlMwAk+oV3rGIIE/AxDlluMgIm/Efab1PsCWYY8DhscfG34DGmTVDHFzp+Pr27jBTCzz9NGH9erCWc/4GWqivdPfOlyj4HqQovFAElzk9YFyhYH3hlukfsgYtkdOMLcThZIebmU5dGudEf6pleOFYfHXOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s12qsjrg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f1c4800easo115183766b.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718898918; x=1719503718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q4JBCnhSJq4oqfZIw7dzs3bChMGSgFx7uu84eklMR7U=;
        b=s12qsjrgolFYEp42rffnCVAzXO0UZaQ+veKzonJwyK8mp8wMcd072Bc8g6090b6FVD
         YHK174y4FCBz2SLHVheUHg2U22U1ra8QLwVwnML5014ys3+VXypOhyeD3LKiHoKDt59E
         wZpzl37vueXU0B8K1zVgQDOaxVBortLRdBjNF4x8truP7jzsihWegrq1RrpaEP/SikPf
         cdr2EwLKZMNmoeW85Yi9M0vT5gzjuD/PHFuj1+8SOAbt3T3WCV77PGasY3HbMQ1CbTX5
         32OqT+1Q0HOfr1zqeShghHvbLm8P9cAJAa+sMZ1x7V/DoSlSPeDdmmfnwonjLWl1JPof
         CHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718898918; x=1719503718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4JBCnhSJq4oqfZIw7dzs3bChMGSgFx7uu84eklMR7U=;
        b=lsyQGvy8v40imeA3Ow/NPH24eLOPHjxZ92flOlivibdSHwmvgiWeCbTbVCr6ooaL+Z
         TJC3B6w41vbyROL3SwCIVfOhSzkQuich+8FZR95i+9pUzOpy6RRdFE7DKWpKaeRlEvxS
         jRLx19gBxGQegPRnmBB7mXEeh9d5880j26wmYgWkYTjvUQ5iv1KPNh0AkDHMEXPy5Juj
         jYgbIXU0qQ/1lOUBhwFnwjIUkNdrMGYJTFR9/FBeH77cweXulP7d9Tsv7t+G7er154L+
         PrIzPCK4XH+v2/k6KoQ2ukH/iGhv14rtOjPtgNyodTrCmf/nM2ct+qO9aUmJQWHYLVG/
         rTJA==
X-Forwarded-Encrypted: i=1; AJvYcCU4jBmFfcXzKSdduZWRLDllGPl6QqjEc0EuwAKNlsAx0t7XIUyJ2vGeFKjFcnNci2vJW2WVHfubyeZLSlFVm03346EKxNiVorE=
X-Gm-Message-State: AOJu0Yxc8jpeollgLu5HouKM3p7voi8cwg80mnpo1Ir8Xi0TzJbzQjFx
	/HnwyrYu4Cvq395Cd/AOetRlavGiP2sVyfeoYG6/oBNUIH+MzNJ1bNcqTtvHTuY=
X-Google-Smtp-Source: AGHT+IFYBlhlHfbiK0XROGgqygoHfOv7JX4uyejkwsNd3c+EAa8G3GJAtqdIkY1sIMVpfzVV0sIZTg==
X-Received: by 2002:a17:907:d30e:b0:a6f:ad2c:af7 with SMTP id a640c23a62f3a-a6fad2c0b2emr322816866b.2.1718898917692;
        Thu, 20 Jun 2024 08:55:17 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9090:3594:a722:64b5:78a3:68f3? ([2a00:f41:9090:3594:a722:64b5:78a3:68f3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56fa6756sm781569266b.217.2024.06.20.08.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 08:55:17 -0700 (PDT)
Message-ID: <d525c5dc-f4b4-42ca-93e4-d45068d896b6@linaro.org>
Date: Thu, 20 Jun 2024 17:55:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] Enable CPR for IPQ9574
To: Varadarajan Narayanan <quic_varada@quicinc.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 angelogioacchino.delregno@collabora.com, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
 quic_sibis@quicinc.com, quic_rjendra@quicinc.com, luca@z3ntu.xyz,
 abel.vesa@linaro.org, quic_rohiagar@quicinc.com, danila@jiaxyga.com,
 otto.pflueger@abscue.de, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240620081427.2860066-1-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240620081427.2860066-1-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/20/24 10:14, Varadarajan Narayanan wrote:
> This series tries to enable CPR on IPQ9574, that implements
> CPRv4. Since [1] is older, faced few minor issues. Those are
> addressed in [2].

Thanks Varadarajan, should things go well I'll resend CPR3 next
week and then review this.

Konrad

