Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554F11CD774
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 13:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgEKLPr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 07:15:47 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:38859 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgEKLPr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 07:15:47 -0400
Received: by mail-oi1-f180.google.com with SMTP id r66so14738432oie.5
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 04:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bByo2cebBdK6Ej+kmrJVle0wyAQ3TiwRFnpDV6NdMY=;
        b=PiTEM/EalJHj71tVRWgP4NZcKOJU14zCBYpMbZCiS67CnzdSeTuxg0XfWX/lhQoAAX
         n6vkDMAC/0C/faRC/Dstkdbw0wgJHVAPKb+5Iwm1+jNKjl8tq6FYD/eIVt5cE5qqta4P
         PCV7iDxA0JHSXxZjS5k048j7ablgaoU4/O8e0fkw+XDZ+t3VCGNsenxJ1nloXmMhBXSk
         46qY+QT4QI4d9Gt5+rnjDTdbDMj+UALXzXls28Wrt2XDq5Bh23mRh8ofbZoe7q/jN7js
         Hx9Ub3XROo3CGn44AAwibD/tIQArzSG2s/YAoAVb/kodYEo6wyL3e8GCKOa8rELThQiU
         +Vjg==
X-Gm-Message-State: AGi0PubPplEB1sEjxC1fcK1GcYlJQ8/tknsnx+Na0M5WoLHt+bmZCnZQ
        IoxZu6As6KgvmxSGxEQhqQpApeQqiMfnBqspvfMwZnYt
X-Google-Smtp-Source: APiQypLaKwpdCOTsM+BCn9RTWmuEuMSDZBV5XZIkTbUYUSsm1et3txm4L7zB7Aejkis3mDefq+FDORD4lDRaBVLsdqM=
X-Received: by 2002:aca:aa8c:: with SMTP id t134mr19920696oie.103.1589195746631;
 Mon, 11 May 2020 04:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ=1=UFaCvPO99W0t9SWuK5zG4ENKYzq2PgJ36iu-EiiQ@mail.gmail.com>
In-Reply-To: <CAJCQCtQ=1=UFaCvPO99W0t9SWuK5zG4ENKYzq2PgJ36iu-EiiQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 May 2020 13:15:30 +0200
Message-ID: <CAJZ5v0hqODC52Bogeo-2suROH63NmON=5a5K6OZEp1YYMYK_QA@mail.gmail.com>
Subject: Re: 5.7 sleep/wake regression
To:     Chris Murphy <chris@colorremedies.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 11, 2020 at 6:22 AM Chris Murphy <chris@colorremedies.com> wrote:
>
> Got an older Macbook Pro that does suspend to RAM and wake OK with
> 5.6, but starting with git 47acac8cae28, it will not wake up. Instead
> it has a black screen, gets hot, fans go to high, and it turns into a
> hair dryer. So it's a regression.

There is a known issue addressed by this patch:

https://patchwork.kernel.org/patch/11538065/

so can you please try it?
