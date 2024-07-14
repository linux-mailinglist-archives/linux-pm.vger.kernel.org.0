Return-Path: <linux-pm+bounces-11081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69996930C20
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 01:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250342817D9
	for <lists+linux-pm@lfdr.de>; Sun, 14 Jul 2024 23:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E2113D601;
	Sun, 14 Jul 2024 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMIdFc4M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A615C0
	for <linux-pm@vger.kernel.org>; Sun, 14 Jul 2024 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720998497; cv=none; b=LEHRKyxNYq4COe+unPLI+istKqgF38rOvAMY9TH3XbajAHo2vffs+b107mtbsGprhqLh5+VLANAIstC7COPALUG3/knhBHtKPm2deCRRILEopuzRz9lxeDpijM6jtvu2QcfwM2uOZ0GRTi3W0GMihgGALeyq4efeUPqwqquWhTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720998497; c=relaxed/simple;
	bh=OMkN5np2QtCs1JNvE31sSeSC1J+h0T2xqETYrtz/Jvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nk5fnDCoHlSwlorZTzftJOl4GqMZO6s+lYqC/AFDFPN18c+F3S8oe5Rao4BkQwZm+hByPgMjURTFP9BtLhmfdnRRVLXuaAD8IfXwEHS0WgHaZ0KMJF1DufqbzfpxZZI+HK/PbS/VpJ7P+pC9qSzXEVrLO5U2zXiCyFCUdvxRsoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IMIdFc4M; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4266182a9d7so23282635e9.0
        for <linux-pm@vger.kernel.org>; Sun, 14 Jul 2024 16:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720998493; x=1721603293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=giOaqGkW3gh78EAsAQJqHIlxqObHcBjMGF7SPoyrBgw=;
        b=IMIdFc4MW2Yg6OPSpUgXBa4MZbS6twZtslBhTsBJ/IK001rWc78GjXZPPWUOeHMfem
         NRTkTmWSWoTKQoznW7tU+fXPkOnQPuQzCu/WbSOg71unlJYQo+mcFADiKCfGX5vv6qwi
         gmiFfLImakLREO9JdXat5GPOOPSyrOQkFQVy4WRbDCBkrE2s/4VKmLp9U3cCWYXBM//E
         DHFY3FAAN2d13PTOmtvWc3b+AgUkAtfuO/f7+FZCbX8ouqDizj7YZHVwvO3MUnBnIxm6
         1CXBX/53qgkJAGhy8gq1OXN+Wd9P/wMTBKHgURf2+QbCEvS3ROKrhD3ZqF3BK6lf2r0o
         3PLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720998493; x=1721603293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=giOaqGkW3gh78EAsAQJqHIlxqObHcBjMGF7SPoyrBgw=;
        b=gGiwwpvhMW1+LSqeINdwZF4hMEsfXUOKU6md1/p8cpshFclc2ryQHL1fTSHnoWsNO5
         gAhZNqGapRGWucbQmwcY5IWn/Jw2aL3eA6rIZwA6n81ngurImEoD9GdXCKezDCZ78Y5e
         MGEice/CQ3L5oTSS6AhNykRu350tbIFAyRvS6rEJcNGKx7i+/a7fbCnPA5usog54bp4M
         rgmYcOBpmqNISnhR0mGjWGL6hy9jK/u8hxZ+mwACEwygbZU7QeKLq4kJnIp4vwK8J04Q
         TTQhRVD0qag8/SP+j0iuc3KwjgQBE67kngQEXmP4ctYt4yty2qjFGHmSWxXHdOusXYEc
         ztmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7h6odJ+cHqqWiPPgYTPNxQ651lC1+bx4A6u8Bo2mFpnKNIx2C4djfIH946Useh9ayc8cza3cC2BCe8JVsGp69G+hZhs1qlg8=
X-Gm-Message-State: AOJu0Yxr5nF3yFUb52O7Qc6K2dl4uKsSsvgCgw+yFeybSIgGvBZSc3o7
	ZW9HyXcUTS2qa5f6rOz5Syn7lEOPlwWlWJptMfGRURmCuK9IG3gw0jHZ+hENfoc=
X-Google-Smtp-Source: AGHT+IHEJtdJ8gx7OOIcLqOTFIx9I0LKxCSaI1ZsOORagte27E0UhFbA3bxbSv/hBaM4nMePlTVBRg==
X-Received: by 2002:a5d:6a52:0:b0:367:8909:197b with SMTP id ffacd0b85a97d-367cead94b9mr10738905f8f.61.1720998493213;
        Sun, 14 Jul 2024 16:08:13 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccc55sm4807421f8f.50.2024.07.14.16.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 16:08:12 -0700 (PDT)
Message-ID: <dfe6be96-9ec1-4f49-b561-19865bc313c9@linaro.org>
Date: Mon, 15 Jul 2024 00:08:11 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PM: domains: add device managed version of
 dev_pm_domain_attach|detach_list()
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <1720763312-13018-1-git-send-email-quic_dikshita@quicinc.com>
 <1720763312-13018-2-git-send-email-quic_dikshita@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1720763312-13018-2-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/07/2024 06:48, Dikshita Agarwal wrote:
> This patch adds the devres-enabled version of dev_pm_domain_attach|detach_list.
> If client drivers use devm_pm_domain_attach_list() to attach the PM domains,
> devm_pm_domain_detach_list() will be invoked implicitly during remove phase.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---

> +	num_pds = dev_pm_domain_attach_list(dev, data, list);
> +
> +	ret = devm_add_action_or_reset(dev, devm_pm_domain_detach_list, (void *)list);

Fairly sure that cast isn't necessary eg

drivers/input/touchscreen/ili210x.c::ili210x_i2c_probe()
drivers/power/supply/axp288_fuel_gauge.c::axp288_fuel_gauge_probe()

---
bod

