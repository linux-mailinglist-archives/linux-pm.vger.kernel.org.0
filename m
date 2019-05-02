Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5881218B
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 20:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfEBSAX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 14:00:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36550 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBSAW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 14:00:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id w20so1383152plq.3;
        Thu, 02 May 2019 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9M+4aR9fNWXNflKVe7nz1SP5sWWG5VRDSahF3SFgwmQ=;
        b=D/VPU66BvpekGFROv6r0X+7oDOtKJ9ft86oiABfVYkVUdvIwmNF4hn15tTbQlJUHX1
         xeiSGoJ4N8irW+3nxecq3c4XOPjK1zOHGe5jJ6FmljDBRjI1GkAFjU9j0vDP5dGw0T41
         BQ3DRP+5NBE+wrqv9FhMK4K6UIHKXjdHFOG8IytY37oNKb4IzBXJOAIBKRIUlXylZ/Yf
         nxfECqXQORwuw6/RMIaPIfbwMyO/OeqLdlgLdBvK0a4im6NDG7UIxuh9w8atQpnE3L1u
         3FwNutokPFgVGuQzsBCassISOuZNxJooM5kg45nXo+G/K5oua2Te/LJ+ca00lwE90pvw
         qnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9M+4aR9fNWXNflKVe7nz1SP5sWWG5VRDSahF3SFgwmQ=;
        b=g90Obd6oykc5oqaAqWbRri2S3FbJIJe7wemFTKgVquUCfMTrLotfvmzIfev8du/QbX
         UMSt1YMAuBMEppnqudlKhuWkyIPut7gHolCvwIrilaxfHb/Xhsre/tuKe0xpFzx9zLB1
         qJ8sg/fBSQXzf16214/7CgWj3B7aHC4OdM6EYVgL5j0Vp6XdbfAIEcukEL7AXiB1lE0R
         d2DFp9oMcC5MHz+pyGqrlMuK/FV/AEZhkCJZQ1nP+CXekmMIRl4ns138zWMCB/KZWqrG
         E3NRaEAtwq6KHooLEybCDu6QxuhmiYBnXknkaZFvmc+CQh2f/SEiBAkd00Xe+eHQwnwX
         WC4A==
X-Gm-Message-State: APjAAAU1CWgPPyCMoPZN4m1RIVkvQRnNv5hM/jlSMKemN7zx1jETcBmI
        u/qCQS0XpthyBjf9NEzYhMQ=
X-Google-Smtp-Source: APXvYqwB/glr1vl0VtIIotv8ZpC9pruGFbGjfyxYpf8EEkwywfCzYZSKTA0/MLo76/1GE7kLgTIZKw==
X-Received: by 2002:a17:902:9a0c:: with SMTP id v12mr5270619plp.184.1556820022117;
        Thu, 02 May 2019 11:00:22 -0700 (PDT)
Received: from vostro (50-0-151-188.dsl.dynamic.fusionbroadband.com. [50.0.151.188])
        by smtp.gmail.com with ESMTPSA id k26sm2730412pfi.136.2019.05.02.11.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 11:00:21 -0700 (PDT)
Date:   Thu, 2 May 2019 10:59:58 -0700
From:   Nikitas Angelinas <nikitas.angelinas@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power/poweroff.c: mark variables with __initdata and
 __maybe_unused
Message-ID: <20190502175958.GA14955@vostro>
References: <20190502074305.GA6039@vostro>
 <20190502101500.GA23980@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502101500.GA23980@amd>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 02, 2019 at 12:15:00PM +0200, Pavel Machek wrote:
> On Thu 2019-05-02 00:43:05, Nikitas Angelinas wrote:
> > There is no need to keep sysrq_poweroff_op after initialization, so mark
> > it with __initdata.
> 
> Are you sure?
> 
> pavel@duo:/data/l/k$ grep -ri sysrq_key_op . | grep initdata
> pavel@duo:/data/l/k$
> 
> 
> 									Pavel
> 
I am sorry about this. I completely missed the point of registering this
structure. Please ignore this patch.



Cheers,
Nikitas
> >  
> > -static struct sysrq_key_op	sysrq_poweroff_op = {
> > +static struct sysrq_key_op sysrq_poweroff_op __initdata = {
> >  	.handler        = handle_poweroff,
> >  	.help_msg       = "poweroff(o)",
> >  	.action_msg     = "Power Off",
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


