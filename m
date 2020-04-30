Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC00F1BEF9E
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 07:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgD3FVn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 01:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726391AbgD3FVn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 01:21:43 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E125DC08E859
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 22:21:42 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a31so253461pje.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 22:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3+Aje/v5jcj8L3yv0nBtSsoYFCrlpuzCMRL81ZSK7zQ=;
        b=WMRL5oZ97WiITscnQMde+o232dXlIvgsliipcI180iJ8pVpzQN0tjjvBC8prpmNwNM
         2Rl5hSog1LlVBwRMnDw08s+kAQTVOYXbKxVIh6LM1l0au6rr7zvfSaUX890zTF854Lod
         lG/W2F5HzIQR+j2as9L9akXJ6oFHNRpnYb8bqLXkp3Oc6ryBgNKs1tG3jApEg5iSmEJ/
         1MTKmlA7pz7sp0+vHHyawhYtqROiD6HBWhchth6/IH4Ff6T2ax5LN1D+rr6pE2Qwd3eq
         Kc4uHEzakoAqU7o2rkrA9mrjdSFe16zL3IY9afOgw77rr7fnSBbVkG+Q0YZ7ejfQNKGX
         y1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3+Aje/v5jcj8L3yv0nBtSsoYFCrlpuzCMRL81ZSK7zQ=;
        b=AZr/g/e/pqIrqeMlPB69DxIejXWbZ7bazOtcG0Y3NPbj7udeaeam4SKPhIWdv6SCrU
         WD9/+fZy0DbZz04+L9/nhQHK66Kbqx31bYoeDGUcvWnTAV2608VxCQbJDLSUjtdH6WhP
         RMHdJ5xVYQ/XCNNzPvJM80lybVPT2EbbYerddah9s4J85wLOuiXljNkSLJhpX+XO6F0z
         wye8G/PmRRnmNMhoqTw8T8f/zfFCb7OOcgQtezFho98YoQRpx9yY6jJfRo9j7JugSwK6
         vmLY02hw2ZsJK5K0J9rttFt9x4Sj5iQhzBlKmgXmsrbsSsBWyheeJ34Rad07Fc5UuKbh
         KOeA==
X-Gm-Message-State: AGi0PuZxY3XyeVrxc1av5DCbAGh2SW67S99o32we+jkGSlnTZjXL3FOh
        V4Pwo3JIqPOIF21Vo6wr6x3kpQ==
X-Google-Smtp-Source: APiQypJT2Qj4R3PjkMG/fujT78Utc+4rknpPqcNDAU5n5mvRk6nX1Ay33sH4ujimxFi3CdH3WArD0w==
X-Received: by 2002:a17:902:47:: with SMTP id 65mr1842545pla.54.1588224102051;
        Wed, 29 Apr 2020 22:21:42 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id x13sm2444143pfq.154.2020.04.29.22.21.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 22:21:41 -0700 (PDT)
Date:   Thu, 30 Apr 2020 10:51:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org,
        nm@ti.com, sboyd@kernel.org, robh+dt@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/7] OPP: Add helpers for reading the binding
 properties
Message-ID: <20200430052138.zr6smv3wrtkt5e52@vireshk-i7>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-3-georgi.djakov@linaro.org>
 <20200424173052.GM199755@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424173052.GM199755@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-04-20, 10:30, Matthias Kaehlcke wrote:
