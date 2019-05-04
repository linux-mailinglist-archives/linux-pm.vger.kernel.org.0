Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9A013715
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2019 04:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfEDC6h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 22:58:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37906 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfEDC6g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 22:58:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id w11so8280129edl.5;
        Fri, 03 May 2019 19:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//CSh60nHtBxBuafVgZ3RCY/UUkArd9hTjAQpDmS2Sg=;
        b=bkz5BjK1JnDEIe6wS3P4DoAgGwZL9JLKBqjTLtxvUw1P5SVwxbH3uH11BTA3oP5XYL
         9xNJZeq7dW0knAi4O2p+pI/xx1X7aiaKA5DmFQ1uL+NsEPvTq1k7ruPjJx3gtHKc+tJf
         VrdIEuaz4LeL9jYnZwdFMWCK2eeJ/YoZbi+EM/j1jUqajc4ml+4GyALxHP707xkEWVo1
         gk4SoEWK0VcCKIHUWY9joAAqYV7Bnlzll9weY/wQ+lmT0YC9HIeC5Egx35dP4mB2j5H0
         8VADFVv9cTEus2B7CFS8VmmYnOW+jZg/cFkO86ndw4yw6W7F5biFi4qXTJ5lXPiBWeLx
         gdkg==
X-Gm-Message-State: APjAAAXhjyJ3ph2dTiuLOk4No6gXXxQimhvzi7brmYCjjCqC+LnpGqhF
        lgU1R503UN1yAzrsv6JCCFPluZ6lAXaKW/xTNlpXnw==
X-Google-Smtp-Source: APXvYqwbRWk7yLYYpIV+4HB2tLPfMMAWCqNGgOhqm8u01ZpkdD0KNPNLDRxULWgh/7PestYUh2WsYrsSKqg56YTJamg=
X-Received: by 2002:a50:b513:: with SMTP id y19mr12635968edd.100.1556938714973;
 Fri, 03 May 2019 19:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
 <10af238e4f996ccfc0ecf8baedca04df0c65c7c1.1556657368.git.len.brown@intel.com>
In-Reply-To: <10af238e4f996ccfc0ecf8baedca04df0c65c7c1.1556657368.git.len.brown@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 3 May 2019 22:58:23 -0400
Message-ID: <CAJvTdKk8n3EVZ2WKZHsUvyyvw1cF1tD4GPjqqGxueFbCvAsZ5A@mail.gmail.com>
Subject: Re: [PATCH 13/18] hwmon/coretemp: Support multi-die/package
To:     X86 ML <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 1, 2019 at 12:24 AM Len Brown <lenb@kernel.org> wrote:
>
> From: Zhang Rui <rui.zhang@intel.com>

> @@ -732,6 +732,7 @@ static enum cpuhp_state coretemp_hp_online;
>  static int __init coretemp_init(void)
>  {
>         int err;
> +       struct cpuinfo_x86 *c = &cpu_data(0);
>
>         /*
>          * CPUID.06H.EAX[0] indicates whether the CPU has thermal

FYI, the hunk above was errantly left over from v2 and included in this e-mail.

It is removed in git.
And that is the only difference between this e-mailed series and my
latest git tree.

thanks,
-Len
