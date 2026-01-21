Return-Path: <linux-pm+bounces-41237-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGDtMH4BcWmgbAAAu9opvQ
	(envelope-from <linux-pm+bounces-41237-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 17:40:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB685A040
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 17:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53DD2AE9080
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE123350A34;
	Wed, 21 Jan 2026 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VhuLospF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E928931197C
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769009397; cv=none; b=IHGeMNOP6SqFU2DY0GBus39Ft2Iak+ULqnE8JTmM8r3ukm+Y0W3lpXz+hEA7xvZqjAWDqsBFUg8uTMJr4kOo6wLA/+9iqiS8us7uX4YxNpJDn+NQqqvWFjeAx0Hyl/Z8w9UrChtf5F9BdPVeOLSynl7k/uglL+gOMqMOvmGsahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769009397; c=relaxed/simple;
	bh=q/WMDsBSOk2w1D5Fcqwcd1mVv+u62zEh+g6Xu3yAt+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ql2KYEOvTKCEubTOgyjZMTnbwqOQIM46JXVK3pRcX4VQ3j6n1sNub1mt0Vbnk/KGXaOOpnXlApsb+uqj0U6V7sDPUQKoaUErWVvBL26mTz4Zh6T6fE5Hi/8siswYot5iHBjJigVxddDFyz5h95BqPtzu9VsCusliqr7RJSHegUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VhuLospF; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so47029815e9.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 07:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769009394; x=1769614194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVraHTvGYWHeUSeCM7zloSyYdx+u7Hx5nno7KP+9/hA=;
        b=VhuLospFonnDieri5sek6anmFwCy7b4R3ohfqtc1hdvPCeOxKn5HPtj7KKzSkE08qV
         sM72kZqauQ5pAqpk4G5L87g/Yp0mmrKQNwH5PJ4EnszcioEnWb+97YSsG5DOA/m2OSn/
         hSfvkLXL4VqvVAuVWF6WvdFZmqHH2APsDgwQMi5AGL5uTcV/gE0GlXQbGDVrThZmgPCp
         EjU5waaEk4Yeftvu/RKHCrFQ0EdLRXC7CctEGonmaCZy7cyU9Wqx2MAZQSn5sosivPeJ
         V71g0wmno9Kk2vSJ+wuZf2jQzlCrMAdEZmy1lBiry+2URWEGrZDvvhKsSAgx4g+bhXQh
         1IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769009394; x=1769614194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVraHTvGYWHeUSeCM7zloSyYdx+u7Hx5nno7KP+9/hA=;
        b=FmN9JrvQ8B/0Rjd8jCeCukIpUYpHCvAWy+tkQJOdknpjnAlMUAWho5QLPMq6l2KYWF
         sgNPvVLM+89pHrb6OHJQVIt8H3Yrj+OwAuLIDQQUXVUXN++W5Me5y3bgD0jRRY+uQOic
         pWSxEi29Zhem/v8QSZ+TDLOUBTS6c8PA1QFuyYmogGw1mgokQNIf4ULYl4QDJPP8K2EV
         FfqME3hE2FUchml1UXk/XLeUgogvJ4rj47oucgD9jjz1e2b7kSeZ+cwRTjqUny6W8BTm
         9qwk1lQ/4HuLS3Qt15AvBA4301xJwaL/7BP9lmc5eqgFtpvzpS0LPu9nfulJbgr+RZ/Q
         +2Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXI0Syv1b33XvbFRZS+z5xe5w3zijw0jG9V1G25iCd94ojSvJ1FoF+nXeqjhEJVnC7EX7DKGxXoQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs9McTH+ZVJXa37cRVMezoV83oWONu/uG7ZEu7w550sHi6pfXa
	JEktglcSj8w3JFADUbakX9R2a4roz4A20lgBc6HAYAxdH6djQ/U/dKOT5ryJ5XbfWaI=
X-Gm-Gg: AZuq6aKHOuzBn33gXm5waiC3E9KbhZoDTFFwE6GTxbXxnxCO26t5rsJzeu8xawA1eCx
	WhPCgANkjfho+LkZDR0nBBDZPGW9k6QepOUMl/8VB74tRiYVdHZACu15Prd+N/hgiZUfepBZJ2S
	GSPXzOcWehVDzNORD/oV9O7FNEFyeg7cD+/cz354MF5vgtf55jTMRBRW8yIKiVFDs5IoQyJo/30
	IJmEeLLDCFYPDdoMQ50kEx5xt/VxIREDDDV+Oz6U/1Ru9X/jUHVgPTRKNNb42QJEd5Ynh/7sbLG
	TvfY1wceGqZDC0i96Ri+cp/XhV7YfvyB+J8aVZ5qAXEzKzJ+rnvMxxt3x7fd00T1iB/wKOFGqY4
	gJHue+ffu/L7ti8mXcA/5G/mQY7YdFLuNEObp3U2TCEN6uZpBrZlRIPPTz16+VHgR1DCqVYng17
	zW9N6S/HAbxZzE5ZUlUuV8XIlUgZrmQckM+QMsqrBAiev8BDqPxYdIpJ+kns/WmOpqQaefAn8AH
	w==
X-Received: by 2002:a05:600c:310e:b0:47d:885d:d2ff with SMTP id 5b1f17b1804b1-4801eb11002mr229658175e9.29.1769009394082;
        Wed, 21 Jan 2026 07:29:54 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:ebda:5627:9bc:1ede? ([2a05:6e02:1041:c10:ebda:5627:9bc:1ede])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43596090493sm9305361f8f.25.2026.01.21.07.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 07:29:53 -0800 (PST)
Message-ID: <9131900c-f095-4c2a-a6c6-15b875d5b8ec@linaro.org>
Date: Wed, 21 Jan 2026 16:29:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] thermal: stm32: Use predefined HZ_PER_MHZ instead
 of a custom one
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
References: <20260114092808.273695-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20260114092808.273695-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linaro.org,none];
	DKIM_TRACE(0.00)[linaro.org:+];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,arm.com,gmail.com,foss.st.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41237-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[twitter.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linaro.org:dkim,linaro.org:mid,linaro.org:url]
X-Rspamd-Queue-Id: 3BB685A040
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/14/26 10:28, Andy Shevchenko wrote:
> Use predefined HZ_PER_MHZ instead of a custom one. No functional changes.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

