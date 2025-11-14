Return-Path: <linux-pm+bounces-38038-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8032AC5D593
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 14:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AD9D4E23CB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 13:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2AB314A79;
	Fri, 14 Nov 2025 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLxJBecV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7F313E30
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126525; cv=none; b=GXK+DuJFx/ADYJKUdTI56US3tDn1CvwZhqFG8nwOlxq0y6kR5QossushxX24nPh3fMIcBjBdHfbXk6Gsi2V/tUXW1pv/xGaj2sZBheNSmw1thOhauDym79SbpeVfbmVQsmWuxSjBeJACVGuZOlEi3ZHeYp2eRwQO/Zdi2c+zKaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126525; c=relaxed/simple;
	bh=PIhVxornY+xeHydrfUvm8sKztzt4GgYtkzvZxgJ8W40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwW+FBZb0F5iEJOfq+uMlmS3+8gTaxylt3c+k3KI4t9Qux+q1vf+UbEDLWvMD7ESVc3n7ed+asp36yEz1K1xRoaBvbcehAWX0Bd4wtIkrk28Id0n42gjR0O72Izs/5coyijfD/7wG+YabLOqf4qPiGdwuxRzaGd8v8JPYjo1Tqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLxJBecV; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37bac34346dso5637421fa.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 05:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763126522; x=1763731322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TrtX8x6xiGPlcF3REo6XTaulSDVNKE90sjqlhnGudPU=;
        b=JLxJBecVTt7ci4MySHtaJCX2RuSWm+47+kgQXd3+q5iCTC6xRsKVeS4VMO2C6iKoUi
         7wC7myl8516ZyD8NfP4qhC6InalfcMWDXVAnbtLDFNwJ6ARwpQfEZIrsLX12cgIT1uql
         lrk6TGIK/1QEbP5uaOpQ8lOu/DJZfSzIb3aiGlYvsoBl6Z+b0tkjB3xpz6kbj1SreGpl
         da9piGtvNIXkCcYmoDu2sNWR9609OQO1ta0KvjdQNYb4U1AiIS2D9tvNsn+Wv5udjE9n
         tKW1+Vcx+V8JDmWgyb2Y2iuVQPq4hnOZ7a48Uw3v7Cx5fOHYIAEu4dBdezJxsOSPM0Es
         tZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763126522; x=1763731322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrtX8x6xiGPlcF3REo6XTaulSDVNKE90sjqlhnGudPU=;
        b=dcCddMkoNdH3x9jUNBtaJW3/r5ushWVJxGDfCEj/NDlc2zpwHXHk8tFHYhHxqtNuPn
         0k/aLGt87VuaH5TzukZ8YyfSw09qRAngy4HNgseCIMtTg1hOflK9l2FjOSPScIutn2Fr
         WX/s3ajvLKO6fmtQD/C5R89Ea6+MXrsB0gfVFGTuJbssoWo9cHqmyoKeKnJOFc3DIXU7
         NSTjGHZX54XBSJ7LVL5DOM6MElgooNdx3rGa09K9t6scrjWSa6AqNKgaysvIb8s+ulnc
         cUYk87NGrOHhtb12/nxWROeAoSjebNaKgCAUw4svuXrBvsDHVTHgd1WB/ACq1cfraWVB
         1fjw==
X-Forwarded-Encrypted: i=1; AJvYcCU9loVQC2BmJA8UMvOfsAPlCXtSMN9tk1/TTBF7f3b/yZkaIex6F7L1jaBC0hmFUt9L3MyC4LlsKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/Z4BeHAOiWf2naPh2onXT6TbMMLaZQlo9wAljwlmaSMb3+N3
	pOwdrnlkTFDf8rxNGMRwVQJAALfn3GZBQ3Y1/KSTnM/zxV5gc5nzeQVD
X-Gm-Gg: ASbGnctELcs8xuRyS3V8xumJhK2Y0MiPb9ivwS5f2+l+3X1FsWUw1sFuApLNvrW1Hdo
	2qjFhv9upVyvdHHbXMKTEOLocUt1eBQ4QA/19WbZHDhgr5azwM4i+8pxqX38qWBPjlQFjxgG3Tt
	fhmAJu34xgXiZ6pIN5taDVQyT5mLtb+mXxehkYouB4VthZhIVwpEM1wxamkGcIe2Sr2exYjbKLR
	ih5cjD1RIo2W+pKhYxy8qQBjRlKhUqxyQ1NtOUpiXj6CnhKwZ3FURfuuZ6EEiJI6sLqyuvqdKmk
	Iwy8Z+ep+s3v4lb16FtY5DwiZJtQ47NSoRlPjbLFN3NYuLjd9KKi8HGsLl42wxQNuiXzQ25hA/p
	WxyQEaIx4sLO4Nh3Gf+AZxPcbXTiQCBL15oHTJPRzWGwXJessZLByiLaRCUBksguUuaMwRLSl+E
	Uu68c1yDnJqQLcrs7JIha0A5BjUyelYoiW2es5eBEF47QYWKZS0JvQLLWjwA==
X-Google-Smtp-Source: AGHT+IFJvPwRc3iSb2WexT7/Nxb76MqMei5zXQUBPxVbaOVwZ0mTUJAzGoCKPRFSwFTVf5iDU0WZyw==
X-Received: by 2002:a05:651c:418f:b0:378:e3f9:2d26 with SMTP id 38308e7fff4ca-37babd80ac1mr5793261fa.39.1763126521767;
        Fri, 14 Nov 2025 05:22:01 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37b9ce080a6sm10220141fa.4.2025.11.14.05.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 05:22:01 -0800 (PST)
Message-ID: <2334e57c-a384-4a1e-9708-19d14b8f082c@gmail.com>
Date: Fri, 14 Nov 2025 15:22:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/16] power: supply: bd71828: Support wider register
 addresses
To: Andreas Kemnade <andreas@kemnade.info>,
 Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org
References: <cover.1763022807.git.mazziesaccount@gmail.com>
 <6248200397d3582fe926938736da66d6bbf9535d.1763022807.git.mazziesaccount@gmail.com>
 <20251114121509.629d171b@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251114121509.629d171b@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Andreas,

On 14/11/2025 13:15, Andreas Kemnade wrote:
> On Thu, 13 Nov 2025 10:55:39 +0200
> Matti Vaittinen <matti.vaittinen@linux.dev> wrote:
> 
>> As a side note, we can reduce the "wasted space / member / instance" from
>> 3 bytes to 1 byte, by using u16 instead of the unsigned int if needed. I
>> rather use unsigned int to be initially prepared for devices with 32 bit
>> registers if there is no need to count bytes.
> 
> Well, this is totally internal to the module, so no ABI/API changes, so
> there is no advantage of using 32bit now I think. We can switch any time.

The only advantage is to avoid the churn if 32bit ICs are to be added.

> But we have 32bit stuff in the regmap cache anyways, so that is not above
> the general level of wasting space.

Exactly. And, I am not sure if sparing ~hundred bytes is worth the 
hassle - even if it is hassle internal to the driver. But yeah, we can 
squeeze a few bytes if it is seen beneficial. That's why I mentioned it 
here :)

Yours,
	-- Matti

---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

