Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E607DB757
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 21:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393062AbfJQTUN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 15:20:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46097 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfJQTUN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 15:20:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id 89so2853108oth.13;
        Thu, 17 Oct 2019 12:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/qoyoMQ9W4I1/TYe0ldoyjtavCj7X+7Ce3KSIjFEFU=;
        b=PelJKRk2DHJV3qBvE3sMdIIHJ6mZZq989mkneN8n3olSs4RWvIyYdpvEGJhy5RD1OI
         HuxDZhvSdXmgGjaOzhZBHHGNTg6jiAg6Xm7OWoXKGt8EcM+3pkA9uTXcUmpOMPMKkTCW
         aT4EVkcanTMTZ+O/0/JU65KmoDKH0H9Hdza1FLzoM2fkfCcxfYOZ1obL1+nCq+Jy57Ay
         aQRR2MHYExlZB8Nk+l5kHQbvHgaZLTvDv9/xWLTSojpbWdluSLZapmDCLfIdqHBp40Jd
         5S6+Nk7xNRKczlUvJ3ckMxQcar7bx9OzFLb3zBDu2Sl+zhtbV3pula6fch6OofXhCMr6
         fjCA==
X-Gm-Message-State: APjAAAUTodRptpWb4AhJj9RMFeoI7q3W1xzyCGUA2X8m/7i0eahoxj/t
        b7x3FeJg1PWFV20NYiwF/RBsl6IKCPD1lXgmLLo=
X-Google-Smtp-Source: APXvYqyAEnmPGU3ezJi7jTfyrQ8QxlGN+0MQ16rBMGX4W5MPPz1Cythbt53Gq7sGENDVVoRthO5D7hrXg2HjRkERjOY=
X-Received: by 2002:a9d:459b:: with SMTP id x27mr4188702ote.167.1571340012633;
 Thu, 17 Oct 2019 12:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <1571272750-29798-1-git-send-email-zhenzhong.duan@oracle.com>
In-Reply-To: <1571272750-29798-1-git-send-email-zhenzhong.duan@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Oct 2019 21:20:01 +0200
Message-ID: <CAJZ5v0h7+53bT4oF109b-ah3wjFNYxz+PNr7DOBQ7rpRKbtGWQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle-haltpoll: make haltpoll aware of 'idle=' override
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 17, 2019 at 2:41 AM Zhenzhong Duan
<zhenzhong.duan@oracle.com> wrote:
>
> Currenly haltpoll isn't aware of the 'idle=' override, the priority is
> 'idle=poll' > haltpoll > 'idle=halt'. When 'idle=poll' is used, cpuidle
> driver is bypassed but current_driver in sys still shows 'haltpoll'.
>
> When 'idle=halt' is used, haltpoll take precedence and make 'idle=halt'
> no effect.
>
> Add a check to not load haltpoll driver if there is 'idle='

OK

> and haltpoll
> is built in. If haltpoll is built as a module, still give a chance for
> admin to use it despite 'idle='.

Why exactly?  Do you have any particular use case in mind?

Otherwise I'd prefer the behavior to be consistent regardless of
whether or not it is a module..
