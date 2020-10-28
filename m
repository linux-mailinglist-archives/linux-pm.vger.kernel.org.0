Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A3C29DACF
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 00:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390101AbgJ1Xc6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 19:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbgJ1Xc5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Oct 2020 19:32:57 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C0FE207BC;
        Wed, 28 Oct 2020 23:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603927977;
        bh=kuucGMnUYKQNkrUGdSAOSrFVV9tKdC9VMLt9lSaC1xo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iYRqfEug23UYUTFOmnbUhJp+n8AxJjw91pqACy2XjfvqlxqErHHl2Q6rQwX2Ecr2F
         yliMD+EV/m/sfo1NCIa3KJvZrCPNcRnvtYwMtPnSGPJY+93ie4q79w5FmtdIWTKG6Q
         KGAL6YMQOQmU54OXkUWuNZHJiAgs4iRnbg2fbsY4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e0df59de670b48a923246fae1f972317b84b2764.1603785323.git.viresh.kumar@linaro.org>
References: <e0df59de670b48a923246fae1f972317b84b2764.1603785323.git.viresh.kumar@linaro.org>
Subject: Re: [PATCH] opp: Reduce the size of critical section in _opp_table_kref_release()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
To:     Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>
Date:   Wed, 28 Oct 2020 16:32:55 -0700
Message-ID: <160392797572.884498.11353243518476305974@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Viresh Kumar (2020-10-27 00:57:06)
> There is a lot of stuff here which can be done outside of the big
> opp_table_lock, do that. This helps avoiding few circular dependency
> lockdeps around debugfs and interconnects.
>=20
> Reported-by: Rob Clark <robdclark@gmail.com>
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Any Fixes tag?

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
