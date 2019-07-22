Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F356F9AA
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 08:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfGVGtZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 02:49:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43987 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfGVGtZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 02:49:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so17175116pgv.10
        for <linux-pm@vger.kernel.org>; Sun, 21 Jul 2019 23:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XCZ14W+TeNVmxVqLLf/TFkx7EazXnv5AaEBQnQvbufc=;
        b=yOevxfIVWjZrcDxO+KBryL00uayyK6HWEH7fkamGPRW5eB8PfPlG0AX5j1ZF2Vhgyv
         unzTjje2CIg6G0LAarzCizFXun4ckE43xyEe/Gx8YK229r5M52rR+810BMQEE+0xzajW
         fi3liTZ2T9yaywVS5zmaPkhcEc5QnUFOgxNjtzgvQeMUgXsOVs+zdi9hqyzrzmNYY9Va
         FElyf0YT1i5bAFawrgYA5WXvxPTmw2KlZEbVpSK81Ja5KxoFcSv0dxaZI7k2UaTfUgph
         6AQSKM8OyUoLdHc66jqWbABtiw9Krswr/JbCR2eiigKO8QzRlRB5S6oifzYUQw5gE6n+
         4TAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XCZ14W+TeNVmxVqLLf/TFkx7EazXnv5AaEBQnQvbufc=;
        b=hT3WnSUCrWzGz1QfCiKYgBKD354i2Gi1GgPVArYz4Y7CYB57KJJIIBYcrP9Jcx4nJ/
         1RfTE2qstKuCsf1DLv7y5iSK3vL0YNstWOZDQ7CexWEHkqk0ZB41e7xb/tDVdQ1Laycs
         UwiGUbi2Qpp5O0VMECwCvnUUTk5CCG9rTsw4gy6UULzg8ileSgh0Lm4jdRUd/UsN75bU
         EWuiNsXICmjjtnfZynVyw1B7/5jshC0dK31TQzirJyzWtbjiC+cDoIVHLtyIeUEqGPxG
         aFwEjydcQ38+xYXozI3DoWio6kfvYm9euPdVip2Gr4anQF0Mpub5krmaqpg1XWK+8vRU
         ZIGA==
X-Gm-Message-State: APjAAAXRl9iZY848y8VTvc4fML72syUAzwQKJK10sftfsgpNHmISgU1t
        DLSktuScIBWzYnu86QbDmk79bGYZieQ=
X-Google-Smtp-Source: APXvYqwXRPQKIwxf5nHCeGZNiDbk2PIWyVBx4i1OejCqTFJIDu31MQqpvfOeOo9ngol9gtfFy+E8ng==
X-Received: by 2002:a63:d23:: with SMTP id c35mr69539464pgl.376.1563778164615;
        Sun, 21 Jul 2019 23:49:24 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id 35sm40151455pgw.91.2019.07.21.23.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 23:49:23 -0700 (PDT)
Date:   Mon, 22 Jul 2019 12:19:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     rjw@rjwysocki.net, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] Revert "cpufreq: schedutil: Don't set next_freq to
 UINT_MAX"
Message-ID: <20190722064921.qrjslrdnbknd5j7b@vireshk-i7>
References: <1563431200-3042-1-git-send-email-dsmythies@telus.net>
 <20190718102815.utl3hanfc7fpf2i6@vireshk-i7>
 <000001d53d7f$ee306e70$ca914b50$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d53d7f$ee306e70$ca914b50$@net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-07-19, 08:46, Doug Smythies wrote:
> On 2019.07.18 03:28 Viresh Kumar wrote:
> > On 17-07-19, 23:26, Doug Smythies wrote:
> >> This reverts commit ecd2884291261e3fddbc7651ee11a20d596bb514.
> >> 
> >> The commit caused a regression whereby reducing the maximum
> >> CPU clock frequency is ineffective while busy, and the CPU
> >> clock remains unchanged. Once the system has experienced
> >> some idle time, the new limit is implemented.
> >
> > Can you explain why this patch caused that issue ? I am sorry but I couldn't
> > understand it from your email. How are we trying to reduce the frequency? Is
> > clk_set_rate() getting called with that finally and not working ?
> 
> The patch eliminates the "flag", UNIT_MAX, and it's related comment,
> that was used to indicate if it was a limit change that causes the
> subsequent execution of sugov_update_single.

I think I may have understood the root cause. Please try the patch I just sent
as reply to this thread. Thanks.

-- 
viresh
