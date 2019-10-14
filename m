Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B45D5F3E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 11:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbfJNJq5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 05:46:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36551 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfJNJq5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2019 05:46:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id y189so15319459qkc.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2019 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lu3kAKNgLKj0l9OS9STf244o7FzKM+AFq67sW2GGwEA=;
        b=Uj1L73BBDeBKogOWy6V6kJudrhezS8moRSdpCrLY3eY9sVevqZAlfZAlmZMNsqrlct
         4XIovLTXE+6nSTwfashjKKTW2PVQ/K6PU9icsADDq339H5d7jT31VyzFjtJW2asPwsdy
         L0M1pcSU3zUIQdwuXVKawprh1KTIZUtoQ3cjK3vibIrgNXXCjY6G3ttf0De5NBBY/l/+
         zPX+pEWj3G8AeMRPKsUZgjzkpJoQt63L+nEAhoMwyIOucJftx3nzAQM2WdBUWdOGHzUk
         02Kki+LBpQ/Y4lBCVMqlH5sWxGCAMWbYXCuRwD3gng7oQwVM+7Wdj3gVhhP4tao3K1NB
         MfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lu3kAKNgLKj0l9OS9STf244o7FzKM+AFq67sW2GGwEA=;
        b=Au2Hq9766RXVrt2OZv0gGtzxUHWCODIQ3R9vQN7WIgNEmOukUtiEIj2+f3d6Sx1Pj4
         66Pz4a1O/+TvF6TFV0znByIQQa191GEfD7xeBmauWn4quY2eiIrnHheoSy/EXSN16M2E
         TsV8puPI2atyElsnOjElUeZRdlQKM1ShX9Je2s0UajPm04zwnJKMVrXRlwMW868Dja3Z
         Ow11rx5IW04mcZsCiJFDdoBdwOIJWa8eA8Qlk9xGRZPvscnEjcITZ1wui0A//XmkZUMC
         8rPL04FAjLZaX/NnW3ehNiWjVmdOrQoP46+XnLe7zmXUyWhQk+Ots4t4tcY6Qb5bq8xU
         ifiw==
X-Gm-Message-State: APjAAAWj8mTxe974FTbfR0OS5X1QYyTHhTrmaxpEZZXgJJp2QBCwF9TM
        WU0KedIW/axHZR8XuBLSg6NBtQyR9TcCvDdOq06zFQ==
X-Google-Smtp-Source: APXvYqyX4BdAfaAii4xGwBuVXmFyQ/mTRTffh56bnScOrXrCBjFUMfh4PyZVxGpBJtJERVnMwTOvmNlFux+g2AOjz0g=
X-Received: by 2002:a37:883:: with SMTP id 125mr28347719qki.478.1571046415923;
 Mon, 14 Oct 2019 02:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190927090202.1468-1-drake@endlessm.com> <261805141.5tZyQaKU0z@kreacher>
 <CAD8Lp46NF8rq55g0Mz40Mmz1+KzqrTzziK3oYcmfh=1RUCRzug@mail.gmail.com> <4883845.KNzyzeMIEj@kreacher>
In-Reply-To: <4883845.KNzyzeMIEj@kreacher>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 14 Oct 2019 17:46:44 +0800
Message-ID: <CAD8Lp44TYxrMgPLkHCqF9hv6smEurMXvmmvmtyFhZ6Q4SE+dig@mail.gmail.com>
Subject: Re: [PATCH] PCI: also apply D3 delay when leaving D3cold
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 14, 2019 at 5:22 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> While I still think that both the system resume and runtime resume code paths
> should be as similar as reasonably possible, the above needs to be taken into
> account IMO, so it is better to retain pci_pm_default_resume_early(), but make
> it do a conditional "ACPI power state refresh" and then call
> pci_restore_standard_config().
>
> So something like the patch below (can you please test it too?).

This is also working fine, thanks for your help!
