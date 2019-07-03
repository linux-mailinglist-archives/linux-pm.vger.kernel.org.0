Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77C895EDB3
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 22:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfGCUg0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 16:36:26 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34088 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfGCUgW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 16:36:22 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so3803318otk.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2019 13:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPXq+pIJPDQwSLT19cfFmw2Vcvo0FzOgU0YAUNu6RQk=;
        b=wJEJ8tMd3xtbZ2ihovoIGxTsU9YvYQTD507F06G8Qqxby/Sqvh3E1rTKa7dCWbAXsL
         h/isW/5dGZoENf01Ua1CCOvp4kgRYyzqLT7O6zHgJ8l7uoiYTsWdVJ21RHWF19PzlLAR
         9xr3ISuA4c2/xdscQyncXx03C+DMq5YRqIsnH9jeBCTGsOE+ieL9MGoSO8GfuWheduzo
         OQw5O8PpiOM9bedjbV9vjq+7W/dh1hZDoISE5FWjVv2qvKldf5IhSZUYIA0Ab1JM77l2
         6+vk3f1AQPzkm62ZK5lTASVX297bodhM/abR59OSn82RuuK+7lPzRMTZinSktvd1c4EB
         DFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPXq+pIJPDQwSLT19cfFmw2Vcvo0FzOgU0YAUNu6RQk=;
        b=HmH+A4plHghGkjboxPpzNxp3nZicEJ8oMStm4D0I2cvob7VshJJbFsjotNjeNEIJwT
         TobA33qJXsdlFw2ejseYatNvWRk0i5mdAilPtLGdnviIkvW21eLndUtnRs+S+ExwIfSb
         zTg7Ws23g8jLQ1tPnZURJbrvH+pn+/CHYaIK7xhz/TPuKoim10S5oaSUo6/TPyqkdDBH
         vbaRQH3BoPqTBR6jqZkmXL/WTljoG6xf6ax9m0JupMC+zHKwfrdiCQoXZib7EhIYuMCE
         4B8K2EgmJH7Icm6gtt5duKGSooNe9ux1k+hcLe3FBsTR1d6CoKl58k016IGALXgu4Cb7
         ZulQ==
X-Gm-Message-State: APjAAAU6ATlpqBNgQbQB8SGarncBmdssbbNFi/MQdiwmhyNAsEr7RFgw
        z+iiF8DiEXGP8tzUL3NJ5aiCJE+qj+wr+QZrmZQpzA==
X-Google-Smtp-Source: APXvYqy900opobQMpHjkJXGmlkfMTJ/Fz3xLTchhFyxqL4NA93DGafUbOsl0BNsl2aa50mubporMqRqSONHDjBDYRfU=
X-Received: by 2002:a9d:1909:: with SMTP id j9mr14152896ota.139.1562186181028;
 Wed, 03 Jul 2019 13:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703063632.hl2lipcoeehplyxq@vireshk-i7>
In-Reply-To: <20190703063632.hl2lipcoeehplyxq@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 3 Jul 2019 13:35:44 -0700
Message-ID: <CAGETcx9Dhzt9-Ys-8hLtoZ9RYWMWa59H5yismUJDWmJ3Kq-smQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Introduce Bandwidth OPPs for interconnect paths
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        evgreen@chromium.org,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 2, 2019 at 11:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 02-07-19, 18:10, Saravana Kannan wrote:
> > Interconnects and interconnect paths quantify their performance levels in
> > terms of bandwidth and not in terms of frequency. So similar to how we have
> > frequency based OPP tables in DT and in the OPP framework, we need
> > bandwidth OPP table support in the OPP framework and in DT. Since there can
> > be more than one interconnect path used by a device, we also need a way to
> > assign a bandwidth OPP table to an interconnect path.
> >
> > This patch series:
> > - Adds opp-peak-KBps and opp-avg-KBps properties to OPP DT bindings
> > - Adds interconnect-opp-table property to interconnect DT bindings
> > - Adds OPP helper functions for bandwidth OPP tables
> > - Adds icc_get_opp_table() to get the OPP table for an interconnect path
> >
> > So with the DT bindings added in this patch series, the DT for a GPU
> > that does bandwidth voting from GPU to Cache and GPU to DDR would look
> > something like this:
>
> And what changed since V2 ?

Sorry, forgot to put that in. I just dropped a lot of patches that
weren't relevant to the idea of BW OPPs and tying them to
interconnects.

-Saravana
