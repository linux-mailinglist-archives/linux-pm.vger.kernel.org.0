Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDD6135233
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 05:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgAIEkz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 23:40:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42256 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgAIEky (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 23:40:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so2719133pfz.9
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2020 20:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TTD2x5dI94tlyfHEVS+KfYZUSun3WSq3+iSXPR+9K3E=;
        b=EcGRRhbfbE2JQ8Efxb2BANb1+NSsd5HC5I3ODMD4HDcIddM/9eT/K3s+T6JjLDtOAf
         teX8g7Exokj6vD0CPHc/mQ+VQw2ITEBotzQ0PYdktEgl6u+Ba1dPztPaEngN6lGC6RwD
         fij68ZT/MPS4qOnxE8vlqabXHHmxDzxSlX8cEpWW00Ibvhsxz854fPXSaeW1eG34RoiZ
         eBsxh9LOqKoi0Wt7FxWx3owFNT8A7iFQGIK03LqBYhIPifGxVoiarmU5JGis1/bmcTLU
         xb1cDo2t/qHKUOG11YSe4PabDIVRm7diGCe+WWwfk3p48XrXxUWAahNPhkIp22iHtZ+D
         9oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TTD2x5dI94tlyfHEVS+KfYZUSun3WSq3+iSXPR+9K3E=;
        b=eePpNVKcKWuoTpYK9v4AA5Cho2hoCs7ujfRt8gYTjA65WPiK7AZVCL0Tbrw/7r5oUy
         a26nWSll5ouckfnbFkY00mcATG3ptU6EzmY5bbHv25s+c2bEXLX4mpWYD3tH6jBiovWS
         jNhHDp47+z2NRrmU5QAeQnqDqsAi06aN2i/rNYKJwc65K0qpZIQ5VkKBeIbaw61VtCfq
         gDPAOargTiRorUzUxD0usziNVoCShZVTCEgPtkMAwnaalZZ0JnESaPnD8njkkM/xl5Ie
         XKxB4amfl17Ot4z+Ez6OMo9uULT5zDgxq3+NB1Vcd3Ac/FBkfC2o1vgxpZe7AkCSZd0G
         fRVQ==
X-Gm-Message-State: APjAAAUXDIghnuRDZJMmcYowUEXNrJzVrEtcxdSrGUzuELBHGO7HnylV
        1L3Rjih6MsZvkVBTatBLHVJ70Q==
X-Google-Smtp-Source: APXvYqxchuav0rFtDGS7fXHA6b21hxQl8ETG0FPFpF3G910odNkYOuNybG+b46cGo1evQ5cBeBqPuQ==
X-Received: by 2002:aa7:8e13:: with SMTP id c19mr9209399pfr.227.1578544853917;
        Wed, 08 Jan 2020 20:40:53 -0800 (PST)
Received: from localhost ([122.172.140.51])
        by smtp.gmail.com with ESMTPSA id b20sm5513222pfi.153.2020.01.08.20.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 20:40:52 -0800 (PST)
Date:   Thu, 9 Jan 2020 10:10:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] OPP: Add helper function for bandwidth OPP tables
Message-ID: <20200109044051.62ocfpt44q25q6qi@vireshk-i7>
References: <20191207002424.201796-1-saravanak@google.com>
 <20191207002424.201796-4-saravanak@google.com>
 <20200108111947.q5aafrlz26tnk3nq@vireshk-i7>
 <CAGETcx_T7VONkSd-r9CY-5OpZBZ2iD0tFoCf0+d8CY2b5zgr9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_T7VONkSd-r9CY-5OpZBZ2iD0tFoCf0+d8CY2b5zgr9g@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-01-20, 16:58, Saravana Kannan wrote:
