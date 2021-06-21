Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C0B3AEB29
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 16:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhFUO0f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 10:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhFUO0e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 10:26:34 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184D9C061574;
        Mon, 21 Jun 2021 07:24:18 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so17942595otl.0;
        Mon, 21 Jun 2021 07:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3Q+u88A7OlP4119QDatD7v4G6DTIYfrxqaTT3udWXs0=;
        b=MHcCFhvCFi2AUQLLfNm4Gz8dP6cDRu9Oz7pok0hkt6k3YwXB97Fe8B9I8nhTmW8yaJ
         Lzy+qQpMpnkNyZZm+Y1Xaw/CuRedX7LfNSkJLrxTjKahp4Ux9eVpX/eKnfl5e4ar40Yh
         JWSBCVcZRY/o25f19utVuzIjWoM1ZhbWNjy1PyLXvuZ9WTKxijFb2iTxL8q/AzjRjmpy
         nlzD4r6fW9Mied6xsF+AsJelfChfhNCIvalCJ8dLdW2IN0ZRFhUKMAYotnBt2ya0fZMi
         6Hnv/c7iuC0LHe65HdA3njJYsj60f/V9BPlmQRunSyEd6LgHD+zA7mHNHQrkDWaM8n60
         jegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=3Q+u88A7OlP4119QDatD7v4G6DTIYfrxqaTT3udWXs0=;
        b=Eyp2ib9J7CSaZ0OyxADVdkm0+BAlvOVNFOmlak9YzFbmRHh519AX57xR9ND7TLKFYD
         fphPeG2Nld1TSKkC5qqP2vJ73wI4MfwnwdCGk6DNDBQ6hTO1dhj0VNjm0mtrQoicVKp8
         HEFGVVllzbpehoKEfjNrrrLH+EKgQt61POcDXfCACn2jLIhzI7OuCVGrueJm25AY93u2
         b5nHgZvpKdfZtcVByVseLEoYju0esS16m+L1il+gGP8zbAOKk59ftInHPk4lj2/fCyUo
         5lUsqMZIF25UgZNVg/6GMWIbTCSmlcL9QSSRAlOliFR4QTLal+yREJhHF/V0MjfZzc1f
         /lIA==
X-Gm-Message-State: AOAM532++l20Y3v/3i1lrXdGXbyf4BMdwhqZ7wv8IOCiwml2fP8HD81M
        QNGKdnMJk/4fLfJsMlo9xuw=
X-Google-Smtp-Source: ABdhPJzziQmTYrhT5+C5sJae+4MxEqAvQf20R5dIwCsKV39qiv5T4OqlNdLUM94Avsj8z/HtBxwUEA==
X-Received: by 2002:a9d:7516:: with SMTP id r22mr18218752otk.332.1624285457445;
        Mon, 21 Jun 2021 07:24:17 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o5sm1877249oti.53.2021.06.21.07.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 07:24:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 21 Jun 2021 07:24:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: (lm90) Prevent integer overflow of
 temperature calculations
Message-ID: <20210621142415.GA3604789@roeck-us.net>
References: <20210620211408.3893-1-digetx@gmail.com>
 <20210620211408.3893-2-digetx@gmail.com>
 <20210621121229.GB116119@roeck-us.net>
 <ac1c4350-687e-7999-633c-6b7354ef9b8c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac1c4350-687e-7999-633c-6b7354ef9b8c@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 21, 2021 at 03:14:40PM +0300, Dmitry Osipenko wrote:
> 21.06.2021 15:12, Guenter Roeck пишет:
> > On Mon, Jun 21, 2021 at 12:14:07AM +0300, Dmitry Osipenko wrote:
> >> The minimum temperature value that is passed to the driver is unlimited
> >> and value that is close to INT_MIN results in integer overflow of
> >> temperature calculations made by the driver. Limit the value in order
> >> to prevent the overflow. For now the overflow condition is harmless,
> >> but thermal framework won't work properly once we will support the
> >> set_trips() callback because it will pass INT_MIN value to the driver.
> >>
> > AFAICS that should only happen for lm99 because all other values
> > are bound in the temp_to_xxx functions. Where else do you see an
> > overflow (or underflow) ?
> 
> You're correct that the overflow affects only lm99. But why we should
> ignore it?

That isn't the point. The point is that you claimed there would be a
generic underflow, which is not the case. That means we'll only need
to apply the fix to the lm99 specific code (which unconditionally
subtracts an offset from the provided value, causing the underflow).

Anyway, thanks for alerting me to the issue. As it turns out, there are
other underflow issues in the driver. With improved module test scripts,
I get:

Testing lm90 ...
temp1_crit_hyst: Suspected underflow: [min=54000, read 85000, written -9223372036854775808]
Testing lm99 ...
temp1_crit_hyst: Suspected underflow: [min=96000, read 127000, written -9223372036854775808]
temp2_crit: Suspected underflow: [min=-112000, read 143000, written -9223372036854775808]
temp2_min: Suspected underflow: [min=-112000, read 143875, written -9223372036854775808]
temp2_max: Suspected underflow: [min=-112000, read 143875, written -9223372036854775808]

So we'll need fixes for lm99 temp2_{min/max/crit} and for temp1_crit_hyst
(the latter affects all chips supported by the driver).

Thanks,
Guenter
