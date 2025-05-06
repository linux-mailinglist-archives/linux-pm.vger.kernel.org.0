Return-Path: <linux-pm+bounces-26738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE989AAC62C
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 15:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173D54A310A
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 13:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F71280CD5;
	Tue,  6 May 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkY85565"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3727AC41;
	Tue,  6 May 2025 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537785; cv=none; b=S7LbWxnUOZTCjgD6Nw5A7w4gIGVrZh7YZQGAXag17+JG2095LvEayhvSHYPMu15GuqhY3c1chmXQnZuXfkWnLoS/IISwEah35hnhBn0cD8fXqaq823snN8TwkVFlImo7ZHOo7A7OUf8UWZIejonltBZdTeXJKUPac6hV/PF9nRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537785; c=relaxed/simple;
	bh=SdTbQRmvxVkDHJ0Zmj3+GRgE9uEvKkYZ4qhq+hZjXfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bb+oRr5vC4PV+yfctuQTlmX4fddFc/76uCWMk1pOKcfwl//Gw9hM9mMzGBPEkW9yFLmsq1Qm8ArsUullQsWu1tqrRZTLqHXsMw+RDv0oTbOUF/yRfZ3iqsXcJGnUCtBYMIfbE3QumyTD23TJf/NX212CSDvugt7ImS/F67PeiJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkY85565; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso972673766b.3;
        Tue, 06 May 2025 06:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746537781; x=1747142581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ychOGS0fwVtT0GZZg8j7lVAB5ILds60YZKRJT8XDlKg=;
        b=nkY85565eoc04yRbeWzquGhf9hVs65ZDUnSKzAlrHzhQ6HvEFWYcG2ooEQk3ra+P7s
         ftU9CG9THchi7yCkIWO6m2YYJuv0XqQScoLHtnE6S/1IHNwI6hbNMjjzUnztaY/03eE0
         Oi24PKaiGEzsByQexXuOcOQeit0Jp4T7Jw/dNy3O8QhsECswWtU7zoMHVoEupqLTaEky
         ovm9qB4a6ZjOBwrde7NCVqmiG6ug+zRRC0XP4vd/CPZGvVmlUxhgzILP1YrHHY+x863u
         Wu17oJABnLQR5KRwdhcKM8fZRl78OHw4HhSEJ18TpJs79FYHZEfOfnDH+8CV7ms2AKET
         R0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746537781; x=1747142581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ychOGS0fwVtT0GZZg8j7lVAB5ILds60YZKRJT8XDlKg=;
        b=NcK8z2V4H551OzB+h486/BGlmxratAkL5LxDUXoOgsuId2USU6b+o1k4hIsDtb+xD0
         lq1FCI/yWTcFkqaclMXspkzDHgvHDR/FhHFF0N1BEn7bs4o+su28DUAZ9GcPH6EP6nRz
         iHbvemJJA9BhcxXuBADtUItBY1unXkDtg3bUMo11RXQVKc8EXbJI0XfcNmwZ4hwUf0CX
         fEzNjwlNFKpLmqzwWC/XyHFzSscS7N8CVwkfEeQiUwI7oBwh//O7SY3QUL/BZI2IUiL8
         NK2whkX76hLWQlviZ+bIfSWkx/bNdi01HKn7qHyzz81QuqXBRpxpJTvNxwYm0WYNouTi
         FZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXieyDaNm6vPs7ppA6le+3s5keS3dgSUtHkFVLddV8ujItk+895vTABA/yqJaQEldExlpqGrsHER2syfj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygrqUVEztZ6rCQlUuswATPd7ea59jw5E+wsvTS7tD4znx9hkvP
	lfnb9avpImVn/uaqws151EL7PD0S34KIfQnfKubJ3vRayv/Vu+FY
X-Gm-Gg: ASbGncuyY9gx9vuFQIaNkg80rFNyIa6ekPgFLOtGs3a5k6RBnE9yuVosdC9OwiYW2YO
	IFAKhlmOlyZx92USyr5mvMQmRhP/S179P/Abohkr8nGTKP7rVJX5ywWmu8X4DQbK/2W0Po2jXQC
	p2gRIPfqQZZLnaO7FgIZGniqFSAj1L98LK6fwrHDTKl49OG3VSlByB41+tedpBSiIWekYxeZq0t
	7Bfq0B9BhgI/O/OSQcw9M/SUrSjhj3w7NXcqf+LrqEWkAEAEvv+qrJlp7jQJH8sts+jC869EsZl
	GkhRXYyaHq3ZoCNxvbFDXJDPFMQror573DJk7V1Al7KgxVMs59D4em2RDsTxTC2uwa/OQ8u9G/m
	mJQRTP4sQySGgWKF/lQiRZGvDb0+nvBt5WNc=
X-Google-Smtp-Source: AGHT+IG+BsbWupjoQzskKZOgAx9L65nh+d6RPW44BjEcFwPpA/8TXeD1ngr7i7XpwoAfFBy+3NeFmw==
X-Received: by 2002:a17:906:7952:b0:aca:c38d:fef0 with SMTP id a640c23a62f3a-ad17b249c58mr1412115266b.0.1746537781283;
        Tue, 06 May 2025 06:23:01 -0700 (PDT)
Received: from [10.0.0.176] (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189147431sm705332566b.8.2025.05.06.06.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 06:23:00 -0700 (PDT)
Message-ID: <091539c4-8ed1-46a4-aab5-8eb0e62a9027@gmail.com>
Date: Tue, 6 May 2025 15:23:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: reset: POWER_RESET_TORADEX_EC should depend on
 ARCH_MXC
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Sebastian Reichel <sre@kernel.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1ef0beb1e09bf914650f9f9885a33af06772540d.1746536287.git.geert+renesas@glider.be>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <1ef0beb1e09bf914650f9f9885a33af06772540d.1746536287.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/05/2025 15:01, Geert Uytterhoeven wrote:
> The Toradex Embedded Controller is currently only present on Toradex
> SMARC iMX8MP and iMX95 SoMs.  Hence add a dependency on ARCH_MXC, to
> prevent asking the user about this driver when configuring a kernel
> without NXP i.MX SoC family support.
> 
> Fixes: 18672fe12367ed44 ("power: reset: add Toradex Embedded Controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/power/reset/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 5ce402ff71964f59..1a17c5192818de1e 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -218,6 +218,7 @@ config POWER_RESET_ST
>  
>  config POWER_RESET_TORADEX_EC
>  	tristate "Toradex Embedded Controller power-off and reset driver"
> +	depends on ARCH_MXC || COMPILE_TEST
>  	depends on I2C
>  	select REGMAP_I2C
>  	help

The default is 'N', and the EC is just an I2C device, unrelated to ARCH_MXC.
Is it really annoying if the user is asked about this driver during
configuration? Or is it just normal?
Wouldn't there be a better way to handle this?

