Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4900217D841
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 04:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgCIDUy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Mar 2020 23:20:54 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41497 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgCIDUy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Mar 2020 23:20:54 -0400
Received: by mail-qv1-f68.google.com with SMTP id s15so3734681qvn.8;
        Sun, 08 Mar 2020 20:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3z+/ShsiL7nlqYnENb1XAVXEchprEjWk3+VW1W/e/ko=;
        b=nYASToVe8kuAbflDDY7FoWCWNG5pIZit55VlLjAOluo+AUhN5vV178BT6F72ZdMcNR
         F9586M22WrlY+/IE6LBiBkHplQnD58K4SHr/0R7KMXJCFHFNfGByEoFUWDcZl8H/suf2
         wxMu1q1IQEp9W7+jGuKfCDCZZdFIBcI9fn6qNE3zqAOACCGjVaPl9xaHGwvdQbbYqi6Q
         w7jc1w3se27wBp1aOPjh0UEVWxtImvGID+9E/4xBycoqnpvG3wZxlOxQi/Sd1O3P+KtP
         RYKKg90ivYbnVTUC/8C8oUcyu99ZzwTRxZAeXqNy3pbQyC9NzNRJCW3E2Z6L4+5uXG71
         tTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3z+/ShsiL7nlqYnENb1XAVXEchprEjWk3+VW1W/e/ko=;
        b=eOT0yLka64SDfVYaqHEe25QZZOP3gCT/0wcSvDZzSdsJL8NkFLsLnIm6m6hjHWEY8J
         Cqrkesx+HIgOuHxA9gPI+74BqeqQ8a9/SVXEt638kqLWWlKEh49GvgZb5ImjGy/tj6FD
         xcGrP+t5HMev+y5sffoLg2laxKxPoZkutWeL80k8xeZb1FrkTc/sDnj+xVfoFRD6hNkF
         6bh0vv1FoOuS7Uuuapil4Ka+bXX2rRSR8HpyZxOKlqvyBA0xZ3hLK9EeGvJRjuhwS/N2
         o5OI5A5GNQBHplt3cj+bTe0IdeMh7aFjo4KsXAHKlBxvzryEEevPawcOC0F6ZMCe+wMk
         zpRA==
X-Gm-Message-State: ANhLgQ3wWL1MTh9+DveL7uW/WWIDFpf7j9FN5D1T64PBwnbDZYirGD5J
        62XY68pvSfRcEXnEqJDcvE82U6wbepsC+TeTXEVFSQ==
X-Google-Smtp-Source: ADFU+vvPnPJtWjGOupyrIxJlXmPGxbTe0E6hUS6GR8Ych8dvr9UMCtAKlUjtY1OUuKl6m4TzlQJVpNcnJd3xkPMiKr8=
X-Received: by 2002:ad4:4e88:: with SMTP id dy8mr13140314qvb.118.1583724052805;
 Sun, 08 Mar 2020 20:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <5e098be25c70e07c37e743f84a901f6f756090e0.1583461755.git.baolin.wang7@gmail.com>
 <20200306204712.dgomi52jzyakylky@earth.universe>
In-Reply-To: <20200306204712.dgomi52jzyakylky@earth.universe>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 9 Mar 2020 11:20:41 +0800
Message-ID: <CADBw62owL-G_B7pU87sH2U+0vCNEG9rkMRpHZXL5_9YZcvQfxg@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply: Allow charger manager can be built as a module
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On Sat, Mar 7, 2020 at 4:47 AM Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> On Fri, Mar 06, 2020 at 10:34:10AM +0800, Baolin Wang wrote:
> > Allow charger manager can be built as a module like other charger
> > drivers.
> >
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > ---
>
> Thanks, queued. I do not like this driver, but its the best we have
> at the moment.

Thanks. I understood your concern, do you have any plan to re-design
the charger manager driver in kernel? Or do you have some thoughts
about re-designing it? Now we have some out of tree code to use the
old charger manger, and we'd like to change to the new charger manger
driver and upstream them.

-- 
Baolin Wang
