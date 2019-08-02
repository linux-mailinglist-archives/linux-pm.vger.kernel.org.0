Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278B67EE8E
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 10:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390750AbfHBIPC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Aug 2019 04:15:02 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:45525 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfHBIPC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2019 04:15:02 -0400
Received: by mail-oi1-f179.google.com with SMTP id m206so56225184oib.12;
        Fri, 02 Aug 2019 01:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8CXPr54lctTpT9n1ymDOLbViWrnvnZDLFZP+N9mvLA=;
        b=YA0ERajjGLChv5+nlwq9xDAgn/rdfw7QXmuf2wpAqgM57XNBZNetHjHSHdReQbrueq
         uczoOJBt5GoalOajVr/tW5uhuD7ULcRo2Y8nIu7pWZMKeDBMlKqCx9D3N+MS5Rtn4oDi
         6N0iA9ADS7mptkywtBYco6Ws3cyvIeypaMWwjWsOpR6FWhAifWFEiB6CJ/85jsJm5Vux
         vRuRUPm38o2JPnXzLjcJA2YRYgIlbX+79nYOvomqEL+EN3C1Bzsqofu6QBWv2bO6ru9V
         K3vzZ+63nMVyx3mM/9d7Ry4Jpc2PU7Y+GJFBpD4vY/Rl4vQr1Mm9ByO4qPwQ4EZEhvTG
         VlXg==
X-Gm-Message-State: APjAAAXr+vnIrhvxg2SoYUt6CZwvBHjIg3jzEwGaE3SMABwF1HzRvGs1
        s6E7zgx5UXDFS8PoWRJQ76zLEKNs8+Q5QvudY3LBaw==
X-Google-Smtp-Source: APXvYqzclE9UPKLLLbJdm4/GbD3vCIgZP4Wrn5033xqe67VnfM4owdkHeOH80ccBCIVIyuhV/i+hgq+x3txRtrd6WFY=
X-Received: by 2002:aca:4e89:: with SMTP id c131mr2019124oib.57.1564733700646;
 Fri, 02 Aug 2019 01:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hrpO_PRos3=JnLQ0ZbuBX1vdR8j2jx3je5+Y2m=Dwk2A@mail.gmail.com>
In-Reply-To: <CAJZ5v0hrpO_PRos3=JnLQ0ZbuBX1vdR8j2jx3je5+Y2m=Dwk2A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Aug 2019 10:14:48 +0200
Message-ID: <CAJZ5v0g5ywC0tz-35z_NektV3xfqFXq6Ckhppn30zQrtkDb7EA@mail.gmail.com>
Subject: Re: [LPC 2019] Power Management and Thermal Control MC: Call for topics
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 17, 2019 at 12:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Hi All,
>
> Now that the PM+Thermal MC has been officially announced
>
> https://linuxplumbersconf.org/event/4/page/34-accepted-microconferences#pm-tc
>
> everyone interested in the problem space in question and having a
> topic for discussion is kindly requested to submit a topic proposal
> for that MC via the LPC web site:
>
> https://linuxplumbersconf.org/event/4/abstracts/
>
> To do that (after following the link above):
>
> 1. "Press" the "Submit new proposal" button.
> 2. Log in to the LPC CFP system (* see below in case you don't want to
> create an account).
> 3. Put a one line title of your topic into the "Title" field.
> 4. Put your abstract into the "Content" field (please keep the
> abstracts concise).
> 5. Add yourself as the author (there may be multiple authors, in which
> case add all of them).
> 6. In the "Comments" field say how much time the topic is expected to take.
> 7. Choose "Power Management and Thermal Control MC topic" in the
> "Track" selection.
> 8. Answer "Yes" to the anti-harassment policy compliance confirmation.
> 9. "Press" the "Submit" button.
>
> * In case you don't have an account in the LPC web site and you don't
> want to create one, you can send the topic title and abstract to me,
> and I will put the proposal into the LPC CFP system for you. Still,
> please do consider adding an LPC account and following the steps above
> yourself.
>
> Please note that the most relevant topics are those aimed at solving
> specific problems in the Linux "plumbing" area: the kernel, libraries,
> system management tools etc.

This is a reminder for everyone possibly interested that today is the
last day to submit MC topics for LPC 2019.

Thanks,
Rafael
