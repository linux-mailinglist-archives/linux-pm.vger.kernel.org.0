Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86B3B133C59
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 08:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgAHHdm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 02:33:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40000 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgAHHdm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 02:33:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so1169598pfh.7
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2020 23:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UqnEPALWHzZA1XyArIe54gSIpTfBlxJBhMMEH98tgUE=;
        b=UEpDwj3j2VI8L9aqT88S/h054nZlI+rPpR+RVksa4qB0/BkrDmo7PWRnGBnfMVpPAG
         0QgCFIB3H6aVWAN4MsySPOgKSPLx69qB6rr0Sb8m5YITjqWhWlntgj01rWc6AcFigyJB
         PZgQBRl3HLdR/QIpfDLhqbXF5J+6hC9Ck7L/qTqyz1HEW+Y59yG8NNx9/vVsu2GzwO99
         iOpCyt8jszQJI+8L/YjaEhFRh2izKxZYgJaERCP2dZbduV5jh/8jIjHKqloD9pfoAOH5
         mlyEgoognJTOGCQv8wLeclE6DYnk2zdS2leE9rT1jOe5jRJet78D8wjlHKlGrCPIgtuv
         wt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UqnEPALWHzZA1XyArIe54gSIpTfBlxJBhMMEH98tgUE=;
        b=fsrkdp0tHzBxp+I8XK9yVADkv1O2fOq+e1V1N3s/plzmvHDXoxB80SP9fadl/RGEj4
         3pJEW5ql8Z/ZtyTxRVDlwuz/xbTK/b0FWRlR8m406yBPgn2dFYqhuzPyIL3rXl0gLdpI
         aseBxy4bCzM2HxLzbNeyZeKcCwkJJUJu7uPUb643HXTB53NNiBhKixhvXNpPM35ykXW6
         wECOQRtRpo7gS3+nJQpEVaSkRw29D9BYnNdc/cQRZflnedeJfpEtrCHIihnn6DsP64mO
         sCtL4368Vl52DwJNs6f0xmeL4nVHqLV3yAV+Vjh8K5JDHb06Wrz4QSegxZy4Yjfs8plD
         yOPg==
X-Gm-Message-State: APjAAAUMVthRnkZQgyroEn22/xsWwwO9fXr1KoaoS3FczOI3R8gKELk0
        7OUnYVfpvlimItiYZ3cHweD9CQ==
X-Google-Smtp-Source: APXvYqxwVBPZqqbgaYvff2juBz4dLlvAIoJIWaijz/+a7wJ8MfYjW2y6dqFWKfa03fsQ9NmnU2HUZA==
X-Received: by 2002:aa7:951c:: with SMTP id b28mr3530292pfp.97.1578468822078;
        Tue, 07 Jan 2020 23:33:42 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id s1sm2169870pgv.87.2020.01.07.23.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2020 23:33:41 -0800 (PST)
Date:   Wed, 8 Jan 2020 13:03:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] opp: fix of_node leak for unsupported entries
Message-ID: <20200108073338.4z6gktglduigfo5p@vireshk-i7>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
 <20200107063616.a3qpepc46viejxhw@vireshk-i7>
 <20200107140449.GB20159@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107140449.GB20159@qmqm.qmqm.pl>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-01-20, 15:04, Michał Mirosław wrote:
> On Tue, Jan 07, 2020 at 12:06:16PM +0530, Viresh Kumar wrote:
> > Discard my earlier reply, it wasn't accurate/correct.
> > 
> > On 03-01-20, 20:36, Michał Mirosław wrote:
> > > When parsing OPP v2 table, unsupported entries return NULL from
> > > _opp_add_static_v2().
> > 
> > Right, as we don't want parsing to fail here.
> > 
> > > In this case node reference is leaked.
> > 
> > Why do you think so ?
> 
> for_each_available_child_of_node() returns nodes with refcount
> increased

I believe it also drops the refcount of the previous node everytime the loop
goes to the next element. Else we would be required do that from within that
loop itself, isn't it ?

-- 
viresh
