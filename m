Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B8F10A457
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 20:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfKZTKF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 14:10:05 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:45591 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfKZTKF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 14:10:05 -0500
Received: by mail-oi1-f169.google.com with SMTP id 14so17648420oir.12
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2019 11:10:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNw4A8s2wPJFQUeAT7Uw16TKtiwtBI/7q/FZKBk5STQ=;
        b=bdhoh3sDu0Y8kLdB3ahU/OcbmCZ0jxdeHV4y6j+uO1zxZetPVH1so1MZkeRwg4TBWe
         /PPlDLmJwOQAQUu8n8M2YLLjmMwUH7nbApGM8PU1zWSl7Y1fMPvHk/E+t7UN8xOFuMyL
         /eGhbVpRByGPvjQgF4hvb2C5jkbLPvOQEGlku2XdOMaEl3Tr9KczM+p9MtVzRc88XhOX
         zESIshOHDy2RrcaW2/SFMPmOivMKJOpBaW2dbCS8/eIqufRNl+YKyCozINKmxQOBO9qv
         8tA6y7vyNXnyl70sqAHDWGTaesufJ8R0rmRlc6WyV+zt/ysu12asjnm3u0vNFQ/hGDxN
         rdDQ==
X-Gm-Message-State: APjAAAXbR0sWM7w2M5vzRcGaSIHkhnRqKwyPYjmhM8B8r4DjqrIB1y9b
        hygaftjkMrt1L9EBnCrQ7Uzkj/My5ys2+o6JAOA=
X-Google-Smtp-Source: APXvYqwkLVPccBiIbwD9GY951gRqLxkIB2ncPC01P7eS0y0zHnObyHrgiEqnaIp6xpeCp+A40OswZUSZH6tCmmxX+UQ=
X-Received: by 2002:aca:cd92:: with SMTP id d140mr492528oig.68.1574795404586;
 Tue, 26 Nov 2019 11:10:04 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0iJevs95=wpZF8iprXqs2R6H=T-FHfbFwGsQqcBe=Wk5w@mail.gmail.com>
 <alpine.DEB.2.21.1911260833250.2714@hp-x360n> <12933162.9b7K5rSXZx@kreacher> <alpine.DEB.2.21.1911261102180.2714@hp-x360n>
In-Reply-To: <alpine.DEB.2.21.1911261102180.2714@hp-x360n>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Nov 2019 20:09:53 +0100
Message-ID: <CAJZ5v0jOmhe74rMLcMMNqtWZNuxrLPvjMsnQ3ka299VNbcSRtg@mail.gmail.com>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep:
 Simplify suspend-to-idle control flow)
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 26, 2019 at 8:03 PM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> On Tue, 26 Nov 2019, Rafael J. Wysocki wrote:
>
> > I've just realized that it is not necessary to use acpi_ec_query_flushed() in
> > acpi_ec_flush_work() at all, because it calls flush_scheduled_work() anyway,
> > so the appended patch should be good to go.
> ...
> > Can you try it, please?
>
> IFFFF this current fingers-crossed build fails I certainly shall.

Well, it would be useful to try it anyway.

In any case, I'm going to go ahead and post the EC part of it as a
proper patch and integrate it.
