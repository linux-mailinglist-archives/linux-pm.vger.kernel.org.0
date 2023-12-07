Return-Path: <linux-pm+bounces-805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA04280913A
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 20:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636232814E1
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 19:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4364F616;
	Thu,  7 Dec 2023 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1BBzRfm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33BF10DE
	for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2023 11:25:38 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9efa1ab7fso14924181fa.0
        for <linux-pm@vger.kernel.org>; Thu, 07 Dec 2023 11:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701977137; x=1702581937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUDn/j69FGh+Nko+qtqx4etAJxz91ofxqPcpkro2SJw=;
        b=X1BBzRfmwFLt6jQtwOvMSrfl03DJDDkT3cVsJ+2HDahjYn6npzFj7uq114WuRbLCWm
         7gBH/Va1dRFOP7S+XbW1SyfwBq02x1Uwsw/k21Dap3UpAF3E4AQeCfBGexabIXUE5zDf
         /T/5sSfvXuz8kZ79gkrngl1qZdMWsJwK7YAH0E6ddzAOJaHVzPvBNpfht48BMgbD14c2
         K6FeXg4zKGFeMW6PAZqg2V+EeySzav3LaVJaS19DozY6V3WDlvgzZ+cQEFkU1UAqz5b8
         vDlA1ItHvvcW85ez9cSxRYuWIRc3qSWTCz67NG3YqB3fqKH7c1eIpB//uVH5j9m4LzE/
         R2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701977137; x=1702581937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUDn/j69FGh+Nko+qtqx4etAJxz91ofxqPcpkro2SJw=;
        b=Hde7MQil1gvZJPK/OfYDgwStIuIG274fEP0LOWvHWEZT0d/xFR4aC+hA1uviqU8RRG
         d2/hGOK+svKUGj1GlpNfh4Kum1z0NJnWK1TmjRjqrz2SGpsxEJzcpkaOCpwjwx/jfwvc
         PrPUT8GWlBoX9GZehqdXT8kOe5wrBX6nUnFIRomanYtf7FISj7Uae94JPBNfwrZdY9qI
         aFQGJSK8/bLnFYF3rQT4eUxLqtTm+Q/CfEdfqVQ1OtFF0Hs8GyADyCQqaSFF/xrHsGab
         q7senqysxOlVRU4+xP3DP3aJd/YbAQHafHqiuLGZuKsZhFr1CV1hyE9kObxvel2M4j25
         xvTw==
X-Gm-Message-State: AOJu0YxzYKYXePSZ24ablDsTF9Vf+tX84JIu5vU7y3OTX5DhW8OvUsLX
	Usu1X8PSyXA6eJDBATVjvf36tg==
X-Google-Smtp-Source: AGHT+IEp6nkb7rKd6lVkK3sBTYQmEK9KmGCayssO0/HB+is7lA3ZTjG8bz5353dtDuDlplr1n1Xggw==
X-Received: by 2002:a05:651c:1030:b0:2ca:bcb:e798 with SMTP id w16-20020a05651c103000b002ca0bcbe798mr928338ljm.157.1701977136856;
        Thu, 07 Dec 2023 11:25:36 -0800 (PST)
Received: from [172.30.205.181] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a11-20020a05651c010b00b002ca0a5dc73csm24380ljb.9.2023.12.07.11.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:25:36 -0800 (PST)
Message-ID: <c7b5677b-9f76-435c-bc79-00012be295e9@linaro.org>
Date: Thu, 7 Dec 2023 20:25:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: acer-aspire1: Add embedded
 controller
Content-Language: en-US
To: Nikita Travkin <nikita@trvn.ru>, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20231207-aspire1-ec-v1-0-ba9e1c227007@trvn.ru>
 <20231207-aspire1-ec-v1-3-ba9e1c227007@trvn.ru>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231207-aspire1-ec-v1-3-ba9e1c227007@trvn.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/7/23 12:20, Nikita Travkin wrote:
> The laptop contains an embedded controller that provides a set of
> features:
> 
> - Battery and charger monitoring
> - USB Type-C DP alt mode HPD monitoring
> - Lid status detection
> - Small amount of keyboard configuration*
> 
> [*] The keyboard is handled by the same EC but it has a dedicated i2c
> bus and is already enabled. This port only provides fn key behavior
> configuration.
> 
> Add the EC to the device tree and describe the relationship between the
> EC-managed type-c port and the SoC DisplayPort.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
lgtm but I'll wait for bindings to settle so that the computer can
say it's happy as well

Konrad

