Return-Path: <linux-pm+bounces-15406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E54F9970D5
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 18:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D6C4B21CF8
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 16:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82DD206961;
	Wed,  9 Oct 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="chWmB0Ot"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139621E3DF9
	for <linux-pm@vger.kernel.org>; Wed,  9 Oct 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489048; cv=none; b=RoDnfWMv03KCy0VMnvyA3O7SBuxjdqUF5FuGe97r67Q0K0GIZBd30rTFP2YZLhBSNEuk7MTkRJaVRpq1eQwaOIwQCElgq0C6aXu1exI7sdCWEhRR9EJEPIuBMgr02d7xFJWcK0PD+owtkhPzX6bWNtRCcYnxuuaMogD4w7w8BIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489048; c=relaxed/simple;
	bh=OmwyS3GSE5s/9kY3ybmyfZGiNcfsRHrwELKvRrHQkSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKbbuoGrZg2hTfqrUn4L4k74pNreSsBy6OjYWKss9nYm8KVBe42fAU34MhXgvLIQu2EUv0xwRzx73IqHGCiEdP3bsxFXg87sLwrjjjD/a/E/ZK6/pbQVyYiPUI00e4BMBYzZL75Fn+uAc96ZcrfiWKZaRhqpXa5O/EAY9BOquBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=chWmB0Ot; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45ee18f058eso36211cf.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2024 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1728489046; x=1729093846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0BahaGyOs3RbKN27MjD5OzyEnaYqYENahYoWiqAVa0=;
        b=chWmB0Ot/DwYNdbxUngtOMMhrfjExt7RP8sD9ypFgJsdh1YllO7m0FsTR1I9WK1qju
         R4B8K5olBHVh6lcEQ4RJb+ibYLnuRjyFlq5EvvZnBJG7eXIUalQTHfjPPFjGBL+NFi1r
         c0zVgzQKCVCPmBU356asoyPsPLJBx2b6IR6PL5waiGYIPiHH6zUasPtfB4AKssXwT9vv
         TLuurU1R6Qi0AGTjP+P4z/Zf8qyeOha4n5z//CypCzxn+wfoHoskq6ujKR2bk00wYQQM
         6hXv/TvuA+QYDLQmAu57Q0OCcT6Yy42oGKbLZei0iqipb0qcfm0zwfM0XX8qzcL82tpo
         ARVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489046; x=1729093846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0BahaGyOs3RbKN27MjD5OzyEnaYqYENahYoWiqAVa0=;
        b=P6pNYynVOBKiybQoXu0zadHNwWh09ru8/jOdSzVAiOmOKaZIBlCYNAhe+qhS51HM/2
         D5OhX3Ry6cJVz0bKYJezqgze8iSXiyJyBCg7egLvVXLD7IXEKVLRWRtYUgJ/bjVan7Ju
         ZQtlT0o9N3cl9gZRz23CADWYN3yFEPZTb/njgVNr20+07a/oKV+CmzQG3JZvRGGQlWeG
         3IYDPYoiZjOrdLD4AmkGLNRgfpXv35BWgI91hmaU1BCtCMdkjX/lctVXwuy0a1RQX50o
         +0ikPjlI66PRguHjj39sKMoi2nBycxRfd4fLR8D2NbcCSFZDom2CvNDMIoX89VBK8bZx
         zyag==
X-Forwarded-Encrypted: i=1; AJvYcCWSYOkCPRLEPyKyx3AWNDecu1HvSGpPgmB71G5RXrTXT9pMhsERiq0bHI7IzMFbx3tFIT0b4fE83g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGrEtgLBupbcfG0W+OVX2VdaiuO5E7DPfikmRx8b9y/KnkKuw
	5vbKN3qdpvWVE3rmqG9B0sJOP7Ur7iKiyhP6LAWbueshbmo11N1NzdpxzNCsPA==
X-Google-Smtp-Source: AGHT+IGVv9FRSuf+Rrvp+G110Shph8S5aMJB4HlFe+wKJFnKmoExxlTR6BybSIsHj1ywu8PwtUpanw==
X-Received: by 2002:ac8:5782:0:b0:453:15b5:26b9 with SMTP id d75a77b69052e-45fb0e75577mr39831301cf.52.1728489045831;
        Wed, 09 Oct 2024 08:50:45 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:2501:2805:c6d5:fe22:7fa3:ec54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45efcedd9dcsm17305761cf.91.2024.10.09.08.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 08:50:45 -0700 (PDT)
