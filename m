Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F4F246F2F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 19:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388730AbgHQRny (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 13:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389020AbgHQRns (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 13:43:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99461C061389;
        Mon, 17 Aug 2020 10:43:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x5so13949493wmi.2;
        Mon, 17 Aug 2020 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HFsbrpQA/6K/m6r64TJHx6ZpqfJgPOgySDUCEdnMbUs=;
        b=BEVJDvx4JugvWQ1LtNcvyOtVSVOmLiagYyaUL4nRagGU9m0FqRjQngHvQ+WqZu1gpN
         G/6e3/WToUY711n0lcpG6utJKT4+1ge+FKcETxwVdq8SwEXmmWFJA5dF/7jhjYLYBrpG
         s9pk+O6sE35yNH8cZFSwElKy6xPNP11BZZIHzGrsN4DopoNUVdZtIp8mEMVZ85ZDDvzD
         hdWV4V9hlZNZxt1k833BuryAlMT2pqX/UEbCoSstqGFxgYX0hQXnfmxyvyYKjUe3uWz3
         AUy9/GH+rZixjDs9WNrEKmcvmJOO4+8BJx3do2iJzZ3GLCbrpUcPRo1Ggqo+zowb/8BE
         ANMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HFsbrpQA/6K/m6r64TJHx6ZpqfJgPOgySDUCEdnMbUs=;
        b=LuGTfsvtC+Z1EaJL5ODbGrNibIZwnZzuMl+XAFSANSMWMsx6+swTbqEg7MzLgJZ7bY
         E3Hu7fdeJHMUud8lfDY/nTIiYuyBJEHqN8Dxl4FzzHsh3cb/5wgd5XZOf2sLUv7ojdvT
         nTovuRT59CHyqwAx1MJoDZIT+6asx3bOujFzwURkZGeByqNatN0XNZ/2iixxbemZZtee
         YNjFX5D2/0RAUgEoQjJS2+k3UasVoVe1YjW9t9QZlthKFBXC63vy3zP49sJ9B7Cx8RMg
         Yml01QSAG0O78drOKisKlLCkJK9NUKExrB3BgnlP5CniAIV9Pm0C6JghtjsiHdhO9G6Y
         ncxA==
X-Gm-Message-State: AOAM533dMbWWspZsHtQShfvqWvIPJ0o0Y2/mtbV2c/161HUn5UTYje/j
        RAXqmxS4KkEeE0P+DQmt4X8=
X-Google-Smtp-Source: ABdhPJyrcKXTHc4h4Psph7lG3cawYaF1Uisg47sIhEE1aW8mNmbTC9HMd1oGHBj6YzpuAqNrjqVsyw==
X-Received: by 2002:a1c:3b89:: with SMTP id i131mr15545485wma.30.1597686227372;
        Mon, 17 Aug 2020 10:43:47 -0700 (PDT)
Received: from lenovo-laptop (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id a10sm31312236wro.35.2020.08.17.10.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 10:43:46 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Mon, 17 Aug 2020 18:43:44 +0100
To:     David Lechner <david@lechnology.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Go??aszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] power: supply: Add dependency to lego-ev3-battery
 Kconfig options
Message-ID: <20200817174344.lxuzlly4it5vpfmz@lenovo-laptop>
References: <20200809185444.54247-1-alex.dewar90@gmail.com>
 <d6c98ee6-f2f3-c55a-be16-3794ccf30a28@lechnology.com>
 <20200812133711.ddwhxypmvr27pxdu@lenovo-laptop>
 <ce0ae241-10e1-de5c-e694-2c00dc01a2c4@lechnology.com>
 <20200812190253.zewvdfvyu6cnggcl@lenovo-laptop>
 <0927eaf0-62d6-adaf-c4b0-89d7f4cc7b4a@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0927eaf0-62d6-adaf-c4b0-89d7f4cc7b4a@lechnology.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 12, 2020 at 02:12:57PM -0500, David Lechner wrote:
> On 8/12/20 2:02 PM, Alex Dewar wrote:
> > On Wed, Aug 12, 2020 at 10:24:30AM -0500, David Lechner wrote:
> > > On 8/12/20 8:37 AM, Alex Dewar wrote:
> > > > On Tue, Aug 11, 2020 at 09:24:10AM -0500, David Lechner wrote:
> > > > > On 8/9/20 1:54 PM, Alex Dewar wrote:
> > > > > > This battery appears only to be used by a single board (DA850), so it
> > > > > > makes sense to add this to the Kconfig file so that users don't build
> > > > > > the module unnecessarily. It currently seems to be built for the x86
> > > > > > Arch Linux kernel where it's probably not doing much good.
> > > > > 
> > > > > It would probably also make sense to add "default n" since it only
> > > > > applies to one board in the entire arch.
> > > > 
> > > > Ah ok. That makes sense. Would you like me to send a follow-on patch for
> > > > this?
> > > 
> > > You can just send a v2 patch that includes the change below and the
> > > additional change.
> > 
> > I've just had a look at the documentation[1] and it seems that as there's
> > no "default y" there it'll default to n anyway. Have I got that right?
> > 
> > [1] https://www.kernel.org/doc/html/latest/kbuild/kconfig-language.html#menu-attributes
> > 
> 
> Yes, that seems right. That makes me wonder why this would have been enabled in
> the Arch Linux kernel for x86 then.

Not sure, maybe the Arch devs like Lego? ;-)

Are you happy to give an Acked-by for this anyhoo?

@Sebastian, are you happy to pick up this patch?

Best,
Alex
