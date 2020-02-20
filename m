Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9FB165C49
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 11:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgBTK5U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 20 Feb 2020 05:57:20 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45916 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgBTK5U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 05:57:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so3198658otp.12;
        Thu, 20 Feb 2020 02:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oUm7pdkP7Z40yNU0+bCa9A5eNVIQpdLnF23GrSn2iwk=;
        b=f3hXWZR3Hgc9JoPdVd35B4XTpiRolop8/siUgtSvyl6YikTULe5f0Q1VKRustk1AZK
         Cor8gVk2TL0UX0iBI0u6F58X6/XCNn2ruI+JC6lTig0MN6qMwvViH4vi++2/iFps9L+D
         kyNcGJ7xjIMm5j6j/HLLkKqTDhCpW9FfRdbBal2WKe26N6FOcLmimSyKJVzTUNIX4p5k
         7OScjqydnM2YNtSagwE0DK/BR/6Yg+eJKtaDzkpVYoMImGK8OLZqggTQiLuWUtI4BoJR
         9VfzK3gX/T9jktdxpA5rVLmSqeVFSJHhQhEN9ar2yAsBJrrzfXUYlB83Xo2oYdGhJ6pL
         0nAw==
X-Gm-Message-State: APjAAAUe3BqjKOMXVp4sngwxWQpnfc9bpMXTv7EnvWCNbc0dP1BSe9/R
        oOwp7iIwy9IPabNeoWM/mKnkz/n7koA1zMG86jOneA==
X-Google-Smtp-Source: APXvYqxqJppIyUd/OfZTqFpjgRZ7wJ/a32QzOMfYY2RxFL5PJ9ad0sUNFLEOiPEbk+atTo+IHeVpWl+zX0CASNRcELw=
X-Received: by 2002:a05:6830:1651:: with SMTP id h17mr21822924otr.167.1582196239475;
 Thu, 20 Feb 2020 02:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20200218145819.17314-1-j.neuschaefer@gmx.net>
In-Reply-To: <20200218145819.17314-1-j.neuschaefer@gmx.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Feb 2020 11:57:08 +0100
Message-ID: <CAJZ5v0gQsZjHn4A2aSRL1Ap2PiUN0SC3h0Csfqd87aS9e6VpxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: power: Drop reference to interface.rst
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 18, 2020 at 3:59 PM Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
>
> It has been merged into sleep-states.rst.
>
> Fixes: c21502efdaed ("Documentation: admin-guide: PM: Update sleep states documentation")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/power/index.rst | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/power/index.rst b/Documentation/power/index.rst
> index 002e42745263..ced8a8007434 100644
> --- a/Documentation/power/index.rst
> +++ b/Documentation/power/index.rst
> @@ -13,7 +13,6 @@ Power Management
>      drivers-testing
>      energy-model
>      freezing-of-tasks
> -    interface
>      opp
>      pci
>      pm_qos_interface
> --

Applied as a fix for 5.6, thanks!
