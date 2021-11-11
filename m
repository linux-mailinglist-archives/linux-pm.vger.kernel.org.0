Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0612A44DAF6
	for <lists+linux-pm@lfdr.de>; Thu, 11 Nov 2021 18:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhKKRKG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Nov 2021 12:10:06 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37455 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKKRKG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Nov 2021 12:10:06 -0500
Received: by mail-ot1-f45.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so8972106otg.4
        for <linux-pm@vger.kernel.org>; Thu, 11 Nov 2021 09:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpdNVxSOK4e9mew952lGnYtXN0rtbGDg38h4wdSISA8=;
        b=nzElFpmTKXCV2nQvjRsWGcg9X/WUluMulvmhDxR3tcul7EMmctaLssZPa6mupkLEy0
         p6AIAc+c3ztHdxi4QYf0hFKBRFe2TeiIlrzMU0LVRMYCoZb315NFy5wJ3Jx18M7i/n5L
         rC+sVc+T793tkkp9HaFGi4VDQfutQoOKyuUy/u1qUifZa8JmPKlnlMNahZMH5niAF6LG
         IfSHHv9nZBixT8xOvg390eNX7Ojsop3M7IIqLUCykiA+FNHaofKd+N3p/Cj3nUFD9agL
         OYdrCnbIMvLEChKqlS3tjZnoM2aew098cNfL4mfMUPeelB32zjEFeV62UZWwPzCD4BFw
         vIUA==
X-Gm-Message-State: AOAM531H3kmxVLq6M8AUmB5R068zmEHxkz82ZHEt1mDbD0T5xDynFR/c
        2aNSUbxY0QQOKwRPK/8eLAXHtCqVgecesIFChzDbeTYO
X-Google-Smtp-Source: ABdhPJyK3pUdrOK/tTGEnmjZNHH+GmoZ9c+O0Rkr7/3wbn5KOWpzTuWEBpwYzbcUgLrc455z7epe+yLtZjDO6GUex1M=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr7124925otu.254.1636650437073;
 Thu, 11 Nov 2021 09:07:17 -0800 (PST)
MIME-Version: 1.0
References: <1635766618-24732-1-git-send-email-youquan.song@intel.com>
 <CAJZ5v0jJ+tthguYtq81EbapZAxLkUkz=B=quDWcMzHQFcWAnrA@mail.gmail.com>
 <BYAPR11MB3205164D85635F784AFA4C429C939@BYAPR11MB3205.namprd11.prod.outlook.com>
 <20211110105833.GA30301@linux-youquan.bj.intel.com> <2d01125c-facd-6db6-23d3-b0b1b608c4e8@intel.com>
 <20211111042807.GA887@linux-youquan.bj.intel.com>
In-Reply-To: <20211111042807.GA887@linux-youquan.bj.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 11 Nov 2021 18:07:05 +0100
Message-ID: <CAJZ5v0gQZQwbA_mghmUCHOCUgWfYUMD2CeqceRhO7TvEQtAfgA@mail.gmail.com>
Subject: Re: [PATCH] PM/QoS: resume latency 0 should be not latency allowed
To:     Youquan Song <youquan.song@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Youquan Song <youquan.song@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 11, 2021 at 6:40 AM Youquan Song
<youquan.song@linux.intel.com> wrote:
>
> On Wed, Nov 10, 2021 at 08:24:12PM +0100, Rafael J. Wysocki wrote:
> > On 11/10/2021 11:58 AM, Youquan Song wrote:
> > >>But do you really need to make these changes?  What problem is there with using the interface as currently documented, ie. writing "n/a" to it to get "no latency at all"?
> > >I think so. "0" is "latency is not allowed", but "n/a" is "no latency".
> > >
> > Actually, "0" means "I don't care" and "n/a" means "no latency"
> > which means latency tolerance == 0.
> So it is not reasonable and need change.

Why isn't it?

It may not be intuitive, but it doesn't imply "unreasonable".

> "0" is the smallest latency and means "latency not allowed";

Not in this interface.  The documentation is very clear in that respect.

> if latency_req==0, it will not allow to enter into C-state. "n/a" is largest latency and means "I don't care" the input of latency_req at all.

I'm afraid that the existing interface cannot be changed without
introducing regressions for some users.

Please use it as documented or demonstrate to me why it cannot be used
as documented.
