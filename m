Return-Path: <linux-pm+bounces-40579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFFBD0CCCB
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 03:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 853243032FFA
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 02:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153A523E334;
	Sat, 10 Jan 2026 02:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cU9icCWA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835811CAA78
	for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 02:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011424; cv=none; b=IDw/Pq7U1NDiyy/UHB+C6Hoa3rm8gxh2SOLsw6vZS4ng0ogVPxSR5sx3eej8+hTJaHCoHokQWCt8VyRtbV0DrCxIv1T5FeCgeyQbh2rpA9AoDeK0TN7rIgJhuvnKzJmxtzjZjqZ3MFUL5trADAXvjJ6zmL8jqJhICaAfbforqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011424; c=relaxed/simple;
	bh=MR82Uddn6LpIx7Prbvd5G0/4W/Nrnou4KGzkP2OeRrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ai/Ta9v3t8qzUyT3KA3SpyLaZ0l55nKGetXUUfONAh0jEq9thI4e5Cv6dP8tlPl8rFUJBx0iMNyy1QmnogFciMOSAVk7aTOii/RXYAckn4BEplM9vGXaw4YEzhqZ9/qpHYvpM2FBsj/5CKuQ0dDlEwGWvXVVAkz2g4P1TVPnK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cU9icCWA; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79028cb7f92so45827947b3.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 18:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768011421; x=1768616221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/CS+sPGCudOBw/4dF2tLtNG4zOFpBZ8fj0ZBfM+xSUg=;
        b=cU9icCWAe69IHgPF9ny/jE9bgV79h1TuCqsvuhAsSJ8+MRS9KeAAyXPKT5oP+lxnQq
         tZvDL5TpoeaTaVMSSL6w1+Y0oZon0bnl0i8fOhgVcxYeD03/3H4l1c5KFtp1ESOjD7zn
         Uiyv9mEFNX1ctzeKBUb8WDIw5HvzIhxF5Tm6JkbRoc5v8FhH9erwYfGAijysBUuYp7lh
         0FyhWdaqhhEZ4gNvCOvXAZSDQRdSHNMdMTx+Ln/Cp9uzfNtAD8p7dM024iO8HGm9/JO/
         +o6wIe7g46q+ELhPPSCeKTWNziX7YdmLkg5R3IJ0wKzh3Np5niXILsWzlti/TQuOr4Vb
         Zkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768011421; x=1768616221;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CS+sPGCudOBw/4dF2tLtNG4zOFpBZ8fj0ZBfM+xSUg=;
        b=hLK3WyXeYnACxbOteScaZ1bs1G4NQhQjLs6DlBkayfm0a5eKD5OnUy201vblcQ04Oh
         rC4XLyuOV0wgJ2fv3YNSiKPu3h1i2VTFyIF9Xsn6uQ1ArnzTrhD0nf/f9TXgD/B8JulT
         L/SznoVbyqE0cFdQ7VIb9/vlc4FyBcma3ExU09ic3GM/PxVdRG//ZXyv3O02oh7pQLvb
         1hzBfmGQYNW2krxvSqGwtRjQCkTxGZKvkzqsuV75calIzUJWIXpeS/pKiKA/GXAzSq/I
         z+tVbuiew/GSHwneRHM7UUwTugZ9YmhXtluCZBZ+spngFHtiIvOq62ay8tioJqBsOtq2
         21zA==
X-Forwarded-Encrypted: i=1; AJvYcCVI9IUzrrkE+2v/sWQbtuTvy5ecjk5T+Lx0pjtGiq7oQuy05rTJIBpaMGsYuCdLHESSt0//DHACnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaI5yg/abOhoTQ39Jr6t3/oTIEkI0xUvXBVd+6suFZJQ7twsdJ
	VPsbAwM5sM6+CaMxoffdz7Tw/zcoAr7j/D8HJ0dVk4jJfnyztFXYeDONsBw9PuXApg==
