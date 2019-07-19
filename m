Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0850E6E1F6
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 09:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfGSHvw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 03:51:52 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:41245 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGSHvw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 03:51:52 -0400
Received: by mail-ot1-f45.google.com with SMTP id o101so31852764ota.8
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 00:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NshTXyOQJzW6SDdKntKrdHR5W2BVDC5UGM/Gomp7Bs=;
        b=TakyH7l4kqtg5/RgoB7yVfJBcCAv4YppNbLbaEJ+pEAkJIOO+Ng4YE7v49H9r5iUoJ
         HqPVrAXqWN4cnHEc7HB+6GQIRfj93/pz+FP7YoA1JUXqCMYNwLP+MSHTaYKKXaKghi3w
         h8GEX7dye7KVzFpdkqOCP/5AU9hheL59vvFxVX4gD2aNNKQdIFMULj3ACSqp66/dpOlF
         bqLcUlh0hZ0j+DnIaWNS/kBamGdkXg+4OENk8fGNj3L7a8VIsYuNLG0bH2oBJoz+2OkN
         wgIZ8k2ucI93B6vWjR/cWoFI5h1iCfeTYkj6T0FTbzk+QeUzJhFZZPGKa5qJXohw+dU/
         3qTg==
X-Gm-Message-State: APjAAAV2rHBarONJkckFC0teIBh3+I+IBrxV/jXbJFKqG63FKfptmaxG
        UD4QtGa4iil82+agT1DvVR8a2xMdDiMqhQ5Ph3o=
X-Google-Smtp-Source: APXvYqyoAtIK3e6TddqsCJQrlP8gNzulQPQQsZBGq8J7bcSMt7+HmU/H/6pQszgeDN/qNphRf7A9EvBuMwrk7lIQKmg=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr38756644otq.262.1563522711798;
 Fri, 19 Jul 2019 00:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907181955330.2769@hp-x360> <1563514893.2433.3.camel@intel.com>
 <alpine.DEB.2.21.1907182308321.2769@hp-x360>
In-Reply-To: <alpine.DEB.2.21.1907182308321.2769@hp-x360>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Jul 2019 09:51:40 +0200
Message-ID: <CAJZ5v0jYdV3esYfj9Yc2NRkdTFNdDvFnuuOe-rTwFQFhFvRH=g@mail.gmail.com>
Subject: Re: [Fwd: Commit 555c45fe0d0 ("int340X/processor_thermal_device: add
 support for MMIO RAPL") boot failure]
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 19, 2019 at 8:32 AM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> On Fri, 19 Jul 2019, Zhang Rui wrote:
>
> > Are you using the latest Linus' tree today?
>
> Yeah, Linus' master tree, as of the time of this E-mail (no new commits since
> mid-afternoon Thursday PDT).

So can you disable PROC_THERMAL_MMIO_RAPL in Kconfig and retest?
