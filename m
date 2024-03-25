Return-Path: <linux-pm+bounces-5323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F101F88A822
	for <lists+linux-pm@lfdr.de>; Mon, 25 Mar 2024 17:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BF234244E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Mar 2024 15:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4297D85276;
	Mon, 25 Mar 2024 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z14MSpQV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1F84FAA
	for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2024 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373612; cv=none; b=u6SRpZUFpEr1p3IsA5yNsEbaEEV9OhRxccfhP76vTDvZo6sdZ5pvekeOTRnGo6zEuAcmCxF5VJ7mmFXRGhp/+g9dsJIBuDhhv+EMe/A0vjWar4OZZte2A6F0JEHphqJVmVBWmM6zJ0spKLRi99NAfrQvVjwB5/aNz2XWcu5ch2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373612; c=relaxed/simple;
	bh=6J4ms11BS54iDQjS55AGnBFf/GYY/qcCGClBkwLnZmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcwasC/jG7Xf2sSLhzPI3+GGa5fecmNJRxLDFSd86JBJfwhZAIufLrmGZjNHSm991BA+fjPg6yF8JpH6BbTZD5CUpedPHmJARO+aOdmkoFOK0vx5x2kD0mJ0iDrnDfun45E135z+VBvT0ugTU+yWd8ukt40sCuo0vjfmEX/MgaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z14MSpQV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33ed5b6bf59so3181790f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2024 06:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711373609; x=1711978409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CwWH2jgh9N6G1pyIJIB+90c3Md6W096aoI30rebu5ww=;
        b=Z14MSpQVn/5EGkQt0KKCz1+yW/PAJwvfJCIzQfLpC/okNCR/v7QmkPDgv4KI4cCFRZ
         oakKDDaigaimpNw2a0kwfk/rfUsFZkGUcM0EUBUK7VmJO2TUeH0bi2+oC0qPXkfo36td
         XrFwo1UBlFp+qfYJSaeRl2memKnPZKFI1QkyQ0c8LKTzBG81oMZSmNoclsRgi+zCAhF4
         CIbIZYF7Hw92jad7R0XnLQFsbrASXhWZ0jpmkklYnAbdbUCx989zpgu6Y264x9fO169e
         HoMinBrnSbIzJ1ZA6Adyzlc9jZ9Cg0xsEiUF4QPACduFLR8Xra6u2icyjS2xRfzu/aQC
         LjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711373609; x=1711978409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwWH2jgh9N6G1pyIJIB+90c3Md6W096aoI30rebu5ww=;
        b=GsiRX5pYi+iJE46c/LKpNqLdPlF/ikZsGcFhwYfpgKsyDS/VH6qwzQf/0cq3BEF15v
         TJGN67maA5KcGzmSpNmut3x8jOXHfFiikNnSI/2XBsMd+t6WtIgmroJfGgGduzzN9Hif
         KgiSmua3sA/rhPghr0IMj1XFFCSsHq9Dnsr1tDAAv1oPCwaSYAd6gjtd5xAdUVr26VD8
         Btm64zlfTN4N9xrPUM2I0fEiNQ6bC1Q7O17WhcEXnwwbdmHgjRkbmEmaCDwAdnI1k/Ah
         FdrAZXdv1tnaFZBCSDnOAcb8T1xZV+VLtRdttgO8hrsIAFk0ffOoat2oY78HX1LqLa70
         OwtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhbQiTUzMPmyCDVTYtfUI0PFnztKUh2Y/0/ep0iyGhQbvBT2Ud9wlpmNgxf2ZjRYjgIuCzt7wkyIpe/+HSbm4dIcLeNA2Me7M=
X-Gm-Message-State: AOJu0YwELaahamuR81L5jk7XBO/pPPV47Omah3M9zx29Fy6LjU+oWOJk
	FzMwIJtMjjgjFwvL++XOmRPFWE5yI6/p1NXDtyX/tRX1KI5s/8T+Duf7SA//HWlcj1h3FNDJvpf
	e
X-Google-Smtp-Source: AGHT+IERQHLRf1z384RS5iNzJQb4oon5G+j1OSkjjEVPlN+gsZXzmY0i1TIhUht0CJWRYKp+EH+9vw==
X-Received: by 2002:a5d:54cd:0:b0:341:80ee:22fe with SMTP id x13-20020a5d54cd000000b0034180ee22femr4771522wrv.50.1711373608682;
        Mon, 25 Mar 2024 06:33:28 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c1-20020adffb01000000b00341d186a2dbsm1299633wrr.14.2024.03.25.06.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 06:33:28 -0700 (PDT)
Message-ID: <42ffcfb8-33fd-4ea5-bfac-fa8c78cd1cd4@linaro.org>
Date: Mon, 25 Mar 2024 14:33:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] thermal: More separation between the core and
 drivers
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <2331888.ElGaqSPkdT@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2331888.ElGaqSPkdT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

thank you for this series.

It has been reported a regression with commit cf3986f8c01d3. I'm 
investigating and confirming it. If it is the case a revert may impact 
this series.


On 25/03/2024 14:10, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This is an update of
> 
> https://lore.kernel.org/linux-pm/4558384.LvFx2qVVIh@kreacher/
> 
> which is a resend of the series with one extra patch added.  That extra patch
> is related to
> 
> https://lore.kernel.org/linux-pm/20240306085428.88011-1-daniel.lezcano@linaro.org/
> 
> The original description of the first two patches still applies:
> 
>> Patch [1/2] is based on the observation that the threshold field in struct
>> thermal_trip really should be core-internal and to make that happen it
>> introduces a wrapper structure around struct thermal_trip for internal
>> use in the core.
>>
>> Patch [2/2] moves the definition of the new structure and the struct
>> thermal_zone_device one to a local header file in the core to enforce
>> more separation between the core and drivers.
>>
>> The patches are not expected to introduce any observable differences in
>> behavior, so please let me know if you see any of that.
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


