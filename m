Return-Path: <linux-pm+bounces-1143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00D8812C70
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 11:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0721C20B1B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 10:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD14439FE9;
	Thu, 14 Dec 2023 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHpRpzF6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55030B2
	for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 02:05:08 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c236624edso78383965e9.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 02:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702548307; x=1703153107; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EHL6gd+5RkLTCPxIRuaoKWx3/qtEjaNd+44Gwf+jPsI=;
        b=dHpRpzF6qEGCfWqSDJ7sI2Mb7lQNd9hQ0GoDILuHI0wkdnXLNBGs1DzjSBF3Rl2NcJ
         wExSaCXGGsYOigmHB/EDsgwvaGAE88bTuhVwmLTdKEw5qL62/t0bAfzJjo0Py+xFNbcV
         40un9SS0NRm87QjTOiIkzMRIAqcng15bxgGNFKPBrYBhUJblpoewj2Bp7+kSmweRKLjF
         Lgi2ZfmdpCh8Eyfa6VHYn8gjDxXqn7R8YRoagl3WX8JfC5ubR94C4GShDkTc/Lmz+Kfm
         S/E3Rgzu1wkoEMvIYryP/i1jMw5OJH22adqL6kaD14FAdYIm88pupKQNP5H47YHpheMn
         OkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548307; x=1703153107;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHL6gd+5RkLTCPxIRuaoKWx3/qtEjaNd+44Gwf+jPsI=;
        b=PT0zsFL+KFrynTr/kTwuOT2L6Wn8iNFWXxUcqiefaEuUSMIN0xoPQPS2hzvZN9W6qQ
         ZMqWMUj/ypTtZJH2Q+6A8RUJMGqRec58nJGkItRvcsxyJ5VslvKnau6CodVsWG1/Yjxo
         Qxe1eSNr9S7ywiYwpT1i2ys8Mwrwbq6ReUNXifEKn81DEMCzRhmUjRSd+cEH8jfVx19g
         hDx/4CoKYsq8tEi+xJUdIbwXgIuuALVxCQIt5GyYh1FAO8zYVsLzoR835MAkFrXSaw8b
         9aUrkaJ/LRYOngxUUwKAX/S14CH8p7k3cVbZbIv6R1MFybEtAlhTdf1IsMJO0yTqdcZC
         a6Uw==
X-Gm-Message-State: AOJu0Yz8IPNrsAm6tArH0JEK4HaFAo4WJIpfnLP6IEn+YcKXNWPMUw+/
	jyVrCuMkrhKeQ1IAcSHoBBnWVA==
X-Google-Smtp-Source: AGHT+IEUrvRLQTz5xcOfn+vPIvgX1NyVPVWfHfwCVcZMecqm0y3dpLK2sU3pl3afS9KxQ3NuHHni5g==
X-Received: by 2002:a05:600c:43c9:b0:40b:5e21:cc1b with SMTP id f9-20020a05600c43c900b0040b5e21cc1bmr5014906wmn.70.1702548306642;
        Thu, 14 Dec 2023 02:05:06 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id s5-20020a05600c384500b0040b632f31d2sm24319267wmr.5.2023.12.14.02.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:05:06 -0800 (PST)
Date: Thu, 14 Dec 2023 13:05:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [bug report] thermal: core: Make thermal_zone_device_unregister()
 return after freeing the zone
Message-ID: <b8e0ffcf-a09a-4f60-8d93-95e3fa086f3f@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Rafael J. Wysocki,

The patch 4649620d9404: "thermal: core: Make
thermal_zone_device_unregister() return after freeing the zone" from
Dec 8, 2023 (linux-next), leads to the following Smatch static
checker warning:

	drivers/thermal/thermal_core.c:1500 thermal_zone_device_unregister()
	warn: freeing device managed memory (UAF): 'tz'

drivers/thermal/thermal_core.c
    1490 
    1491         device_del(&tz->device);
    1492 
    1493         kfree(tz->tzp);
    1494 
    1495         put_device(&tz->device);
                 ^^^^^^^^^^^^^^^^^^^^^^^
This check is based on the rule of thumb that probably this put_device()
frees tz.  I tried to read the code to see if that was true, but ended
up with even more questions.

    1496 
    1497         thermal_notify_tz_delete(tz_id);
    1498 
    1499         wait_for_completion(&tz->removal);
                                     ^^^^^^^^^^^^
Use after free?

--> 1500         kfree(tz);
    1501 }

tz is allocated in thermal_zone_device_register_with_trips().  Here is
what the clean up looks like in that function:

drivers/thermal/thermal_core.c
  1389          /* Update the new thermal zone and mark it as already updated. */
  1390          if (atomic_cmpxchg(&tz->need_update, 1, 0))
  1391                  thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
  1392  
  1393          thermal_notify_tz_create(tz->id, tz->type);
  1394  
  1395          return tz;
  1396  
  1397  unregister:
  1398          device_del(&tz->device);
  1399  release_device:
  1400          put_device(&tz->device);
  1401          tz = NULL;

I couldn't find the release() function.  But this code assumes that
the put_device() does free tz.

  1402  remove_id:
  1403          ida_free(&thermal_tz_ida, id);
  1404  free_tzp:
  1405          kfree(tz->tzp);
                      ^^^^^^^
This should have a NULL check.

	if (tz)
		kfree(tz->tzp);

  1406  free_tz:
  1407          kfree(tz);
  1408          return ERR_PTR(result);
  1409  }

regards,
dan carpenter

