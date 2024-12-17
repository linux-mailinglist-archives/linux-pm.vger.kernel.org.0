Return-Path: <linux-pm+bounces-19394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 008FA9F572E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 20:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C3EE7A60F2
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 19:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6C51F9F5D;
	Tue, 17 Dec 2024 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKH7odhH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90AA1F942E;
	Tue, 17 Dec 2024 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464776; cv=none; b=guN23yUtFNQVW99MKg0Kmgo4Y9Ynadh1tIAVIfFKFTaTirv25JckGqm61qlf5nrJBesm5+nYZnlSAO4dmWuIPyJ9ewYOD+VgxgPxBJ++oC0IUSD5+mXHC8jQj297cvQqHnGryR7e6FxaHjX1/CfCpBNuCrvpI4UpR8pKRhLSydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464776; c=relaxed/simple;
	bh=xAgQ6NxynbC4P6G9Ez5bgi51XEoJp9xCovFVvuAdqd8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=kGNoDZBZOO4rw06Ipr+QDREn/eWIQ5RD6ScB6Dz/xag6vNukaS1NhrWKFxvSQfWoSYnYZCYlz7QbHdZFfrFH2Y4//HbVPXSc9B83kpQNKkDu/2GMfbQjoISFHI/+QdSoibji6KNicqFVajOmUXNoJrB1ZhGsddhSU1dCRHwC1Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKH7odhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3E3C4CED3;
	Tue, 17 Dec 2024 19:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734464775;
	bh=xAgQ6NxynbC4P6G9Ez5bgi51XEoJp9xCovFVvuAdqd8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=LKH7odhHR9cuSRQmvBoCLlJnlIaxOAdlZp0OC+Pjjqhhbs65owAjbdS2gg8uiBxGM
	 NTs5HNra7EqDgsvCamOaA23xSAlZzZyGwrQ60S5IwFaLUpjq85LZH5ycUkp6zwy45d
	 j8HsoJ+g6Nql/mp87bm/aUl4WV6cyEb4ODPmj6q4oRzYlMvvqMj7zeaGPmTcqxLm9X
	 23rXiKVbKlPa7TtnGfl/KjncEh9bUYTcUmHjnpMeuHrOit+/I0MMBjSz9Rfg7Phsr+
	 XTh0BmHwkmRLi02FAuP/JiW2Z7JqdELB3o7Q4NF/8LJ8RfN9T0l/q2gDxeDfXdNjSj
	 odzZcRStdv6ag==
Message-ID: <b3fbe9aa24bce4f99e864b81ae8ec440.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241205-qcom-cpufreq-clk-fix-v1-2-de46c82e0fe5@linaro.org>
References: <20241205-qcom-cpufreq-clk-fix-v1-0-de46c82e0fe5@linaro.org> <20241205-qcom-cpufreq-clk-fix-v1-2-de46c82e0fe5@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: qcom: Implement clk_ops::determine_rate() for qcom_cpufreq* clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>, Rafael J. Wysocki <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Xiu Jianfeng <xiujianfeng@huawei.com>, manivannan.sadhasivam@linaro.org
Date: Tue, 17 Dec 2024 11:46:13 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Manivannan Sadhasivam via B4 Relay (2024-12-05 08:50:29)
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>=20
> determine_rate() callback is used by the clk_set_rate() API to get the
> closest rate of the target rate supported by the clock. If this callback
> is not implemented (nor round_rate() callback), then the API will assume
> that the clock cannot set the requested rate. And since there is no paren=
t,
> it will return -EINVAL.
>=20
> This is not an issue right now as clk_set_rate() mistakenly compares the
> target rate with cached rate and bails out early. But once that is fixed
> to compare the target rate with the actual rate of the clock (returned by
> recalc_rate()), then clk_set_rate() for this clock will start to fail as
> below:
>=20
> cpu cpu0: _opp_config_clk_single: failed to set clock rate: -22
>=20
> So implement the determine_rate() callback that just returns the actual
> rate at which the clock is passed to the CPUs in a domain.
>=20
> Fixes: 4370232c727b ("cpufreq: qcom-hw: Add CPU clock provider support")
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Closes: https://lore.kernel.org/all/20241202100621.29209-1-johan+linaro@k=
ernel.org
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

