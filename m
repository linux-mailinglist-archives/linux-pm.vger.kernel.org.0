Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8E436DF71
	for <lists+linux-pm@lfdr.de>; Wed, 28 Apr 2021 21:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbhD1TUC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Apr 2021 15:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239291AbhD1TUC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Apr 2021 15:20:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEE9C061574;
        Wed, 28 Apr 2021 12:19:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a4so2907482ejk.1;
        Wed, 28 Apr 2021 12:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mn8/Ar0eEzsq39T/Ky8eyYjEz0vXjTW8aW0yarDklzw=;
        b=Q3jOVz8H+EsKNQAxP9IDphSieAde6nkIF0dh/ekAKncPdQf6lUFN7MfJcuRV4R+Xzc
         DZ+wLWDxk4nyItGILsljRZ+goxsc67711lNEuUgCOzCQXtbaF22AuaCf/4l+XpwYWWHX
         HsIZk4ugSHJTPzCH/fDin2/UKwNWTZRw/uh026EOO3BEiwuxEV6mJxMaBu3of8DZjUvs
         z+0hEhkwFvZ4iczJFecbaQivOnSDVo6ye/rzys2fyVXGSjX2PIdSYliDGOYRF1N8Aa9/
         lpw8ldyRcxgjWoCSsazW7v+E8Jp/hy0W/gU9Fk31atnSMPJ6x14877syku44REdTQCsK
         bPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mn8/Ar0eEzsq39T/Ky8eyYjEz0vXjTW8aW0yarDklzw=;
        b=mga1qs1KGzJgT1MzLDDzdSR4L++Ze2sCTDYRBf9mHtVonWqT2au2NJl1xF3Njb+bwi
         2Xy0ant45EjeRjlGkU4jZt2hERVVlafc33OANbVhMErtH/AVfJEIJiVO6FuvzWx0FpRo
         UV5bVHGJJc+qYxZYyLi81JHNyzb32rQdHH38bSXfO4mv1jTWDZuh0TTCSdm8odYGt4f0
         TQGGtcDFcdRKsmN7gsysQR6FDexZTYQqhYSl4lNxZHLaga3VgsJ2XHJ0XNAD7Ah8UY2K
         f/t7G7HvGHIUaUqYfTZuhLmFqAG5Y4fzH/91k6rkH3gpdHsBUl8P6Ear7j29Dy1f98XX
         A86A==
X-Gm-Message-State: AOAM530ok0YWGFz0ee48aoY5AfB/oWyL9xnguPVIdotCo10d3pthNLRt
        GY5Qqpvx9C6Te944MGJRhbw=
X-Google-Smtp-Source: ABdhPJzN6AeqvI1H2B9zoISizKPzRPDXl+6O15vh6fpY82JYZFR9eJYU2lPNSBTu8WaO7FMXy/G80w==
X-Received: by 2002:a17:906:994c:: with SMTP id zm12mr18139644ejb.404.1619637555806;
        Wed, 28 Apr 2021 12:19:15 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.gmail.com with ESMTPSA id hp29sm409671ejc.47.2021.04.28.12.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 12:19:15 -0700 (PDT)
Date:   Wed, 28 Apr 2021 21:19:13 +0200
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
Message-ID: <YIm1MdsOm754WtgD@Ansuel-xps.localdomain>
References: <20210419012930.7727-1-ansuelsmth@gmail.com>
 <20210419012930.7727-2-ansuelsmth@gmail.com>
 <8e679407-07e7-244a-48fa-0d4d451d744d@linaro.org>
 <YImuFixa0iWtsU3k@Ansuel-xps.localdomain>
 <fe7dff6b-0079-7fba-4982-a3422add83b5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe7dff6b-0079-7fba-4982-a3422add83b5@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 28, 2021 at 03:14:31PM -0400, Thara Gopinath wrote:
> 
> 
> On 4/28/21 2:48 PM, Ansuel Smith wrote:
> > On Wed, Apr 28, 2021 at 12:47:30PM -0400, Thara Gopinath wrote:
> > > Hi,
> > > 
> > > Please include a cover letter next time describing the patch series.
> > > 
> > 
> > Yes sorry, I tought that for a small series (2 patch) it wasn't needed.
> > 
> > > On 4/18/21 9:29 PM, Ansuel Smith wrote:
> > > > Simplify debugfs init function.
> > > > - Drop useless variables
> > > > - Add check for existing dev directory.
> > > > - Fix wrong version in dbg_version_show (with version 0.0.0, 0.1.0 was
> > > >     incorrectly reported)
> > > > 
> > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > ---
> > > >    drivers/thermal/qcom/tsens.c | 16 +++++++---------
> > > >    1 file changed, 7 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > > > index f9d50a67e..b086d1496 100644
> > > > --- a/drivers/thermal/qcom/tsens.c
> > > > +++ b/drivers/thermal/qcom/tsens.c
> > > > @@ -692,7 +692,7 @@ static int dbg_version_show(struct seq_file *s, void *data)
> > > >    			return ret;
> > > >    		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
> > > >    	} else {
> > > > -		seq_puts(s, "0.1.0\n");
> > > > +		seq_printf(s, "0.%d.0\n", priv->feat->ver_major);
> > > >    	}
> > > >    	return 0;
> > > > @@ -704,21 +704,19 @@ DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
> > > >    static void tsens_debug_init(struct platform_device *pdev)
> > > >    {
> > > >    	struct tsens_priv *priv = platform_get_drvdata(pdev);
> > > > -	struct dentry *root, *file;
> > > > -	root = debugfs_lookup("tsens", NULL);
> > > > -	if (!root)
> > > > +	priv->debug_root = debugfs_lookup("tsens", NULL);
> > > > +	if (!priv->debug_root)
> > > >    		priv->debug_root = debugfs_create_dir("tsens", NULL);
> > > > -	else
> > > > -		priv->debug_root = root;
> > > > -	file = debugfs_lookup("version", priv->debug_root);
> > > > -	if (!file)
> > > > +	if (!debugfs_lookup("version", priv->debug_root))
> > > >    		debugfs_create_file("version", 0444, priv->debug_root,
> > > >    				    pdev, &dbg_version_fops);
> > > >    	/* A directory for each instance of the TSENS IP */
> > > > -	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
> > > 
> > > Unconditionally creating priv->debug here is correct. The below if
> > > (!priv->debug) will never be true because as per your patch 1, we call
> > > tsens_debug_init once per instance of tsens.
> > > 
> > 
> > You are right, will send a v2 if everything else is good. What do you
> > think?
> 
> I have not tested this yet. The clean up itself looks okay to me.
> My question is have you tried this with 8960 tsens ? That is the only
> version of tsens that does not use init_common and hence looks to me that a
> debug interface is not created. I don't think this should be a problem
> though. So if you can fix the above, it is a go ahead from me.
> 

Recent commits should have switched 8960 to init_common. Actually I
pushed this cause while testing 8960 I notice the warning about
double debugfs. Anyway thx for the review. Will send v2 ASAP.

> 
> -- 
> Warm Regards
> Thara
