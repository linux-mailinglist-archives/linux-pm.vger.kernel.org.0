Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E608F165B49
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 11:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgBTKP2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 05:15:28 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37271 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgBTKP2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 05:15:28 -0500
Received: by mail-oi1-f196.google.com with SMTP id q84so27013619oic.4;
        Thu, 20 Feb 2020 02:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrpA/aDZEgyuDLHKgBcy0/LH4Roo4D9FFntWx9OYv2w=;
        b=puzpre/gWsEzKECAMVdhOh93TdiahuGGNA0nfGvX40K8eCGyOOSPWIWV/MhuoijArf
         amhEx+lrItaODvRwItzp7hgzMUiHRtInBxaLEiV+PKKs5yFVnErmDVx0NzXmB+3Y0Jbl
         vDEolpE9sUF9C3ubF9Wn79hsz8C1JTFxhUYiv9CnYS728HI+aDyYjXydqwS8eXSLvLaS
         EGbyOww/WpZlHyXfGfSd8C+BJQiAixDlxx0rhQsaeHVtlT7sITv/V5hmrqn6W7TuWSZ3
         rQwugHm952dpGcxmfT5w5kSkfpWinGgW+KddcMlOEm/Qe/2kTnDFjRW270RM+f0dKyR3
         ediw==
X-Gm-Message-State: APjAAAU6Fo2uWVONuuqtV8Jvk4ghw0+TFr/Jxi9GDyq8MFeqo1taA2t7
        GSyiOt47p5xmHIG27TIf3C4fD6+vsP3w8OqefawVu4zC
X-Google-Smtp-Source: APXvYqzLPpMYvxdkIJp5TMgSSKCY3AGW71USksXzIoWISBQJ/hG1+gi9Xec/beN8VCK1p/1gA/6xwBODRg7rHQpRWbw=
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr1473766oif.57.1582193727554;
 Thu, 20 Feb 2020 02:15:27 -0800 (PST)
MIME-Version: 1.0
References: <20200220050440.45878-1-john.stultz@linaro.org>
In-Reply-To: <20200220050440.45878-1-john.stultz@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Feb 2020 11:15:16 +0100
Message-ID: <CAJZ5v0iROuLr-AtUTOa=pxbkif9xTSC_r2P6gHNtT2JPoE61pA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] driver core: Try to improve and cleanup driver_deferred_probe_check_state()
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 6:04 AM John Stultz <john.stultz@linaro.org> wrote:
>
> This series tries to improve and cleanup the
> driver_deferred_probe_check_state() code in the driver core.

"Do. Or do not. There is no try."
 - Master Yoda
