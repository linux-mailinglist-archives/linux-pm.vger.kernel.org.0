Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFA482686
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 23:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfHEVCv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 17:02:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37602 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHEVCv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 17:02:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so40240825pfa.4
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 14:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=uMVmeu4mdexdqU41liFV6boDUEQu0SlMK35Wx76U6rQ=;
        b=fWEhDH71W06T3024ETGhhgrpXzwlOn9eSdQr0TzByAtVcHPr5TVTvBfe3MLFjn8JNr
         fptB9Za0YySQe54L+mGjMUAaYQUicXz48Ta4el70D9SHQhbLW8zXoQj5+Cnrqv/XVgVh
         biPY1LDvezl01zVWbBeV8IZ3lhX34QANjm7Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=uMVmeu4mdexdqU41liFV6boDUEQu0SlMK35Wx76U6rQ=;
        b=BB7O9r/gCY5wm6QQYC09DF374uNY3QwL/Yp2m8/bpFSQSTezmbcryzM7WptiMDrNmW
         M8TaYkdDL/eLAi2lGzVv5C4UACMh1rW38NvAPiezG1HcgyRFq0ZLBzuy9CNHwZRCAF/Y
         bSLfhlEZoUzZMtIpC45UNNRBFUtQCEPR/QUXrPnwNx28kmwRSUwZspboyt170MEQrVzE
         NbIIGDqKQDmoO6OuEpRK56dNkH9h5X8xlLfK3c02xzoO5/W2gz8xM3pQn/h6+2LLn0R9
         E/f3ljzu00IfIicJnx/VmW+Y76lRrcqbqb9mYaRQOwSIXM4mBTlaoqVNzlZibq6CMhaq
         ACXg==
X-Gm-Message-State: APjAAAXoEEwqV8I846MlHp6fq1/wIyyRa5h2r8Z31bBNNhlL59B8KFJ3
        Vl1S+H8baYIXrWAsWGi4QFd/Qw==
X-Google-Smtp-Source: APXvYqzPqg8YsUI6ORm0RYGZBvQh+47+wA0FAnK1obUP/lbkhgT9hEqgCPBEcxjSX/A3ucR/P+9qKA==
X-Received: by 2002:a17:90a:2247:: with SMTP id c65mr19374065pje.24.1565038970368;
        Mon, 05 Aug 2019 14:02:50 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x9sm59934438pgp.75.2019.08.05.14.02.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 14:02:49 -0700 (PDT)
Message-ID: <5d489979.1c69fb81.9480d.fd19@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190805175848.163558-4-trong@android.com>
References: <20190805175848.163558-1-trong@android.com> <20190805175848.163558-4-trong@android.com>
Subject: Re: [PATCH v7 3/3] PM / wakeup: Show wakeup sources stats in sysfs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, Tri Vo <trong@android.com>
To:     Tri Vo <trong@android.com>, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org
User-Agent: alot/0.8.1
Date:   Mon, 05 Aug 2019 14:02:48 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Tri Vo (2019-08-05 10:58:48)
> diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeu=
p_stats.c
> new file mode 100644
> index 000000000000..3a4f55028e27
> --- /dev/null
> +++ b/drivers/base/power/wakeup_stats.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Wakeup statistics in sysfs
> + *
> + * Copyright (c) 2019 Linux Foundation
> + * Copyright (c) 2019 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> + * Copyright (c) 2019 Google Inc.
> + */
> +
> +#include <linux/idr.h>
> +#include <linux/kdev_t.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>

Can you include init.h, device.h, timekeeping.h, and kernel. here? This
file calls functions exported in those headers.

> +
> +#include "power.h"
> +
> +static struct class *wakeup_class;
> +
> +#define wakeup_attr(_name)                                             \
> +static ssize_t _name##_show(struct device *dev,                         =
       \
> +                           struct device_attribute *attr, char *buf)   \
> +{                                                                      \
> +       struct wakeup_source *ws =3D dev_get_drvdata(dev);               =
 \
> +                                                                       \
> +       return sprintf(buf, "%lu\n", ws->_name);                        \
> +}                                                                      \
> +static DEVICE_ATTR_RO(_name)
> +
> +wakeup_attr(active_count);
> +wakeup_attr(event_count);
> +wakeup_attr(wakeup_count);
