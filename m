Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03941FEB4A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 08:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgFRGOZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jun 2020 02:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgFRGOY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2020 02:14:24 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B58C061755
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2020 23:14:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d10so112168pls.5
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2020 23:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9qR0fuoqIBy0xUAm2ITtA1DoU0HgxEgx3YBhTm/3Gek=;
        b=j5W1UFSmkVhTt7/aLu+Byy4gWGen8wWhvgWZRToHhZS3+p4zloJZgwWyU6X7QkGagZ
         KkPK+JeL+QUF7Z5xWGU9ZLRq8HzH7LmNtPKB/tGZyjA/n5xQeWRs+DGYiYgEJcoSoN9T
         aTXyVSaMrW2VWoC2pqXkVaTeErWrzJ6UUTFnO57U2oVwMmtqExRPcSfR65E4AOnHxW8X
         6MvFC2YBrWgfl7z3rPrFfTa4ZZGWd/whgnn78dlKw8Fm55IGCtlv15C/U6Z/iL7sek4p
         agPvgixAMciwE7dz0w8i+SNYxsQR+GbIUim3y3IBDgA5TMZCm9ynoyrq3+/F/AqxK+06
         +vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9qR0fuoqIBy0xUAm2ITtA1DoU0HgxEgx3YBhTm/3Gek=;
        b=ROq3ZqWLRKmb7cBhTSgXzJFv8NdixaXkfWuiDDjs1UqoRN+yLhAbaSxLWECGYrH45o
         l1zDdgMq50x9+QmrO0+weVSB70l/qMMG8t26GP5nHZRFElCNwTwFr/lKeR+fR9KQhU11
         O0XkxMiW00CtHsLBrztsqHW+fKrR0ZNhAu4qZuPot9ogB3sfTn7mtvL/i98K2Dlz7nzS
         JAV+vxRXEc7VASa3KgXoV6n1aF03MP2k229Ud8qil1Il8Zo4DPNCReCdgJy5xw0lhW9G
         IgDyZBNTfC/m+BTfgBf9z1DosvTKUF8CyAfVYxslkgAWaJqMnXbxA7FYKVR7F+SC9bQ7
         9+TA==
X-Gm-Message-State: AOAM533zVrzx/rYBtLaW1zqFIRlR46Pyk4UgsH0nDUstHEAzniZxQZZV
        ci2qf2w+UO++vwQ4EhiH8eSO24bpvxo=
X-Google-Smtp-Source: ABdhPJx1/jxhXBS8AN8LHrbnqRktjYWNTZxxEd020DnwsWjMOLk/3LSKicpt+yNaq9ciJ4xxgJmn5w==
X-Received: by 2002:a17:902:b403:: with SMTP id x3mr2394513plr.240.1592460863990;
        Wed, 17 Jun 2020 23:14:23 -0700 (PDT)
Received: from localhost ([122.172.119.132])
        by smtp.gmail.com with ESMTPSA id r132sm1689881pfc.96.2020.06.17.23.14.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2020 23:14:23 -0700 (PDT)
Date:   Thu, 18 Jun 2020 11:44:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: Re: [PATCH 2/2] cpufreq: arm_scmi: Set fast_switch_possible
 conditionally
Message-ID: <20200618061420.5q7xsldakax2zro5@vireshk-i7>
References: <20200617094332.8391-1-nicola.mazzucato@arm.com>
 <20200617094332.8391-2-nicola.mazzucato@arm.com>
 <20200617124753.GA15211@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617124753.GA15211@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-06-20, 13:47, Sudeep Holla wrote:
> This is first step towards avoiding polling based cpufreq set if firmware
> has fast access registers that bypass normal mailbox based messaging.
> 
> If you happy with this and provide ack, I will take this along with scmi
> changes via ARM SoC. Hope that is fine by you.

Sudeep,

I am not sure how it concerns me frankly :)

AFAICT, this is enabling fast switch based on some mechanism (internal
to scmi) and so either the cpufreq driver will have fast-switch
enabled or not, and both are fine by the cpufreq core.

And so I am confused on why my Ack is important here :)

-- 
viresh
