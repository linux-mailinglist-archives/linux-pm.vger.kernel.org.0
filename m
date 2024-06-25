Return-Path: <linux-pm+bounces-9962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A29916CEE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 17:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03021F28EB4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 15:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE127178390;
	Tue, 25 Jun 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej1nPY/m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312EC17084E
	for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328887; cv=none; b=Q7inHT4r3cx9cS5ketSatsyVZnLANC8KwU7U34JTEv9CIyoUv6puPKiV51LooZNQkKZ9J1uKnHHVUHYupcVCrvsCJEamvqSMV1t/aoJoV+kABptXT4P3f/siAnCtZS2SCGCPd0U1meE2hVuXHfSt2oO96LG5K93Ogp8+ZqzoynQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328887; c=relaxed/simple;
	bh=L7dxI5atDsC5KiA+r4b1ljvk5s3mM1vtSwSuKOCRIQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdLtb120yy8/hTi+DkIHtGMs3oB7yFNbc3OMZ8luZ3pieD5QZpFQBWmO1NfpTXJgkCC+2CobHAuMNu0c8tF1bt2yRebtJwAXaxQfqh5v01S0TmDyXCEf7qKSctfUvNr5ChqW2K+DvUoISzO8o38QDOujnJsSNqbTyUtvnJIk+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ej1nPY/m; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6fe81a5838so343008666b.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719328884; x=1719933684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Az0heqnLoqAXxETr4R66/gQlMFb6UsVZu78yZT+FtM=;
        b=ej1nPY/m/mJiFjtLkwezKGV3BWkyTGK1K0VIiW0uOtQMBOMPhunnRKktVdoxoTg2K7
         JRuEzafxf9ZCsRtRKyPV1Z78nVhPF3kxdSyHdJsLwayST65bswY7+KS1qs6TEUF1qk/S
         XC02ocX40hdI4gHXGM38rlVbxZdzL+NsvMqeA5kXew//Gbk66FVYeGOU+Y4U2KkfO7wk
         wCVTkWUZtT7XuCNn3zmTBgVXDeLp6An4hn6uGuQniLEuvNFoPV27+ww4J/Ir7i+wxO+G
         VG9opmi1eFC4O7sLELTzGlZqS8p95uux7OE01uD5l9Nzy6RaK3PORN0tCe4G7QMi4YNG
         McOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719328884; x=1719933684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Az0heqnLoqAXxETr4R66/gQlMFb6UsVZu78yZT+FtM=;
        b=alck32R7SAocxATNQXOu5Ov4bdSRLbEB+jpwO2aBidlvapDGlJixDleVBcC9JjK4Mm
         TQP0ORYCvXHln9RNrdDV3w1RwReQugdgMMV2LJm1YuRvPbnOtdiiZE8Kr80u7dW0Runp
         zTdCqkXU+I72WCbD8tERJPn9+IgdXefTekLEMjxP7Vf+2Pv3XZLXFD3MFk900xJd29gb
         LOcbw0V0OmAF3m28k0xFKIuYcMssB/mE/H/q+Q6hRBiMZA6BjRZ8aRBlAAci0rIE0cY7
         WyK0D/uvShUTAcJQjYdIBC1StiwXIiRNFZ4yf/KIYNyZBKCXnUgWwReAd5jUTU837+sK
         q5VA==
X-Gm-Message-State: AOJu0YzZI7kFy+4sxl5/1YGZfP9Xi/4F3profH8ZqUsX5I+kysn2y8zC
	3GATVm5h/BJijFLkMqPZNKrJE7aqmEld2KgSdjZkbag2i7ubyty/
X-Google-Smtp-Source: AGHT+IEwGjcHs3g81KlSF2qV1aaiJY8CUoiJqhsXZub36AqeYKP8R1QA0tBjGpdazjbTFBB6e2fS+w==
X-Received: by 2002:a17:906:9c87:b0:a72:7a71:7f59 with SMTP id a640c23a62f3a-a727a7180b9mr142448366b.57.1719328884220;
        Tue, 25 Jun 2024 08:21:24 -0700 (PDT)
Received: from [192.168.1.18] (175.131-179-91.adsl-dyn.isp.belgacom.be. [91.179.131.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7250f0c2a8sm250967166b.114.2024.06.25.08.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 08:21:23 -0700 (PDT)
Message-ID: <81a78629-ea25-4317-bbb3-62a4a3262e27@gmail.com>
Date: Tue, 25 Jun 2024 17:21:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 0/3] cpufreq: sun50i: add Allwinner H700 speed
 bin and additional OPPs
To: Chen-Yu Tsai <wens@csie.org>, Yangtao Li <tiny.windzz@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara
 <andre.przywara@arm.com>, Ryan Walklin <ryan@testtoast.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
References: <20240607092140.33112-1-ryan@testtoast.com>
 <171906943501.1109052.11689701111557656569.b4-ty@csie.org>
Content-Language: en-US
From: Philippe Simons <simons.philippe@gmail.com>
In-Reply-To: <171906943501.1109052.11689701111557656569.b4-ty@csie.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I made some more tests, and it seems the schedutil governors is hanging.

I don't have the technical knowledge to find why or where, but I wanted 
to report it here.

Others cpu_freq governors are working fine (so far).


Philippe

On 22/06/24 17:17, Chen-Yu Tsai wrote:
> On Fri, 07 Jun 2024 21:20:32 +1200, Ryan Walklin wrote:
>> Support for the Allwinner H618, H618 and H700 was added to the sun50i cpufreq-nvmem driver recently [1] however at the time some operating points supported by the H700 and in use in vendor BSPs were found to be unstable during testing, so the H700 speed bin was not included in the mainline driver.
>>
>> Retesting with kernel 6.10rc2 (which carries subsequent fixes for the driver) shows stable operation with these additional OPPs.
>>
>> This patchset adds the H700 speedbin index, enables the additional operating points for the H700 in the H616 OPP table, and enables DVFS support for the Anbernic REG35XX handheld devices, which are the only mainline-supported devices currently using the H700.
>>
>> Regards,
>>
>> [...]
> Applied to sunxi/dt-for-6.11 in sunxi/linux.git, thanks!
>
> [2/3] arm64: dts: allwinner: h616: add additional CPU OPPs for the H700
>        https://git.kernel.org/sunxi/linux/c/b05f15d0fc15
> [3/3] arm64: dts: allwinner: rg35xx: Enable DVFS CPU frequency scaling
>        https://git.kernel.org/sunxi/linux/c/e1e61fe3452d
>
> Best regards,

