Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D783D913DD
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 03:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfHRBGY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Aug 2019 21:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfHRBGX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Aug 2019 21:06:23 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 327B021019;
        Sun, 18 Aug 2019 01:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566090383;
        bh=LhaIiMn1P8CAyuogHy1jmpo4mGnse2SYL3+tuNzicc8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=xM4Ji/bnasWq768I1fc5JrCUZFNXOUY+GA43yEMn+339aFhEnSxfwyLtcYpRs6V66
         PByQkKAdEnEaJHiKo/6VrgTQV7/lc8HtscyLDdysiIpFoJd/+udhzJk0AMpwl7CIA/
         DAe7jxjM+rF6BiqRMDe747z/4UpD01WBPsodbdoc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190725104144.22924-4-niklas.cassel@linaro.org>
References: <20190725104144.22924-1-niklas.cassel@linaro.org> <20190725104144.22924-4-niklas.cassel@linaro.org>
Subject: Re: [PATCH v2 03/14] cpufreq: qcom: Re-organise kryo cpufreq to use it for other nvmem based qcom socs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Sricharan R <sricharan@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
User-Agent: alot/0.8.1
Date:   Sat, 17 Aug 2019 18:06:22 -0700
Message-Id: <20190818010623.327B021019@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Niklas Cassel (2019-07-25 03:41:31)
> From: Sricharan R <sricharan@codeaurora.org>
>=20
> The kryo cpufreq driver reads the nvmem cell and uses that data to
> populate the opps. There are other qcom cpufreq socs like krait which
> does similar thing. Except for the interpretation of the read data,
> rest of the driver is same for both the cases. So pull the common things
> out for reuse.
>=20
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> [niklas.cassel@linaro.org: split dt-binding into a separate patch and
> do not rename the compatible string. Update MAINTAINERS file.]
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Reviewed-by: Ilia Lin <ilia.lin@kernel.org>
> ---

FWIW

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

