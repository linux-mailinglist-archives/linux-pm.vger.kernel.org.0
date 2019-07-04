Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 507055FE80
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 00:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfGDW7r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 18:59:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41623 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfGDW7r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jul 2019 18:59:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so7263742ota.8;
        Thu, 04 Jul 2019 15:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnfMXaG+XzQAsgJcmPp9Bhtt71ddIs1XOoLY8p4aiPI=;
        b=otMiGVL3Zh9VWOB8aHxeuOVqLsNZ7Y5gWRcl6k+1zrygRVVKdGpKD3chgWlis8v9/h
         lD1gt4W/tBT8G1Uwxom6vQ0cCW0iIYWQgjP5N27Oiln2NeWkAoNxvgGeAbEknaFtb3JH
         BrPjePJ9FDGWk+p70OT3CuPK42BqO2hjl5Nh6xM0eZZTLMcmhX+jLL8EoGm/t+ul5zlC
         tht3lhMoZiesPk0knEiJ/IDMphtX2BfQIK0xtoC2RzmaGs/t0+ZOuVqdguitil4yBa3G
         i66bDLNU6a6TMZee/upL1Zll6VFbesIXrysjXJKPaRSR8bn4O7L+9Rip6wjjh+K8HtaF
         9LGA==
X-Gm-Message-State: APjAAAW2mdsh8DFOVE/5qm8WktoqvfPH51NeNw2/gJ0aOOtoHs2Y09he
        gEEgA5sJr+/tLNft/mFLQul4MINsG1Mn88Gj1zM=
X-Google-Smtp-Source: APXvYqxF9ZMGY45AnEiuieibPhYW7Lb7YHSMpxnTlyzTCj1qfMcp7W7Pdu3P7pIJQ+5CELATGfZqlOmbGuvYbQMUavo=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr349262oto.118.1562281186444;
 Thu, 04 Jul 2019 15:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190704192020.GA3771@amd>
In-Reply-To: <20190704192020.GA3771@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Jul 2019 00:59:35 +0200
Message-ID: <CAJZ5v0gn7FWpqW+WmCzj1=K-pjY=SjRNuEsMR3bRTSO8FzFG=Q@mail.gmail.com>
Subject: Re: suspend broken in next-20190704 on Thinkpad X60
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 4, 2019 at 9:20 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> Suspend is broken in next-20190704 on Thinkpad X60.

Broken in what way?  Any details?

> It very very probably worked ok in 20190701.

Well, please try the linux-next branch from linux-pm.git
(git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git)
alone and see if that fails.
