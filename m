Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EB3219AB1
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 10:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgGIIWQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 04:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgGIIWQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Jul 2020 04:22:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EA962073A;
        Thu,  9 Jul 2020 08:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594282936;
        bh=sWUPCkqH0F+VWeWXkIpSdFyGoORAipbqnBL7/L00KRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYcTEJoMoMqtKh5vR+jIJ5hb8KNVidfBziGOvLOHAIDbTZForqDLuDalCGCGaoBT/
         OEVZJIkaySQC8gihrEgIxq0hfCrpbD+GgCklkQX31yNUCyfia6JsB3XFrV+C3ma92i
         wpJM6qpxtugoTybI2It+NsuPnkfM36QdumpcWCXs=
Date:   Thu, 9 Jul 2020 10:22:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] genpd: Fix up terminology with parent/child
Message-ID: <20200709082222.GE13487@kroah.com>
References: <202007081629.0840B4CB78@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007081629.0840B4CB78@keescook>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 08, 2020 at 04:32:13PM -0700, Kees Cook wrote:
> The genpd infrastructure uses the terms master/slave, but such uses have
> no external exposures (not even in Documentation/driver-api/pm/*) and are
> not mandated by nor associated with any external specifications. Change
> the language used through-out to parent/child.
> 
> There was one possible exception in the debugfs node
> "pm_genpd/pm_genpd_summary" but its path has no hits outside of the
> kernel itself when performing a code search[1], and it seems even this
> single usage has been non-functional since it was introduced due to a
> typo in the Python ("apend" instead of correct "append"). Fix the typo
> while we're at it.
> 
> [1] https://codesearch.debian.net/
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
