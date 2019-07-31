Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29A9B7CD5C
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 21:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbfGaT7G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 15:59:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730095AbfGaT7G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 15:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0FCgrVECgHJ5mN0TOLb6qGjmrOPbesWGR16zdSh0WtI=; b=r7C5N+pecqmZ+wGnQ0eBJgI6K
        OieGkEotLn7ZIsuqxUC09nkXC73FRG+HDD++sZo3HPiL8KRuchfKzaGeQcf8QXAHUlZrTKWCZbnW9
        XvyWyaHapg1EjywoFq/+xTK1gnG8oucj1vaplCGjFUN72/Z6ptG85+uQbhNBHZyb0P8d9Jd0UA8Ne
        QcCA8MOBHBfi2ptKd6QqtTO6YWXLZy4KlxASy6Lxp6OgAi60GuN28VgGdvnYJAJ6FSsYy0z4lXlyj
        498IiA36yV7ceGVsFa8EYPmNeS+ngzQjsAszY/ePkT+si/20g40OyJ2wwihWvUc+FnlLcfMaSDCzn
        EtYGbtdQA==;
Received: from [191.33.152.89] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsukZ-0008O6-Nm; Wed, 31 Jul 2019 19:59:03 +0000
Date:   Wed, 31 Jul 2019 16:58:59 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 01/26] docs: power: add it to to the main
 documentation index
Message-ID: <20190731165859.10b439c8@coco.lan>
In-Reply-To: <20190731133443.49368cbb@lwn.net>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
        <5417112ea7a391e6622c46bf833b7d6a5725c158.1564145354.git.mchehab+samsung@kernel.org>
        <20190731130338.6de6c5d7@lwn.net>
        <20190731161606.2572a567@coco.lan>
        <20190731133443.49368cbb@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Em Wed, 31 Jul 2019 13:34:43 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 31 Jul 2019 16:16:06 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > The remaining ones in this series aren't there yet.
> > 
> > From this series, besides this patch, you can also exclude patch
> > 25/26, as it seems that Paul will merge via RCU tree.
> > 
> > The remaining ones apply cleanly on the top of docs-next
> > (I tested applying them on the top of your tree yesterday).  
> 
> Hmm...really?
> 
> - [PATCH v2 03/26] docs: powerpc: convert docs to ReST and rename to *.rst
> 
> 	Seems to already be applied.
> 
> - [PATCH v2 07/26] docs: w1: convert to ReST and add to the kAPI group of
>   docs
> 
> 	Gives me the dreaded "could not build fake ancestor" error, I
> 	don't really understand why.

That's new! What Sphinx version are you using?

Btw, on my build here (Sphinx 2.0.1 on Python3), I can't see this error.

> 
> - [PATCH v2 08/26] spi: docs: convert to ReST and add it to the kABI
>   bookset
> - [PATCH v2 16/26] docs: fs: cifs: convert to ReST and add to admin-guide
>   book
> 
> 	Likewise
> 
> I've applied the others, so we're getting closer...

Weird...

I did a rebase here on the top of your current docs/docs-next... they
apply fine. Had to do just a small trivial fix on one of the patches.

Anyway, thanks for merging those... I have now just 5 patches.

Btw, it seems that there are now 5 new broken links:

MAINTAINERS: Documentation/filesystems/jfs.txt
MAINTAINERS: Documentation/filesystems/ufs.txt
drivers/hwtracing/coresight/Kconfig: Documentation/trace/coresight-cpu-debug.txt
fs/jfs/Kconfig: file:Documentation/filesystems/jfs.txt
fs/ufs/Kconfig: file:Documentation/filesystems/ufs.txt

4 of them related to the two fs patches applied today.

I'll send you a fix together with the remaining patches in a few.

Thanks,
Mauro
