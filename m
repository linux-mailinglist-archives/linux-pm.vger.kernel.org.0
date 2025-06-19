Return-Path: <linux-pm+bounces-29052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 149BDADFE60
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 09:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD793A1D01
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 07:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C05246790;
	Thu, 19 Jun 2025 07:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jITB6Yxw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF04242D8C
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750316823; cv=none; b=b0ftzq67Q4HzBV1JZ8wZ0nJtoRq+xxRQihFTDj9hQPtanZxZ9KVKs94R8hSOAddLB7eN7ktD1Jx3D0T+vXgUdy30heC10oEUWVtWorLxjHeRkv2xjk8tVndJEAuIuQG6A4yRu8waf6TNtg0Wth/LzLCFiRAkAU3gP6U2dRqpctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750316823; c=relaxed/simple;
	bh=gIrndrxqEQYIbQKwOcS4Mln3+RBHF7hskkcp5VOAKaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aihpgPBE84/hY8z9UzUFn7rzw9k0I91LJ7GBJdFsfoQr3Ijlywk4SvqdL8PYaydzK/BgFsAlCxxiAXd7OjpUa+cW/HPq4jtFSSuNs33ijvTVgUbXYCMjXVvbMqd9ju4d/DgD96PtKgvb0ivq2EqQJ3dPvtoygt7bhs7peu1xDC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jITB6Yxw; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af6a315b491so467536a12.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 00:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750316821; x=1750921621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IymuwWFz5efXWH2kgyyNSxlRPSBhBIlq8B6srm/Era0=;
        b=jITB6YxwNdiziytTZMmOunSrMJYwnfFJlf59FgIG1M1zfjzHw1YCXXr1cL3RxvSt9g
         pPfWHXi/GNu71l2fiKMDAD72d9CJ3Y9UoIV/RsDOorBaVU3gOBolh+p8n5rfDQRzibJ7
         TwTnQKtw0DDJmlBWvmz0kjxdyTtr26oBtIGcjGMdiAxz8IY+WfbJ7QJTYsG1DRpmxAvm
         06Rh09Bq0BurbrmGwM0b0/oKXjAsZuiyEg9rXqfaE+LlAFBq9JT6ZH8aHeIlg+yxjH4X
         uFpnAKJ9eCSPTjVWwOg/a8LLN7UT89MEkyFa3m6rQgjEWpV2uqHy1QcfXVeWOXZ+3zx2
         Og4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750316821; x=1750921621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IymuwWFz5efXWH2kgyyNSxlRPSBhBIlq8B6srm/Era0=;
        b=QZAtquPTlXIQIFTeA+CYSJbeA00Zb+tBTVefxUF4hf9RWbyu/kG8xWZftG81mH9XYe
         XrrMwfur47ncSmZnvBTHYFD64vNXnfXJJ1BznI782ihMPDSV40kAvhhCeV8hXu9w7lW4
         WmYt+u+jL3xyNiio0vfCvUbPfVqWknjsyoaDF6v8RytqT/V1eG2IXPOt4hqnalKeTs5K
         UrQbplVlU5N3rBWS5jiu3fYEZe1IP9CXMLl04lKLt8AZua6hS8jSNYLpT6Xa8TZ8n/Cq
         Thjvx1kafZglimYCyTTI/ywDhTI+hPQ9h/iIJ/VvMdES0X1kztDnPyfnRtf4/MQ8rLn0
         lUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi0dIYiytD7uE3rTuGflfFKza0kbvbtFRIgMAlLMBWLxolah5xTtoOglG1zmf/VMW06SP/F132Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLEv1qHbz8UcAvRwLsUW2hp8CaQ9a8x8Mg8MpuXcNvSaLwL1F+
	CZzuaB8ZBF7xM73NrmwWIVtDrwL7F00Gv2aBZ7+cEKawfdj2FwPoz0AvQTUZpf+lYR0=
X-Gm-Gg: ASbGncuqwT0ZY1Cw+kkb8hbpRXCmemnPnNSaC/OSLiYvqfTCivH8HLlsQtRY0rDq6LN
	RFeHi91qgKj7b8JNVbf2GP+bkKOsh5OD/y1VPiNKGWfzb5GfptApxjuIqXLA9AdOPK2ilszEBrC
	cK+HqpBX82KDbgMi3zSlG94Z7GpNizT6qPVMmRhHP4Cpa2+dx2DjK5gdnN71KbWL+NNeIGUy/5T
	mhXk5QNevTqychnsSMCstNRd83MIwM9miJvjmcdG5pwzCj5iCe3KupGx3lGKZClzFOqjZpQGX+j
	ebl6r3+WKnitVHaGID2K3jSejRoT+tMSZkThsuqIUMHqx7M/bU9jehOX4eHej3I=
X-Google-Smtp-Source: AGHT+IGyYaOKIL36CbVXP5wK2R0Ni0YKSM2IJpGDucT9Et2S+y0DrU3AlyTGX8LLr5798o70TnJH/A==
X-Received: by 2002:a17:90b:380c:b0:311:baa0:89ce with SMTP id 98e67ed59e1d1-313f1c06bf5mr36604358a91.12.1750316820675;
        Thu, 19 Jun 2025 00:07:00 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a23e627sm1365892a91.18.2025.06.19.00.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 00:07:00 -0700 (PDT)
Date: Thu, 19 Jun 2025 12:36:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: brcmstb-avs: Fully open-code compatible for
 grepping
Message-ID: <20250619070657.dshqwhulzadxpyz3@vireshk-i7>
References: <20250613071643.46754-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613071643.46754-2-krzysztof.kozlowski@linaro.org>

On 13-06-25, 09:16, Krzysztof Kozlowski wrote:
> It is very useful to find driver implementing compatibles with `git grep
> compatible`, so driver should not use defines for that string, even if
> this means string will be effectively duplicated.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

