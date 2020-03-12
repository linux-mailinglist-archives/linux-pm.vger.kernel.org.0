Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE38182710
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 03:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbgCLCfz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 22:35:55 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43821 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387501AbgCLCfz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 22:35:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id p125so4001767oif.10;
        Wed, 11 Mar 2020 19:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8OJZ8s4LAFvvLbr1LYlDu6AvwjLr2eKD3RcnrO+l9+M=;
        b=phTASrbqGplbQZ0J9qq81BbAQWHnb5mliO8intSCodcYFQzfgu384fG0rprHEqkjrg
         P9CvEQK20yLFBtazpyuwL6H2VP1MMluyxgLPAQxGsxq7YXhD85W546FMlNQgInvkJb86
         N3vHrKk2yRhRnMdGgGfqAPsr3bpV3c0Qcw+eCUq/yfGn+XqPY0ekDeeVClETG4tpU5Qj
         m0xsQffi7gybur9azt8O/hd18pqtzkEI4EPkXkJQ6vfn+A2HXu/cqp7AR8Nk2CjD4tlF
         gjJsqTfmjxWBqGIj1bZpnDPZ7Fb1paa880Roh9MEtYBSbqwhQvWgvZqvhhYRyLEz5Kic
         eFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OJZ8s4LAFvvLbr1LYlDu6AvwjLr2eKD3RcnrO+l9+M=;
        b=lD/22FZ769vuP3oEmaw+YSW+AAW6vTo1dlLvYD4emxT6aGYOuqJIzKInvN0YxNljFl
         /7blmbgSeMaM/OtpYdV9l97UiMX5VySfOnQUAYPuijq0711J1BrTERAwnAiCw5TPQFX6
         CUvxlgwqw3zwcEQ6EqOl8DvLZKtDorkzj96YC4/g7U50UE7Onbmp/K9R4AeIk8xh8hlv
         Rj7yKfEtDSNtO1cyjNje8xAafaj48I1LdD5MQ9PKfFBUNq8UV6yvYLTUdhc8Ge5fmgjg
         O/n69bAffGDqotJAn9hcbpwVX02ji2TWx/mOfGI3vobEx7x6tQFDLQYYwBxMGTWTOqyq
         7rzw==
X-Gm-Message-State: ANhLgQ3AmskSfc+1FSgn6xkb34ibpGwkERlzMjqTPT6ZSNxALAjoZtNi
        1kuWUMJ/pCTrgzyKn7/RUyqsxSx6ZLhOXI65L+c=
X-Google-Smtp-Source: ADFU+vv6quOwJyLsYSdx0o07YDwd6saaCjSttFVyiNsWDmrJbcyplKpBgKJleR6+IcKHECFksg2a0LUIUWZbEHXfYkI=
X-Received: by 2002:aca:cc81:: with SMTP id c123mr1089651oig.74.1583980554871;
 Wed, 11 Mar 2020 19:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <5e098be25c70e07c37e743f84a901f6f756090e0.1583461755.git.baolin.wang7@gmail.com>
 <20200306204712.dgomi52jzyakylky@earth.universe> <CADBw62owL-G_B7pU87sH2U+0vCNEG9rkMRpHZXL5_9YZcvQfxg@mail.gmail.com>
 <20200311221856.yh2vr3fybwm3krfc@jupiter.universe>
In-Reply-To: <20200311221856.yh2vr3fybwm3krfc@jupiter.universe>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 12 Mar 2020 10:35:38 +0800
Message-ID: <CADBw62pMPrNoTXsfN0Mzs2Vo=ORQLzeabn6bSW2CG_JfE7cebQ@mail.gmail.com>
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

On Thu, Mar 12, 2020 at 6:18 AM Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> On Mon, Mar 09, 2020 at 11:20:41AM +0800, Baolin Wang wrote:
> > On Sat, Mar 7, 2020 at 4:47 AM Sebastian Reichel <sre@kernel.org> wrote:
> > > On Fri, Mar 06, 2020 at 10:34:10AM +0800, Baolin Wang wrote:
> > > > Allow charger manager can be built as a module like other charger
> > > > drivers.
> > > >
> > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > > ---
> > >
> > > Thanks, queued. I do not like this driver, but its the best we have
> > > at the moment.
> >
> > Thanks. I understood your concern, do you have any plan to re-design
> > the charger manager driver in kernel? Or do you have some thoughts
> > about re-designing it? Now we have some out of tree code to use the
> > old charger manger, and we'd like to change to the new charger manger
> > driver and upstream them.
>
> I don't have anything ready yet and not enough time unfortunately.
> The proper way would be to have something equivialent to charger-manager
> in the power-supply core. The core should be able to monitor batteries
> and handle connected chargers automatically.  Also there shouldn't be
> any DT entry for the software managing the charger, since DT is about
> hardware.

OK. We'll think about it according to your suggestion. Thanks.

-- 
Baolin Wang
