Return-Path: <linux-pm+bounces-38994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F26C987A7
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 18:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C2E64E4469
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 17:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE25B36D514;
	Mon,  1 Dec 2025 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Npow+MGS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5185333769B
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609364; cv=none; b=Ka8QoL470U8p0eW8UgFjyMJMDT1hRTeAG8a8WwYUI86Kgxm3gIll9vbzXi8XX/Dmc8QtR2yf2OfeIxZf7/2Tgya5f3zYwT6GgTQJvnMdnnLhJF1u0U7VqgAzXkJzEt4w8Na9hz6J3ikzaJbYCdXMmwuKvwD5sro0NMjS/6UWi5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609364; c=relaxed/simple;
	bh=HH/YjoTJvK+HycLUz2tbwGdJb1nNegFYrobhQ9Ypw8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dv/QK7cLqXe0kDdWmjDxfW5spLKE8q+dZjWM9ktSX/L59lqLGU7VM2VFTe/S/86rcIC9bWq7zJ21GAKqU6jyr/SqDKujl8eGXxgEucnLrdabki4B4QfSOkjn2sNd0IBFlF/mlKajP44WnYHWreNg7pqqrTK+oqX5t/OzXAPOE4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Npow+MGS; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-657a6028fbbso1710112eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 09:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764609357; x=1765214157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mXBvbePBmN0aGW+rjYL5kzNiYaDe50sZg3kuC1eECMg=;
        b=Npow+MGScSa9PmoCppCBKLkH/lvjtJcb6awX9aPoo0MtWh2u5ueZl/upHY6tPLROi5
         EW73g+TiACBOJ+6zy3qphgzGuN5GmxU+PFQrjTy1JxwXANnbrwdp5plkDZDTUHuv0JEr
         /OhNtkJdZQ2tjwgdau6y7JHlSn3T1eYWvaUdRrCjFeRqk2rWcjfNRY7xp9O58g1TKOs7
         TENNcDQyxVmuY8UZ9RorIWWD6IcDvaEP5x9IAtzciD9xU7ComNVSJfHGYv2lHYq0m5Mp
         C373JHEbOJ7pFsoWM7r6gp+mCteyyMrpi4dKE1LEy4ThHi502gBLwkQ2Pjs+1wi4HnJv
         zC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764609357; x=1765214157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXBvbePBmN0aGW+rjYL5kzNiYaDe50sZg3kuC1eECMg=;
        b=Y9cyeCTYV54oeB2K9gAzFGDMo6t3qZPNXBLFF4OAWnqAjbhds6jtakfTr5S0RKplT2
         tJMou+NsrC3bONO5Os9uOJTfAF37fLBKK6Dr6PEmxPiNkPkGFfHH947WrxeQi8NWuLf5
         P0pwFxt40IPKp3QUpZXQEHOuPAC/3xc4AmYfBLuIGudUqDI0yMe+O5nafrD3DVszMjvh
         rgZkTQdKLIWzSK3uMb+nh8Z2eiDteWLWYqohIW2k6j2B8tY0MJOlRuUyw3syUHlma+if
         IvI4woicdjeCQY71AHpeAwGtexCpfpqfvPy8aYv5mDML6SBYFUvk+aj6bI1/qVavHaWz
         wfWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqtb+H0IN20eMPOgq16xiu2O31zK0HUQ0UnrGOVjGGTuOsLBkCTAS5BqH0OJVvVTBERZUrNoyLbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx42yvh3/02p7KGBmpthmSnz1sYBOhAHPCjRBzkdsYV3AbgM/K+
	e36fGTXOhcX6FOtTXWGTehbwLSJVF/YrpIhNz1U/0xjecuZ0TqdlYFkMNhdb8HOXDmg=
X-Gm-Gg: ASbGncv+zKXNojX6bu19rE8MO1oR/VPxpkjcqHG51nPIoL7/eqYORp/TS9vRbV0IQJD
	L0GOH623Cs349M2uawGaLDbek/+797q3yGB0Rb2XVw1HFaQ3y+hl4FT18GeYBo/fh4psQBOZ/kv
	LlROtmX+V3Tor/KnineQnWpwpvAfDc+/O1O5IfygNMmdJysgZLd6rjG3pog1EZM7mzcJgca4xhA
	t07TUmqfmtC9AQORH+dws3DTVNuU1mqeUmr7soxiqDPXmcCCQJrVijbvTMBOOmp0r3hUzVOXjiV
	AnH15fqR9hTfK0ph5b2NIoWr+5ZweJqmnaT0V9WRCtLpqOJdjqMWGt7Uvu/cYs7k6TEycY0qn2L
	p2q2qA99BMSLRO7Tf/r/X1Ad7UWH7zZZzvziUWBEM7NugStpS0UvIK25oQAiRaGWPBoSSqpjKmn
	Nr0Kku/B5HuYTn+igkkqzzSNTl8XLf4pE9GpXwuKmZEp6j2+oFOxcjCxKJAg==
X-Google-Smtp-Source: AGHT+IFhXzu7oIvN//K+0gQ9fSmHlhexzrACWF7hMjJsE/gYpW4bjA3882odDNc+t9DkOzPtuw0t9A==
X-Received: by 2002:a05:6808:1790:b0:450:65dc:1fce with SMTP id 5614622812f47-4514e5f84ddmr11527679b6e.3.1764609356945;
        Mon, 01 Dec 2025 09:15:56 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:b67b:16c:f7ae:4908? ([2600:8803:e7e4:500:b67b:16c:f7ae:4908])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-453169b2a51sm3922009b6e.4.2025.12.01.09.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 09:15:56 -0800 (PST)
Message-ID: <78240755-44dc-4835-aca5-99540cca0304@baylibre.com>
Date: Mon, 1 Dec 2025 11:15:54 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: inkern: Use namespaced exports
To: Romain Gantois <romain.gantois@bootlin.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Guenter Roeck <linux@roeck-us.net>,
 Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>, Kevin Tsai
 <ktsai@capellamicro.com>, Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Hans de Goede <hansg@kernel.org>,
 Support Opensource <support.opensource@diasemi.com>,
 Paul Cercueil <paul@crapouillou.net>, Iskren Chernev <me@iskren.info>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matheus Castello <matheus@castello.eng.br>,
 Saravanan Sekar <sravanhome@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Casey Connolly <casey.connolly@linaro.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20251201-iio-inkern-use-namespaced-exports-v1-1-da1935f70243@bootlin.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251201-iio-inkern-use-namespaced-exports-v1-1-da1935f70243@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 4:59 AM, Romain Gantois wrote:
> Use namespaced exports for IIO consumer API functions.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---

...

> diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
> index a8198ba4f98a..33d6692f46fe 100644
> --- a/drivers/iio/dac/ds4424.c
> +++ b/drivers/iio/dac/ds4424.c
> @@ -14,7 +14,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/driver.h>
>  #include <linux/iio/machine.h>
> -#include <linux/iio/consumer.h>

Unrelated change?

>  
>  #define DS4422_MAX_DAC_CHANNELS		2
>  #define DS4424_MAX_DAC_CHANNELS		4
> @@ -321,3 +320,4 @@ MODULE_AUTHOR("Ismail H. Kose <ismail.kose@maximintegrated.com>");
>  MODULE_AUTHOR("Vishal Sood <vishal.sood@maximintegrated.com>");
>  MODULE_AUTHOR("David Jung <david.jung@maximintegrated.com>");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS("IIO_CONSUMER");
Is this actually needed if we don't use anything from consumer.h?

