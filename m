Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7338A5D8C9
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 02:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfGCA3L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 20:29:11 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37221 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfGCA3L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 20:29:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id s20so470331otp.4
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2019 17:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkNIE7aWWKzHjDuVcD24lWsEIj7twInNeM0qZhDib2s=;
        b=W5lpa5xLzUNXeHsB6sP7N3+8hOJRklTa1P5VBjV479BaOzfIea5n5nalaPgHVxRdy3
         X0QPAYuPh5q6shahL9FPBtBhguNcxWgYsQPEaDdPWUE9NcrbWqrvcAEe8YUL1HKxIAa+
         Q4hYz0r4ihtiglYTGBiHZHE08Vi3YX4X3WFiwyQl+DQnVNG28+ZqSXHWTmGNGA9SfYbO
         uwgsoh5b9vv2cuxJJUTVpusxlU2pAHI4ko9RaRx1jmLA/8H8Ne9pH0jGsEwNQxlrQOPe
         KwUo99tYwGlck7YsnW13CcV/oZUPn14jCBZu9KFF2A1nHcJ7SO9fzF0VjbZ7yxKqByBg
         jPWg==
X-Gm-Message-State: APjAAAU6MezsijV689IbBUF1AI+HjYD6VyN4awUdHQSmoESkhBZnIehm
        YJx6qpcvExprRownC8NslE4BwubcT/X8vHHPkvB48A==
X-Google-Smtp-Source: APXvYqz65q9En7j87JCLWeSIJWtKPYnmEOB/wY1aCnQncBMb1AJMpQYYpqFF6KN1yiN24Fwfj/sny78SXxfBPgzMiPk=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr8353264oto.167.1562104807817;
 Tue, 02 Jul 2019 15:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <1561701029-3415-1-git-send-email-rui.zhang@intel.com> <1561701029-3415-10-git-send-email-rui.zhang@intel.com>
In-Reply-To: <1561701029-3415-10-git-send-email-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Jul 2019 23:59:56 +0200
Message-ID: <CAJZ5v0gEW_9UaZDnJdz60e6baEYQOuG-SdZu54tswho6J+zYkQ@mail.gmail.com>
Subject: Re: [PATCH 09/13] intel_rapl: abstract RAPL common code
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 28, 2019 at 7:50 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Split intel_rapl.c to intel_rapl_common.c and intel_rapl.c, where
> intel_rapl_common.c contains the common code that can be used by both MSR
> and MMIO interface.
> intel_rapl.c still contains the implementation of RAPL MSR interface.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/Kconfig             |   11 +-
>  drivers/powercap/Makefile            |    1 +
>  drivers/powercap/intel_rapl.c        | 1427 +--------------------------------
>  drivers/powercap/intel_rapl_common.c | 1468 ++++++++++++++++++++++++++++++++++

intel_rapl_common.c and intel_rapl_msr.c, please.

>  include/linux/intel_rapl.h           |    7 +
>  5 files changed, 1491 insertions(+), 1423 deletions(-)
>  create mode 100644 drivers/powercap/intel_rapl_common.c
