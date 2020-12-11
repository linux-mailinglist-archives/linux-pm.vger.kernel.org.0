Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45612D711B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 08:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbgLKHxb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 02:53:31 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42662 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgLKHxG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 02:53:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id v22so8339578edt.9;
        Thu, 10 Dec 2020 23:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NA73H9hnW7ZffMvP0dVM78dWrLcP2b5rGyJPIWWT4EA=;
        b=lYxvYIt5i8V3ndDPFFM/liTvHsMApYwEQKdf0bKmfJXHVrs9YpxUig2S8nO5KHeYus
         +6aka/zHG1YPaewwNhAbApYLppdYbZyecOEeDFseFr75LzhAVu0UgTBGfqqqyxdTfx07
         DgZ8LQk1k2z/X/7acwNzJbpARTETE0zHTP5jQMK9tXR4Zi9hzujlbr/MuZacZpEx7AiN
         Lsq9i2F149Kqg2eABFF8dnVMsKjHtd/gEeiFQjhAk8XjkOS6LMJGgsgs/D18bb1veX1y
         sn5VmPqCwKLllYp0iwjNH4FoXj+Qu7xobCxM0qEywN4MqJu/f3iydtAV62SzGZruISmj
         TF3g==
X-Gm-Message-State: AOAM53294Rzg5p37RdmhsP7SyOdnuG76NQHyNy1H9RJv4T8FbB27k0vt
        s5RWcw1bohEN2eBHnzGLFu1CjdaBgeU6jA==
X-Google-Smtp-Source: ABdhPJyTWbPM+348VosHakJYqfDpz/oGKjIRozphEEvJlHWB5uxMlDSi3Z3S+vfb920NixjMPRQwfQ==
X-Received: by 2002:a50:e80c:: with SMTP id e12mr10135558edn.288.1607673143900;
        Thu, 10 Dec 2020 23:52:23 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id d14sm7546069edn.31.2020.12.10.23.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 23:52:22 -0800 (PST)
Date:   Fri, 11 Dec 2020 08:52:21 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [RFC 18/18] power: supply: max17040: Do not enforce (incorrect)
 interrupt trigger type
Message-ID: <20201211075221.GB4346@kozik-lap>
References: <20201210212534.216197-1-krzk@kernel.org>
 <20201210212534.216197-18-krzk@kernel.org>
 <20201210221600.anob3tojbawjhehs@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201210221600.anob3tojbawjhehs@earth.universe>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 10, 2020 at 11:16:00PM +0100, Sebastian Reichel wrote:
> (I shortened the Cc)
> 
> Hi,
> 
> On Thu, Dec 10, 2020 at 10:25:34PM +0100, Krzysztof Kozlowski wrote:
> > [...]
> > index d956c67d5155..f737de0470de 100644
> > --- a/drivers/power/supply/max17040_battery.c
> > +++ b/drivers/power/supply/max17040_battery.c
> > @@ -367,7 +367,7 @@ static int max17040_enable_alert_irq(struct max17040_chip *chip)
> >  
> >  	flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
> >  	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> > -					max17040_thread_handler, flags,
> > +					max17040_thread_handler, IRQF_ONESHOT,
> >  					chip->battery->desc->name, chip);
> >  
> >  	return ret;
> 
> 'flags' is unused after this change.

Indeed, thanks. Kbuild also complained now on my github branch. I'll fix
it in v2.

