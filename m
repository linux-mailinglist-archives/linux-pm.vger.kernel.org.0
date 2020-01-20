Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB8C142E67
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 16:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgATPJZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 10:09:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52731 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgATPJZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 10:09:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so14863233wmc.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2020 07:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ByBSacKRJKuzSIYiOQyT8J9CJv5HzmRfCVnRBxTEqEo=;
        b=qg1ZLvviVZfjbWUxveYlY31YKSPtpCoqGvUCxFFFmuSNhzrZG+8/JTUBew4MqF1QwT
         ZkjTqLHsvs275UZGLdOmP854e8vkiW0i8IheAE92enwVx5dgNXUWibw7xuJsq5IzFhhk
         pKzY/RUwbanMSqGLmJ0vUxWmHzbBOZqzoxp9yT0uRtho17C6I5oH1xMf+pTIjzSN3MZY
         H8HxiblWXheI6D/R+4rBvbQG0cc5g6adqj0TwfF4L2cC1eWieAELuSXvre7Nin13453w
         MgPO0mLx6I2rhlnxlc70+w5Qw7/m8lq2IEay5qYyHSQ30y8iTLRUAkWggiNl+AA9LLR9
         CgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ByBSacKRJKuzSIYiOQyT8J9CJv5HzmRfCVnRBxTEqEo=;
        b=CAOmmoJclRjgQkqWvjL71KhxoLKMWYurmgb1N9XLSxGfLq8yxlibIx7iO/B3MjW+nF
         xTaZLpiJ+WGOFWZnSxJFuWW+9HnhMugUPcJqs9jODUxrsYCD4i7dO5Gx+iPRE+XhS/78
         t3x5re3FguNWJ5Vtc/wH+LnYszn/jIfIriIHuuuVtpwzdW5kLHHCGytKLKKe0lMl5Plo
         NHrJzVZNpzFs3on1bEANGCS272/Vm/lC6FSYcw7iO0GO8mu7GKEX+9GptXw/ByN63iqk
         ahNSz4xH8QlYMOEBKO6r2CmN6+e7VuJdMn4B4GxW0b97uI9px6I3OoOpK53mn4aq/NG6
         rP0Q==
X-Gm-Message-State: APjAAAXPpJjPViBvLcW4t+5kMK5DEPRj27ivL9tWOHrXQt+R8F14U4Uz
        +K4nN0YnvP1HDDb7zgC2lqnFCkjGKwaLd9gM
X-Google-Smtp-Source: APXvYqyH6QMzJgz4YZQ39CG1D478e9/BsTiziBKmrfafEV/iedUuTR3YTBW7pk8iuudU9KBXYjMY8g==
X-Received: by 2002:a05:600c:21da:: with SMTP id x26mr19321181wmj.4.1579532962450;
        Mon, 20 Jan 2020 07:09:22 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id a5sm23285242wmb.37.2020.01.20.07.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 07:09:21 -0800 (PST)
Date:   Mon, 20 Jan 2020 15:09:18 +0000
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, Chris.Redpath@arm.com,
        ionela.voinescu@arm.com, javi.merino@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, kernel-team@android.com
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
Message-ID: <20200120150918.GA164543@google.com>
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
 <20200117105437.GA211774@google.com>
 <40587d98-0e8d-cbac-dbf5-d26501d47a8c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40587d98-0e8d-cbac-dbf5-d26501d47a8c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Lukasz,

On Monday 20 Jan 2020 at 14:52:07 (+0000), Lukasz Luba wrote:
> On 1/17/20 10:54 AM, Quentin Perret wrote:
> > Suggested alternative: have two registration functions like so:
> > 
> > 	int em_register_dev_pd(struct device *dev, unsigned int nr_states,
> > 			       struct em_data_callback *cb);
> > 	int em_register_cpu_pd(cpumask_t *span, unsigned int nr_states,
> > 			       struct em_data_callback *cb);
> 
> Interesting, in the internal review Dietmar asked me to remove these two
> functions. I had the same idea, which would simplify a bit the
> registration and it does not need to check the dev->bus if it is CPU.
> 
> Unfortunately, we would need also two function in drivers/opp/of.c:
> dev_pm_opp_of_register_cpu_em(policy->cpus);
> and
> dev_pm_opp_of_register_dev_em(dev);
> 
> Thus, I have created only one registration function, which you can see
> in this patch set.

Right, I can see how having a unified API would be appealing, but the
OPP dependency is a nono, so we'll need to work around one way or
another.

FWIW, I don't think having separate APIs for CPUs and other devices is
that bad given that we already have entirely different frameworks to
drive their respective frequencies. And the _cpu variants are basically
just wrappers around the _dev ones, so not too bad either IMO :).

Thanks,
Quentin
