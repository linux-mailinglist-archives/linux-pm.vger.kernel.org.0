Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7BCD632C9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 10:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfGIIRo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 04:17:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45065 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfGIIRn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2019 04:17:43 -0400
Received: by mail-oi1-f194.google.com with SMTP id m206so14706749oib.12
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2019 01:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0ZGvGKT5pFbjF0ovjZNSbMltnKAbap8hhJEgalvESs=;
        b=spytujQDnnSEXfB2bBS/bg/n8yFvKPIdZ6rAOZcGJYqYBcpIh7+IuwjdIcO4zhNzo6
         Zy/g71h5102m1GHIvAGXSI/SQc2BDRDuwrya+jSC6kYTl2OOiwVZyXKbqFVfj2pE+Qn8
         aOIHy/tOlOWLrheIs2KxnIjpouczH8GJhECQJd+pR8LxArY2FiVatDYrQE/jUJzHeHeT
         QjlTXMAsC2gMx8cdj3l6UwvIhcFLVTfafEFlK0t5yqc20OzLeychHGy4yDz2vVgKhtFz
         eKMuC6E/T53HsMThAm7fTDYR8HeQPN6lCZFy3zQtiRrbYyQuIWiAX4MIMXfPw6uMdV34
         6ymg==
X-Gm-Message-State: APjAAAXrLYKfN7r1R9chAq88pguzX3cE58SGhYncFYboG4eUSddy/aXS
        +iKn0QmvZNXlrMvYJkkkrisIcjjH2LTl2kUfQUI=
X-Google-Smtp-Source: APXvYqzTEH1imUMQsvlhyTKpjprNG8XGh7ZVrc0bkI/a4ADsxK8i5Q/EeMnXbwPglLXm+4HPoXwTwOJam1wpx4scWLs=
X-Received: by 2002:aca:4e89:: with SMTP id c131mr12094830oib.57.1562660263187;
 Tue, 09 Jul 2019 01:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190708231725.11353-1-prarit@redhat.com>
In-Reply-To: <20190708231725.11353-1-prarit@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Jul 2019 10:17:32 +0200
Message-ID: <CAJZ5v0j4fsqK=AwqtytDM-T-HwcsCzmyGamQ3ZOMNZngh=2oeQ@mail.gmail.com>
Subject: Re: [PATCH v2] tools/power/x86/intel-speed-select: Add .gitignore file
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Arcari <darcari@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 9, 2019 at 1:17 AM Prarit Bhargava <prarit@redhat.com> wrote:
>
> Add a .gitignore file for build include/ and final binary.
>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: David Arcari <darcari@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  tools/power/x86/intel-speed-select/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tools/power/x86/intel-speed-select/.gitignore
>
> diff --git a/tools/power/x86/intel-speed-select/.gitignore b/tools/power/x86/intel-speed-select/.gitignore
> new file mode 100644
> index 000000000000..f61145925ce9
> --- /dev/null
> +++ b/tools/power/x86/intel-speed-select/.gitignore
> @@ -0,0 +1,2 @@
> +include/
> +intel-speed-select
> --
> 2.21.0
>
