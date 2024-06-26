Return-Path: <linux-pm+bounces-10021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7AD917930
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 08:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7691C2188B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC2614AD1B;
	Wed, 26 Jun 2024 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePbXxdjL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734D413B293
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384651; cv=none; b=nDRVBvl7NPJqAkUqRutdaL6JRt1HwBi38Svp5PuR0teaHIUXN4YAZuFQKUALCGdhlN++hbF8yPMC4XoI1jG7y8AL3vD2l0i72wK5MNCfUCrhexOVhgwUaUvzQJeXF4Go2oB3RI84dSTaKByU1/zTDKFOEc74z9/WQ+W4cbNHb/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384651; c=relaxed/simple;
	bh=FLcyKt6EgwVaUDfbAcHdIg3xP48LE7R/BqXNq11tA74=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=b5EQwruRnYeGyJVBGiztRp4BF/yv0+1wzV/TkPlkb+hDQYAPIZ/HLhyaF1BHGkPDFGi7r3fAoJgk1J7TL1fcUcohELdho0GnnLeTIZJBHUvBOGu1W9VZF3nLr4c+KMzY89ESuguRfoySVEd7abPjdRQSGJ8Oou12tS/23jnlaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ePbXxdjL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3629c517da9so6159302f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 23:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719384648; x=1719989448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlpvcV1YBhbc0/8TsProIi/jn85vef1e6RfWTlqBLz4=;
        b=ePbXxdjLgDvdkHZvyPNb3Pd7GtlacQPQdeHjNXIk8OQxIObhLGg79uqPD11Ta9+G8a
         ASv2yATTzZjzjluywq8j3fPUVkvofOZLgml+BA2N2a3fHRCvIWULtwP0xR0sfGLbmKZ6
         NvPE0tQje2VCcwEiC7AQyJKbtbL12fDVSnn3A6nktYjP+5ZHM4mbcIFurB17Ccusgy3H
         nq3QIYMhWSh3veDDJTA50fb96niNmBftmY+guXLMy/YnJkfIxYDgbg/xEQGVeuDQIMGR
         PkPFsDcTVLo7lGzI1QvZvyS3V/eARgFHp2M86cRa/ABK3p4cD+MDORDTWuIWz96D98F8
         fC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719384648; x=1719989448;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dlpvcV1YBhbc0/8TsProIi/jn85vef1e6RfWTlqBLz4=;
        b=UcwZRJaGa4z1sy8lHTB4qJGvfPqBHiAiNe3HiQiE8W4ApJIb/oD+15raarr8Bj7ECT
         KclYe/Wyo6r0mQhJEWvR4Mb0QcnDggs6mmYCWh2Ve0w4/YfDiwx+dxS83vyDW7g3corY
         CePICL5KPEt8s/nl/0JvTxmyx0NSlfXisQaX79H/nrCMPABiURs1524e6fvQfWv3XyuY
         GL6GMPwkoh70xF9TjngazT4WfHfOgiIKoyh7TAb9kevfvqcIYrR1l9SAOlsiOikW5yL6
         Hetk/iavv1abf7QmF0EE3R0hrheP4DTJYg9GYo1CSdVFJ7j2ehlFs880s9nPPU8K8Xeg
         Htlw==
X-Gm-Message-State: AOJu0YxlgnciMxRTeduIx1f5jjzMupqQ2xHNZyZ30KnQ2Xr252xGFJqn
	Gq3m1pztyNl9QkKGGJzDjJUvt6NBU6AMQPaVXhfzJkonhPQchICDnLYlvs1PYMk=
X-Google-Smtp-Source: AGHT+IG6GvPw8d0PecvCbiCCTua2t0wAnDJob1oY963ScexGf0Up+qjhQxyPk2vm5BV7R/atrjhsEg==
X-Received: by 2002:a5d:6985:0:b0:362:a1e8:15b with SMTP id ffacd0b85a97d-366e949d36bmr8037370f8f.28.1719384647723;
        Tue, 25 Jun 2024 23:50:47 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-366389b8ad2sm14787577f8f.33.2024.06.25.23.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 23:50:47 -0700 (PDT)
Message-ID: <dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org>
Date: Wed, 26 Jun 2024 08:50:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Trip points crossed not detected when no cooling device bound
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>,
 Lukasz Luba <Lukasz.Luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi,

after experimenting different setup I noticed there is no longer trip 
crossed notifications sent to the userspace when there is no cooling 
device bound to a thermal zone.

git bisecting leads me to this commit:


202aa0d4bb532338cd27bcc64c60abc2987a2be7 is the first bad commit
commit 202aa0d4bb532338cd27bcc64c60abc2987a2be7
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Tue Apr 30 17:45:55 2024 +0200

     thermal: core: Do not call handle_thermal_trip() if zone 
temperature is invalid

     Make __thermal_zone_device_update() bail out if update_temperature()
     fails to update the zone temperature because __thermal_zone_get_temp()
     has returned an error and the current zone temperature is
     THERMAL_TEMP_INVALID (user space receiving netlink thermal messages,
     thermal debug code and thermal governors may get confused otherwise).

     Fixes: 9ad18043fb35 ("thermal: core: Send trip crossing 
notifications at init time if needed")
     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
     Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
     Tested-by: Lukasz Luba <lukasz.luba@arm.com>

  drivers/thermal/thermal_core.c | 3 +++
  1 file changed, 3 insertions(+)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

