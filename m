Return-Path: <linux-pm+bounces-21936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE41A320C1
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 09:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D1107A2383
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEC4204C1C;
	Wed, 12 Feb 2025 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="I1308Cii"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2CC1E9B3B
	for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348304; cv=none; b=N6I/kUzaqEHtdweiHL3I8getUUS4cqtCXLvPIZRI0pepVjutGcw+uLYQH8mYusVgNek828LwhCgHg9f5ocLPlv2iptsJnJ/Z8YgkYZC1JTs70WfEs0jSQIaYgJEEE55pTrTDw639CpzWVZPw2UXzYbMY0ZO5wUfMSJvN+bQwCkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348304; c=relaxed/simple;
	bh=pe1GAinqTXmMtWLyQJVPYf2smmZnVgMAETxekYxmBgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqkxTMstsuVwdeqVh+AaI7ddviBoEhJ3DZHPPMFEMcuqiWCEAQiMPKlVnE3FeJFo/62gjgiL/q4soRqHysvlQnaaLvKMbNi11rpk8JQosQ247JKMMOqbF4cpEegMSXjr/emcpIcQFnHeLdiGwF9kiZvs39Z1WVPEKrSYPtvi79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=I1308Cii; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5de3c29ebaeso7997419a12.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 00:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739348301; x=1739953101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUWX2C7v/npw1BHngSXdIYBv3kYifI6qQFt5lUSdhNY=;
        b=I1308CiiauivOZLl7wCUkbBwv7xmfnxCfMYEpciY7ws78/QoPsGiuedOVhZKHM4z3Z
         a7jtLEXUVLYTVALfyY9TIpf25LEuMUukYwBiA0AmH2zvynLgi0RYaTYjs2WjJpc34vEH
         alBObgjsd7OEBJ+oRAVL13NoSByqWeE3Ph9oDWDF5cqnZPfvPErq0NoSwHOdWXMSTj9p
         gmTQ7IWvJ4yn688PXLni2RK0gjsRVQ2QT8bQ9nqoLfoN4wEk30EBLTCYkv/Xdw/7+okB
         VIt3eZfW9UZ5DdQkCd4pBZCUz2qy+3nm65w3mqMYiISyvy8FPE//5IOvdI20DxAnNbkd
         VjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739348301; x=1739953101;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUWX2C7v/npw1BHngSXdIYBv3kYifI6qQFt5lUSdhNY=;
        b=W+ahE7c376BdFNmjDxQjydG7E3UPAivGR1X2FbLDymsAm4jlrnbBntl5aUU3Ac0XKz
         ol7y6vtFPyCyV4F9sFEgwlpfKbTsnX3PI1B6AjzPAFA02Dwp7JQHj5tQL3x8h3puv/1b
         xeUNqATm4oVdkP2tSNWF92t/0/CjbBWoZBjVpboAQRWjRcQ58btrznTH/J37NQk+SIpr
         kuH8I9s5Qqzh4LeMyRBPOCPODoR6xZqZey3Kd8E3gVAblXmaXXkeHCL2JH31m2EGLlq+
         aHMpy/OK65Kt/bKfCMOdENxhdK+GV20NlF0Gr/Xa8ljloU93zMT7Dmc2K5JXTH9W5s7B
         Lu7A==
X-Forwarded-Encrypted: i=1; AJvYcCVH8vSVwIr18tY1z8KjdxO9b0MFiHrE8YtXjrd+1ygKqqAEO4epkvUMwmqyuwJT6vDxSlCEDYdlzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqgvkMYG084PjfhP7YZuMoUCzbSh3wQE6d4EsdOVSgGYa3+OVK
	uQ2g7Hg2fqIKL6W7gTOjbmow9MUVxGrN/qk+x9ek6l20wI/pnAfqa1ymnIjjA/s=
X-Gm-Gg: ASbGncsjBxsR5Y7IgPf3Gw6QbtC7SNflnZsrBcqJlZbUGoj0BQwS9bhV2Y6Wqzi09wI
	OhcugQqko2wvoAOOgb0lhi8Ec5cGD6i7OfmH1BnzbzDmoXu7Fo2VWwhV4/co70sl3DfNmi8canX
	Gw2B1EAxlVDSO54UlA1Ht+/wSG233cYPzuOWZPRcRnqF5EbBs/f8wpf+BxL3XgreP2/uSW72qyr
	Vk34J16JAh+/KDGwb+b7F7+4FG0sqZ0FZ7EBkIUIDzSg86T1ndlGvhEBDwNrkHHAZgYZMIF6PC5
	NeISo0oxYMdD8e9x7G73chHp
X-Google-Smtp-Source: AGHT+IEwjSS+zOVDgDiChTpc71avmO2oV3vQhPuCatbzyoXLnyMKNa1d3LFoa9iHYB9Jc1QHZRsUnw==
X-Received: by 2002:a05:6402:1ed6:b0:5dc:8fcb:b224 with SMTP id 4fb4d7f45d1cf-5deadd829cbmr1660137a12.8.1739348301352;
        Wed, 12 Feb 2025 00:18:21 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de5a2fc79esm8071036a12.10.2025.02.12.00.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 00:18:20 -0800 (PST)
Message-ID: <9baea17b-fb8e-48a5-b12f-7eebee406ee6@tuxon.dev>
Date: Wed, 12 Feb 2025 10:18:19 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] dt-bindings: at91rm9260-rtt: add
 microchip,sama7d65-rtt
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
 <b437898b518910a2f94f7d827608db35e82c5828.1739221064.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <b437898b518910a2f94f7d827608db35e82c5828.1739221064.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10.02.2025 23:13, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 RTT compatible to DT bindings documentation.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml         | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> index a7f6c1d1a08ab..48a2e013a6b24 100644
> --- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> @@ -23,6 +23,9 @@ properties:
>                - microchip,sam9x60-rtt
>                - microchip,sam9x7-rtt
>            - const: atmel,at91sam9260-rtt
> +      - items:
> +          - const: microchip,sama7d65-rtt

Can't this be added in the above enum?

> +          - const: atmel,at91sam9260-rtt
>        - items:
>            - const: microchip,sama7g5-rtt
>            - const: microchip,sam9x60-rtt


