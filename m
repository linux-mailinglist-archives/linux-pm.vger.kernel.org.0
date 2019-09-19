Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F7AB815B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 21:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404416AbfISTZK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 15:25:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42379 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404328AbfISTZK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 15:25:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id z12so2427802pgp.9
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cRUM2Bgk+uo7XLX/Jy2FrsXWAee8Of1P+PViX2GKNZY=;
        b=Wtb8HIE8vSdrRJNHZ2wmfbgGrAtk3ivSxMNFGnSByX+FxJcPGP4rAB6aVWjW89hdFe
         pYYji/ebkFmwElkLjlB5gfhwZshuG6GyHgpQ6OUxqgFbFCH2I40jlTNCFNzbNl1Ikf9u
         xEI7catyJ1zqMSoXBGHLZqRSe/5bskK0AKwiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cRUM2Bgk+uo7XLX/Jy2FrsXWAee8Of1P+PViX2GKNZY=;
        b=hf5Z5oR6gf9Ed4zwcvjdY3uyqklu5yb1gpFehN+Vxreq9j10Z5cSBzeK9E7ob5NXlo
         Gm9mSyeY3rN4Os9DIW87uEqHWI/R5LFKDn2WTkDmBCEgkQny/gL5LYOwsaBRjGWbb4K8
         WHvOaGNkEj5eb9lXxle3lMgLw6HfquhaL7sSv6hn/GxGUvbCcMQoy6e7as1e0xLC4FYD
         tRFmj209SOqyzuhyeW39Ouse8Rd2zGsHlaOIP+6vcZsa2ftNFXi1fxc49vuVUgkmaGie
         dDxw+W0fS9cOPp8v6cKu6VPGvxcFXhkpmOHfM9o8viEoqphJoQDx7qHD/7j/FAqx4vtY
         O8KQ==
X-Gm-Message-State: APjAAAU71Ux7EM5XZOpvLapsnVu9nOGedhfZsSmdAepwVTs6SklMRfOu
        4Sf6Z06uTHUn1C0o1UMBJ/lw4A==
X-Google-Smtp-Source: APXvYqwngcFum1vlZgnTY7YySXFB/HJZmBru5y/kt5s7NFfKVBnC1yOjxATiB3VpQrksdB/U2eFy0w==
X-Received: by 2002:a63:515a:: with SMTP id r26mr10663846pgl.121.1568921109183;
        Thu, 19 Sep 2019 12:25:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g4sm14154791pfo.33.2019.09.19.12.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 12:25:08 -0700 (PDT)
Date:   Thu, 19 Sep 2019 12:25:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/8] PM / devfreq: Lock devfreq in trans_stat_show
Message-ID: <20190919192507.GW133864@google.com>
References: <cover.1568764439.git.leonard.crestez@nxp.com>
 <7d8f4d5c608d45ba19cdd52068fe6ffe30de67c1.1568764439.git.leonard.crestez@nxp.com>
 <20190918212836.GN133864@google.com>
 <VI1PR04MB7023CAC70C08BF3963301A67EE890@VI1PR04MB7023.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR04MB7023CAC70C08BF3963301A67EE890@VI1PR04MB7023.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 19, 2019 at 06:42:22PM +0000, Leonard Crestez wrote:
> On 19.09.2019 00:28, Matthias Kaehlcke wrote:
> > Hi Leonard,
> > 
> > this series doesn't indicate the version, from the change history in
> > the cover letter I suppose it is v5.
> 
> Sorry about that, I forgot --subject-prefix. It is indeed v5
> 
> > On Wed, Sep 18, 2019 at 03:18:20AM +0300, Leonard Crestez wrote:
> >> There is no locking in this sysfs show function so stats printing can
> >> race with a devfreq_update_status called as part of freq switching or
> >> with initialization.
> >>
> >> Also add an assert in devfreq_update_status to make it clear that lock
> >> must be held by caller.
> > 
> > This and some other patches look like generic improvements and not
> > directly related to the series "PM / devfreq: Add dev_pm_qos
> > support". If there are no dependencies I think it is usually better to
> > send the improvements separately, it keeps the series more focussed
> > and might reduce version churn. Just my POV though ;-)
> 
> The locking cleanups are required in order to initialize pm_qos request 
> and notifiers without introducing lockdep warnings.
> 
> pm_qos calls notifiers under dev_pm_qos_mtx and those notifiers needs to 
> take &devfreq->lock. This means initializing pm_qos notifiers and 
> requests must be done outside &devfreq->lock which needs some cleanups 
> in devfreq_add_device.

Thanks for the clarification!

> This particular patch is a more loosely related bugfix. Devfreq 
> maintainers: would it help to post it separately?

If it's just this single patch it probably isn't a problem, I'd be
more concerned about multiple unrelated patches or if the changes are
complex.

> >> @@ -1415,15 +1416,20 @@ static ssize_t trans_stat_show(struct device *dev,
> >>   	struct devfreq *devfreq = to_devfreq(dev);
> >>   	ssize_t len;
> >>   	int i, j;
> >>   	unsigned int max_state = devfreq->profile->max_state;
> >>   
> >> +	mutex_lock(&devfreq->lock);
> >>   	if (!devfreq->stop_polling &&
> >> -			devfreq_update_status(devfreq, devfreq->previous_freq))
> >> -		return 0;
> >> -	if (max_state == 0)
> >> -		return sprintf(buf, "Not Supported.\n");
> >> +			devfreq_update_status(devfreq, devfreq->previous_freq)) {
> >> +		len = 0;
> > 
> > you could assign 'len' in the declaration instead, but it's just
> > another option, it'ss fine as is
> >> +		goto out;
> >> +	}
> >> +	if (max_state == 0) {
> >> +		len = sprintf(buf, "Not Supported.\n");
> >> +		goto out;
> >> +	}
> > 
> > This leaves the general structure of the code as is, which is great,
> > but since you are already touching this part you can consider to
> > improve it: 'max_state' is constant after device creation, hence the
> > check could be done at the beginning, which IMO would be clearer, it
> > could also save an unnecessary devfreq_update_status() call and it
> > wouldn't be necessary to hold the lock (one goto less).
> 
> Now that I look at this more closely &devfreq->lock only really needs to 
> be held during the stats update, it can be released during sprintf.

right, another simplification :)
