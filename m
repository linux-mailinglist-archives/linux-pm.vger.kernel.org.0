Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8D719A2CF
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 02:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbgDAAW4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 20:22:56 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35496 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbgDAAW4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 20:22:56 -0400
Received: by mail-pj1-f68.google.com with SMTP id g9so1859644pjp.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2020 17:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0o2sV67Co/BBx0wQ4CH55gP8jkBwRSr+2tVUKNJ+jjs=;
        b=WO+ozxIIDjv27brvR7QvEowOsM567l0YbO2zH0gREDzz8YZrcRPYUZ1V1ZPiOl3NfE
         1EaDjS+UlqeOO7OB5Yd/lEZQKIpjeHMjsQPi/V0FK6RcTFGYN1joylj1uA8zmjk9JoY0
         4srtd/tCSlN1MTJV2QRYOYqxk/xfRkSy35AILPNtkOl6ho6qt4Ix3UkaPF8iecDSFbro
         kq8+lqj7uW9i+RE5rNwRra9PQaClmxoQo9ArJX72Z9usw4uJcX7GsS4vntuwxjs+J+aw
         iPulgCUfwRmovAjXdFqTWyLVkSl36vOYQp/J488xiS2HANCxmT8RN5ywrd8LxelYB+LQ
         e8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0o2sV67Co/BBx0wQ4CH55gP8jkBwRSr+2tVUKNJ+jjs=;
        b=VXfhtE1cLMx15V/c+zRgHpOCzZXhPRP6JO9gQjLxum3wxaWx7XfOisN5Fu07Ejpm4m
         WR/v5vj8UWF+KAkzcvOMuQhmO8W6OZrKtaFiTpVtSxX5iLgPg0Vt/l+CU8Ybr5X+5s0I
         +nFP5cRcEKhEWBTgnthXrgtVKZapvX44broPX+LuJeEsQYKmTU/Ce1eF2FNWweGMvU8z
         RSb8CIZt2yovFbOGBgMfxnyEV2TyG68adWQQ25xYByyJe8/OU66qJ6pcBAqrEBEGfCAh
         E0QX9dKLJlAdRJ0qskITIQMpcvMnwl6ZS1zCz/nWMG/K9ChQCqMAs9XLb7clajoVrdqi
         BRpw==
X-Gm-Message-State: AGi0PubHeFAgkiq26dgCjo6LkPubk6dSoY/oyZntcRzbOZvzjTcjet2a
        ujMv8zIEh3RnG/UEtgf5PsF8Rg==
X-Google-Smtp-Source: APiQypKuzqy2/q3VbEGna+2WnnSYjgThOwQnOXSMdNxZiSgHa5xgjTxdBLOAa4VjYDpVIPuyUNxudQ==
X-Received: by 2002:a17:90a:2103:: with SMTP id a3mr1623468pje.181.1585700573639;
        Tue, 31 Mar 2020 17:22:53 -0700 (PDT)
Received: from localhost (c-73-170-36-70.hsd1.ca.comcast.net. [73.170.36.70])
        by smtp.gmail.com with ESMTPSA id z8sm205317pju.33.2020.03.31.17.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 17:22:52 -0700 (PDT)
Date:   Tue, 31 Mar 2020 17:22:51 -0700
From:   Sandeep Patil <sspatil@android.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 2/4] power_supply: Add additional health properties to
 the header
Message-ID: <20200401002251.GA177505@google.com>
References: <20200116175039.1317-1-dmurphy@ti.com>
 <20200116175039.1317-3-dmurphy@ti.com>
 <20200117010658.iqs2zpwl6bsomkuo@earth.universe>
 <20200306235548.GA187098@google.com>
 <6b947adc-a176-5fa0-1382-8b08ec3f8b09@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b947adc-a176-5fa0-1382-8b08ec3f8b09@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 10, 2020 at 03:09:37PM -0500, Dan Murphy wrote:
> Hello
> 
> On 3/6/20 5:55 PM, Sandeep Patil wrote:
> > Hi Sebastian,
> > 
> > On Fri, Jan 17, 2020 at 02:06:58AM +0100, Sebastian Reichel wrote:
> > > Hi,
> > > 
> > > On Thu, Jan 16, 2020 at 11:50:37AM -0600, Dan Murphy wrote:
> > > > Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
> > > > 
> > > > Signed-off-by: Dan Murphy <dmurphy@ti.com>
> > > > ---
> > > Looks good. But I will not merge it without a user and have comments
> > > for the driver.
> > Android has been looking for these properties for a while now [1].
> > It was added[2] when we saw that the manufacturers were implementing these
> > properties in the driver. I didn't know the properties were absent upstream
> > until yesterday. Somebody pointed out in our ongoing effort to make sure
> > all core kernel changes that android depends on are present upstream.
> > 
> > I think those values are also propagated in application facing APIs in
> > Android (but I am not sure yet, let me know if that's something you want
> > to find out).
> > 
> > I wanted to chime in and present you a 'user' for this if that helps.
> 
> We have re-submitted the BQ25150/155 driver that would be the user and we
> have 2 more for review that will use the new definitions

Dan / Sebastian, I wasn't able to find the subsequent patches
that add the 3 health properties, so I'm assuming this patch is still
"out-of-tree".

I was hoping against that so we (Android) aren't unnecessarily diverging
from upstream. However, I have now just cherry-picked this patch[1] for the
next Android release.

Sebastian, since these appear in JEITA spec, will the same patch with
additions to the commit message saying so be enough?

Thanks,
- ssp

1. https://android-review.googlesource.com/c/kernel/common/+/1275596

> 
> Dan
> 
