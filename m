Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDF818DF37
	for <lists+linux-pm@lfdr.de>; Sat, 21 Mar 2020 10:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgCUJnZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Mar 2020 05:43:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46829 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgCUJnY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Mar 2020 05:43:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id j17so6892560wru.13;
        Sat, 21 Mar 2020 02:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yZ4/TaWU2jVZLNaE2CUJwiwZnKB070p6Wb75TCVLFjI=;
        b=vE71Fwk3rSlGWaemVAsSF4ownbULl8jjJtiwn6GGL3rYjSzEdDmBLQU/Ee3vZLRIBL
         Y3Mt8/x+7liEXsvD17swSwRirSxXrRj6SE/sLeyrmE3Xray93h9lXNogQ1P05/2kZcUN
         DOm07shAYdditI0e/3iPCWevLFj8K+SpoKMbUoN/mj4bvwREhUIwwtOLlf8IjGXzyYhY
         atIxPPa1D/RCEZTHjHR7p2mitYWmJIjRxVgNCB8oEcDTYxPqumzBL9bmEF7Ty5s5MIgH
         xbtkLK4G3Ikzw6n7iXnI767sdDnecubFhKLE/BiW+cwV/4AzWHpwHO9gqWvPSe83E+CU
         IT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yZ4/TaWU2jVZLNaE2CUJwiwZnKB070p6Wb75TCVLFjI=;
        b=CkcCVdJHew7QPKQFQSKHkikaaubBobMFfhZAYAL7ZqTCaJF/zwmijSZ8DIfrXXMHRk
         3GE7h41KIz9ljeTW/sqj68Qjo2fnaQ3ftUihU+Yk4JILo5zY4OC3IQRR3PdePoVLkxsb
         +PLmn+NfOys8WxcGQWhW9FI+2XvhaVwJgqqWySb+LbWSNlW9EQJySxcTVTSr00IREpxY
         JnrJhp1n6U8pvD8Vl0IttyuTUoQkMeyzKTgAVPNJN69L+RSzPe6DLClbrj/02RBOVgs/
         HF3O1NsaUJ6kdS3sgGm11lIS+WZo62haZlITF73kU3wz0fFdhXm3Z7r9e1ZjZ0NQYwRN
         6C+A==
X-Gm-Message-State: ANhLgQ0oTKXq57JYinAV/t+NVT0ivOcAGQ53c7YSoGU/lylwe90ctcct
        +M/rL0nBmvg/031EyIVJr8k=
X-Google-Smtp-Source: ADFU+vvW5sct755NUwifdQuwIgqCdWxkVyjJHbtG94yO4DL9dlchRlivIZgLvO5iFOJ5Gh/Q+CXTqg==
X-Received: by 2002:adf:82a6:: with SMTP id 35mr16709433wrc.307.1584783802797;
        Sat, 21 Mar 2020 02:43:22 -0700 (PDT)
Received: from macmini.local (181.4.199.77.rev.sfr.net. [77.199.4.181])
        by smtp.gmail.com with ESMTPSA id c23sm12867854wrb.79.2020.03.21.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:43:22 -0700 (PDT)
Date:   Sat, 21 Mar 2020 09:43:21 +0000
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: weird cooling_device/cur_state sysfs behaviour
Message-ID: <20200321094321.6taz2d3fbkeo535i@macmini.local>
References: <20200320151055.h32rh5hpnv7xyuey@macmini.local>
 <bbdd32b7-c376-d44b-df2f-a50911592692@linaro.org>
 <96f75e90-9c14-5908-e9e9-979c9d28a898@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96f75e90-9c14-5908-e9e9-979c9d28a898@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Indeed, many thanks for you help.

On Fri, Mar 20, 2020 at 09:17:47pm +0100, Daniel Lezcano wrote:
> Adding Rafael,
> 
> On 20/03/2020 18:43, Daniel Lezcano wrote:
> > On 20/03/2020 16:10, Willy Wolff wrote:
> >> Hi all,
> >> Hope you're doing well with the situation.
> >>
> >> I fill that my board get a cold too...
> >>
> >> When I write to a sysfs node, I have a weird behaviour about the function that is called behind.
> >> This bug appears on an arm32 odroid-xu3, and only after v5.4, v5.3.18 behave correctly.
> >>
> >>
> >> Here my modification to see what's going on:
> >>
> >> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> >> index aa99edb4dff7..a437ae3f4b9f 100644
> >> --- a/drivers/thermal/thermal_sysfs.c
> >> +++ b/drivers/thermal/thermal_sysfs.c
> >> @@ -706,11 +706,22 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
> > 
> > [ ... ]
> > 
> >>         return result ? result : count;
> >>  }
> >>  
> >> +
> > 
> > [ ... ]
> > 
> >>
> >> As you can see, the function is recalled with one character less, until the "buffer is empty".
> >> I don't understand why. Can anybody help me for this thing?
> >> Many thanks in advance.
> > 
> > [ ... ]
> > 
> > Very likely the problem is coming from:
> > 
> >         result = cdev->ops->set_cur_state(cdev, state);
> > 
> > which returns '1' as showed by the traces:
> > 
> > drivers/thermal/thermal_sysfs.c:735:cur_state_store result = 1, count = 3
> > 
> > And because of the return condition above:
> > 
> > 	return result ? result : count;
> > 
> >  the function is returning result, so '1', which is interpreted by the
> > sysfs as "I wrote one character', so it recalls the function with the
> > two remaining characters, etc ...
> > 
> > The problem is from the governor AFAICT, which governor is it?
> 
> I went through the code and I believe the problem is coming from:
> 
> cpufreq_set_cur_state
>  -> freq_qos_update_request
>    -> freq_qos_apply
>        -> pm_qos_update_target =>
> 
> " * This function returns 1 if the aggregated constraint value has changed,"
> 
> 	freq_qos_apply() does:
> 
> 		ret = pm_qos_update_target()
> 	...
> 	return ret;
> 
> 
> At the first glance, it is related to commit 77751a466ebd1 (Nov 2019).
> 
> 
> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
