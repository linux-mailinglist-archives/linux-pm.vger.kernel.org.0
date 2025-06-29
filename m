Return-Path: <linux-pm+bounces-29806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8123AECF32
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 19:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787543B6938
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 17:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2D5239E6C;
	Sun, 29 Jun 2025 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="isFwwZLd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF1239E68
	for <linux-pm@vger.kernel.org>; Sun, 29 Jun 2025 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751217992; cv=none; b=ALYvi6sMNixifwTZ45UGC/v/IR51Nvn70nP8D/weKbEYhdtawzaSdieYBhPMVUloVMPPmWAGmdRJ4hKqLlZ0K7Yozi2YubRPz8XsQUvWbiwqxli8tXpdIqsaD/bzvKH0FKy0e3kWEcwLoWn+eZdvHsfnS+LbPx3IssTLTP2uYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751217992; c=relaxed/simple;
	bh=UcDLRIK4nSfwsBUkh4/O9ySj32H/fgYNG9bmFhJ1eH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k1rqEqjYyMU7gqKGI5t1e3xEhXyhoiiDKGYtqD3wcpFnLapLCvdbzEy2kR6b/dZTP59eHAt/YWSOm6P/sBCBywRxR+mkjxO7NO/4WbSIjNqf512oy01EGIdbCrifJfHF8pdI8QM3AnFaTy2Q+xLT7SoO50gHOUdYiLbSNAhh+hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=isFwwZLd; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-40b32b6af9eso1580971b6e.1
        for <linux-pm@vger.kernel.org>; Sun, 29 Jun 2025 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751217990; x=1751822790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x0J44e2xJxiOSnYAQHHbyr1iri4R8DxZunjcmJed2aE=;
        b=isFwwZLdtu5EizqvCa04xQCqe9bvR/q3t8o0rFOFMPooO0XcPlZ+ZCwYZmSvepau63
         LRZtPklD7PocyJ4F1UJPI7IS3WS9rI8tb8Ca77h+XJtNW8sbciQc997QGH/3D3bzAM97
         rqI3TeaXiv/Ut4Mh1yKKubQLOmSOT/oYzVya8nkBBsop79IdKFcnlCSPkCebKM9lajjH
         6NS4sdpEMp0UmtcQyw8xMv9L2uuwv5VO5CdBcY7tWP9Gp4wJPJBe/++VuLOggWsQiFsO
         JPKc2dPKMbIt0K2Ez9LoD8uzMYIOP2aRn9DnsEEW6g7LnjLjJ9DvONDO8aTLlmoCrpId
         Xq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751217990; x=1751822790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0J44e2xJxiOSnYAQHHbyr1iri4R8DxZunjcmJed2aE=;
        b=cJ9cvOENv9Ii8VEcwdJfKxydTzsxeB6/wVgX7VCwkTBf4vgUu0m3Zriz3E+x4rnOZd
         6p7UqsmMRDTz5poK+Me8zMMYX6ibRJvhZJo96uqSvb/TOVp4IojgUV9bwk6vyvSny07Z
         UAd5rgCCtlnVhviVgGrB/wQCP8CqHsabEZ8d+R+y+OegS8A6F0FdIc4fh9VmZz8Pgtgi
         7aA/gwKV2KIIodf6drqPd7VFf9qZQoxRo9Z7olNrQN+nMpYaNd2lfXoHFNd8MGM8KsVz
         sYd9ZnThNn3Q1FHnB5nvrbRQT2vIEsSPtk73eM4ommMAeqF3QIV5wg7e7GaFZFLnQUpa
         7u3g==
X-Forwarded-Encrypted: i=1; AJvYcCUaaK2WB+ndlF0T7loldKoEI6O6B4GarAo6qMM+J/BLTdbOPo+z/2aEwsM6hd8eHcSKABFd61mlUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwzmGl1K8dcg+tRb5eCxGdSPPTZp0bQ9DKU141maWaPS34STay
	6uZJai9TQeyEN5BSPrk1zb1PAHxrun+fruKW4CftCsbjB9cN55fQ5Kua75gsRZuZi8c=
X-Gm-Gg: ASbGncu0M5v7Uqsct9q8Swfy12vSUdWnA5D0DGP74/jzLtX+0Pj2C/W3GLbCWw51UlL
	FTteJXCGECAhV6OMu2/hxXEHVcKBLFi1j6le97Hsx7qGKPRY4U4jD+gSnTfgRMHC4ic4Jp460eD
	xdz6gXOEa8UOuiBG6yf6bza4vkNdlgJicXyH/loeEfeYA45XnrfA1kOMLdPfKcsuThV/nctMSzd
	iNY6d/m10PsVpAnDc6FNTrnHakK26sex/tdy2oPYauqQVbJMRXi43Vt7b8TBKApgbLE8/o8McQx
	As+X9WrdmKVPpGiYPvC5tSJ9SHwqj8RRmjxvfe9w4+RNGaa6o9pdwldwd7NtAAhnVnZix+9WvIT
	Vkfmxvp8x7TP5v1TqP11JoNhfNBAL0NqTHBF83C4jPxi5OJR5Xw==
X-Google-Smtp-Source: AGHT+IGXPL0lhOwDFehBinrdpXCNAl48Ot/qIiS16yHakjjWRm/8p1TRnd0kC3+2s69JZhSqjEXZhg==
X-Received: by 2002:a05:6808:f02:b0:409:f8e:726f with SMTP id 5614622812f47-40b33e34ba4mr6866779b6e.25.1751217989649;
        Sun, 29 Jun 2025 10:26:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4876:5a0d:2fea:6208? ([2600:8803:e7e4:1d00:4876:5a0d:2fea:6208])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b487940bbsm940788b6e.3.2025.06.29.10.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 10:26:29 -0700 (PDT)
Message-ID: <97d34412-31ca-41a4-a3fe-30635a79d52c@baylibre.com>
Date: Sun, 29 Jun 2025 12:26:27 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: iio: adc: Add support for MT7981
To: Aleksander Jan Bajkowski <olek2@wp.pl>, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, zhiyong.tao@mediatek.com,
 linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250628223837.848244-1-olek2@wp.pl>
 <20250628223837.848244-4-olek2@wp.pl>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250628223837.848244-4-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/25 5:38 PM, Aleksander Jan Bajkowski wrote:
> The temperature sensor in the MT7981 is same as in the MT7986.
> Add compatible string for mt7981.
> 

If they are exactly the same, then we would want to include fallback to
the existing identical compatible string rather than adding a new standalone
compatible.

> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml      | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> index b489c984c1bb..ceb914dde15b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> @@ -26,6 +26,7 @@ properties:
>            - mediatek,mt2712-auxadc
>            - mediatek,mt6765-auxadc
>            - mediatek,mt7622-auxadc
> +          - mediatek,mt7981-auxadc
>            - mediatek,mt7986-auxadc
>            - mediatek,mt8173-auxadc
>        - items:


