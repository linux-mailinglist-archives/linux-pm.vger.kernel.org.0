Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F18367166
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbhDURfX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 13:35:23 -0400
Received: from sender11-of-o51.zoho.eu ([31.186.226.237]:21112 "EHLO
        sender11-of-o51.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239822AbhDURfW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 13:35:22 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Apr 2021 13:35:22 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1619025575; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=WmXre7ic130ZOYKn+d0nKVKDMIhYzL4dXCULW7ofz24R/FKdC6PdmTZpWJG04hkaGYFT822YkOq2eKN/S+zDe7vZswz2jgyWDPiiNzaO/EPdwtD9jxuN43iOAazDpX4/hIO33rs53rPWEgavBPzK6xEh7tJKsodtk+eLMSeuTOM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1619025575; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=obrCtbJ+KgZ6tsOyyDAx+m+OwfF0hUYR7eox/my8XBY=; 
        b=Tu13UAm6jYWn1VVHyzUV8boM2z5SfT5CZMR/RdOCn6yTaXTd0v8MVQOpMNwQy9wvWRYBlMsRLn1Fu6zd2gBLUjG/UDkSSIqnIMFbcWNJjSlbVAsYi7/ogFaRbyELGDgJHxwugCxmncA3a5bdXOPgUtNGeUn6uxb/fvjAa4QLu8E=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=philipp@uvos.xyz;
        dmarc=pass header.from=<philipp@uvos.xyz> header.from=<philipp@uvos.xyz>
Received: from UVOSLinux (ip-95-222-215-74.hsi15.unitymediagroup.de [95.222.215.74]) by mx.zoho.eu
        with SMTPS id 1619025573833283.36820387667444; Wed, 21 Apr 2021 19:19:33 +0200 (CEST)
Date:   Wed, 21 Apr 2021 19:19:33 +0200
From:   Carl Philipp Klemm <philipp@uvos.xyz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     zhuguangqing83@gmail.com, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: cpcap-battery: fix invalid usage of
 list cursor
Message-Id: <20210421191933.6fa083e0b2496aedaef4957a@uvos.xyz>
In-Reply-To: <YIBNDrHlwqn5hrl2@atomide.com>
References: <20210421143650.16045-1-zhuguangqing83@gmail.com>
        <YIBNDrHlwqn5hrl2@atomide.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Looks good to me, but dosent appear to solve the bootup bug.

(this time reply all)

Reviewed-by: Carl Philipp Klemm <philipp@uvos.xyz>
Tested-by: Carl Philipp Klemm <philipp@uvos.xyz>

-- 
Carl Philipp Klemm <philipp@uvos.xyz> <carl@uvos.xyz>

On Wed, 21 Apr 2021 19:04:30 +0300
Tony Lindgren <tony@atomide.com> wrote:

> Hi,
> 
> * zhuguangqing83@gmail.com <zhuguangqing83@gmail.com> [210421 14:38]:
> > From: Guangqing Zhu <zhuguangqing83@gmail.com>
> > 
> > Fix invalid usage of a list_for_each_entry in cpcap_battery_irq_thread().
> > Empty list or fully traversed list points to list head, which is not
> > NULL (and before the first element containing real data).
> > 
> > Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
> > ---
> > v2:
> >   - Modify commit message and code as suggested by Sebastian.
> 
> Thanks looks OK to me. Looks like there's no flag we need to set there when
> the entry is found, so this should do for the check.
> 
> Hmm I wonder if this just might fix the issue where booting with a USB
> charger connected can hang..
> 
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> 
> > ---
> >  drivers/power/supply/cpcap-battery.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
> > index 6d5bcdb9f45d..a3fc0084cda0 100644
> > --- a/drivers/power/supply/cpcap-battery.c
> > +++ b/drivers/power/supply/cpcap-battery.c
> > @@ -786,7 +786,7 @@ static irqreturn_t cpcap_battery_irq_thread(int irq, void *data)
> >  			break;
> >  	}
> >  
> > -	if (!d)
> > +	if (list_entry_is_head(d, &ddata->irq_list, node))
> >  		return IRQ_NONE;
> >  
> >  	latest = cpcap_battery_latest(ddata);
> > -- 
> > 2.17.1
> > 
