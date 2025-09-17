Return-Path: <linux-pm+bounces-34898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882F6B81153
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 18:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48FF17F8AB
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 16:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE5D2FB08C;
	Wed, 17 Sep 2025 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="lwLe+kEw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061922FA0F0
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127873; cv=none; b=dY9bAd7yonuz/GjTvJAf0HEugnF5T0+WoGgU2jFHbRil+uTuAg4f8x+nlb+1vwf6cOVBnJ0va8ggjgmSEbjVduKsMP23OzvcJnDkTCEaYW9geIo/kvki5FSbMi9L6YEPnoOT1UnXBCdW+eGLvBi4vzu1SPWmrpjYn9F7bWQgO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127873; c=relaxed/simple;
	bh=gwDqeO9pTlUdpXA9Yz5i6ic6vnRjW6m7pH/Sogrghyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cY0eofSJEFVHuWQNYBGQHd/lrUJSljIGXheyWK7urXbGbm5Gu1JThusmB/bOPaNno+w+KF/ASuhnzRIv+w0l/z44kO1dj0QBvybrMKOF3UdeLX8gJUKK4uWJpXLs1LrAL6dPMyhvbCC7qqqzossF2VyLC7/yqourMZPDqXW1Dh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=lwLe+kEw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so67815e9.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758127868; x=1758732668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZNcucLNP4mR46I0TWwPFtv0PUd9VAWxLOjNJ+Jrcyo=;
        b=lwLe+kEw9UJ+bGa96NfYgUtD61zui7E11GrMzUvFnicHQAA2n8YmEpr9ayWoIXvSzy
         12+PFUJJVdZOUirqmBhaLOCOXjbxrxTZ14L7btrj4LntTIPQujH/hthVQivA3bs0JDem
         KXJvqE4/tzWF6CkQXOW6o/92QxtdwN6vx1wsLvRzoqOnkUVGA5OEZR4bturRK4AR3vdm
         uUgqFTkcS6sFy6IIL2/MyIuDAMeb3h9gPxLkgQmEFvX5S78C8P8dlb+ntIg6nN5D5x56
         zWdFYsMYDghW9bqNiw3BpkVfBR5yuPdOw8RLW73HSaOpUSeR9uzbgXebpILellfVWBeO
         ddbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758127868; x=1758732668;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZNcucLNP4mR46I0TWwPFtv0PUd9VAWxLOjNJ+Jrcyo=;
        b=WLydPaL6bvxLZXDTm4/WweuEtTqHCNW743crTYNRoEJCR3ESqFXhVJK6Nbryho/pTS
         KslDSUFygQtrrMk5Km6ztswpnLfDKI6u9WZkrb6l0n2rf55pgLJ3vcuSyM9wlVSa1E7t
         AN/FSCJCZgGWx8DpiowHFtO8DdG3chH+a5ywvG/4pL4JWPLyM1CL5dtq/0SdV/nD0UF1
         FF2cM2kb1zdlqBOSHKbye0DKC1LkDu0Ju0JzR0N/ghhZIpXOFsbea4x41dDluQ6SAm0v
         Tt+zbkGUnfVdv0z0IkiDFN+pf/A+YvmkeIo8WZ2CP1izqARwc8hZLQqJywXt3bkecgJC
         fmBQ==
X-Gm-Message-State: AOJu0Yz7SE8l1fh+74Qi5uJ71gCsWqiaoJFhrxew8qWwM+kUVTowGJ5N
	LatDn4hOT1K/n4n2THBcRy2DfBMELKFlX+wK6nNMxDA2I9asUMwl0vg2LE5MGNlYT1Y=
X-Gm-Gg: ASbGncvnOhmAOQbHZVittAroIPYsNxJiRlzxGHBjHlPRf5UZyquoGtYwtTF92UHjqsa
	/5xlvWfXC6ph3dRz8l8GnHvZ/iDKTXyDqmKPhwIwDsrzQeKAa61j2MP3hwUb6M2Rci2tjKFsJzA
	6cudHl5e/FefGGPih/QuWyho1mKTQaBJczomup6x6I2UMMAKvkgcp+mjs4aZdMtfpleBxjENwaA
	Lg5kAGTcbAwB65W651qeXYY+9IRMWjW6hUFJjT6o0aMlEStyTvogzMqMHRv+OeS6h0qGZjTudbY
	ayBsHWyUy24Yxe2WHfJVv+pxycRWDM1brpPnG8pKlh7yY8QJ2AOO/a2f7RWxwRDFWfi3+u536nn
	NEft3fO1QuPDKTmK65q+pTRYJ4qdtRK0=
X-Google-Smtp-Source: AGHT+IF1nrUouqCOeE6wDOtkdHMD2AWyWimjxHxsQ94F2pzaPGFfHQDSxdsvbeXDPczFHDXsujKBhw==
X-Received: by 2002:a05:600c:3587:b0:45d:e285:c4c6 with SMTP id 5b1f17b1804b1-46207a83da5mr28634175e9.37.1758127868023;
        Wed, 17 Sep 2025 09:51:08 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07411f4dsm64874f8f.26.2025.09.17.09.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 09:51:07 -0700 (PDT)
Message-ID: <a59d7be5-f767-4ce5-9a88-5a9b340c6643@tuxon.dev>
Date: Wed, 17 Sep 2025 19:51:06 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ARM: at91: PM: implement selection of LPM
To: Ryan.Wanner@microchip.com, sre@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux@armlinux.org.uk
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>
References: <cover.1758051358.git.Ryan.Wanner@microchip.com>
 <98b7e9347fd15e45e2606d0e89f09095887079fc.1758051358.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <98b7e9347fd15e45e2606d0e89f09095887079fc.1758051358.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/16/25 22:50, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> The LPM shutdown controller output could signal the transition to PM
> state for different devices connected on board. On different boards
> LPM could be connected to different devices (e.g. on SAMA7G5-EK REV4
> the LPM is connected to on main crystal oscillator, KSZ8081 PHY and
> to MCP16502 PMIC). Toggling LPM on BSR PM mode is done unconditionally
> and it helps PMIC to transition to a power saving mode. Toggling LPM
> on ULP0 and ULP1 should be done conditionally based on user defined
> wakeup sources, available wakeup source for PM mode and connections to
> SHDWC's LPM pin. On ULP0 any device could act as wakeup sources. On ULP1
> only some of the on SoC controllers could act as wakeup sources. For this
> the architecture specific PM code parses board specific LPM devices,
> check them against possible wakeup source (in case of ULP1) and tells
> assembly code to act properly on SHDWC's LPM pin.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> [ryan.wanner@microchip.com: Fixed conflicts when applying.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

