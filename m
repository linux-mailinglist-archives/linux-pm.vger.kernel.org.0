Return-Path: <linux-pm+bounces-9509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6062990DC82
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 21:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B931F23124
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 19:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4687516CD2E;
	Tue, 18 Jun 2024 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXsNFEos"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D016CD1C
	for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739244; cv=none; b=fZyYIm8WM+KqDiGoxcHCN+FetaFlERbOOE+xDm6fDgasjnmuHM0zrepqBbiaSAdK1sZ3nyNPNqkzcuPocX078AYrHLYSz5I5cd/PSkMrpo/kzaKjbsaBHRKvyT3xBMyy/Q+bh23kmaeScZKxd7qYYuaW8Ql1Nh4AcgXBBW4V894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739244; c=relaxed/simple;
	bh=gOOHAkWdEq2o+F+PAFBjrXVJB7871zrKdARdfANeYwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXYWehpB+B5feNgR/MR7oQ/noruZ55HbRwEPTqCZ3h80tDrrftnPM5XK3rAw5IgeHwRdT08yAy245RkMJ2Jv3NSp0ssyta/c6VcnsBxvthIww1h5FPLbAvM+DitkL6vZdUQZIFQc1Bv1rsJalZ3RqnO7Ti5U+VDGFN8LPeGiMhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hXsNFEos; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4218180a122so41651755e9.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 12:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718739240; x=1719344040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHcB0wrrEA97c0hWkCMLu5O4gDIGel8t6MiFzreOa7A=;
        b=hXsNFEoseGeXcSBrmmJesPKwX2dbfiRoSaHYtcREq2G7Y6o2Mwv/hkJ0imiJuWLlPq
         +E0pli+bL/LLMnBUTeaknaO5WRCa4OTBZy7Pspg6aJ7gYX+IbS1xf2dlwPfLNsjgTJVb
         B3f2hqBmllF0sZdXSrlvoRFQpzmYUTt8dRGAqX+WJnNYRVhN0LGAEwvFhMx9OeWrlTQ/
         7hhMFq9WrBXzZq7Noi0AHALjUJSROn9Z6em45wNOQLNIb8Tbs3eQ/TFW+QEQbAU2bQ+d
         V4HtNBEHqeMhLqwnL+xLXE3aIQJRMulhl07zTY18PYoSOeeCAEm3vozrfYkwgyTIU7jn
         GkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718739240; x=1719344040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHcB0wrrEA97c0hWkCMLu5O4gDIGel8t6MiFzreOa7A=;
        b=ayoHR56OFj+4fhqd8HEl5lP97dH28bIej8UMPLA3YbNRlYDwQKxC01aISnDbSOknVt
         ewRFjZX5y5QiIECcVr6zRIDEB3+KCkq3NfjnLPyV2xgR3m+GAC0QepaW8KFDpcyGhJBU
         mhZwlELGL4Q0RcObkVQbxd+6rRw1daHy7sMGkkPkZ/8oJ/5INs5vh+x8ybPxjUIVc2OH
         JnlOuZ8DN9PScl98PuXdl2rpl6fGSCmXrWa5rKl6tu2Q22Xi3hb6OqMMV+mZ3SLRuQxg
         zj2vm22XyanEqVL+dvQieVY7JAyaao/+un3Vx8IA4HKIADkFA9qbe3Gyh0VENq6vhsQ7
         KLxA==
X-Forwarded-Encrypted: i=1; AJvYcCXJR9BwFu3b1VvP3Ds7TdqaIc1ugEHbbUnzx/m6L7ZRVJzVxN7+NmdKzZsM5kz1dkRbrHwyDQIB9LLkq/o1Yh2lOYulqntNB7o=
X-Gm-Message-State: AOJu0YxdLWB5EjyvIP88pZiN+ZRyWprTV1nAsGlbqw81ZcnV6xDV89Em
	tX0gKwS2KssMKcrzEJDpk/HWpb4zsJuj8yuP8L9lcwzzX2L0ZmQtah0rEF0Q5MU=
X-Google-Smtp-Source: AGHT+IF1hfdLk4wvrZbisapNYDaeCPmw0aftasv3gas30inKuHZTvqzfK3httBkIJ6pjUtuRZUjRoA==
X-Received: by 2002:a05:600c:1615:b0:420:2cbe:7efd with SMTP id 5b1f17b1804b1-42475298bd5mr3272545e9.31.1718739239713;
        Tue, 18 Jun 2024 12:33:59 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:5d11:7fa7:8997:f811? ([2a00:f41:9028:9df3:5d11:7fa7:8997:f811])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef9ccsm233226745e9.5.2024.06.18.12.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 12:33:59 -0700 (PDT)
Message-ID: <8cb65123-dec5-4740-b1ff-58f065716887@linaro.org>
Date: Tue, 18 Jun 2024 21:33:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] arm64: dts: qcom: x1e80100: Add BWMONs
To: Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
 djakov@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, conor+dt@kernel.org,
 dmitry.baryshkov@linaro.org, abel.vesa@linaro.org
References: <20240618154306.279637-1-quic_sibis@quicinc.com>
 <20240618154306.279637-4-quic_sibis@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240618154306.279637-4-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/24 17:43, Sibi Sankar wrote:
> Add the CPU and LLCC BWMONs on X1E80100 SoCs.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---

If you're going to resend, please add a comment like:

/* CPU0-3 */

above the respective monitor nodes

Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

