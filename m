Return-Path: <linux-pm+bounces-26566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9449AA6E5B
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 11:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AA9171719
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 09:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F40B230D1E;
	Fri,  2 May 2025 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTUTESF8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8C022688C
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178976; cv=none; b=eK/OAtkg07GMwvxIsUpCcgw3R64c4XRENq2n525AoZSHw+EKwsnfVTw/ACI5p4cvuVYTH7siEXI8amCZFdPWIp6dHnP01HvbMHkubpZSp98SIPjybKU2MC6z/tClmQIE2Hi/4NIB0MYVmfxkTpmmA3Z3znoBIHmI/gzCXfpesxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178976; c=relaxed/simple;
	bh=XE7hRm0qUP0PF61AUPQ84APUG//4sM4kzYT+GWRzLUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=WdBrWe0skBcCaQk5MV96E8tQv+Mgq8Uy6/tVmXvNvczSZm9s63g9oCGmVbOq0jIhBJ29+TWhpr76doau2QA8PReqj9qpeoOvC2Vw4p4u5bQcZerxKYlfy64Ld92HBHM6F2GHC4AJI6PV+PS71At7HSQHpt8Uzi375yidktQE6YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UTUTESF8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso1054489f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 02 May 2025 02:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746178972; x=1746783772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WX/evLS+DuAe/0hAk5mHgxdHnsJicsKUxinsRE+gIwI=;
        b=UTUTESF8oIlgwT1NlAMe84PQyu+i2zvuu36LEu2IRmlO4C5699pofAS24BZRT+Nd8c
         iPUzLgTYXIqfDrkaxKy+JPlWPSzupqok+ycdPWiJBIL8oIi2Fs9knsc89krO9dLNGfHL
         30gBVBj5VR0c4b8p0xr+QehSMByt3cursARIoWDyCB1kZHTX1NtVQPp1dkPew0kMqpDY
         MlRhcpT8hmIi6pJw2zXwuY9KhYsUI56QYTMjS+Ge+gIQAI9d29MTLYbtIgBsLPuVnnAJ
         xbSDodvCMDzKrHkdQIbQvCeHrJZzsMaMX/cGz8mMiuH1FE8CQSae9DTl4Glky2M31H0k
         cD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746178972; x=1746783772;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WX/evLS+DuAe/0hAk5mHgxdHnsJicsKUxinsRE+gIwI=;
        b=SF4hSfCSUtJesuvuO8I0JtHdnA5/ZVP0IzFovGY5sgSwVzux3+Kl3+iM74S0SiBBgC
         UyMJc/yqGoyC9UDf80QF8xgviMqNb40sgQuWp9+PNzmhtL9BkCpP3eSUZWMoUf/WXRnN
         lN2WXWcyUlX2C2Lv1gUU692gemzbhWCHh3HoJ2B6WDsayXDr1CAxxGqBuux/MR8Gzf83
         SI/UY8Y7HXOn24oDoy0RTJMToeg4q2RQD8iRqOXD8VPjvTfgHrTPxWLnMWfKttWBHIfv
         D9J9Z1MFKgl6bFHMkgYW+oK1Rwl6jEhSMXctwqIbuopMi5H5GKSty/zvxw50BwQnXLDm
         Bfog==
X-Forwarded-Encrypted: i=1; AJvYcCV5s/+NjFodoqDb4y0aqyH33ORiHB6m51jUyKBaFQyBrJWeqtcsECvspQXTqgaoCWc3QezBXOczjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMv8m//M+YBz1h1eCm2oNr0eZAWmCpdDOazbFr6dWMgc3A3nm
	l3cPaarL+JnPvoPr+Yf8ESSHgVbdgjoSbDoQLWDPZ8livSppMUXC6aISxvKF4pk=
X-Gm-Gg: ASbGncsWCc7kfFM8Rahjv+eggXhvDVqF5WdIkXMCxoEEgqeW9OWtat0/Pr7y7SSUTIe
	5Zd4sJl7ETn2sNzYiphUNh2WKlq9Oq01O/fQ02tWNK4h6y4c5OFygei2soZ6Krs5+rVf6WJZTOb
	KK512IKWtvTNJ588QV23HeYquVwr2KmjK3XdFOqb6uu7kEcVpLh8k9zCLBEumrsgFurGOkDcWzj
	joDE5Yj4HNgY1Rx4dIogWQu15cUi84BctwqmzYGVy1JExathWAjecEaWJfTMEBewTF5LS/H7DqN
	Lx2o1cMer4jt/HD7K4QtJDKzAg21yxno9ssmCQ+Aipyh76huhx60wnnL2GcWMynoV9172wriRPK
	LMj75
X-Google-Smtp-Source: AGHT+IFiBHhJcjpY8AHYvmDW+6tcszRqTtvHysmH6lFStDCvbCOZgJoVZxZSTCZEdI78/1mXl/L2Pw==
X-Received: by 2002:a05:6000:2585:b0:390:ec6e:43ea with SMTP id ffacd0b85a97d-3a094038f02mr4157873f8f.15.1746178972094;
        Fri, 02 May 2025 02:42:52 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a099ae3c1fsm1660874f8f.37.2025.05.02.02.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 02:42:51 -0700 (PDT)
