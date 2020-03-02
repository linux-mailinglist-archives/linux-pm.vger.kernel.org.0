Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B771752A4
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 05:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCBEXi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Mar 2020 23:23:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44238 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgCBEXi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Mar 2020 23:23:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id a14so4744117pgb.11
        for <linux-pm@vger.kernel.org>; Sun, 01 Mar 2020 20:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lg+E5eHGxFbLp+eF4wTMF7bFywHujeredhQKubPaWes=;
        b=l66FDgfYLHI7EUix2Aiqym+m2ZMNUT+Y8VEgpOrJUEOT/aZGa1B7r4iA98ATTpwf9j
         KhZsvQ4NIw04r8qNg7czctPRTWfNeLIO2xmhT0YCrJ7CrvCGuYspk+sjG3ud3J9OFxip
         fcxRpi7k3ZCyuU4uR4fwYbaOadUfgHAr2QorgrCQFQgQh/PAImAwnlO89dbqjU/NLejR
         w5/20AOljurdNOmAmZfeVnCNKnlyD7l4WShmI6H+sk4awXeolzxZY2mgyV79uRmu4Ykq
         2YzghEX75EsC6VDpVgS08sVBVu59ZAyuUjNQeBZTw84TPAsLI4v0gKemYX/MrTD+9mwz
         1rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lg+E5eHGxFbLp+eF4wTMF7bFywHujeredhQKubPaWes=;
        b=W1KPMHqmg31cSoAbPp6moVjSRATccN961R8VVmPVRguGyCnaN54Zzp3X9y0YRsloTj
         0L7PKXgY6BiZdDpI1Brm3n6PPX8IsaQ6j4K57DmbXWFaSDu4t1FS2tW8xVGtOJcYa2hy
         Ki9ZWMbCvefACSmy+ZU5EYrhelDngrv56G+4Zka9/+GP5vswhpSRg2cC+AclUxoQHzXb
         ep7r5SzJz+wZbWsaiXGpCJKnummSQ45wdWm+TOS+Wb+lJoOLdDFTGpU6wComRSIkS3h5
         qoG6pXmuPWtfwDwciK1JxqNkVJ8wi7oCDxaXtHO9OSkdCsi2tfRW3Z66Glat7fUiMSw8
         NgoA==
X-Gm-Message-State: APjAAAX8WlkhmNOHa8M0QP8DAIKbmp9rCs2sKFR11eNxtFRBqRqZPDTw
        sDyaA+4LmNT6kXOTUp1WVuwRtw==
X-Google-Smtp-Source: APXvYqwfgRJZfsTclE5xGz9OlvpRNhORqGihbZ0X5SACoRN9a8WvoQPuHfi9UK6f6oGd2jWI7KhwoQ==
X-Received: by 2002:a63:dd06:: with SMTP id t6mr15894338pgg.384.1583123017453;
        Sun, 01 Mar 2020 20:23:37 -0800 (PST)
Received: from localhost ([122.167.24.230])
        by smtp.gmail.com with ESMTPSA id z17sm6972051pfk.110.2020.03.01.20.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Mar 2020 20:23:36 -0800 (PST)
Date:   Mon, 2 Mar 2020 09:53:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     qiwuchen55@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] cpufreq: fix a mem leak caused by policy->max_freq_req
 in cpufreq_policy_free()
Message-ID: <20200302042334.rrmizz3apjes6zwd@vireshk-i7>
References: <1583069198-21060-1-git-send-email-qiwuchen55@gmail.com>
 <CAJZ5v0jqGm-u-inJ4R-Qd=muqyKHxDOGAdtgaaxMq6BHa6Wwnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jqGm-u-inJ4R-Qd=muqyKHxDOGAdtgaaxMq6BHa6Wwnw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-03-20, 21:09, Rafael J. Wysocki wrote:
> On Sun, Mar 1, 2020 at 2:26 PM <qiwuchen55@gmail.com> wrote:
> >
> > From: chenqiwu <chenqiwu@xiaomi.com>
> >
> > There is a mem leak in cpufreq_policy_free() that the resource of
> > policy->max_freq_req pointer is not free.
> 
> That's incorrect AFAICS.

+1

> Thanks!
> 
> > Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index cbe6c94..6756f7a 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1280,6 +1280,8 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> >                 blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
> >                                              CPUFREQ_REMOVE_POLICY, policy);
> >                 freq_qos_remove_request(policy->max_freq_req);
> > +               kfree(policy->max_freq_req);
> > +               policy->max_freq_req = NULL;

Memory for both min_freq_req and max_freq_req is allocated together
and so we don't need to free max_freq_req separately.

-- 
viresh
