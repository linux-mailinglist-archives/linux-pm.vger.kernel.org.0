Return-Path: <linux-pm+bounces-12605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3E2959689
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 10:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F24282903
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BBC1A7ADB;
	Wed, 21 Aug 2024 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jk+g1Oug"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F361166F29
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227160; cv=none; b=NEjbCKiqfauORdtk+YPnJHzyIjN13QF6MY27dPyGPK6z8VN0heTwSoFxBPA/Em/Vuj4mqoEipoptILB8vCY+jFBsDfZO/QC1pc/TkUis8wqaZvfCXXtjBW0uwE99mAqljuiP+2msu+PKeBG96So+RoiN74mQT9yqzoaxmSjJpoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227160; c=relaxed/simple;
	bh=vmZoQ1uV1Pp2U5AwGUjIKnclRbitDC4/b0S9tawjIZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQvAT/JE1jUCVwz1vOtNO7+iJO3PpvJPJj+SZZzuOKIq2RywBPs6StYWeppmbHDhyjt8F4TwLh/YP+nsp8QbrEeiZkXqKqjMI0MNhclvqEeONRUf+RX/bAge7LJtznIUUVEGQdizdCHKxroNY6WDYxoy1uNBF6lWN/NCaZIF3Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jk+g1Oug; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428f5c0833bso2617855e9.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 00:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724227157; x=1724831957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSadfNXEdeNozhNQXiSBtdB01rrKvu5hoPMu5VmvLQA=;
        b=jk+g1OugDVmRmGNO2pV75ZELJTjAb/1aalyUrINmhEwRw3q0ekcslrsgOZFtBD7+l0
         pisJ4dTseAmnri0y2ucmxj7847GOrtdPYZo1oYrTi3ykP4ityNbE7Upg9q/gPnoV4Gft
         uEhhrdJ4oxwc2X/UZC0CiIdYBhThXstQu/SMy/AcZc2f1fgROjI7mSzVzw7FX0VPetGd
         +vDM/N0HkRwyLFjeEsO+zPWCd59RreR8F+Ifhf2zyNJCDRy2ZU8BrDEW6SNs6boJEw/A
         TFf0dWb0PDaYJ9P6A5+YV8BslhsIIZ3by6ceEq+D8Wz/NrAdQBCm5uLG0GXoYlyDzXwQ
         3iNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724227157; x=1724831957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSadfNXEdeNozhNQXiSBtdB01rrKvu5hoPMu5VmvLQA=;
        b=PcsBgoh8XEVxEpCxbe5UmbuSGe1PCuyuiDx/7p0h/e9hM95d9y2jSuWpqNjEdiSWTm
         x1J997J+TnNflFcuWuMROUmKlXW6t05z+Bbsfx4aVl/h8RLMmC8gBnLAVSrZNoQ6+obZ
         Dq73RPeDZfhYP5MTxmSJarq7/l9gc15hL8ygBPd4f6AuWozWX3pBbrjnjcBnkEVF9zYm
         tXmf/bwVqnNmDRQ4qknjXcEjp5oRZKZVOkLxUz5w9IQI/dK4ualMgVwGdCgJkCfiqUgn
         PxFSXms5X2/XJwWksygXEC5e/RfO3qgyY0Ly/Fi+VsSsXyHHrcJZasQYxnuawrh73zje
         ElMw==
X-Forwarded-Encrypted: i=1; AJvYcCUfzQwxV2A0v2TuL8n5f7JlHCUe+aLBRd1jccNfMefHAnTU5Zm4wxTU2sdI+hlgPFHp/Wc2k/hK2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtmC5Z8+0oFVnVSX3bWOSzbkuFi3LGYgUGCGnXeue2754w8cEq
	hv5ipUq5Igd1VJlOje9k4ysqzIq6crSPSLAdDmlmgONRsh1nIX1+sfXGUm3tOmM=
X-Google-Smtp-Source: AGHT+IFM8X6ScfzQNt29Q3dK9ZN0yu11nlgXNiQcyfIignJgbUypEk/hFTrj4+VprEYUb2eAB3gEew==
X-Received: by 2002:a5d:538b:0:b0:367:9049:da2e with SMTP id ffacd0b85a97d-372fdd6d646mr785696f8f.8.1724227156030;
        Wed, 21 Aug 2024 00:59:16 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-371898abf2csm14887449f8f.107.2024.08.21.00.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 00:59:15 -0700 (PDT)
Message-ID: <699f1bb5-c3f1-48f7-83bf-184bf6a04402@linaro.org>
Date: Wed, 21 Aug 2024 09:59:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] thermal: core: Rearrange checks in
 thermal_bind_cdev_to_trip()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <3324214.44csPzL39Z@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3324214.44csPzL39Z@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 17:51, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is not necessary to look up the thermal zone and the cooling device
> in the respective global lists to check whether or not they are
> registered.  It is sufficient to check whether or not their respective
> list nodes are empty for this purpose.
> 
> Use the above observation to simplify thermal_bind_cdev_to_trip().  In
> addition, eliminate an unnecessary ternary operator from it.
> 
> Moreover, add lockdep_assert_held() for thermal_list_lock to it because
> that lock must be held by its callers when it is running.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Good catch

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