Date: Wed, 9 Oct 2024 11:50:42 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: duanchenghao <duanchenghao@kylinos.cn>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hongyu Xie <xy521521@gmail.com>, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, niko.mauno@vaisala.com, pavel@ucw.cz,
	stanley_chang@realtek.com, tj@kernel.org,
	Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Message-ID: <2c368013-8363-4a4e-bfee-2f0b14d01162@rowland.harvard.edu>
References: <20240906030548.845115-1-duanchenghao@kylinos.cn>
 <1725931490447646.3.seg@mailgw.kylinos.cn>
 <a618ada1582c82b58d2503ecf777ea2d726f9399.camel@kylinos.cn>
 <8b07752d-63c4-41e3-bd20-ce3da43dfffc@rowland.harvard.edu>
 <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>
 <b8dc326b-8aee-4903-bbb6-64083cf66b4d@rowland.harvard.edu>
 <bddecd4e-d3c8-448e-8a22-84bbc98c4d1b@kylinos.cn>
 <b2ec107d4797f6e1e8e558f97c0ad1be6d46572c.camel@kylinos.cn>
 <84a4f66a-5b0e-46a8-8746-be6cd7d49629@rowland.harvard.edu>
 <fa347849defa66a7d4af23ac6317ae5b37357ea4.camel@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa347849defa66a7d4af23ac6317ae5b37357ea4.camel@kylinos.cn>

On Wed, Oct 09, 2024 at 10:35:05AM +0800, duanchenghao wrote:
> Hi Alan,
> 
> These are two patches, each addressing the same issue. The current
> patch is a direct solution to the problem of the interrupt bottom half
> being frozen. The patch you replied with is another, alternative
> solution to the same problem. Please review which solution is more
> suitable, or if there are any other revised proposals.
> 
> 
> Please review the patch I mentioned:
> https://lore.kernel.org/all/0a4dc46ae767c28dd207ae29511ede747f05539a.camel@kylinos.cn/

I still think your whole approach is wrong.  There is no need to change 
the way the HCD_FLAG_WAKEUP_PENDING flag gets set or cleared; that's not 
the reason for the problem you're seeing.

The problem occurs because when suspend_common() in 
drivers/usb/core/hcd-pci.c sets do_wakeup, it does so by calling 
device_may_wakeup(), and the value that function returns is not what we 
want.  The value is based on whether the controller's power/wakeup 
attribute is set, but we also have to take into account the type of 
suspend that's happening.

Basically, if msg is one of the suspend types for which wakeups should 
always be disabled, then do_wakeup should be set to false.  There isn't 
a macro to test for these things, but there should be.  Something like 
PMSG_IS_AUTO() in include/linux/pm.h; maybe call it PMSG_NO_WAKEUP().  
This macro should return true if the PM_EVENT_FREEZE or PM_EVENT_QUIESCE 
bits are set in msg.event.

Rafael, please correct me if I got any of this wrong.

So the right way to fix the problem is to add to pm.h:

#define PMSG_NO_WAKEUP(msg)	(((msg.event) & \
		(PM_EVENT_FREEZE | PM_EVENT_QUIESCE)) != 0)

and in suspend_common():

	if (PMSG_IS_AUTO(msg))
		do_wakeup = true;
	else if (PMSG_NO_WAKEUP(msg))
		do_wakeup = false;
	else
		do_wakeup = device_may_wakeup(dev);

Then with do_wakeup set to false, none of the HCD_WAKEUP_PENDING() tests 
in the following code will be executed, so the routine won't fail during 
the freeze or restore phase with -EBUSY.

You'll also have to define an hcd_pci_freeze() routine, just 
like hcd_pci_suspend() except that it uses PMSG_FREEZE instead of 
PMSG_SUSPEND.  And the .freeze callback in usb_hcd_pci_pm_ops should be 
changed to hcd_pci_freeze.

In fact, it looks like choose_wakeup() in drivers/usb/core/driver.c 
could also use the new macro, instead of checking for FREEZE or QUIESCE 
directly the way it does now.

Alan Stern

