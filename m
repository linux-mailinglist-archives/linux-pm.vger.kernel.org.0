Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C83136DF29
	for <lists+linux-pm@lfdr.de>; Wed, 28 Apr 2021 20:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhD1Stp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Apr 2021 14:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhD1Sto (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Apr 2021 14:49:44 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AB4C061573;
        Wed, 28 Apr 2021 11:48:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l4so96107491ejc.10;
        Wed, 28 Apr 2021 11:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g5s+0vEkHh19AESWjEx4If4aPHPR8MgDvb7TEbFK5BY=;
        b=OHvfQHtTiNAmKmSIuWJk6lvXrEzqDTc28+ZlkQBSBMBdx6Qkrhu3XLDQfpsiqDrZ/p
         5uMxaKYoH5ZxvgsnaT4wTS25qpWbeMznNZum/airlTozuk2cCasV7leNEHWtqedusrmS
         aLflwojjEtKhw85Dm5LxVtgW+eB4Qzy4J759jZ2PsjLgYkhB+CuziqzQUs0mo3lYgUiT
         mXPgj3H7Wd64eSDvWLxagpTPwSpsPS7DcnFamoyOx4ZsbgrjJKTQa5gta7qR4jRonn4Q
         AK3cI6XOrYAWMpyFWpTohvIAoMaRDbgQhjjlO7pbZwGTNvNhDvSOmSfREf+bHIXO8TQS
         1R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g5s+0vEkHh19AESWjEx4If4aPHPR8MgDvb7TEbFK5BY=;
        b=Fz6iCndAmt653jIH9MotJeg1CLQzH1QVeOnzhgVdJHcunef9yEY1Nshr/u1g0iRaeW
         cKyfdXSvp5ZZwrINe2nWNYjpd2uTK/ZBAhe6CaUCQLeQNswv4k6HNIc8a9qeZULcIzP9
         /Mb/yKh1U3Zt9qtjevhzkMVB40y4NDZ/2TFup83sduWxgmH6Xeyz5NmYQiA3RCPPTZZy
         EY/ufFWx+H0rHIrR6hGrPsxzfy0fL/zqYblUGRttIkBPnuhDHmTAcx8EHYsLRzCZcv0J
         SdQXDcWW7THajlV4R25uFonQ2I31qR0ocNJ9ud5m5BPc94xjV2wCJazp2WKHlTiXcKJ4
         tOTA==
X-Gm-Message-State: AOAM5326sjUEL/nrkD2VKLtW/M2LqGAyp1GMpEwO/aW8RZ2OGuyQ15hl
        8Lt8bm/Z67HjyzUGZZnDd0dGXHVK5WVB7w==
X-Google-Smtp-Source: ABdhPJz4dooRCjDaCsA1y8Fg7AldM0+jPftpeeCXP7+AEXow1il2flmiGl1TRpelfO4Gtmfw7tMsZw==
X-Received: by 2002:a17:906:1d0e:: with SMTP id n14mr30850884ejh.97.1619635736195;
        Wed, 28 Apr 2021 11:48:56 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.gmail.com with ESMTPSA id b8sm405698ejc.29.2021.04.28.11.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 11:48:55 -0700 (PDT)
Date:   Wed, 28 Apr 2021 20:48:54 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [thermal-next PATCH 2/2] thermal: qcom: tsens: simplify debugfs
 init function
Message-ID: <YImuFixa0iWtsU3k@Ansuel-xps.localdomain>
References: <20210419012930.7727-1-ansuelsmth@gmail.com>
 <20210419012930.7727-2-ansuelsmth@gmail.com>
 <8e679407-07e7-244a-48fa-0d4d451d744d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e679407-07e7-244a-48fa-0d4d451d744d@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 28, 2021 at 12:47:30PM -0400, Thara Gopinath wrote:
> Hi,
> 
> Please include a cover letter next time describing the patch series.
>

Yes sorry, I tought that for a small series (2 patch) it wasn't needed.

> On 4/18/21 9:29 PM, Ansuel Smith wrote:
> > Simplify debugfs init function.
> > - Drop useless variables
> > - Add check for existing dev directory.
> > - Fix wrong version in dbg_version_show (with version 0.0.0, 0.1.0 was
> >    incorrectly reported)
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >   drivers/thermal/qcom/tsens.c | 16 +++++++---------
> >   1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index f9d50a67e..b086d1496 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -692,7 +692,7 @@ static int dbg_version_show(struct seq_file *s, void *data)
> >   			return ret;
> >   		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
> >   	} else {
> > -		seq_puts(s, "0.1.0\n");
> > +		seq_printf(s, "0.%d.0\n", priv->feat->ver_major);
> >   	}
> >   	return 0;
> > @@ -704,21 +704,19 @@ DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
> >   static void tsens_debug_init(struct platform_device *pdev)
> >   {
> >   	struct tsens_priv *priv = platform_get_drvdata(pdev);
> > -	struct dentry *root, *file;
> > -	root = debugfs_lookup("tsens", NULL);
> > -	if (!root)
> > +	priv->debug_root = debugfs_lookup("tsens", NULL);
> > +	if (!priv->debug_root)
> >   		priv->debug_root = debugfs_create_dir("tsens", NULL);
> > -	else
> > -		priv->debug_root = root;
> > -	file = debugfs_lookup("version", priv->debug_root);
> > -	if (!file)
> > +	if (!debugfs_lookup("version", priv->debug_root))
> >   		debugfs_create_file("version", 0444, priv->debug_root,
> >   				    pdev, &dbg_version_fops);
> >   	/* A directory for each instance of the TSENS IP */
> > -	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
> 
> Unconditionally creating priv->debug here is correct. The below if
> (!priv->debug) will never be true because as per your patch 1, we call
> tsens_debug_init once per instance of tsens.
> 

You are right, will send a v2 if everything else is good. What do you
think?

> > +	priv->debug = debugfs_lookup(dev_name(&pdev->dev), priv->debug_root);
> > +	if (!priv->debug)
> > +		priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
> >   	debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
> >   }
> >   #else
> > 
> 
> -- 
> Warm Regards
> Thara