X-Gm-Gg: AY/fxX6EoD1CxHGNq+Ijzrl3CpyKfe16S03wdmq4kSE0PXWYn1G05gtd5eNyDr8jSL+
	vZsl/rkxh2IalZqiKR5kB9hjEMYfpX8SAVUluDwJ/5X9G8jszC4JwnkIjVuALM4zcBvzJwbRNoP
	d5fyGMZyC/IPjnTEj/Q5W3Gx15AxgdYVmZF90CUyi1JymI/AHbTlo5mWG+DT6JOVtCit5bI1X/T
	tPoJ78okl0AK51vBxhKKWEMSoL+gaPlM+9dChEZ0Sw6bsnVL7Le2ufOoo0T9kBFEkd57i+ysZeo
	qN3JaDJK3Xpm8ol6f9ta11zu+w0reXUR3o/EBK9UjhJ9V1XBZaD0CsVvyMierHK8U+dG/9lbE4o
	1o22hNLRy1u4wGWqnxnw1ER72LcJPl9P/X8087J8jpwjLL0KPPxakEjVnvlYolqhkVAfU5qClHF
	3z6fiFMlrAsqlK5tGzzkqlt4UjZmTH1vijMzHm/+Xg1/XNHivQxRASgr768q+myX6ZZd08SQ==
X-Google-Smtp-Source: AGHT+IGX5MeGSKttRFeAc0MSgP/y2VLZfmVAUtwN+S37FdIJqLLc9vxJfr4q2stpMVFT7lLIyB/0qA==
X-Received: by 2002:a05:690c:6809:b0:78f:a6e7:76d8 with SMTP id 00721157ae682-790b5758359mr102216847b3.18.1768011421232;
        Fri, 09 Jan 2026 18:17:01 -0800 (PST)
Received: from ?IPV6:2600:1700:4570:89a0:1dd1:9ef2:39ca:beb4? ([2600:1700:4570:89a0:1dd1:9ef2:39ca:beb4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa553ac3sm47388137b3.5.2026.01.09.18.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 18:17:00 -0800 (PST)
Message-ID: <9f94993e-dd69-4c9e-b467-aad6031c83d4@google.com>
Date: Fri, 9 Jan 2026 18:16:57 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] usb: typec: tcpm/tcpci_maxim: deprecate WAR for
 setting charger mode
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Lee Jones <lee@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
 <20251227-max77759-charger-v3-5-54e664f5ca92@google.com>
 <aWD_RIPp1ULH9St1@kuha>
From: Amit Sunil Dhamne <amitsd@google.com>
Content-Language: en-US
In-Reply-To: <aWD_RIPp1ULH9St1@kuha>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Heikki,

Thanks for the review!

On 1/9/26 5:14 AM, Heikki Krogerus wrote:
> Hi,
>
>> +	if (source) {
>> +		if (!regulator_is_enabled(chip->vbus_reg))
>> +			ret = regulator_enable(chip->vbus_reg);
>> +	} else {
>> +		if (regulator_is_enabled(chip->vbus_reg))
>> +			ret = regulator_disable(chip->vbus_reg);
>> +	}
> It looks like you have to do one more round, so can drop the
> regulator_is_enabled() checks and just always enable/disable it
> unconditionally.
>
>         if (source)
> 		ret = regulator_enable(chip->vbus_reg);
> 	else
> 		ret = regulator_disable(chip->vbus_reg);

The regulator framework uses refcounting on the number of enables. If
the number of times regulator is disabled > enabled, a warning will be
thrown. Also, I don't want to call regulator_enable more than once for
the same refcounting reason (will have to call disable those many number
of times to actually disable).

> I don't think you need the check in any case, but if I've understood
> this correctly, you should not use that check when the regulator does
> not support that check because then the API claims it's always
> enabled. So I guess in that case "if (!regulator_is_enabled())" may
> not work as expected, and you may actually be left with a disabled
> regulator. This may not be a problem on current platforms, but who
> knows what happens in the future.

I don't think this should be an issue in the future as this driver is
specifically meant for max77759_tcpci device and should only be used
with max77759 charger (they both exist only in the same package). And
that the max77759_charger driver does implement the callback. However,
if you think that regulator_is_enabled() is unreliable, I could track
the state within the tcpci driver instead of calling
regulator_is_enabled() and call enable/disable regulator accordingly.

Let me know wdyt and I'll update the next revision accordingly.


BR,

Amit

>
> thanks,
>

