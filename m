Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEB3F7894
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 17:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKKQRp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 11:17:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfKKQRp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 11:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JOQLx3ZKrI0K+Bq2WdjB8BmGIG8Kvh4vTdEVFJHVFYM=; b=rNhhsUmxXuV/fXVhv/HtZ8L1c
        zpp6RCuo4cyIZMfiY+Tul59en/Vznu0ggsRZnHcj1743JNBb/UpZtKjxx7uusjfHnw3eYqDVdEc4x
        /Ox3mvW1tf3arCF+M4rKz9XkKqHq1H9Q1/6Ay6X2DvKPqM66OkyLqMWoVkro4vb2LumHUwBemmnFF
        G4p81QQvBjavlVCyRUkHngspaTi6bTZ64y7T3nEMT/RDjEMqKLoFWUb0Hi8AWxCilFEfB8RNcryz5
        RvLvcQSaBCA35g0jvlg+kit5Avhh05zD6Si6RLgeFfcPoeaYuI9XL13tDZ3Q8e9d3+emHOe9ORRoL
        1aYTb9RzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUCNr-0007w6-ED; Mon, 11 Nov 2019 16:17:43 +0000
Date:   Mon, 11 Nov 2019 08:17:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Elliot Berman <eberman@codeaurora.org>, sre@kernel.org,
        tkjos@google.com, tsoni@codeaurora.org, rananta@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] reboot: Export reboot_mode
Message-ID: <20191111161743.GA24952@infradead.org>
References: <1573241532-21554-1-git-send-email-eberman@codeaurora.org>
 <1573241532-21554-2-git-send-email-eberman@codeaurora.org>
 <20191108193958.GA1273544@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108193958.GA1273544@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 08, 2019 at 08:39:58PM +0100, Greg KH wrote:
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index c4d472b..6518370 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -32,7 +32,9 @@ EXPORT_SYMBOL(cad_pid);
> >  #define DEFAULT_REBOOT_MODE
> >  #endif
> >  enum reboot_mode reboot_mode DEFAULT_REBOOT_MODE;
> > +EXPORT_SYMBOL(reboot_mode);
> >  enum reboot_mode panic_reboot_mode = REBOOT_UNDEFINED;
> > +EXPORT_SYMBOL(panic_reboot_mode);
> 
> EXPORT_SYMBOL_GPL() perhaps?

Absolutely.  But then again drivers/power/reset/reboot-mode.c, which
he wants to make modular in patch 2 is just a trivial abstraction
that avoids drivers directly poking into these values.  I really don't
see a point to make that modular to start with.
