Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4507434E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 04:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388865AbfGYCax (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 22:30:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34102 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388772AbfGYCax (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 22:30:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so22778607plt.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 19:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z8Xo9F35Jnjc9XijZCcQ2rozL9xIXtmpcSL+K8PquAE=;
        b=mcGQh8NXcdBWu+xz3Gs/fefZAaR45ySwQq5ksz1Qk66f21qrMjSw+hhnQLd4PMLvVm
         K13LBdP8SDpQBZX9ewSOSLZ5QOHv6ZruKGrlTEMfrSRyfa4e7Q7+5yGsN/WQNFJhV8t7
         rmlwE1EQ93ETmdl7DM5hKnF281cbyZwDOG/r5qnr4u73daGEmENzLpRErgotT9gtUYHS
         jN8MPYVUC9SCME4FkR8B0ZTTzExFg75UyYJA1ocZ0pYqfU4ngMdCAhcpI63ZM96Pc47F
         ahxU51/X64iCjjKASFCbe1/3LGT5GL4Q7TmEn9QDxeQhaEV1wrzz+IBB6QSFDxrhtlZf
         rSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z8Xo9F35Jnjc9XijZCcQ2rozL9xIXtmpcSL+K8PquAE=;
        b=rf572dWiuMg1qrYpZHPah5LCQu/Z1G+3VNqEjgCpHCKozTlU671lwbgtgrNJxBd3/N
         iiw2+VAdyrYhapSyIBxFN+HK+vFYU4TBPOPxeoLW123qfx2tAlxlZU9eKr5IcFskZiWC
         tZ+6aT6z+YYJziUqMXvUODWyAlgnIFT/5F8+8ZkhryMKBdXcj+ccrFRRq2yle70EvQdi
         kCdtIQitfe9zv67wUFqRhiXAbX3QiIO8uQLtEikInU772Ctp9s6bYLpwnNgj7IRzEa2T
         C1CInaRg16GkaZgvCgX7sI1tf+G9Y9N8GsVFzP2EEnyWsN2We5SSqRIBHmkQ1MaFv6+r
         PYdA==
X-Gm-Message-State: APjAAAWnvUTXScg+BXkTD6dN/FTKaodnTKvzP/OdaI7hd1omFUHlTU8W
        s9V5IPKkpyrS8S5j6BYnSP+8aA==
X-Google-Smtp-Source: APXvYqyQ+Idaqp2XOKlh2A+59UT3l7Es0V6fP+GpNTh+LEvHX5XPNjpHbZckqg4+pj1buEP+J8OsZA==
X-Received: by 2002:a17:902:e40f:: with SMTP id ci15mr88979000plb.103.1564021852454;
        Wed, 24 Jul 2019 19:30:52 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id 35sm49333089pgw.91.2019.07.24.19.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 19:30:51 -0700 (PDT)
Date:   Thu, 25 Jul 2019 08:00:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Add required-opps support to devfreq passive gov
Message-ID: <20190725023050.7ggjbwsthoxpkexv@vireshk-i7>
References: <20190724014222.110767-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724014222.110767-1-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-07-19, 18:42, Saravana Kannan wrote:
> The devfreq passive governor scales the frequency of a "child" device based
> on the current frequency of a "parent" device (not parent/child in the
> sense of device hierarchy). As of today, the passive governor requires one
> of the following to work correctly:
> 1. The parent and child device have the same number of frequencies
> 2. The child device driver passes a mapping function to translate from
>    parent frequency to child frequency.

> v3 -> v4:
> - Fixed documentation comments
> - Fixed order of functions in .h file
> - Renamed the new xlate API
> - Caused _set_required_opps() to fail if all required opps tables aren't
>   linked.

We are already in the middle of a discussion for your previous version
and I haven't said yet that I am happy with what you suggested just 2
days back. Why send another version so soon ? The next merge window is
also very far in time from now.

Please wait for a few days before sending newer versions, I will
continue discussion on the previous version only for now.

-- 
viresh
