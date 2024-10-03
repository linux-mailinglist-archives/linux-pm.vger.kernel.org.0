Return-Path: <linux-pm+bounces-15108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A276598F446
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 18:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574D92829D8
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 16:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334261A4E8A;
	Thu,  3 Oct 2024 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncgMjvhi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758802E419;
	Thu,  3 Oct 2024 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973142; cv=none; b=JuSaY2LXmNsg0cd6FdCMUWzjC6qRt3VsGLtZLKGwxmC4B5EO6CS3RgL1jPT/gv/1vx8DZIslekeUnx3UC4iXqGHc51rLuT1FvYP0ZmOIUbuP2tNQcxH7GCl2EBUA2fBUEobJL9kRLLxmbmaB4Hf9wFknG+By6v9QT42+0jk9SvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973142; c=relaxed/simple;
	bh=JMJEZzcDykjRe2LzWFc0UnhPZ7HQw6CVeai1eHP5/bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ev3QZl4KAH+bRVu9Gu7PTBGoXyO/+QzHuhDswtSHxH1I+hRRCHCJIM7u5jk3m23gnpO2kWoOFV3pUMVnMvFAWfLbrywQsm3nGgIJUGj85DpZCeiXI+lCRjrymwhKROa8E9vww3Ouo7kmkRXYQDtHXpkUF10DFEL5jse5Bd+PHd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncgMjvhi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cba8340beso13598895e9.1;
        Thu, 03 Oct 2024 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727973139; x=1728577939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EI0tnWl1dLlz6m0UaX8+H054cmhe7d9iY1/KJ1ExYdw=;
        b=ncgMjvhi5ahx/KIl0nSHHKYY4saSJ4sW1rJobKGEfr6g9wPL7s5Mf1n7o475FTH5Li
         d6nJXb1H8kQhIz1A+sw4+oEFed//5ajKdXieafnUPtU50Hre0KOy+DGCJPstuK9yNwwa
         X46FTgnp4Gr9OQpNOyGJrEzC+A7Y9vNI/3iygbew+ALo2YtuP6Mvm843ng+Q/RXWlBYC
         HpJySu5LJsD8WBcxt42WYBk6KFehQUwpJKxnyKukdPCRfDm2odG8JPmzN8DTQiKiWZFu
         LxLDKAJeR9GHvXKmbixEG4nEq7lH03+PYfV+uZi2YkCrkfwXMuUmmcv46VSPcTS5LmIb
         w2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727973139; x=1728577939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EI0tnWl1dLlz6m0UaX8+H054cmhe7d9iY1/KJ1ExYdw=;
        b=ZyMcPIh4BvixxjQyEy8XzcqNyRBDxGVpTXFENllv9KhftVfjyG4+a0CxfYXhqiwIPP
         FQPzbMl8XcKXtV13Yur8xbkpHMGAEc7ZSDlFuYWsiK3ctaULTA9gYgUAzHGzUnL9z1/H
         Hm/nQoZtWXOkIT71NTgLtHjRhe3UgUbSaE/JpqWA0XvqsQNgSlvHHdGmBtrjd8Dbw9t8
         ilfRV03cXuraY5AhkvhFBIzBFQxDMGYynqLf7L+K5aqzT001rUDyjIXkVr4oLW//NOTc
         1ZM8Vzgo4AD86PHMK3NrBsHMuKV2FNs98KbMjkSzdtK8qFTDNoNqezxd7i5RxclaEHm4
         bp7A==
X-Forwarded-Encrypted: i=1; AJvYcCUWnLDQEw8hpdU3QTlKM75/cTmHK7CNeE7shMtw8aTbfdIjjY0i/DQmLew7LLjAg4ZiLURQYRd7nZXDewQ=@vger.kernel.org, AJvYcCXU1A4Y6DJ20Tzz9HC51orwC71anA4Qz4K72235HE0j7m0/SWnBbekm2wzdLfTQEGK18FEiiCRPHWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8KA17w2OlcBCLVpNghxnM/v5eayyq8ZE/XfqyuPBa6Vk+A8Ak
	DG7ebcjW/1WqxtdS5deRDnJr/S1dpM5yWpt20UmfZpTtmawun061
X-Google-Smtp-Source: AGHT+IFeQQTtsZq9/ZokVHKXqyJcGG5frxeTrecVPIYprnmtJAgju36msDG+gHJF21LNzwWNm9QU1Q==
X-Received: by 2002:a05:600c:4695:b0:42c:b7e1:a9c with SMTP id 5b1f17b1804b1-42f7df4178amr27574895e9.5.1727973138419;
        Thu, 03 Oct 2024 09:32:18 -0700 (PDT)
