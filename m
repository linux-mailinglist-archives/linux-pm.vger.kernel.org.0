Return-Path: <linux-pm+bounces-39047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28727C9A980
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 08:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFBF7347B6D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 07:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2B3305077;
	Tue,  2 Dec 2025 07:57:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100DF304BD3
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662255; cv=none; b=eeJ83WttvdZt3T8RpWNy3Ayp9ktXRzXEyVssgTvya2TaYNhUKPJ6ejfR2pYeB8M5fH6jYhXuQl2aZBHAgzWaP1zbJWZZjUqIrjxZChxX5UUM7v4e/sXf63FeDRwBof5wjfkppCdTRLjmiBJ+2ucCJPR3Vhbc55ua93e98LtgHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662255; c=relaxed/simple;
	bh=xRnByJYkV6Sz6EGG7idVjVOc+n/gNsJDkv6Rq8vLXmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw71vVO9H/09XbtNc3zecuqEP+VdRjq3Me4aBh9aimk95Mm4DkwNeGNswk8QJP7xI/ZCzpPEaP6g9HFg8IqrPvtr4669eVRmuiSx4ye+83AkMFZpF6wu0eCIv5S+05olNNTOkkUyRceWzTEe2KBNLnnuNlrh8a6NXjz9e42NxrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vQLGG-00054h-BS; Tue, 02 Dec 2025 08:57:24 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vQLGG-003Zr7-03;
	Tue, 02 Dec 2025 08:57:24 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vQLGF-001XiD-2n;
	Tue, 02 Dec 2025 08:57:23 +0100
Date: Tue, 2 Dec 2025 08:57:23 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] pmdomain: imx93-blk-ctrl: convert to devm_* only
Message-ID: <20251202075723.myevt4wa2kpyehdd@pengutronix.de>
References: <20251201-v6-18-topic-imx93-blkctrl-v1-0-b57a72e60105@pengutronix.de>
 <20251201-v6-18-topic-imx93-blkctrl-v1-2-b57a72e60105@pengutronix.de>
 <aS4ZpyhrJ1IpUCKv@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS4ZpyhrJ1IpUCKv@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On 25-12-01, Frank Li wrote:
> On Mon, Dec 01, 2025 at 06:12:06PM +0100, Marco Felsch wrote:
> > Some APIs used by this driver don't have devm_ helpers yet. Instead of
> > using the devm_add_action_or_reset() the current driver is based on hand
> > crafted error goto paths and a .remove() callback.
> >
> > Convert the driver to devm_ APIs only by making use of
> > devm_add_action_or_reset() and devm_pm_runtime_enable() to simplify the
> > release and error path.
> 
> Nit: I think keep this paragaph should be enough.

I can re-phrase it.

> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  drivers/pmdomain/imx/imx93-blk-ctrl.c | 64 +++++++++++++++--------------------
> >  1 file changed, 27 insertions(+), 37 deletions(-)
> >
> > diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> > index 2aa163aef8de4ee901b9cde76ce2aad246c8c08a..13b0de6dd689cf944e034f7666a4e97b0118e3bd 100644
> > --- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
> > +++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> > @@ -188,6 +188,20 @@ static int imx93_blk_ctrl_power_off(struct generic_pm_domain *genpd)
> >  	return 0;
> >  }
> >
> ...
> >  static struct lock_class_key blk_ctrl_genpd_lock_class;
> >
> >  static int imx93_blk_ctrl_probe(struct platform_device *pdev)
> > @@ -256,10 +270,8 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
> >  			domain->clks[j].id = data->clk_names[j];
> >
> >  		ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
> > -		if (ret) {
> > -			dev_err_probe(dev, ret, "failed to get clock\n");
> > -			goto cleanup_pds;
> > -		}
> > +		if (ret)
> > +			return dev_err_probe(dev, ret, "failed to get clock\n");
> >
> >  		domain->genpd.name = data->name;
> >  		domain->genpd.power_on = imx93_blk_ctrl_power_on;
> > @@ -267,11 +279,12 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
> >  		domain->bc = bc;
> >
> >  		ret = pm_genpd_init(&domain->genpd, NULL, true);
> > -		if (ret) {
> > -			dev_err_probe(dev, ret, "failed to init power domain\n");
> > -			goto cleanup_pds;
> > -		}
> > +		if (ret)
> > +			return dev_err_probe(dev, ret, "failed to init power domain\n");
> >
> > +		ret = devm_add_action_or_reset(dev, imx93_release_pm_genpd, &domain->genpd);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret, "failed to add pm_genpd release callback\n");
> >  		/*
> >  		 * We use runtime PM to trigger power on/off of the upstream GPC
> >  		 * domain, as a strict hierarchical parent/child power domain
> > @@ -288,39 +301,17 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
> >  		bc->onecell_data.domains[i] = &domain->genpd;
> >  	}
> >
> > -	pm_runtime_enable(dev);
> > +	devm_pm_runtime_enable(dev);
> 
> Need check return value

Missed this one, thanks.

> >  	ret = of_genpd_add_provider_onecell(dev->of_node, &bc->onecell_data);
> > -	if (ret) {
> > -		dev_err_probe(dev, ret, "failed to add power domain provider\n");
> > -		goto cleanup_pds;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to add power domain provider\n");
> >
> > -	dev_set_drvdata(dev, bc);
> 
> why remove dev_set_drvdata(dev, bc)

Because it's no longer needed, it was required due to the .remove()
callback. I wasn't sure if I should mention this within the commit
message. I'm going to add it to the commit message since you asked.

Regards,
  Marco

> 
> Frank
> > +	ret = devm_add_action_or_reset(dev, imx93_release_genpd_provider, dev->of_node);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to add genpd_provider release callback\n");
> >
> >  	return 0;
> > -
> > -cleanup_pds:
> > -	for (i--; i >= 0; i--)
> > -		pm_genpd_remove(&bc->domains[i].genpd);
> > -
> > -	return ret;
> > -}
> > -
> > -static void imx93_blk_ctrl_remove(struct platform_device *pdev)
> > -{
> > -	struct imx93_blk_ctrl *bc = dev_get_drvdata(&pdev->dev);
> > -	int i;
> > -
> > -	of_genpd_del_provider(pdev->dev.of_node);
> > -
> > -	pm_runtime_disable(&pdev->dev);
> > -
> > -	for (i = 0; i < bc->onecell_data.num_domains; i++) {
> > -		struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
> > -
> > -		pm_genpd_remove(&domain->genpd);
> > -	}
> >  }
> >
> >  static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[] = {
> > @@ -455,7 +446,6 @@ MODULE_DEVICE_TABLE(of, imx93_blk_ctrl_of_match);
> >
> >  static struct platform_driver imx93_blk_ctrl_driver = {
> >  	.probe = imx93_blk_ctrl_probe,
> > -	.remove = imx93_blk_ctrl_remove,
> >  	.driver = {
> >  		.name = "imx93-blk-ctrl",
> >  		.of_match_table = imx93_blk_ctrl_of_match,
> >
> > --
> > 2.47.3
> >
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

