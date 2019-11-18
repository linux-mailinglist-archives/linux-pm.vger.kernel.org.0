Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4E01000C8
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 09:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfKRIwQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 03:52:16 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37950 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfKRIwQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 03:52:16 -0500
Received: by mail-qv1-f68.google.com with SMTP id q19so6187571qvs.5
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2019 00:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=90C7hPp0jjaPYLe8/qhSTZ7vmNH4K6cF3RIbxB4NlI8=;
        b=h+DlLwIYPwkEGm7ZwxM9QJLnJfsunRWIedIWJ9B3S7ojb1/F7YdnBvGfpCWtt2P6eE
         ZHN9kG3Fa8IBk9MopizRa68GDkKaxUIODQul193ZJ4n95myJmTqCaab7imPgHrruhtwh
         c9xP7YeXINGmtqGVaMBieRXt4fgzVhPTaibcqilhjpTPndqwFNazKjFwVxX2wOCTRcN4
         k4CIUGjRLoQcM9SWQCl3r7Y5GAGb1LKWQmg7KTAtR4LW9kQ8Du0hgbXlcEkgtxP7Uqam
         KZ73heL7JguFUx9b73bmSdJkrJk1ceY85PzJZsMP0X49WMs5mAeG57IFT9mRkLgv9awm
         LGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90C7hPp0jjaPYLe8/qhSTZ7vmNH4K6cF3RIbxB4NlI8=;
        b=pZfQRXUP6qBMKwiV745V4RmsUMPn28/Fhk1z4mRqv59GVrFL4SojYsWxQztSzJAyVs
         HcVF/+8JydJogVukVxifTqV3s4pYK9Uc6kgKz/01nJfhYQBqqmzgxAUK8YW6yasCIK3B
         /y4IqO+nyI+U1CIoWdZK7sxH3fbEELeUurjjUsoXlV3oTe5njiKmcQaM79S0flMrlM9T
         gmZn1/RY78xTj74797UyB580yOp49wiMKAnUgIygyb3kwUyE1NDT7Cq/4mgBHQAvVyfe
         IGXaxCUk/YxdsUxOuv5ZC6S/zwyC93n7BrwoqZzdYxP3+a7OrfrTvEus00J8SHJtnuCp
         73YQ==
X-Gm-Message-State: APjAAAV24Tm5Mg+dEvnBAUK2lzb8wsH4WvABzr6Yd4oTma1NrDGgDEaX
        O9PQ1NhYaloRvc6VzgrXmFQJsoYV8Ad+YoS00Q2HWA==
X-Google-Smtp-Source: APXvYqx4wlDkliAAM0cS02/2UUhvIK8zKh6KQrQBhzlkEtuIsELYprvnD3s0HH+9QRTRcCKli2zottiLXVwM9jiUuoI=
X-Received: by 2002:a0c:bf4d:: with SMTP id b13mr3703586qvj.115.1574067134850;
 Mon, 18 Nov 2019 00:52:14 -0800 (PST)
MIME-Version: 1.0
References: <CAD8Lp47HgAi-86ni5WHhZT1-sEd7oJEZUiG6KNU66qpmRCfaXw@mail.gmail.com>
 <20191025162814.GA130180@google.com> <CAD8Lp44f9EQS93VkYUfnZYPjHMpOVCPuGoKD+dZ+=+tfyZHU5w@mail.gmail.com>
In-Reply-To: <CAD8Lp44f9EQS93VkYUfnZYPjHMpOVCPuGoKD+dZ+=+tfyZHU5w@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 18 Nov 2019 16:52:04 +0800
Message-ID: <CAD8Lp46qQootoWqOA5fyE=y0stqr+9qTmXymvNsmX9ghjox=aw@mail.gmail.com>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bjorn,

Any further ideas here? Do we go ahead with the quirk or try to find a
more generic approach?

On Mon, Oct 28, 2019 at 2:32 PM Daniel Drake <drake@endlessm.com> wrote:
> It looks like we can detect that the reset has failed (or more
> precisely, not quite completed) by reading PCI_COMMAND (value not yet
> 0) or PCI_PM_CTRL (doesn't yet indicate D0 state, we already log a
> warning for this case).
>
> From that angle, another workaround possibility is to catch that case
> and then retry the PCI_PM_CTRL write and delay once more.

Thanks
Daniel