Message-ID: <356bc97a-bd75-4894-98fe-d7fb0e02e1c1@linaro.org>
Date: Fri, 2 May 2025 11:42:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] thermal: Add support for Airoha EN7581 thermal
 sensor
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20250226003608.8973-1-ansuelsmth@gmail.com>
 <20250226003608.8973-2-ansuelsmth@gmail.com>
Content-Language: en-US
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba
 <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Christian Marangi
 <ansuelsmth@gmail.com>, Zhang Rui <rui.zhang@intel.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250226003608.8973-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Angelo,

AFAIR, the LVTS driver had issues with the interrupts.

This driver proposed by Ansuel Smith looks very similar to the LVTS and 
there are some comments regarding errors with the documentation below 
which may appy to the LVTS driver too.

Would you mind to check ?

See below.

On 26/02/2025 01:35, Christian Marangi wrote:
> Add support for Airoha EN7581 thermal sensor. This provide support for
> reading the CPU or SoC Package sensor and to setup trip points for hot
> and critical condition. An interrupt is fired to react on this and
> doesn't require passive poll to read the temperature.
> 
> The thermal regs provide a way to read the ADC value from an external
> register placed in the Chip SCU regs. Monitor will read this value and
> fire an interrupt if the trip condition configured is reached.
> 
> The Thermal Trip and Interrupt logic is conceptually similar to Mediatek
> LVTS Thermal but differ in register mapping and actual function/bug
> workaround. The implementation only share some register names but from
> functionality observation it's very different and used only for the
> basic function of periodically poll the temp and trip the interrupt.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

[ ... ]

> +#define   EN7581_HINTEN1			BIT(6)
> +#define   EN7581_CINTEN1			BIT(5)
> +#define   EN7581_NOHOTINTEN0			BIT(4)
> +/* Similar to COLD and HOT also these seems to be swapped in documentation */
> +#define   EN7581_LOFSINTEN0			BIT(3) /* In documentation: BIT(2) */
> +#define   EN7581_HOFSINTEN0			BIT(2) /* In documentation: BIT(3) */
> +/* It seems documentation have these swapped as the HW
> + * - Fire BIT(1) when lower than EN7581_COLD_THRE
> + * - Fire BIT(0) and BIT(5) when higher than EN7581_HOT2NORMAL_THRE or
> + *     EN7581_HOT_THRE
> + */
> +#define   EN7581_CINTEN0			BIT(1) /* In documentation: BIT(0) */
> +#define   EN7581_HINTEN0			BIT(0) /* In documentation: BIT(1) */
> +#define EN7581_TEMPMONINTSTS			0x810
> +#define   EN7581_STAGE3_INT_STAT		BIT(31)
> +#define   EN7581_STAGE2_INT_STAT		BIT(30)
> +#define   EN7581_STAGE1_INT_STAT		BIT(29)
> +#define   EN7581_FILTER_INT_STAT_3		BIT(28)

[ ... ]

> +#define   EN7581_NOHOTINTSTS0			BIT(4)
> +/* Similar to COLD and HOT also these seems to be swapped in documentation */
> +#define   EN7581_LOFSINTSTS0			BIT(3) /* In documentation: BIT(2) */
> +#define   EN7581_HOFSINTSTS0			BIT(2) /* In documentation: BIT(3) */
> +/* It seems documentation have these swapped as the HW
> + * - Fire BIT(1) when lower than EN7581_COLD_THRE
> + * - Fire BIT(0) and BIT(5) when higher than EN7581_HOT2NORMAL_THRE or
> + *     EN7581_HOT_THRE
> + *
> + * To clear things, we swap the define but we keep them documented here.
> + */
> +#define   EN7581_CINTSTS0			BIT(1) /* In documentation: BIT(0) */
> +#define   EN7581_HINTSTS0			BIT(0) /* In documentation: BIT(1)*/
> +/* Monitor will take the bigger threshold between HOT2NORMAL and HOT
> + * and will fire both HOT2NORMAL and HOT interrupt when higher than the 2
> + *
> + * It has also been observed that not setting HOT2NORMAL makes the monitor
> + * treat COLD threshold as HOT2NORMAL.
> + */
> +#define EN7581_TEMPH2NTHRE			0x824
> +/* It seems HOT2NORMAL is actually NORMAL2HOT */
> +#define   EN7581_HOT2NORMAL_THRE		GENMASK(11, 0)
> +#define EN7581_TEMPHTHRE			0x828
> +#define   EN7581_HOT_THRE			GENMASK(11, 0)
> +/* Monitor will use this as HOT2NORMAL (fire interrupt when lower than...)*/
> +#define EN7581_TEMPCTHRE			0x82c
> +#define   EN7581_COLD_THRE			GENMASK(11, 0)
> +/* Also LOW and HIGH offset register are swapped */
> +#define EN7581_TEMPOFFSETL			0x830 /* In documentation: 0x834 */
> +#define   EN7581_LOW_OFFSET			GENMASK(11, 0)
> +#define EN7581_TEMPOFFSETH			0x834 /* In documentation: 0x830 */
> +#define   EN7581_HIGH_OFFSET			GENMASK(11, 0)
> +#define EN7581_TEMPMSRCTL0			0x838

[ ... ]





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

