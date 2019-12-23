Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C0312927B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 08:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfLWHsP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 02:48:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43475 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfLWHsP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2019 02:48:15 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so12034944qtj.10;
        Sun, 22 Dec 2019 23:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FJiERJq8seSOSllZH5YEQwwR1oj81w19nx1TE+EiOU=;
        b=DLtTzH9MNQBe0QaZgTDVJi1ZZHB9hfP3crI9OK2Y0wAG9ltJOO/KTTAH+Ers5VFoWc
         vCsPz/gxO1GKNLyLLT2INRzujN8gbcoLHi794Klpqqhrf5aUh9kCQY61m0q5FOMv7pWL
         4vliKQtnC+QVtiSFA7lZB7mraLCi3TbUVbumJioSAWZ7wrBAgfD51yFr+0OHd3dwjbM/
         DZ4+tTzwy+z3BJpGVwgr1o64tavDOeMuBwh2ciffMRDfutiy0CKnH+ZVPvj88ySgYG+d
         RZNZDrRjJoo/WcNQcEakrBYwN8Hf2CiU3dsO6AQaY6jsuGIXeJEaWCt2UJfhc+75m/gW
         tuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FJiERJq8seSOSllZH5YEQwwR1oj81w19nx1TE+EiOU=;
        b=bSMSQfQ6VqjTE8YOte9Pb3Jwt7sHYpN+dpZjRnO+7KztDO0mnjF3mqpi7nWMMlrnnh
         1oTetJ5+zk9TOnmJ0sCjsljnyFTCep3UcGchvpzYb7ilL8BZddmL9JHN9PB9RBonMI+I
         w6m9NjfptDvyqfTOtFgJYSHlzvp2muqRTQfW6DPr89C6VOJ+J9v3KeA+lYQegvoxXsSX
         aVIgy+YTXbphMISjkSM8O5azofxif8XR8cjiuUTWQbGlGfLsCtrnnYkuztwQ7NbRZ2QL
         DydG2E8ytlDHU6oDl8KRCKMcInMqeRp/fHtTh+mokGM4/SKlTQbqwfXcjbQU8J80hc52
         9nwQ==
X-Gm-Message-State: APjAAAU92GSzLsuy3xdYJ3VTE+4JT9vV+PA4AcfYi3TY9pMRZS0aq8WU
        2oDk/LqgEMOPqjVtgsCyz73En9Ian9uIL5n8V8k=
X-Google-Smtp-Source: APXvYqyvf3vxurJvXfLOn2BfIE0NvTSP3CZXj/aOJrKdFo9xEcgZ7fdeYCMSQNPTYo8AeyffGkTIQU2xcVU6QMYEmyI=
X-Received: by 2002:ac8:541a:: with SMTP id b26mr22512155qtq.276.1577087294188;
 Sun, 22 Dec 2019 23:48:14 -0800 (PST)
MIME-Version: 1.0
References: <8d5358a67746b2aff5f6995cabd11d0d7c9e579e.1575978484.git.baolin.wang7@gmail.com>
 <dd3303a956e7dd5c065ac2b92b1dea7ee5d1df17.1575978484.git.baolin.wang7@gmail.com>
 <CADBw62o3vW_hdFwcMdQFJqx2HpNhCEHOxADQO9LztzpqCVQBpg@mail.gmail.com> <547d91fa-66c5-e3bb-4028-2578f070695c@linaro.org>
In-Reply-To: <547d91fa-66c5-e3bb-4028-2578f070695c@linaro.org>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 23 Dec 2019 15:48:02 +0800
Message-ID: <CADBw62pcYZ_GR1OrS3VG-Y1T8CYOcL4pRzTwBt6of4ZmzhhNng@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: sprd: Add Spreadtrum thermal driver support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        mark.rutland@arm.com, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>, freeman.liu@unisoc.com,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On Mon, Dec 23, 2019 at 3:42 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Baolin,
>
> On 23/12/2019 07:31, Baolin Wang wrote:
> > Hi Rui and Daniel,
> >
> > On Tue, Dec 10, 2019 at 8:08 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >>
> >> From: Freeman Liu <freeman.liu@unisoc.com>
> >>
> >> This patch adds the support for Spreadtrum thermal sensor controller,
> >> which can support maximum 8 sensors.
> >>
> >> Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> >> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> >> ---
> >> Changes from v1:
> >>  - None.
> >> ---
> >
> > Any comments for this patch? Thanks.
>
> as it is a new driver, it takes a bit more time for the review.

Sure, thanks.

>
> By the way, is there any open documentation for the hardware?

Unfortunately, our company did not supply public documentation for
thermal until now.
