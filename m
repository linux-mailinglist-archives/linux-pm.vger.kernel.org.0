Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E5334ACB2
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 17:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhCZQnB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 12:43:01 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:35396 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhCZQmn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Mar 2021 12:42:43 -0400
Received: by mail-oi1-f170.google.com with SMTP id x2so6295369oiv.2;
        Fri, 26 Mar 2021 09:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyvsq45iIYu4n93ieWOlkWUljRTFCA4DQNS3yBXQfKM=;
        b=kyvgKzmLgJ8gsSF8GizNTxcJh3OZF64OxqY+EqggQ6OSapLYJnunWfZ2uB/vCZNOn1
         bcrqgK55x1JVfUiPoDkpcIie88S4mQeXJIjQK1Vao0WRqxCeKadRPspNg90fQwiC+KV+
         bL9nHuoN/B+v6nJzR0wjOSf97AjVHcfHfwwqXwUz80Hv2CaG2qVGa7PnSc5D64i7Ulb7
         7tBkzbWIY/mkovO+JQwvHyOlItGDMgfMEJRmTYJ7S3i+npnsL9FpQByK5QJx4CYpcRNA
         kS9qeBE/z8yd04EIw8y/Ob1MM8RaSK5vRcjMIAWHajGKObGwMSWTxNG7ZRY2YaDvJhoR
         FIxg==
X-Gm-Message-State: AOAM532K1dwqX5mjkgK7bO2ehfZfiq+zXdkYffY2yifga6jSDAb9BVZR
        9BAzBcFVEAuF+bgJ3VeNLzYNLefuC0y4aKgR0XM=
X-Google-Smtp-Source: ABdhPJxoTgDJotLw06IjDrlficQWWmnwrKPiGy2g78XNSAFktbfrj1mFdmYZqikxqfbrJg/h2sXJF5wX3dWAOZyMTxY=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr9953234oib.69.1616776963249;
 Fri, 26 Mar 2021 09:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210326105619.27570-1-adrian.hunter@intel.com>
In-Reply-To: <20210326105619.27570-1-adrian.hunter@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Mar 2021 17:42:32 +0100
Message-ID: <CAJZ5v0hf8pfpovgn7pjL1bwUdScP_5=QwUjv3XwgY7fF2EN6kw@mail.gmail.com>
Subject: Re: [PATCH 0/2] PM: runtime: Fix race getting/putting suppliers at probe
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 26, 2021 at 11:56 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> SCSI UFS is starting to use device links for power management but
> has run into issues. Here are 2 patches that seem to help.
>
>
> Adrian Hunter (2):
>       PM: runtime: Fix ordering in pm_runtime_get_suppliers()
>       PM: runtime: Fix race getting/putting suppliers at probe

Both look good to me, so queuing them up for the next 5.12-rc, thanks!
