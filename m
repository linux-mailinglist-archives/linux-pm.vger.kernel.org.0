Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3B93FB8B0
	for <lists+linux-pm@lfdr.de>; Mon, 30 Aug 2021 17:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbhH3PDW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Aug 2021 11:03:22 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:37429 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbhH3PDU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Aug 2021 11:03:20 -0400
Received: by mail-oi1-f173.google.com with SMTP id y128so20212745oie.4
        for <linux-pm@vger.kernel.org>; Mon, 30 Aug 2021 08:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wf3xAU1ij0RMMd8Ew7cSqbN0oTUZGyzNwZVJieOWSFU=;
        b=m85lEbN3FR0X2E8JXfH2y2o5FGelmT2eSX95gp1aKfMrqi/saBenS8IjOQXqim4KEi
         Wz6F4PNtf56EAFXei3gJ6zvTLN0wkvBtyBwh+DQKKnFLJM5USH3sGm30prSjZAwpHDNs
         sEPJr74dHBdHs9BTiOa9rlSVtcY+6MgM504+IhUXZlaCmVCRejFj4lnXHWWNr5RDdHER
         DzfjK95GCl9rFvOCnccl+CEGLSc5yfRfpy6ulOvP4NoxL8avno3XmQZupX1Gze3jYENV
         WXmKx7+bccwglgtsk0eCz2LVlTw+R+u/rhyR3qZk/iCCKFlGzPmulq4mpEPe32/k/pBI
         aqBQ==
X-Gm-Message-State: AOAM532PWR01609gJS4/1He6qHA+APHL/nTgu83N5Fex73a/p0qnDwmS
        cwtgvAo4utXN40nZq7xN0WmYSsPnXxd5Pq8xRONzIo8HGsw=
X-Google-Smtp-Source: ABdhPJy3OplOVQmyJRPbyvOrS7y1CexErTYO8YvoJfkointgJB0rJDWSnxfrmfG1kup72kem0slv0kntxd9i7nFtWo8=
X-Received: by 2002:aca:afcd:: with SMTP id y196mr15667172oie.71.1630335746713;
 Mon, 30 Aug 2021 08:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <93abc004-eed6-d78b-9311-a6626e7a0ff6@mec.at>
In-Reply-To: <93abc004-eed6-d78b-9311-a6626e7a0ff6@mec.at>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Aug 2021 17:02:15 +0200
Message-ID: <CAJZ5v0ijNPY+33yYPZR03ZEQbCXLog32aqjU0LMTPkcvDwvNYA@mail.gmail.com>
Subject: Re: Communication between kernel and user-space
To:     Thomas Marangoni <thomas.marangoni@mec.at>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 30, 2021 at 3:51 PM Thomas Marangoni
<thomas.marangoni@mec.at> wrote:
>
> Hello,
>
> I'm currently working on the axp209 driver.

What kind of devices is it going to handle, specifically?

> The device has multiple
> warnings like: temperature too high or low,

You should be able to use the existing thermal framework for this.

> over-voltage, under-voltage

But there's no generic way to communicate those AFAICS.

The question here is what user space is going to do about them, though.

> etc. What is the recommended way to communicate such warnings to the
> user-space, besides dmesg, so programs can handle them? Or should I just
> create my own attribute for each warning and set it to a specific value
> from the kernel and let user-space applications reset them to
> acknowledge them? And if there is a recommended way can you name me a
> driver that is using it?
>
> Thanks for your help!
>
