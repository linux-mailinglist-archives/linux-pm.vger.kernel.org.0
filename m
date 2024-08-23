Return-Path: <linux-pm+bounces-12795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E745D95C664
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 09:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65716B2558A
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 07:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB97131BDF;
	Fri, 23 Aug 2024 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I6vOtMdy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB64D13B580
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 07:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397421; cv=none; b=CuScTAL29PFhYNZyP8sbjBcEcOOlc6VQ2QaWiU7HgJauIhCrVPTFt+eVN1BxamD6dpwFia63Dtl8/P7DbkxTQmdgi/7hvVFcDW8h+omaAdoG7smaicUOzBK4ORorAT8JrA0Z6IbL+2rZCtI5fJWXhOvMqrJ9X+y4vFiq4sIEpzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397421; c=relaxed/simple;
	bh=D3ZPXgYER7sM+rsk0jLrTxbAiwVH0QlqRKhIneBJkbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGML1nRddgIvOvvTk/55mXgGZQZJgpc/tHNhL7M7StJ5BLo0rfrGcsa2HcLuYw/qn3rb838iBmz4amYvxwtHMYViGNyuPt8PR9AHEOW5EMiCFeHhL5MBwgYiFPLfJdnncWO9a/z7qCQ7Ffy3pkmKhAZfHlNF10xdKdcysGcEHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I6vOtMdy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37186c2278bso1462414f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 00:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724397418; x=1725002218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZroqZKgF6RWL9lH5GbbgiY0GkBOa3t42/yZ1y/JKV8s=;
        b=I6vOtMdy7QLezAZFJR9APJPWs64UH12Q/K53RF1HRuwHxb2GeSJeGyFG3UKWAemdr6
         tff0rR070p1z/8EO8KNlYg5u8UsbtO/4ppNxbC1BYChnKnv4Y4JNwvYoZhLcHqs9lvzo
         /myXOkMHH0rmwwBfcVt4wfrKQppCeW/Z4EssXvN9CGqnIn4C2GLb3uAicqVZyPvjMslH
         /9feQRh0G39vYH7fiQM75uM1Mh5VM/Zgu+953nJMjX84wB4eHAfMfnVHD82R6RPvAaaN
         Vs5VN84YwU3GNm92LJJudEKXypff+EGD5TbEBHML2W+Ye93cr/aqqFoFCJ3PJwJ740xA
         7aBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724397418; x=1725002218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZroqZKgF6RWL9lH5GbbgiY0GkBOa3t42/yZ1y/JKV8s=;
        b=Fx18LNfHH4n4qYsLjCCQIs7hPid4AelEMCgT45PQ9332F79i10z20VmNB7rUOEtCwS
         VXc+UzpM62ImHpu0B2M1edE58mpAh2qbn5GS2WMsy9ZlVmYVqNz6R5KpgoZhxv3gUuBa
         n/Hi4XdF28PHE+bmDxwQpcvNKvD0CC/LqU5r84p6S/JXcafNFjGO33jlOKpcWt5yJuWT
         NYXMMnvl/AygA5004egnu2vFQY4gvN1SgU4N6RnYRGzsnAfNcqFfOLdy1qBGqhr6xfov
         HqIb0m2gy4xe53e/FxuLld4XuEPAJ53/ru8sqZ2Zn7WVJe9YWNTh7ZXQlTllnVxeFElQ
         vT1A==
X-Forwarded-Encrypted: i=1; AJvYcCVExUSIzM2CwZp2+UxkFNIEVRzMU02ZiYk0qRdxwU1euZtN57AvQP4NI6dFLTZykvYZJKdDz7h3ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb4z19WriZj+tc7g16RQ1trP2K9z3fDfgpA6gISQLoQ6cj2d/8
	/sp/fEh3/0cEypSAe4FGyvHgI37x4Yle187rXPQbotGzjq1ZdmOpPmo4thck0BU=
X-Google-Smtp-Source: AGHT+IEupqcfwgNbisPuJPLQ8mx1EE5hDp1w08he6BJYNcYqIMp0sC1NXTx8A0K/QugnAOSAvScejw==
X-Received: by 2002:adf:cd12:0:b0:366:ee84:6a77 with SMTP id ffacd0b85a97d-37305254515mr3346376f8f.3.1724397417775;
        Fri, 23 Aug 2024 00:16:57 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42ac517a68dsm50212155e9.33.2024.08.23.00.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 00:16:57 -0700 (PDT)
Message-ID: <3d1384af-b51e-4441-8116-2bd52d823aac@linaro.org>
Date: Fri, 23 Aug 2024 09:16:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] thermal: core: Drop redundant checks from
 thermal_bind_cdev_to_trip()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>, Huisong Li <lihuisong@huawei.com>
References: <12516814.O9o76ZdvQC@rjwysocki.net>
 <4607540.LvFx2qVVIh@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4607540.LvFx2qVVIh@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/08/2024 21:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since thermal_bind_cdev_to_trip() is only called by
> thermal_zone_cdev_binding() under the thermal zone lock and the latter
> is only called by thermal_zone_device_register_with_trips() and
> __thermal_cooling_device_register(), under thermal_list_lock in both
> cases, both lockdep_assert_held() assertions can be dropped from it.
> 
> Moreover, in both cases thermal_zone_cdev_binding() is called after
> both tz and cdev have been added to the global lists of thermal zones
> and cooling device, respectively, so the check against their list nodes
> in thermal_bind_cdev_to_trip() is redundant and can be dropped either.
> 
> Link: https://lore.kernel.org/linux-pm/CAJZ5v0jwkc2PB+osSkkYF9vJ1Vpp3MFE=cGQmQ2Xzjb3yjVfJg@mail.gmail.com/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

