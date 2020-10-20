Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249FD293432
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 07:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391375AbgJTFGF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 01:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391360AbgJTFGF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 01:06:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF906C0613D3
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 22:06:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x13so357706pgp.7
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 22:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BzDvCT5g2ND13ShvMBrA2tEQLZj9RI4ctTQKR5Kpfuc=;
        b=uPEeeX/DkYsg9UWKSh0+FRdUxTreGbPlkgnEhDxaInY8nddcQU3qyV1wfRBNMpqWjN
         9rF5Q56o1pwGUjrzDvlAirLfrFoFOxzxO0jlWQjkX1RkxArCXT7DQ4utHJCGrbmskRpn
         A347sF/7AzVP8ltjvo2yc7ixP+LpN7wbq5cLyPz3xPj8cH2Fsuj8CHz/tsZ7yj7v0t9o
         YqP/+7SxWRHjDG8fiQE7hgucXSQmUa9aD3DTe4g3iL2ZDwaWWURVdsLYhBJyZwIyyHbX
         XqAvtI5wfYvuzsmdXehkIxSqMqI00c5Ci+RcMIuC1iSr7y++pZhcip11evlQ1nC0XX4+
         qZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BzDvCT5g2ND13ShvMBrA2tEQLZj9RI4ctTQKR5Kpfuc=;
        b=Z8opJaa4lVQn641oYdwEjw7E5HtPpH4E3jtM9K98c/GKnfAyUXHx7sYq+7/P93Ia8d
         VraxRxMf9lr+jbcJfME1AvSGMp41t2HXy0DRZ5xJ1hHdjcfupV4WlmQKMLTjhBxQQBen
         1h3+8q65TwCBiBoRmZgUJAMcU796AA/dBZJ4AjSKUhVBJWtLfw834M859oG3BAiGR9Tt
         ZklTNFoiS+oCWIOFX9GTq+0IMOkB76v4PpcxELS0vPduGczcZ+2wmX6IddkBI0OWxpJ5
         EBi99Z71+KlxONPLRCeVoUjZlQpzSVSlLrraTntvY/0vyVX0kMxS104PIwOcTUhkzbID
         bnpA==
X-Gm-Message-State: AOAM533o6HVL5P1+LpkCPTI3YVhJ5i8xVwPGS9JBmXMoT2LDFegvQCbZ
        ZNdzeF+iuPUV9kKh/k3G2jDKkg==
X-Google-Smtp-Source: ABdhPJyntUjcVPO+MPmgw2P4aUUdPM5qJP0EIygPQXWlro3nbJAxdzYw/V2F3UVp/3OBcrgNnw2YHw==
X-Received: by 2002:a63:4c55:: with SMTP id m21mr1226500pgl.305.1603170363147;
        Mon, 19 Oct 2020 22:06:03 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id a4sm496798pgl.51.2020.10.19.22.06.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 22:06:02 -0700 (PDT)
Date:   Tue, 20 Oct 2020 10:35:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, nks@flawful.org,
        georgi.djakov@linaro.org, Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH V2 1/2] opp: Allow dev_pm_opp_get_opp_table() to return
 -EPROBE_DEFER
Message-ID: <20201020050557.a3b2nk33eeyxnvl2@vireshk-i7>
References: <20201015180555.gacdzkofpibkdn2e@bogus>
 <20201016042434.org6ibdqsqbzcdww@vireshk-i7>
 <20201016060021.sotk72u4hioctg7o@bogus>
 <20201016111222.lvakbmjhlrocpogt@bogus>
 <20201019045827.kl6qnx6gidhzjkrs@vireshk-i7>
 <20201019091723.GA12087@bogus>
 <20201019092411.b3znjxebay3puq2j@vireshk-i7>
 <20201019101241.GB12908@bogus>
 <20201019103535.ksp5ackoihamam4g@vireshk-i7>
 <20201019141007.GA6358@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019141007.GA6358@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-10-20, 15:10, Sudeep Holla wrote:
> On Mon, Oct 19, 2020 at 04:05:35PM +0530, Viresh Kumar wrote:
> > On 19-10-20, 11:12, Sudeep Holla wrote:
> > > Yes it has clocks property but used by SCMI(for CPUFreq/DevFreq) and not
> > > by any clock provider driver. E.g. the issue you will see if "clocks"
> > > property is used instead of "qcom,freq-domain" on Qcom parts.
> > 
> > Okay, I understand. But what I still don't understand is why it fails
> > for you. You have a clocks property in DT for the CPU, the OPP core
> > tries to get it and will get deferred-probed, which will try probing
> > at a later point of time and it shall work then. Isn't it ?
> >
> 
> Nope unfortunately. We don't have clock provider, so clk_get will
> never succeed and always return -EPROBE_DEFER.

Now this is really bad, you have a fake clocks property, how is the
OPP core supposed to know it ? Damn.

-- 
viresh
