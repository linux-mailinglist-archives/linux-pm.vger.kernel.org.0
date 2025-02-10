Return-Path: <linux-pm+bounces-21706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83810A2F13D
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 16:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3A3163E7B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 15:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A10C230D3D;
	Mon, 10 Feb 2025 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="Fi5HiAbG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646AA1F8BAA
	for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200643; cv=none; b=unlLDVkNrs+yEZHjC57oFLsVmSVMAmR8xOUnAqg52cCI23/uxqa8QvoUlav4xbbfVu8JQ8eiz8rwhnlh7WCBVIQPdWkb5lTMLXn5lELP4kgyirMVUbTrp3B3KC/Cg+aVMAdL1BIqx/sElEbs37BmzR30r1WqteXMh+rc7CRvGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200643; c=relaxed/simple;
	bh=uG272hbqp19He+noX6bJMf3lAmn0BOPTkAquhMcRT5c=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=t1Zptwmi8J0eL7sdP7NBsDR4Lvk1YF/kYE2kAcDivOWTnbjXXvRj6aHQOcEwo3PENiBvNl9nP5Lz3C89T9YbyUR9EnmxIiqbSuNwReJz8Zi1TaELLlKUBotQyAGmiIeI7nY/yO8Ck9vjGeHtvVAonnLJ6rM585Fovy6JH+IVV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=Fi5HiAbG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f3c119fe6so99686735ad.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 07:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1739200640; x=1739805440; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uG272hbqp19He+noX6bJMf3lAmn0BOPTkAquhMcRT5c=;
        b=Fi5HiAbGzSRAIAJs0vuLmdWxwuJ8e6gS+kf5c1IGp5/ovzpag5MFkAzTx05qfryoXo
         yPsgPHLjkgE71TfOUcrhewhcCcw7MlJeA+sqhWAGaF1leVfA9kL0GuvQnRWKdhgzdfag
         yrX0az8Hfmh1qg4farpMHpyRBTigy8C6MHXpjvghMhTes5D2cMb62BnaNN1pYlkNZX0a
         JSmp3LMc0MbpnK2t2u9kBmJ9S3bcoEHpYwZe0A+soelaQR1kJHni7Vgqq52y38IMGfrm
         uJCfUkMkJsF0dtmQQNWDg1wpL2RDpEGPIxv0+Qhln2m1dOjTebW6tbWa+eWyhRFiryZ6
         Zgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200640; x=1739805440;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uG272hbqp19He+noX6bJMf3lAmn0BOPTkAquhMcRT5c=;
        b=nHG87Rt/T+Pe4QJizFebTJSU9V7xikp8xUsufX+R92w7GBMe9Mz8j7XiBqFLKkrdv2
         1hH6niqTCmYpr8wKYA0Y6uwfCoD+tvV7vHwL7QoiCKlaQWc00anLlZhAgtloLJR2b05W
         TaS9UQiytuB56U2F1WqkkYEXbXgJy6OBN4hFuxZ5yyqvyPCvQoX3yLD1p0/OziXERldg
         hYyskpuKtvFHSwtitR6y5V8iy8N0B5iJw+2zcTP+Hs09lPAVmj1LNIMy5/FDL9ErhO0G
         eiWb5cr248xA4n5PUOcoMrcM23trto4LNPEVztwHn4yPM65/tgSvBAVLWpQJ+29yHx6/
         7mow==
X-Forwarded-Encrypted: i=1; AJvYcCXlpQcB9IVyVHLrce29NHbIqwwb571a23y+nreLUA24zpbBKen6rzmbG6um598qbA+KZ3U+IeuFkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQY55KSWSHEwS5Nhazlq2gjEMocCfaNQ2var5Qle+S0d759giS
	y70gp4nj+O4+lnSVgLMmvQoSjLJnpNI9MMDMET//LUqJ+pI+YjLDP5NgcKkLcQY=
