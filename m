Return-Path: <linux-pm+bounces-7993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5038C9DB6
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 14:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2BDB1C22A29
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 12:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A7A86626;
	Mon, 20 May 2024 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y976RHh7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628CD21106
	for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716209629; cv=none; b=hhq5Va7KPkjOshRHzb+nN8S3qOz7YdXfuKebo/rt3nLk6d6nY5vqlEF8fS5Cr9jbkxrQ96kRl6HXSpSJP+8jXtHbZL3czJnNxEBvsvz6MkwuoZTnQ4PGUixstTpT9IRJeJWX9S063duFpI8CT2Z6X4GoxL28y582DxIyUV7liCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716209629; c=relaxed/simple;
	bh=XpTS/UOJcc9WbuJR5vn3xPlMLUss9X8Ut2VcUbv1GcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwZ4vsTSO/6uAms+8nXYfQaDJfwy6BaEkqNy8PMyFpxGgXzQOfstuMEi7jzC22xnqw9Xfa1vGG7IEcA6yMunqQrRbNuezcI7h0M4ANqUSz6MFhniav4qKFwNlv7dAH4oPxEIfDnTbG+H9/AkcrKl2ZLTEaJFuLNlHEseiurDLqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y976RHh7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4200ee78e56so18291015e9.3
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716209624; x=1716814424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpTS/UOJcc9WbuJR5vn3xPlMLUss9X8Ut2VcUbv1GcI=;
        b=y976RHh7jUFdKkMmWzWd+M5E07mzTUGkp/h6nvf6SSXkSqUyDkqkTch/GvKXzEVdpa
         m/2qKTm2hjhRlfYuGh/eekWJlWHNV54YHryUG9Ab8C6axB+luDw2L0zfva1/1QU/+0Er
         vXzgEpBWUJ8qILqpDwi7uK41fdj5r1Hc+BacXK5cqAGM3W3TMbDxfDQVhDmLbS4qV/u1
         5egMYT3aZjmnqHd6Fm4022oYcPjo+7xFW6IQ3R5aQKiwJJvx8PzKUkmd4oQgk9EWVFCv
         NNqHVDwhcCaEEcQKPV9fijGDA6TpR4iL9hZ/gm5LzH/ajffhR48FpocZ+3pozF3Bil1s
         1tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716209624; x=1716814424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpTS/UOJcc9WbuJR5vn3xPlMLUss9X8Ut2VcUbv1GcI=;
        b=C6Sd3OFUfQUBbDHZBOWV2Gm7Fa8nUXt0rBsJYdpl7QbauwJZylsrMAjWoXP2ddk371
         tL2NU2MZZ2M+c8p5zUoQNQmU7YkVlgOyNdlvqDBTwrzc7m6ENfpccKMMxgJZF1pnGXKH
         damfasGHkAj8asHTwPobaPUh5+3yA48r4MY4Vc78CxB+FvWmCnT7KR2IJrxg+l1QqV7m
         UPuzMuN6rTBUPfJZadVTwadrMBbmLy8F/H1m46s5nVARZIJXn69RwX18yTmid0uWZKsi
         uX+DVibJIXYkh/gtY1BLfn1vVO0e7ne3MSjm2Rxp7I/y+MihAASN2SmB3Kw4n3NMmjYv
         YHxA==
X-Forwarded-Encrypted: i=1; AJvYcCWo53u4mpfmOS+IZnvOPd9fHEJ/olS8LXSWMK1Jqd3d3gN5OUO7aJfObWu8v9O2lh9MdYi4hVqnckY9eIUA0kjKxB4ao7deXYk=
X-Gm-Message-State: AOJu0Yyme5BgWJL3KxIh0HpWoigvSsy/hNX4rhfwNNlMqrOmNKAPCAqh
	NsXdfoPfV/0xtUEaWfMtBVF2UpmgTbVSA9G0zZjA4kBBv+8vKFQa9F2gn+57n939J09WxQDIvJ0
	6
X-Google-Smtp-Source: AGHT+IH3TUiR89Y7ynALFtrZoHqN4V0wClqNFYlgiy6j8bhsqgAWhVOwSDHKAiedHWew5HkCZs07ZA==
X-Received: by 2002:a05:600c:4e8c:b0:41a:408b:dbaa with SMTP id 5b1f17b1804b1-41fea539875mr229021755e9.0.1716209623945;
        Mon, 20 May 2024 05:53:43 -0700 (PDT)
Received: from ?IPV6:2a01:cb1d:433:4e00:3518:6eec:d551:4012? ([2a01:cb1d:433:4e00:3518:6eec:d551:4012])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fe004eae9sm407632325e9.1.2024.05.20.05.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 05:53:43 -0700 (PDT)
Message-ID: <eae892e8-f888-4d15-85a5-c89b6b6825f7@baylibre.com>
Date: Mon, 20 May 2024 14:53:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Mediatek thermal sensor driver support for
 MT8186 and MT8188
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Nicolas Pitre <nico@fluxnic.net>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
References: <20240402032729.2736685-1-nico@fluxnic.net>
 <981a8748-16d0-4744-b097-aa9dd14c63a8@collabora.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <981a8748-16d0-4744-b097-aa9dd14c63a8@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/23/24 11:22, AngeloGioacchino Del Regno wrote:
> Il 02/04/24 05:25, Nicolas Pitre ha scritto:
>> This is a bunch of patches to support the MT8186 and MT8188 thermal
>> sensor configurations. Several changes are needed to cope with oddities
>> these SOCs implement.
>>
>> All values (calibration data offsets, etc.) were lifted and adapted from
>> the vendor driver source code.
>>
>
> I picked patches 7 and 12 (and also fixed them) introducing the nodes for the
> LVTS controllers, but will not pick 9 and 15, as they're either missing thermal
> zones and/or using the wrong names; let's wait for the next cycle for those, as
> I will also be able to add the SVS on top (needs a bit of time for testing),
> getting both SoCs complete on the LVTS side, without rushing.
>
> Cheers,
> Angelo
>

Hello Angelo.

I took over Nico's work, so I might have missed a few things, but I'm
a little bit confused with patches 7 and 13 (you wrote '12' but meant
'13' I guess, didn't you ?).

It seems to me that patches 7 and 13 were applied in next-20240503
(f5bcf8ab0950 and d3dbc472ac66). But I don't find them any more in
next-20240520. It's likely that I don't understand well the process, but
I prefer being sure...Should I resend them in next series ?

Just a comment about d3dbc472ac66. There's a typo error, I think:
nvmem-cell-names = "lvts-calib-data1";
...should be replaced with
nvmem-cell-names = "lvts-calib-data-1";
...according to the related yaml.

Julien




