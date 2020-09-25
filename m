Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D39278B0C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 16:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgIYOil (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 10:38:41 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:34059 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgIYOil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 10:38:41 -0400
Received: by mail-ot1-f43.google.com with SMTP id h17so2518808otr.1;
        Fri, 25 Sep 2020 07:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5liefUfQCMNWakXF6yVHEEkkUR6lSK3XVQ4kT9Vtek=;
        b=D83xCjfDyjdqR3i54wPf9synv1UQZw3U5Mti0zCwOlqOvK6v40puW3IgoAdJE5hs/E
         kKcUN2FSpEqATRwMPOvO4SkautSjw769bnKhxynkPMHeGmi5/wy1VHVcDegC2Dd9NY4y
         /gg2hJs6lh2JevJ8yhoAZxjM76I0jdbBYdEXWM/u9wQQUo297PqxAfXsQWApz3d1X5e4
         PuFrquXwjRx/WJWQRgA5F7qWtZhonrEZmgOn92aMIU43KG8a8v8+Y6I5Vo1qBDMFDvoC
         iXIaR/VNyWRExab+OnVYzeRd5mLn5X7qi1lqOBWZE7cTcyX79b8Cf6zwNSD79IfANDoi
         YTeQ==
X-Gm-Message-State: AOAM5333Q162izAnoJSrtnoUxJPsF4Xb2PGHDOKCMnnPB4ITLmQkPPrR
        sgPGOW+81IqHTEC0Jhx/0MS5ObX6hldniRVt2ME=
X-Google-Smtp-Source: ABdhPJxJoBPhRCO5Az1qgfr6T3bpAKUp+NsK4e36mmqnAgCidtTNxF/lhuz7uzWmE5ZhWX+WkNZhI2GQXNtyqljXEP4=
X-Received: by 2002:a9d:718a:: with SMTP id o10mr524441otj.262.1601044720262;
 Fri, 25 Sep 2020 07:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200924100342epcas1p42ad5d9bf5f2316f8c9e3909dfaa49a75@epcas1p4.samsung.com>
 <2dc9eeae-159e-c886-0278-f3c85d20bab5@samsung.com>
In-Reply-To: <2dc9eeae-159e-c886-0278-f3c85d20bab5@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 16:38:29 +0200
Message-ID: <CAJZ5v0h3yLJjaxshWUdYAzGW2RhjWqeKv+iEumKQyOs16pc2oQ@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq fixes for v5.9-rc7
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 24, 2020 at 12:03 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v5.9-rc7. I add detailed description of
> this pull request on the following tag. Please pull devfreq with following updates.
> - tag name : devfreq-fixes-for-5.9-rc7

Pulled, thanks!

I would appreciate receiving pull requests a bit earlier before the
target -rc, though.

Cheers!
