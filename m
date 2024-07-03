Return-Path: <linux-pm+bounces-10417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C74924F0E
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 05:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7431C209CF
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 03:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC4738DC7;
	Wed,  3 Jul 2024 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/oFHSCo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6DCA6F;
	Wed,  3 Jul 2024 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719976090; cv=none; b=suqEZBHaoD1+h/Ocua2JvN8BVF0u1nwhS8JJ9YjRQb5cGR24MeF1kZAadbZuoBbxrANX8aA0owqgPW1PU1mHvLid0EQB+p7Lt3G0/Pk9cvVKiuRCNqsMObv0AH+Pze7SQ/9JCMVmgnLw5Row8OEx44wjZyBHu0o4LeIY/yjM4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719976090; c=relaxed/simple;
	bh=dwDIrNX1cXKYArj3wRoS4iZ6/Bs4bEiF2Y8U9tZ8r6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2t3zdtA4QK22ehSysXZ47LzAUpOhqj5jXE3SMwoshP6hpq0qMVdsoBflq8Rs87edUrr9BV7+99ImgmAeTo07g0fivJpk/Ey/61jKi+NnadRfASShIPt5gFTiVTT/PEmm2qmHbZhxhdfUrEMJ0DHColshYSifkRitKtQQNWTp/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/oFHSCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD17C116B1;
	Wed,  3 Jul 2024 03:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719976089;
	bh=dwDIrNX1cXKYArj3wRoS4iZ6/Bs4bEiF2Y8U9tZ8r6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/oFHSCoJEnDLxJkAZ6Onvt0Es6AN7qxhTaONKom9VEl5sLem3MUXycwMJ6bSoMNn
	 QpvA2xc6tastla97sPLDnW32LOLBXN2TFeTUFmxfKS378dD4RgZZgUD40HlcIwtZaJ
	 3hJxkOlFhbfhGxx0Zl6wNdUo8kibm2PhwCyUhG9g+lrO2RD1SIZvH0lqJIvgygj4sE
	 t9jpjovm2eX5wbMVggfBnfOaQNEW6mG8iQBNXeTn6J+jkb9+6epgmxBN6HD7rn+xno
	 AFZAkg7wV/QWK+tRsIpPh6+9pq3eJvQbChjhzMY+LUMHD+t53SJq+mj454LyL09G+M
	 8tlT8vnDjkBDw==
Date: Tue, 2 Jul 2024 22:08:05 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, linux-pm@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Ajit Pandey <quic_ajipan@quicinc.com>
Subject: Re: [PATCH V7 3/5] clk: qcom: gdsc: Add set and get hwmode callbacks
 to switch GDSC mode
Message-ID: <7mzxt3h3pohxczatfsvqxtxvptdy6ooq76mq7ylywzkqncjkvs@aap4wnoo6j3p>
References: <20240624044809.17751-1-quic_jkona@quicinc.com>
 <20240624044809.17751-4-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624044809.17751-4-quic_jkona@quicinc.com>

On Mon, Jun 24, 2024 at 10:18:07AM GMT, Jagadeesh Kona wrote:
> Some GDSC client drivers require the GDSC mode to be switched dynamically
> to HW mode at runtime to gain the power benefits. Typically such client
> drivers require the GDSC to be brought up in SW mode initially to enable
> the required dependent clocks and configure the hardware to proper state.
> Once initial hardware set up is done, they switch the GDSC to HW mode to
> save power. At the end of usecase, they switch the GDSC back to SW mode
> and disable the GDSC.
> 
> Introduce HW_CTRL_TRIGGER flag to register the set_hwmode_dev and
> get_hwmode_dev callbacks for GDSC's whose respective client drivers
> require the GDSC mode to be switched dynamically at runtime using
> dev_pm_genpd_set_hwmode() API.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Taniya Das <quic_tdas@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/clk/qcom/gdsc.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/gdsc.h |  1 +
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index df9618ab7eea..fa5fe4c2a2ee 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -363,6 +363,43 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>  	return 0;
>  }
>  
> +static int gdsc_set_hwmode(struct generic_pm_domain *domain, struct device *dev, bool mode)
> +{
> +	struct gdsc *sc = domain_to_gdsc(domain);
> +	int ret;
> +
> +	ret = gdsc_hwctrl(sc, mode);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Wait for the GDSC to go through a power down and
> +	 * up cycle. If we poll the status register before the
> +	 * power cycle is finished we might read incorrect values.
> +	 */
> +	udelay(1);
> +
> +	/*
> +	 * When the GDSC is switched to HW mode, HW can disable the GDSC.
> +	 * When the GDSC is switched back to SW mode, the GDSC will be enabled
> +	 * again, hence we need to poll for GDSC to complete the power up.
> +	 */
> +	if (!mode)
> +		return gdsc_poll_status(sc, GDSC_ON);
> +
> +	return 0;
> +}
> +
> +static bool gdsc_get_hwmode(struct generic_pm_domain *domain, struct device *dev)
> +{
> +	struct gdsc *sc = domain_to_gdsc(domain);
> +	u32 val;
> +
> +	regmap_read(sc->regmap, sc->gdscr, &val);
> +
> +	return !!(val & HW_CONTROL_MASK);
> +}
> +
>  static int gdsc_init(struct gdsc *sc)
>  {
>  	u32 mask, val;
> @@ -451,6 +488,10 @@ static int gdsc_init(struct gdsc *sc)
>  		sc->pd.power_off = gdsc_disable;
>  	if (!sc->pd.power_on)
>  		sc->pd.power_on = gdsc_enable;
> +	if (sc->flags & HW_CTRL_TRIGGER) {
> +		sc->pd.set_hwmode_dev = gdsc_set_hwmode;
> +		sc->pd.get_hwmode_dev = gdsc_get_hwmode;
> +	}
>  
>  	ret = pm_genpd_init(&sc->pd, NULL, !on);
>  	if (ret)
> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> index 803512688336..1e2779b823d1 100644
> --- a/drivers/clk/qcom/gdsc.h
> +++ b/drivers/clk/qcom/gdsc.h
> @@ -67,6 +67,7 @@ struct gdsc {
>  #define ALWAYS_ON	BIT(6)
>  #define RETAIN_FF_ENABLE	BIT(7)
>  #define NO_RET_PERIPH	BIT(8)
> +#define HW_CTRL_TRIGGER	BIT(9)
>  	struct reset_controller_dev	*rcdev;
>  	unsigned int			*resets;
>  	unsigned int			reset_count;
> -- 
> 2.43.0
> 

