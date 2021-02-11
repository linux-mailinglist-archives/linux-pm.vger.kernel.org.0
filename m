Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94CE3192FC
	for <lists+linux-pm@lfdr.de>; Thu, 11 Feb 2021 20:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhBKTUR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Feb 2021 14:20:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhBKTUQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 11 Feb 2021 14:20:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82CE364DEC;
        Thu, 11 Feb 2021 19:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613071175;
        bh=/Xi5MgzQdyZzamI/PYQu74aK/EMKSW4dbTMwe8emdRI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=I9MMM+gv/OcX4WiiksCAigl0oEaKW7w5jaSK6eFRSTv1YMO7r1nCas/LlK4vx8TNX
         HYt66sDs0VBk71HbnchLSXxXhvvptGfPxnklIiLBayqmReaRVGag1dRYRpwf699Nr+
         klddIUZpFFmWcnKo9P8QIfe7y1sLCeO+m3lyBM7uunTrr14FvChVpAX9X64WkOISPP
         Xk2+DYRDtb3vmwhGrNFwlmIYQgd1wadaWHcHp19IL7Jl8XxXwXLvLm5x8B3kAmAo3V
         oShgCsJGChbU1Ki/aywbmw6Pcl+6nK8KzgRUYQl0YEvXqRFa/P3Ilegd0E9aAqzx3o
         Cl6OWW7Kwc5UQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <61854037cd4d3ac367cfda3f02fd1557b1b3bb8b.1612153322.git.viresh.kumar@linaro.org>
References: <61854037cd4d3ac367cfda3f02fd1557b1b3bb8b.1612153322.git.viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] opp: Don't ignore clk_get() errors other than -ENOENT
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
To:     Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>
Date:   Thu, 11 Feb 2021 11:19:34 -0800
Message-ID: <161307117419.1254594.16016042022739644084@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Viresh Kumar (2021-01-31 20:22:58)
> Not all devices that need to use OPP core need to have clocks, a missing
> clock is fine in which case -ENOENT shall be returned by clk_get().
>=20
> Anything else is an error and must be handled properly.
>=20
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - s/ENODEV/ENOENT
> - Use dev_err_probe()
>=20
> Stephen, is the understanding correct that -ENOENT is the only error
> returned for missing clocks ?

Yeah pretty much. See clk_get_optional().