> Hi Georgi,
> 
> On Fri, Apr 24, 2020 at 06:53:59PM +0300, Georgi Djakov wrote:
> > From: Saravana Kannan <saravanak@google.com>
> > 
> > The opp-hz DT property is not mandatory and we may use another property
> > as a key in the OPP table. Add helper functions to simplify the reading
> > and comparing the keys.
> > 
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > ---
> > v7:
> > * Extracted just the helpers from patch v6, as Viresh advised to split it.
> > 
> > v6: https://lore.kernel.org/r/20191207002424.201796-3-saravanak@google.com
> > 
> >  drivers/opp/core.c | 15 +++++++++++++--
> >  drivers/opp/of.c   | 42 ++++++++++++++++++++++++++----------------
> >  drivers/opp/opp.h  |  1 +
> >  3 files changed, 40 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index ba43e6a3dc0a..c9c1bbe6ae27 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -1272,11 +1272,21 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
> >  	return true;
> >  }
> >  
> > +int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
> > +{
> > +	if (opp1->rate != opp2->rate)
> > +		return opp1->rate < opp2->rate ? -1 : 1;
> > +	if (opp1->level != opp2->level)
> > +		return opp1->level < opp2->level ? -1 : 1;
> > +	return 0;
> > +}
> > +
> >  static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
> >  			     struct opp_table *opp_table,
> >  			     struct list_head **head)
> >  {
> >  	struct dev_pm_opp *opp;
> > +	int opp_cmp;
> >  
> >  	/*
> >  	 * Insert new OPP in order of increasing frequency and discard if
> > @@ -1287,12 +1297,13 @@ static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
> >  	 * loop.
> >  	 */
> >  	list_for_each_entry(opp, &opp_table->opp_list, node) {
> > -		if (new_opp->rate > opp->rate) {
> > +		opp_cmp = _opp_compare_key(new_opp, opp);
> > +		if (opp_cmp > 0) {
> >  			*head = &opp->node;
> >  			continue;
> >  		}
> >  
> > -		if (new_opp->rate < opp->rate)
> > +		if (opp_cmp < 0)
> >  			return 0;
> >  
> >  		/* Duplicate OPPs */
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index 9cd8f0adacae..e33169c7e045 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -521,6 +521,28 @@ void dev_pm_opp_of_remove_table(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
> >  
> > +static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
> > +			 bool *rate_not_available)
> > +{
> > +	u64 rate;
> > +	int ret;
> > +
> > +	ret = of_property_read_u64(np, "opp-hz", &rate);
> > +	if (!ret) {
> > +		/*
> > +		 * Rate is defined as an unsigned long in clk API, and so
> > +		 * casting explicitly to its type. Must be fixed once rate is 64
> > +		 * bit guaranteed in clk API.
> > +		 */
> > +		new_opp->rate = (unsigned long)rate;
> > +	}
> 
> nit: curly braces are not needed

In fact they are as the comment is present within the if block (which
is the right thing to do). Yes the code will compile fine without
braces, but coding guideline suggests it around multi-line-statements.

> > +	*rate_not_available = !!ret;
> > +
> > +	of_property_read_u32(np, "opp-level", &new_opp->level);
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
> >   * @opp_table:	OPP table
> > @@ -558,26 +580,14 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
> >  	if (!new_opp)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > -	ret = of_property_read_u64(np, "opp-hz", &rate);
> > +	ret = _read_opp_key(new_opp, np, &rate_not_available);
> >  	if (ret < 0) {
> > -		/* "opp-hz" is optional for devices like power domains. */
> > -		if (!opp_table->is_genpd) {
> > -			dev_err(dev, "%s: opp-hz not found\n", __func__);
> > -			goto free_opp;
> > -		}
> > +		if (!opp_table->is_genpd)
> > +			dev_err(dev, "%s: opp key field not found\n", __func__);

Looks like the logic got changed here ? We used to goto free_opp only
if !is_genpd earlier..

> >  
> > -		rate_not_available = true;
> > -	} else {
> > -		/*
> > -		 * Rate is defined as an unsigned long in clk API, and so
> > -		 * casting explicitly to its type. Must be fixed once rate is 64
> > -		 * bit guaranteed in clk API.
> > -		 */
> > -		new_opp->rate = (unsigned long)rate;
> > +		goto free_opp;
> >  	}
> >  
> > -	of_property_read_u32(np, "opp-level", &new_opp->level);
> > -
> >  	/* Check if the OPP supports hardware's hierarchy of versions or not */
> >  	if (!_opp_is_supported(dev, opp_table, np)) {
> >  		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
> > diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> > index d14e27102730..bcadb1e328a4 100644
> > --- a/drivers/opp/opp.h
> > +++ b/drivers/opp/opp.h
> > @@ -211,6 +211,7 @@ struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_
> >  void _dev_pm_opp_find_and_remove_table(struct device *dev);
> >  struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
> >  void _opp_free(struct dev_pm_opp *opp);
> > +int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
> >  int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table, bool rate_not_available);
> >  int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
> >  void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

-- 
viresh
