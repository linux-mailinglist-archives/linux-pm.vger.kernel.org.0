Return-Path: <linux-pm+bounces-5949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA9C8997D5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Apr 2024 10:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E236B212FF
	for <lists+linux-pm@lfdr.de>; Fri,  5 Apr 2024 08:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BDC1514F6;
	Fri,  5 Apr 2024 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="artZWtV9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED3150984
	for <linux-pm@vger.kernel.org>; Fri,  5 Apr 2024 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305864; cv=none; b=QHQkhDlgRCxUNMsNQULz9glNUdiWynoEYjzTFBDO9k8ceGjjjMIldSAipVMui8KMb9QD9vlIu59C5om4ezjSyYT6t/x7jn5TtuoEtRogEDSbzepKJdoma28/neOhgZdoE/SCV5wzHmavWy3vk+1uD8+3Zv0kO4GtU/lq6xCyBDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305864; c=relaxed/simple;
	bh=yxdBB10ArDmSlmE0g0r1a9LmbtngWEnM0SlxQmAvBY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkrvrYbgE9WOO6P6jmPj31nfpAPmG55eWxxUpv05wizRtfwZrn9Abcc/UJs1DAifVw9be6veMEFFu+0y32+AHhCmvVhhmAXggOWX9c4DT0ocb5y6SKFYjtLACrCQSB+G9bBYX8h4Dt4dEM7Mhrc0nciie4j9LNH68qEENxXbR/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=artZWtV9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4163181a7ceso1289655e9.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Apr 2024 01:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712305859; x=1712910659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+yiJOo7/g4gpSdzIrOskjwlXwHDi0ApeHqIT18FSLE=;
        b=artZWtV9YaxV7ecokOgz02QMDGSdua/wB+XoZK/eo3Vh/wC/1cWYBFhS49mM6AhauJ
         GOK6sF+0LTqD+mGqqUuBVuN0RA4ArYbsCsK9XepqP5jjlhM5FHX+0jGZob3uHSgnsHYQ
         11i6RFzuV6mEHKmegfFRkjWqsTIPxE5kG8479OVelXnqTo7Kp3NPmXxEvVpgFDZaTJ85
         QpjyogaqcyZlAIt6Zfu6cy2jKxqAEAgz2czKwUj+wZYsRmyorpa0vC+se23o7jrZ1WT0
         pA8sbdVYL/6FEWrm6bYf64DNNksStpTGatQddBFEsVoFu9QQ5NXW/p27/yVaWokBemL0
         EiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712305859; x=1712910659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+yiJOo7/g4gpSdzIrOskjwlXwHDi0ApeHqIT18FSLE=;
        b=GQ0wWodUsDayETjV+8Zt9+6+8wnWeYUcU+iVUC+CcTPs4NHV3J+w3QMdrd6TV51ANS
         7VzK3DDyNJ9lIaE3/0jJS2dkzfDIJTDA6Bp+As2JUIuIjGhEJsIVBIcpRRRTMLPzLytp
         WahDtw2pDVaAVkBoYcLtBm6yja+KgYGe9e5HCw+OKuhfgnphZipm3oDcod7Jvc0erwSd
         ycgLmlr7VVbL2SmBJ5TLIQRh6AKlxnFHjoHVTWfqP83y1EevEIfiv55DH6fQNZldoeuk
         Cx2C4AhXD78laVDAgWTTwhoHwKs6E0rnXJ+9OeDuFiR2ljKJLx50PSGJWk3rgdWSXLKw
         +UHw==
X-Forwarded-Encrypted: i=1; AJvYcCUNyhaEnfmxHwG16jxmMRwlOdX2C4SzsU2WZR3G6Q6nix9GbofGHQngN3X1uMZFaKG3dRRT6FNVYpDYV1pki78r9QkEa55V48c=
X-Gm-Message-State: AOJu0YyS8IuewVCXlKZshBaqU2nl+zExLahWbeP37APrawqxFX514c7/
	2LDuav+u44838nw4VufEQwRZoysVgd5m+/whDcVMWlrTe5ENm4uAuE1gIu4g2rQ=
X-Google-Smtp-Source: AGHT+IHwzZg6mqbOsTet1vE1TEWA9BHTjUj5nkdl33/YZd+0KsGS7zI4vNLvez40dZEnn1sQDzcRBw==
X-Received: by 2002:a05:600c:1f93:b0:416:2a95:6e8b with SMTP id je19-20020a05600c1f9300b004162a956e8bmr572430wmb.26.1712305859037;
        Fri, 05 Apr 2024 01:30:59 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n8-20020a5d4c48000000b0033e7b05edf3sm1446622wrt.44.2024.04.05.01.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 01:30:58 -0700 (PDT)
Message-ID: <cf1ad84d-3983-4595-aeab-e421bc1f95b5@linaro.org>
Date: Fri, 5 Apr 2024 10:30:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] thermal: core: Rewrite comments in
 handle_thermal_trip()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <4558251.LvFx2qVVIh@kreacher> <3284691.aeNJFYEL58@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3284691.aeNJFYEL58@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/04/2024 20:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the comments regarding trip crossing and threshold updates in
> handle_thermal_trip() slightly more clear.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


