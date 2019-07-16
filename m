Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAFFC6A07E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 04:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733308AbfGPCOA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 22:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733303AbfGPCOA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Jul 2019 22:14:00 -0400
Received: from localhost (unknown [88.128.80.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B527C20880;
        Tue, 16 Jul 2019 02:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563243239;
        bh=1WXPaLAxJOus0JflLOCmf91JljCoNLWlAUD7TSVunLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=otpIewzTS2BCt4D6NLKOkDkFrN+yl1xFmNapQfs4OCftxcE6ZgRSBnNEJBuUzAaNG
         DcJDE7j2jP0Sea0ksNgunMOHibyOErzZLgL5H2ifQOEASbJxod0S4w5YvIYppWMHiZ
         tRUfvtTj4oi8FKKc9OM2Bt1Opfve1sbf7Y/nVcTo=
Date:   Tue, 16 Jul 2019 04:12:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tri Vo <trong@android.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>, kaleshsingh@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH v3] PM / wakeup: show wakeup sources stats in sysfs
Message-ID: <20190716021201.GB8310@kroah.com>
References: <CANA+-vAxU5jp6PQ26NU+UMc6iyw6KkBS9nbd6wj0qqkO-1WhYg@mail.gmail.com>
 <20190715201116.221078-1-trong@android.com>
 <20190715203651.GA7513@kroah.com>
 <CANA+-vC+_Gp4RwdLH_XYDAepRONB66PdekvaCxNT3ZVGx73G6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANA+-vC+_Gp4RwdLH_XYDAepRONB66PdekvaCxNT3ZVGx73G6A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 15, 2019 at 02:48:13PM -0700, Tri Vo wrote:
> > And I am guessing that you actually tested this all out, and it works
> > for you?
> 
> Yes, I played around with wakelocks to make sure that wakeup source
> stats are added/updated/removed as expected.

Great!

> > Have you changed Android userspace to use the new api with no
> > problems?
> 
> Kalesh helped me test this patch (added him in Tested-by: field in
> latest patch version). We haven't tested beyond booting and manual
> inspection on android devices. Android userspace changes should be
> fairly trivial though.

Ok, I know some people wanted to do some premature optimization with the
original discussion about this, glad to see it's not needed...

thanks,

greg k-h
