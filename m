Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3212611687B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 09:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfLIIoS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 03:44:18 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35179 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfLIIoS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 03:44:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id o9so11506977ote.2;
        Mon, 09 Dec 2019 00:44:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0jcGNVDZdjVOcFf7U5lfAmPR1zFVD6MTPuQZE2xEcE=;
        b=HNJ3D8YuQVuEIxDq9xeijwPiOCcO7/8CPkNxp6FmP1p04bVURJPkkk7es+SyHCmB7G
         aP25r3rA1LILbDATT4vnKQ/RodfZS6Z0IKI9lZlJUC7o9x0m+3JuYJ97o96kIwdWABmk
         n0uV9vVnsaucYDxCyb1xdLzbBWNZIteDu9ZsHPmhbvAuiziS1ndPsI+RoAzsZPPHQyNZ
         UB4jCno60tO7mZvOMY9nrhyOSH5tfiVcshIldX5PvM7XVIAf22lEaVBAVGBHnXdaVOUc
         j4vqg51j77LFetGcAxGV6/sLMVDMLNpQGg2+XKE1eSv7ACAYl5hQcsZ/DJcn7UO4cTDE
         e9qw==
X-Gm-Message-State: APjAAAWwk1KsVzp+7Ur+EL0ne5F//da7n40ygzW8cXe9amAq6kSiSuIj
        5wF3j25fapem0uEQWhxPNkaBOcrF01gunyzkoZY=
X-Google-Smtp-Source: APXvYqw3e7bqrtKZjCExTB/wvF/XmbS6xv1meaecTz1g79OjC4gLerzStkCD7JZ0/DUNY5Qbd/Fpc76z7jw/D/argko=
X-Received: by 2002:a05:6830:18cd:: with SMTP id v13mr19601980ote.118.1575881057288;
 Mon, 09 Dec 2019 00:44:17 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191209065107epcas1p4eaa96dffa943add96359b15cbd4d3b62@epcas1p4.samsung.com>
 <f2f33725-5a73-0553-ef8a-52b192b80cfb@samsung.com>
In-Reply-To: <f2f33725-5a73-0553-ef8a-52b192b80cfb@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Dec 2019 09:44:02 +0100
Message-ID: <CAJZ5v0i0HJp-P+q-fMPsFdxTrc=Qo8Ckp16_8S=QHw2_=0+MYg@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq fixes for v5.5-rc2
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 9, 2019 at 7:51 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-fixes pull request for v5.5-rc2. I add detailed description of
> this pull request on the following tag. Please pull devfreq with following updates.
> - tag name : devfreq-fixes-for-5.5-rc2

Pulled and pushed out (as 5.5 candidate material), thank you!

> The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
>
>   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-fixes-for-5.5-rc2
>
> for you to fetch changes up to 27dbc542f651ed09de910f274b32634904103774:
>
>   PM / devfreq: Use PM QoS for sysfs min/max_freq (2019-12-09 12:19:16 +0900)
>
> ----------------------------------------------------------------
>
> Update devfreq for 5.5-rc2
>
> Detailed description for this pull request:
> 1. Update devfreq core
> - Add PM QoS support for devfreq device with following QoS type. External user
> of devfreq device can request the minimum and maximum frequency according to
> their multiple requirements.
> : DEV_PM_QOS_MIN_FREQUENCY is used for requesting the minimum device frequency.
> : DEV_PM_QOS_MAX_FREQUENCY is used for requesting the maximum device frequency.
>
> - Use PM QoS interface when entering the min/max_freq via sysfs interface.
>
> - Add get_freq_range() helper function in order to get the final min/max
> frequency among the multiple requirements of min/max frequency.
>
> - Fix the issue such as fixing the return value and modify code
> for more correct exception handling if error happen.
>
> ----------------------------------------------------------------
>
> Leonard Crestez (6):
>       PM / devfreq: Fix devfreq_notifier_call returning errno
>       PM / devfreq: Set scaling_max_freq to max on OPP notifier error
>       PM / devfreq: Introduce get_freq_range helper
>       PM / devfreq: Don't fail devfreq_dev_release if not in list
>       PM / devfreq: Add PM QoS support
>       PM / devfreq: Use PM QoS for sysfs min/max_freq
>
>  drivers/devfreq/devfreq.c | 273 ++++++++++++++++++++++++++++++++++------------
>  include/linux/devfreq.h   |  14 ++-
>  2 files changed, 212 insertions(+), 75 deletions(-)
