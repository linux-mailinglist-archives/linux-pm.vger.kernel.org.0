Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A07D84201
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 03:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfHGB4t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 21:56:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44113 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfHGB4t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2019 21:56:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so42496579pfe.11
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2019 18:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h3YaDPv00/avJlZSQWNbmVylhizhO/sYz7AvHGg5w3g=;
        b=YY7tqnZ+65cWDTGrXQYMsKenjk6zyIZEwv6Re4lGRIS94mFNvInPYITvMPTY//yUqI
         9Wwd4DxP1TI9+6oScZI8kWYuQiMoufUX/xAxIn5D60MhQDsngVqhZRpxAH+jiH8FKgOx
         M2Fw7sj9KCKZcaPx7xW8sP4oIdfVzLxqe71LqiXSkOBGvUyq1ijC1tYb3goxSMR7yJA0
         4p9OJfGWAAzkqCzJUh8ZrfeJuRserJqSasn47MUShrK9WIEEsmDclSi+bI3U4C6hHOlx
         pcQwYkETNEV1rVfhYLj7v8ynVdiKqs4Q/px/8xP0HMdBoEQ7roisQosHN51mDw5/X0Z3
         LfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3YaDPv00/avJlZSQWNbmVylhizhO/sYz7AvHGg5w3g=;
        b=Yhv1cstBzxkU5VbuhkOdll/zVhLK9PnKSFuWOUMMLzgeCV59KJwKSBEuyVVYY2ofuc
         afPx8p4xhUSfH0blJrVq/JoVfu2TzH6cXsW2vMBbkfoiavsFM7kijDaQFRbUtr3HhXTT
         he8DHg2ob1uD0QaOnQQQJepgZzeLKTbAVcJ/vinTGuQ4iG7xpUnHV4LG73PrebCwdSWo
         l5S4ewMrU+j4xJlIY0RxEItQdW7ECVEMWjmXCzunD9/u6pqUB55t4sHL4klt4AGOlpXs
         c7reyfkFfHU2IrLQci5dQCQbFz82Ks0AkUcjVvWeixtOh7lsmQ9zsYYb6/aiSxdk5Gpm
         U6Cw==
X-Gm-Message-State: APjAAAX2kHuYWoyGfxWf4wrIVjoYipOmrGhhTTf7xNNo0XSqm24diAm4
        my0q+DpIAJcKXHIpUAQtTQ0=
X-Google-Smtp-Source: APXvYqxYxMbTzKIxMJUtX59dFmmz63+VukwwJxRuzWscI+1vhHdRSQ560BMiKem+1X1ZTovnUkuL7A==
X-Received: by 2002:a17:90a:2190:: with SMTP id q16mr5842498pjc.23.1565143008832;
        Tue, 06 Aug 2019 18:56:48 -0700 (PDT)
Received: from localhost ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id t9sm94081335pgj.89.2019.08.06.18.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 18:56:48 -0700 (PDT)
Date:   Wed, 7 Aug 2019 09:56:37 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH RESEND] thermal/drivers/core: Use put_device() if
 device_register() fails
Message-ID: <20190807095637.000021f8.zbestahu@gmail.com>
In-Reply-To: <6135a0d0-9dc5-7b85-b014-6131f67332fc@linaro.org>
References: <20190806020221.8504-1-zbestahu@gmail.com>
        <6135a0d0-9dc5-7b85-b014-6131f67332fc@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 6 Aug 2019 12:26:18 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> On 06/08/2019 04:02, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Never directly free @dev after calling device_register(), even if it
> > returned an error! Always use put_device() to give up the reference
> > initialized.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---  
> 
> Thanks for catching this. Instead of adding a new rollback block, can
> you do a cleanup in the rollback routine and then add this patch with
> the proper label at the end of the function?

Ok, i will try to clean up the rollback code in the v2.

Thank you.

> 
> eg.
> 
> unregister:
> 	device_unregister(&tz->device);
> release_device:
> 	put_device(&tz->device);
> ...
> 
> remove_id:
> 	ida_simple_remove(&thermal_tz_ida, tz->id);
> free_tz:
> 	kfree(tz);
> 	return ERR_PTR(result);
> 
> 
> >  drivers/thermal/thermal_core.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index 6bab66e..ffe5d8e 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -985,7 +985,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
> >  	result = device_register(&cdev->device);
> >  	if (result) {
> >  		ida_simple_remove(&thermal_cdev_ida, cdev->id);
> > -		kfree(cdev);
> > +		put_device(&cdev->device);
> >  		return ERR_PTR(result);
> >  	}
> >  
> > @@ -1292,7 +1292,7 @@ struct thermal_zone_device *
> >  	dev_set_name(&tz->device, "thermal_zone%d", tz->id);
> >  	result = device_register(&tz->device);
> >  	if (result)
> > -		goto remove_device_groups;
> > +		goto release_device;
> >  
> >  	for (count = 0; count < trips; count++) {
> >  		if (tz->ops->get_trip_type(tz, count, &trip_type))
> > @@ -1347,8 +1347,11 @@ struct thermal_zone_device *
> >  	device_unregister(&tz->device);
> >  	return ERR_PTR(result);
> >  
> > -remove_device_groups:
> > -	thermal_zone_destroy_device_groups(tz);
> > +release_device:
> > +	ida_simple_remove(&thermal_tz_ida, tz->id);
> > +	put_device(&tz->device);
> > +	return ERR_PTR(result);
> > +
> >  remove_id:
> >  	ida_simple_remove(&thermal_tz_ida, tz->id);
> >  free_tz:
> >   
> 
> 