X-Gm-Gg: ASbGnctG/DIcWlt1RR5oTH1nJB3snl7l1WNsnjQb2zmlmbhy1AJuAGdPcffPqzvJ7Nc
	x+ufwWlFOZmWYgzzb5S1IlY2WTEorXd9ejP+07BNWMxpF/UnuVivhd92ZpwfJ+XhLeGb0XrFwRM
	0lk1XAaOUZOQCARksLHbwHtUy4p3fHCcM3cmVXdDWzoDJMgAKK39BPJWC3/CnEh2Hh5geUUMSHJ
	1it0a01cuiTSIyjxW0qanjgTeDLICwqhjzxAUm6jloX5m7fhTwC2ozvasnQIg62jq34tVlFBT2V
	b7AQHpGbh5eWlYgvI5I1h6WFNvvntTnmwtHmyhn1HiSy2C/Jz5+dv0Qf
X-Google-Smtp-Source: AGHT+IFxmBR+FDM9oZjyzx/qEh8soWZgzP/gXnemDEFlV+s8l9s07tFUKyXRU5C3ABLP4UXcu4ylTw==
X-Received: by 2002:a05:6a20:394c:b0:1db:e40d:5f89 with SMTP id adf61e73a8af0-1ee03bacc31mr23897302637.28.1739200640659;
        Mon, 10 Feb 2025 07:17:20 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aecf47asm6624275a12.31.2025.02.10.07.17.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2025 07:17:20 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
	"'LKML'" <linux-kernel@vger.kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>,
	"'Aboorva Devarajan'" <aboorvad@linux.ibm.com>,
	"'Linux PM'" <linux-pm@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <12630185.O9o76ZdvQC@rjwysocki.net> <009d01db79b9$aecd1c70$0c675550$@telus.net> <CAJZ5v0jELEw3yAoRFLPgEcfBRoUyd6tKSNHO2Q1O6_CoeR1Bng@mail.gmail.com>
In-Reply-To: <CAJZ5v0jELEw3yAoRFLPgEcfBRoUyd6tKSNHO2Q1O6_CoeR1Bng@mail.gmail.com>
Subject: RE: [RFT][PATCH v1] cpuidle: teo: Avoid selecting deepest idle state over-eagerly
Date: Mon, 10 Feb 2025 07:17:21 -0800
Message-ID: <000e01db7bce$e1d3b8b0$a57b2a10$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLC2T+pvcOY0U2G0e8FLXneTSytVAF1rbSKAnCZaQyxUrGngA==

On 2025.02.08 03:25 Rafael J. Wysocki wrote:
>On Sat, Feb 8, 2025 at 12:40=E2=80=AFAM Doug Smythies =
<dsmythies@telus.net> wrote:
>> On 2025.02.04 12:58 Rafael J. Wysocki wrote:
>>>
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

... snip ...
>>
>> Test durations were >=3D 45 minutes each.
>>
>> Kernel 6.14-rc1: Includes cpuidle: teo: Cleanups and very frequent =
wakeups handling update
>> Average Idle Power: teo governor: 2.199 watts (+25.51%)
>> Average Idle power: menu governor: 1.873 watts (+6.91%)
>
> menu hasn't changed in 6.14-rc1, so this would be variation between
>runs I suppose.

Perhaps the way I presented my data wasn't the best method.
All the % were relative to kernel 6.13 and the teo idle governor.
Relative to kernel 6.13 menu governor that would be: -1.9%,
certainly within the noise floor.
=20
>> Kernel 6.14-rc1-p: Added this patch for teo and "cpuidle: menu: Avoid =
discarding useful information when processing recent idle intervals" for =
menu
>> Average Idle Power: teo governor: 9.401 watts (+436.6%)
>> Only 69.61% idle is in the deepest idle state. More typically it =
would be 98% to 99%.
>
> Ah, not good.
>
> OK, this clearly doesn't go in the right direction.
>
>> 28.6531% idle time is in state 1. More typically it would be 0.03%
>> Average Idle Power: menu governor: 1.820 watts (+3.9%)
>>
>> Kernel 6.13: before "cpuidle: teo: Cleanups and very frequent wakeups =
handling update"
>> Average Idle Power: teo governor: 1.752 watts (reference: 0.0%)
>> Average Idle power: menu governor: 1.909 watts (+9.0%)
>
> Thanks, I'm just going to drop this patch then.
>
> If you don't mind, I'll have a couple more teo updates for testing.

O.K. I'll watch for the patches.
Plenty to do in the meantime, acquiring baseline data and continuing =
with the:
"cpuidle: menu: Avoid discarding useful information when processing =
recent idle intervals"
patch set portion of kernel 6.14-rc1-p



