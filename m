Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 207DA13605C
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 19:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbgAISol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 13:44:41 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41113 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbgAISoi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 13:44:38 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so8252566otc.8
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2020 10:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XTYu6dx3P7+neGNkEsuHx7Hl39JFzGEmh9FvOI/6t8=;
        b=U8I2YmCRoAq67WWxoFFCJ3k3gOrykE2YQwTErZWVe+5AoPziMhEmwKx1VMD0KMFPCX
         +jbhGCIi7LaCyRozBXGg67tWcEshu9t/nV+5GRwcrDrqaDPVF/q7WB8dwyvMqzHqXwXh
         vrxb+U/3GbD3UJN8t4zfHH1mfu+g+1u0RsxmiGudZ7HOzTAUZJgwQCEkmMzHDz3VZVLP
         1NJnm0l580uFrBULSlvulQKs3TC7T5fJclJfMNd+rdGx7VAt3rjC3csdddytt5qAtS3Z
         elFxbmidwN6O0NCzzqYHweFXkI8SZ4G5Gp6oB6GfQmpbRyFtz4PI/ZFnReNOyC4mjr8l
         abGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XTYu6dx3P7+neGNkEsuHx7Hl39JFzGEmh9FvOI/6t8=;
        b=cnqG3IlIIsAUwRgBh5eu03w4LM+P6h5QRmvbpIy0o8ICnxE3fPBeSHa2P3z7C/6rJS
         YwiPUF30X+3HPcPR9LKDphrSC2IwCLh94LV0Xx+o3DQr9u/mTlXWWM+zTXbHJWlEWbBF
         AbW9X8KiMtj3ekR6aBIgRmpUO6OWXTmKA8KmfZ7p3yEU7EKVUjZZT5uZeRxxACQEs/0O
         iBH1IYb7vrMXERBQ/lRBQ8xvjysv0txaW2EO6P3QnEsdUrXd8Zmh1HwcBL1qZIl1Mtuz
         /WYHH6b8t35OtoTXtV9VeoAA0fc8kYuajJp3Enj7auDgAtVC7aKgughkIqePA0s0Od7l
         esxQ==
X-Gm-Message-State: APjAAAXT3DRNW6uM3VnLjzQRj0gYrQ3PqGJ0KmuRsLWFQDWv/iiAS89x
        +TR9q+mm1K+OUY5zb32Sc+q58xaZyoEj3zrQ0PF0kA==
X-Google-Smtp-Source: APXvYqwbORFOz9hNPUv86p8ax7GkF+op9OEIJjbOBrv/fGZR+RsiVZt588/jpZ7zEUY+jEIrhutCl+sw14/o5poL9tg=
X-Received: by 2002:a05:6830:121a:: with SMTP id r26mr9606498otp.225.1578595477678;
 Thu, 09 Jan 2020 10:44:37 -0800 (PST)
MIME-Version: 1.0
References: <20191207002424.201796-1-saravanak@google.com> <20191207002424.201796-4-saravanak@google.com>
 <20200108111947.q5aafrlz26tnk3nq@vireshk-i7> <CAGETcx_T7VONkSd-r9CY-5OpZBZ2iD0tFoCf0+d8CY2b5zgr9g@mail.gmail.com>
 <20200109044051.62ocfpt44q25q6qi@vireshk-i7>
