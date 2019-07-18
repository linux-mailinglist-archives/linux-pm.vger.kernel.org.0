Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40B3E6CA23
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 09:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfGRHmO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 03:42:14 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40970 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfGRHmN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 03:42:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id v22so19660078qkj.8
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nzmwtsx5tycGhb+4LFPxCL+N+c9XhlGZm/gifhTU4EI=;
        b=CEmXIqx1zEiZseyaLHbAZg2eYr52IGrxCiYtf3WdbIdRfxNALuaF360H38na2HHGeT
         kJhvHRHwPkvdmaSFb4Ut1bXNNSwq+Az21CQwDcXz/2aJYfDrZA8FLv0Whf7jcqWPgUP7
         cxDS052qMR+IQox9Kk3hORyh7saHwYg+y7qKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nzmwtsx5tycGhb+4LFPxCL+N+c9XhlGZm/gifhTU4EI=;
        b=GNvoJeblM2Fgc/OH5ej6hmALiTldEH3GDk9M4znm8xBt7zSnNBDjVrEF0tFuEbSktq
         Vgx6s7iiSrwbtA5PEnxxXiNyk+INUnKA651+lshTP+elEXjqUThOwPdBXb+NRiCwklXB
         gwADMmUVNpBqgr8PJnPbauUhpntzKShJVsqtDjQbRXQZmyOg3R8cimqoI3xzmyOd8v3+
         pju/xepBoe6OJlOblSoEbwATnARccHJiXJzQPMFGRcex5xee6AT7+rWN9QBbFS3yTaYF
         XClAYG622L6XEkCTka7by1PrjHVvHZnlI3Vr+wzl1+9mnqywaeMnzd3Demlst8QJHihD
         EPNg==
X-Gm-Message-State: APjAAAUXROGepshmjJgf3RlOsket+1as+GcpOveLn8QsXW20eHjJzlRs
        6T+4EvW/bJHkMbCOIV2l11KSfCrQG/cB8rBkbgKr+Q==
X-Google-Smtp-Source: APXvYqyaijtootjYh8DupgYeIQoCu/S4vDUdZBI2rD3C+dIP7BgMxJuxlurbcYyMNzYZGK8otJ+FaVyHPZ59zlJBHRk=
X-Received: by 2002:a37:a603:: with SMTP id p3mr30398001qke.297.1563435732883;
 Thu, 18 Jul 2019 00:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190717061124.453-1-hsinyi@chromium.org>
In-Reply-To: <20190717061124.453-1-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 18 Jul 2019 15:41:47 +0800
Message-ID: <CAJMQK-ga16BekNgZqDm2Bz4xw6O6Jt0Zaw3vcUhrvh6s570WOQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/2] Use cpu based scaling passive governor for
 MT8183 CCI
To:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     "MyungJoo Ham )" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 17, 2019 at 2:12 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> 2. cpu based scaling support to passive_governor from Sibi Sankar
> https://lore.kernel.org/patchwork/patch/1101049/
This series is tested with previous version:
https://patchwork.kernel.org/patch/10875195/
