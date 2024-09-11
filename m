Return-Path: <linux-pm+bounces-13982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB632974A57
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA8B2868D1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 06:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901577DA87;
	Wed, 11 Sep 2024 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="q4bx29TG"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B3D1DA5E;
	Wed, 11 Sep 2024 06:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726035813; cv=none; b=ONhkGZ9SUO4xA/fZ7RFSLTdPdI7eKE7tqBNOB1lFhWdL/ewpYhXXsm/PcJu/Lmu3qZxb/bMZigb9rgbCykXiDG98jitkF3w06oqKa5yPPOEpHLGUYZesSWBLdoD/POqEgRljKIBnqkQX3CBBLYgQBiKFWbkRmWTDGW+dTYKPnoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726035813; c=relaxed/simple;
	bh=4wgafjl/GF7A9Wh1sZeg2hoiXJBXDO/q6k6MudD+87I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UbFUo+mHwkC619YlbDNuv5umHhlngpb8oU0r48/YT/SOe311RttgWYTy0KVLkCrZl3IhWUst/ibNt+Srw8T5G9nJwC7mubm0ga6yR+0sTLWXLJLyUgZnC1mjK/+bJjAuwVn96jfhUXjP43Ce3fcItMiOaULEAU3hN30zF5flZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=q4bx29TG; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [220.162.71.13])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 9DCEC78909;
	Wed, 11 Sep 2024 14:23:16 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 9DCEC78909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1726035798;
	bh=G6ZlhgSqLu1jIrj4ZJvMQOKzybekvd6XIOY3ry0RzrI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q4bx29TGnWLvZaZywL9HFJeY/ltajfcnMykw73XRyhlnBf4+sHCa7aFUr3rmDjGUB
	 WjKAwHBYa3FITUg2c364dnLwlTip/8o25Fy7swUc5BwzQRF+URpqpcRZ2Es/aP/837
	 n2PW5QHy83Ysm1FMrVoGxqVgAqytD+Gfl6yKUfUw=
Message-ID: <50537ca6-2324-4cbf-8036-a8c5cadd52be@classfun.cn>
Date: Wed, 11 Sep 2024 14:23:22 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Introduce Photonicat power management MCU driver
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux@roeck-us.net, wim@linux-watchdog.org
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
 <20240908093002.26317-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <20240908093002.26317-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/8 17:30, Chukun Pan wrote:
>> Initial support for the power management MCU in the Ariaboard Photonicat
>> This patch series depends on Add support for Ariaboard Photonicat RK3568 [1]
> 
> The official website says it's "Renesas RA2E1 cortex M23 ultra-low power MCU"
> Perhaps renaming the 'Photonicat MCU' to 'Renesas RA2E1 MCU' would be better?

Renesas RA2E1 is a MCU product line, and Ariaboard wrote firmware for this MCU.
Maybe "Renesas RA2E1 MCU in Photonicat" would be better?


Best regards,
Junhao