In-Reply-To: <20200109044051.62ocfpt44q25q6qi@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 9 Jan 2020 10:44:01 -0800
Message-ID: <CAGETcx-UWFSaZ8q1iiFVFUEPLN8t1uFb-u6v4VJiMarS21RLRQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] OPP: Add helper function for bandwidth OPP tables
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 8, 2020 at 8:40 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-01-20, 16:58, Saravana Kannan wrote:
> > On Wed, Jan 8, 2020 at 3:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >  /**
> > > >   * dev_pm_opp_get_level() - Gets the level corresponding to an available opp
> > > >   * @opp:     opp for which level value has to be returned for
> > > > @@ -299,6 +322,34 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_freq);
> > > >
> > > > +/**
> > > > + * dev_pm_opp_get_suspend_opp_bw() - Get peak bandwidth of suspend opp in kBps
> > >
> > > Hmm, I wasn't expecting this. So the interconnects will also have a
> > > suspend OPP ?
> >
> > Yes, device voting for interconnect paths might want to lower the
> > bandwidth to a suspend bandwidth when they suspend.
>
> That's exactly what I was saying, the request for a change during
> suspend should come from the device

Agree. And this tells the device requesting for bandwidth, what
bandwidth to vote for when it's suspending. Keep in mind that these
bandwidth OPP tables are used by the consumers of the interconnects to
pick from a list of bandwidths to vote for.

> and you can't do it here, i.e.
> they should lower their frequency requirement, which should lead to a
> low bandwidth automatically.

Agree, the OPP framework itself shouldn't be responsible. And I'm not
doing anything here? Just giving those devices a way to look up what
their suspend bandwidth is? So they can vote for it when they suspend?

> > > > + * @dev:     device for which we do this operation
> > > > + * @avg_bw:  Pointer where the corresponding average bandwidth is stored.
> > > > + *           Can be NULL.
> > > > + *
> > > > + * Return: This function returns the peak bandwidth of the OPP marked as
> > > > + * suspend_opp if one is available, else returns 0;
> > > > + */
> > > > +unsigned long dev_pm_opp_get_suspend_opp_bw(struct device *dev,
> > > > +                                         unsigned long *avg_bw)
> > > > +{
> > > > +     struct opp_table *opp_table;
> > > > +     unsigned long peak_bw = 0;
> > > > +
> > > > +     opp_table = _find_opp_table(dev);
> > > > +     if (IS_ERR(opp_table))
> > > > +             return 0;
> > > > +
> > > > +     if (opp_table->suspend_opp && opp_table->suspend_opp->available)
> > > > +             peak_bw = dev_pm_opp_get_bw(opp_table->suspend_opp, avg_bw);
> > > > +
> > > > +     dev_pm_opp_put_opp_table(opp_table);
> > > > +
> > > > +     return peak_bw;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_bw);
> > > > +
> > > >  int _get_opp_count(struct opp_table *opp_table)
> > > >  {
> > > >       struct dev_pm_opp *opp;
> > > > @@ -343,6 +394,40 @@ int dev_pm_opp_get_opp_count(struct device *dev)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
> > > >
> > >
> > > I think we should add function header here instead of the helpers
> > > which get exact match for freq, bw or level. And then pass a enum
> > > value to it, which tells what we are looking to compare. After that
> > > rest of the routines will be just one liners, make them macros in
> > > header file itself.
> >
> > Not sure I understand what you are saying here.
>
> Okay, lemme try again with proper example.
>
> enum opp_key_type {
>         OPP_KEY_FREQ = 0x1,
>         OPP_KEY_LEVEL= 0x2,
>         OPP_KEY_BW   = 0x4,
>         OPP_KEY_ALL  = 0x7,
> }
>
> /**
>  * Add function header here..
>  */
> struct dev_pm_opp *dev_pm_opp_find_opp_exact(struct device *dev,
>                                              enum opp_key_type key,
>                                              unsigned long key_value,
>                                              bool available)
> {
>        struct opp_table *opp_table;
>        struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
>
>        opp_table = _find_opp_table(dev);
>        if (IS_ERR(opp_table)) {
>                int r = PTR_ERR(opp_table);
>
>                dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
>                return ERR_PTR(r);
>        }
>
>        mutex_lock(&opp_table->lock);
>
>        list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
>                if (temp_opp->available == available &&
>                    !opp_compare_key(temp_opp, key, key_value)) {
>                        opp = temp_opp;
>
>                        /* Increment the reference count of OPP */
>                        dev_pm_opp_get(opp);
>                        break;
>                }
>        }
>
>        mutex_unlock(&opp_table->lock);
>        dev_pm_opp_put_opp_table(opp_table);
>
>        return opp;
> }
>
> //Now in header file
>
> #define dev_pm_opp_find_freq_exact(dev, freq, available)        dev_pm_opp_find_opp_exact(dev, OPP_KEY_FREQ, freq, available);
> #define dev_pm_opp_find_level_exact(dev, level, available)      dev_pm_opp_find_opp_exact(dev, OPP_KEY_LEVEL, level, available);
> #define dev_pm_opp_find_bw_exact(dev, bw, available)            dev_pm_opp_find_opp_exact(dev, OPP_KEY_BW, bw, available);

Ok, but you want this done only for "exact" or for all the other
helpers too? Also, this means that I'll have to implement a
_opp_compare_key2() or whatever because the generic one that
automatically picks the key is still needed for the generic code. Is
that fine by you?

Also, ack to your other response.

-Saravana