> On Wed, Jan 8, 2020 at 3:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >  /**
> > >   * dev_pm_opp_get_level() - Gets the level corresponding to an available opp
> > >   * @opp:     opp for which level value has to be returned for
> > > @@ -299,6 +322,34 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_freq);
> > >
> > > +/**
> > > + * dev_pm_opp_get_suspend_opp_bw() - Get peak bandwidth of suspend opp in kBps
> >
> > Hmm, I wasn't expecting this. So the interconnects will also have a
> > suspend OPP ?
> 
> Yes, device voting for interconnect paths might want to lower the
> bandwidth to a suspend bandwidth when they suspend.

That's exactly what I was saying, the request for a change during
suspend should come from the device and you can't do it here, i.e.
they should lower their frequency requirement, which should lead to a
low bandwidth automatically.

> > > + * @dev:     device for which we do this operation
> > > + * @avg_bw:  Pointer where the corresponding average bandwidth is stored.
> > > + *           Can be NULL.
> > > + *
> > > + * Return: This function returns the peak bandwidth of the OPP marked as
> > > + * suspend_opp if one is available, else returns 0;
> > > + */
> > > +unsigned long dev_pm_opp_get_suspend_opp_bw(struct device *dev,
> > > +                                         unsigned long *avg_bw)
> > > +{
> > > +     struct opp_table *opp_table;
> > > +     unsigned long peak_bw = 0;
> > > +
> > > +     opp_table = _find_opp_table(dev);
> > > +     if (IS_ERR(opp_table))
> > > +             return 0;
> > > +
> > > +     if (opp_table->suspend_opp && opp_table->suspend_opp->available)
> > > +             peak_bw = dev_pm_opp_get_bw(opp_table->suspend_opp, avg_bw);
> > > +
> > > +     dev_pm_opp_put_opp_table(opp_table);
> > > +
> > > +     return peak_bw;
> > > +}
> > > +EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_bw);
> > > +
> > >  int _get_opp_count(struct opp_table *opp_table)
> > >  {
> > >       struct dev_pm_opp *opp;
> > > @@ -343,6 +394,40 @@ int dev_pm_opp_get_opp_count(struct device *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
> > >
> >
> > I think we should add function header here instead of the helpers
> > which get exact match for freq, bw or level. And then pass a enum
> > value to it, which tells what we are looking to compare. After that
> > rest of the routines will be just one liners, make them macros in
> > header file itself.
> 
> Not sure I understand what you are saying here.

Okay, lemme try again with proper example.

enum opp_key_type {
        OPP_KEY_FREQ = 0x1,
        OPP_KEY_LEVEL= 0x2,
        OPP_KEY_BW   = 0x4,
        OPP_KEY_ALL  = 0x7,
}

/**
 * Add function header here..
 */
struct dev_pm_opp *dev_pm_opp_find_opp_exact(struct device *dev,
                                             enum opp_key_type key,
                                             unsigned long key_value,
                                             bool available)
{
       struct opp_table *opp_table;
       struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);

       opp_table = _find_opp_table(dev);
       if (IS_ERR(opp_table)) {
               int r = PTR_ERR(opp_table);

               dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
               return ERR_PTR(r);
       }

       mutex_lock(&opp_table->lock);

       list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
               if (temp_opp->available == available &&
                   !opp_compare_key(temp_opp, key, key_value)) {
                       opp = temp_opp;

                       /* Increment the reference count of OPP */
                       dev_pm_opp_get(opp);
                       break;
               }
       }

       mutex_unlock(&opp_table->lock);
       dev_pm_opp_put_opp_table(opp_table);

       return opp;
}

//Now in header file

#define dev_pm_opp_find_freq_exact(dev, freq, available)        dev_pm_opp_find_opp_exact(dev, OPP_KEY_FREQ, freq, available);
#define dev_pm_opp_find_level_exact(dev, level, available)      dev_pm_opp_find_opp_exact(dev, OPP_KEY_LEVEL, level, available);
#define dev_pm_opp_find_bw_exact(dev, bw, available)            dev_pm_opp_find_opp_exact(dev, OPP_KEY_BW, bw, available);

-- 
viresh
