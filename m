Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E80C3DFB
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 19:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfJARDr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 13:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731929AbfJARDq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Oct 2019 13:03:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 555DB2086A;
        Tue,  1 Oct 2019 17:03:45 +0000 (UTC)
Date:   Tue, 1 Oct 2019 13:03:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PM / Domains: Add tracepoints
Message-ID: <20191001130343.4480afe3@gandalf.local.home>
In-Reply-To: <20191001163542.GB87296@google.com>
References: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
        <20190927044239.589e7c4c@oasis.local.home>
        <20191001163542.GB87296@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 1 Oct 2019 09:35:42 -0700
Matthias Kaehlcke <mka@chromium.org> wrote:

> How about this instead:
> 
>   Add tracepoints for genpd_power_on, genpd_power_off and
>   genpd_set_performance_state. The tracepoints can help with
>   understanding power domain behavior of a given device, which
>   may be particularly interesting for battery powered devices
>   and suspend/resume.

Do you have a use case example to present?

Thanks!

-- Steve
