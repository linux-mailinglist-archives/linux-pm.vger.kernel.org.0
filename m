Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C567274631
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 18:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgIVQH1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 12:07:27 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:34306 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgIVQHW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 12:07:22 -0400
Received: by mail-oi1-f177.google.com with SMTP id n2so21610111oij.1;
        Tue, 22 Sep 2020 09:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZiwJUvaSFlx1/asaLqqaBoYnVyJQN8NlMctLP6sQWeI=;
        b=ZMz9v5xA8TVx2zZBaR3m2xkOup0Vv9gzKp76KWuH7cyPAWdzBVyqE76VcBREsSKbS9
         XmhZ600llBmB+h/Cv05NIo6QuOmUXiTucDm1E++JQnEC87asbviEy4PxfnzRzeKbfdZn
         /NIXVT9sUS1AYNvW/aR3U/w84REidm68dPj3a5fXEWUJ6ds+2Jmv+9WBp2q6lrSA6Zy5
         kWWkN66dnPNZgPj3LiLg0thz4Oxl22edJ2I6oBfWV/O7NMujTfi5rDtBPrf/ni2qv7dg
         Moc5VeVa9vyI+PZ7F6IGAHIY84QBGe/F/Zm5XmnLtK6ZshXvthHIpyiDc8iUcEG+SNZy
         mXlg==
X-Gm-Message-State: AOAM532H3MJ1cgbhYPyhSCrtrL6wu6SMlCMivU5fyEKRLBlabIyx7T9J
        Vnd6vb2noTVMCHDj8Xq8gy7MVreWiLu8akowPZ4=
X-Google-Smtp-Source: ABdhPJxniD6JhtDmzvKhIf9BQHPSO3ocEi0tmyadGh6S4OPjujF2AkUQ/mnGSl9/ss0LzTuZEVN3FJdLQIyu7oP73Fo=
X-Received: by 2002:aca:5b09:: with SMTP id p9mr2965041oib.68.1600790842017;
 Tue, 22 Sep 2020 09:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200915032629.1772569-1-liushixin2@huawei.com>
 <20200915031714.GA670377@yoga> <7hwo0qdeun.fsf@baylibre.com>
In-Reply-To: <7hwo0qdeun.fsf@baylibre.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Sep 2020 18:07:10 +0200
Message-ID: <CAJZ5v0hbTH0_Lfkoed54=+PU87MHwTrmMkf_HVW1vNAig-M2jg@mail.gmail.com>
Subject: Re: [PATCH -next] power: avs: qcom-cpr: simplify the return
 expression of cpr_disable()
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Niklas Cassel <nks@flawful.org>,
        Andy Gross <agross@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 18, 2020 at 10:12 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Bjorn Andersson <bjorn.andersson@linaro.org> writes:
>
> > On Mon 14 Sep 22:26 CDT 2020, Liu Shixin wrote:
> >
> >> Simplify the return expression.
> >>
> >> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> >
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> Acked-by: Kevin Hilman <khilman@baylibre.com>
>
> Rafael, please apply directly.

Applied as 5.10 material with minor edits in the subject, thanks!
