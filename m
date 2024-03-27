Return-Path: <linux-pm+bounces-5537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A377E88F086
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 21:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF9E1B22780
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 20:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0031509BF;
	Wed, 27 Mar 2024 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUdwURHu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6591534FE;
	Wed, 27 Mar 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711573029; cv=none; b=Jxsx8mu6RFznhGtGTcT5uvpIzTNrIUThnfEjZspu/fX/3pBAhvV/UwvVbQuMRF/HarkMBnwrpHuuum+VsiRD3fkefJFO3LzB/31/6mTS1htt02s4z6go7Kvc7lVEDGMXP3hwK4cfU0gAa1dCcuYGP49CLf15bvHt4gFMqizVaM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711573029; c=relaxed/simple;
	bh=ASykyg23JcxT/XGhYWgv+/4msMSXbAY7lg2eIAUlMbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmRQc1KvsxJAldcrow+AMkISKiVsAvjx5EsDiIt4+WmVDu8WuBAemgiznUNCXXpkauESZRLZXa5nF7hkHJjrv3yDkV/CPycxWZw4EZgWM8BQjaPOgLRYV0AzGHR7th7Q3yW4gr9JkWsiWbfdWXKN7TMx/R+7/vcL564W8ojOvI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUdwURHu; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4e0a65f37bso35304866b.0;
        Wed, 27 Mar 2024 13:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711573026; x=1712177826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLxG9EcnVkh0DSQcXX7ogAec3EJe03+5XzYJOhrYVn4=;
        b=RUdwURHuYYRd8cFLiPzs2Pw4vvRAY2R9cFKuh37/qGg1FT7sS391aiotktgaS2qQj+
         kzx9V7FTmu8Ue2z2NcXhAOMf+TO4aOPISYl/Ot6tzpfmy0hjqgY9pzSzV9sjMllxhYQY
         aLCisQhWlXHAlSLsYf6wLn98kfmYklP/5X0wPyWDf5sm1p+j3/gL0hJw1pCN5vA7gyYC
         W+SjA0JRXKwj5zWKGVaHkfM7cFGin6PRyFpYXUj1JsjEO6gPtmyt2lHAWLXpsNcxR23P
         8FsQcSBzztU9f6NnhXVPlqqvyOOiO7LuorhvvOStRrm7Z15XN1Z6B2bphxADbmS1SBif
         QCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711573026; x=1712177826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLxG9EcnVkh0DSQcXX7ogAec3EJe03+5XzYJOhrYVn4=;
        b=rjInKsWlKFighuKtoHXRjPPDqpRDvDo1PlrPxTU3C9OKLFUCdqMELZOQUd6sOpLBiF
         F7on4FulRWnru/U/1I+8vhqjCm41Oit03TfdWMjr6Q3Al0nYzYWdg8aWCootvuIvDkae
         ffgeA6KohIMnOmj3tFEXs12dZpAzRLmlBa8hWOstwNsTJzdrzqGj6Z8Yj+XkflWdgFwO
         B8v29UdlfkAEEZiGWMPr828i/9mE6e6oXXeH63sOvu+Dvmk4ESRqeA1GCA5JoK0LDqou
         dcSK0vrK+9NPuJ/VaLVV0/J92sj4qig7Epj+UKOT81jqckx6lQowEksVhzVSYRPrYylI
         jQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDCgl+iQNLGnk5L5F53Q37oVGqPYzjlHznwr1cOnglR5u1HX1oAVQwmm5apMHLo0tOdwfWcuj4Zd3CY7jxzypSOdqQkzKnY5oEgA==
X-Gm-Message-State: AOJu0YweZpFaA3zfRjr7e5kxwo8LOmbZo90V4T56qDOm9rTv9ofLrkse
	olZe/Yxg/C0hNzTP9+2G9yzl1S/67t+bz28X2eMA0d0tveXSBVmX
X-Google-Smtp-Source: AGHT+IEgamyfp26jk5puLJyAWoiz0SiekS9aAN+NI95EWS6Ohw6UAKgRKR/78XIAsNl9tlEJTNqMsg==
X-Received: by 2002:a17:906:c4c:b0:a4d:f7ca:1856 with SMTP id t12-20020a1709060c4c00b00a4df7ca1856mr381084ejf.61.1711573026016;
        Wed, 27 Mar 2024 13:57:06 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id hg11-20020a1709072ccb00b00a4e03823107sm1231928ejc.210.2024.03.27.13.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:57:05 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Brandon Cheo Fusi <fusibrandon13@gmail.com>,
 Martin Botka <martin.botka@somainline.org>,
 Martin Botka <martin.botka1@gmail.com>,
 Chris Morgan <macroalpha82@gmail.com>, Ryan Walklin <ryan@testtoast.com>
Subject:
 Re: [PATCH v3 2/8] cpufreq: dt-platdev: Blocklist Allwinner H616/618 SoCs
Date: Wed, 27 Mar 2024 21:57:04 +0100
Message-ID: <4334338.ejJDZkT8p0@jernej-laptop>
In-Reply-To: <20240326114743.712167-3-andre.przywara@arm.com>
References:
 <20240326114743.712167-1-andre.przywara@arm.com>
 <20240326114743.712167-3-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne torek, 26. marec 2024 ob 12:47:37 CET je Andre Przywara napisal(a):
> From: Martin Botka <martin.botka@somainline.org>
> 
> The AllWinner H616 SoC will use the (extended) H6 OPP driver, so add
> them to the cpufreq-dt blocklist, to not create the device twice.
> This also affects the closely related sibling SoCs H618 and H700.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index b993a498084bc..86d8baa816795 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -104,6 +104,9 @@ static const struct of_device_id allowlist[] __initconst = {
>   */
>  static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "allwinner,sun50i-h6", },
> +	{ .compatible = "allwinner,sun50i-h616", },
> +	{ .compatible = "allwinner,sun50i-h618", },
> +	{ .compatible = "allwinner,sun50i-h700", },
>  
>  	{ .compatible = "apple,arm-platform", },
>  
> 





