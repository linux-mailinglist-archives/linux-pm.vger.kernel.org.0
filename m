Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077EB2A2410
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 06:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgKBFXI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 00:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgKBFXH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 00:23:07 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB83AC0617A6
        for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2020 21:23:07 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id k9so8090819pgt.9
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2020 21:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Z6jFeOISoVy0hjItvU/r5loHMWkMguydCyBxu8A1QU=;
        b=WX5b0qQ/RudjEHHhNSB3Fwvaq6bX9GBrnTQe2TTWsid5gIphMJ/hgorRAUJvNy87LP
         zAFitkuczVIfvkdobLFVnL12CKrfN8ARK0bpkCKE2wjQzzSRa6glWEtXYsJsMnkdv+zP
         0XzBK3WfsMuLHy7QJxttnlbxSoJ74/EQ09v/d0B8ASvslbPuhnvzkoK0kRS21l4gsuPi
         mWh9UzL+clhiqbxsoVMaaymgxh/4bIQpsv4sgbhDsX//avyUmzazRYGWwbP9rHwHEdWf
         L7VQrfGxhd9kmisVHsQenZxVRoDtkdQInpF/PLFRS/bjOZPWmxbWOAd3xmhHPq3xm91p
         FJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Z6jFeOISoVy0hjItvU/r5loHMWkMguydCyBxu8A1QU=;
        b=fSrfExp+evnZcKUMzG1TRAeYH/MTMZSxd1c8VZ23ngLQ9Yj4lr/952gSt3TSZbyAqS
         iaFR1IeAuoWXv/uUdisYaDtcj9UkHEo+UyakOEvrIxAMwvD4j/em20ZCwLmbDbVNQXRP
         0YC6yiQHhPqCKLH0PI3sUZqXTYvbxPXE8SMCDHD6CYwtO1ViGYD+7o6fOzwFiIppiLgQ
         seb8ba3m1e0mOHHq7sChCYxeQtwe3+4gq77GufHyee9OQDlSic+AbCySq3A+M2gfW9Pi
         SBAzjkg58HpTNfhqv28XfZE/RIyorQOjqWpkdNTfs/BAtrnrvf+kq+kD1mdaKNE/WdM8
         GSrw==
X-Gm-Message-State: AOAM531f3oE2UiHqDPJ0xarn1b6U37TpUbJFwU7b0QukyD0uDrhHcemV
        j93XpNBpgFtmslwH2AQDy0DIIg==
X-Google-Smtp-Source: ABdhPJxF4QOhMT4DelTkJQhcNWvMH0yATAaMnutzgC1B6LeSKNZ1zr2lxVysf5iyGuYHXsXb39U3ng==
X-Received: by 2002:a17:90b:3505:: with SMTP id ls5mr4833886pjb.134.1604294587207;
        Sun, 01 Nov 2020 21:23:07 -0800 (PST)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id u14sm10661200pjf.53.2020.11.01.21.23.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2020 21:23:06 -0800 (PST)
Date:   Mon, 2 Nov 2020 10:53:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Reduce the size of critical section in
 _opp_table_kref_release()
Message-ID: <20201102052304.rha7hpulcswqoh4x@vireshk-i7>
References: <e0df59de670b48a923246fae1f972317b84b2764.1603785323.git.viresh.kumar@linaro.org>
 <160392797572.884498.11353243518476305974@swboyd.mtv.corp.google.com>
 <20201029041019.xps4dcavkvk6imp5@vireshk-i7>
 <20201030042000.bo3dwrmi7efoe42v@vireshk-i7>
 <160411279004.884498.13305671365226511605@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160411279004.884498.13305671365226511605@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-10-20, 19:53, Stephen Boyd wrote:
> Quoting Viresh Kumar (2020-10-29 21:20:00)
> > On 29-10-20, 09:40, Viresh Kumar wrote:
> > > Thanks a lot. I was a bit worried about the crazy idea I had to solve
> > > this :)
> > 
> > Hmm, I thought this is the other patch where I had that crazy idea.
> > This one was quite straight forward :)
> > 
> 
> What's the other crazy idea patch?

Surprisingly I never sent it properly, just shared in another email thread with
Rob Clark to test it out.

Sent that now.

-- 
viresh
