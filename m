Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106381DD118
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 17:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgEUPWV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 11:22:21 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33521 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgEUPWU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 11:22:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id v17so5830848ote.0;
        Thu, 21 May 2020 08:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uw/ECKoYgz/YxRjuJpnhpsZS31S0r5IQsD1sVVnFwsk=;
        b=aATRAxRprz6cP3SJWzCbj6vv5f5/aWhXdwGGlhXlq41jqU+FEmgtxviTj6MR0imbUV
         xoN5Ov1RqrzIA7Ea2vpshUsoqshXANhmL0SOUHZ0Sidpbe96vRv6/NHgumz0Q/0R02OF
         mzBlpdj4cuxASDz2NSxAm96UqU/unyXNYi1ouc42Io5haqPWynj4NZm6EktEDa+h3YqA
         KMQruSltnEGwl2+e0FpyW+FOD+wNPu4m6no68c3QyaUJPvU1NWX30suephwnlv8Q+0Z7
         tP8Hd+WY7DRyrB1BB8USJdd0mVsQaRsMkeQ5yjH0e30mh0OyUs7oHL74eH0sotUg+/ny
         lSDw==
X-Gm-Message-State: AOAM532fZAGLkPY3QrV2yAdX2sIMobqqJg1CLoPRuIIa3gL+xUGfX4dB
        R77Bv2j4lownfYVjYMvDiHdkdYvyRTh9iqU9CqQ=
X-Google-Smtp-Source: ABdhPJySYHHfJZQzmSAFX4YreFFQLn9SDcqp+e2Kz8pIAQ/fKPfh6o6bUIqNhlRZ/GFZaNjXxDQc9ZETXw93O7R/z84=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr7537138otc.262.1590074539694;
 Thu, 21 May 2020 08:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200520095148.10995-1-dinghao.liu@zju.edu.cn>
 <2b5d64f5-825f-c081-5d03-02655c2d9491@gmail.com> <20200520150230.GC30374@kadam>
 <2a46539d.b977f.1723553aa81.Coremail.dinghao.liu@zju.edu.cn> <20200521091505.GF30374@kadam>
In-Reply-To: <20200521091505.GF30374@kadam>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 May 2020 17:22:05 +0200
Message-ID: <CAJZ5v0irLayBUPRWNT1tcZivz9inS1YbUgGj5WXvucLKKwRQAw@mail.gmail.com>
Subject: Re: Re: [PATCH] media: staging: tegra-vde: fix runtime pm imbalance
 on error
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     dinghao.liu@zju.edu.cn, devel@driverdev.osuosl.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>, Kangjie Lu <kjlu@umn.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 21, 2020 at 11:15 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, May 21, 2020 at 11:42:55AM +0800, dinghao.liu@zju.edu.cn wrote:
> > Hi, Dan,
> >
> > I agree the best solution is to fix __pm_runtime_resume(). But there are also
> > many cases that assume pm_runtime_get_sync() will change PM usage
> > counter on error. According to my static analysis results, the number of these
> > "right" cases are larger. Adjusting __pm_runtime_resume() directly will introduce
> > more new bugs. Therefore I think we should resolve the "bug" cases individually.
> >
>
> That's why I was saying that we may need to introduce a new replacement
> function for pm_runtime_get_sync() that works as expected.
>
> There is no reason why we have to live with the old behavior.

What exactly do you mean by "the old behavior"?
