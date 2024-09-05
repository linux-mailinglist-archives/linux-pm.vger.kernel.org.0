Return-Path: <linux-pm+bounces-13737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3C496E55A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 23:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781A22873C8
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE841AD9E4;
	Thu,  5 Sep 2024 21:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dQZhzunV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315BD1AD5CB
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573492; cv=none; b=VIBCtx12+uwiut+Nv1TCSViMWxn0fXs3sJRUo1kgaEaAgMbpbcSgP2ywueCgISaFuhRl/i7LZZ3Un57jUWNVUFclBtHrQWSBWx5wRA8N1aaV4oIooo579nFR+t4wEkBbyU4mVFGD3uez7YkzitPJ9YNjXvG7us1JJH3Js40aPVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573492; c=relaxed/simple;
	bh=e9rxq9LZX+91CbA6ojRIObEYeB2nV1V6Dz73whegJ1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cwm5tylb5bADOnG7XcQw5wM+prApyMEq9YjPWq2SYve9EzYOU6HjJkSjc26x28QuG8jAHsbBE/4bCH5jDO098PIsSpi/jpPiy8LQeorRLeI+/FqX7IcwUwaoP4u9fu5kY//xMpBOzC1LkX7oIRDI5bY1gRzt0JNZSf+6ftRocsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dQZhzunV; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso961555a12.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2024 14:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725573490; x=1726178290; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=debuxuNcW7Vau/i5ri1+uD5qWokdP8/oPSvRGMK4Oy4=;
        b=dQZhzunVTQ60/9d4z/JGsQAd/R3jMugvuAb0eh1kmrmQo55oP+gHj+SBi3HUtSVzz0
         TD9rblT2U1DvQNpudcWYtQQmM5V2Xc1y/ZJjVjfUn3LCXn/9JYeqk/2u3TbKTI4wi9Y2
         a0dyjrsAgMxMIbI2RBHdfPP0GzkGdLFNylsILcfXFMU/V269jaACefUEpZjY1gd9Z9AQ
         aoiQ7UZsZFoQdYYon9RIgfP/JlQQYjIzG5rK7pI2vXVOgKO1/2zKAVbKEzCXR7JfGJF0
         eM4Tovyj6nkf4UMtLyY+mw5YmBwx34VexDqCEQbdHrf/kpZoN/BMjbTflthZK6NDBA/C
         g4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725573490; x=1726178290;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=debuxuNcW7Vau/i5ri1+uD5qWokdP8/oPSvRGMK4Oy4=;
        b=w/e6/moVcS6Yp7p44IVbXF/PUNZwHw8Q65N6ITH+V0JZFaHOmBO/rCLIC2SnsAnguX
         JqLVlZumt0cU+BUL0Mc2M+g6RwlDR1R9v/OKuVbSmrDqubf6jEIs14yKYzsQbW7OYtyg
         mO/IDo67C60DzIPE2fuucntnOqTie9vdgw3ZxnOMqhQiNYQd+6OyLkEr/TNaQ0IGHZR0
         FULryV5HklbmtkgvOBQrTA+SuI75v1YGkRx7gWyLX00zbfdqnpc9RRyi47LDi2PSTYOy
         rdRGrPvz5yPfcwaUpFaKly/TS9qjTUSmAOUol3JdcB3+ZCVHl7U2RgVwaEEDBEtfdA0P
         YPDg==
X-Gm-Message-State: AOJu0Yw7oYMo9I0J4UqypvnkPyD9HMUwaMvKo3CRzJNJ4K+t7fFOs+Vp
	/9RqwFVBsjLVp3788ve8QHubj3jb+tU00GWbKaKeCmdUhp1UY8xj8/lnMhOCWR5qlKQgMmjA3Ke
	zRX8=
X-Google-Smtp-Source: AGHT+IGTshBMlJFlXsC+frdPM3BZscmeS6VUJgi2fVQqYwOBl4sze3V53Rb4d0wn1FbyDqYcOILusQ==
X-Received: by 2002:a17:90a:f48e:b0:2d8:7a3b:730d with SMTP id 98e67ed59e1d1-2dad501408fmr847011a91.21.1725573490526;
        Thu, 05 Sep 2024 14:58:10 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbff3c6dsm6637a91.3.2024.09.05.14.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 14:58:10 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Vibhore Vardhan
 <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur
 <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, Markus
 Schneider-Pargmann <msp@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pmdomain: ti_sci: add wakeup constraint management
In-Reply-To: <CAPDyKFpH9TQ3P75CXxHmgo+y8z-C_iYCzFzqR93w1Mt9jhFBBw@mail.gmail.com>
References: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
 <20240819-lpm-v6-10-constraints-pmdomain-v2-2-461325a6008f@baylibre.com>
 <CAPDyKFpH9TQ3P75CXxHmgo+y8z-C_iYCzFzqR93w1Mt9jhFBBw@mail.gmail.com>
Date: Thu, 05 Sep 2024 14:58:09 -0700
Message-ID: <7hseudahla.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Tue, 20 Aug 2024 at 02:00, Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> During system-wide suspend, check all devices connected to PM domain
>> to see if they are wakeup-enabled.  If so, set a TI SCI device
>> constraint.
>>
>> Note: DM firmware clears all constraints on resume.
>>
>> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
>> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> Signed-off-by: Dhruva Gole <d-gole@ti.com>
>> ---
>>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> index 963272fa387b..8af907579152 100644
>> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> @@ -76,6 +76,23 @@ static int ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
>>         return ret;
>>  }
>>
>> +static inline bool ti_sci_pd_set_wkup_constraint(struct device *dev)
>> +{
>
> Similar comment as for patch1, should this be a static void intstead?
>

Yes, will do in v3.

Kevin



