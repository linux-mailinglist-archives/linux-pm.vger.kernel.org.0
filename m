Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2171714ED
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 11:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgB0K0G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 05:26:06 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34017 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgB0K0G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 05:26:06 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so2800511oig.1;
        Thu, 27 Feb 2020 02:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXNrhQnn6fU6FETSoNq6OA/MgRDG1RJ4qtgoBTgezDc=;
        b=gz8f5hgEc1zayjVXbHU01/XDO7Sd4j7T/urZckWWhVCjf10BKSsz7dOJbu0rKTb8c9
         0ZSE4CqILfmI23I6yOEDac/4axReyO1gRLitJnxki0bHGC/paEbgO80nc+4V+/lPpfeU
         vpQ7ChScIOxGiLqlkS+xLtt2n+ww//OEeJnhNY51qhmQJkzYeW/cknEUMcYCB4g0LMsv
         YWhSBOp5hElayP1+oRN6s0q8WWoZWZA0i2D4dKoJfsUncnFcugoI4aFCk98LA5QZYnBd
         um4TSkdPa5WsqHfzOaZoFoCoBbDP1HSmPh1XNqZc3iAGAtE0ZRvyOr+9cYSvSObw0Lmd
         +RgA==
X-Gm-Message-State: APjAAAUwfJUUNV8On+cPhyMlNicj7gfdlPCHS913q3yG4a5TmSX6lA9A
        9XCqS5s0gDo6oX5q/RmdheVtLg/x6IROlIpzu7cyAA==
X-Google-Smtp-Source: APXvYqxVYq9YmdoFBUYgnwZt6K/DqYgnSkRVd19l0aEbuGCnpmsJNeXxN6aMJ7HqNVCeiO5b77mXU+elvUGy3LUH7nA=
X-Received: by 2002:aca:4d82:: with SMTP id a124mr907319oib.103.1582799165729;
 Thu, 27 Feb 2020 02:26:05 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200227042233epcas1p2541b00baa994f262d07c4dc65da99c1c@epcas1p2.samsung.com>
 <c9cf6c14-2ff7-6809-2bc7-83ca7974c3b7@samsung.com>
In-Reply-To: <c9cf6c14-2ff7-6809-2bc7-83ca7974c3b7@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Feb 2020 11:25:54 +0100
Message-ID: <CAJZ5v0iEpnYG1TZz-kd3cavWU84CGU6Rsk+tsMo5xAh_L1NCPw@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq fixes for v5.6-rc4
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 27, 2020 at 5:22 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-fixes pull request for v5.6-rc4. I add detailed description of
> this pull request on the following tag. Please pull devfreq with following updates.
> And this patch will be applied to stable tree.
> - tag name : devfreq-fixes-for-5.6-rc4
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:
>
>   Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-fixes-for-5.6-rc4
>
> for you to fetch changes up to 66d0e797bf095d407479c89952d42b1d96ef0a7f:
>
>   Revert "PM / devfreq: Modify the device name as devfreq(X) for sysfs" (2020-02-24 11:14:29 +0900)

Pulled, thanks!
