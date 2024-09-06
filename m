Return-Path: <linux-pm+bounces-13785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAAC96F132
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 12:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945A7287741
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 10:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710981C9EA1;
	Fri,  6 Sep 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="cQyXlKQC"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A526E1459FA;
	Fri,  6 Sep 2024 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617968; cv=none; b=SFWVUeUCeH8WyRtqeqP4jCvfjocDOG0BOtXAp4H2mnqkNbgXqLO+bccTtY+NG7iWc3Jcci5Gy6QbeyHQAPTY0lOA+OW/HsuzlykYtnTvd0Mq+ml0jpPMZBAsqoIjWg0moJoYmp4vWakH/TXWn/aQsJzcDUeWLNka2hwnF7ASLB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617968; c=relaxed/simple;
	bh=3mnakEJhvKvzaNYAVTW+Hy8tcDEqJ+EPB4nH3YjGGLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=JNdgI6HyrBKP9gfWPpvhQL9/F9sD2m0EcFZj+VoVMivPTL5r/mso06JSxYMvKhLUPaYDTRuEr1NktA11eT6TwLLjXRwGVTcubsQzYQx4FW5VrIeyCS7uoXO5N2q9ooHRsUFQeqwu0pgAvVav6SditAzlS4vkSqR48woHhsXEytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=cQyXlKQC; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 78FA978A00;
	Fri,  6 Sep 2024 18:19:22 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 78FA978A00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725617963;
	bh=MykDBDEeSXpiJA/5ml7RMoyTFs9rXLaVXhQuD4WYiVg=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=cQyXlKQC3OmuDWiWxy79rw8XDWBm0hiZGJhWiYPm56DG/s/tIat4GeKALjOw9cD/v
	 OU3M/kMBbns+SNGDf7AeLEAD5FCHXxBIg/3UcjztCNhTj9TnB5YqBOadDKnDjLDvz8
	 8DGI3tMAoZYYh5aYd8V+TWF2bNAYFXewSVkxM3V8=
Message-ID: <3094e728-f9b0-46b9-8aaa-e8a1d8b55252@classfun.cn>
Date: Fri, 6 Sep 2024 18:20:49 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Introduce Photonicat power management MCU driver
To: Krzysztof Kozlowski <krzk@kernel.org>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
 <155940e4-d209-401f-af03-b32b57e5f7b2@kernel.org>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley,"
 <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Heiko Stuebner <heiko@sntech.de>,
 Chukun Pan <amadeus@jmu.edu.cn>, Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <155940e4-d209-401f-af03-b32b57e5f7b2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/6 17:45, Krzysztof Kozlowski wrote:
> On 06/09/2024 11:36, Junhao Xie wrote:
>> Initial support for the power management MCU in the Ariaboard Photonicat
>> This patch series depends on Add support for Ariaboard Photonicat RK3568 [1]
> 
> How it depends? This prevents merging. You must decouple the patchsets.
> 
> 
> 
> Best regards,
> Krzysztof
> 

Thanks for your correction, I will decouple the patchsets.

Dependencies:
 * "dt-bindings: Add documentation for Photonicat PMU" [1]
   depends on "dt-bindings: vendor-prefixes: Add prefix for Ariaboard" [2],
   which requires this vendor prefix.

 * "arm64: dts: rockchip: add Photonicat PMU support for Ariaboard Photonicat" [3]
   add nodes based on "arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568" [4]

[1] https://lore.kernel.org/all/20240906093630.2428329-9-bigfoot@classfun.cn/
[2] https://lore.kernel.org/all/20240906045706.1004813-2-bigfoot@classfun.cn/
[3] https://lore.kernel.org/all/20240906093630.2428329-10-bigfoot@classfun.cn/
[4] https://lore.kernel.org/all/20240906045706.1004813-4-bigfoot@classfun.cn/

Best regards,
Junhao

