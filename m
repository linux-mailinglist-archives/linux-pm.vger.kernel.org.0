Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E341264B36
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 19:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgIJR1X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 13:27:23 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39605 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgIJRY5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 13:24:57 -0400
Received: by mail-oi1-f194.google.com with SMTP id c13so6661764oiy.6;
        Thu, 10 Sep 2020 10:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SjYkPCU61w/qb4B6RVouCzvKhSm3h1WA66nzvLfjm4Y=;
        b=quRiHve48nAJjV09bFrsgP8HHIa6G4pvDjKK5TOnnBN8ghyrvyybNOkMX/QfPhnWZ+
         DFMj9OSMFXSHAdclgebGNGTvAX4wquzZ+tv/Tyo1ik1x5xNHHXD3mR34cjxDdeaI5DZ8
         hVsMOw7dg8JiAswKzWRl1EZvE/2zCDWuGjorLl1PKe+owVLsCW8/pO9VJQsPor5BO0J1
         0H9Kx34rfN8pPasZj0o/R9uREuYbB2MaC40Fn6e2mmx9Ow5I7gMS882xP6XzPRTjhaQ5
         D3kQjRPgSuLwo/NzjakrnD4dnqpLIbayUWlL7vF5oTKDTyQO+cTlpOAIlr6DD6ct6Noq
         RWmg==
X-Gm-Message-State: AOAM532fVtQze6jy91FCnXkbxAs025w5rrJ0XyNWZa/6eFI49kiZazKr
        n/++2VNOHgb8CojKRSfqDnkfZS/oFETwmn6rVBigqKxd
X-Google-Smtp-Source: ABdhPJynJyCEpO/tGdCDaOxBk3ZDa6w6i3ddDaYTbgQkZw4gQmwn7+kK35cbsnV5yWaFCEJBy4sMikK+fdImbFZ11vs=
X-Received: by 2002:aca:fd95:: with SMTP id b143mr663599oii.68.1599758696796;
 Thu, 10 Sep 2020 10:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <d97f40ad-3033-703a-c3cb-2843ce0f6371@infradead.org>
In-Reply-To: <d97f40ad-3033-703a-c3cb-2843ce0f6371@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Sep 2020 19:24:45 +0200
Message-ID: <CAJZ5v0iaHEWw2aV1pm6ZsXMRicYSkpKHmC+ygU=UW76isqX+4A@mail.gmail.com>
Subject: Re: [PATCH] PM: <linux/device.h>: fix @em_pd kernel-doc warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 7, 2020 at 5:43 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix kernel-doc warning in <linux/device.h>:
>
> ../include/linux/device.h:613: warning: Function parameter or member 'em_pd' not described in 'device'
>
> Fixes: 1bc138c62295 ("PM / EM: add support for other devices than CPUs in Energy Model")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/device.h |    1 +
>  1 file changed, 1 insertion(+)
>
> --- lnx-59-rc4.orig/include/linux/device.h
> +++ lnx-59-rc4/include/linux/device.h
> @@ -454,6 +454,7 @@ struct dev_links_info {
>   * @pm_domain: Provide callbacks that are executed during system suspend,
>   *             hibernation, system resume and during runtime PM transitions
>   *             along with subsystem-level and driver-level callbacks.
> + * @em_pd:     device's energy model performance domain
>   * @pins:      For device pin management.
>   *             See Documentation/driver-api/pinctl.rst for details.
>   * @msi_list:  Hosts MSI descriptors
>

Applied as 5.9-rc material, thanks!
