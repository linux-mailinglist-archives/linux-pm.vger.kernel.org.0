Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE9C23375F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 19:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgG3RIH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 13:08:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38717 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgG3RIH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 13:08:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id u63so12575752oie.5;
        Thu, 30 Jul 2020 10:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OONDieM5UAEMzdZ6NsbtNQbk4h1/Xc0big1pg7G9+Io=;
        b=WAlpnbAim42JumR6ZfIsld0KRE1UDohiiZciZGHhYxgFKQHU4kUyHEZT5eEobteFNy
         ES4gF9FdvEa5ACQ+nIxeRy+K40sT8DqGAEg8lcbHbFmEWziPiRoA6XD1Y5lfPpmOD+Sd
         K7rAq83DEZmDtkfLeIag2e732v1n4N2c5sv6seMxSKh/XgqtLcpLjYrPGzKr470eim6L
         bD3SWPgkmvVDS8RaIaRf8Z5VQhhcs7BwgVAcu9P984rYuqQT9B9YsqvAguIFjYJENpeC
         bxRvuMK6Pd9izd8zFI7LHE3LL6cXVLJg19MoCl4rjlOvxABb4sz23k5BR3CA4+AInj3k
         5vVA==
X-Gm-Message-State: AOAM530Pk/F2Ux8q7wrbIRPbfCn8wHugq8n0LwLCLRtUYoBacxkRDCWQ
        aVZbp1+zf6w68CprXIEPHArDn5QORbdsq+IffhE=
X-Google-Smtp-Source: ABdhPJw7bRB6RXcm6+DMUkT3ZlIDc0J2xWUJ7BneAXIrmwMIAAfS3xjVuRHApdKHxR+JYDfmY71V/j7DMEQgqNhBrrk=
X-Received: by 2002:aca:110a:: with SMTP id 10mr1363938oir.68.1596128885963;
 Thu, 30 Jul 2020 10:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200730084154epcas1p478b744a64f99618541818c1977c88fc9@epcas1p4.samsung.com>
 <6bf6b502-44ef-ea50-27f6-235a8ce96c1d@samsung.com>
In-Reply-To: <6bf6b502-44ef-ea50-27f6-235a8ce96c1d@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Jul 2020 19:07:54 +0200
Message-ID: <CAJZ5v0i4cWk5Nt0YsQKmQSuVkKq-3Jc+f_h8r8cmvN6fwgtn_Q@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for v5.9
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?64KY7ISx6rWt?= <sungguk.na@samsung.com>,
        =?UTF-8?B?6rmA7Iq57Jqw?= <sw0312.kim@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On Thu, Jul 30, 2020 at 10:42 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v5.9-rc1. I add detailed description of
> this pull request on the following tag. Please pull devfreq with following updates.
> - tag name : devfreq-next-for-5.9
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit 92ed301919932f777713b9172e525674157e983d:
>
>   Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.9
>
> for you to fetch changes up to 27a69714450f5c9288cec2b20f1ae4f7ad34dacf:
>
>   PM / devfreq: Fix the wrong end with semicolon (2020-07-30 17:22:58 +0900)

Pulled, thanks!
