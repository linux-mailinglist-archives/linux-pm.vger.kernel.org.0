Return-Path: <linux-pm+bounces-12643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BCA959EEF
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 15:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B591E282CEA
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345741AD5CA;
	Wed, 21 Aug 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LvhdlmKD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6495A1A7AF1
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247759; cv=none; b=RkYHcfrG72VnTweZfGodSRvGUv25SfH7XsQBlEhwAOdNENDb3n1YgMW50Jp1vyUZNzNih+/TZL+iSTg0aTzlVjFgrXOqTYVW0v3U9pPYdinwKl44XmdCHmn6/4jXu08p24H8Jc8lMR/6cnLIgc92/0wq3GMj805SC9V6bqnkaa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247759; c=relaxed/simple;
	bh=QONK94iRvdLCkFzKX0e/7PlO/nG9joY+JgRsY16DFNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0PTX7mFo0s1Kg/4iC4vQL6q9xefeMWROWW5xz7pU1zL9M7lHX54U9JqhcbMU8NXOA+pKcx48H1DD/IpBZuQlpj9P9jibK1ncuRPXhXKBkHNB8MtHlXsXUmfj29+5h8uWRY3DffuP2BjK+fqMud/Dyx1KaiZlDu/Gn1I5rfL1gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LvhdlmKD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42ab880b73eso16017025e9.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 06:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724247756; x=1724852556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VJsppgPirLly3GD0IN/t04cO41JiGSW1iAo56M7EyD8=;
        b=LvhdlmKDFG5xKXdQXlVcZ6sBjFW+T5OF+qP5fw30CCCJJMOu+Vw3Kg1C8K6F/+ymor
         IdTDxR5Tth2Q8GUKcTKLH0ga1ipJ+hmQm6NqCO8Y8dPa3eeDKl4jb7MKrT0rNBqHleqq
         prxLgTDAqjMWMLNotOmT+5AYE2xI5EZLobCVrbgIHT6AGfMTWE6yvMKDHn3R7Yk9zRDN
         hudONAX/NJlCigbk6U508Mt59P+aUBpJlLQ9XILD1DUSkXdVWsNMudMqAFZVF/eTOOWW
         eazNQkDR9v9iB9WIoVJleQzqMuPDDIvYMDrUCsTw6N/ovvcViZN4kZxZGdTuoWdtAX6J
         SJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724247756; x=1724852556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJsppgPirLly3GD0IN/t04cO41JiGSW1iAo56M7EyD8=;
        b=SbTnTgU7kYTASrxxTwk3Ii4PZkgym/qDabGAGMQ0h/ALKMadqxjUWE2rGZb7WpFouQ
         jnY2g//y/c7ATchgvYT7a1kX2vzg5R7btuxSHYWm8Ssv2ZkbFyKIAHmEH3cOCTKnayRP
         FYOzVYMq1pMN1Cr5zRpYKTG+/uy/MObT5AgI231nIV4GyPacCl4M1B2f5UFXBiUC6hZQ
         6H7kUWNOwgpHJbXxRb6mglsFCJhOTsVaaafYeo2C7KI4o5CwIsPHrqtLllUxuF6Ymt6I
         Lxli/lXH+eEJL788LWEMDGsc7mO6jFKS8Px+TzzrtCh8/Sp2e9QcLHnF40dZBOB/7y68
         s9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUlw9CeBQl5agCjo1/Nm7/57ZmBDO5Kfm6NoWZ394ctyK4Vx8PA/yvhybIvLr/uFO2lIcWj04RCrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlMZ/OarND9PNJspxyTKfyVQhJsulbTCwNC00BFKYB2z42JIBT
	Quo6EkG3w1xxPQVcCCTn+Nxesp4jvb2A1lIS9Bz2FjdcGKxEyTpwwTQo4YiMWk0=
X-Google-Smtp-Source: AGHT+IFVPMQaCNHXE33yxUqjZrAbeBWCgU3RtQoYGtUEjlamY69VErH1gKWoM3Hgdn3POZ4E1/1oog==
X-Received: by 2002:a05:600c:1f85:b0:427:ff7a:79e with SMTP id 5b1f17b1804b1-42abd21323fmr17223155e9.16.1724247755140;
        Wed, 21 Aug 2024 06:42:35 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42abefc63c4sm25847905e9.29.2024.08.21.06.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 06:42:34 -0700 (PDT)
Message-ID: <6c60c236-c0c2-49a6-a2f1-9d588a81681c@linaro.org>
Date: Wed, 21 Aug 2024 15:42:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/14] thermal: imx: Use the .should_bind() thermal
 zone callback
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <2485070.jE0xQCEvom@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2485070.jE0xQCEvom@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 18:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the imx_thermal driver use the .should_bind() thermal zone callback
> to provide the thermal core with the information on whether or not to
> bind the given cooling device to the given trip point in the given
> thermal zone.  If it returns 'true', the thermal core will bind the
> cooling device to the trip and the corresponding unbinding will be
> taken care of automatically by the core on the removal of the involved
> thermal zone or cooling device.
> 
> In the imx_thermal case, it only needs to return 'true' for the passive
> trip point and it will match any cooling device passed to it, in
> analogy with the old-style imx_bind() callback function.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