Received: from [192.168.0.10] ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a017esm19285205e9.36.2024.10.03.09.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 09:32:17 -0700 (PDT)
Message-ID: <a0960c37-e390-481b-80c1-9c467b17beb8@gmail.com>
Date: Thu, 3 Oct 2024 19:32:10 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] power: supply: sbs-battery: Handle unsupported
 PROP_TIME_TO_EMPTY_NOW
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, Sebastian Reichel
 <sre@kernel.org>, kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@chromium.org>
References: <20240418-sbs-time-empty-now-error-v3-1-f286e29e3fca@collabora.com>
 <cf4d8131-4b63-4c7a-9f27-5a0847c656c4@notapiano>
 <CAHc4DNJ0prAQOw89Hvw8n9KhY+8xB3D77pJvoPfU-X7ZFDYu7Q@mail.gmail.com>
 <924db470-8163-4454-8f59-f7372a132186@notapiano>
 <c721f2b9-2b08-45f3-adb5-09b163924fbc@collabora.com>
 <1db95251-04bb-4d4f-b77b-3b78a8f497cd@notapiano>
Content-Language: en-US, tr, en-GB
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <1db95251-04bb-4d4f-b77b-3b78a8f497cd@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2024-05-13 16:27 +03:00, Nícolas F. R. A. Prado wrote:
> On Thu, May 09, 2024 at 05:43:42PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 09/05/24 17:25, Nícolas F. R. A. Prado ha scritto:
>>> On Mon, Apr 22, 2024 at 04:10:23PM +0800, Hsin-Te Yuan wrote:
>>>> On Sat, Apr 20, 2024 at 12:03 AM Nícolas F. R. A. Prado
>>>> <nfraprado@collabora.com> wrote:
>>>>>
>>>>> On Thu, Apr 18, 2024 at 01:34:23PM -0400, Nícolas F. R. A. Prado wrote:
> [..]
>>>
>>> Getting back on this, we were finally able to update the EC firmware for both
>>> juniper and limozeen and all the issues were fixed. I have added the logs below
>>> just for reference. So I guess the only change we could have upstream would be a
>>> message suggesting the user to update the EC firmware in case the SBS is behind
>>> the CrosEC and it starts throwing errors. I'll prepare a patch for that.
>>>
>>
>> ...yes, but then you can't do that in the sbs-battery driver, but rather in the
>> CrOS EC - so you'd have to link this and the other driver (beware: I'm not
>> proposing to do that!), which wouldn't be the cleanest of options.
> 
> I *was* actually thinking of adding the log in the sbs driver by checking the
> parent's compatible, since that's already done elsewhere in that driver to
> disable PEC:
> 
> 	if (of_device_is_compatible(client->dev.parent->of_node, "google,cros-ec-i2c-tunnel")
> 
> But now that you mention it, indeed if we're only printing a warning, it would
> be best to do it in the EC i2c tunnel driver. And that's all that I'm proposing
> to do: log a warning telling the user to update their EC firmware, as that
> should fix the readouts, and not add any quirk to the driver.

I still see this error on a cozmo, even after doing a ChromeOS recovery 
to upgrade EC firmware. (Also, some properties sometimes error with -6). 
Looks like Google did not release an updated version with that patch:

  $ sudo ectool version
  RO version:    cozmo_v2.0.9006-689870d95c
  RW version:    cozmo_v2.0.9006-689870d95c
  Firmware copy: RW
  Build info:    cozmo_v2.0.9006-689870d95c 2022-06-14 10:16:42 @chromeos-ci-firmware-us-central1-b-x32-0-he51

  $ sudo ectool battery
  Battery info:
    OEM name:               PANASON
    Model number:           AP19B5K
    Chemistry   :           LION
    Serial number:          38D5
    Design capacity:        3440 mAh
    Last full charge:       2558 mAh
    Design output voltage   11550 mV
    Cycle count             19
    Present voltage         11607 mV
    Present current         243 mA
    Remaining capacity      2142 mAh
    Flags                   0x06 BATT_PRESENT DISCHARGING

I hope you can ping someone to release a new firmware build (probably 
firmware-icarus-12574.B)? I checked `chromeos-firmwareupdate --manifest` 
as well, but mine matches the version there.

But upgrading firmware would be an ordeal for people who replaced 
ChromeOS with an ordinary Linux distro on the internal disk. ChromeOS 
recovery would wipe their non-ChromeOS system, so they might need to 
figure out how to safely manually upgrade firmware (thinking VPD and A/B 
flags).

Even then, the RO EC firmware will forever carry the EC bug on 
most devices. For example, one of my hana boards goes into a bootloop 
failing to sync EC firmware, where I had to disable that and only 
use RO EC firmware. And we will eventually have non-ChromeOS firmware 
for these devices, which might not properly handle EC firmware.

Please consider fixing it in the kernel as well.

