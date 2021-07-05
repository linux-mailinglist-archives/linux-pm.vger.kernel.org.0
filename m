Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170AC3BB7F3
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 09:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhGEHir (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jul 2021 03:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhGEHiq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jul 2021 03:38:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B64C061760
        for <linux-pm@vger.kernel.org>; Mon,  5 Jul 2021 00:36:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t15so17465137wry.11
        for <linux-pm@vger.kernel.org>; Mon, 05 Jul 2021 00:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=weC1zMZ4iQacKpyErdpDocx69cDmZbkaWvPljQ5YbzA=;
        b=L1VsdV0vOqFrEc4dkuNurFn2LuuZEL5GI5jn/ai/KI32HvFa1nDGknj2FmJsOKJOTg
         JDNkshrinpKYHpQvtsGF1Az2oXMicni5WR9S7YLcrDexnZmt+UFfJO6DJ205zuDZ2g4o
         MSmfNAPkC4GYYqY6xUc/g4JpXzbvUyUXBVKilTDyWdJQZP2XGwww5EraHhIDjkbyBozV
         9C6UmmEzu1z9N10TWYZvbHBjBuzBRcA82q4LWHpDTwXAmZ5W2HFbqFvJFGeZ5UI+C1NC
         ZSiJsKNqg/idk/7J8fvyqT1fARP9tbCliUNfsQ1GNpLGUglwu/9UZ35zWN8QPMzm1aKh
         JRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=weC1zMZ4iQacKpyErdpDocx69cDmZbkaWvPljQ5YbzA=;
        b=HzEMsxGq6JYXDil8KcgoTncIAt1XIlBQCv7o6W2gpkflJUSkCrggWVLq2bHGwkWkbl
         MXquJWZLW+hEUaGiqfHLvx2Iz8xnpCMezqg6TQVCnG8nYGHmWtTbeMX1wqwXAEVnnQ+k
         et8q5up11d75PRhCqQkpcsT/3AixwO6z8+opv5jzkL/uib1LlsSFPXtTEcppKKrf19c1
         6u6hR8ICaxAIMnyw8eJMl+JAtSt3/SbwHjCUUEpalj2NxLM+34ZK+c+9bfnQrEjzBP2t
         A7FqpNnEFR8gyOPfXaQKYhLEbYS4RBLbhjcBGZr+TW76GvZbSvcIUXoWut0vYOesl7rC
         W97A==
X-Gm-Message-State: AOAM531Hnfm91zkjjn0DC6wl54rfkMg5PIF9+TjxN9cP+/9gk01kJ0om
        pPdCxG6YClcwLp2SCXDu+iupFg==
X-Google-Smtp-Source: ABdhPJyGYzppxh68ImBh7U0H9RS3daxpN5GalJy+2W1xWwnrNnPmYvtcQpgIcr4OryVXdjJjMxBqQQ==
X-Received: by 2002:adf:eb43:: with SMTP id u3mr14107643wrn.83.1625470568254;
        Mon, 05 Jul 2021 00:36:08 -0700 (PDT)
Received: from dell ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id u1sm9246257wmm.6.2021.07.05.00.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:36:07 -0700 (PDT)
Date:   Mon, 5 Jul 2021 08:36:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, robh+dt@kernel.org,
        lars@metafoo.de, sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, leonard.crestez@nxp.com,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 2/4] mfd: rn5t618: Add of compatibles for ADC and power
Message-ID: <YOK2aKYU6TK1GO7H@dell>
References: <20210703084224.31623-1-andreas@kemnade.info>
 <20210703084224.31623-3-andreas@kemnade.info>
 <20210703170405.60828c57@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210703170405.60828c57@jic23-huawei>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 03 Jul 2021, Jonathan Cameron wrote:

> On Sat,  3 Jul 2021 10:42:22 +0200
> Andreas Kemnade <andreas@kemnade.info> wrote:
> 
> > This allows having devicetree nodes for the subdevices.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/mfd/rn5t618.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> > index 384acb459427..b916c7471ca3 100644
> > --- a/drivers/mfd/rn5t618.c
> > +++ b/drivers/mfd/rn5t618.c
> > @@ -24,8 +24,10 @@ static const struct mfd_cell rn5t618_cells[] = {
> >  };
> >  
> >  static const struct mfd_cell rc5t619_cells[] = {
> > -	{ .name = "rn5t618-adc" },
> > -	{ .name = "rn5t618-power" },
> > +	{ .name = "rn5t618-adc",
> > +	  .of_compatible = "ricoh,rc5t619-adc" },
> 
> Odd to have a name of 618 and a compatible of 619.  Why?
> Definitely deserves a comment if this is necessary for some reason!

Actually this is the norm.  We have lots of drivers named after the
*first* device they supported before expansion.

> > +	{ .name = "rn5t618-power",
> > +	  .of_compatible = "ricoh,rc5t619-power" },
> >  	{ .name = "rn5t618-regulator" },
> >  	{ .name = "rc5t619-rtc" },
> >  	{ .name = "rn5t618-wdt" },
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
