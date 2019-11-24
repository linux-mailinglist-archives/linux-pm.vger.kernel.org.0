Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 599251083E1
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2019 15:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfKXO5P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 09:57:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44171 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfKXO5P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2019 09:57:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id d199so1357900pfd.11;
        Sun, 24 Nov 2019 06:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfWsOmQE/r0rnoMiC9E/xzw8dmYppncobr92itFVVSs=;
        b=IsG6iwopTfpkSahUG6WT0yB+bF7hDW/WcOu4iU3POG1cggRa/nihBOenHTteUKComn
         QVl0DDjCxmf9EE7EenT2oriblVHVJ9/to9q0OQEwuehzdoRMQcUSxvjQawTzu/j/BWcV
         MPrVab+hfkO/mCUxfHkxLvEhsOC+zpWxDEFHOO9VxZ8w97dbccUR4GgTL9NEz+eg6BpA
         rYFXlupkxzoVEdLBQZDXL8kaEzwZu0rfxnwMnxtTMsQQrlaJTrrGaDw5jxxzZgZfj8iy
         5tJ/5KgbWrEBCceGl9LLkyc5KaRyMS/shAiHnlA8Z1oCKKu30+Xwsk7Fmix9T8eI0cY9
         y3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfWsOmQE/r0rnoMiC9E/xzw8dmYppncobr92itFVVSs=;
        b=tmYcT8ZMa+3vE37DKlZEL3ol//P+6FHDUVUVyj0KKnHqUvhcg9V6ol5NuwmHvM+I1v
         jMuXtNh4yh1ZTsNdlke4j3frWL7e6Kv5g8tcFDwbnIpRgSSJqrpZPtNlqa0RPnJM8fA7
         d4z7igs55SpSoU2R5zUYH1HfOjQBErEbis2yzF/oXdVyYAdFyiY9cNScXXSbtjXpQ1Ev
         5OP/8W7MTlpbk92p19NCHKpJIMzWP1qXufepkQKdRLe5N5uiOn/Rm/jn2pDU+CrMz3iF
         abuAHpcNBb3KYdLIMrhgDz31EUYWRQKFJeSs5GaFVh/Bpgajz+jAwBec2Q6STWLtsbzL
         MpgA==
X-Gm-Message-State: APjAAAVVHl4vgWn1E4DY18+23g2FNwZ2zByZG003Cu0ybEdN+HRE2Cjq
        PWH9MEhVCeHmUNndJUSfLDsHOjANQNJeITVx6DxrzN+E
X-Google-Smtp-Source: APXvYqwZoLFN1zxu52vVv3dD5/32mEnANCd+XVhQAiRkPPoSM2JkZ9mS6MAzmzvEHaPoZLlNYU+nqc9CBou0i1oYEfw=
X-Received: by 2002:a62:7590:: with SMTP id q138mr6261090pfc.241.1574607434795;
 Sun, 24 Nov 2019 06:57:14 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com> <1574604530-9024-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1574604530-9024-2-git-send-email-akinobu.mita@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 24 Nov 2019 16:57:03 +0200
Message-ID: <CAHp75VfGt59F5YbEjctvOm00g+Pws+1jYgVbNLnUE3kq3SZi-A@mail.gmail.com>
Subject: Re: [PATCH 1/8] add header file for kelvin to/from Celsius conversion helpers
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Nov 24, 2019 at 4:09 PM Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
> There are several helper macros to convert kelvin to/from Celsius in
> <linux/thermal.h> for thermal drivers.  These are useful for any other
> drivers or subsystems, but it's odd to include <linux/thermal.h> just for
> the helpers.
>
> This adds a new <linux/temperature.h> that provides the equivalent inline
> functions for any drivers or subsystems.  It is intended to replace the
> helpers in <linux/thermal.h>.
>
> Cc: Sujith Thomas <sujith.thomas@intel.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@verdurent.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  include/linux/temperature.h | 39 +++++++++++++++++++++++++++++++++++++++

>  include/linux/thermal.h     |  1 +


> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -14,6 +14,7 @@
>  #include <linux/idr.h>
>  #include <linux/device.h>
>  #include <linux/sysfs.h>
> +#include <linux/temperature.h>
>  #include <linux/workqueue.h>
>  #include <uapi/linux/thermal.h>

I don't see any users of it. Why did you include?

-- 
With Best Regards,
Andy Shevchenko
