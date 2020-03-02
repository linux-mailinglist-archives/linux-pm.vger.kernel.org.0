Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 430F31766A5
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 23:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgCBWQW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 17:16:22 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43417 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBWQW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2020 17:16:22 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so877278oif.10;
        Mon, 02 Mar 2020 14:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noZiYNyOS94nMDQsDfPOoeLawipKoxMdHXJET6K9jNA=;
        b=V4VPwJH0RjVGR4EmLNi+wzs6UhKNCNzf84ZGeaqg/JDmA5LuYy8fn5F6sIRbskTZyu
         30EN+verJGGTl+3X2qBmF4Npp5t1w1GJ/0IrsjJSe3rjsMr8hzaetj8fDxgKV2lQPSYx
         cjBa2StpVlj8n3jMaSCGlOBEssyBPqtHgFc87QTN6VxBbAR0BPzan8Sor837yQAGM2CT
         I4F1YndPiMqSKtqqSxuIuEf/Rrd60pHba4OaH4ZyqjHSjAQnvfd8vWB0U1y7dmzxZ4YG
         Vp+2Wyc02B84qwOSU/lQx0xzcPIv9Ujo6lDlW4loyQWg54Ff+Z7maTLSyvNLt3R0k9Pe
         WzIA==
X-Gm-Message-State: ANhLgQ10Az0WXuLY1rEOJxtCaHEuOT0+tyfA2PesC5hNCf4juAhQVn2+
        ly/0V+SFkkyJbQP8GQgzMwjH71iozAaZPF5/lZBjbg0a
X-Google-Smtp-Source: ADFU+vtP6YxzSQsibwRqw47itfxwwseprgpBoXx7+ncgb7wNRz8tNzzDH+91Jz9wSioH6Z7+A+qLTKctJMyHR6rMT18=
X-Received: by 2002:aca:4d82:: with SMTP id a124mr426136oib.103.1583187381398;
 Mon, 02 Mar 2020 14:16:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581956285.git.mchehab+huawei@kernel.org>
 <7a89b0c82520d340d3c7f45bfd52ee9e6e23dbdf.1581956285.git.mchehab+huawei@kernel.org>
 <20200302141916.1c6d8abe@lwn.net>
In-Reply-To: <20200302141916.1c6d8abe@lwn.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Mar 2020 23:16:10 +0100
Message-ID: <CAJZ5v0jOXFqkm4g=_WrZo6S-LBrWuqhckS7Yn29nE6hCfZCVzQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/24] docs: cpu-freq: convert index.txt to ReST
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 2, 2020 at 10:19 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Mon, 17 Feb 2020 17:20:32 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>
> > most of the stuff there can be re-used with ReST format,
> > but we need to add an empty TOC and remove the existing
> > entries, as the following conversion patches will be re-adding
> > them, as they're converted.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
> Rafael, do you want to carry the cpu-freq changes from this set, or should
> I just apply the whole thing over here?

I will take the ones that are applicable after rebasing on top of
https://patchwork.kernel.org/patch/11411035/

Cheers!
