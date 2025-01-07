Return-Path: <linux-pm+bounces-20023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA5CA03DCD
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D472A1886CD5
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A5B1DF73A;
	Tue,  7 Jan 2025 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgmEQPCW"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3708214AD2D
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249592; cv=none; b=EDKuq9egTpAowkuJwX+RUUmX4fAiGcNnCTdN53hdThzW4GIRFHFnDRkZL2/9/1rZeMfG0J+EwWKHGDjDJu3S41oJIZsvm4KwishmNsUdvJcfXCpNst8iRb89Z1oSl9d2wlVaSE4VxsopGfr2FkuMscvAWqA3UOFHgx/nTvx2hqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249592; c=relaxed/simple;
	bh=XSpK0okPnkzY3uI6W/vqv12c1G4dPW7DT60HD+P7j5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3vCdg35hABBTNuV5vajW53RZ2qR39jPvb/Xx79e6hTxvVaNuKHFTtOURL6pPT89j8y0DKTVl9Rvd35jY0kEMrmB0feWE6Kcrc9x7N+n0KmVM5j5cWqU3Ecrt6WdgXpFFquBjEDEGx9eLsT8NJpHNiw4h25ytkgfwwjyOswwMT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgmEQPCW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736249590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1s4OGoaAo7NMEmyoLUwIYjFG71OPbCjR+gChUnQ7iNI=;
	b=QgmEQPCWNYFKqwJRNwks7Y+3L2qnnSJg2grKTtaEPaAqmFbng4XnYMuPmUl3ktWHKBWxPs
	+xLeCNXJUeXdKKc4dYKPgJ9DGwY1SbOL4ROCjtixY1efBD6OUp747PV8oYo2iu3lOGvbBp
	O1EKeBIBo90xTTVjmitSj09TukfReCc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-2Qio6YjCOhaZIjnE1BSSLA-1; Tue, 07 Jan 2025 06:33:09 -0500
X-MC-Unique: 2Qio6YjCOhaZIjnE1BSSLA-1
X-Mimecast-MFC-AGG-ID: 2Qio6YjCOhaZIjnE1BSSLA
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d3dbddb891so8357259a12.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 03:33:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736249588; x=1736854388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1s4OGoaAo7NMEmyoLUwIYjFG71OPbCjR+gChUnQ7iNI=;
        b=k6ZHSpCaePsDiylTbGZCvBTsQZ7G7jSbNz0O56lOx0WMmzKFzzMEYBI64U0IDXvjN9
         qRuNeXtd0uR9/oouBQJkGhM3IYxObEmBlHTCbPyF9zHPPqRC37v4aUVqbP0fvGLn5aqU
         UR08UZ/qk9YU3CqoxLk8Lb+mqB4VGhMgchXaaLojmt8e5yJvheqZx9EZy+bYscnVBPEX
         IHsHFC0gt47a1T3IrEfx0Hfi0wrJkDdmAzt24CB1JPHPoSWcXF3bnHfHExlCDRXWMAUe
         ZTLmp9usS3+ZNkbK1By95RLlMDx8ZL4LJM9jVT42UHo2c0eKiO9s3eaQngvmjsnFWatZ
         b2Kg==
X-Gm-Message-State: AOJu0YybFDh5+3/fu801HomYiYc6TUecU3zJshps2ZcuH6jeU3Mm5K2h
	U+qgnTPNF+CPII+hvTxGFY0XJCeWhQ9Tnsx4rHFApSpaUGJMmfnHWY48LmS4McgkY9AIgxV1KLW
	xPBfwaHw3fvOfse/LVlaStaXoQmwJdGsQXlpUJbcyWHwoWqVxtEqeaWg2
X-Gm-Gg: ASbGncvGgZa04WLL8ajBDVgn9isMpmlWkdbqkJ33SZ8oof1hVNMzuOVrN2svpIm1dht
	H3kVsiDtZMXB01qdONVNz0cSYxDUU6kzZDzbK3fl9mFKsSu07vWMjkAeRAIiuPT4jrNFlSfZ49Z
	s8Mkdq/UP6WURda1XkGStPK6IT49KCkKoJoRI2kIi72JLx/A+ZF5bCAT2xKsHSJtuFUoQxPAoTx
	6OfAPMlToD9kzDH1XiKpYQchR6e9QMpoqFSxOA83RWW6aemFt0O6dmORUslhL332ALxDUYhhKSj
	h9EaemneDo1JxXlADZNswTEwkdMfqSRbQ44AmLYbC8a+zTuFVoi9+nEonS1xcH0T5Ue+mVWvQ65
	YDVHGZFwsMdjlYgcLV3r1W5gmGsjzxtc=
X-Received: by 2002:a05:6402:2108:b0:5d0:7a0b:b45f with SMTP id 4fb4d7f45d1cf-5d95e8d6901mr2447769a12.10.1736249587858;
        Tue, 07 Jan 2025 03:33:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESjlGK2uO+aQlZLWv4NbAxfGSTyiFVPbHGvtw7cvJ/PVKjjKb1RIptLF5Hl0m8alrZI25UYw==
X-Received: by 2002:a05:6402:2108:b0:5d0:7a0b:b45f with SMTP id 4fb4d7f45d1cf-5d95e8d6901mr2447764a12.10.1736249587546;
        Tue, 07 Jan 2025 03:33:07 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f3f9sm24175345a12.23.2025.01.07.03.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 03:33:07 -0800 (PST)
Message-ID: <70341af4-90e6-4fa1-b2f9-0fb23839a04c@redhat.com>
Date: Tue, 7 Jan 2025 12:33:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] power: supply: Add adc-battery-helper
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
References: <20241215172133.178460-1-hdegoede@redhat.com>
 <20241215172133.178460-3-hdegoede@redhat.com>
 <c6af6fb4-50a1-43c0-88e5-f541fa5dd4c7@quicinc.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <c6af6fb4-50a1-43c0-88e5-f541fa5dd4c7@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jeff,

On 7-Jan-25 12:26 AM, Jeff Johnson wrote:
> On 12/15/24 09:21, Hans de Goede wrote:
> ...
>> diff --git a/drivers/power/supply/adc-battery-helper.c b/drivers/power/supply/adc-battery-helper.c
>> new file mode 100644
>> index 000000000000..1917e92ab1eb
>> --- /dev/null
>> +++ b/drivers/power/supply/adc-battery-helper.c
>> @@ -0,0 +1,359 @@
>> +// SPDX-License-Identifier: GPL-2.0+
> 
> ...
> 
>> +MODULE_AUTHOR("Hans de Goede <hansg@kernel.org>");
>> +MODULE_LICENSE("GPL");
> 
> Sorry for not noticing this until now -- holidays...
> 
> Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
> description is missing"), a module without a MODULE_DESCRIPTION() will
> result in a warning with make W=1. Please add a MODULE_DESCRIPTION()
> to avoid this warning.

Thank you for reporting this. I have just send out a v2 patch-set
dropping the 2 bug-fixes which Sebastian has already merged and
adding the missing MODULE_DESCRIPTION().

Regards,

Hans



