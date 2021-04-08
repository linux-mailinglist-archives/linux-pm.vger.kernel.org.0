Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420FE358BA5
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 19:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhDHRqq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 13:46:46 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40679 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbhDHRqp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 13:46:45 -0400
Received: by mail-ot1-f54.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so3106784otb.7
        for <linux-pm@vger.kernel.org>; Thu, 08 Apr 2021 10:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTCBRmOLqDAuijz6uV4nFyFyChmpqyz+Aj5wR4QJLN8=;
        b=ZulDEa2PYlsQcouYx4l0Y/kSf6SLsfsNSnxhAsRJv60pIfSUAYz/Y7s4LeQIyMKlew
         fz/CK4wReMTLdLFF+SUNOPU0vCrAim84P3Nd/XMP7pL07i4enbHVJ6KZGPzF++aYQFZs
         OS7XCVUwQxqhN7fBY/XFV8v864wHqFxS+XO7Mvjx8v9hQfUChpo58bbXOGgWU6M6rfMs
         Ys+SCwzzKzQS/OiOwat+J+OTspB+0GEbCEE4K6NLAIO6xaGISJS3RHVWWqtFzGs71X8a
         uPr7LTGXPMeYewm8mEKOFbIyM/sGcv/gmyCs9EtUZMUTwMiNXPqSX4E9/GnTsXwJJ1y0
         nazA==
X-Gm-Message-State: AOAM530CO4uyXulmE2MXmqmXDWaTSacWhHROOdrkPIHg4PFn5yXfE2Qm
        +BJ8GdSUqfC5GJqJo8MVNAJH8DlfThrlBtDBmqo=
X-Google-Smtp-Source: ABdhPJyUY5IWd78GsVI9d7HyZPM7azneItGG7jD3HCcUh3tZxBzgdk8WyB9VITOMN92IGp6Uus4TBrDBI8S88fbwlr4=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr8899721otr.321.1617903994233;
 Thu, 08 Apr 2021 10:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210408152209.GA1299604@rowland.harvard.edu> <CAJZ5v0jjhF=Xpk_WrAFXkcCh44tnqdy16uBxrPLsRcWO6VX3Ow@mail.gmail.com>
 <20210408161210.GB1299815@rowland.harvard.edu>
In-Reply-To: <20210408161210.GB1299815@rowland.harvard.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 19:46:23 +0200
Message-ID: <CAJZ5v0hERQVM9QMEQT8Zs9ummKBRncg2SiA_tzGQxafNTsGisw@mail.gmail.com>
Subject: Re: [PATCH] PM: Add documentation for pm_runtime_resume_and_get()
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Linux-PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 8, 2021 at 6:12 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, Apr 08, 2021 at 06:00:27PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Apr 8, 2021 at 5:22 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > Commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
> > > deal with usage counter") added a new runtime-PM API function without
> > > adding any documentation for it.
> >
> > Well, there is a kerneldoc comment which counts as documentation, so
> > I'd rather say "without updating the documentation in runtime_pm.rst".
>
> Okay, that's a good point.  Feel free to make this change.

So applied with this change made (as 5.13 material), thanks!
