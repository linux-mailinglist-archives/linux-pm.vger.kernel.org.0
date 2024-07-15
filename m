Return-Path: <linux-pm+bounces-11087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F209310E0
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 11:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F144283194
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 09:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6F5185E64;
	Mon, 15 Jul 2024 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcnYtGy4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C9317C7C9
	for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034588; cv=none; b=J5+nr+joobyS7mbILQlVfKgUdoykBSXsqgpDr5DodSY/9N5dmDNwBe1ygyedjPunFhxgiOOnrSP/YnoyyZpsFBEMllTUM96PLlJKx3KsGVp4UxBIiNIGBE+HXMsiTcim5WJOazP36+IkkJQuYwEmRnMKsW1OBuJAeAUa4yYeMzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034588; c=relaxed/simple;
	bh=u+Gaa0hibGb8iA3gN6UB9Fck2zCztXz6k5FGOnbEuUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvTKU9utI25L/orBGdttD0qMxq5WNNSZh+aazwhucw4i+/O24lY9/FzBpItO1qWFEc7tUwC5dUi/ejcvUWzsKMrk/B7MuWRfqUG/ss//LWvdyv+zTREvhG7m5j4XJK8Ic+aVmdAY/AIzSJLaUstRlXxAPFuVsYp+fBBgbZoUD6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xcnYtGy4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42660b8dd27so26862985e9.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 02:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721034584; x=1721639384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+3B6jB8UMroqJ2Yc/1gLAFE4gd/G0YdH5HhxS6qLOew=;
        b=xcnYtGy472lUiPqLeQZaIqzpvnyS9w9FgeUvynpJcLdf7GPgzJjwFUfZAWbtGhJBbm
         QOoGLCijVZkAzobxwoJ3kb0QBb0xxWloUaEbVYki2HFL5LD1Iy/0G2J8FstygyvpC29J
         zHOcEHL8UFIkrYud8K2aqEAIS/wWLASfrvBYXOln7p6HeK0igSg+T+Uno0RJnoSHBIql
         dilDAkE6N0BM510SWTO6XCIvmoORlzCFTXSm0L/zYY1vH9y1vlQWjT8mi1gXyjAryXxv
         9q+BPGtuzP6A8XMOyO6CZimXQwEQM/D9F797ay86cspL3HKK07894mwmTJxwNAgBt/AN
         NQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721034584; x=1721639384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3B6jB8UMroqJ2Yc/1gLAFE4gd/G0YdH5HhxS6qLOew=;
        b=Gq97NJTHASB1LaPvU5X3S9Pr/CPZMXkL80P1ZJlFVH5iQsTnCeN7kPOxhvxD/f59W+
         VnIX9YRI8WETRPPJvIpvhvL1wxIxfN6NyFhHfxbJ/u14teJbPYckA9ywuZlqSYUZsL4t
         lvj/nDoKsPwJY2DW/TfuubXWe4fp+3/Hj3MJjJEuSeKzuo3lfCL3S8wxtli5fXBMXzh5
         yTtKjmOIzGshf2oWhhFdX7CUIw1pec8xwifpYJwqxPcM8LbiAiNoO7COaYsXq/xDai1K
         gn0qO+T7LLZy+h5CyXljirTDiCOjEeSCkBUTczlxZ/09YrlkInUN4kQCqr5m5F4KctSA
         JO6Q==
X-Gm-Message-State: AOJu0YzQOmpQRAwVMmpMcySpYhh7VuUVzoNrBFY82Zh0OVE04Os99D9Q
	Bywl58k3XCldhcakISmt6C4/J7v37chISVqH6b7e5H+VO3w4DvKtB6chh7WcL9o=
X-Google-Smtp-Source: AGHT+IHoknIsEXpesRP/qX2XWO81Tb0GhanCjhRsodiU3YItQHNxx21jIEKs66uJTiHHN8J6aJ56mg==
X-Received: by 2002:a7b:cd98:0:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-426708f1d94mr128457725e9.26.1721034584503;
        Mon, 15 Jul 2024 02:09:44 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:e709:abf9:48b3:5079? ([2a05:6e02:1041:c10:e709:abf9:48b3:5079])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-427a5edb489sm77959745e9.37.2024.07.15.02.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 02:09:44 -0700 (PDT)
Message-ID: <4d7e11a7-b352-4ced-acee-b5f64e3cd0b6@linaro.org>
Date: Mon, 15 Jul 2024 11:09:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Eric Biggers <ebiggers@kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>
References: <6064157.lOV4Wx5bFT@rjwysocki.net>
 <20240715044527.GA1544@sol.localdomain>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240715044527.GA1544@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/07/2024 06:45, Eric Biggers wrote:
> Hello,
> 
> On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()
>> if zone temperature is invalid") caused __thermal_zone_device_update()
>> to return early if the current thermal zone temperature was invalid.
>>
>> This was done to avoid running handle_thermal_trip() and governor
>> callbacks in that case which led to confusion.  However, it went too
>> far because monitor_thermal_zone() still needs to be called even when
>> the zone temperature is invalid to ensure that it will be updated
>> eventually in case thermal polling is enabled and the driver has no
>> other means to notify the core of zone temperature changes (for example,
>> it does not register an interrupt handler or ACPI notifier).
>>
>> Also if the .set_trips() zone callback is expected to set up monitoring
>> interrupts for a thermal zone, it needs to be provided with valid
>> boundaries and that can only be done if the zone temperature is known.
>>
>> Accordingly, to ensure that __thermal_zone_device_update() will
>> run again after a failing zone temperature check, make it call
>> monitor_thermal_zone() regardless of whether or not the zone
>> temperature is valid and make the latter schedule a thermal zone
>> temperature update if the zone temperature is invalid even if
>> polling is not enabled for the thermal zone (however, if this
>> continues to fail, give up after some time).
>>
>> Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip() if zone temperature is invalid")
>> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Link: https://lore.kernel.org/linux-pm/dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org
>> Link: https://lore.kernel.org/linux-pm/2764814.mvXUDI8C0e@rjwysocki.net
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> On v6.10 I'm seeing the following messages spammed to the kernel log endlessly,
> and reverting this commit fixes it.
> 
>      [  156.410567] thermal thermal_zone0: failed to read out thermal zone (-61)
>      [  156.666583] thermal thermal_zone0: failed to read out thermal zone (-61)
>      [  156.922598] thermal thermal_zone0: failed to read out thermal zone (-61)
>      [  157.178613] thermal thermal_zone0: failed to read out thermal zone (-61)
>      [  157.434636] thermal thermal_zone0: failed to read out thermal zone (-61)
>      [  157.690774] thermal thermal_zone0: failed to read out thermal zone (-61)
>      [  157.946659] thermal thermal_zone0: failed to read out thermal zone (-61)
>      [  158.202717] thermal thermal_zone0: failed to read out thermal zone (-61)
>      [  158.458697] thermal thermal_zone0: failed to read out thermal zone (-61)
> 
> /sys/class/thermal/thermal_zone0/type contains "iwlwifi_1".

Does the following change fixes the messages  ?

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c 
b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 61a4638d1be2..b519db76d402 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -622,7 +622,7 @@ static int iwl_mvm_tzone_get_temp(struct 
thermal_zone_device *device,

  	if (!iwl_mvm_firmware_running(mvm) ||
  	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
-		ret = -ENODATA;
+		ret = -EAGAIN;
  		goto out;
  	}


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


