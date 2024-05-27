Return-Path: <linux-pm+bounces-8133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADDB8CF99A
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 08:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7BC1C20F32
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 06:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DF5134B0;
	Mon, 27 May 2024 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nygGisJo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A532D17BCA
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716792964; cv=none; b=rJFw5nA9r9uLvfGTZj2wqcFXZyQxcMbgMsFpqTWnZ2v8MRCJ9/6HivpLiQ5idnVwfm5whU1Io7S9nvdR3Tpl46SqIOnvUAO3oLK9N//dy0tE1FUTIKABU9Akg418KBd1gbIy6TeHfLv3r3PoNAbEC/U3OkWCj0jI0AHPVaWmyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716792964; c=relaxed/simple;
	bh=61H+vlKkZBEfdQTaQTfeY9m5+DEAKkGHLIuZYqlPlPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=su0eJki+ZnvTuD67SscplEuS6ZdbB6hQOHnjumffXWc2wlU42Sb+HMY3daSWVw15S/HkLjOFyg+e96iyEnrxYs9xm0Cq4Fz7YZhoM1jS5mSBNZ0AgXh4jL9/8Ip77AT4Yu/xR6STURFJHgA1Ahq35Qh20eDe9qchcTDbklaQcOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nygGisJo; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-578517cab9eso3295270a12.2
        for <linux-pm@vger.kernel.org>; Sun, 26 May 2024 23:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716792961; x=1717397761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=etkOs+jLo9IMGYwxyaUB61TS4Whlbe7itmHxGWKZyYc=;
        b=nygGisJoa+oPJ4M6ehM4KbpLbs0MvbQgfY/18eo0SyoRXQITKSfzmVHQd/4zb6U6cG
         VZYw0IQ1WRLh9n/NscVE/gfmJolM34q4nlAk5Pxlk6nRpqIIkLtSwpzsNE+XFQhqa6nj
         48AjHNbNRBE/L8i+rl3etjqtIBdJlPlXyB83mpryaIQD+RMRCKgjxsoU6Qj6gwY2rLcv
         7JFvIucnRHD2niLHBijmbPGDyvaJgBzLx4dz2z8mnr2aeYVUYKueWe4l4VavfvogVF+H
         G4ZSeGGi6tThPEH+lYCk2gCqjs9ELCbN/Wx3TM78LIu37MKgZS89Y6rIkoV9qHiJaUyf
         NG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716792961; x=1717397761;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etkOs+jLo9IMGYwxyaUB61TS4Whlbe7itmHxGWKZyYc=;
        b=Go5dJtj/Ye0s1QXvx4/liiUJi/TREWYEfHUALWlFXZQfWKqmMk16ePnx3HIhxabJCG
         xzFQ146ZtimtQfslyYNojZ/AQKiaj6zUh1cifgLvt80rpmIo39qmHx/kBuWdQdCDwCaF
         yLvWuZuFDbCd+YQWzqBBe8BXwXa/uG/1HGj0T9gNshkKlRZ1DiLvp7xD1WH+umMntq6j
         jeZVnP656zh7eHQuH2/354oWFAiE1X/HTIpKUgol/ouRg0rw22Qe4XduTceaeSrHXUD0
         KG8gx6Q6IBK84QIZBpXI16GRjylm2YRmov2HATr0yX9tcPy62Ml4YnaLGwkVBoJ49muZ
         aY8g==
X-Forwarded-Encrypted: i=1; AJvYcCWdLkWsuXOvelPzHQS6BrVhvZLGC4cz/mqNuP1N7kw/cBF6Dd5H/wK+sn5HjkXShIz7/8FK+EsSnMizwsowmgBkrtZIXokB9q0=
X-Gm-Message-State: AOJu0YxWdOpVoLyCdEumyqPhwWC9F5UpnpMVhvlYoUSd6qKAVgGv0j8r
	osM0UvO7XkorhpoSu69uLyNK/2X52zjPYIlvFVLjVDRNg7b8U61OLTJ82g7RSHA=
X-Google-Smtp-Source: AGHT+IEF1T16EqVwdVzeLJAbMgIiLuIr9wyvpSiUxanNtjQeD6NNm5m86Em0jKlY/9Gc5EL/QFJDBA==
X-Received: by 2002:a50:9305:0:b0:56f:e75b:839a with SMTP id 4fb4d7f45d1cf-57851970dedmr5410157a12.1.1716792961009;
        Sun, 26 May 2024 23:56:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d5e3f995sm806996a12.64.2024.05.26.23.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 23:56:00 -0700 (PDT)
Message-ID: <824a9871-1fd4-4b92-a3b5-e57a126dac53@linaro.org>
Date: Mon, 27 May 2024 08:55:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] dt-bindings: thermal: Add a property to select the
 aggregation type
To: Alexandre Bailon <abailon@baylibre.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240524143150.610949-1-abailon@baylibre.com>
 <20240524143150.610949-5-abailon@baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240524143150.610949-5-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/05/2024 16:31, Alexandre Bailon wrote:
> This adds a new property named "aggregation" that could be used to
> select the aggregation type when there are multiple sensors assigned
> to a thermal zone.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  .../devicetree/bindings/thermal/thermal-zones.yaml        | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index fa7a72e2ba44..e6e4b46773e3 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -111,6 +111,14 @@ patternProperties:
>            coefficients are ordered and are matched with sensors by means of the
>            sensor ID. Additional coefficients are interpreted as constant offset.
>  
> +      aggregation:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum:
> +          - avg
> +          - max
> +        description:
> +          Aggregation type to use compute a temperature from multiple sensors.

Hm, why exactly this is a property of hardware? Why on one board you
would like to average and on other use max? I can only think of a case
that some sensors give inaccurate data. Otherwise it is OS policy.

Best regards,
Krzysztof


