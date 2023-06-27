Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EE773FB3E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jun 2023 13:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjF0Lir (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jun 2023 07:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjF0Lin (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2023 07:38:43 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B142D65
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2023 04:38:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso2525678e87.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2023 04:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687865906; x=1690457906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfWH0OQlsg+dvWsXTp6JCSMfE+H9UOwW5z/wnfAlqDM=;
        b=g0JjsRF1zHQRW4jZzWYMLCLGoymlc17mLqx1F9Ai41Cisd+FAVNuut0V6+6zRCyKsZ
         1Ey6SPBm57SH7KeUf3V1TLpVJD/1fY5K22ORSG+qIFuDornGDg7RClO6wnnB1fXf1QJi
         ZQUkzKUy/qws7TMjW1ec0/SxI6D0nreH4i7Uo9vpbD1zbNWI2a/GBtoybyfvWud1n26f
         arC0AB1M69QRJZrVi83jF39slVbATFzrLec8H5MwcoQj5l+vZevlAL3iD6TlZe8S+x5r
         Oo+qljD5aGAv/Zk03pzB+AtelXcdQiLzGqar87fqc8IPAaHNZXiPjIS8kiiB86McFoz3
         mzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687865906; x=1690457906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfWH0OQlsg+dvWsXTp6JCSMfE+H9UOwW5z/wnfAlqDM=;
        b=T+DdwB/nseMU8hsmUufI6GjDGKhFfXmtHL7uz6jHQXswuqqLXS+Ft9oS+JMgS7S8kg
         Bm47nPiC+dhjJe62W4PLyVBlfLu94jI9s7Z1+RSJLAbvt4dwjhANPWLQ/4aKzvvo1zvy
         ckIDkurzPu7n782vAzFWh6udGg3TLL6me8dXT1rL/kpBnBgn70stcX500jZel0ZSWiNk
         eR4/LgnQfGh3gsbws4lxfUen0Q7OAKeLPc8HkZYT5thAtKVjYHFk4OhMQ1HADpcDlN+R
         4JhsognjlKWUbrFBjDPAiQNWPivwehV/kLcb5YDTolxYfD1H7hoP4Vn5lMzqAdH7Onvu
         GWJg==
X-Gm-Message-State: AC+VfDwpn0KxuycV91mN1LK0bdhgp1zlIBabDX3B8o6EmrMW6w4dfbD7
        sibA2Cx8wWDI1vtsUkrDC8LtGQ==
X-Google-Smtp-Source: ACHHUZ5CK70G/4mbB1hUPJkh1Rn4Fjo/i/K+ZfnRSo16urKoN8y/vTKwRLbwuw2xbYORIKVP019tsA==
X-Received: by 2002:a05:6512:eaa:b0:4fb:7cea:882a with SMTP id bi42-20020a0565120eaa00b004fb7cea882amr2756090lfb.3.1687865905789;
        Tue, 27 Jun 2023 04:38:25 -0700 (PDT)
Received: from linaro.org ([62.231.110.100])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c214400b003fa95890484sm6015915wml.20.2023.06.27.04.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:38:25 -0700 (PDT)
Date:   Tue, 27 Jun 2023 14:38:23 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        avel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] clk: qcom: gdsc: Add support for set_hwmode_dev
Message-ID: <ZJrKL5+JHzOgHQl5@linaro.org>
References: <20230627104033.3345659-1-abel.vesa@linaro.org>
 <20230627104033.3345659-2-abel.vesa@linaro.org>
 <666f7313-f0a2-6a94-f591-eb354df083dd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <666f7313-f0a2-6a94-f591-eb354df083dd@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-06-27 12:47:24, Konrad Dybcio wrote:
> On 27.06.2023 12:40, Abel Vesa wrote:
> > Implement the GDSC specific genpd set_hwmode_dev callback in order to
> > switch the HW control on or off. For any GDSC that supports HW control
> > set this callback in order to allow its consumers to control it.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> Currently all GDSCs with flags & HW_CTRL enable hw ctrl mode implicilty.
> I didn't get any cover letter with these patches.. are you planning on
> retiring that behavior? Presumably after adding a matching pair of set_hwmode
> in venus!

I didn't think a cover letter was needed here. After a chat offline with
Taniya about this and it seems there is at least one consumer driver
that needs to switch back and forth the HW control bit. For the rest of
the consumers, the safest way is to assume that they expect their GDSC
to be in HW control mode from the moment it is enabled until it gets
disabled. One example of this is venus.

> 
> fwiw this patch lgtm
> 
> Konrad
> >  drivers/clk/qcom/gdsc.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> > index 5358e28122ab..9a04bf2e4379 100644
> > --- a/drivers/clk/qcom/gdsc.c
> > +++ b/drivers/clk/qcom/gdsc.c
> > @@ -314,6 +314,26 @@ static int gdsc_enable(struct generic_pm_domain *domain)
> >  	return 0;
> >  }
> >  
> > +static int gdsc_set_hwmode_dev(struct generic_pm_domain *domain,
> > +			       struct device *dev, bool enable)
> > +{
> > +	int ret = gdsc_hwctrl(domain_to_gdsc(domain), enable);
> > +
> > +	if (ret)
> > +		goto out;
> > +
> > +	/*
> > +	 * Wait for the GDSC to go through a power down and
> > +	 * up cycle.  In case there is a status polling going on
> > +	 * before the power cycle is completed it might read an
> > +	 * wrong status value.
> > +	 */
> > +	udelay(1);
> > +
> > +out:
> > +	return ret;
> > +}
> > +
> >  static int gdsc_disable(struct generic_pm_domain *domain)
> >  {
> >  	struct gdsc *sc = domain_to_gdsc(domain);
> > @@ -451,6 +471,8 @@ static int gdsc_init(struct gdsc *sc)
> >  		sc->pd.power_off = gdsc_disable;
> >  	if (!sc->pd.power_on)
> >  		sc->pd.power_on = gdsc_enable;
> > +	if (sc->flags & HW_CTRL)
> > +		sc->pd.set_hwmode_dev = gdsc_set_hwmode_dev;
> >  
> >  	ret = pm_genpd_init(&sc->pd, NULL, !on);
> >  	if (ret)
