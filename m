Return-Path: <linux-pm+bounces-8711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FAB8FE725
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 15:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74AA41F26788
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 13:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2801B195F19;
	Thu,  6 Jun 2024 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pxwKEkMC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAB9195B3F
	for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679251; cv=none; b=Jlje12xQcxdHUVzni1NSIp9sj3cTNEOLcjYsO7l1vEbdNwpXJwzDBrJ0pyxKj6XchO6HO4RapZk0gsm/J8nXJL2FpWdAsw9ux3Nw6lpmqPi2sKETG10xGXQqFxNaNTfcOZklz8mrT1gvOHKh1ZEy+/Aq70WD43qfwjrUaN16W0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679251; c=relaxed/simple;
	bh=BdMDCKYOciFtZo4PTTUMFab4UVUl6ecIp67QhNGiFxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/SfzIGzU4pK7o0m9fVCMAsoXxkpWBobWxnOvWqqRE+VJixlG4CG+3xyorz9CYMFgMrFYKBpnuy6IRe1D3GRDyij75ynEypik8s08dP7UiMB69oXRMiyjZl8XA8APYWnmXHk7X3bp8Ws5nEJTlcPwlIxhvLvDJ1vyByTcujT9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pxwKEkMC; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eaac465915so9304401fa.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Jun 2024 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717679247; x=1718284047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xqbTDU5EddtC0TrVAfeU+ERNe8gfqyFv4sZpg6VCoU=;
        b=pxwKEkMCAXQ3w1PmZGCLFJPg73nrIiAPKJ09kyo49i0sr85KLCvLJ1iGVUpouQPxRK
         VtoYUCN/QXLqsdurv1iapN+4l6ku+A7trXHNZCu3LMfJhXstzUuj+pEbAA3gqaTnQ2L3
         yAVINfg0dsSQzCuA+ep21dnQAjJmLgzdVd1f3W/LWMzCXplErGog/26QuCbai80e5mku
         kC7R7eJQNfDF5/w74oTXWwI9C9kE37U3apw+oFiG2ewAbScm2OVbzX5YuIsxFfxAZi/G
         Y4L5YASTKUKdITRxEc2NoBHqk87NfI4sa5b0OL68oA6J9wKMpJ7cA7yaZKPa5+eqeZSB
         CdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679247; x=1718284047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9xqbTDU5EddtC0TrVAfeU+ERNe8gfqyFv4sZpg6VCoU=;
        b=WuDRblrSVH2UpqoKJcm7CgTOhdpDutHcbEsqIkwHhRNir1JtCpgjmx4tu2W7gYJN0l
         YQXPhZzPk+2eDACjOYjCDoGVANu+Abxf67kb3hdjR0/rOAMR7wtQ6oj686C3pdxNRdby
         SJIrDYnT18YHR/he6/shOR7BdteV9LUe6jh7MCXGyCRCEWjwvWxCMifllBRq5oVXTXD4
         Dw3O+wktRQrLQ/DrxZVTbZ4zRh2Skst5HFlwgQMTx7BrlsadasVLmC7oXAM3QNb9dNBn
         9oawSPQNx7++AxgFFHTFoR8WJ8qMLi4p4PJm8AButWYyYhjwOzHRhEXmrUgOxPETk6Oo
         6VMw==
X-Forwarded-Encrypted: i=1; AJvYcCXDX8DPCDgv7AGIdqSXZzj+ztTSv3vkQ/ViQAH0ihbwIVRpNvVAO8z5mWNEyVI2jTd5XaGVELT3hTQ0r5clE5BFh0Fgzlu9MFk=
X-Gm-Message-State: AOJu0YzD0idFG8k9QYfUnQ3b538tS9ispdhOu2nfxUvEpiTA1AWN5IIp
	+HeLFv08vdUi0nDuteFcyRH6e3XJW4uohtph4jab69KCY50SR+2k6vsVYwuXqWAOmXRtTmnbLf/
	zc6c=
X-Google-Smtp-Source: AGHT+IGlDZLXub3zByy5p0lR4DbNs9Rf06mpjjFumk2zfzKdHZ7Rvj7G7Qjl3dOWAdV+S5AdUp9Xhg==
X-Received: by 2002:a2e:9c07:0:b0:2e9:8ac8:b0c4 with SMTP id 38308e7fff4ca-2eac7a6ed32mr28518321fa.49.1717679247427;
        Thu, 06 Jun 2024 06:07:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:f9a9:3740:b905:9995? ([2a05:6e02:1041:c10:f9a9:3740:b905:9995])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4215c19e67fsm21943435e9.2.2024.06.06.06.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 06:07:26 -0700 (PDT)
Message-ID: <5f93f034-f781-47e0-b8ce-3c8407a709f7@linaro.org>
Date: Thu, 6 Jun 2024 15:07:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: core: Do not fail cdev registration because
 of invalid initial state
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Laura Nao <laura.nao@collabora.com>
References: <4569763.LvFx2qVVIh@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4569763.LvFx2qVVIh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/06/2024 21:17, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is reported that commit 31a0fa0019b0 ("thermal/debugfs: Pass cooling
> device state to thermal_debug_cdev_add()") causes the ACPI fan driver
> to fail probing on some systems which turns out to be due to the _FST
> control method returning an invalid value until _FSL is first evaluated
> for the given fan.  If this happens, the .get_cur_state() cooling device
> callback returns an error and __thermal_cooling_device_register() fails
> as uses that callback after commit 31a0fa0019b0.
> 
> Arguably, _FST should not return an inavlid value even if it is
> evaluated before _FSL, so this may be regarded as a platform firmware
> issue, but at the same time it is not a good enough reason for failing
> the cooling device registration where the initial cooling device state
> is only needed to initialize a thermal debug facility.
> 
> Accordingly, modify __thermal_cooling_device_register() to pass a
> negative state value to thermal_debug_cdev_add() instead of failing
> if the initial .get_cur_state() callback invocation fails and adjust
> the thermal debug code to ignore negative cooling device state values.
> 
> Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()")
> Closes: https://lore.kernel.org/linux-acpi/20240530153727.843378-1-laura.nao@collabora.com
> Reported-by: Laura Nao <laura.nao@collabora.com>
> Tested-by: Laura Nao <laura.nao@collabora.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

As it is a driver issue, it should be fixed in the driver, not in the 
core code. The resulting code logic in the core is trying to deal with 
bad driver behavior, it does not really seem appropriate.

The core code has been clean up from the high friction it had with the 
legacy ACPI code. It would be nice to continue it this direction.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


